year ?= 2025
day ?= 3
part ?= nil
test ?= true

AOC:
	swift run AOC --year $(year) --day $(day) --part $(part) --test $(test)