<script lang="ts">
  import { push } from 'svelte-spa-router';
  import { categories, vehicles, activeRentals } from '../stores/appStore';
  
  let selectedCategory = null;
  
  // Fetch vehicles when category is selected
  function selectCategory(category) {
    selectedCategory = category;
    
    // Request vehicles from backend
    fetch('https://vein-rentals/selectCategory', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({ category: category.name })
    });
  }
  
  // View vehicle details
  function viewVehicleDetails(model) {
    push(`/vehicle/${model}`);
  }
  
  // View active rentals
  function viewActiveRentals() {
    push('/active-rentals');
  }
  
  // Subscribe to vehicle updates
  vehicles.subscribe((newVehicles) => {
    if (newVehicles && newVehicles.length > 0) {
      // Auto-select the first vehicle if we just loaded vehicles
      if (!selectedCategory) {
        selectCategory($categories[0]);
      }
    }
  });
  
  // Subscribe to category updates
  categories.subscribe((newCategories) => {
    if (newCategories && newCategories.length > 0) {
      // Auto-select the first category
      selectCategory(newCategories[0]);
    }
  });
</script>

<div class="main-menu">
  <div class="tabs">
    <div class="category-tabs">
      {#each $categories as category}
        <button 
          class="tab" 
          class:active={selectedCategory && selectedCategory.name === category.name}
          on:click={() => selectCategory(category)}
        >
          <span class="mdi mdi-{category.icon}"></span>
          {category.label}
        </button>
      {/each}
    </div>
    
    <button class="tab rentals-tab" on:click={viewActiveRentals}>
      <span class="mdi mdi-car-clock"></span>
      My Rentals
      {#if $activeRentals && $activeRentals.length > 0}
        <span class="badge">{$activeRentals.length}</span>
      {/if}
    </button>
  </div>
  
  <div class="category-description">
    {#if selectedCategory}
      <h3>{selectedCategory.label}</h3>
      <p>{selectedCategory.description}</p>
    {/if}
  </div>
  
  <div class="vehicles-grid">
    {#each $vehicles as vehicle}
      <button 
        class="vehicle-card" 
        on:click={() => viewVehicleDetails(vehicle.model)}
        on:keydown={(e) => e.key === 'Enter' && viewVehicleDetails(vehicle.model)}
      >
        <div class="image-container">
          <img src={vehicle.image} alt={vehicle.name} />
        </div>
        <div class="vehicle-info">
          <h3>{vehicle.name}</h3>
          <p class="price">${vehicle.rentalPrice}/hour</p>
          
          <div class="stats">
            <div class="stat">
              <span class="stat-label">Speed</span>
              <div class="stat-bar">
                <div class="stat-fill" style="width: {vehicle.stats.speed}%"></div>
              </div>
            </div>
            
            <div class="stat">
              <span class="stat-label">Handling</span>
              <div class="stat-bar">
                <div class="stat-fill" style="width: {vehicle.stats.handling}%"></div>
              </div>
            </div>
          </div>
          
          <span class="view-btn">View Details</span>
        </div>
      </button>
    {/each}
  </div>
</div>

<style>
  .main-menu {
    display: flex;
    flex-direction: column;
    height: 100%;
  }
  
  .tabs {
    display: flex;
    justify-content: space-between;
    border-bottom: 1px solid #e0e0e0;
    padding-bottom: 10px;
    margin-bottom: 20px;
  }
  
  .category-tabs {
    display: flex;
    gap: 10px;
  }
  
  .tab {
    background: none;
    border: none;
    padding: 10px 15px;
    border-radius: 4px;
    cursor: pointer;
    font-weight: 500;
    display: flex;
    align-items: center;
    gap: 5px;
    transition: background-color 0.2s;
    color: var(--color-text);
  }
  
  .tab:hover {
    background-color: rgba(0, 0, 0, 0.05);
  }
  
  .tab.active {
    background-color: var(--color-primary);
    color: white;
  }
  
  .rentals-tab {
    background-color: var(--color-accent);
    color: white;
    position: relative;
  }
  
  .badge {
    position: absolute;
    top: -5px;
    right: -5px;
    background-color: var(--color-secondary);
    color: white;
    width: 20px;
    height: 20px;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 12px;
  }
  
  .category-description {
    margin-bottom: 20px;
  }
  
  .category-description h3 {
    margin: 0 0 5px 0;
    font-weight: 500;
    color: var(--color-primary);
  }
  
  .category-description p {
    margin: 0;
    color: #616161;
  }
  
  .vehicles-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
    gap: 20px;
    overflow-y: auto;
    padding-right: 10px;
  }
  
  .vehicle-card {
    background-color: white;
    border-radius: 8px;
    overflow: hidden;
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
    transition: transform 0.2s, box-shadow 0.2s;
    cursor: pointer;
    /* Reset button styling */
    border: none;
    font: inherit;
    color: inherit;
    padding: 0;
    margin: 0;
    display: block;
    width: 100%;
    text-align: left;
  }
  
  .vehicle-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.15);
  }
  
  .image-container {
    height: 160px;
    overflow: hidden;
    background-color: #f5f5f5;
  }
  
  .image-container img {
    width: 100%;
    height: 100%;
    object-fit: cover;
    transition: transform 0.3s;
  }
  
  .vehicle-card:hover .image-container img {
    transform: scale(1.05);
  }
  
  .vehicle-info {
    padding: 15px;
  }
  
  .vehicle-info h3 {
    margin: 0 0 5px 0;
    font-weight: 500;
  }
  
  .price {
    color: var(--color-primary);
    font-weight: 500;
    margin: 0 0 15px 0;
  }
  
  .stats {
    margin-bottom: 15px;
  }
  
  .stat {
    margin-bottom: 8px;
  }
  
  .stat-label {
    display: block;
    font-size: 12px;
    margin-bottom: 2px;
    color: #616161;
  }
  
  .stat-bar {
    height: 6px;
    background-color: #e0e0e0;
    border-radius: 3px;
    overflow: hidden;
  }
  
  .stat-fill {
    height: 100%;
    background-color: var(--color-primary);
  }
  
  .view-btn {
    width: 100%;
    padding: 8px 0;
    background-color: var(--color-primary);
    color: white;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    font-weight: 500;
    transition: background-color 0.2s;
  }
  
  .view-btn:hover {
    background-color: var(--color-secondary);
  }
</style> 