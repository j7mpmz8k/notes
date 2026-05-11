<details><summary>

### HTML structure
</summary>

* check out https://w3schools.com/tags/ for comprehesive list of tags
    ```html
    <!DOCTYPE html>`tells browser the code is html5 complient`
    <html>
        <head></head>
        <body></body>
    </html>
    ```

#### head
* most all meta-data contained here
* adding `<title></title>` will show in the browser tab...note that this must be inside `<head></head>`
    * by default the title is the name of the html file
    ```html
    <head>
        <title>browser tab title</title>
    </head>
    ```

#### body
* add `<p></p>` to add paragraph text
* add `<h1></h1>` to add header text
* both `<p>` & `<h1>` have a space above and below & on a new line
    ```html
    <body>
        <p>paragraph text</p>
        <h1>header text</h1>
    </body>
    ```

* `<span>` & `<div>` do not have a space
    * `<div>` also on new line
    * `<span>` does NOT put on a new line

* elements are traditionally categorized as either "block-level" or "inline"
    * Block-level (div, p, aside): These elements always start on a new line and take up the full width available (stretching out to the left and right as far as they can).
    * Inline (span, small): These elements do not start on a new line and only take up as much width as necessary for their content. They usually live inside block-level elements (like a <span> inside a <p>).

##### div
###### input
* may use `<input type="text"/>` inside a <div>
    * self closing
    * optional types:
        * `"text"`
        * `"button"` ← different from a `<button></button>`
        * `"checkbox"`
        * `"password"`
        * `"radio"` ← can't be unchecked, looks like a multiple choice question bubble
        * `"email"` ← looks identical to text, but helps password manangers

</details>
<details><summary>

### scripts
</summary>

* use `<script src="test.js"></script>` to load JS
    * may use in either the head or body
    * should use `defer` to load the script after the html is loaded ie. `<script src="test.js" defer></script>`

#### the DOM
* to retreive html, the object class name is `document` along with any class attributes such as the body
    ```js
    console.log(document.body);
    ```
* to get contents from specific tags, use the `.getElementsByTagName()` method
    * gets ALL tags of same tag in an html collection (looks like an array)
    ```js
    const spansContent = document.getElementsByTagName("span");
    console.log(spansContent);
    ```
* to get a specific tag, may include an `id` in the html tag
    ```html
    <span id="customTagName">
        hello world
    </span>
    ```
    * then use the `.getElementsById()` method
    ```js
    const span1 = document.getElementsById("customTagName");
    console.log(span1):
    ```
* may also use `getElementsByClassName("exampleClass")`
    * returns an array of all the objects of that class

#### event loop
* use `<button></button>` to create a button...more flexible since it is a container
    ```html
    <body>
        <button id="click-me">Click Me!</button>
    </body>
    ```
    * then combine with `.addEventListener()` method from the button object
        * param1: type `"click"`
        * param2: callback fn ie. `sayHello`
    ```js
    const button1 = document.getElementsById("click-me");
    function sayHello() {
        console.log("Button was clicked");
    }
    button1.addEventListener("click", sayHello);
    ```

</details>
<details><summary>

### header
</summary>

body
</details>
