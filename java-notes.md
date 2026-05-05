### Java 25:
* added implicily declared Classes -> removed need to delcare visibility (ie. public/private/protected) and/or constructor status (ie. static)
    * if `static` is ommited -> defalts to constructor
    * if `public`/`private`/`protected` is ommited, defaults to package private (private but still public to same package)
        * `protected` allows sublasses in other packages to also have access
        * in overridden attributes/methods may not decrease visiblity
    * works for any method...also removes need to declare class only for single file entry points.
```java
void main() {// NOTE! omitting static actually creates an instance of main
    System.out.println("Hello, World!");
}
```
where the old method would require setting up a class and declaring both the class and the method as public. If public is not declared it is package private however Java25 makes an exception allowing the JVM to run the main method
### Java 21:
```java
public class Main {
    public static void main(String[] args) {
        System.out.println("Hello, World!");
    }
}
```
</details>

***
### signature
<details><summary></summary>

* `static` means the method it tied directly to the class without an instance/object
* `String[] args` is for entering arguments when running the program even if no arguments are used.
* `void` means nothing is returned, else the type of the return value must instead be declared ie. `int`, `boolean`, ect.
</details>

***
### printing to console
<details><summary></summary>

* evaluated left to right, `+` initially means addition, but when adding to a string, `3` is converted to `"3"` to concat to `"abc"` to create `"3abc"`
    * `System.out.print(System.out.println(1 + 2 + "abc" + 1 + 2););` -> output: "3abc12"
    * if intending to concat `1` & `2` instead of adding, use `"" + 1 + 2` instead 
</details>

***
### format fields
<details><summary></summary>

* builds template instead of concatenation
* use `String.format()` for formatting a variable into a `String`
    ```java
    int num = 123;
    String str = String.format("%d", num);
    System.out.println(str);  // Output: "123"
    ```
* use `printf()` for formatting a string to output to terminal
* ie. `%6.2f`
  * ***trigger*** -> `%` indicates special command proceeds
  * ***width*** -> `6` indicates 6 total characters in template, will right align with spaces on the left if needed. default=unlimited (will not truncate)
  * ***separator*** special modifier (may also be combined)
    * dot `.` indicates a decimal number followed by precision
      * can also be used with `String`, the precision number would then truncate the string(can't truncate non-floating point numbers like `int` using this method)
    * comma `,` automatically adds commas ie. "1,000,000"
    * minus sign `-` left aligns everything instead of right
    * plus sign `+` forces a "+" before each number even for negatives
    * left parentheses `(` forces a "-" before each number even for positive numbers
    * zero (`0`) converts padding of zeros to spaces
  * ***precision*** -> `2` forces length of 2 characters after decimal, will round if needed or add zeros. default=0 (needs the dot separator)
  * ***conversion type*** -> `f` stands for 'floating point' which is used for `double` or `float` types
    * `d` for `int`/`long`/`short`
    * `s` for `String`
    * `b` for `boolean`
  * ```java
    //ie. %.6s and %6.2f
    void main() {
        String var1 = "Number PI is:";
        double num1 = 3.14159;
        System.out.println("Number PI is:" + num1);//output: "Number PI is:3.14159"
        System.out.printf("%.6s %6.2f", var1, num1);//output: "PI is:   3.14"   
    }
    ```
| Purpose                              | Format String          | Input                    | Output                     |
|--------------------------------------|------------------------|--------------------------|----------------------------|
| Basic string replacement             | `%s`                   | `"World"`                | World                      |
| Uppercase string                     | `%S`                   | `"alice"`                | ALICE                      |
| Decimal integer                      | `%d`                   | `25`                     | 25                         |
| Integer with thousands separator     | `%,d`                  | `1234567`                | 1,234,567                  |
| Zero-padded integer (width 5)        | `%05d`                 | `42`                     | 00042                      |
| Right-aligned integer (width 6)      | `%6d`                  | `950`                    |    950                     |
| Floating-point number (default)      | `%f`                   | `Math.PI`                | 3.141593                   |
| Float rounded to 2 decimal places    | `%.2f`                 | `19.995`                 | 20.00                      |
| Float with grouping and 2 decimals   | `%,.2f`                | `1234567.89`             | 1,234,567.89               |
| Float with explicit sign             | `%+f`                  | `-3.2`                   | -3.200000                  |
| Scientific notation                  | `%e`                   | `0.00004567`             | 4.567000e-05               |
| Single character                     | `%c`                   | `'J'`                    | J                          |
| Boolean value                        | `%b`                   | `true`                   | true                       |
| Hexadecimal (lowercase)              | `%x`                   | `255`                    | ff                         |
| Hexadecimal (uppercase)              | `%X`                   | `65535`                  | FFFF                       |
| Octal number                         | `%o`                   | `7`                      | 7                          |
| Left-aligned string (width 12)       | `%-12s`                | `"Java"`                 | Java............<-12spaces |
| Literal percent sign                 | `%%`                   | (no arguments)           | %                          |
| Platform-independent newline         | `%n`                   | (no arguments)           | (platform newline)         |
| Multiple mixed types                 | `%s %d %.1f%%`         | `"Team"`, `88`, `73.333` | Team 88 73.3%              |
</details>

***
### data types
<details><summary></summary>

| Type       | Bit Size | Signed? | Range                       | Notes                                         |
|------------|----------|---------|-----------------------------|-----------------------------------------------|
| **byte**   | 8-bit    | **Yes** | -128 to 127                 | ie. `byte va1 = 127`                          |
| **short**  | 16-bit   | **Yes** | -32,768 to 32,767           | no suffix                                     |
| **char**   | 16-bit   | **No**  | 0 to 65,535                 | unicode enclosed in single quotes (`'A'`)     |
| **int**    | 32-bit   | **Yes** | -2.1 billion to 2.1 billion | default for whole numbers                     |
| **float**  | 32-bit   | **Yes** | ±1.4e-45 to ±3.4e+38        | needs `F` suffix durring assignment           |
| **long**   | 64-bit   | **Yes** | -9.22e+18 to 9.22e+18       | needs `L` suffix durring assignment           | 
| **double** | 64-bit   | **Yes** | ±4.9e-324 to ±1.8e+308      | default for decimals                          |

* **signed** vs **unsigned** refers to if it can be negative

* unicode ascii characters
```java
// Char -> number
int code = 'A';  // 65

// Number -> char
char ch = 65;    // 'A'

int i = 65;
char c = (char) i; //<- needs type casting since `i` "could" be outside of char range ie. 0-65535
```
important unicode characters

| Decimal | Char  | Decimal | Char | Decimal | Char | Decimal | Char |
|---------|-------|---------|------|---------|------|---------|------|
|  32     | space |  56     | 8    | 80      | P    | 104     | h    |
|  33     |   !   |  57     | 9    | 81      | Q    | 105     | i    |
|  34     |   "   |  58     | :    | 82      | R    | 106     | j    |
|  35     |   #   |  59     | ;    | 83      | S    | 107     | k    |
|  36     |   $   |  60     | <    | 84      | T    | 108     | l    |
|  37     |   %   |  61     | =    | 85      | U    | 109     | m    |
|  38     |   &   |  62     | >    | 86      | V    | 110     | n    |
|  39     |   '   |  63     | ?    | 87      | W    | 111     | o    |
|  40     |   (   |  64     | @    | 88      | X    | 112     | p    |
|  41     |   )   |  65     | A    | 89      | Y    | 113     | q    |
|  42     |   *   |  66     | B    | 90      | Z    | 114     | r    |
|  43     |   +   |  67     | C    | 91      | [    | 115     | s    |
|  44     |   ,   |  68     | D    | 92      | \    | 116     | t    |
|  45     |   -   |  69     | E    | 93      | ]    | 117     | u    |
|  46     |   .   |  70     | F    | 94      | ^    | 118     | v    |
|  47     |   /   |  71     | G    | 95      | _    | 119     | w    |
|  48     |   0   |  72     | H    | 96      | `    | 120     | x    |
|  49     |   1   |  73     | I    | 97      | a    | 121     | y    |
|  50     |   2   |  74     | J    | 98      | b    | 122     | z    |
|  51     |   3   |  75     | K    | 99      | c    | 123     | {    |
|  52     |   4   |  76     | L    | 100     | d    | 124     | |    |
|  53     |   5   |  77     | M    | 101     | e    | 125     | }    |
|  54     |   6   |  78     | N    | 102     | f    | 126     | ~    |
|  55     |   7   |  79     | O    | 103     | g    |         |      |

* **primitive Object wrappers**
    * can assign variable to a wrapper without using a constructor due to auto boxing/unboxing (constructor is depricated)
        * boxing -> `Integer var1 = 3`
        * unboxing -> `int var2 = var1`
    * to compare two of the same object, use `obj1.compareTo(obj2)`
        * returns `-1` if **obj1** is less than **obj2**
        * returns `0` if equal
        * returns `1` if **obj2** is less than **obj1**

</details>

***
### type casting
<details><summary></summary>

* **automatic** when widening from smaller type to larger 
  * integer path(signed number, ie. positive or negative)
    * `byte` -> `short` -> `int` -> `long` -> `float` -> `double`
  * character path(unsigned number, ie. zero or positive)
   * `char` -> `int` -> `long` -> `float` -> `double`
  * note compound operators like `+=` include auto type casting
    ```java
    int x = 5;
    x += 4.5;//output: 9 since `4.5` is converted into an int
    ```

* **manual** casting when narrowing from larger to smaller compatible data type(risk of data loss/truncation)
  * `double` -> `float` -> `long` -> `int` -> `char` -> `short` -> `byte` -> `char`
    * uses `()` (ie.`(float)`) before the value being assigned to a variable
    * ie. `char ch = (char)65` -> `A`
    * ```java
      // ie. double -> float
      double var1 = 9.78;
      float var2 = (float) var1;//var1 was a double being assigned to var2 which is a float
      ```

* when doing arithmitic, both operands must be the same type, if `int`->`double` casting is automatic, if `double`->`int` needs manual casting
| Code Example                                | Compiles? | Result Value | Explanation / Why Valid or Invalid                           |
|---------------------------------------------|-----------|--------------|--------------------------------------------------------------|
| `int var1 = 5 / 2;`                         | Yes       | 2            |                                                              |
| `int var1 = (int) 5.6 / 2;`                 | Yes       | 2            | Cast -> int division                                         |
| `int var1 = (int) (5.6 / 2);`               | Yes       | 2            | floating point division -> cast                              |
| `double var2 = 5 / 2;`           unexpected | Yes       | 2.0          | int division -> auto-cast                                    |
| `double var2 = 5 / 2.0;`                    | Yes       | 2.5          | auto-cast -> floating point division                         |
| `double var2 = (double) (5 / 2);`unexpected | Yes       | 2.0          | cast only applied to after () evaluation                     |
| `double var2 = (double) 5 / 2;`       fixed | Yes       | 2.5          | cast -> floating point division                              |
| `int var1 = (int) 5.6;`                     | Yes       | 5            |                                                              |
| `int var1 = 5.6 / 2;`                       | No        | —            |                                                              |
| `int var1 = 5.6;`             needs casting | No        | —            |                                                              |
 
#### `String` -> `int`/`double`/`float`
* since `String` and `int` are not compatible for type casting, must use a function
    * use `Double.parseDouble()` for `String` -> `double` (ie. `3.14`)
    * use `Float.parseFloat()` for `String` -> `float` (ie. `3.14`)
    * use `Integer.parseInt()` and put the `String` inside the `()`
        ```java
        String var1 = "12345";
        int var2 = Integer.parseInt(var1);
        ```
    * **Alternativly** use `.valueOf(str)` ie. `Integer.valueOf("67")`
        * returns a wrapper object unlike .parseInt() which returns a primitive
* `int`/`double`/`float` -> `String` (**use a String formatter**)
    * **Alternativly** use `String.valueOf(int var1)` asuming `var1` is an **int**
</details>

***
### variables
<details><summary></summary>

* Must declare type enforcement of variables **ONLY** when *intializing* variable and/or methods
    * **exception** -> may *declare* variable in a seperate statement from *assignme
    ```java
    int var1; //declared (ie. type enforcement)
    var1 = 25; //assignment (ie. allocated memory)
    ```
* may include `final` for constants to enforce immutability
* **scope** -> if declared in a loop, it is local only to that loop
    ```java
    void main() {
        final double RADIUS = 20;
        double diameter = RADIUS * 2;
        System.out.println("diameter is " + diameter);
    }
    ```
* may include`static` to make variable available to every instance of class **ONLY** if outside of a method regardless if method is static or not
    * **NOTE!!** `static` methods can only access `static` variables or variables local to method
* may include `public` to make variable global to any class within project **ONLY** if outside of a method
    ```java
    public class Example {
        public static final double RADIUS = 20;
        final String CONSTANT = "can't be access by static methods";

        void main() {// can access CONSTANT and RADIUS
            System.out.println("diameter is " + get_diameter());
        }
        static double get_diameter() {// can NOT access CONSTANT
            return RADIUS * 2;
        }
    }
    ```
    ```java
    public class Example {
        public final double RADIUS = 20;
        final String CONSTANT = "can't be access by static methods";

        void main() {// can access CONSTANT and RADIUS
            System.out.println("diameter is " + get_diameter());
        }
        double get_diameter() {// can NOT access CONSTANT
            return RADIUS * 2;
        }
    }
    ```
</details>

***
### User input to console
<details><summary></summary>

*Scanners* allow the program to read the console (ie. obtain user input)
* the `Scanner` class must first be set as the data type
* `input` is name of variable
* `new` creates an object for the `Scanner` class
* keyboard input gets passed into `System.in` which the `Scanner` searches for
* the `nextDouble()` method for the `Scanner` class returns the `Double` found in the list
* use `nextLine()` method for String input
```java
import java.util.Scanner;
void main() {
    Scanner input = new Scanner(System.in);
    System.out.print("Enter two numbers: ");
    
    double num1 = input.nextDouble();
    double num2 = input.nextDouble();//finds next input separated by space and/or new line
}
```
* use `next()` for scanning for next `String`
* use `nextLine()` for scanning `String` by entire line entered
* may input any **String** instead of `System.in` to scan a string variable instead of from input
</details>

***
### Random numbers
<details><summary></summary>

* very similar to a `Scanner` as `Random` is also located in `java.util`
    * `.Random()` -> max range for data type, unless arguments are used ie. `rng.nextInt(11)` -> range is [0,10)
    * pass a number into the arguments for a seed ie. `Random(452)`
    ```java
    import java.util.Random;
    void main() {
        Random rng = new Random();//rng is just a variable for the 'Random' object
        double var1 = rng.nextDouble();
        int var2 = rng.nextInt(11);//picks a random int 0-10
    }
    ```
    * `.nextInt()`
        * `.nextInt(max)`                             -> range is [0,max)
        * `.nextInt(max + 1)`                         -> range is [0, max]
        * `min + .nextInt(max - min + 1)`             -> range is [min, max]
        * **alternative** pass a bound into argument, works only for **int**
            `.nextInt(max)`           -> range is [0, max)
            `.nextInt(max + 1)`       -> range is [0, max]
            `.nextInt(max - min + 1)` -> range is [min, max]
    * `.nextDouble()` <- can't use parameters like with `nextInt()`
        * `nextDouble() * (max + 1e-10)`              -> range is [0, max]
        * `min + .nextDouble() * (max - min + 1e-10)` -> range is [min, max]
 
* may also use `Math.random()`                        -> returns a **double** in range **[0,1)**
    * `Math.random() * max`                           -> returns a **double** in range **[0,max)** 
    * `(int) (Math.random() * (max + 1))`             -> returns an **int** in range **[0, max]**  (**USE `()` AROUND EXPRESSION ELSE ONLY ZERO WILL RETURN**)
    * `min + (int) (Math.random() * (max - min + 1))` -> returns an **int** in range **[min, max]**
    * `min + Math.random() * (max - min + 1e-10)`     -> returns a **double** in range **[min, max]**
</details>

***
### conditional statements
<details><summary></summary>

* `if` statements contains `()`
* `else if` must be used instead since `elif` does not exist
```java
void main() {
    if (var1 > 0) {
        // statements if true
    } else if (var1 < 0) {
        // statements if true
    } else {
        // statements if false
    }
}
```

#### note!
* `{}` is not technically needed for `else` only for first line after `else`
```java
void main() {
    if (var1 > 0) {
        // statements if true
    } else
        // statements if false
    // OUT OF 'else' SCOPE!
}
```
#### simplified repeating if statements (ie. `if var1 == 5`, `if var1 == 6`, `if var1 == 7`)
* use `switch` and `case`
* ie. `case 1:` checks if `var1` after `switch` is equal to `1`
* may optionally use `default` similar to `else`
```java
void main() {
    int var1 = 8;
    switch (var1) {
      case 1:
          // statements if true
          break;
      case 2:
          // statements if true
          break;
      default:
          // statements if no cases are true
          break;
    }
}
```
* `:` may be replaced with `->` however `break` is no longer required as there is no **falling through** with `->`
    * **falling through** may be mimiced with a comma `,`
    * if no action should be taken, must include empty `{}`
    * if multiple statements, should include a code block with `{}`
    * may use `yield` for conditionals `case -> {if (true) {yield 5;} else {yield 7;}}`
    * exmaple with all compatible data types
    ```java
    public class SwitchAllCompatibleTypes {

        public static void main(String[] args) {

            // 1. byte, short, char, int  (and their wrapper types via auto-unboxing)
            Integer intWrapper = 50;
            switch (intWrapper) {
                case 40 -> System.out.println("Integer: forty");
                case 50 -> {  // Multi-statement block
                    System.out.println("Integer: fifty");
                    System.out.println("Also logging: Processed fifty");
                }
                default -> System.out.println("Integer: other");
            }
            // 2. Character (char wrapper) – auto-unboxes to char
            Character ch = 'B';
            switch (ch) {
                case 'A' -> System.out.println("char/Character: A");
                case 'B' -> System.out.println("char/Character: B");
                case 'C' -> {}//empty code block
                default  -> System.out.println("char/Character: other");
            }
            // 3. String (since Java 7)
            String day = "Monday";
            switch (day) {
                case "Monday", //new line doesn't affect anything
                     "Tuesday"   -> System.out.println("Weekday start");
                case "Saturday", "Sunday"  -> System.out.println("Weekend");
                default                    -> System.out.println("Mid-week day");
            }
            // 4. enum (most common real-world use of switch today)
            enum Color { RED, GREEN, BLUE, YELLOW }

            Color c = Color.GREEN;
            switch (c) {
                case RED    -> System.out.println("Stop");
                case GREEN  -> System.out.println("Go");
                case BLUE, YELLOW -> System.out.println("Caution / Attention");
                // No default needed if all enum constants are covered (Java allows this)
            }

            // ───────────────────────────────────────────────
            // These types CANNOT be used in switch:
            // ───────────────────────────────────────────────
            // long, Long
            // float, double, Float, Double
            // boolean, Boolean
            // Object (unless it unboxes to one of the allowed primitive wrappers)
            // ───────────────────────────────────────────────
        }
    }
    ```

#### `break` is used because when any `case` is `true`, it will execute all cases after it
* excluding `break` can be useful in certain circumstances
* may also use `return` on either case as well
```java
void main() {
    int dayOfWeek = 3;
    switch (dayOfWeek) {
      case 1:
      case 2:
      case 3://starts here since case 3 is true
      case 4:
      case 5:
          System.out.println("Weekday");
          break;//ends here
      case 6:
      case 7:
          System.out.println("Weekend");
          break;
    }
}
```

</details>

***
### loops
<details><summary></summary>

* `while` loops very similar to if statements
```java
void main() {
    while (var1 > 0) {
        // statements if true
    } 
}
```
* `do while` loops split the loop in half putting the conditional statement in the middle where the `while` statement is
    * ie. `loop1=true -> do -> while`...`loop2=true -> do -> while`... `loop3=false -> do -> break`
* one benefit is that the statements inbetween the `do` and `while` will be executed at least once. Where a `while` loop by itself may not execute at a>
```java
void main() {
    do {
        // statements to do before while loop
    } while (var1 > 0);//NO EXTRA STATEMENTS
}
```
* `for` loops syntaxt inside the `()` with `for ()` has three parts
    * for (initialize value of `i`; condition to stop; incrimental direction
        * *initialize* -> ie. `int i = 0` (`i` is 0 on first loop)
        * *condition* -> ie. `i < 10` (will loop 10 times, stop when `i = 10`)
        * *incrimental direction* -> ie. `i++` (incriments 1 every loop)
            * use `i--` for decreasing incriments
```java
void main() {
    for (int i = 0; i < 10; i++) {
    // statements each loop
    }
}
```
* looping through an array
    * it iterate through an array, use the `.length` method without the `()` (ie. `i < myArray.length;`)
    * `i` represents the index, not the item unless using a **for each* loop
      ```java
      for (int i = 0; i < myArray.length; i++) {
          System.out.println(myArray[i]);
      }
      ```
* reverse an array with reverse for loop
    * `j` is set to count backwards while `i` is set to count forwards
        * syntaxt of dual counting for loop: `(i init, j inti; condition; i++, j--)`
    * initialize an empty array, then make `arrayReversed[i] = arrayOriginal[j]`
    ```java
    public static int[] reverseArray(int[] arrayOriginal) {
        int[] arrayReversed = new int[array.length];//initialize empty array
        for (int i = 0, j = arrayOriginal.length-1; i < array.length; i++, j--) {//do not re-declare type of j!
            arrayReversed[j] = array[i];
        }
    ```
* **for each** loop allows pulling the values rather than the index from array ie.`for (double i : myArray)`
    * remember, `i` is just a copy of the value of the index, not the orginal index value
    * ```java
      int sum = 0;
      for (int i : myArray) {
          sum += i;
          //ie. 'i = newValue' will NOT change orginal index value
      }
      ```
</details>

***
### operators
<details><summary></summary>

* **bitwise** operators
    * full evaluation (ie. no short circuit)
    * works on `int`, `long`, ect.
    * potential **side effects**? when used with numbers(ie. safe for boolean)
* **logical** operators
    * short-circuit
    * only works on `boolean`
* defining **short-circuit** -> ie. can skip evaluation of right operand if pre-determined from left operand
    ```java
    //prevents index error, assume `str` is empty
    if (str.length() > 0 && str.charAt(0) == 'A')
        // `str.length() > 0` -> false
        // `str.charAt(0) == 'A'` -> short-circuited, skipped because of `&&`
    ```
* common bug if `=` used instead -> `if (var1 = true) {...}` will return `true` always since `var1` is assigned to `true`
* `String` comparison does not work as `==` compares memory addresses (not a problem with number data types like `int`)
    * must use the `.equals()` method for `String` comparison ie. `var1.equals(var2)` instead of `var1 == var2`

* `&&` refers to **and**
* `||` refers to **or**
* `^` referes to **exclusive or** meaning only one can be true(note, `^` is bitwise operator, not logical)

* De Morgan's Law for distributing `!` to a boolean statement
    * flips signs ie. `&&` -> `||` and `<` -> `>=` and `^` -> `==`
    * `!(x > 5 && y < 10)` -> x <= 5 || y >= 10
    * `!(a || b)` -> `!a && !b`
    * `!(a ^ b)` -> `a == b`

* precedence
Java Operator Precedence (highest to lowest)

Precedence | Operators                                                      | Description                                                    | Associativity
-----------|----------------------------------------------------------------|----------------------------------------------------------------|--------------
1 (highest)| `()` `[]` `.` `::`                                             | Parentheses, array access, member access, method reference     | Left-to-right
2          | `expr++` `expr--`                                              | Postfix increment/decrement                                    | Left-to-right
3          | `++expr` `--expr` `+expr` `-expr` `~` `!` `(type)` `new`       | Prefix inc/dec, unary +/-, bitwise NOT, logical NOT, cast, new | Right-to-left
4          | `*` `/` `%`                                                    | Multiplication, division, remainder                            | Left-to-right
5          | `+` `-`                                                        | Addition, subtraction (also string concat)                     | Left-to-right
6          | `<<` `>>` `>>>`                                                | Bitwise shifts (signed & unsigned)                             | Left-to-right
7          | `<` `<=` `>` `>=` `instanceof`                                 | Relational and type comparison                                 | Left-to-right
8          | `==` `!=`                                                      | Equality and inequality                                        | Left-to-right
9          | `&`                                                            | Bitwise AND                                                    | Left-to-right
10         | `^`                                                            | Bitwise XOR                                                    | Left-to-right
11         | `|`                                                            | Bitwise OR                                                     | Left-to-right
12         | `&&`                                                           | Logical AND (short-circuit)                                    | Left-to-right
13         | `||`                                                           | Logical OR (short-circuit)                                     | Left-to-right
14         | `?` `:`                                                        | Ternary conditional                                            | Right-to-left
15         | `=` `+=` `-=` `*=` `/=` `%=` `&=` `^=` `|=` `<<=` `>>=` `>>>=` | Assignment and compound assignment                             | Right-to-left
16 (lowest)| `->`                                                           | Lambda expression arrow (context-dependent)                    | —

Notes:
- Operators on the same row have equal precedence.
- Use parentheses () to override precedence and improve readability.
- The arrow operator (->) is used in lambdas and switch expressions and does not follow standard expression precedence rules in all contexts.

* comparing **doubles** -> reccomended precision: 1E-14
    * due to rounding errors, must use an **epsilon** instead of `==`
    * if the 15th or 16th digit needs to be accurate, use bigDecimal instead
    ```java
    final double EPSILON = 1E-14;
    // Example calculation that results in a tiny precision error
    double x = 1.0 - 0.1 - 0.1 - 0.1 - 0.1 - 0.1; // x is actually 0.5000000000000001
    double y = 0.5;
    
    // Check if the difference is smaller than the threshold
    if (Math.abs(x - y) < EPSILON) {
        return true;
    } else {
        return false;
    }
    ```
* comparing **floats** -> reccomended precicion: 1E-5
    * if the 6th or 7th digit needs to be accurate, use doubles instead
    ```java
    final float epsilon = 0.00001f;
    if (Math.abs(a - b) < epsilon) {
        return true;
    } else { 
        return false; 
    }
    ```

</details>

***
### methods
<details><summary></summary>

* **NOTE!* -> `public` or `private` is not requried except for `main()` which requires `public`

| Modifier   | Visible to same Class | Visible to same Package | Visible to Subclasses | Visible to World |
|------------|-----------------------|-------------------------|-----------------------|------------------|
| public     | Yes                   | Yes                     | Yes                   | Yes              |
| protected  | Yes                   | Yes                     | Yes                   | No               |
| (No label) | Yes                   | Yes                     | No                    | No               |
| private    | Yes                   | No                      | No                    | No               |

```java
void main() {
    System.out.println("my method will return: ", methodName(6, 18));
}
public static bool methodName(int param1, int param2) { // need to include bool since this method returns a bool value...the 'int' in the parameters are basically enforced type hints
    // checks if two values are equal
    return (param1 == param2);
}
```
* if argument to an method is an array, must also include `[]` after the type
    ```java
    public static bool methodName(int[] array1) {}
    ```
* **stepwise refinement** - top-down stratety, starting with overall goal, then breaking down into smaller tasks
 
#### overloading methods
* allows the same method (ie. `max()`) that has different data types for the parameters, or even number of parameters
* the return type is irrelevant

```java
void main() {
    System.out.println("the max int is: ", max(6, 18));
    System.out.println("the max double is: ", max(6.5, 18.6, 5.5));
}
public static int max(int param1, int param2) { 
    // method for 'int' parameters
    if (param1 > param2) return param1;
    return param2
}
public static double max(double param1, double param2, double param3) { 
    // method for 'double' parameters     
    if (param1 > param2) return param1; 
    if (param2 > param3) return param2;
    return param3
}
```
</details>

***
### Arrays
<details><summary></summary>

* Fixed size length
* No hetrogenous types
* created with `new` OR an initializer with `{}`
    * may not use `{}` initializer to replace a previously created array
    * may use `new` to repalce a previously created array
* default values
    * zeros for number data types
    * boolean -> false
    * char -> '\u0000' (the "null" character as blank/space)
```java
void main() {
    double[] myArray = new double[10];// creates 10 empyty indexes
    
    myArray[0] = 5.5;//similar to python
    myArray[1] = 2.35;

    string[] ArrayInitializer = {"hello", "world"};//
}
```
* to make a copy of an array, can't just simply do `array2 = array1` since that would just make a new variable name for `array1`
    * the simple way: `int[] arrayCopy = myArray.clone();`
    * the manual way: using a `for` loop
        * must first be initialized/created via `new` ie. `int[] copy = new int[original.length];`
    ```java
    int[] original = {1, 2, 3};
    int[] copy = new int[original.length];

    for (int i = 0; i < original.length; i++) {
        copy[i] = original[i];
    }
    ```
* to obtain index of last item: `arr.length - 1` <- since the index starts at 0
    * if `i = arr.length - 1` then `arr[i]` equals the value of that item

* array math shortcuts
    * use `Arrays.stream(arr1).` without needing iterative loop or manual index arguments
    * common methods
        * `Array.stream(arr1).min()` -> min
        * `Array.stream(arr1).max()` -> max
        * `Array.stream(arr1).sum()` -> sum
        * `Array.stream(arr1).average()` -> avg

* **multi-dimensional arrays**
```java
* types:
    * square 3x3
    * rectangle 2x5
    * ragged 4,1,3,2
        ```java
        {
        {4,4,4,4},
        {1},
        {3,3,3},
        {2,2}
        }
        ```
* To store objects in an array, must first initialize array with the data type of the object being its class
    ```java
    //lets Circle be a class
    Circle[] arrayCircles = new Circle[5];// [null, null, null, null, null] -> no circles have yet been created
    for (int i = 0; i < arrayCircles.length; i++) {
        arrayCircles[i] = new Circle();
    }
    ```

import java.util.Arrays
int[][] squareArray = new int[3][5]; //[outer][inner]
int fillValue = 1;
for (int[] row : squareArray) {
    Arrays.fill(row, fillValue);//fills each index in inner [] (more efficient that setting up multiple nested for loops)
    fillVallue++;
//  output:[
//      [1,1,1,1,1]
//      [2,2,2,2,2]
//      [3,3,3,3,3]
//  ]
}
//ARRAY INITIALIZER
int[][] raggedArray = {
        {4,4,4,4},
        {1},
        {3,3,3},
        {2,2}
    };
```

#### Array List
* must first `import java.util.ArrayList;`
* can't do `ArrayList shapes = new ArrayList();` since this doesn't describe the nested type inside `ArrayList`
    * INSTEAD use `<>` to pass type held inside ArrayList
    * must use `.add()` to append new entries
    * indecies inside ArrayList are private. Can't access with `shapes[i]`
        * use `.get(i)` for read access
        * use `.set(i, "new value")` for write access
        * use `.size()` instead of `len()` for a for loop
            * may also use for each loop
    ```java
    import java.util.ArrayList;
    void main() {
        ArrayList<String> shapes = new ArrayList<>();
        shapes.add("Circle");
        shapes.add("Square");


        for (int i = 0; i < shapes.size(); i++)
            shapes.set(i, "shape" + i)//renamed with set()

        for (String i : shapes) {
            System.out.println(i)
        }
    }
    ```

</details>

***
### search/sort
<details><summary></summary>

* **linear search**
    ```java
    public static boolean linearSearch(int search) {
        for (int i = 0; i < array.length; i++) {
            if (array[i] == search) {
                return true;
            }
        }
        return false;
    }
    ```

* **binary search**
    ```java
    public static boolean binarySearch(int search) {
        int lower = 0;
        int upper = array.length - 1;

        boolean found = false;
        while (!found && lower <= upper) {
            int middle = (lower + upper) / 2;
            if (array[middle] == search) {
                found = true;
            } else if (array[middle] < search) {
                lower = middle + 1;
            } else {
                upper = middle - 1;
            }
        }
        return found;
    }
    ```

* **bubble sort**
    ```java
    public static void bubbleSort(int[] array) {
        boolean didSwap = false;
        do {
            didSwap = false;
            for (int item = 0; item < array.length - 1; item++) {
                if (array[item] > array[item + 1]) {
                    int temp = array[item];
                    array[item] = array[item + 1];
                    array[item + 1] = temp;
                    didSwap = true;
                }
            }
        } while (didSwap);
    }
    ```
    
* **selection sort**
    ```java
    public static void selectionSort(int[] array) {
        for (int start = 0; start < array.length - 1; start++) {
            int minPos = start;
            for (int scan = start + 1; scan < array.length; scan++) {
                if (array[scan] < array[minPos]) {
                    minPos = scan;
                }
            }
            int temp = array[start];
            array[start] = array[minPos];
            array[minPos] = temp;
        }
    }
    ```
</details>

***
### arithmetic
<details><summary></summary>

* **post-increment** `i++` returns current value then increments
    ```java
    int i = 5;
    System.out.println(i++);   // prints 5
    System.out.println(i);     // prints 6
    ```
    ```java
    int a = 10;
    int b = a++;     // b gets 10, then a becomes 11
    System.out.println(a);   // 11
    System.out.println(b);   // 10
    ```
    * incorrect method
        ```java
        int i = 5;
        i = i++;    // i stays 5
        i = i++;    // i stays 5
        i = i++;    // i stays 5
        i = i++;    // i stays 5
        ```
    * correct method
        ```java
        int i = 5;

        i++;          // i → 6
        i++;          // i → 7
        i++;          // i → 8

        // or
        i = i + 1;    // same effect
        i += 1;       // same effect
        ++i;          // same effect (pre-increment)
        ```
* **pre-increment** `++i` increments then returns new value
    ```java
    int x = 3;
    int y = ++x;     // x becomes 4 first, then y gets 4
    System.out.println(x);   // 4
    System.out.println(y);   // 4
    ```
* rounding via `Math.round()` function
    * `float` -> `int` (both are 32 bit numbers)
    * `double` -> `long` (both are 64 bit nubmers)

| Method                              | Description                                                  | Return Type   | Example & Result                                                                 |
|-------------------------------------|--------------------------------------------------------------|---------------|----------------------------------------------------------------------------------|
| `abs(x)`                            | Absolute (non-negative) value                                | same as x     | `Math.abs(-7.89)` → `7.89`                                                       |
| `max(a, b, c...)`/`min(a, b, c...)` | Larger / smaller of two values                               | same as args  | `Math.max(10, 25)` → `25`<br>`Math.min(10, 25)` → `10`                           |
| `pow(a, b)`                         | a raised to the power b (aᵇ)                                 | double        | `Math.pow(2, 10)` → `1024.0`                                                     |
| `sqrt(x)`                           | Square root of x                                             | double        | `Math.sqrt(144)` → `12.0`                                                        |
| `cbrt(x)`                           | Cube root of x                                               | double        | `Math.cbrt(27)` → `3.0`                                                          |
| `sin(x)`, `cos(x)`, `tan(x)`        | Sine, cosine, tangent (x in radians)                         | double        | `Math.sin(Math.PI / 2)` → `1.0`<br>`Math.cos(Math.PI)` → `-1.0`                  |
| `asin(x)`, `acos(x)`, `atan(x)`     | Inverse trigonometric functions (return radians)             | double        | `Math.asin(1.0)` → `1.5708...` (π/2)<br>`Math.acos(-1.0)` → `3.14159...` (π)     |
| `atan2(y, x)`                       | Angle (in radians) from positive x-axis to point (x,y)       | double        | `Math.atan2(1, 1)` → `0.785398...` (π/4 rad, 45°)                                |
| `toRadians(deg)` / `toDegrees(rad)` | Convert degrees ↔ radians                                    | double        | `Math.toRadians(90)` → `1.5708...`<br>`Math.toDegrees(Math.PI / 2)` → `90.0`     |
| `log(x)`                            | Natural logarithm (base e)                                   | double        | `Math.log(Math.E)` → `1.0`                                                       |
| `log10(x)`                          | Base-10 logarithm                                            | double        | `Math.log10(1000)` → `3.0`                                                       |
| `exp(x)`                            | e raised to the power x (eˣ)                                 | double        | `Math.exp(1)` → `2.71828...` (≈ e)                                               |
| `floor(x)` / `ceil(x)`              | Round down / round up to nearest integer                     | double        | `Math.floor(4.7)` → `4.0`<br>`Math.ceil(4.7)` → `5.0`                            |
| `round(x)`                          | Round to nearest integer (long when input is double)         | long / int    | `Math.round(4.6)` → `5`<br>`Math.round(4.4)` → `4`                               |
| `rint(x)`                           | Round to nearest integer (returns double)                    | double        | `Math.rint(4.6)` → `5.0`<br>`Math.rint(4.5)` → `4.0` (rounds .5 to even)         |
| `random()`                          | Pseudorandom value ∈ [0.0, 1.0)                              | double        | `Math.random() * 100` → e.g. `42.735...` (range 0–99.999...)                     |
| `hypot(x, y)`                       | √(x² + y²) — accurate hypotenuse                             | double        | `Math.hypot(3, 4)` → `5.0`                                                       |
| `signum(x)`                         | Sign of x: -1.0, 0.0, or 1.0                                 | double        | `Math.signum(-42.5)` → `-1.0`<br>`Math.signum(0.0)` → `0.0`                      |
| `copySign(x, y)`                    | Magnitude of x with sign of y                                | same as x     | `Math.copySign(10.0, -3.2)` → `-10.0`                                            |

* bitwise math
    * AND(`&`) -> both must be true
        * `0011 & 1111 = 0011` or `3 & 15 = 3`
    * OR(`||`) -> at least 1 must be true
        * `0010 || 0100 = 0110` or `2 || 4 = 6`
    * XOR(`^') -> only 1, not both must be true
        * `0111 ^ 1111 = 1000` or `7 ^ 15 = 8`

| Decimal | Binary |
|------------------|
| 1       | 0001   |
| 2       | 0010   |
| 3       | 0011   |
| 4       | 0100   |
| 5       | 0101   |
| 6       | 0110   |
| 7       | 0111   |
| 8       | 1000   |
| 9       | 1001   |
| 10      | 1010   |
| 11      | 1011   |
| 12      | 1100   |
| 13      | 1101   |
| 14      | 1110   |
| 15      | 1111   |

</details>

***
### Strings
<details><summary></summary>

* immutable, must assign new value or define new variable
* `+=` works for appending
* helpful String methods
    * `.toLowerCase()`, `.toUpperCase()`, `.length()`, `.equals(String)`, .`replace(char old, char new)`, `.split(String regex)`, `charAt(int)`, `.substring(int)`, `.trim()`, `.isEmpty()`
* reminder
    * use `.substring(i)` for looping through substrings
    * use `.charAt(i)` for looping through charcters -> returns a **char**
        * use `Character.isDigit(char)` to check if a single **char** is a **boolean** <-- does not accept a String
        * Must first convert single **string** character to **char** type ie. `Char
        ```java
        String str = "H3LL0"
        for (i = 0; i < str.length; i++) {
            Character.isDigit(charAt(i));
        }
        ```
</details>


***
### misc custom functions
<details><summary></summary>

```java
public static boolean areAnagramsSort(String s1, String s2) {
//aTwo strings are anagrams if they contain the same characters with the same frequencies (case-sensitive or insensitive depending on requirement).
    if (s1 == null || s2 == null) return false;
    if (s1.length() != s2.length()) return false;
    
    char[] arr1 = s1.toLowerCase().toCharArray();
    char[] arr2 = s2.toLowerCase().toCharArray();
 a   
    Arrays.sort(arr1);
    Arrays.sort(arr2);
    
    return Arrays.equals(arr1, arr2);
}
```
```java
public static boolean isPalindromeReverse(String s) {
//A string is a palindrome if it reads the same forwards and backwards (ignoring case, spaces, punctuation is optional depending on requirements).
    String reversed = "";
    for (int i = s.length() - 1; i >= 0; i--) {
        reversed += s.charAt(i);
    }
    return s.equals(reversed);
}
```
```java
void main() {
    long totalMilliseconds = System.currentTimeMillis(); // counting from the UNIX epoch: January 1, 1970 GMT
    
    long totalSeconds = totalMilliseconds / 1000;
    long totalMinutes = totalSeconds / 60;
    long totalHours = totalMinutes / 60;
    
    long currentHour = totalHours % 24;
    long currentMinute = totalMinutes % 60;
    long currentSecond = totalSeconds % 60;
    
    System.out.println("Current time is: "
        + currentHour + ":";
        + currentMinute + ":";
        + currentSecond + "GMT");
}
```
```java
import java.util.ArrayList;
import java.math.*;

void main(String[] args) {
    ArrayList<Number> list = new ArrayList<>();
    list.add(42);
    list.add(1337.33);
    list.add(new BigInteger("123456789123456789012345678912345678912345"));
    list.add(new BigDecimal("3.1415926535897932384626433832795028841971"));

    System.out.printf("The largest number is: %s\n", getLargestNumber(list));
}

/**
* Finds the largest number in a list of mixed types without losing precision.
*/
public static BigDecimal getLargestNumber(ArrayList<Number> list) {
    // 1. Safety check for empty or null lists
    if (list.isEmpty()) {
        return null;
    }

    // 2. Initialize "biggest" using the first element
    BigDecimal biggest = new BigDecimal(list.get(0).toString());

    for (Number n : list) {
        // 3. Convert current number to BigDecimal for a precise comparison
        BigDecimal currentVal = new BigDecimal(n.toString());

        // 4. Compare currentVal to our running champion
        if (currentVal.compareTo(biggest) > 0) {
            biggest = currentVal;
        }
    }
    
    return biggest;
}
```
```java
<E extends Comparable<? super E>> void quicksortGeneric(E[] data) {
    quicksortGeneric(data, 0, data.length - 1);
}
<E extends Comparable<? super E>> void quicksortGeneric(E[] data, int start, int end) {
    if (start < end) {
        int pivot = partition(data, start, end);//moves everything less to the left, greater to the right...then returns pivot index
        quicksortGeneric(data, start, pivot - 1);//sorts left of pivot
        quicksortGeneric(data, pivot + 1, end);//sorts right of pivot
    }
}
<E extends Comparable<? super E>> int partition(E[] data, int start, int end) {
    int middle = (start + end) / 2;
    E pivotValue = data[middle];

    //swap pivot(ie. middle) with start
    E temp = data[middle];
    data[middle] = data[start];
    data[start] = temp;

    int pivot = start;

    for (int scan = start + 1; scan <= end; scan++) {
        if (data[scan].compareTo(pivotValue) < 0) {//true if scan < pivotValue
            pivot++;//update pivot
            //swap new pivot with scan
            temp = data[scan];
            data[scan] = data[pivot];
            data[pivot] = temp;
        }
    }
    //swap start with new pivot
    temp = data[pivot];
    data[pivot] = data[start];
    data[start] = temp;

    return pivot;
}
```
</details>

***
### Classes & Objects
<details><summary></summary>

* To build a constructor, make a method out of the class
* `static` if used on method or attribute will keep use/functionality agnostic of instances
    * handy uses
        * **constants** should use `static` to avoid memory consumption(else realocates for each instance)
        * iterating variable to count number of created instances, or even a list of all instances...one benefit is ommits need for variables to access instances
        ```java
        import java.util.ArrayList;
        import java.util.List;

        public class Player {
            private String name;

            // The Static List: Shared by the entire class with the class name 'Player' as the type
            public static List<Player> allPlayers = new ArrayList<>();

            public Player(String name) {//initialize constructor
                this.name = name;
                // Every time 'new Player()' is called, the object adds itself (this) to the list.
                allPlayers.add(this);
            }
            public String getName() {
                return name;
            }
            void main() {//initializing instances..notice -> no need for variables
                new Player("Alice");
                new Player("Bob");
                new Player("Charlie");

                //acessing data
                System.out.println("Total players: " + Player.allPlayers.size());//getting number of instances
                for (Player p : Player.allPlayers) {//accessing each instance
                    System.out.println("Stored Player: " + p.getName());
                }
            }
        }
        ```

* Does not return any thing, ie. no **return type** or `void`
    * if used, will be treated as a normal class method instead of a constructor
* don't forget to overload if wanting option for parameters or not
    ```java
    class Cirlce {
        double radius;
        Circle() {radius = 1;}//constructor
        Circle(double initialRadius) {radius = initialRadius; }//overloaded constructor

        double getArea() {return Math.PI * radius * radius; }//instance method
        double getPerimeter() {return 2 * Math.PI * radius; }
        void setRadius(double newRadius) {radius = newRadius; }
    }
    ```
    * use `new` to create a new object/instance of Class
        ```java
        void main(){
            Circle c1 = new Circle();
            Circle c2 = new Circle(4);//using overloaded constructor
        }
        ```

* `this` is needed in cases where shadowing is used. But best practice is to always use it when accessing instance variables
    * can not be used with `static` variables and methods (technically can be used inside main to access class attributes assuming static was ommited)
    * **shadowing** is where a parameter name is the same as the class attribute name as the parameter would be called without `this`
        * conventionally `this` is not used in getters except when needed.
        ```java
        public class Square {
            int width = 5;
            int getArea() {
                return width * width;
            }
            void setArea(int width) {
                this.width = width;
            }
        }
        ```

#### INHERITANCE     
* use `final` to prevent any inheritance at the class level
    * `final` if used just on methods/attributes prevents overriding.
    * `Private` also prevents inheritance on methods/attributes(can't be used on a class)
* use **child** `extends` **parent** to create a child class ie. `class Circle extends Shape {...}`
* private attributes in parent can be modified only by methods in the parent.
* private methods in parent are not inherited by child
* private classes can not be inherited
* When ANY child constructor is called, the parents' empty constructors are ALWAYS called unless `super` is used to call a specific parent constructor. Super only accesses the immediate parent.
    * calling super can be usefull to avoid creating setters in parent if trying to keep parent attributes immutable/private
        ```java
        void main() {
            Shape shape1 = new Circle();//color is black, inherited from parent default -> String() & Circle() called
            Shape shape2 = new Circle("blue")//color is blue, only because `super()` was called
        }
        class Shape {
            //define attribute
            private String color;
            //initialize constructors
            Shape() {color = "black";}
            Shape(String color) {this.color = color;}
            //getter methods for attribute
            String getColor() {return color;}
        }
        class Circle extends Shape {
            private double radius;
            Circle(String color) {//color overrides parent default(immediatly after parent sets to default)
                super(color);//needed since `color` is private, if public could instead do `this.color = color;` alternativly could have made a setter in parent and called in child constructor
                radius = 1;
            }
            Circle() {radius = 1;}//color default is triggered by parent

            double getRadius() {return radius;}
        }
        ```
    
    * All classes by default inherit for `Object`
        * `.toString()` automatically called when printing any object which is inherited fromm `Object`
            * returns class name and memory location ie. `Circle@5b480cf9`
            * if overriding to write custom method, may also call `super(toString)` to retain previous functionality
            ```java
            void main() {
                System.out.println(Circle);// `.toString()` automatically appended to `Circle`
                System.out.println(Circle.toString());// redundant example since called anyway
            }

            class Circle {//extended from `Object`
                private String color;
                private java.util.Date timeCreated;
                Circle() {
                    color = "blue";
                    timeCreated = new java.util.Date();
                }

                @Override//reccommended since `toString` is a method of `Object`
                toString() {//can also put @override on same line as signature
                    return String.format("%s\nCreated on: %s\nColor: %s",
                        super.toString(),//retains original functionality of toString ie. Circle@memoryAddress
                        this.timeCreated,//handy modification
                        this.color);
                }
            }
            ```

* Class relationships
    * **inheritance** -> directly inherits attributes from parent (ie. superCar inherits from Car)
    * **composition** -> creating an object inside of a different class then stored as an attribute
        * if parent dies, child also dies (ie. factory creates car and stored in factor)
    * **aggregation** -> pass as argument then stored as attribute
        * if parent dies, child can remain (ie. pre-made car passed into warehouse)
    * **association** -> interacts with secondary class, often methods (ie. car passed into driver and calls `car.drive()`)

    * example: student has name and address
        * sudent - name -> composition (UML has black diamon next to owner ie. student)
        * student - address -> aggregation (UML has non filled white diamond next to owner ie. student)

##### visibility
* Child classes may not decrease visibility for inherited attributes/methods
* however the child class itself may increase visibility for non inherited attributes/methods
* the child class may itself be more visible but the inherited attributes/methods remain the same regardless of being overriden

##### dynamic binding
* A form of Polymorphism related to inheritance when child's overriten method may be found at runtime even though defined as parent ONLY when signature matches parent's method.
    ```java
    void main() {
        Rectangle var1 = new Square();
        Rectangle var2 = new Rectangle();
        System.out.printf(var1.getArea());
        System.out.printf(var2.getArea());
    }
    class Rectangle {
        private int width = 3;
        private int height = 4;
        int getArea() {
            return width * height
        }
    }
    class Square extends Rectangle{
        int side = 12;
        @override int getArea() {
            return side * side;
        }
    }
    ```
* `getClass()` returns a `Class` object, which stores the information about the child class it was created as.
    * helpful when making sure if a rectangle is also a square. Helpful in deep inheritance trees 
    ```java
    Rectangle var1 = new Square();
    Rectangle var2 = new Rectangle();
    var1.getClass().getSimpleName()//returns "Square"
    var2.getClass().getSimpleName()//returns "Rectangle"
    ```

##### Abstract Classes/methods & Interfaces
* attributes can NOT be abstract...but attributes are still inherited if not marked private
* if method is marked abstract method, class must also be marked abstract
* abstract methods enforces methods to be overriden on child classes for safe polymorphism
* may still use `instanceof` to check of obj implements a certain interface
```java
protected abstract class GeometricObject {
    abstract double getArea();//notice no {code block}
}
public class square extends GeometricObject {
    private double side = 4;
    @Override double getArea() {
        return side * side;
    }
}
```

* Interfaces can store virtual functions that can be implimented by classes.
    ie. Animal abstract class is inherited by Chicken and Tiger classes. But I could have an interface called Edible that has a method that lets you eat. Chickens might impliment Edible while also inheriting Animal but Tiger does not impliment Edible. This also allows lets say a Fruit class to impliment Edible while also inheriting from abstract Plant class
    * Interface methods can only be either public or private. If public, implementations can't reduce visibility(no protected/package private)
    * If object is defined as Object, must then cast the interface as the type to call virtual function
    ```java
    void main() {
        Object[] objList = {
            Animal obj1 = new Tiger();
            Animal obj2 = new Chicken();
            Plant obj3 = new Orange();
            Plant obj4 = new Apple("red");
            Plant obj5 = new PoisonIvy();
        }
        ((Chicken)obj2).fly(true);
        ((Chicken)obj2).fly(false);

        for (Object obj : objList) {
            if (obj instanceof Edible) {
                System.out.println(obj.getClass().getSimpleName(),(Edible)obj.howToEat())//must cast Edible interface to call virtual function
            }
        }
    }
    interface Edible {
        String howToEat();
    }
    interface Flight {// <-- poor design, better to make an abstract bird class (or composition with flight class) since state must be public
        default void fly(boolean newState) {
            if (newState && isFlying()) {System.out.println("Already Flying");}
            else if (newState && !isFlying()) {System.out.println("Lift Off");}
            else if (!newState && isFlying()) {System.out.println("Landing");}
            else if (!newState && !isFlying()) {System.out.println("Already Landed");}
            _setFlying(newState);
        }
        boolean isFlying();
        void _setFlying(boolean newState);
    }
    abstract class Animal {
        abstract String noise();//must carry abstract to methods
        abstract String howToMove();
    }
    class Chicken extends Animal implements Edible, Flight {
        private boolean flying = false;
        @Override String noise() {
            return "bock bock";
        }
        @Override public String howToEat() {//must declare public since its from interface
            return "cook";
        }
        @Override String howToMove() {
            return "fly";
        }
        @Override public boolean isFlying() {//must declare public since its from interface
            return this.flying;
        }
        @Override public void _setFlying(boolean newState) {//must declare public since its from interface
            this.flying = newState;
        }
    }
    class Tiger extends Animal {
        @Override String noise() {
            return "roar";
        }
        @Override String howToMove() {
            return "run";
        }
    }

    abstract class Plant {
        private String color;

        Plant(String color) {
            this.color = color;
        }
        String getColor() {
            return color;
        }
    }
    class PoisonIvy extends Plant {
        PoisonIvy(){
            super("green");
        }
    }

    abstract class Fruit extends Plant implements Edible {
        Fruit(String color) {//constructors can't be abstract
            super(color);
        }
    }
    class Orange extends Fruit {
        Orange() {
            super("orange");
        }
        @Override public String howToEat() {//must declare public since its from interface
            return "juice";
        }
    }
    class Apple extends Fruit {
        Apple(String color) {
            super(color);
        }
        @Override public String howToEat() {//must declare public since its from interface
            return "bite";
        }
    }
    ```


##### Type Casting
* when defining a parent class but calling a child constructor, child attributes and methods are unavailable to object unless later manual casted to redefine as child class type
    * Java remembers the the class the contructor was called from. Creates almost a "secret" type that is remembered if in case a child object is defined as a parent and later type casted as a child.

* autocasted if redefining a child object as parent
* manual casting needed if redefining a parent object as child asuming object is already a child but previously defined as parent
* remember, parents can not become a child!

```java
void main() {
    Square shape1Sqr = new Square();
    Rectangle shape2Rect = new Square();
    Square shape3 = new Rectangle();//  <-- RUNTIME error will crash; a parent object, can not be defined as child if not actually a child

    Rectangle shape1Copy = shape1Sqr;//redefined child->parent auto-casted
    Square shape2Copy = (Square)shape2Rect;//redefined parent->child NEEDS manual type-casting
}

class Parent{
    int width = 3;
    int hight = 4;
}

class Square extends Rectangle{
    int side = 12;
}

```
#### Object Comparison
* use `==` to compare memory addresses of objects not data within
* use `instanceof` to compare object to type name ie. `var1 instanceof Object` returns `bool`
* **override** `equals()` method to extend functionality to custom classes extended from `Object`
    * use `instanceof` to prevent crash if parameter is not same class type
    ```java
    void main() {
        Circle shape1 = new Circle(1);
        Circle shape2 = new Circle();
        System.out.println(shape1.equals(shape2))//different instances but contain same data, returns `true`
    }
    class Circle {
        double radius;
        Circle() {
            this.radius = 1;
        }
        Circle(double radius) {
            this.radius = radius;
        }
        @override double equals(Object obj) {
            if (obj instanceof Circle) {//prevents crash if obj can't be casted to Circle
                Circle objCasted = (Circle)obj;//MUST cast since previously defined as Object in parameter type
                return this.radius == obj.radius;//be aware of rounding errors
            }
            return false;//obj was not a Circle
        }
    }
    ```
* alternativly could override the `compareTo()` method from the `Comparable` interface.
    * helpful for sorting classes that arnen't a built in warper class for primitives...could beef up a previous sort algorithm that support objects that also implement Comparable to now modularly sort the object regardless of the type
    ```java # ignore this one, just an example
    interface Comparable {//Simplified version of Java's provided interface
        int compareTo(Object obj);// Conventionally returns < 0 if this object > parameter , 0 if equal, < 0 if this object < parameter
    }
    ```
    ```java
    void main() {
        Circle shape1 = new Circle(1);
        Circle shape2 = new Circle();
        System.out.println(shape1.equals(shape2))//different instances but contain same data, returns `true`
    }
    class Circle implements Comparable {
        double radius;
        Circle() {
            this.radius = 1;
        }
        Circle(double radius) {
            this.radius = radius;
        }
        @override int compareTo(Object obj) {//lacks type safety if obj not circle
            Circle objCasted = (Circle)obj;//MUST cast since previously defined as Object in parameter type
            if (this.radius > objCasted.radius) {
                return 1;
            } else if (this.radius < objCasted.radius) {
                return -1;
            } else return 0;
        }
    }
    ```
##### Generic Comparables
```java
void main() {
    Circle shape1 = new Circle(1);
    Circle shape2 = new Circle();
    
    // Different instances but contain same data, now correctly returns `true`
    System.out.println(shape1.equals(shape2));
    
    // This will print 0, meaning they are equal according to compareTo
    System.out.println(shape1.compareTo(shape2));
}

// 1. Add <Circle> to the Comparable interface
class Circle implements Comparable<Circle> {
    double radius;
    
    Circle() {
        this.radius = 1;
    }
    
    Circle(double radius) {
        this.radius = radius;
    }

    @Override
    // 2. The parameter is now explicitly a Circle, not an Object
    public int compareTo(Circle other) {
        // 3. No casting needed! We know 'other' is guaranteed to be a Circle.
        
        if (this.radius > other.radius) {
            return 1;
        } else if (this.radius < other.radius) {
            return -1;
        } else {
            return 0;
        }
        
        // Note: A cleaner, best-practice way to write the above 7 lines in modern Java is:
        // return Double.compare(this.radius, other.radius);
    }

    // Added so shape1.equals(shape2) works based on the radius data, not memory address
    @Override
    public boolean equals(Object obj) {
        if (this == obj) return true;
        if (obj == null || getClass() != obj.getClass()) return false;
        
        Circle circle = (Circle) obj;
        // Compare primitive doubles safely
        return Double.compare(circle.radius, this.radius) == 0; 
    }
}
```

  Key differences you'll notice in this updated version:
   * implements Comparable<Circle>: This tells the compiler that a Circle can only be compared to another Circle.
   * public int compareTo(Circle other): The method signature now accepts a Circle directly.
   * No (Circle) obj casting: Because the compiler enforces the type, you don't need to manually cast Object to Circle inside the method. You can access other.radius immediately.
* Exists also a generic `Comparable<E>` interface...way easier to avoid dealing with tyoe casting
* **MORE ROBUST** approach is `<E extends Comparable<? super E>>` vs `<E extends Comparable<E>>` (see `quicksortGeneric`) since comparable<E> if inherited from parent class is locked to that same parent class...meaning can't compare child classes
    Imagine you have a class Animal that implements Comparable<Animal>. 
    Then, you create a subclass called Dog extends Animal. 
    
    Because Dog inherits compareTo(Animal) from its parent, it technically implements Comparable<Animal>, not Comparable<Dog>. 

    If you use <E extends Comparable<E>>, you cannot pass a Dog[] array into your quicksort method because Dog doesn't implement Comparable<Dog>.

    By using <E extends Comparable<? super E>>, you are telling Java: "Accept any type E, as long as E (or one of E's parent classes) implements Comparable."

#### Generics
```java
void main() {
    GenericStack<String> stack1 = new GenericStack<>();
}
class GenericStack<E> {
    //use E as type
    <E> void customMethod(E[] data) {// <-- use <E> for methods that accept a generic type...
        //method statements
    }
}
```
#### Generic bounded types
* Must bind generic type if intending to call any methods of the generic type. Data structures don't always need this since they are just storing the types. Don't need to bind generic to type if calling the methods of the generic outside of the generic class, only if calling from inside the class
* the big use case for this is that if the generic was bypassed and just used GeometricObject as the type, then if i didn't want polymorphic behavior (ie. only either circles or rectangls) then I need to use generic bounded types to the parent. I could also  bind it to circle, but then I would need overloaded methods for rectangle as well. 
```java
import java.util.ArrayList;

public class MainProgram {
    public static void main(String[] args) {
        ArrayList<Circle> circles = new ArrayList<>();

        circles.add(new Circle(2, "Blue", false));//
        circles.add(new Circle(4, "Green", false));

        double area = totalArea(circles);
        System.out.printf("The total of all circles is %.2f\n", area);
    }

    public static <T extends GeometricObject> double totalArea(ArrayList<T> objects) {//need to use <T> as placeholder for actual object to "extends ParentClass", enforces parent type 'GeometricObject' without having to overload for every possible child class.
        double total = 0;
        for (GeometricObject item : objects) {
            total += item.getArea();
        }
        return total;
    }
}
    private boolean filled;

    protected GeometricObject(String color, boolean filled) {
        this.color = color;
        this.filled = filled;
    }
    public abstract double getArea();
}
class Circle extends GeometricObject {
    private double radius;

    Circle(double radius, String color, boolean filled) {
        super(color, filled);
        this.radius = radius;
    }

    @Override
    double getArea() {
        return Math.PI * radius * radius;
    }
}
```
</details>

***
### exception handling
<details><summary></summary>

* raise an exception(optional, best for better error messages and/or forcing an error)
    * use `throws <Exception>` after method signature (conventionally declaring we are looking for it)
    * use `throw new <Exception>("Error")` in code block (raises the error, crashes if not handled)
* handling exception(jvm will catch automatically raise errors and/or manully thrown errors)
    * use `try`&`catch` to handle error(`ex` is just a convensional variable)(required for checked exceptions)
    * add more `catch` blocks for catching more errors (ie. `InputMismatchException` for inputing String instead of Int)
* `finally` optional block AWAYS runs even when `return` statements exist in try/catch blocks

#### custom exceptions
```java
class InvalidRadiusException extends RuntimeException {
    private double radius;
    InvalidRadiusException(double radius) {//overloads inherited constructor to allow doubles instead of Strings
        this.radius = radius;
    }
    double getRadius() {//helpful since getMessage() would only get the string
        return this.radius
    }
}
```

#### 1. Unchecked Exceptions (Subclasses of `RuntimeException`)
**Rule:** You are **not required** to catch these or declare them in a `throws` clause. They usually represent programming logic errors.

| Exception Class                      | Package     | Common Trigger |
| :--- | :--- | :--- |
| **`ArithmeticException`**            | `java.lang` | Division by zero or overflow. |
| **`NullPointerException`**           | `java.lang` | Accessing a method or field on a `null` object. |
| **`ArrayIndexOutOfBoundsException`** | `java.lang` | Using an index outside the range of an array. |
| **`IllegalArgumentException`**       | `java.lang` | Passing an inappropriate value to a method. |
| **`IllegalStateException`**          | `java.lang` | Calling a method when the object is in an unfit state. |
| **`NumberFormatException`**          | `java.lang` | Failing to parse a string into a numeric type. |
| **`ClassCastException`**             | `java.lang` | Attempting to cast an object to an incompatible type. |
| **`NoSuchElementException`**         | `java.util` | Trying to get an element from an empty collection/iterator. |

---

#### 2. Checked Exceptions (Subclasses of `Exception` excluding `RuntimeException`)
**Rule:** You **must** wrap these in a `try-catch` block or declare them in your method signature using `throws`. These represent recoverable conditions outside your code's direct control.

| Exception Class                  | Package                | Common Trigger |
| :--- | :--- | :--- |
| **`IOException`**                | `java.io`              | Failed or interrupted I/O operations. |
| **`FileNotFoundException`**      | `java.io`              | Attempting to access a file that does not exist on disk. |
| **`SQLException`**               | `java.sql`             | Errors related to database access or syntax. |
| **`ClassNotFoundException`**     | `java.lang`            | The JVM cannot find a class it needs to load. |
| **`InterruptedException`**       | `java.lang`            | A thread is interrupted while it is waiting or sleeping. |
| **`CloneNotSupportedException`** | `java.lang`            | Attempting to clone an object that doesn't implement `Cloneable`. |
| **`TimeoutException`**           | `java.util.concurrent` | A blocking operation timed out. |

---

#### 3. Errors (Subclasses of `Error`)
**Rule:** These are "Unchecked" but are **not** meant to be caught. They represent serious JVM-level disasters.

| Error Class                | Why it happens |
| :--- | :--- |
| **`OutOfMemoryError`**     | The JVM has run out of heap space. |
| **`StackOverflowError`**   | Too many recursive calls (infinite recursion). |
| **`NoClassDefFoundError`** | A class was available at compile time but missing at runtime. |

```java
void main() {
    int num1 = 4;
    int num2 = 0;
    try {
    System.out.println(quotient(num1, num2));
    } catch (ArithmeticException ex) {
        System.out.printf("Exception caught: %s\n", ex.getMessage());
    } catch (Exception ex) {
        System.out.printf("Exception caught: %s\n", ex.getMessage());
    } finally {//optional
        //AWAYS runs even when `return` statements exist in try/catch blocks
    }
    //runs regardless of errors, but NOT when return statements exist in try/catch blocks
}
int quotient(int numerator, int divisor) throws ArithmeticException {
    if (divisor != 0) {
        return numerator / divisor;
    } else {
        throw new ArithmeticException("Divisor cannot be zero");//throws `new` object instance (ie. ArithmeticException)
    }
}
```
</details>

***
### recursion
<details><summary></summary>

base cases - stops recursion
recursive steps - continues recursion
#### factorials
```java
void main() {
    System.out.println(factorial(4));
}
void factorial(int n) {
    if (n == 0) {//base case
        System.out.println("n" + n)//only ever prints "n = 0"
        return 1;//cuts adding to call stack
    }
    System.out.println("n" + n)
    return n * factorial(n - 1);//recursive steps
}
//Output:
// n = 4 prints first despite this iteration is bottom of call stack
// n = 3
// n = 2
// n = 1 this itteration is top of call stack
// n = 0  <-- base case reached...0 was never returned, 1 was, but 0 was printed anyway
// 24 <-- executed in reverse (top to bottom of call stack) ie. 1*2*3*4 not->4*3*2*1
```
n does drop to 0 (this base case) always ie 4,3,2,1,0 however what is returned is the sequence of call stacks
n = 0 returns f(0) = 1          <-- placed last to top of call stack
n = 1 returns f(1) = n * f(0) 
n = 2 returns f(2) = n * f(1) 
n = 3 returns f(3) = n * f(2) 
n = 4 returns f(4) = n * f(3)   <-- place first to bottom of call stack

#### fibonacci
```java
public static long getFibonacciRecursive(int n) {
    if (n <= 1) {
        return n;
    //could also do:
    // if (n == 0) return 0;
    // if (n == 1) return 1;
    }
    return getFibonacciRecursive(n - 1) + getFibonacciRecursive(n - 2);
}
public static long getFibonacciRecursive(int n) {
    if (n >= 2) {
        return getFibonacciRecursive(n - 1) + getFibonacciRecursive(n - 2);
    }
}
// fib #'s --> 0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144
// f(0) = 0 <--base case
// f(1) = 1 <--base case
// f(n) = f(n - 1) + f(n - 2) when n>=2  <-- recursive steps
```

#### selection sort
this is treated similar to a loop since it doesnt return anything, but the start of the "loop" starts at the top of the call stack.
```java
void main() {
    int[] myArray = {6, 7, 3, 2, 9, 4, 45, 65, 23, 34, 11, 55, 33, 88, 90, 67, 45, 78, 55, 22};
    selectionSort(myArray);
    System.out.println(myArray);
}
void selectionSort(int[] data) {//entry point since main() shouldn't need to know additional parameters
    selectionSort(data, 0, data.length - 1);//not recursion, simply calling an overloaded method
}
void selectionSort(int[] data, int low,  int high) {
    if (low < high) {//invisible base case
        int minPos = low;
        for (int scan = low + 1; scan <= high; scan++) {
            if (data[scan] < data[minPos]) {
                minPos = scan;
            }
        }
        int temp = data[low];
        data[low] = data[minPos];
        data[minPos] = temp;
        return selectionSort(data, low + 1, high);
    }
}
```
#### binary search
```java
boolean binarySearch(int[] data, search) {
    binarySearch(data, 0, data.length-1, search);
}
boolean binarySearch(int[] data, int low, int high, int search) {
    if (low > high) return false;

    int middle = (low + high) / 2;

    if (search == data[middle]) {
        return true;
    } else if (search > data[middle]) {
        return binarySearch(data, middle + 1, high, search);
    } else {
        return binarySearch(data, low, middle - 1, search);
    }
}
```
#### Tail Recursion
behaves similar to standard standard loop
call stack merely a vehicle to return the exact same result to to bottom, since result is alerady calculated at top of stack
```java
void main() {
    System.out.println(factorialTail(4));
}
long factorialTail(int n) {
    return factorialTail(n, 1);//initialized result=1
}
long factorialTail(int n, int result) {
    if (n == 0) {//base condition
        return result;//actual returned result
    }
    return factorialTail(n - 1, n * result);//increments result by * n...n is decremented by 1  <--tail recursive because ONLY itself was called ie. no n * f(x)
}
```
n = 0; result = 24
n = 1; result = 6 * 4 = 24 <-- if base condition was 1, would loop forever if n = 0...otherwise works when n is possitive
n = 2; result = 2 * 3 = 6
n = 3; result = 1 * 2 = 2
n = 4; result = 1

#### quicksort
```java
void quicksort(int[] data) {
    quicksort(data, 0, data.length - 1);
}
void quicksort(int[] data, int start, int end) {
    if (start < end) {
        int pivot = partition(data, start, end);//moves everything less to the left, greater to the right...then returns pivot index
        quicksort(data, start, pivot - 1);//sorts left of pivot
        quicksort(data, pivot + 1, end);//sorts right of pivot
    }
}
int partition(int[] data, int start, int end) {
    int middle = (start + end) / 2;
    int pivotValue = data[middle];

    //swap pivot(ie. middle) with start
    int temp = data[middle];
    data[middle] = data[start];
    data[start] = temp;

    int pivot = start;

    for (int scan = start + 1; scan <= end; scan++) {
        if (data[scan] < pivotValue) {
            pivot++;//update pivot
            //swap new pivot with scan
            temp = data[scan];
            data[scan] = data[pivot];
            data[pivot] = temp;
        }
    }
    //swap start with new pivot
    temp = data[pivot];
    data[pivot] = data[start];
    data[start] = temp;

    return pivot;
}
```

</details>

***
### data structers
<details><summary></summary>

#### linked lists
```java
public class LinkedList<E extends Comparable<? super E>> {
    private ListNode<E> head = new ListNode<>();
    private int size;

    public LinkedList() { this.size = 0; }

    public int getSize() { return this.size; }
    public boolean isEmpty() { return this.size == 0; }

    public void insert(E o) {
        ListNode<E> node = new ListNode<>(o);
        ListNode<E> current = head.next;
        ListNode<E> previous = head;

        //sorts list
        while (current != null && current.value.compareTo(o) < 0) {
            previous = current;
            current = current.next;//iterates to the next node
        }
        //inserts new node between previous and current node
        previous.next = node;
        node.next = current;
        this.size++
    }
    public void remove(E o) {
        ListNode<E> node = head.next;
        ListNode<E> previous = head;
        // 1. Check if node is null FIRST to avoid NullPointerException
        while (node != null && node.value.compareTo(o) != 0) {
            previous = node;
            node = node.next;
        }
        // 2. If node is null, we reached the end without finding 'o'
        if (node != null) {
            previous.next = node.next;
            this.size--; // Don't forget to decrement the size!
        } else {
            System.out.println("Element not found.");
        }
    }
    public void display() {
        ListNode<E> current = head.next;

        while (current != null) {
            System.out.println(current.value);
            current = current.next;
        }
    }
    public boolean find(E o) {
        ListNode<E> current = head.next;
        boolean found = false;

        while (current != null && !found) {
            if (current.value.compareTo(o) == 0) {
                found = true;
            } else {
                current = current.next;
            }
        }

        return found;
    }
    private class ListNode<E> {
        public E value;
        public ListNode<E> next;

        public ListNode() {}
        public ListNode(E o) {
            this.value = o;
        }
    }
}
```

#### Static Stacks
A LIFO data structure...under the hood a static stack is typically an array wrapped in a class for extra functionality (ie. overflow protection, variable to track last index of filled portion)


```java
public class StaticStack<E> {
    public E[] data;
    public int top = -1;

    public StaticStack(int maxSize) {
        this.data = (E[]) new Object[maxSize];
    }

    public void push(E v) throws Exception {
        if (isFull()) {
            throw new Exception("Stack is full")
        }
        top++;
        data[top] = v;
    }

    public E pop() throws Exception {
        if (isEmpty()) {
            throw new Exception("Stack is empty")
        }
        return data[top--];
    }

    public boolean isFull() {
        return this.top == this.data.length - 1;
    }
    public boolean isEmpty() {
        return top == -1;
    }
}
```
#### Dynamic stacks
A LIFO data structure. Structures similar to a linked list but points to previous node instead of newer
```java
public class DynamicStack<E> {
    private class StackNode<E> {
        public E value;
        public StackNode<E> previous;

        public StackNode(E v) {
            this.value = v;
        }
    }

    private StackNode<E> top;

    public boolean isEmpty() {
        return top == null;
    }

    public void push(E v) {
        StackNode<E> node = new StackNode<E>(v);
        node.previous = top;
        top = node;
    }
    public E pop() throws Exception {
        if (isEmpty()) {
            throw new Exception("Stack is empty");
        }
        top = top.previous;
        return top.value;
    }
}
```

#### Static Queues
A queue is a First In, First Out (FIFO) data structure.  Items are added at the back of a queue and removed from the front of a queue. 
```java
public class StaticQueue<E> {
    private E[] data;
    private int front;
    private int back;
    private int count;

    public StaticQueue(int size) {
        this.data = (E[])(new Object[size]);
        this.front = 0;
        this.back = 0;
        this.count = 0;
    }

    public boolean isEmpty() {
        return count == 0;
    }

    public boolean isFull() {
        return count == data.length;
    }
    //adds item to back of queue
    public void enqueue(E v) throws Exception {
        if (isFull()) {
            throw new Exception("Queue is full");
        }
        //wraps back of queue back to start of queue(static queues are circlular)
        if (back == (data.length - 1)) {
            back = 0;
        } else {
            back++;
        }

        data[back] = v;
        count++;
    }
    //returns front item value then removes same item from queue
    public E dequeue() throws Exception {
        if (isEmpty()) {
            throw new Exception("Queue is empty");
        }

        E result = data[front];
        if (front == (data.length - 1)) {
            front = 0;
        } else {
            front++;
        }

        count--;

        return result;
    }
}
```

#### Binary Search Trees
```java
public class BinarySearchTree {
    private class TreeNode {
        int value;
        TreeNode left;
        TreeNode right;

        public TreeNode(int value) {
            this.value = value;
        }
    }

    private TreeNode root;

    public void insert(int value) {
        if (root == null) {
            root == new TreeNode(value)
        } else {
            TreeNode parent = null;
            TreeNode node = root;
            while (node != null) {
                parent = node;
                if (node.value < value) {
                } else {
                    node = node.left;
                }
            }
            TreeNode newNode = new TreeNode(value);
            if (parent.value < value) {
                parent.right = newNode;
            } else {
                parent.left = newNode;
            }
        }
    }

    public boolean search(int value) {
        boolean found = false;
        TreeNode node = root;

        while (!found && node != null) {
            if (node.value == value) {
                found = true;
            } else if (node.value < value) {
                node = node.right;
            } else {
                node = node.left;
            }
        }

        return found;
    }
}
```
#### breath first search
* Would add the parent to a queueAnd then once it adds the children to a queue it can then remove the parent from the queueAnd then would add the grandchildren to the queue and then can remove the grandchildren Parents from the queue.
```java
public void printBFS(TreeNode root) {
    if (root == null) return;
    
    Queue<TreeNode> queue = new LinkedList<>();
    queue.add(root);

    while (!queue.isEmpty()) {
        TreeNode current = queue.poll();//removes head & points to next
        
        // PROCESS: Print when dequeued
        System.out.print(current.data + " "); 

        if (current.left != null) queue.add(current.left);
        if (current.right != null) queue.add(current.right);
    }
}
```
#### depth first search
* recursively checks both sides, However the stack would check all of one side first
##### In-Order Traversal (Left → Root → Right)
sticks to the left
Process the parent between visiting the left and right children.
Note: In a Binary Search Tree (BST), this visits nodes in sorted order.
```java
public void printInOrder(TreeNode node) {
    if (node == null) return;

    // 1. DIVE Left
    printInOrder(node.left);

    // 2. PRINT (Parent in the middle)
    System.out.print(node.data + " ");

    // 3. DIVE Right
    printInOrder(node.right);
}
```
##### Pre-Order Traversal (Root → Left → Right)
Print the parent, then "dive" into the children.
* usefull to rebuild tree
```java
public void printPreOrder(TreeNode node) {
    if (node == null) return;

    // 1. PRINT (Parent first)
    System.out.print(node.data + " ");

    // 2. DIVE
    printPreOrder(node.left);
    printPreOrder(node.right);
}
```
##### Post-Order Traversal (Left → Right → Root)
* Print all children before printing the parent.

```java
public void printPostOrder(TreeNode node) {
    if (node == null) return;

    // 1. DIVE Left and Right
    printPostOrder(node.left);
    printPostOrder(node.right);

    // 2. PRINT (Parent last)
    System.out.print(node.data + " ");
}
```
##### Deleting a node
To delete a node that has two children, solution is traverse to the farmost right node copy that where the deleted node was, if there was a child to the left of that rightmost node that will then also be reassigned to the previous parent. Note that when left node is is reassigned as the child of the previous parent it will most likely be added now as a right child. To replace the rightmost mode to the deleted node is actually just simply copying its value rather than the notice itself recycling the previously allocated memory.
```java
public void remove(int value) {
    TreeNode parent = null;
    TreeNode node = root;
    boolean done = false;

    // 1. Search for the node and its parent
    while (!done) {
        if (node == null) {
            return; // Value not found, exit method
        }

        if (node.value < value) {
            parent = node;
            node = node.right;
        } else if (node.value > value) {
            parent = node;
            node = node.left;
        } else {
            done = true; // Found the node to delete!
        }
    }

    // 2. Perform the deletion
    // Case A: The node has no left child (or is a leaf)
    if (node.left == null) {
        if (parent == null) {
            root = node.right;
        } else {
            if (parent.value < value) {
                parent.right = node.right;
            } else {
                parent.left = node.right;
            }
        }
    } 
    // Case B: The node has a left child
    else {
        TreeNode parentOfRight = node;
        TreeNode rightMost = node.left;

        // Find the in-order predecessor (largest in the left subtree)
        while (rightMost.right != null) {
            parentOfRight = rightMost;
            rightMost = rightMost.right;
        }

        // Replace the target node's value with the predecessor's value
        node.value = rightMost.value;

        // Clean up the moved predecessor node
        if (parentOfRight.right == rightMost) {
            parentOfRight.right = rightMost.left;
        } else {
            parentOfRight.left = rightMost.left;
        }
    }
}
```
</details>

***
### IO
<details><summary></summary>

#### file Scanner & PrintWriter 
* May create a `File` object from file path as constructor argument (does not open file but has methods to test if exists or empty)
* may open a file object with Scanner(File obj)
    *  when using  scanner methods such as nextLine(),  the cursor is moved to the beginning of the line
* The `PrintWriter` object takes either a file object or file path as constructor arg
    * PrintWriter will write over most recently scanned line since cursor is at beginning of line
* May use a try block to open files (Scanner and PrintWriter both open) and optionally catch errors (ie. FileNotFoundException or IOException) which then automatically closes file
</details>

***
### header
<details><summary></summary>

body
</details>

