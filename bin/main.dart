import 'category.dart';

class Movie {
  final String title;

  Category category;

  Movie(this.title, this.category);
}

class Rental {
  final Movie movie;
  final int daysRented;
  final Category category;

  Rental(this.movie, this.daysRented) :
        category = movie.category;


  String formatRentalStatement() {
    return "\t${movie.title}\t\$${amount.toStringAsFixed(2)}\n";
  }

  String formatRentalHtmlStatement() {
    return "${movie.title}: &dollar; ${amount.toStringAsFixed(2)} <br> \n";
  }

  double get amount => category.calculateAmount(daysRented);

  int get frequentRenterPoints => category.calculateFrequentRenter(daysRented);
}

class Customer {
  String name;
  List<Rental> _rentals = [];

  Customer(this.name);

  void addRental(Rental arg) {
    _rentals.add(arg);
  }

  String statement() {
    String result = "Rental Record for " + name + "\n";
    result += _rentals.map((rental) => rental.formatRentalStatement()).join();

    //add footer lines
    result += "Amount owed is \$${rentalAmount.toStringAsFixed(2)}\n";
    result += "You earned $frequentRenterPoints frequent renter points";
    return result;
  }

  String htmlStatement() {
    String result = "<h1>Rental Record for <em> $name </em></h1> \n <p>";
    result +=
        _rentals.map((rental) => rental.formatRentalHtmlStatement()).join();

    //add footer lines
    result +=
    "</p> <p> Amount owed is <EM>&dollar; ${rentalAmount.toStringAsFixed(2)}"
        "</em>\n </p>";
    result +=
    "<p>You earned <em>$frequentRenterPoints</em> frequent renter points</p>";
    return result;
  }

  double get rentalAmount =>
      _rentals.fold(0, (prev, rental) => prev + rental.amount);

  int get frequentRenterPoints =>
      _rentals.fold(0, (prev, rental) => prev + rental.frequentRenterPoints);
}

main(List<String> arguments) {
  List<Movie> allMovies = [
    Movie("The Little Mermaid", Category.CHILDRENS),
    Movie("The Lion King", Category.CHILDRENS),
    Movie("Shrek", Category.CHILDRENS),
    Movie("King Fu Panda", Category.CHILDRENS),
    Movie("Toy Story 4", Category.NEW_RELEASE),
    Movie("Rocketman", Category.NEW_RELEASE),
    Movie("The Godfather", Category.OLD_CLASSICS),
  ];

  Customer cust = Customer('Steve Lee');
  allMovies.forEach((mov) => cust.addRental(Rental(mov, 4)));
  print(cust.statement());
}
