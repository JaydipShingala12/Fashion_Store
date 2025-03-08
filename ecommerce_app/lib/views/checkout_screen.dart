import 'package:flutter/material.dart';
import '../controllers/cart_controller.dart';
import '../models/cart_item.dart';
import '../utils/payment_security.dart';
import 'order_confirmation_screen.dart';

enum PaymentMethod { cashOnDelivery, upi }

class CheckoutScreen extends StatefulWidget {
  final CartController cartController;

  const CheckoutScreen({
    super.key,
    required this.cartController,
  });

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _formKey = GlobalKey<FormState>();
  PaymentMethod _selectedPaymentMethod = PaymentMethod.cashOnDelivery;
  String _upiId = '';
  String? _transactionId;
  
  // Form fields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _zipController = TextEditingController();
  final TextEditingController _upiController = TextEditingController();
  
  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _zipController.dispose();
    _upiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Order Summary
                _buildOrderSummary(),
                const SizedBox(height: 24),
                
                // Shipping Information
                _buildShippingInformation(),
                const SizedBox(height: 24),
                
                // Payment Method
                _buildPaymentMethod(),
                const SizedBox(height: 32),
                
                // Place Order Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      padding: WidgetStateProperty.all(
                        const EdgeInsets.symmetric(vertical: 16),
                      ),
                      textStyle: WidgetStateProperty.all(
                        const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    onPressed: _placeOrder,
                    child: const Text('PLACE ORDER'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  Widget _buildOrderSummary() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Order Summary',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            // Items
            ...widget.cartController.items.map((item) => Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      item.product.name,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      '${item.quantity} x',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      '\$${item.totalPrice.toStringAsFixed(2)}',
                      textAlign: TextAlign.right,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            )),
            const Divider(),
            // Subtotal
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Subtotal'),
                Text(
                  '\$${widget.cartController.totalAmount.toStringAsFixed(2)}',
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
              ],
            ),
            const SizedBox(height: 8),
            // Shipping
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Shipping'),
                Text(
                  'Free',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              ],
            ),
            const SizedBox(height: 8),
            // Tax
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Tax (10%)'),
                Text(
                  '\$${(widget.cartController.totalAmount * 0.1).toStringAsFixed(2)}',
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
              ],
            ),
            const Divider(),
            // Total
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '\$${(widget.cartController.totalAmount * 1.1).toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildShippingInformation() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Shipping Information',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            // Name
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Full Name',
                prefixIcon: Icon(Icons.person),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your name';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            // Email
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email),
              ),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                  return 'Please enter a valid email';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            // Phone
            TextFormField(
              controller: _phoneController,
              decoration: const InputDecoration(
                labelText: 'Phone Number',
                prefixIcon: Icon(Icons.phone),
              ),
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your phone number';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            // Address
            TextFormField(
              controller: _addressController,
              decoration: const InputDecoration(
                labelText: 'Address',
                prefixIcon: Icon(Icons.home),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your address';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            // City, State, Zip
            Row(
              children: [
                // City
                Expanded(
                  flex: 2,
                  child: TextFormField(
                    controller: _cityController,
                    decoration: const InputDecoration(
                      labelText: 'City',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Required';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 16),
                // State
                Expanded(
                  flex: 1,
                  child: TextFormField(
                    controller: _stateController,
                    decoration: const InputDecoration(
                      labelText: 'State',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Required';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 16),
                // Zip
                Expanded(
                  flex: 1,
                  child: TextFormField(
                    controller: _zipController,
                    decoration: const InputDecoration(
                      labelText: 'ZIP',
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Required';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildPaymentMethod() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Payment Method',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            // Cash on Delivery
            RadioListTile<PaymentMethod>(
              title: Row(
                children: [
                  Icon(
                    Icons.money,
                    color: Theme.of(context).primaryColor,
                  ),
                  const SizedBox(width: 8),
                  const Text('Cash on Delivery'),
                ],
              ),
              subtitle: const Text('Pay when you receive your order'),
              value: PaymentMethod.cashOnDelivery,
              groupValue: _selectedPaymentMethod,
              onChanged: (value) {
                setState(() {
                  _selectedPaymentMethod = value!;
                });
              },
            ),
            // UPI
            RadioListTile<PaymentMethod>(
              title: Row(
                children: [
                  Icon(
                    Icons.account_balance_wallet,
                    color: Theme.of(context).primaryColor,
                  ),
                  const SizedBox(width: 8),
                  const Text('UPI Payment'),
                ],
              ),
              subtitle: const Text('Pay using UPI ID'),
              value: PaymentMethod.upi,
              groupValue: _selectedPaymentMethod,
              onChanged: (value) {
                setState(() {
                  _selectedPaymentMethod = value!;
                });
              },
            ),
            // UPI ID input field (only visible when UPI is selected)
            if (_selectedPaymentMethod == PaymentMethod.upi)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  controller: _upiController,
                  decoration: const InputDecoration(
                    labelText: 'UPI ID',
                    hintText: 'example@upi',
                    prefixIcon: Icon(Icons.payment),
                  ),
                  validator: (value) {
                    if (_selectedPaymentMethod == PaymentMethod.upi) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your UPI ID';
                      }
                      if (!PaymentSecurity.isValidUpiId(value)) {
                        return 'Please enter a valid UPI ID';
                      }
                    }
                    return null;
                  },
                  onChanged: (value) {
                    _upiId = value;
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
  
  void _placeOrder() {
    if (_formKey.currentState!.validate()) {
      // Process the order
      // In a real app, you would send the order to a server
      
      // Generate transaction ID
      _transactionId = PaymentSecurity.generateTransactionId();
      
      // For UPI payment, encrypt payment data
      if (_selectedPaymentMethod == PaymentMethod.upi) {
        // Create payment data map
        
        // Encrypt payment data
        
        // Simulate UPI payment processing
        _showUpiPaymentDialog();
      } else {
        // For Cash on Delivery, proceed directly to confirmation
        _navigateToOrderConfirmation();
      }
    }
  }
  
  void _showUpiPaymentDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Processing UPI Payment'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 16),
            Text('Processing payment via $_upiId'),
            const SizedBox(height: 8),
            Text('Transaction ID: $_transactionId'),
            const SizedBox(height: 8),
            const Text('Secure payment processing...'),
          ],
        ),
      ),
    );
    
    // Simulate payment processing
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pop(context); // Close the processing dialog
      
      // Show success dialog
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Payment Successful'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 48,
              ),
              const SizedBox(height: 16),
              const Text('Your UPI payment was processed successfully.'),
              const SizedBox(height: 8),
              Text('Transaction ID: $_transactionId'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _navigateToOrderConfirmation();
              },
              child: const Text('CONTINUE'),
            ),
          ],
        ),
      );
    });
  }
  
  void _navigateToOrderConfirmation() {
    // Create a safe copy of the cart items
    final List<CartItem> orderItems = List<CartItem>.from(widget.cartController.items);
    final double orderTotal = widget.cartController.totalAmount * 1.1;
    
    // Clear the cart
    widget.cartController.clearCart();
    
    // Navigate to order confirmation
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => OrderConfirmationScreen(
          orderItems: orderItems,
          orderTotal: orderTotal,
          shippingAddress: '${_nameController.text}\n${_addressController.text}\n${_cityController.text}, ${_stateController.text} ${_zipController.text}\n${_phoneController.text}\n${_emailController.text}',
          paymentMethod: _selectedPaymentMethod == PaymentMethod.cashOnDelivery
              ? 'Cash on Delivery'
              : 'UPI Payment ($_upiId)\nTransaction ID: $_transactionId',
        ),
      ),
      (route) => route.isFirst,
    );
  }
} 