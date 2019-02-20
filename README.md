# A Beautiful Start (to a new paper)

This is a repository for getting started writing academic papers and other content (e.g., grants) using Markdown.  The goal is to provide a common and simplified workflow which also aid in distraction free writing, organized work flows, while avoiding too much of the hassles with working in raw LaTeX.

The goals I had when setting this up were:

1. *Maximum flexibility* -  esp reguarding output (uses pandoc so can output PDF or Microsoft .docx)
1. *Simplicity* - messing with a lot of boiler place LaTeX is a pain
1. *Quick access to references while writing* - plugings for sublime enable inserting references seamlessly while writing 
1. *Repeatability/standardization* - want everyone in the lab to consider this method to simpify writing
1. *Distraction free writing* - Uses themes and the "distraction free" writing mode in Sublime to help you concentrate
1. *Features useful to academics* - Uses some special modes for academic writing using markdown.

Ultimately the set up is inspired by the paper writing workflow set up by Alex Rich (@alexsrich) for his dissertation projects in my lab and [this blog post by ericmlj](http://www.ericmjl.com/blog/2016/6/22/tooling-up-for-plain-text-academic-writing-in-markdown/).


### Install `pandoc`

`pandoc` is the package which converts between a variety of different text formats including markdown -> (latex, word, etc...).  To install use a system package manager like homebrew.  You also want to install `pandoc-fignos` and `pandoc-citeproc`.  After installed type `which pandoc` to figure out there the system installed these tools as you will need to have them available.

### You need a .bib file

References should be managed in LaTeX using BibTeX files (.bib).  Many tools exist for helping you with this including plain text tools as well as fancy things like Mendeley or (now defuct but possibly coming back) Papers.  There isn't an easy answer to this but my recommendation is to keep one, global reference list for all your work.  BibTex will search through the file easily and at most you will have in the 1,000s of entries probably.  If you start making a separate .bib file for every project you start getting conflicting cite-keys, you fix a reference in one file and it isn't propogated out to the others.  Save yourself some trouble and let everyone in your lab or group use the same global file that is collectively edited for consistency, quality, and completeness.  You need to know the exact path to that file on your system to configure the editor below (e.g., `/path/to/master/library.bib`).

One approach I have yet to work out is to put the lab's global bibtex file into github and then include it as a submodule for each paper or project.
This way even after a paper is published if the lab's global bibtex file was updated then the new citation information would propogate through.

### You want to customize your Sublime Text environment

You can probably do a lot of this in other editors including the amazing Atom editor.  However, sublime and Atom share much in common, and I've sort of become entrenched to sublime for some reason.

You will want to install the following packages:

1. [Package Control](https://packagecontrol.io/installation) - needed to manage packages
1. [CiteBibTex](https://packagecontrol.io/packages/CiteBibtex) - a tool to let you easily cite things while writing
1. [AcademicMarkdown](https://packagecontrol.io/packages/AcademicMarkdown) - some special markdown features for academic writing.
1. [PackageSync](https://packagecontrol.io/packages/PackageSync) - keep the packages up to date
1. [WordCount](https://packagecontrol.io/packages/WordCount) - shows a word and character count at the bottom on the screen

Some optional ones are:
1. [Pandoc](https://packagecontrol.io/packages/Pandoc) - lets you run pandoc directly inside sublime with some keyboard commands
1. [BracketHighlighter](https://packagecontrol.io/packages/BracketHighlighter) - a fancier way to highlight brackets than the built-in one.
1. [Git](https://packagecontrol.io/packages/Git) - lets you use git directly in sublime
1. [GitGutter](https://packagecontrol.io/packages/GitGutter) - i'm not sure what this does but i bet it is great if you like git and subversion



### User Interface

Sublime has a "Distraction Free Writing Mode", under the `View` menu.  When combined with the two panel side-by-side layout you can have something like your outline/notes and your main manuscript open at the same time which is a pretty nice way to work.  It is quite different from the perferred editor set up for doing programming.

### Writing

At the top of you file is a header section written in YAML that lets you enter some meta data including info about authors, affiliations, abstract, etc...
Specifically, the format of what we start with is above is:

```markdown
---
title: A Beautiful Start to a (CogSci) Paper
author: Someone and Todd M. Gureckis
affiliation: New York University
bibliography: library.bib
header-includes:
- \usepackage{soul}
- \usepackage{color}
- \usepackage{cogsci}
- \usepackage{apacite}
geometry: margin=1in
abstract: "Put the abstract here"
---
```

which is a good start for a cogsci template.  You can use alternatiave packages and stuff as needed.  More details on what metadata can be stored in the headers can be found on the [Pandoc README](http://pandoc.org/README.html).

### Pandoc Markdown Cheat Sheet

See [here](https://github.com/dsanson/Pandoc.tmbundle/blob/master/Support/doc/cheatsheet.markdown)

### Citations in Pandox Markdown

Citations are done in Markdown by inserting:

```markdown
   [@citekey]
```

where the `citekey` is automatically generated by Papers, usually in the form of `LastName:YYYY[2- or 3-letter hash]`. An example of what gets inserted is `[@Young:2013px]`. 

There are a variety of way to cite things in pandoc:

- `@Einstein1905` -- Einstein et al. (1905)
- `[@Einstein1905]` -- (Einstein et al., 1905)
- `[see @Einstein1905, pp. 23-42]` -- (see Einstein et al., 1905, pp. 23-42)
- `Einstein was right [-@Einstein1905]`` -- Einstein was right (1905)

If you have installed the *CiteBibTex* as here:

Find the corresponding configuration fields, and change them to the following (making appropriate changes):

```json
    "bibtex_file": "/path/to/master/library.bib",
```
```json
    "autodetect_citation_style": true,
```

then you can press F10 on your keyboard to pull up a searchable index of the papers in your `library.bib`.  This means no need to go back and forth between your library manager software and the text window making some types of writing a bit smoother.


### Building the LaTeX and PDF files

There are a couple of ways to do this.  The link above provides and example of a `pandoc` library for sublime text.  

However, I prefer a more traditional makefile system.  This repository includes a file that will build PDF and LaTeX version of the file and can easily be extended to build a Microsoft Word version.

You can also insteall the [Shell Exec](https://packagecontrol.io/packages/Shell%20Exec) package for sublime and within a few keycommands (and without switching to your terminal) you can run the `make` command yourself and build things.


### Continually rebuilding when the file changes

To continually build the files whenever you save the .mdown file using the makefile system install `fswatch` via homebrew and add a file called `~/.config/fish/functions/watchmake.fish`
containing the following:
```
function watchmake
   fswatch -o $argv | xargs -n1 -I{} make
end
```

then type `watchmake manuscript.mdown` at the fish command prompt.