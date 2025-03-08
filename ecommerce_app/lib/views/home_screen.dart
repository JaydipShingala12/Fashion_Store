import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/cart_controller.dart';
import '../controllers/wishlist_controller.dart';
import '../utils/product_data.dart';
import '../utils/theme_provider.dart';
import '../widgets/product_card.dart';

class HomeScreen extends StatefulWidget {
  final CartController cartController;
  final WishlistController wishlistController;

  const HomeScreen({
    super.key,
    required this.cartController,
    required this.wishlistController,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  String _selectedCategory = 'All';
  String _selectedGender = 'All';
  String _sortOption = 'Default';
  final double _minPrice = 0;
  final double _maxPrice = 200;
  RangeValues _priceRange = const RangeValues(0, 200);
  bool _showFilters = false;
  late AnimationController _animationController;
  late Animation<double> _animation;
  
  // Pagination variables
  int _currentPage = 1;
  final int _itemsPerPage = 8;
  int _totalPages = 1;
  List<dynamic> _paginatedProducts = [];
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    
    // Initialize pagination
    _updatePagination();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _toggleFilters() {
    setState(() {
      _showFilters = !_showFilters;
      if (_showFilters) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }
  
  void _updatePagination() {
    // Apply filters
    var filteredProducts = products.where((product) {
      // Gender filter
      if (_selectedGender != 'All' && product.gender != _selectedGender) {
        return false;
      }
      // Category filter
      if (_selectedCategory != 'All' && product.category != _selectedCategory) {
        return false;
      }
      // Price filter
      if (product.price < _priceRange.start || product.price > _priceRange.end) {
        return false;
      }
      return true;
    }).toList();

    // Apply sorting
    switch (_sortOption) {
      case 'Price: Low to High':
        filteredProducts.sort((a, b) => a.price.compareTo(b.price));
        break;
      case 'Price: High to Low':
        filteredProducts.sort((a, b) => b.price.compareTo(a.price));
        break;
      case 'Name: A to Z':
        filteredProducts.sort((a, b) => a.name.compareTo(b.name));
        break;
      case 'Name: Z to A':
        filteredProducts.sort((a, b) => b.name.compareTo(a.name));
        break;
      default:
        // Default sorting (no change)
        break;
    }
    
    // Calculate total pages
    _totalPages = (filteredProducts.length / _itemsPerPage).ceil();
    if (_totalPages == 0) _totalPages = 1;
    
    // Ensure current page is valid
    if (_currentPage > _totalPages) {
      _currentPage = _totalPages;
    }
    
    // Get paginated products
    final startIndex = (_currentPage - 1) * _itemsPerPage;
    final endIndex = startIndex + _itemsPerPage > filteredProducts.length 
        ? filteredProducts.length 
        : startIndex + _itemsPerPage;
    
    if (startIndex < filteredProducts.length) {
      _paginatedProducts = filteredProducts.sublist(startIndex, endIndex);
    } else {
      _paginatedProducts = [];
    }
  }
  
  void _changePage(int page) {
    if (page < 1 || page > _totalPages) return;
    
    setState(() {
      _currentPage = page;
      _updatePagination();
      // Scroll to top when page changes
      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // Update pagination when filters change
    _updatePagination();
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Fashion Store',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          // Theme Toggle Button
          IconButton(
            icon: Icon(
              themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode,
            ),
            onPressed: () {
              themeProvider.toggleTheme();
            },
            tooltip: 'Toggle Theme',
          ),
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: _toggleFilters,
            tooltip: 'Filter Products',
          ),
          // Wishlist Button
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.favorite),
                onPressed: () {
                  Navigator.pushNamed(context, '/wishlist');
                },
                tooltip: 'View Wishlist',
              ),
              if (widget.wishlistController.itemCount > 0)
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      '${widget.wishlistController.itemCount}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
          // Cart Button
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.pushNamed(context, '/cart');
                },
                tooltip: 'View Cart',
              ),
              if (widget.cartController.itemCount > 0)
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      '${widget.cartController.itemCount}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          // Animated Filter Panel
          SizeTransition(
            sizeFactor: _animation,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withAlpha(51), // ~0.2 opacity
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Filters',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Gender',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.grey[300]!),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: _selectedGender,
                                  isExpanded: true,
                                  items: const [
                                    DropdownMenuItem(value: 'All', child: Text('All')),
                                    DropdownMenuItem(value: 'Men', child: Text('Men')),
                                    DropdownMenuItem(value: 'Women', child: Text('Women')),
                                  ],
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedGender = value!;
                                      _currentPage = 1; // Reset to first page when filter changes
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Category',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.grey[300]!),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: _selectedCategory,
                                  isExpanded: true,
                                  items: const [
                                    DropdownMenuItem(value: 'All', child: Text('All')),
                                    DropdownMenuItem(value: 'T-Shirts', child: Text('T-Shirts')),
                                    DropdownMenuItem(value: 'Jeans', child: Text('Jeans')),
                                    DropdownMenuItem(value: 'Shirts', child: Text('Shirts')),
                                    DropdownMenuItem(value: 'Dresses', child: Text('Dresses')),
                                    DropdownMenuItem(value: 'Activewear', child: Text('Activewear')),
                                    DropdownMenuItem(value: 'Jackets', child: Text('Jackets')),
                                    DropdownMenuItem(value: 'Pants', child: Text('Pants')),
                                    DropdownMenuItem(value: 'Skirts', child: Text('Skirts')),
                                  ],
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedCategory = value!;
                                      _currentPage = 1; // Reset to first page when filter changes
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Price Range',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '\$${_priceRange.start.toInt()} - \$${_priceRange.end.toInt()}',
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      RangeSlider(
                        values: _priceRange,
                        min: _minPrice,
                        max: _maxPrice,
                        divisions: 20,
                        labels: RangeLabels(
                          '\$${_priceRange.start.toInt()}',
                          '\$${_priceRange.end.toInt()}',
                        ),
                        onChanged: (values) {
                          setState(() {
                            _priceRange = values;
                            _currentPage = 1; // Reset to first page when filter changes
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Sort By',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.grey[300]!),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: _sortOption,
                                  isExpanded: true,
                                  items: const [
                                    DropdownMenuItem(value: 'Default', child: Text('Default')),
                                    DropdownMenuItem(value: 'Price: Low to High', child: Text('Price: Low to High')),
                                    DropdownMenuItem(value: 'Price: High to Low', child: Text('Price: High to Low')),
                                    DropdownMenuItem(value: 'Name: A to Z', child: Text('Name: A to Z')),
                                    DropdownMenuItem(value: 'Name: Z to A', child: Text('Name: Z to A')),
                                  ],
                                  onChanged: (value) {
                                    setState(() {
                                      _sortOption = value!;
                                      _currentPage = 1; // Reset to first page when sorting changes
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      ElevatedButton.icon(
                        icon: const Icon(Icons.refresh),
                        label: const Text('Reset Filters'),
                        style: ButtonStyle(
                          padding: WidgetStateProperty.all(
                            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            _selectedCategory = 'All';
                            _selectedGender = 'All';
                            _sortOption = 'Default';
                            _priceRange = RangeValues(_minPrice, _maxPrice);
                            _currentPage = 1; // Reset to first page
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // Results Count and Active Filters
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${products.where((product) {
                    if (_selectedGender != 'All' && product.gender != _selectedGender) {
                      return false;
                    }
                    if (_selectedCategory != 'All' && product.category != _selectedCategory) {
                      return false;
                    }
                    if (product.price < _priceRange.start || product.price > _priceRange.end) {
                      return false;
                    }
                    return true;
                  }).length} Products',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                if (_selectedGender != 'All' || _selectedCategory != 'All' || _sortOption != 'Default')
                  Row(
                    children: [
                      const Text('Active Filters:'),
                      const SizedBox(width: 8),
                      if (_selectedGender != 'All')
                        _buildFilterChip(_selectedGender),
                      if (_selectedCategory != 'All')
                        _buildFilterChip(_selectedCategory),
                      if (_sortOption != 'Default')
                        _buildFilterChip(_sortOption),
                    ],
                  ),
              ],
            ),
          ),
          // Product Grid
          Expanded(
            child: _paginatedProducts.isEmpty
                ? _buildEmptyResults()
                : LayoutBuilder(
                    builder: (context, constraints) {
                      final crossAxisCount = constraints.maxWidth > 1200
                          ? 4
                          : constraints.maxWidth > 800
                              ? 3
                              : constraints.maxWidth > 600
                                  ? 2
                                  : 1;
                      return Column(
                        children: [
                          Expanded(
                            child: GridView.builder(
                              controller: _scrollController,
                              padding: const EdgeInsets.all(16.0),
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: crossAxisCount,
                                childAspectRatio: 0.7,
                                crossAxisSpacing: 16,
                                mainAxisSpacing: 16,
                              ),
                              itemCount: _paginatedProducts.length,
                              itemBuilder: (context, index) {
                                return ProductCard(
                                  product: _paginatedProducts[index],
                                  cartController: widget.cartController,
                                  wishlistController: widget.wishlistController,
                                );
                              },
                            ),
                          ),
                          // Pagination Controls
                          if (_totalPages > 1)
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.arrow_back),
                                    onPressed: _currentPage > 1
                                        ? () => _changePage(_currentPage - 1)
                                        : null,
                                  ),
                                  const SizedBox(width: 8),
                                  ..._buildPageNumbers(),
                                  const SizedBox(width: 8),
                                  IconButton(
                                    icon: const Icon(Icons.arrow_forward),
                                    onPressed: _currentPage < _totalPages
                                        ? () => _changePage(_currentPage + 1)
                                        : null,
                                  ),
                                ],
                              ),
                            ),
                        ],
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
  
  List<Widget> _buildPageNumbers() {
    List<Widget> pageNumbers = [];
    
    // Always show first page
    pageNumbers.add(_buildPageButton(1));
    
    // Show ellipsis if needed
    if (_currentPage > 3) {
      pageNumbers.add(const Text('...'));
    }
    
    // Show pages around current page
    for (int i = _currentPage - 1; i <= _currentPage + 1; i++) {
      if (i > 1 && i < _totalPages) {
        pageNumbers.add(_buildPageButton(i));
      }
    }
    
    // Show ellipsis if needed
    if (_currentPage < _totalPages - 2) {
      pageNumbers.add(const Text('...'));
    }
    
    // Always show last page
    if (_totalPages > 1) {
      pageNumbers.add(_buildPageButton(_totalPages));
    }
    
    return pageNumbers;
  }
  
  Widget _buildPageButton(int page) {
    return InkWell(
      onTap: () => _changePage(page),
      child: Container(
        width: 36,
        height: 36,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: _currentPage == page
              ? Theme.of(context).primaryColor
              : Colors.transparent,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: _currentPage == page
                ? Theme.of(context).primaryColor
                : Colors.grey[300]!,
          ),
        ),
        child: Center(
          child: Text(
            '$page',
            style: TextStyle(
              color: _currentPage == page ? Colors.white : Colors.black,
              fontWeight: _currentPage == page ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label) {
    return Padding(
      padding: const EdgeInsets.only(right: 4),
      child: Chip(
        label: Text(
          label,
          style: const TextStyle(fontSize: 12),
        ),
        backgroundColor: Theme.of(context).primaryColor.withAlpha(26),
        labelPadding: const EdgeInsets.symmetric(horizontal: 4),
        visualDensity: VisualDensity.compact,
      ),
    );
  }

  Widget _buildEmptyResults() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'No products found',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Try adjusting your filters',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[500],
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            icon: const Icon(Icons.refresh),
            label: const Text('Reset Filters'),
            onPressed: () {
              setState(() {
                _selectedCategory = 'All';
                _selectedGender = 'All';
                _sortOption = 'Default';
                _priceRange = RangeValues(_minPrice, _maxPrice);
                _currentPage = 1;
              });
            },
          ),
        ],
      ),
    );
  }
} 