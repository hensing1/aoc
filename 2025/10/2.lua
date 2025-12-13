#! /home/hensing1/code/python/.env/bin/python
# shhhhh

from scipy.optimize import milp, LinearConstraint
import numpy as np
import fileinput
import re


def read_input():
    lines = [line.rstrip() for line in fileinput.input() if line != "\n"]
    machines = []
    button_pattern = re.compile(r"\(([\d,]+)\)")
    joltage_pattern = re.compile(r"{([\d,]+)}")
    for line in lines:
        buttons = []
        for button_str in re.findall(button_pattern, line):
            buttons.append([int(n) for n in button_str.split(",")])
        joltage_str = re.findall(joltage_pattern, line)[0]
        joltage = [int(n) for n in joltage_str.split(",")]
        machines.append((buttons, joltage))
    return machines


machines = read_input()

total = 0
for machine in machines:
    buttons, joltage = machine
    c = np.ones(len(buttons))
    A = np.zeros((len(joltage), len(buttons)))
    for i, button in enumerate(buttons):
        for j in button:
            A[j, i] = 1
    lower = np.array(joltage)
    upper = np.array(lower)
    constr = LinearConstraint(A, lower, upper)
    integ = np.ones_like(c)

    result = milp(c=c, constraints=constr, integrality=integ)
    total += np.sum(result.x)

print(int(total))
