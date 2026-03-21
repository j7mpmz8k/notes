void main() {
    int num1 = 4;
    int num2 = 0;
    try {
    System.out.println(num1 / num2);
    } catch (ArithmeticException ex) {
        System.out.printf("Exception caught: %s\n", ex.getMessage());
    }
}
int quotient(int numerator, int divisor) throws ArithmeticException {
    if (divisor != 0) {
        return numerator / divisor;
    } else {
        throw new ArithmeticException("Divisor cannot be zero");//throws `new` object instance (ie. ArithmeticException)
    }
}
