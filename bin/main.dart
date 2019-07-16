import 'package:movie_refactoring/movie_refactoring.dart' as movie_refactoring;

class Movie {
  static const int CHILDRENS = 2;
  static const int REGULAR = 0;
  static const int NEW_RELEASE = 1;
  final String title;
  int _priceCode;

  Movie(this.title, this._priceCode);

  int get priceCode => _priceCode;

  set priceCode(int arg) => _priceCode = arg;
}

class Rental {
  final Movie movie;
  final int daysRented;

  Rental(this.movie, this.daysRented);
}

class Customer {
  String name;
  List<Rental> _rentals = [];

  Customer(this.name);

  void addRental(Rental arg) {
    _rentals.add(arg);
  }

  String statement() {
    double totalAmount = 0;
    int frequentRenterPoints = 0;
    String result = "Rental Record for " + name + "\n";
    for (Rental each in _rentals) {
      double thisAmount = 0;
      //determine amounts for each line
      switch (each.movie.priceCode) {
        case Movie.REGULAR:
          thisAmount += 2;
          if (each.daysRented > 2) {
            thisAmount += (each.daysRented - 2) * 1.5;
          }
          break;
        case Movie.NEW_RELEASE:
          thisAmount += each.daysRented * 3;
          break;
        case Movie.CHILDRENS:
          thisAmount += 1.5;
          if (each.daysRented > 3) {
            thisAmount += (each.daysRented - 3) * 1.5;
          }
          break;
      }
      // add frequent renter points
      frequentRenterPoints++;
      // add bonus for a two day new release rental
      if ((each.movie.priceCode == Movie.NEW_RELEASE) && each.daysRented > 1) {
        frequentRenterPoints++;
      }
      //show figures for this rental
      result += "\t${each.movie.title}\t\$${thisAmount.toStringAsFixed(2)}\n";
      totalAmount += thisAmount;
    }
    //add footer lines
    result += "Amount owed is \$${totalAmount.toStringAsFixed(2)}\n";
    result += "You earned $frequentRenterPoints frequent renter points";
    return result;
  }
}

main(List<String> arguments) {
  List<Movie> allMovies = [
    Movie("The Little Mermaid", Movie.CHILDRENS),
    Movie("The Lion King", Movie.CHILDRENS),
    Movie("Shrek", Movie.CHILDRENS),
    Movie("King Fu Panda", Movie.CHILDRENS),
    Movie("Toy Story 4", Movie.NEW_RELEASE),
    Movie("Rocketman", Movie.NEW_RELEASE),
    Movie("The Godfather", Movie.REGULAR),
  ];


  Customer cust = Customer('Steve Lee');
  allMovies.forEach((mov) => cust.addRental(Rental(mov, 4)));

  print(cust.statement());
}
