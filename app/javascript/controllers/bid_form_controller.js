import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    console.log("Bid form controller connected")
  }
  
  updateMinBid() {
    const routeId = document.getElementById("bid_route_id").value
    const loadId = document.getElementById("bid_load_id").value
    const carrierId = document.getElementById("bid_carrier_id").value
    
    if (routeId && loadId && carrierId) {
      fetch(`/bids/previous_bid?route_id=${routeId}&load_id=${loadId}&carrier_id=${carrierId}`)
        .then(response => response.json())
        .then(data => {
          const minBidInfo = document.getElementById("min-bid-info")
          const previousBidAmount = document.getElementById("previous-bid-amount")
          
          if (data.previous_bid_amount) {
            previousBidAmount.textContent = data.previous_bid_amount
            minBidInfo.style.display = "inline-block"
          } else {
            minBidInfo.style.display = "none"
          }
        })
    }
  }
} 