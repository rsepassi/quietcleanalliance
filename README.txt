The Quiet Clean Alliance Website
-------------------------------------------------------------------------------

All site files are in site/.
To build the site, run:
  ./build.sh
The built site will be in public/.
You can upload public/ to the site host (e.g. Netlify).

To view it locally, run:
  ./serve.sh
Open a web browser and go to http://localhost:8000

build.sh inserts _header.html at the top of each page, and _footer.html at the
bottom.
_header.html contains the title, menu, and newsletter button.
_footer.html contains the email and copyright lines.

To edit an existing page:
  Open the html file in a text editor, edit the file, and save it.

To add a page:
  1. add a file to site/, e.g. site/mynewpage.html
  2. add the filename to the "files=" list in build.sh, e.g. mynewpage.html
  3. add a link to the page from somewhere,
     e.g. <a href="/mynewpage.html">Visit my new page</a>

-------------------------------------------------------------------------------

A tiny HTML tutorial

More documentation: https://developer.mozilla.org/en-US/docs/Web/HTML

HTML is a bunch of text in a certain format that web browsers understand.

Here's a simple HTML page:
<html>
  <h1>Hello world!</h1>
</html>

Things in those brackets, <>, are "tags".
Tags open, e.g. <html>, and they close, </html>.
Inside of tags you can put tags and text.
Tags can have "attributes", like the "href" attribute on the <a> tag:
    <a href="https://example.org">A link to example.org</a>

Here are the typical tags:
<p> is a paragraph of text
<a> is a link, the href attribute says where to go when clicked
<h1>, <h2>, ... are headers of decreasing size
<ul> is a bulleted list, with <li> as list items
<ol> is a numbered list, with <li> as list items
<button> is a button
<img> is an image, the src attribute says what image to display
<div> is a box that can contain other tags

Here's an HTML page that uses all those tags:
<html>
  <h1>Hello world!</h1>
  <p>
    A paragraph of text with
    <a href="https://example.org">a link to example.org</a>
  </p>
  <img src="https://picsum.photos/200" alt="an image"></img>
  <ul>
    <li>Bullet 1</li>
    <li>Another bullet</li>
  </ul>
  <button>A button</button>
</html>

CSS is a bunch of text in a certain format that tells the web browser how to
style the HTML content. You can put CSS within HTML using the <style> tag.

For CSS documentation: https://developer.mozilla.org/en-US/docs/Web/CSS

-------------------------------------------------------------------------------

Questions

Does every website need a build.sh step?
  No. A website can just be a single HTML file. Here we use a build.sh (which
  is called a "shell script") to "templatize" our many HTML files. That is,
  instead of copying the header and footer to every file, we just have them
  in one place (_header.html and _footer.html) and then make the final HTML
  files in build.sh.

-------------------------------------------------------------------------------
For help, contact Ryan Sepassi at rsepassi@gmail.com
