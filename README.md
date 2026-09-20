# Homebrew Tap

Install Meta-Cortex after its first release:

```sh
brew install ai-ai-ai-ai-ai-ai-ai/tap/meta-cortex
```

Cargo-dist generates the formula and publishes it with the public Meta-Cortex
release. The Update Meta-Cortex workflow imports that formula hourly or on
manual dispatch, committing changes with this repository's GitHub Actions
token. No personal token or cross-repository write credential is needed.

Do not edit the generated formula manually. Homebrew installs the executable;
run `meta-cortex init` inside a project to install its `.meta-cortex/` framework.
