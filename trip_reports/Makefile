# Find all markdown files in the current directory
MD_FILES := $(wildcard *.md)
# Generate target names by substituting .md with .html
HTML_FILES := $(MD_FILES:.md=.html)

# Default target to build all HTML files
all: $(HTML_FILES)

# Pattern rule to convert .md to .html
%.html: %.md
	pandoc -s -f markdown+smart --metadata pagetitle="Trip Report" --to=html5 $< -o $@

# Phony target to avoid conflicts with files named 'all' or 'clean'
.PHONY: all clean

# Clean up generated files
clean:
	rm -f $(HTML_FILES)
