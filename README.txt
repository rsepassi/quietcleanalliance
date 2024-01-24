The Quiet Clean Alliance Website

All site files are in site/.
To build the site, run:
  ./build.sh
The built site will be in public/.
You can upload public/ to the CDN (e.g. Netlify).

The site is a collection of html pages.
_header.html is automatically inserted at the top of each page.
  It contains the title, menu, and newsletter button.
_footer.html is automatically inserted at the bottom of each page.
  It contains the email and copyright lines.

To edit an existing page, open the html file in a text editor, edit the file,
and save it.

To add a page:
  1. add a file to site/, e.g. site/mynewpage.html
  2. add the filename to the "files=" list in build.sh, e.g. mynewpage.html
  3. add a link to the page from somewhere,
     e.g. <a href="/mynewpage.html">Visit my new page</a>
