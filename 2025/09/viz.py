from matplotlib import pyplot as plt
import numpy as np
from sys import stdin
import re

lines = stdin.readlines()
xs = []
ys = []
for line in lines:
    m = re.match(r"(\d+),(\d+)", line)
    if not m:
        break
    x, y = [int(num) for num in m.groups()]
    xs.append(x)
    ys.append(y)

colors = np.linspace(0, 1, len(xs))

plt.scatter(xs, ys, c=colors, cmap="plasma")
plt.show()
