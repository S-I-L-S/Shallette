# Licensing review: decided baseline, not legal clearance

## What is known

- The GitHub project `zen-browser/desktop` currently identifies its license as Mozilla Public License 2.0 (MPL-2.0).
- Mozilla's trademark policy explains that a source-code license does not grant trademark rights. It requires distinct project branding and prohibits suggesting Mozilla affiliation or endorsement.
- The Shallette repository contains documentation and identity assets only; no Zen or Mozilla source code has been imported into it. The badge-edition build (see [`BADGE-EDITION.md`](BADGE-EDITION.md)) repacks the official Zen 1.23.4b release and is not distributed from this repository.

## MPL-2.0 baseline

Shallette is a downstream derivative of Zen (decided — see [`ROADMAP.md`](ROADMAP.md)), and the badge edition already repacks Zen files. Treat MPL-2.0 as the baseline for covered files: retain notices, make source for covered files available under MPL terms when distributing executable forms, and mark modifications as required by the license. Verify the exact upstream revision and its license notices before importing anything. Firefox/Mozilla source and bundled dependencies may carry additional license files and obligations; inventory them rather than assuming one license covers the entire distribution.

For new Shallette-authored files, MPL-2.0 is the decided license (see [`ROADMAP.md`](ROADMAP.md)): file-level copyleft, compatible with the upstream codebase. Assets, fonts, codecs, branding, and third-party components still need separate rights review. The repository does not yet carry a `LICENSE` file; add it together with `THIRD_PARTY_NOTICES.md` before publishing.

## Before adding the license files

1. Project model — recorded: a downstream tuning atelier over Zen Browser (see [`ROADMAP.md`](ROADMAP.md)).
2. Identify the exact Zen and Firefox/Mozilla revisions, if any, and retain their license and notice files.
3. Inventory bundled dependencies, fonts, codecs, icons, and other assets with their licenses.
4. Decide the license for Shallette-authored source and assets separately where appropriate.
5. Add `LICENSE` and `THIRD_PARTY_NOTICES.md`, then review redistribution and trademark requirements before publishing binaries.

This document is an engineering checklist, not legal advice.

## References

- [Zen Browser desktop repository](https://github.com/zen-browser/desktop) (repository identifies MPL-2.0)
- [Mozilla Public License 2.0 text](https://www.mozilla.org/MPL/2.0/)
- [Mozilla Trademark Guidelines](https://www.mozilla.org/en-US/foundation/trademarks/policy/)
