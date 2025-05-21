index:
	pandoc -s -f markdown+smart --metadata pagetitle="WG21 Proposals" --to=html5 index.md -o index.html
