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
