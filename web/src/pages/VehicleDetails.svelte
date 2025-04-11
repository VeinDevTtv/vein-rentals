<script lang="ts">
  import { pop } from 'svelte-spa-router';
  import { onMount } from 'svelte';
  import { selectedVehicle, rentalDurations, loyaltyDiscount } from '../stores/appStore';
  
  // Import this but don't redeclare it
  import { params } from 'svelte-spa-router';
  
  let vehicle = null;
  let durations = [];
  let selectedDuration = null;
  let totalCost = 0;
  let discount = 0;
  
  onMount(() => {
    // Request vehicle details from backend
    fetch('https://vein-rentals/viewVehicleDetails', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({ model: $params.model })
    });
  });
  
  // Calculate rental cost
  function calculateRentalCost() {
    if (!vehicle || !selectedDuration) return 0;
    
    let cost = vehicle.rentalPrice * (selectedDuration.priceMultiplier / 0.1);
    
    // Apply loyalty discount if available
    if (discount > 0) {
      cost = cost * (1 - discount);
    }
    
    return Math.floor(cost);
  }
  
  // Select duration
  function selectDuration(duration) {
    selectedDuration = duration;
    totalCost = calculateRentalCost();
  }
  
  // Rent the vehicle
  function rentVehicle() {
    if (!vehicle || !selectedDuration) return;
    
    fetch('https://vein-rentals/rentVehicle', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        model: vehicle.model,
        duration: selectedDuration.time,
        cost: totalCost
      })
    }).then(response => response.json())
      .then(data => {
        if (data.success) {
          // Rental successful, go back to main menu
          pop();
        }
      });
  }
  
  // Go back to main menu
  function goBack() {
    pop();
  }
  
  // Subscribe to selected vehicle updates
  selectedVehicle.subscribe((newVehicle) => {
    if (newVehicle) {
      vehicle = newVehicle;
      // Reset duration selection when vehicle changes
      selectedDuration = null;
      totalCost = 0;
    }
  });
  
  // Subscribe to rental durations
  rentalDurations.subscribe((newDurations) => {
    if (newDurations && newDurations.length > 0) {
      durations = newDurations;
    }
  });
  
  // Subscribe to loyalty discount
  loyaltyDiscount.subscribe((newDiscount) => {
    discount = newDiscount;
    totalCost = calculateRentalCost();
  });
</script>

<div class="vehicle-details">
  <button class="back-btn" on:click={goBack}>
    <span class="mdi mdi-arrow-left"></span>
    Back to Vehicles
  </button>
  
  {#if vehicle}
    <div class="details-content">
      <div class="vehicle-showcase">
        <div class="image-container">
          <img src={vehicle.image} alt={vehicle.name} />
        </div>
        
        <div class="vehicle-stats">
          <h2>{vehicle.name}</h2>
          <p class="description">{vehicle.description}</p>
          
          <div class="stats-container">
            <div class="stat">
              <span class="stat-label">Speed</span>
              <div class="stat-bar">
                <div class="stat-fill" style="width: {vehicle.stats.speed}%"></div>
              </div>
              <span class="stat-value">{vehicle.stats.speed}%</span>
            </div>
            
            <div class="stat">
              <span class="stat-label">Acceleration</span>
              <div class="stat-bar">
                <div class="stat-fill" style="width: {vehicle.stats.acceleration}%"></div>
              </div>
              <span class="stat-value">{vehicle.stats.acceleration}%</span>
            </div>
            
            <div class="stat">
              <span class="stat-label">Handling</span>
              <div class="stat-bar">
                <div class="stat-fill" style="width: {vehicle.stats.handling}%"></div>
              </div>
              <span class="stat-value">{vehicle.stats.handling}%</span>
            </div>
            
            <div class="stat">
              <span class="stat-label">Braking</span>
              <div class="stat-bar">
                <div class="stat-fill" style="width: {vehicle.stats.braking}%"></div>
              </div>
              <span class="stat-value">{vehicle.stats.braking}%</span>
            </div>
          </div>
        </div>
      </div>
      
      <div class="rental-options">
        <h3>Rental Duration</h3>
        
        <div class="duration-selector">
          {#each durations as duration}
            <button 
              class="duration-option" 
              class:selected={selectedDuration && selectedDuration.time === duration.time}
              on:click={() => selectDuration(duration)}
            >
              <span class="duration-label">{duration.label}</span>
              <span class="duration-price">${Math.floor(vehicle.rentalPrice * (duration.priceMultiplier / 0.1))}</span>
            </button>
          {/each}
        </div>
        
        <div class="rental-summary">
          <div class="summary-row">
            <span>Base Price:</span>
            <span>${selectedDuration ? Math.floor(vehicle.rentalPrice * (selectedDuration.priceMultiplier / 0.1)) : 0}</span>
          </div>
          
          {#if discount > 0}
            <div class="summary-row discount">
              <span>Loyalty Discount ({discount * 100}%):</span>
              <span>-${selectedDuration ? Math.floor(vehicle.rentalPrice * (selectedDuration.priceMultiplier / 0.1) * discount) : 0}</span>
            </div>
          {/if}
          
          <div class="summary-row total">
            <span>Total:</span>
            <span>${totalCost}</span>
          </div>
        </div>
        
        <button 
          class="rent-btn" 
          disabled={!selectedDuration} 
          on:click={rentVehicle}
        >
          Rent Now
        </button>
      </div>
    </div>
  {:else}
    <div class="loading">
      <span class="mdi mdi-loading mdi-spin"></span>
      <span>Loading vehicle details...</span>
    </div>
  {/if}
</div>

<style>
  .vehicle-details {
    display: flex;
    flex-direction: column;
    height: 100%;
  }
  
  .back-btn {
    background: none;
    border: none;
    display: flex;
    align-items: center;
    gap: 5px;
    cursor: pointer;
    font-weight: 500;
    color: var(--color-primary);
    padding: 0;
    margin-bottom: 20px;
    width: fit-content;
  }
  
  .details-content {
    display: flex;
    flex: 1;
    gap: 30px;
  }
  
  .vehicle-showcase {
    flex: 2;
    background-color: white;
    border-radius: 8px;
    overflow: hidden;
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
    display: flex;
    flex-direction: column;
  }
  
  .image-container {
    height: 250px;
    overflow: hidden;
    background-color: #f5f5f5;
  }
  
  .image-container img {
    width: 100%;
    height: 100%;
    object-fit: cover;
  }
  
  .vehicle-stats {
    padding: 20px;
    flex: 1;
    display: flex;
    flex-direction: column;
  }
  
  .vehicle-stats h2 {
    margin: 0 0 5px 0;
    font-weight: 500;
  }
  
  .description {
    color: #616161;
    margin-bottom: 20px;
  }
  
  .stats-container {
    flex: 1;
  }
  
  .stat {
    display: flex;
    align-items: center;
    margin-bottom: 15px;
  }
  
  .stat-label {
    flex: 1;
    font-size: 14px;
    color: #616161;
  }
  
  .stat-bar {
    flex: 2;
    height: 8px;
    background-color: #e0e0e0;
    border-radius: 4px;
    overflow: hidden;
    margin: 0 10px;
  }
  
  .stat-fill {
    height: 100%;
    background-color: var(--color-primary);
  }
  
  .stat-value {
    width: 40px;
    text-align: right;
    font-size: 14px;
    font-weight: 500;
  }
  
  .rental-options {
    flex: 1;
    background-color: white;
    border-radius: 8px;
    padding: 20px;
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
    display: flex;
    flex-direction: column;
  }
  
  .rental-options h3 {
    margin: 0 0 15px 0;
    font-weight: 500;
    color: var(--color-primary);
  }
  
  .duration-selector {
    display: grid;
    grid-template-columns: repeat(2, 1fr);
    gap: 10px;
    margin-bottom: 20px;
  }
  
  .duration-option {
    background-color: #f5f5f5;
    border: 2px solid transparent;
    border-radius: 6px;
    padding: 12px;
    cursor: pointer;
    display: flex;
    flex-direction: column;
    align-items: center;
    transition: all 0.2s;
  }
  
  .duration-option:hover {
    background-color: #e0e0e0;
  }
  
  .duration-option.selected {
    border-color: var(--color-primary);
    background-color: rgba(63, 81, 181, 0.1);
  }
  
  .duration-label {
    font-weight: 500;
    margin-bottom: 5px;
  }
  
  .duration-price {
    font-weight: 500;
    color: var(--color-primary);
  }
  
  .rental-summary {
    background-color: #f5f5f5;
    border-radius: 6px;
    padding: 15px;
    margin-bottom: 20px;
    flex: 1;
  }
  
  .summary-row {
    display: flex;
    justify-content: space-between;
    padding: 5px 0;
  }
  
  .summary-row.discount {
    color: var(--color-accent);
  }
  
  .summary-row.total {
    border-top: 1px solid #e0e0e0;
    margin-top: 5px;
    padding-top: 10px;
    font-weight: 500;
    font-size: 18px;
  }
  
  .rent-btn {
    background-color: var(--color-primary);
    color: white;
    border: none;
    border-radius: 6px;
    padding: 12px;
    font-weight: 500;
    cursor: pointer;
    transition: background-color 0.2s;
  }
  
  .rent-btn:hover {
    background-color: var(--color-secondary);
  }
  
  .rent-btn:disabled {
    background-color: #bdbdbd;
    cursor: not-allowed;
  }
  
  .loading {
    flex: 1;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    gap: 15px;
    color: #616161;
  }
  
  .loading .mdi {
    font-size: 36px;
    color: var(--color-primary);
  }
</style> 