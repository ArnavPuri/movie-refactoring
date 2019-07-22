abstract class Category {
  static const Category CHILDRENS = _ChildrensCategory();
  static const Category REGULAR = _RegularCategory();
  static const Category NEW_RELEASE = _NewReleaseCategory();
  static const Category OLD_CLASSICS = _OldClassicsCategory();

  double calculateAmount(int daysRented);

  int calculateFrequentRenter(int daysRented) {
    return 1;
  }

  const Category();
}

class _OldClassicsCategory extends Category {
  const _OldClassicsCategory();

  @override
  double calculateAmount(int daysRented) {
    return daysRented * 0.5;
  }
}

class _ChildrensCategory extends Category {
  const _ChildrensCategory();

  @override
  double calculateAmount(int daysRented) {
    double thisAmount = 1.5;
    if (daysRented > 3) {
      thisAmount += (daysRented - 3) * 1.5;
    }
    return thisAmount;
  }
}

class _RegularCategory extends Category {
  const _RegularCategory();

  @override
  double calculateAmount(int daysRented) {
    double thisAmount = 2;
    if (daysRented > 2) {
      thisAmount += (daysRented - 2) * 1.5;
    }
    return thisAmount;
  }
}

class _NewReleaseCategory extends Category {
  const _NewReleaseCategory();

  @override
  double calculateAmount(int daysRented) {
    return daysRented * 3.0;
  }

  @override
  int calculateFrequentRenter(int daysRented) {
    int frequentRenter = 1;
    if (daysRented > 1) frequentRenter++;
    return frequentRenter;
  }
}
