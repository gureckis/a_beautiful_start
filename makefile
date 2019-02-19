all:
	# pandoc -s notes.md --bibliography=library.bib -o notes.pdf
	pandoc -s manuscript.mdown --filter pandoc-fignos --bibliography=library.bib -o paper.pdf
	pandoc -s manuscript.mdown --filter pandoc-fignos --bibliography=library.bib -o paper.tex
	open -a Skim paper.pdf
