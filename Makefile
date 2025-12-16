year ?= 2025
day ?= 2
part ?= nil
test ?= false

AOC:
	swift run AOC --year $(year) --day $(day) --part $(part) --test $(test)