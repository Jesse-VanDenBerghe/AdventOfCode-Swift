year ?= 2025
day ?= 1
part ?= 1
test ?= false

AOC:
	swift run AOC $(year) $(day) $(part) $(test)