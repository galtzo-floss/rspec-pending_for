# Changelog

[![SemVer 2.0.0][📌semver-img]][📌semver] [![Keep-A-Changelog 1.0.0][📗keep-changelog-img]][📗keep-changelog]

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog][📗keep-changelog],
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html),
and [yes][📌major-versions-not-sacred], platform and engine support are part of the [public API][📌semver-breaking].
Please file a bug if you notice a violation of semantic versioning.

[📌semver]: https://semver.org/spec/v2.0.0.html
[📌semver-img]: https://img.shields.io/badge/semver-2.0.0-FFDD67.svg?style=flat
[📌semver-breaking]: https://github.com/semver/semver/issues/716#issuecomment-869336139
[📌major-versions-not-sacred]: https://tom.preston-werner.com/2022/05/23/major-version-numbers-are-not-sacred.html
[📗keep-changelog]: https://keepachangelog.com/en/1.0.0/
[📗keep-changelog-img]: https://img.shields.io/badge/keep--a--changelog-1.0.0-FFDD67.svg?style=flat

## [Unreleased]

### Added

- kettle-jem-template-20260729-005 - Gemspec metadata now publishes this
  project's RubyForum tag as `mailing_list_uri`, and support docs link to the
  tagged RubyForum community alongside Discord.

### Changed

### Deprecated

### Removed

### Fixed

- kettle-jem-template-20260729-002 - VersionGem bootstrap now preserves
  and templates dedicated `version_gem.rb` entrypoints even when the gemspec
  dependency is intentionally omitted, and generated anonymous-loader specs
  cover both `version.rb` and `version_gem.rb`.

- kettle-jem-template-20260729-003 - Old-Ruby gems below the VersionGem runtime
  floor now get managed minimal `version.rb` files and anonymous-loader version
  specs without adding `version_gem`.
- kettle-jem-template-20260730-001 - Gemspec package file enumeration now runs
  relative to the gemspec directory, so packaged template assets are included
  even when the gemspec is loaded from another working directory.

### Security

## [0.1.24] - 2026-07-28

- TAG: [v0.1.24][0.1.24t]
- COVERAGE: 100.00% -- 100/100 lines in 6 files
- BRANCH COVERAGE: 100.00% -- 43/43 branches in 6 files
- 72.73% documented

### Fixed

- kettle-jem-template-20260728-005 - VersionGem bootstrap now creates the
  missing canonical version spec when a project only has shim namespace version
  specs.

- kettle-jem-template-20260729-001 - Generated JRuby 9.4 workflows now use the
  legacy manual bundle install path, avoiding setup-time Bundler full-index
  failures against `gem.coop`.

## [0.1.23] - 2026-07-28

- TAG: [v0.1.23][0.1.23t]
- COVERAGE: 100.00% -- 100/100 lines in 6 files
- BRANCH COVERAGE: 100.00% -- 43/43 branches in 6 files
- 72.73% documented

### Added

- Documentation linting now has its generated `yard-lint` dependency and severity config available in the local bundle.

- kettle-jem-template-20260726-001 - Projects now include YARD lint
  configuration and documentation dependencies so documentation issues fail
  before generated docs are refreshed.

- kettle-jem-template-20260727-001 - Spec harness documentation now lists the
  RSpec helpers provided by `kettle-test`.

### Changed

- kettle-jem-template-20260728-001 - Generated Ruby workflows now use clearer
  setup-ruby-flash planning and can prepare appraisal-only jobs without
  installing the main Gemfile bundle.

### Fixed

- kettle-jem-template-20260726-002 - Generated version files now document their
  version namespace and constants, reducing warning-only YARD lint output.

- kettle-jem-template-20260726-003 - Coverage upload steps now treat Coveralls,
  QLTY, and Codecov as optional, so provider outages do not fail CI when local
  coverage thresholds still pass.
- kettle-jem-template-20260728-002 - Generated RuboCop configs now ignore the
  same `gemfiles/vendor/bundle` tree as `.gitignore`, so vendored dependency
  installs are not reported as project lint debt.
- kettle-jem-template-20260728-003 - Generated dep-heads workflows now run
  TruffleRuby jobs with current RubyGems and Bundler, avoiding setup failures
  before the test suite starts.

- kettle-jem-template-20260728-004 - Generated dep-heads workflows now use the
  setup-ruby Bundler install path for direct appraisal Gemfiles, avoiding rv
  lockfile parser failures on Git and path dependencies.

## [0.1.22] - 2026-07-25

- TAG: [v0.1.22][0.1.22t]
- COVERAGE: 100.00% -- 100/100 lines in 6 files
- BRANCH COVERAGE: 100.00% -- 43/43 branches in 6 files
- 63.64% documented

### Changed

- kettle-jem-template-20260716-001 - Shim gemspec manifests now include
  `LICENSE.md` instead of nonexistent `LICENSE.txt`.
- kettle-jem-template-20260716-002 - Generated gemspec manifests now ship fewer
  repository-only files by default to reduce downstream distro packaging churn.
- kettle-jem-template-20260720-001 - Generated READMEs can now render
  template-managed corporate sponsor logos from project or family config.
- kettle-jem-template-20260720-002 - Generated development Gemfiles now use the
  released `tree_sitter_language_pack` gem 1.13.3 or newer by default.
- kettle-jem-template-20260720-003 - Generated StructuredMerge Git diff driver
  config now uses the installed `smorg-rb` Ruby driver name.
- kettle-jem-template-20260720-004 - Generated multi-engine workflow files now
  omit JRuby and TruffleRuby jobs when project config declares MRI-only engines.
- kettle-jem-template-20260720-005 - Generated README Support & Community rows
  now include a RubyForum help badge.
- kettle-jem-template-20260725-001 - Generated JRuby and TruffleRuby workflow
  files now run when pull request head branches start with `feature/release`,
  so release CI monitoring does not report intentionally skipped engine
  workflows as failures.
- kettle-jem-template-20260725-002 - Generated gemspec templates now include
  `anonymous_loader` as a development dependency, and version specs use it to
  execute generated `version.rb` files for coverage without redefining package
  constants. Managed version specs are removed when `version_gem` is disabled
  or incompatible with the project's runtime Ruby floor.

## [0.1.21] - 2026-07-01

- TAG: [v0.1.21][0.1.21t]
- COVERAGE: 100.00% -- 100/100 lines in 6 files
- BRANCH COVERAGE: 100.00% -- 43/43 branches in 6 files
- 63.64% documented

### Added

- Add (non)CI badge for ruby-1.8
- Support `versions: "head"` in `pending_for` and `skip_for` to target
  ruby-head, jruby-head, and truffleruby-head builds.

### Removed

- Removed obsolete `Locked.gemfile` files now that the locked-deps workflow uses
  the main `Gemfile.lock`.

### Fixed

- Fixed current RuboCop Gradual lock drift while preserving the remaining
  baseline entries.

## [0.1.20] - 2026-02-07

- TAG: [v0.1.20][0.1.20t]
- COVERAGE: 100.00% -- 96/96 lines in 6 files
- BRANCH COVERAGE: 100.00% -- 41/41 branches in 6 files
- 63.64% documented

### Added

- Documentation on hostile takeover of RubyGems
  - https://dev.to/galtzo/hostile-takeover-of-rubygems-my-thoughts-5hlo

### Fixed

- compatibility with Ruby < 2.2 (accidentally switched to require_relative)

## [0.1.19] - 2025-09-05

- TAG: [v0.1.19][0.1.19t]
- COVERAGE: 100.00% -- 96/96 lines in 6 files
- BRANCH COVERAGE: 100.00% -- 41/41 branches in 6 files
- 63.64% documented

### Added

- comprehensive documentation and examples in README.md
- support minor version shorthand matching
  - i.e., 3.2 will skip 3.2.8

### Changed

- issues link updated to new org home: galtzo-floss/rspec-pending_for
- upgrade to kettle-dev v1.1.5 template

### Fixed

- fixed handling of version ranges in `skip_for`/`pending_for`
- release date in changelog
- truffleruby compatibility without warnings about typo in engine name

## [0.1.18] - 2025-08-24

- TAG: [v0.1.8][0.1.18t]
- COVERAGE: 100.00% -- 86/86 lines in 6 files
- BRANCH COVERAGE: 100.00% -- 33/33 branches in 6 files
- 63.64% documented

### Added

- Versions can now be ranges!

## [0.1.17] - 2025-02-24

- TAG: [v0.1.7][0.1.17t]
- COVERAGE:  98.44% -- 63/64 lines in 6 files
- BRANCH COVERAGE:  94.44% -- 17/18 branches in 6 files
- 63.64% documented

### Added

- Specs for `skip_for`

### Fixed

- Compatibility with truffleruby (maybe? not able to run it in CI yet)
- Fixed compatibility with Ruby < 2

[Unreleased]: https://github.com/galtzo-floss/rspec-pending_for/compare/v0.1.24...HEAD
[0.1.24]: https://github.com/galtzo-floss/rspec-pending_for/compare/v0.1.23...v0.1.24
[0.1.24t]: https://github.com/galtzo-floss/rspec-pending_for/releases/tag/v0.1.24
[0.1.23]: https://github.com/galtzo-floss/rspec-pending_for/compare/v0.1.22...v0.1.23
[0.1.23t]: https://github.com/galtzo-floss/rspec-pending_for/releases/tag/v0.1.23
[0.1.22]: https://github.com/galtzo-floss/rspec-pending_for/compare/v0.1.21...v0.1.22
[0.1.22t]: https://github.com/galtzo-floss/rspec-pending_for/releases/tag/v0.1.22
[0.1.21]: https://github.com/galtzo-floss/rspec-pending_for/compare/v0.1.20...v0.1.21
[0.1.21t]: https://github.com/galtzo-floss/rspec-pending_for/releases/tag/v0.1.21
[0.1.20]: https://github.com/galtzo-floss/rspec-pending_for/compare/v0.1.19...v0.1.20
[0.1.20t]: https://github.com/galtzo-floss/rspec-pending_for/releases/tag/v0.1.20
[0.1.19]: https://github.com/galtzo-floss/rspec-pending_for/compare/v0.1.18...v0.1.19
[0.1.19t]: https://github.com/galtzo-floss/rspec-pending_for/releases/tag/v0.1.19
[0.1.18]: https://github.com/pboling/rspec-pending_for/compare/v0.1.17...v0.1.18
[0.1.18t]: https://github.com/pboling/rspec-pending_for/tags/v0.1.18
[0.1.17]: https://github.com/pboling/rspec-pending_for/compare/v0.1.16...v0.1.17
[0.1.17t]: https://github.com/pboling/rspec-pending_for/tags/v0.1.17
