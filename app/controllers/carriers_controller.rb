class CarriersController < ApplicationController
  def index
    @carriers = Carrier.all
  end

  def new
    @carrier = Carrier.new
  end

  def create
    @carrier = Carrier.new(carrier_params)

    if @carrier.save
      redirect_to carriers_path, notice: 'Carrier was successfully created.'
    else
      render :new
    end
  end

  private

  def carrier_params
    params.require(:carrier).permit(:carrier_name)
  end
end
