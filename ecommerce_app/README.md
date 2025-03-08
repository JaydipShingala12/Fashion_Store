# Fashion Store E-commerce App

A responsive Flutter e-commerce application for clothing, built with a clean MVC architecture. The app works seamlessly on both mobile devices and laptops.

## Features

- **Responsive Design**: Adapts to screen size (mobile, tablet, desktop)
- **Dark/Light Theme**: Toggle between dark and light modes
- **Product Filtering**: Filter by gender, category, and price range
- **Product Sorting**: Sort by price or name
- **Pagination**: Browse products with page navigation
- **Wishlist**: Save favorite items for later
- **Shopping Cart**: Add items with size and color selection
- **Checkout Process**: Complete with shipping information and payment options
- **Secure Payments**: Encrypted payment data with UPI and Cash on Delivery options
- **Clean Architecture**: Organized with MVC pattern for maintainability

## Getting Started

### Prerequisites

- Flutter SDK (>=3.0.0)
- Dart SDK (>=3.0.0)

### Installation

1. Clone the repository
   ```bash
   git clone https://github.com/yourusername/fashion-store.git
   ```
2. Navigate to the project directory:
   ```bash
   cd fashion-store
   ```
3. Install dependencies:
   ```bash
   flutter pub get
   ```
4. Run the app:
   ```bash
   flutter run
   ```

## Project Structure

```
lib/
  ├── models/
  │   ├── product.dart
  │   └── cart_item.dart
  ├── views/
  │   ├── home_screen.dart
  │   ├── cart_screen.dart
  │   ├── wishlist_screen.dart
  │   ├── checkout_screen.dart
  │   └── order_confirmation_screen.dart
  ├── controllers/
  │   ├── cart_controller.dart
  │   └── wishlist_controller.dart
  ├── utils/
  │   ├── product_data.dart
  │   ├── theme_provider.dart
  │   └── payment_security.dart
  ├── widgets/
  │   └── product_card.dart
  └── main.dart
```

## Usage

- Browse through the product catalog
- Filter products by gender (Men/Women)
- Filter products by category (T-Shirts, Jeans, etc.)
- Sort products by price or name
- Add products to wishlist
- Add products to cart with size and color selection
- Checkout with shipping information
- Choose between Cash on Delivery or UPI payment
- Toggle between dark and light themes

## Dependencies

- cached_network_image: For efficient image loading and caching
- google_fonts: For custom typography
- provider: For state management
- shared_preferences: For theme persistence
- encrypt: For payment data security

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments

- Images from Unsplash
- Flutter and Dart team for the amazing framework
- All the package authors for their contributions
