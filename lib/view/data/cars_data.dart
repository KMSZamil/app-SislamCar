class CarsData {
  late String img;
  late String name;
  CarsData(this.img, this.name);
  static List<CarsData> carsData = [
    CarsData('assets/img/car.jpg', "Toyota Axio G Edtion 2014"),
    CarsData('assets/img/car1.jpg', "Toyota Vios 2021"),
  ];
}
