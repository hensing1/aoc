from pulp import LpProblem, LpMinimize, LpVariable, const

prob = LpProblem("da buttons", const.LpMinimize)
x = LpVariable("x", lowBound=0, cat=const.LpBinary)
