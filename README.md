# LoadarCC - Loadar Code Challenge

## Technology Stack

- **Ruby on Rails 7**
- **Bootstrap 5**
- **Stimulus JS**
- **Sqlite3**
- **Hotwire**

## Features

- Carrier registration and management
- Bidding system for different routes and load types
- Real-time bid status updates
- Automatic validation of bids (must be lower than previous bids)
- Responsive design for all devices

## Setup Instructions

### Prerequisites

- Ruby 3.2.0 or higher
- Rails 7.1 or higher
- Sqlite3
- Node.js and Yarn

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/loadarcc.git
   cd loadarcc
   ```

2. Install dependencies:
   ```bash
   bundle install
   yarn install
   ```

3. Setup the database:
   ```bash
   rails db:create
   rails db:migrate
   ```

4. Seed the database with sample data:
   ```bash
   rails db:seed
   ```
   This will create:
   - Sample routes (Berlin → Warsaw, Belfast → Cardiff, etc.)
   - Sample load types (5 pallets, 10 pallets, 26 pallets)

5. Start the server:
   ```bash
   rails server
   ```

6. Visit `http://localhost:3000` in your browser

## Usage

1. Select or create a carrier from the "Fake Carrier Login" section
2. Submit bids for different route and load combinations
3. View your current bids and their status
4. Submit better bids to win contracts

## Development

To run the test suite:
```bash
bundle exec rspec
```

## Contact

For any questions or feedback, please contact:
- Email: krzysztof.slimak@outlook.com
