### Higher order Functions
```python
msg = "Hello World"
def send_data(data_fn, data):
    data_fn(data)

send_data(print, msg)
```

### Decorators

Allows encapsulation of higher order function, revealing only the callback function (ie. base function)

```python
from time import time, sleep
from random import randint

def timer(base_fn):# <-- custom decorator
    def enhanced_fn():# <-- timer(base_fn)
        start_time = time()
        base_fn()# <-- brewing functions
        print(f"took {round(end_time - start_time, 4)} seconds")
    return enhanced_fn

def loading():
    for _ in range(3):
        print(".", end="", flush=True)
        sleep(1)

def brew_tea():# <-- base function
    print("Brewing tea", end="")
    print("\n...Tea is ready!", end=loading())

timer(brew_tea)()
#alternativly
enhanced_fn = timer(brew_tea)
enhanced_fn()

@timer
def brew_coffee():
    print(f"brewing coffee", end="")
    loading()
    print("\n...Coffee is ready!")

brew_coffee()
# alternativly
enhanced_fn = brew_coffee
enhanced_fn()
```

#### Adding parameters to base function
must modify signature of enhanced function signature to include `*args` and `**kwargs`
* `*args` packs all arguments of base function into a tupple ie. `enhanced_fn(*args)`
    * breaks when keyword arguments used ie. `optional_paramer = 5`
* use `**kwargs` which packs keyword arguments into a dictionary
    ```python
    def timer(base_fn):
        def enhanced_fn(*args, **kwargs):
            start_time = time()
            base_fn(*args, **kwargs)
            print(f"took {round(end_time - start_time, 4)} seconds")
        return enhanced_fn
    ```
    * breaks again when base_fn has return value
        * capture return value of base_fn then return value ie. `result`
        ```python
        def timer(base_fn):
            def enhanced_fn(*args, **kwargs):
                start_time = time()
                result = base_fn(*args, **kwargs)
                print(f"took {round(time() - start_time, 4)} seconds")
                return result
            return enhanced_fn
        ```

### final example
```python
from time import time, sleep
from random import randint

def timer(base_fn):
    def enhanced_fn(*args, **kwargs):
        start_time = time()
        result = base_fn(*args, **kwargs)
        print(f"{base_fn.__name__:<18} --> {time() - start:.8f} seconds")
        return result
    return enhanced_fn

def loading(time: int):
    for _ in range(time):
        print(".", end="", flush=True)
        sleep(1)

@timer
def brew(drink: str, time: int = 3) -> str:
    print(f"brewing {drink}", end="")
    loading(time)
    return f"{drink} is ready!"

brew("tea")#does NOT print "Tea is ready!"
print(brew("coffee", time=5))#DOES print "coffee is ready"
```
### lambdas w/map vs callback w/map vs native comprehension

```python
from time import time

def timer(base_fn):
    def enhanced_fn(*args, **kwargs):
        start = time()
        result = base_fn(*args, **kwargs)
        runtime = f"{base_fn.__name__:<16} --> {time() - start:.8f} seconds"
        return f"{runtime} ---> {result}"
    return enhanced_fn

var1 = [
    ["espresso", 5, 20],
    ["water", 7, 45],
    ["tea", 10, 12],
    ["beer", 2, 99],
    ["wine", 8, 33]
]

def yuck(x):# <-- callback function
    if x[0] == "beer":
        return ["yuck"] + x[1:]
    return x
def no_water(x):
    return x[0] != "water"

@timer
def callBack_w_map(var1):
    return list(map(yuck, filter(no_water, var1)))

@timer
def lamba_w_map(var1):
    return list(map(lambda i: ["yuck"] + i[1:] if i[0] == "beer" else i,
                filter(lambda i: i[0] != "water", var1)))
@timer
def comprehension(var1):
    return [["yuck"] + i[1:] if i[0] == "beer" else i for i in var1 if i[0] != "water"]

@timer
def standard_loop(var1):
    copy = []
    for i in var1:
        if i[0] == "water":
            continue
        elif i[0] == "beer":
            copy.append(["yuck"] + i[1:])
        else:
            copy.append(i)


print(callBack_w_map(var1),
      lamba_w_map(var1),
      comprehension(var1), 
      standard_loop(var1),
      sep="\n")
```
