# Licensing review: proposal, not legal clearance

## What is known

- The GitHub project `zen-browser/desktop` currently identifies its license as Mozilla Public License 2.0 (MPL-2.0).
- Mozilla's trademark policy explains that a source-code license does not grant trademark rights. It requires distinct project branding and prohibits suggesting Mozilla affiliation or endorsement.
- The Shallette GitHub repository checked on 27 October 2026 is empty. There is no local or repository evidence that Shallette currently contains Zen code, Mozilla code, or third-party assets.

## Conditional recommendation

If Shallette will be a downstream fork or derivative that includes Zen source files, treat MPL-2.0 as the baseline for those covered files: retain notices, make source for covered files available under MPL terms when distributing executable forms, and mark modifications as required by the license. Verify the exact upstream revision and its license notices before importing anything. Firefox/Mozilla source and bundled dependencies may carry additional license files and obligations; inventory them rather than assuming one license covers the entire distribution.

For new Shallette-authored files, MPL-2.0 is a practical candidate if the project intends to remain compatible with the upstream codebase and wants file-level copyleft. This is a proposal only. A clean-room implementation has different choices, and assets, fonts, codecs, branding, and third-party components need separate rights review. Avoid adding a generic `LICENSE` until the project owner confirms the intended model and the code provenance is known.

## Before selecting a repository license

1. Choose and record the project model: fork/downstream build, or clean-room implementation.
2. Identify the exact Zen and Firefox/Mozilla revisions, if any, and retain their license and notice files.
3. Inventory bundled dependencies, fonts, codecs, icons, and other assets with their licenses.
4. Decide the license for Shallette-authored source and assets separately where appropriate.
5. Add `LICENSE` and `THIRD_PARTY_NOTICES.md`, then review redistribution and trademark requirements before publishing binaries.

This document is an engineering checklist, not legal advice.

## References

- [Zen Browser desktop repository](https://github.com/zen-browser/desktop) (repository identifies MPL-2.0)
- [Mozilla Public License 2.0 text](https://www.mozilla.org/MPL/2.0/)
- [Mozilla Trademark Guidelines](https://www.mozilla.org/en-US/foundation/trademarks/policy/)
