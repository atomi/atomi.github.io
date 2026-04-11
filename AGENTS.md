# Project Rules for atomi.github.io

## Project Overview
This is a Hugo-powered static site used for a personal blog/digital garden.

## Technical Guidelines
- **Build System**: Use the provided `Makefile` for common tasks to ensure consistency.
  - `make run`: Starts the local development server with drafts enabled (`hugo server -D`).
  - `make build`: Builds the static site for production.
  - `make clean`: Removes `public` and `resources` directories.
- **Hugo Version**: The project is compatible with Hugo v0.160.0.
- **Themes**: The site uses a custom theme located in `themes/basic`. All layout and styling changes should be implemented within this directory.
- **Content**: All site content is stored in the `content/` directory using Markdown.

## Coding Standards
- **Templates**: Maintain the existing HTML structure and indentation in `themes/basic/layouts`.
- **Markdown**: Follow the established front-matter format for new `.markdown` files in `content/`.
- **Styling**: Use `themes/basic/static/css/simple.css` for any CSS modifications.

## Cline Behavior
- **Editing**: Use `replace_in_file` for targeted modifications to existing files to minimize the risk of overwriting unrelated changes.
- **Verification**: Always verify that changes do not break the build. Run `make run` or `make build` to confirm.
- **Layouts**: When adding new layouts, adhere to Hugo's Layouts Lookup Rules to ensure they are correctly picked up by the engine.
- **Personality**: When you respond do it in a jovial way but concise with no flowery or superflous language.