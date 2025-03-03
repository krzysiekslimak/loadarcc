class BidsController < ApplicationController
  # before_action :set_current_carrier

  def index
    @carriers = Carrier.all
    @current_carrier = Carrier.find_by(id: params[:carrier_id])

    @routes = Route.all
    @loads = Load.all
    @bid = Bid.new

    # Pobieramy wszystkie bidy, pogrupowane według kombinacji load-route
    @bids_by_combination = {}

    Route.all.each do |route|
      Load.all.each do |load|
        bids = Bid.where(route:, load:).order(amount: :asc).includes(:carrier)
        @bids_by_combination[[route.id, load.id]] = bids if bids.any?
      end
    end

    # Pobieramy bidy aktualnego przewoźnika
    @current_carrier_bids = @current_carrier ? @current_carrier.bids.includes(:route, :load) : []
  end

  def new
    @bid = Bid.new
    @bid.carrier = @current_carrier
    @bid.load_id = params[:load_id] if params[:load_id]
    @bid.route_id = params[:route_id] if params[:route_id]

    @routes = Route.all
    @loads = Load.all
  end

  def create
    @bid = Bid.new(bid_params)

    if @bid.save
      redirect_to bids_path(carrier_id: @bid.carrier_id), notice: 'Bid was successfully created.'
    else
      @carriers = Carrier.all
      @current_carrier = @bid.carrier
      @routes = Route.all
      @loads = Load.all

      # Pobieramy wszystkie bidy, pogrupowane według kombinacji load-route
      @bids_by_combination = {}

      Route.all.each do |route|
        Load.all.each do |load|
          bids = Bid.where(route:, load:).order(amount: :asc).includes(:carrier)
          @bids_by_combination[[route.id, load.id]] = bids if bids.any?
        end
      end

      # Pobieramy bidy aktualnego przewoźnika
      @current_carrier_bids = @current_carrier ? @current_carrier.bids.includes(:route, :load) : []

      render :index
    end
  end

  def previous_bid
    previous_bid = Bid.where(
      carrier_id: params[:carrier_id],
      route_id: params[:route_id],
      load_id: params[:load_id]
    ).order(created_at: :desc).first

    render json: {
      previous_bid_amount: previous_bid ? previous_bid.amount.to_f : nil
    }
  end

  private

  def bid_params
    params.require(:bid).permit(:amount, :carrier_id, :load_id, :route_id)
  end
end
