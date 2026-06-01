<details><summary>

### HTML structure
</summary>

* check out https://w3schools.com/tags/ for comprehesive list of tags
    ```html
    <!DOCTYPE html><!-- tells browser the code is html5 complient -->
    <html>
        <head></head>
        <body></body>
    </html>
    ```

### head
* most all meta-data contained here
* adding `<title></title>` will show in the browser tab...note that this must be inside `<head></head>`
    * by default the title is the name of the html file
    ```html
    <head>
        <title>browser tab title</title>
    </head>
    ```

### body
* add `<p></p>` to add paragraph text
* add `<h1></h1>` to add header text
* both `<p>` & `<h1>` have a space above and below & on a new line
    ```html
    <p>paragraph text</p>
    <h1>header text</h1>
    ```

* `<span>` & `<div>` do not have a space
    * `<div>` also on new line
    * `<span>` does NOT put on a new line

* elements are traditionally categorized as either "block-level" or "inline"
    * Block-level (div, p, aside): These elements always start on a new line and take up the full width available (stretching out to the left and right as far as they can).
    * Inline (span, small): These elements do not start on a new line and only take up as much width as necessary for their content. They usually live inside block-level elements (like a `<span>` inside a `<p>`)
#### lists
```html
<ol><!-- orderd displays as numbered-->
    <li>Orange</li><!-- list item -->
    <li>Apple</li>
    <li>Banana</li>
</ol>
<ul><!-- un-orderd...displays as bullet pointed -->
    <li>Orange</li>
    <li>Apple</li>
    <li>Banana</li>
</ul>
```
##### drop down list
* use `<select>...the_list...</select>`
    * use `<option>new element</option>`
    * default selection may be overwidden with `selected`
    ```html
    <select id="fruits">
        <option>Orange</option>
        <option selected>Apple</option>
        <option>Banana</option>
    </select>
    ```
* add an event listener of type `"change"` to recogize the selection...get it??
    * the **Event obj's** `.target.value` property is the content value of the selection
    ```js
    document.getElementById("fruits").addEventListener("change", e => {
    console.log(e.target.value);//prints name of the selected fruit
    });
    ```
* may override the value of the content from users visual list, like an ID
    ```html
    <select id="fruits">
        <option value="1">Orange</option><!-- target.value would then be "1" -->
        <option selected value="2">Apple</option>
        <option value="3">Banana</option>
    </select>
    ```

#### tables
```html
<table>
    <thead><!-- defines the header section -->
        <tr><!-- table row -->
            <th>Name</th><!-- table header cell, usually bold and centered by default -->
            <th>Phone #</th>
            <th>Email</th>
        </tr>
    </thead>
    <tbody><!-- main body content -->
        <tr>
            <td>Alice Jones</td><!-- table data cell -->
            <td>111-111-1111</td><!-- new col -->
            <td>alice@usu.edu</td>
        </tr>
    </tbody>
</table>
```
##### `colspan="n"`
* for `<th>` or `<td>` may increase deault column span
    ```html
    <td colspan="2">two collumns</td>
    <td>one collumn</td><!-- will be pushed to the right because of the 2col <td> -->
    ```

#### div
##### images
* use self closing `<img>` tag with `src` to the file path and `alt` for assisted reading compliance
```html
<img id="usu-image" src="usu-background.jpg" alt="Old Main at Sunset" />
```
* to avoid distorting aspect ratio of image, use `auto` on which ever property is not set (ie. `width` or `height`)

* may inject image using css instead of html
    * use `cover` to maintain aspect ratio of picture when resizing window (NOTE adds more images to fill white space)
          * to avoid duplicating image, may instead modify the `height` to equall `100vh`
    ```css
    body {
        background-image: url("usu-background.jpg");
        background-size: cover;
        height: 100vh;
    }
    ```
        * may instead use `contain` instead of `cover` along with using setting the height to `100vh` however this has the same effect of cover without modifying the height as it will also duplicate the image to fill the white space
            * note that without setting the height for `cover` will result in tiny tiny images if used on body since the height for body is by default zero if nothing inside the body element
    * **srolling** in either case, the image will scroll with the text inside the div, to lock the image, set `overflow` to `auto` and `height` to `100%` for the element
        * may also set `overflow` to `scroll` which may force a scroll bar to apear even when not scolling (depending on browser)
        * set to `hidden` if intended to prevent scrolling
        ```css
        body {
            background-image: url("usu-background.jpg");
            background-size: cover;
            height: 100vh;
        }
        #text-div {/*text-div is just an ID name*/
            height: 100%;
            overflow: auto;
        }
        ```
##### input
* may use `<input type="text"/>`
    * self closing..ie no closing tag
    * optional types:
        * `"text"`
        * `"button"` ← different from a `<button></button>`
        * `"checkbox"`
        * `"password"`
        * `"radio"` ← can't be unchecked, looks like a multiple choice question bubble
        * `"email"` ← looks identical to text, but helps password manangers

* to add surrounding text to also be interactabe, must wrap the text in a `<label for="id">`...`"id"` being the `id` of the input
    ```html
    <input id="one" type="checkbox"/>
    <label for="one">Apple</label><!-- makes this also clickable -->
    ```
* alternativly may nest the input and text inside the same label to avoid ID matching
    ```html
    <label>
        <input type="checkbox" />
        Apple
    </label>
    ```
###### radios (with names, classes, and defaults)
* to allow only only one radio to be selected → give all the radios the same `name`
* may also add `checked` to pro select one of them
* adding a `class` becomes useful to listen for them
    ```html
    <div>
        <label><!-- wrapping in a label allows the text to be selected -->
            <input class="radioGroup" id="1" name="customName" type="radio" />
            One
        </label>
    </div>
    <div>
        <label>
            <input class="radioGroup" id="2" name="customName" checked type="radio" /><!-- appears pre selected -->
            Two
        </label>
    </div>
    <div>
        <label>
            <input class="radioGroup" id="3" name="customName" type="radio" />
            Three
        </label>
    </div>
    ```
* getting all the elements by class returns an array of each radio
    ```js
    const radios = document.getElementsByClassName("radioGroup");
    for (const radio of radios) {
        radio.addEventListener("change", e => console.log(e.target.id));
    }
    ```
###### forms
* buttons when used in a form submit the input values to the URL, also requires a `name` to submit
    * use `e.preventDefault()` if not wanting to submit everything by default to the URL
    * getting the element by the form ID allows just a single event obj that each form input stored the `e.target` property ie `e.target.password.value`
    * may use `form.reset()` to reset back to default values
    ```html
    <form id="myForm">
        <div>
            Username: <input type="text" name="customName1" />
        </div>
        <div>
            Password: <input type="password" name="customName2" />
        </div>
        <button>Submit by default</button><!-- no button type submits -->
        <button type="button">Won't Submit</button><!-- "button" button type submits -->
        <button type="submit">Submit</button><!-- "submit" button type submits -->
    </form>
    ```
    ```js
    const form = document.getElementById("myForm");

    form.addEventListener("submit", e => {
        e.preventDefault();//remove if wanting to submit
        console.log("Form Submitted for username:", e.target.customName1.value);
        form.reset();
    });
    ```

</details>
<details><summary>

### scripts
</summary>

* use `<script src="test.js"></script>` to load JS
    * may use in either the head or body
    * should use `defer` to load the script after the html is loaded ie. `<script src="test.js" defer></script>`
</details>
<details><summary>

### the DOM
</summary>

* to retrieve html, the object class name is `document` along with any class attributes such as the body
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
    * then use the `.getElementById()` method
    ```js
    const span1 = document.getElementById("customTagName");
    console.log(span1):
    ```
* may also use `getElementsByClassName("exampleClass")`
    * returns an array of all the objects of that class
#### nodes vs elements
* elements are tags incuding inputs
    * use `.parentElement` to get parent elements
    * use `.children` to get the child elements as an array
* nodes are also tags but also the text within the tags...comments are also nodes
    * use `.parentNode` to get parent nodes
    * use `.childNotes` to get child nodes as an array
    ```html
    <head>
    <script src="demo.js" defer></script>
    </head>
    <body>
    <div id="grandparent">
        <div id="parent-1">
            Parent 1
        </div>
        <div id="parent-2">
            Parent 2
            <span id="child">
                Child
            </span>
        </div>
    </div>
    </body>
    ```
    ```js
    const parent1 = document.getElementById("parent-1");
    const parent2 = document.getElementById("parent-2");

    // Get parent element
    console.log("parentElement")
    console.log("parent1:", parent1.parentElement);
    console.log("parent2:", parent2.parentElement);

    // Get parent node
    console.log("parentNode")
    console.log("parent1:", parent1.parentNode);
    console.log("parent2:", parent2.parentNode);

    // Get children elements
    console.log("children (elements)")
    console.log("parent1:", parent1.children);
    console.log("parent2:", parent2.children);

    // Get children nodes
    console.log("childNodes")
    console.log("parent1:", parent1.childNodes);
    console.log("parent2:", parent2.childNodes); 
    ```
* may remove elements using `.remove()` on the element object
</details>
<details><summary>

### event loop
</summary>

#### Event Listeners
* use `.addEventListener()` method from the input object
    * param1: type
    * param2: callback fn
* other types include:
    * `"click"` → triggered after clicked and released
        * `"mousedown"` → triggered after mouse release
        * `"mouseup"` → triggered at initian mouse click
        * `"mouseenter"` → triggered the moment the mouse enters the radius
        * `"mouseleave"` → triggered when the mouse leaves the radius
        * `"mousemove"` → triggered all the time
    * `"focus"` → triggered once when clicked in a text box
    * `"blur"` → triggered once after no longer focused ie. clicked outside
    * `"input"` → triggered each time text changes
    * `"change"` → triggered once if a change is recognized when moving out of focus compared

#### Event obj
* when the call-back has one parameter instead of zero, a Event obj is passed into the call-back which may be be logged
    * conventionally uses `e`
    * includes a bunch of data about the event
    ```js
    //test.js
    const button1 = document.getElementById("click-me");
    function sayHello(e) { //`e` is the Event obj
        console.log(e);
        console.log("Button was clicked");
    }
    button1.addEventListener("click", sayHello);
    ```
#### button → console
* use `<button></button>` to create a button...more flexible since it is a container
    ```html
    <head>
        <script src="test.js" defer></script>
    </head>
    <body>
        <button id="click-me">Click Me!</button>
    </body>
    ```
* then combine with `.addEventListener()` method on the button object
    * param1: type `"click"`
    * param2: callback fn ie. `sayHello`
* may instead also set the call-back to the `.onclick` attribute
    ```js
    //test.js
    const button1 = document.getElementById("click-me");
    function sayHello() {
        console.log("Button was clicked");
    }

    button1.addEventListener("click", sayHello);//most similar to other languages
    
    //alternate method
    button1.onclick = sayHello;
    ```
* ❌ could also directly call the fn in the html, but it is not recomended 
    ```html
    <button id="click-me" onclick="sayHello()">Click Me</button>
    ```
#### input → button → output to console
* in the button call-back, use `.value` attribute to get contents of input box
    ```html
    <head>
        <script src="test.js" defer></script>
    </head>
    <body>
        <div>
            <input id="user-input" type="text" />
            <button id="submit-button">YELL!</button>
        </div>
    </body>
    ```
    ```js
    const input = document.getElementById("user-input");
    const button = document.getElementById("submit-button");
    function shout() {
        const text = input.value;
        const yellText = text.toUpperCase();
        console.log(yellText + "!!");
    }
    button.addEventListener("click", shout);
    ```
#### input → button → ouput to empty div
* use `.innerHTML` attribute to set the output to
    * may also inject html in the string
    ```html
    <head>
        <script src="test.js" defer></script>
    </head>
    <body>
        <div>
            <input id="user-input" type="text" />
            <button id="submit-button">YELL!</button>
        </div>
        <div id="output"><!-- the empty div -->
        </div>
    </body>
    ```
    ```js
    const input = document.getElementById("user-input");
    const button = document.getElementById("submit-button");
    const output = document.getElementById("output");//the empty div
    button.addEventListener("click", () => {
        const text = input.value;
        const yellText = text.toUpperCase() + "!!";
        output.innerHTML = `<strong>${yellText}</strong>`;//outputs string as bold ie. <strong>
    });
    ```
#### mouse click position → output to empty div
    ```html
    <head>
        <script src="test.js" defer></script>
    </head>
    <body style="width: 100vw; height: 100vh; background-color: gray; margin: 0;"><!-- this just enforced the body to extend the entire screen -->
        <div id="output"></div>
    </body>
    ```
    ```js
    const output = document.getElementById("output");

    document.body.addEventListener("mousemove", e => {
        output.innerHTML = `x: ${e.offsetX}, y: ${e.offsetY}`;
    })
    ```
* `.screenX`
* `.clientX`
* `.offsetX`
#### output to new tag
* use `document.createElement("TYPE HERE")` to create a tag object
    * like above examples, use `innerHTML` and set to new value
    * types: 
        * `"span"`
        * `"div"`
        * `"label"`
        * `"input"`
            * must then assing the input a type ie. "checkbox"
            ```js
            const myCheckbox = document.createElement("input");
            myCheckbox.type = "checkbox";
            ```
* use `.appendChild()` to determine order and put together...the creation of new tags are child tags to a pre-exesting tag
    * use `.prepend()` if wanting to add to top instead of bottom
* if wanting to add an event listener to a new input that is dynamically created, I must then put a an EventListener inside the main EventListener that made the new tag with type `"change"`...in the case of a task/to-do list, the value would then have to be captured from the input value and stored in the main EventListener
* to add a unique id to each new tag, may store a global counter variable ie. `checkbox.id = counter++`
```html
<head>
    <script src="test.js" defer></script>
</head>
<body>
    <div>
        <label>
            <div>Enter task</div>
            <input id="task-input" type="text" />
            <button id="save-button">Save</button>
        </label>
    </div>
    <div id="tasks"><!-- placeholder for new child tags to inject -->
    </div>
</body>
```
```js
/*
...this is the html to inject
<div>
    <label>
        <input id="task" type="checkbox">
        <span>Do Something Good</span>
    </label>
</div>
*/

const input = document.getElementById("task-input");
const saveButton = document.getElementById("save-button");
const taskList = document.getElementById("tasks");//empty div to inject new tags
let counter = 1;

saveButton.addEventListener("click", () => {
    const newSpan = document.createElement("span");
    const task = input.value;//captured value for the child EventListener
    newSpan.innerHTML = task;
    const newDiv = document.createElement("div");
    const newLabel = document.createElement("label");
    const checkbox = document.createElement("input");
    checkbox.id = `task-${counter++}`;
    checkbox.type = "checkbox"; // Manually set the type

    checkbox.addEventListener("change", (e) => {
        if (e.target.checked) {//the change would happen whenever it is checked or unchecked
            console.log(`Task ${task} is complete`);
        } else {
            console.log(`Task ${task} is now pending`);
        }
    });

    // Put it all together
    newLabel.appendChild(checkbox);
    newLabel.appendChild(newSpan);
    newDiv.appendChild(newLabel);
    taskList.appendChild(newDiv);
});
```
##### improved
* instead of creating a new element for each child tag then having to then stitch it all together, could just create a single element with all the child tags and html already present
    ```js
    const input = document.getElementById("task-input");
    const saveButton = document.getElementById("save-button");
    const taskList = document.getElementById("tasks");//empty div to inject new tags
    let counter = 1;

    saveButton.addEventListener("click", () => {
        const task = input.value;
        const newDiv = document.createElement("div")
        const newDiv.innerHTML(`
            <label>
                <input id="task-${counter}" type="checkbox">${task}
            </label>
        `);

        taskList.appendChild(newDiv);
        //cut off short
    ```

* this can be improved to allow for other tags other than just a div to be created...solution would be to still create a div element but only as a placeholder, add the innerHTML and then return only the `.firstElementChilt` of the div, effectivly discarding it. Most effective way to do this is a wrapper function.
    ```js
    const input = document.getElementById("task-input");
    const saveButton = document.getElementById("save-button");
    const taskList = document.getElementById("tasks");//empty div to inject new tags
    let counter = 1;

    function elementFromHTML(htmlString) {
        const wrapper = document.createElement("div");//the div is discarded to avoid hard coding it
        wrapper.innerHTML = htmlString;
        return wrapper.firstElementChild;//discards the above div
    }

    saveButton.addEventListener("click", () => {
        const task = input.value;
        const newDiv = elementFromHTML(`
        <div>
            <label>
                <input id="task-${counter}" type="checkbox">${task}
            </label>
        </div>
        `);

        taskList.appendChild(newDiv);
        //cut off short
    ```
* must still add an event listener to the checkbox however in this case there was never an HTML element object that was created for the checkbox (only the new div) to add an EventListener to.
    * must first add the div to the documend to then get the checkbox element by ID 
        ```js
        taskList.appendChild(newDiv);//added to the document
        const checkbox = document.getElementById(`task-${counter}`);
        
        checkbox.addEventListener("change", (e) => {
            if (e.target.checked) {//the change would happen whenever it is checked or unchecked
                console.log(`Task ${task} is complete`);
            } else {
                console.log(`Task ${task} is now pending`);
            }
        });
        counter++;
        ```
    * alternativly, if desired to get the ID before adding to the document, must then use `.querySelector("#TASK-ID")` on the div element that was created but not yet added to the documend. NOTE that the `#` is needed for the `.querySelector()` to find the ID. 
        ```js
        const checkbox = newDiv.querySelector(`#task-${counter}`);

        checkbox.addEventListener("change", (e) => {
            if (e.target.checked) {//the change would happen whenever it is checked or unchecked
                console.log(`Task ${task} is complete`);
            } else {
                console.log(`Task ${task} is now pending`);
            }
        });
        taskList.appendChild(newDiv);//added to the document
        counter++;
        ```
###### ✅ final result
    ```js
    const input = document.getElementById("task-input");
    const saveButton = document.getElementById("save-button");
    const taskList = document.getElementById("tasks");//empty div to inject new tags
    let counter = 1;

    function elementFromHTML(htmlString) {
        const wrapper = document.createElement("div");//the div is discarded to avoid hard coding it
        wrapper.innerHTML = htmlString;
        return wrapper.firstElementChild;//discards the above div
    }

    saveButton.addEventListener("click", () => {
        const task = input.value;
        const newDiv = elementFromHTML(`
        <div>
            <label>
                <input id="task-${counter}" type="checkbox">${task}
            </label>
        </div>
        `);

        const checkbox = newDiv.querySelector(`#task-${counter}`);

        checkbox.addEventListener("change", (e) => {
            if (e.target.checked) {//the change would happen whenever it is checked or unchecked
                console.log(`Task ${task} is complete`);
            } else {
                console.log(`Task ${task} is now pending`);
            }
        });
        taskList.appendChild(newDiv);//added to the document
        counter++;
    });
    ```
</details>
<details><summary>

### CSS
</summary>

* use `<link rel="TYPE" href="fileName.css" />` to import the CSS file in header
* types
    * `"stylesheet"`
#### element references
* element names → reference the tag name
    ```html
    <body></body>
    ```
    ```css
    body {
        /*style changes here*/
    }
    ```
* classes → reference the class name with a `.` period before
    ```html
    <div class="large"></div>
    ```
    ```css
    .large {
        /*style changes here*/
    }
    ```
* ID's → reference the ID with a `#` before it
    ```html
    <div id="first"></div>
    ```
    ```css
    #first {
        /*style changes here*/
    }
    ```
#### styles
* `background-color` → values: hex, rgb(), or named color
* `color` → applies only to the element contents
    * 🌐 **Reference**: [pallete gererator](https://coolors.co)
    * note: `#0F2439` is Aggie Blue
* `background` → values: same as above
* `font-size` → either a single number ie. `12` or a specific pixel size ie. `32px`
    * `em` in cases of ie. `1.25em` meas 1.5x the default value (the parent element's size)..`<h1>`, `<h2>`, ect. all use `em` for sizing
    * `rem` means reletive to the root element ie. `<html>`
* `border` → all values go on one line ie. `border: 2px solid black;`
    * **style**:(required) common values: `solid`, `dashed`, `dotted`, and `double`
    * **thickness**: ie. `5px`, `thin`, `medium`, `thick`
    * **color**: same values as background-color
* `border-radius` → dictates pixel size to round corners
* `margin` → (outside border) same values as font-size ie. `32px` or `12`
* `padding` → (inside border) same values as margin
* `display` → may convert element to a block ie. `display: block`
* `font-family` → may select a new font in order of priority (maybe the browser doesn't support a specific font)
    ```css
    div {
        font-family: 'Franklin Gothic Medium', 'Arial Narrow', Arial, sans-serif;
    }
    ```
    * 🌐 **Reference**: [remote fonts](https://fonts.google.com)
    * may define new font familie using the `@font-face` selector
    ```css
    @font-face {
        font-family: MyCustomFontName;         
        src: url("path/to/font.ttf");/*usually a .ttf file*/
    }
    body {
        font-family: MyCustomFontName, sans-serif;
    }
    ```
* `background-image` → may incude image or gradient
    * use `linear-gradient()` the angle and pallete of colors ie. `
        * optional param1(default is top to bottom): the angle ie. `90deg` → left to right...or `to left` → also left to right8
        * remaining params: colors in palette
        ```css
        span {
            background-image: linear-gradient(to bottom, red, green, blue, white, blue);
        }
        ```
    * `radial-gradient()` → starts from center outward
        * params same as linear minus the degrees
        * optional param: `cicle` instead of smashed oval ie. `radial-gradient(cicle, red, green, blue, white, blue)`
* **font gradient** → inject background to transparent text 
    ```css
    span {
        background-image: linear-gradient(90deg, red, blue, green, white);
        color: rgb(0, 0, 0, 0);
        background-clip: text;
        -webkit-background-clip: text;
    }
    ```
###### positioning
* `position` → use `relative` mode to move relative to default position
* may adjust position then with only (`top` OR `bottom`) and/or  (`left` OR `right`)
    * `top: 25px` moves down 25 pixels
    * `bottom: 25px` moves up 25 pixels
    * `left: 25px` moves right 25 pixels
    * `right: 25px` moves left 25 pixels
    ```css
    #position-me {
        padding: 16px;
        background-color: blueviolet;
        position: relative;
        top: 25px;
    }
    ```
* `position` → use `absolute` to position directly instead of moving
    * NOTE that the "window" is reletive to the most direct **absolute** parent element...if none then default is the body
    * may use both `left` AND `right` if disired to stretch element
        ```css
        #bar-at-top {
            padding: 16px;
            background-color: blueviolet;
            position: absolute;
            top: 0px;
            left: 0px;
            right: 0px;
        }
        ```
* `position` → use `fixed` to prevent scrolling...is fixed to the screen instead of a parend element
    * to prevent layering issues, either:
        1. prioritize the fixed element last in the html
        2. set the Z axis value using `z-index`...use negative #'s to place back, use positive to move forward
            * does also work with `absolute` and `relative`
        ```css
        #bar-at-top {
            padding: 16px;
            background-color: blueviolet;
            position: fixed;
            top: 0px;
            left: 0px;
            right: 0px;
            z-index: 9999;
        }
        ```
##### flexbox
* may use `display: flex` on parent element to manipulate child elements
* `justify-content`: (note that start and end refer to the end of the axis, the start may not be on the left or right if axis is flipped)
    * `center` → centers
    * `flex-end` → right justify(unless the flex-direction is reversed)
    * `flex-start` → default value...justifies left(unless the flex-direction is reversed)
    * `space-between` → auto positions accross major axis with even gaps (no need for `gap` unless wanting a forced minimum gap)...first and last element positioned without a margin
    * `space-evenly` → similar to spacing between, however space is evenly including the outer sides of first and last element
    * `space-around` → similar to space evenly however the "even" space is assinged to each child element withou overlap of space...meaning that the elements on the far ends may have half the space applied
* `gap`: use pixel count, `em`, or `%`...default is zero
* `flex-wrap`: set to `wrap` to wrap last elements around...set to `wrap-reverse` to wrap the first elements
* `flex-direction`: sets direction (**major axis**)...set to `column` for vertical allingment...default is `row` (horizontal)
    * NOTE on justication, if set to vertical (ie. `column`) it may not be properly justified since parent element may not fill screen...use `height: 100vh`
    * may also do reverse versions of either one ie. `row-reverse` or `column-reverse`...this doesn't just flip the order, it also starts at the other end of the axis
* `align-items`: note that `align-items` is not always horizontal, if `flex-direction` is set to `row` then `align-items` would apply the perpendicular axis (**minor axis**)
    * `center` → if wanting to have column stacked with the direction and still centered horizotaly since center justify would only work in the direction the `flex-diriction` is pointed
    * `flex-start` →  Items align to the top(or left) of the container.
    * `flex-end` →  Items align to the bottom(or right) of the container.
    * `baseline:` → Items display at the baseline of the container.
    * `stretch:` → Items are stretched to fit the container.
* `align-content`→ sets how multiple lines are spaced apart from each other. This property takes the following values:
    * `flex-start`: Lines are packed at the top of the container.
    * `flex-end`: Lines are packed at the bottom of the container.
    * `center`: Lines are packed at the vertical center of the container.
    * `space-between`: Lines display with equal spacing between them.
    * `space-around`: Lines display with equal spacing around them.
    * `stretch`: Lines are stretched to fit the container.
    * NOTE `align-content` determines the spacing between lines, while `align-items` determines how the items as a whole are aligned within the container. When there is only one line, `align-content` has no effect.
* `flex-flow` → short hand for `flex-direction` and `flex-wrap`...just combine the values ie. `column wrap` 
```css
body {
    display: flex;
    justify-content: center;
    flex-direction: column;
    height: 100vh;
    align-items: center;
}
```
###### child boxes
* may use `flex` to size each child element using a ratio ie. 1:2:1 = 100%
    ```css
    .small-div {
        flex: 1;
    }
    .large-div {
        flex: 2;
    }
    ```
* may manually asign `order` with any integer value (-2, -1, 0, 1, 2) 
    * by default, EVERY element gets zero at the same time...agigning it -1 just moves to the left a bit
* `align-self` → takes same values as `align-items`
##### variables
* may define a variable using `--customName` in the `:root` selector
    * use `var()` to reference the variable
    ```css
    :root {
        --custom-color: (rgb(123, 90, 20));
    }
    body {
        background: var(--custom-color);
    }
    ```
#### selectors
Selectors are powerful tools to apply CSS styling rules based on HTML element types, relationships, states, or attributes.

##### 1. Basic Selectors
Select elements directly by tag, class, ID, or globally.
* **Element / Tag Name Selector**: Selects all elements with the specified tag name.
  ```css
  p {
      /* Styles all <p> elements */
  }
  ```
* **ID Selector**: Selects a single element with a specific `id` attribute. Prefix with `#`.
  ```css
  #my-id {
      /* Styles the element with id="my-id" */
  }
  ```
* **Class Selector**: Selects all elements with a specific `class` attribute. Prefix with `.`.
  ```css
  .my-class {
      /* Styles all elements with class="my-class" */
  }
  ```
* **Universal Selector**: Selects every element on the page. Use `*`.
  ```css
  * {
      /* Styles all elements */
  }
  ```
* **Grouping Selector**: Applies styles to multiple selectors simultaneously. Separate with a comma `,`.
  ```css
  h1, h2, #my-id {
      /* Styles all <h1>, <h2>, and the element with id="my-id" */
  }
  ```
* 🌐 **Reference**: [MDN Basic Selectors](https://developer.mozilla.org/en-US/docs/Learn_web_development/Core/Styling_basics/Basic_selectors)

##### 2. Combinator Selectors
Select elements based on their relationships to other elements.
* **Descendant Combinator (space)**: Matches all descendant elements nested inside a parent element (at any level: children, grandchildren, etc.).
  ```css
  div p {
      /* Styles all <p> elements that are descendants of a <div> */
  }
  ```
* **Child Combinator (`>`)**: Matches only elements that are immediate, direct children of the parent element.
  ```css
  div > p {
      /* Styles only <p> elements that are direct children of a <div> */
  }
  ```
* **Adjacent Sibling Combinator (`+`)**: Selects the first matching element placed immediately after another element under the same parent.
  ```css
  div + p {
      /* Styles the first <p> element that immediately follows a <div> */
  }
  ```
* **General Sibling Combinator (`~`)**: Selects all matching sibling elements that follow another element under the same parent.
  ```css
  div ~ p {
      /* Styles all <p> elements that are siblings and appear after a <div> */
  }
  ```
* 🌐 **Reference**: [W3Schools CSS Combinators](https://www.w3schools.com/css/css_combinators.asp)

##### 3. Pseudo-Class Selectors
Select elements based on a temporary or specific state (e.g., hover states).
* **Syntax**: Use a single colon `:` between the selector and the pseudo-class.
  ```css
  selector:pseudo-class { }
  ```
* **Example (`:hover`)**: Applies styles when the mouse pointer is hovering over the element.
  ```css
  p:hover {
      /* Styles applied when hovering over a <p> */
  }
  ```
* 🌐 **References**: [W3Schools CSS Pseudo-classes](https://www.w3schools.com/css/css_pseudo_classes.asp) | [Full Pseudo-Class List](https://www.w3schools.com/cssref/css_ref_pseudo_classes.php)

##### 4. Pseudo-Element Selectors
Style a specific part of an element's content (such as the first letter, first line, or generated content).
* **Syntax**: Use two colons `::` between the selector and the pseudo-element.
  ```css
  selector::pseudo-element { }
  ```
* **Example (`::first-line`)**: Applies styles to the first line of text within the element.
  ```css
  p::first-line {
      /* Styles the first line of all <p> elements */
  }
  ```
* 🌐 **References**: [W3Schools CSS Pseudo-elements](https://www.w3schools.com/css/css_pseudo_elements.asp) | [Full Pseudo-Element List](https://www.w3schools.com/cssref/css_ref_pseudo_elements.php)

##### 5. Attribute Selectors
Select elements based on the presence or exact value of their HTML attributes.
* **Presence (`[attribute]`)**: Matches elements with the specified attribute, regardless of its value.
  ```css
  a[target] {
      /* Styles all <a> tags that have a target attribute */
  }
  ```
* **Exact Match (`[attribute="value"]`)**: Matches elements with the exact specified attribute value.
  ```css
  a[target="_blank"] {
      /* Styles <a> tags with target attribute set to "_blank" */
  }
  ```
* 🌐 **Reference**: [W3Schools CSS Attribute Selectors](https://www.w3schools.com/css/css_attribute_selectors.asp)

##### 6. Quick Reference Table
| Selector          | Category                     | Targets                                         |
|-------------------|------------------------------|-------------------------------------------------|
| `div p`           | Descendant Combinator        | Any `<p>` inside a `<div>`                      |
| `div > p`         | Child Combinator             | Direct child `<p>` of a `<div>`                 |
| `div + p`         | Adjacent Sibling Combinator  | The next immediate `<p>` after a `<div>`        |
| `div ~ p`         | General Sibling Combinator   | Any `<p>` after a `<div>` under the same parent |
| `a:hover`         | Pseudo-class                 | Element based on its current state (hovered)    |
| `p::first-letter` | Pseudo-element               | A specific part of the content (first letter)   |
| `*`               | Universal Selector           | Every element on the DOM                        |
| `#header`         | ID Selector                  | The single element with `id="header"`           |
| `.nav-item`       | Class Selector               | Any element with `class="nav-item"`             |
| `[disabled]`      | Attribute Selector (Presence)| Any element with a `disabled` attribute         |
| `[type="submit"]` | Attribute Selector (Exact)   | Elements with the exact attribute value         |
| `h1, h2, p`       | Grouping Selector            | All listed elements simultaneously              |
</details>
<details><summary>

### header
</summary>

body
</details>
