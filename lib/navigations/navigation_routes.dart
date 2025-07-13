enum NavigationRoutes {
  signin(name: '/signin'),
  register(name: '/register'),
  home(name: '/home'),
  addInventory(name: '/add-inventory'),
  detailInventory(name: '/detail-inventory');

  const NavigationRoutes({required this.name});
  final String name;
}
