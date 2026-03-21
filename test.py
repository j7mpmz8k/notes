from time import time, sleep
from random import randint

def timer(base_fn):
    def enhanced_fn(*args, **kwargs):
        start_time = time()
        result = base_fn(*args, **kwargs)
        print(f"took {round(time() - start_time, 4)} seconds")
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
