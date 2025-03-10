import '../models/product.dart';

final List<Product> products = [
  // Men's Products
  Product(
    id: 'm1',
    name: 'Classic White T-Shirt',
    description: 'Essential cotton crew neck t-shirt perfect for everyday wear',
    price: 24.99,
    imageUrl: 'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab',
    category: 'T-Shirts',
    gender: 'Men',
    sizes: ['S', 'M', 'L', 'XL'],
    colors: ['White', 'Black', 'Gray'],
  ),
  Product(
    id: 'm2',
    name: 'Slim Fit Jeans',
    description: 'Modern slim fit denim jeans with slight stretch for comfort',
    price: 59.99,
    imageUrl: 'https://images.unsplash.com/photo-1542272604-787c3835535d',
    category: 'Jeans',
    gender: 'Men',
    sizes: ['30x32', '32x32', '34x32', '36x32'],
    colors: ['Blue', 'Black', 'Gray'],
  ),
  Product(
    id: 'm3',
    name: 'Oxford Button-Down Shirt',
    description: 'Classic oxford cotton shirt perfect for business casual',
    price: 45.99,
    imageUrl: 'https://images.unsplash.com/photo-1596755094514-f87e34085b2c',
    category: 'Shirts',
    gender: 'Men',
    sizes: ['S', 'M', 'L', 'XL'],
    colors: ['White', 'Blue', 'Pink'],
  ),
  Product(
    id: 'm4',
    name: 'Casual Chino Pants',
    description: 'Comfortable cotton chino pants for a smart casual look',
    price: 49.99,
    imageUrl: 'https://images.unsplash.com/photo-1473966968600-fa801b869a1a',
    category: 'Pants',
    gender: 'Men',
    sizes: ['30x32', '32x32', '34x32', '36x32'],
    colors: ['Khaki', 'Navy', 'Olive'],
  ),
  Product(
    id: 'm5',
    name: 'Polo Shirt',
    description: 'Classic polo shirt in breathable pique cotton',
    price: 34.99,
    imageUrl: 'https://images.unsplash.com/photo-1583743814966-8936f5b7be1a',
    category: 'T-Shirts',
    gender: 'Men',
    sizes: ['S', 'M', 'L', 'XL'],
    colors: ['Navy', 'White', 'Red'],
  ),
  Product(
    id: 'm6',
    name: 'Denim Jacket',
    description: 'Classic denim jacket with comfortable fit',
    price: 79.99,
    imageUrl: 'https://images.unsplash.com/photo-1495105787522-5334e3ffa0ef',
    category: 'Jackets',
    gender: 'Men',
    sizes: ['S', 'M', 'L', 'XL'],
    colors: ['Blue', 'Black'],
  ),
  Product(
    id: 'm7',
    name: 'Athletic Shorts',
    description: 'Lightweight shorts perfect for workouts',
    price: 29.99,
    imageUrl: 'https://images.unsplash.com/photo-1562886877-aaaa5c0b3986',
    category: 'Activewear',
    gender: 'Men',
    sizes: ['S', 'M', 'L', 'XL'],
    colors: ['Black', 'Gray', 'Navy'],
  ),
  Product(
    id: 'm8',
    name: 'Hooded Sweatshirt',
    description: 'Comfortable cotton blend hoodie for casual wear',
    price: 44.99,
    imageUrl: 'https://images.unsplash.com/photo-1556821840-3a63f95609a7',
    category: 'Activewear',
    gender: 'Men',
    sizes: ['S', 'M', 'L', 'XL'],
    colors: ['Gray', 'Black', 'Navy'],
  ),
  Product(
    id: 'm9',
    name: 'Dress Shirt',
    description: 'Formal dress shirt for business wear',
    price: 54.99,
    imageUrl: 'https://images.unsplash.com/photo-1563630423918-b58f07336ac5',
    category: 'Shirts',
    gender: 'Men',
    sizes: ['S', 'M', 'L', 'XL'],
    colors: ['White', 'Light Blue', 'Pink'],
  ),
  Product(
    id: 'm10',
    name: 'Cargo Pants',
    description: 'Utility cargo pants with multiple pockets',
    price: 64.99,
    imageUrl: 'https://images.unsplash.com/photo-1517438476312-10d79c077509',
    category: 'Pants',
    gender: 'Men',
    sizes: ['30x32', '32x32', '34x32', '36x32'],
    colors: ['Olive', 'Khaki', 'Black'],
  ),

  // Women's Products
  Product(
    id: 'w1',
    name: 'Floral Summer Dress',
    description: 'Light and breezy floral print dress perfect for summer',
    price: 49.99,
    imageUrl: 'https://images.unsplash.com/photo-1515372039744-b8f02a3ae446',
    category: 'Dresses',
    gender: 'Women',
    sizes: ['XS', 'S', 'M', 'L'],
    colors: ['Blue', 'Pink', 'Yellow'],
  ),
  Product(
    id: 'w2',
    name: 'High-Waisted Yoga Pants',
    description: 'Comfortable and stretchy yoga pants with high waist',
    price: 34.99,
    imageUrl: 'https://images.unsplash.com/photo-1506629082955-511b1aa562c8',
    category: 'Activewear',
    gender: 'Women',
    sizes: ['XS', 'S', 'M', 'L'],
    colors: ['Black', 'Gray', 'Navy'],
  ),
  Product(
    id: 'w3',
    name: 'Blouse',
    description: 'Elegant blouse with feminine details',
    price: 39.99,
    imageUrl: 'https://images.unsplash.com/photo-1604695573706-53170668f6a6',
    category: 'Shirts',
    gender: 'Women',
    sizes: ['XS', 'S', 'M', 'L'],
    colors: ['White', 'Pink', 'Blue'],
  ),
  Product(
    id: 'w4',
    name: 'Skinny Jeans',
    description: 'Classic skinny jeans with stretch',
    price: 54.99,
    imageUrl: 'https://images.unsplash.com/photo-1541099649105-f69ad21f3246',
    category: 'Jeans',
    gender: 'Women',
    sizes: ['2', '4', '6', '8', '10'],
    colors: ['Blue', 'Black', 'Gray'],
  ),
  Product(
    id: 'w5',
    name: 'Maxi Dress',
    description: 'Flowing maxi dress for elegant occasions',
    price: 69.99,
    imageUrl: 'https://images.unsplash.com/photo-1496747611176-843222e1e57c',
    category: 'Dresses',
    gender: 'Women',
    sizes: ['XS', 'S', 'M', 'L'],
    colors: ['Black', 'Red', 'Navy'],
  ),
  Product(
    id: 'w6',
    name: 'Crop Top',
    description: 'Trendy crop top for casual wear',
    price: 24.99,
    imageUrl: 'https://images.unsplash.com/photo-1503342394128-c104d54dba01',
    category: 'T-Shirts',
    gender: 'Women',
    sizes: ['XS', 'S', 'M', 'L'],
    colors: ['White', 'Black', 'Pink'],
  ),
  Product(
    id: 'w7',
    name: 'Sports Bra',
    description: 'High-impact sports bra for workouts',
    price: 29.99,
    imageUrl: 'https://images.unsplash.com/photo-1571945153237-4929e783af4a',
    category: 'Activewear',
    gender: 'Women',
    sizes: ['XS', 'S', 'M', 'L'],
    colors: ['Black', 'Pink', 'Blue'],
  ),
  Product(
    id: 'w8',
    name: 'Cardigan',
    description: 'Soft knit cardigan for layering',
    price: 44.99,
    imageUrl: 'https://images.unsplash.com/photo-1434389677669-e08b4cac3105',
    category: 'Jackets',
    gender: 'Women',
    sizes: ['XS', 'S', 'M', 'L'],
    colors: ['Gray', 'Beige', 'Black'],
  ),
  Product(
    id: 'w9',
    name: 'Pencil Skirt',
    description: 'Classic pencil skirt for office wear',
    price: 49.99,
    imageUrl: 'https://images.unsplash.com/photo-1582142306909-195724d33ffc',
    category: 'Skirts',
    gender: 'Women',
    sizes: ['2', '4', '6', '8', '10'],
    colors: ['Black', 'Navy', 'Gray'],
  ),
  Product(
    id: 'w10',
    name: 'Tank Top',
    description: 'Basic tank top for everyday wear',
    price: 19.99,
    imageUrl: 'https://images.unsplash.com/photo-1503342217505-b0a15ec3261c',
    category: 'T-Shirts',
    gender: 'Women',
    sizes: ['XS', 'S', 'M', 'L'],
    colors: ['White', 'Black', 'Gray'],
  ),
]; 