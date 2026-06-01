<details><summary>

### Strings
</summary>

* can create templates similar to f-strings in python
    * use the backtick with `$` before the `{}`
    ```js
    let myName = "Bob";
    console.log(`Hello ${myName}, how are you?`);
    ```
* use `()` for expresions when concatonating without using templates

* does support "" inside '' and vice versa like python
#### priting
```js
console.log("Hello, World!");
```
```html
<script src="test.js"></script>
```
</details>
<details><summary>

### variables
</summary>

* should not use `name` or `Name` since legacy code already uses it in the JS library
* variables are global between `.js` files since they are imported to the HTML file
    ```html
    <script src="file1.js"></script>
    <script src="file2 .js"></script>
    ```

* use `let` to assign variable
    * doesn't need it if reasigning var to new value
    * legacy alternitive is `var`
        * due to "hoisting" in JS (pre allocating memory for all variables) & the problem that `var` is function scoped instead of block scoped meaning they are not local to an if statement or for loop... they also don't give an error if used before defined since they are initianzed with `undefined` before value assingment which could be a bug if accidentally defined after it is used where `let` & `const` give a `ReferenceError` since they live in a "temporal dead zone" before they are defined 
    ```js
    let msg = "Hello world";
    ```

* use `const` instead for immutability
    ```js
    const MSG = "Hello world";
    ```

</details>
<details><summary>

### data types
</summary>

#### primitives
* `number` includes both decimals and whole numbers (may call methods due to auto boxing)
* `bigint` may be represented with an `n` at the end of a number (ie. `3232n`)
    * used for higher bit integers
* `boolean`
    * all primitives have a boolean value, NOTE! they do not actually return the boolean value, they return their own value
        * `null` → false
        * `undefined` → false
        * !number → false
        * `0` → false
        * (-∞, 0) U (0, ∞) → true
        * `""` → false
        * `"hello"` → true
</details>
<details><summary>

### arithmatic
</summary>

* use `/` for division
    * `//` is for comments
* use `Math.trunc()` for integer division

</details>
<details><summary>

### arrays
</summary>

* use `[]` for assingment ie. `let animals = ["ape", "bear", "cat", "dog"];`

* use `.pop()` to return and remove last value
* use `.push()` to add new value to last in array (returns new length of array)

* use `.shift()` to remove front value
* use `.unshift()` to add new value to the front

* use `.splice()` (does not return new array, instead moddies original)
    * arg 1 → start idx
    * arg 2 → number of idx's to remove **after** start idx (default → remaining idx's)
    * all other args are to add right after start idx (set arg 2 to 0 if not intending to remove anything)
    ```js
    let animals = ["ape", "bear", "cat", "dog"];
    animals.splice(2);// removes everything after bear
    animals.splice(2, 1);// removes only cat
    animals.splice(2, 0, "human", "bigfoot");// adds human and bigfoot after bear
    ```
* use `.slice()` (returns new array similar to python)
    * arg 1 → start idx to return
    * arg 2 → stop idx, not inclusive (default → remaining idx's)
</details>
<details><summary>

### objects
</summary>

* similar to python dictionaries
* good practice to make object a `const` since it only effects the variable name
* may use `delete` to delete a key
```js
const person = {
    personName: "Alice",
    age: 30,
    job: "Lawyer"
};
let key = "age";

let value = person[key];// ✅
value = person.key;// ❌ ERROR! not allowed pollymorphic access
value = person.age;// ✅

delete person.age;

let arrayLength = person.length;
```
#### classes
* `class` is syntactic sugar for `function`
    ```js
    function lamePerson(name) {//constuctor
        const person = {};
        person.myName = name;//property variable
        person.sayName = () => console.log(person.myName);//method
        return person//assumes `new` isn't used
    }
    function Person(name) {//constuctor
        this.myName = name;//property variable
        this.sayName = function() {console.log(this.myName);}//❌ not bound method
        this.sayName = () => console.log(this.myName);//✅ bound method
        // may add to prototype to save memory 
        // ie. this.prototype.sayName = () => console.log(this.myName);...however not bound to obj
    }
    class CoolPerson {
        constructor(name) {
            this.myName = name;
        }
        sayName() {
            console.log(this.myName);//❌ not bound
        }
        autoBoundSayName = () => console.log(this.myName);//✅
    }
    const person0 = Person("Greg");
    const person1 = new Person("Alice");
    const person2 = new CoolPerson("Bob");
    ```
    * the "class" or function may simulate an oop class by adding `new` before calling the function...while this may look similar to Java, actually a way to automattically create and return an object (similar to a dictionary)
* may simulate a method by making one of the properties a callback function
* may still use `this` to reference the object that is created and returned
    * only works if using `new` since `this` is the varriable name of the obj
* may create new properties to the class after definition using `prototype` between the class name and property → `className.prototype.newProperty = newValue/Function`
    * not needed if adding to a created object → `obj.newProperty = newValue/Function`
        * not recommended to add to only a single object since polymorphism is not enforced...better to add to the prototype
##### this
* this technically refers to the object that call the value/function of the proprety...however this breaks with `setTimeout` (ie. `setTimeout(person1.sayName, 1000`) since if it is used to delay a the method callback, the callback is added to the browser window object instead of its original obj the callback was stored in...meaning `this` no longer refers to the original obj breaking the simulated "oop"
    * this requires binding the method callback to the original obj
        1. can be done with `.bind(callBack)` 
            ```js
            setTimeout(person1.sayName.bind.(person1), 1000);
            ```
        2. may instead create a callBack to call the obj method
            ```js
            setTimeout(() => person1.sayName(), 1000);
            ```
        3. use big arrow functions to store the method call for the class, not `function` neither the prototype! See [classes](#classes) ...note, also works in higher order double big arrow funtions
            ```js
            setTimeout(person1.sayName(), 1000);//only works if `sayName` is just a variable to a big arrow callback
            ```
</details>
<details><summary>

### comparison & logic
</summary>

* supports short circuiting

* `===` → strict comparison
* `==` → loose comparison
* also still apply to `!==` and `!===`
* does NOT apply to `<=` & `>=`
    ```js
    10 == "10";// → true
    10 === "10";// → false
    null == undefined;// → true
    null === undefined;// → false
    ```
* `||` → OR (if **True** OR operator returns **FIRST TRUE** value from left to right due to short circuiting)
* `&&` → AND (if **True** AND operator returns value to the **RIGHT**)
* the the same if they are false, the logic operator would return the first value that made the expression false
    * side note, comparison operators still return boolean

</details>
<details><summary>

### loops
</summary>

* regular **for** loops behave and look exactly like a for loop in Java...only differance is the data type of `i` needs to be defined with `let`

* **for in** loops when used on an array are a mix between a for each loop and a regular loop...they prevent index out of bounds errors but still only return the index
    ```js
    const myArray = [10, 11, 12, 13, 14, 15]
     for (let i in myArray) {
        console.log(i);//would print 0, 1, 2, 3, 4, 5
     } 
    ```
    * NOTE! when used on an object they function like a regular for-each loop as each loop iterates each key
        1. Integer Keys: Any keys that can be parsed as non-negative integers are listed first, in ascending numeric order.
        2. String Keys: Normal string keys (like name, age, and job in your example) are listed next, in chronological order of creation.
        3. Symbol Keys: If there were any Symbols, they would come last, also in creation order.
    ```js
    const myObj = {
        name: "Alice",
        age: 40,
        job: "Professor"
    };

    for (let key in myObj) {//notice `let` is used
        console.log(key, myObj[key]);
    }
    ```

* **for of** loops only work on iterables
    * since objects are not iterable, could use a **for in** OR use the `Object.entries(myObj))` work-around
        * work-around also enables simultaneous iteration over both the key and the value
    * should always use `const` since value should not change mid iteration
    ```js
    const myObj = {
        name: "Alice",
        age: 40,
        job: "Professor"
    };

    for (const [key, value] of Object.entries(myObj)) {//notice `const` is used
        console.log(key, value);
    }
    ```
    * arrays do happen to be iterable
    ```js
    const myArray = [5, 4, 3, 2, 1, 0];

    for (const i of myArray) {
        console.log(i);
    }
    ```

* **while** and **do while** loops look and function the same as in Java
</details>
<details><summary>

### functions
</summary>

* parameters do not need to be pre defined with let or const
```js
function simpleCalc(value) {
    return avlue * 2;
}
```
#### function generator
```js
function funcGenerator(value) {//higher order fn
    function newFunction(num) {//call back fn
        return num * value;
    }
    return newFunction;
}
const tenTimes = funcGenerator(10);//call back becomes new fn from higher order fn
const twoTimes = funcGererator(20);
```
##### anonymous functions
* similar to a lambda that may also be named
```js
const myFunc = function (num) {return num * value;};
```
* can actually convert the call back fn, ie. `newFunction` into an anonymous fn
    ```js
    function funcGenerator(value) {
        return function (num) {//Notice that there is no name to the callback fn
            return num * value;
        };
    }
    const tenTimes = funcGenerator(10);//call back becomes new fn from higher order fn
    const twoTimes = funcGererator(20);
    ```
###### big arrow
* alternativly may use an `=>` arrow to create the fn
```js
const myFunc = (num) => {return num * value;};
```
* one more shortcut, may remove `{}` & `return` if all on one line
    * many also remove the `()` in the signature if only one parameter
    ```js
    const myFunc = num => num * value;
    ```
* ✅ final revision of the funcGenerator
```js
const funcGenerator = value => num => num * value;
```

#### spread operator
* may use `...obj` to pack all the arguments into the function... if there is too few args the missing arg will be `undefined`
```js
const person = ["Alice", 25, "Professor"];

function displayPerson(name, age, job) {
  console.log(`${name} is ${age} years old and is a ${job}`);
}

displayPerson(...person);
```

* may also use `...args` to unpack args when used as a parameter in a defined function
```js
const person = [1, 2, 3, 4, 5, 6];

function displayPerson(...args) {
    for (const arg of args) {//may loop through all the ... unpacked args
        console.log(arg);
    }
}
```

#### setTimeout()
* asynchronous fn
* args
    1. call back function
    2. delay in mill sec to execute fn
    3. optional: args to be passed into the fn
        * instead of manually entering the args, may instead generate a new fn that can inject them with `...args`
        * could just directly make a fn called `delayedHello` but then I would have to rewrite the logic for the setTimeout() blending the args with main call-back
        * by making a fn generator I can easily convert a fn like `printHello()` to become a delayed fn... of course I could also not generate any fn and just mix and match by wrapping a generic fn that can dely the fn... ie. `delay(printHello())`...the problem with this is that I have to wrap every fn I want to delay... if I have many more fn I want to wrap and/or , it would be better to genenate a pre-wrapped fn
        
        ```js
        //delay() returns a fn that injects the args into the callback fn
        function delay(callback, amount) {
            return (...args) => {//...args is "Alice"
                setTimeout(() => callback(...args), amount);
            }
        }

        function printHello(name) { console.log(`Hello, ${name}`); }
        function printGoodbye() { console.log("Goodbye"); }

        const delayedHello = delay(printHello, 3000);
        const delayedGoodbye = delay(printGoodbye, 1000);

        delayedHello("Alice");
        delayedGoodbye();
        ```
    
 
</details>
<details><summary>

### functional
</summary>

```js
let nums = [1, 2, 3, 5, 6, 8, 9, 10, 13, 16, 19, 20, 21, 22];

function findFirst(nums, predicate) {//the predicate is the conditional statement
    for (const num in nums) {
        if (predicate(nums[num])) {
            return num;
        }
    }
    return null;
}
//purpose to this is that it seperates the logic of scanning the arry and the actuall predicate logic
console.log(findFirst(nums, val =9> val % 2 === 0));//finds first even num
console.log(findFirst(nums, val => val > 10));//finds first num greater than 10
```
* this can be even further refined to scale when needing many parameters...in this case there is only 2 `findFirst(nums, predicate)`
    * may instead create a fn generator to seperate the parameters by generating a function that remembers the predicate so the `nums` may be added seperately.
    ```js
    function findFirstGenerator(predicate) {
        return function (nums) {
            for (const num in nums) {
                if (predicate(nums[num])) {
                    return num;
                }
            }
            return null;
        }
    }

    const firstEvenFn = findFirstGenerator(val => val % 2 === 0)
    const firstGreaterThanTenFn = findFirstGenerator(val => val > 10)
    
    let nums = [1, 2, 3, 5, 6, 8, 9, 10, 13, 16, 19, 20, 21, 22];

    console.log(firstEvenFn(nums));
    console.log(firstGreaterThanTenFn(nums));
    ```
</details>
<details><summary>

### debugging
</summary>

* may add a breakpoint with adding the line `debugger;`
    * may then hover my mouse over a variable to show the value...that or just see the values in "scope" on the side
</details>
<details><summary>

### header
</summary>

body
</details>
