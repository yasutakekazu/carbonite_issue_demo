# CarboniteIssueDemo

This repository was created to reproduce the issue reported in [Carbonite Issue #120](https://github.com/bitcrowd/carbonite/issues/120).

It demonstrates the problem where a `Carbonite.Transaction` created in a fixture setup persists into subsequent tests, leading to incorrect transaction metadata in update operations.

## To start your Phoenix server:

  * Run `mix setup` to install and setup dependencies
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix