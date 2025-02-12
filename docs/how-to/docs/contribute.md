# Contributing Guide

## mkdocs.yml

The mkdocs.yml file is where the site configuration is defined. It is where the theme is selected, extra CSS is provided, details about the site are defined, and contains the table of contents under nav:. 

## Adding Content

To add additional content create a markdown file inside an existing directory or create a new one as it makes sense for what is being added. Once the new markdown file is complete add it to the proper place in the nav: entry in mkdocs.yml. If no title is provided it will use the first header in the file. A custom title can be provided before the file name and the title and file name need to be separated by a colon. Sub-sections can be added by listing related pages together under a title page. Indentation is key to making sure everything is organized properly in to top level items and sub-sections.

## Testing

After making changes please test them by running the mkdocs serve command and viewing the new site locally. More details on this can be found in the Documentation Build page of this documentation. 