***
### Strings
<details><summary></summary>

#### priting
```js
console.log("Hello, World!");
```
```html
<script src="test.js"></script>
```
</details>

***
### varibles
<details><summary></summary>

variables are global between `.js` files since they are imported to the HTML file
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

***
### header
<details><summary></summary>

body
</details>
