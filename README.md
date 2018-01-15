# criticalis
The purpose of this project is to create a platform to enable everyone to contribute to the improvement of popular works in the public domain. 

## Kinds of Improvements
### Corrections
Specifically, the correcting of older works where a computer generated version (using Optical Character Recognition) may have made mistakes due to peculiarities in language and printing styles.

Contributers may reference the original documents, but many of these errors are self evident.

### Explanations
Many aging works contain phrases, spellings, and references that today are at best, meaningless, and at worst, confusing. The community would be helped to see a simple footnote explaining these things or providing references for further study.

## How it works
The basic idea is nothing less than a very simplified interface for version control, like GitHub, but focused on texts. It needs to be simplified for the kinds of people that are best suited to making these corrections or comments. From the merely interested to world renown experts, rarely would they also be familiar with all the ins and outs of setting up 'git' on their system, cloning, branching, submitting pull requests, etc. This should all be as seamless as a social media platform where users can comment and press an up or down arrow to show approval (or disapproval).

The current concept is to provide the public domain version of the text to the reader, in a format which they may also use as a regular etext reading platform. The reader can then easily reference a particular location or set of words, and offer the corrective, along with explanatory notes. 

Other contributers should be able to see the recommendation and either approve or disapprove, and interact with the one submitting the change. In this way the community can self-govern after a fashion.

The curator of the work will be the one who decides if the corrective will make the cut, and the 'community improved' version will be the result.

The format will be html, and contained in epub format. More on this as I explore the capabilities and requirements.
    It needs to support, at a minimum, highlighting, and hyperlinks for referencing footnotes and whatnot.

## The way ahead
This project will use a favorite text of mine as the initial "subject." "The Treasury of David" is an original exposition and commentary on the book of Psalms by C. H. Spurgeon, composed in seven volumes, published in the late 19th century.

### Digestion / Implementation Notes / Examples (this is a living document)
The ePubs will need to be decompressed and possibly formatted in such a way as to ensure workable 'chunks' can be selected and changed, as in Git. I'll likely attempt to find an ePub reader already implemented, open source, and modify it to allow for good referencing of chunks. 

As an example for what we are working with, Psalm 1 begins on **page 20** of the file **The_Treasury_of_David-I.pdf**: and looks like this:

<img src="images/example1.PNG?raw=true" width="600" alt="example-pdf-1"/>

The ePub version (**The_Treasury_of_David-I.epub**) is rendered like so: 

<img src="images/example2.PNG?raw=true" width="600" alt="example-ePub-1"/>

And, inside the ePub, the xml file (**content-0012.xml**) shows this starting on line **1078**:


```xml
    <div class='flow' style=''>
      <a class='page' id='GBS.PA1'></a>
      <div id='block.18.1.0.box.179.412.1310.1953.q.60' class='gtxt_body'>
        <a id='GBS.PA1.w.1.0.0'></a>
        <p class='gtxt_body' style='font-size:102%;text-align:center;' id='para.18.1.0.box.693.412.296.38.q.60'>PSALM I.</p>
        <a id='GBS.PA1.w.1.1.0'></a>
        <p class='gtxt_body' style='font-size:102%;text-indent:1em;' id='para.18.1.1.box.192.485.1294.163.q.60'>TrTLE.&#8212;
          <span style='font-style:italic;'>This </span>
          <span style='font-style:italic;'>Psalm </span>
          <span style='font-style:italic;'>may </span>
          <span style='font-style:italic;'>be </span>
          <span style='font-style:italic;'>regarded </span>
          <span style='font-style:italic;'>as </span>
          <span style='font-variant:small-caps;'>The </span>
          <span style='font-variant:small-caps;'>Preface </span>
          <span style='font-variant:small-caps;'>Psai.m, </span>
          <span style='font-style:italic;'>leaving </span>
          <span style='font-style:italic;'>in </span>
          <span style='font-style:italic;'>it </span>
          <span style='font-style:italic;'>a </span>
          <span style='font-style:italic;'>notifica</span>
          <span style='font-style:italic;'>tion </span>
          <span style='font-style:italic;'>of </span>
          <span style='font-style:italic;'>the </span>
          <span style='font-style:italic;'>contents </span>
          ....
                    <span style='font-style:italic;'>up </span>
          <span style='font-style:italic;'>a </span>
          <span style='font-style:italic;'>divine </span>
          <span style='font-style:italic;'>sermon. </span>
        </p>
        <a id='GBS.PA1.w.1.2.0'></a>
        <p class='gtxt_body' style='font-size:102%;text-indent:1em;' id='para.18.1.2.box.192.650.1294.164.q.60'>
          <span style='font-variant:small-caps;'>Division.</span>&#8212;
          <span style='font-style:italic;'>This </span>
          <span style='font-style:italic;'>Psalm </span>
          <span style='font-style:italic;'>consists </span>
          <span style='font-style:italic;'>of </span>
```

and it goes on like that. This excerpt shows how the first two paragraphs were assembled and the kind of thing we are dealing with.

The ideal situation would allow for a tap or a click on a word, and the selection of a phrase if wanted, and that being able to be modified and pushed back into the xml to simple change spelling.wording/punctuation -- or to add footnotes/references (which may require something more).


## Public References (If I have obtained a downloaded copy, as available, they will be #[found here]() in this repository as well)
- The main source I retrieved the books from
    - #[Volume 1](https://books.google.com/books?id=XRZVAAAAYAAJ)
    - #[Volume 2](https://books.google.com/books?id=JeFJAAAAMAAJ)
    - #[Volume 3](https://books.google.com/books?id=bF4VAAAAYAAJ)
    - #[Volume 4](https://books.google.com/books?id=XdFJAAAAMAAJ)
    - #[Volume 5](https://books.google.com/books?id=jYcXAAAAYAAJ)
    - #[Volume 6](https://books.google.com/books?id=BtJJAAAAMAAJ)
    - #[Volume 7](https://books.google.com/books?id=s0EJAQAAIAAJ)
- The ePub version in this repository (OCR)
    - #[Volume 1](sources/The_Treasury_of_David-I.epub)
    - #[Volume 2](sources/The_Treasury_of_David-II.epub)
    - #[Volume 3](sources/The_Treasury_of_David-III.epub)
    - #[Volume 4](sources/The_Treasury_of_David-IV.epub)
    - #[Volume 5](sources/The_Treasury_of_David-V.epub)
    - #[Volume 6](sources/The_Treasury_of_David-VI.epub)
    - #[Volume 7](sources/The_Treasury_of_David-VII.epub)
- The PDF version from which the ePub was derived 
    - #[Volume 1](sources/The_Treasury_of_David-I.pdf)
    - #[Volume 2](sources/The_Treasury_of_David-II.pdf)
    - #[Volume 3](sources/The_Treasury_of_David-III.pdf)
    - #[Volume 4](sources/The_Treasury_of_David-IV.pdf)
    - #[Volume 5](sources/The_Treasury_of_David-V.pdf)
    - #[Volume 6](sources/The_Treasury_of_David-VI.pdf)
    - #[Volume 7](sources/The_Treasury_of_David-VII.pdf)


