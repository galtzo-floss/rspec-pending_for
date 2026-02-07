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

### Changed

### Deprecated

### Removed

### Fixed

### Security

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

[Unreleased]: https://github.com/galtzo-floss/rspec-pending_for/compare/v0.1.20...HEAD
[0.1.20]: https://github.com/galtzo-floss/rspec-pending_for/compare/v0.1.19...v0.1.20
[0.1.20t]: https://github.com/galtzo-floss/rspec-pending_for/releases/tag/v0.1.20
[0.1.19]: https://github.com/galtzo-floss/rspec-pending_for/compare/v0.1.18...v0.1.19
[0.1.19t]: https://github.com/galtzo-floss/rspec-pending_for/releases/tag/v0.1.19
[0.1.18]: https://github.com/pboling/rspec-pending_for/compare/v0.1.17...v0.1.18
[0.1.18t]: https://github.com/pboling/rspec-pending_for/tags/v0.1.18
[0.1.17]: https://github.com/pboling/rspec-pending_for/compare/v0.1.16...v0.1.17
[0.1.17t]: https://github.com/pboling/rspec-pending_for/tags/v0.1.17
