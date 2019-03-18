all:
	pandoc -s manuscript.mdown --filter pandoc-fignos --bibliography=library.bib -o paper.pdf
	pandoc -s manuscript.mdown --filter pandoc-fignos --bibliography=library.bib --natbib -o paper.tex
	pandoc -s manuscript.mdown --filter pandoc-fignos --bibliography=library.bib -o paper.docx
	open -a Skim paper.pdf

