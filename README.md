# Herb Demo

A minimal Rails app that shows the new Herb template engine catching broken
HTML in ERB templates, and a `bin/rails herb:check` step in `bin/ci`.

It is the companion code for the Code With Rails post:

**[Catch Broken HTML Before Deploy with Rails' New Herb Template Engine](https://codewithrails.com/blog/rails-herb-catch-broken-html/)**

> Herb support is on Rails `main` (slated for 8.2) but not yet in a released
> version, so this app's `Gemfile` points `rails` at the GitHub `main` branch
> ([#58552](https://github.com/rails/rails/pull/58552),
> [#58721](https://github.com/rails/rails/pull/58721),
> [#58770](https://github.com/rails/rails/pull/58770)). Swap that for a version
> once 8.2 ships.

## Branches

- `main` has the fixed templates. `bin/rails herb:check` passes.
- `broken` has the three broken partials from the post. `bin/rails herb:check`
  fails, but `bin/rails test` still passes.

## Run it

```bash
bundle install
bin/rails db:setup   # create, migrate, and seed
bin/rails server
```

Then open http://localhost:3000 to see the project list.

## Try the check

```bash
bin/rails herb:check
# All HTML+ERB templates compile through Herb. All is good!

git checkout broken
bin/rails herb:check
# app/views/projects/_project.html.erb:
#   [source]:3:3: Opening tag `<div>` at (3:3) doesn't have a matching closing tag `</div>` in the same scope.
# ...
# 3 HTML+ERB templates failed to compile through Herb.
```

On the `broken` branch, visit http://localhost:3000 to see the
`ActionView::SyntaxErrorInTemplate` error for the unclosed `<div>`.

To run the full CI, including the Herb step:

```bash
bin/ci
```

## Files to look at

- `app/views/projects/_project.html.erb` (the unclosed `<div>`)
- `app/views/shared/_status_badge.html.erb` (closing tags in the wrong order)
- `app/views/shared/_flash.html.erb` (ERB output in attribute position, fixed with `tag.attributes`)
- `config/ci.rb` (the `Templates: Herb` step)
- `test/integration/projects_test.rb` (passes on both branches, because the test
  database has no projects and the partial is never rendered)
