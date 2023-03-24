[![REUSE status](https://api.reuse.software/badge/github.com/SAP/fosstars-rating-core-action)](https://api.reuse.software/info/github.com/SAP/fosstars-rating-core-action)

# Fosstars ratings

This action calculates [a security rating](https://sap.github.io/fosstars-rating-core/oss_security_rating.html) or [an OSS rule of play rating](https://sap.github.io/fosstars-rating-core/oss_rules_of_play_rating.html) for an open source project.
The rating contains a score and a label. The score is a number from 0 to 10.

It shows how well the project cares about security or open source community/maintenance aspects. The ratings take several aspects into account. You can find all the details regarding the various aspects in the section "What the security rating takes into account" of [the security rating documentation](https://sap.github.io/fosstars-rating-core/oss_security_rating.html) and the section "What the OSS rules of play rating takes into account" of [the OSS rules of play documentation](https://sap.github.io/fosstars-rating-core/oss_rules_of_play_rating.html). Additional information about Fosstars, how the ratings are calculated and related content is available [in the documentation](https://sap.github.io/fosstars-rating-core/) as well.

Fosstars uses only publicly available data about open source projects.

The action creates a detailed report that explains how the rating was calculated.
In addition, the report contains recommendations for improving the respective rating.

## Badges

The action generates one of the following badges that reflect the labels of the respective ratings (see [security](https://sap.github.io/fosstars-rating-core/oss_security_rating.html) or [OSS rules of play](https://sap.github.io/fosstars-rating-core/oss_rules_of_play_rating.html)):

### Security

* ![Good security rating](https://raw.githubusercontent.com/SAP/fosstars-rating-core-action/main/images/security-fosstars-good.svg)
* ![Moderate security rating](https://raw.githubusercontent.com/SAP/fosstars-rating-core-action/main/images/security-fosstars-moderate.svg)
* ![Bad security rating](https://raw.githubusercontent.com/SAP/fosstars-rating-core-action/main/images/security-fosstars-bad.svg)
* ![Unclear rating](https://raw.githubusercontent.com/SAP/fosstars-rating-core-action/main/images/security-fosstars-unclear.svg)
* ![Unknown rating](https://raw.githubusercontent.com/SAP/fosstars-rating-core-action/main/images/security-fosstars-unknown.svg)

### OSS Rules of Play

* ![Rating passed](https://raw.githubusercontent.com/SAP/fosstars-rating-core-action/main/images/rop-fosstars-passed.svg)
* ![Rating passed with warnings](https://raw.githubusercontent.com/SAP/fosstars-rating-core-action/main/images/rop-fosstars-passed_with_warning.svg)
* ![Rating failed](https://raw.githubusercontent.com/SAP/fosstars-rating-core-action/main/images/rop-fosstars-failed.svg)
* ![Unclear rating](https://raw.githubusercontent.com/SAP/fosstars-rating-core-action/main/images/rop-fosstars-unclear.svg)
* ![Unknown security rating](https://raw.githubusercontent.com/SAP/fosstars-rating-core-action/main/images/rop-fosstars-unknown.svg)

The report and the badge are stored in a specified branch.

## Inputs

### `rating`

**Required** The rating this action should determine, can be `security` or `oss-rules-of-play`. Default `security`.

### `report-branch`

**Required** A branch where the report and the badge should be stored. Default `fosstars`.

### `fosstars-version`

**Required** [A version of Fosstars](https://github.com/SAP/fosstars-rating-core/releases)
to be used for calculating a rating. Default `v1.11.0`.

### `token`

**Required** A token for fetching data about the project via GitHub API,
and for committing the report and badge to the specified branch.

### `report-file`

**Optional** A file name for the report. Default `fosstars_report.md`.

### `badge-file`

**Optional** A file name for the badge. Default `fosstars_badge.svg`.

### `data-provider-config-urls`

**Optional** A comma-separated list of data provider configuration URLs.
The individual file names need to have the format `ProviderClassName.yaml` or `ProviderClassName.config.yaml`.
As some data providers of the OSS Rules of Play rating require configuration files to work correctly, [SAP default configuration files](https://github.com/SAP/fosstars-rating-core-action/tree/main/rop-sap-defaults) are being used if the `oss-rules-of-play` rating is specified and no configuration URLs are passed to the action.

### `git-user-name`

**Optional** The git user name used when performing the report commit. Default `Fosstars`.

### `git-user-email`

**Optional** The git user email address used when performing the report commit. Default `fosstars@users.noreply.github.com`.

## How to use it

Here is an example workflow that updates the report every day, or when a commit is pushed.
The report is stored to the `fosstars-report` branch.

```
name: "Fosstars"
on:
  push:
    branches:
      - main
  schedule:
    - cron: "0 0 * * *"

jobs:
  create_fosstars_report:
    runs-on: ubuntu-latest
    name: "Security rating"
    steps:
      - uses: actions/checkout@v2.3.4
      - uses: SAP/fosstars-rating-core-action@v1.11.0
        with:
          rating: security
          report-branch: fosstars-report
          report-file: fosstars_security_rating.md
          badge-file: fosstars_security_rating.svg
          token: ${{ secrets.GITHUB_TOKEN }}
          data-provider-config-urls: https://raw.githubusercontent.com/your-org/your-repo/main/conf/ReadmeInfo.config.yml,https://raw.githubusercontent.com/your-org/your-repo/main/conf/ContributingGuidelineInfo.config.yml,https://raw.githubusercontent.com/your-org/your-repo/main/conf/LicenseInfo.config.yml
```

The badge will be stored to the same branch. It can be used in a README file:

```
[![Fosstars security rating](https://raw.githubusercontent.com/your-organisation/your-project/fosstars-report/fosstars-security-rating.svg)](https://github.com/your-organisation/your-project/blob/fosstars-report/fosstars_security_rating.md)
```

## Example

Check out [an example workflow](https://github.com/SAP/fosstars-rating-core/blob/master/.github/workflows/fosstars-project-report.yml) that runs the action.
The workflow stores [a report](https://github.com/SAP/fosstars-rating-core/blob/fosstars-report/fosstars_report.md) in [fosstars-report](https://github.com/SAP/fosstars-rating-core/tree/fosstars-report) branch.

## Known issues

Please see [GitHub issues](https://github.com/SAP/fosstars-rating-core-action/issues).

## Support

Please create a new [GitHub issue](https://github.com/SAP/fosstars-rating-core-action/issues)
if you found a bug, or you'd like to suggest an enhancement.
If you think you found a security issue, please follow [this guideline](SECURITY.md).

If you have a question, please [open a discussion](https://github.com/SAP/fosstars-rating-core-action/discussions).

## Contributing

We appreciate feedback, ideas for improvements and, of course, pull requests.

Please follow [this guideline](CONTRIBUTING.md) if you'd like to contribute to the project.

## Links

1. [Fosstars home page](https://github.com/SAP/fosstars-rating-core)
1. [Fosstars documentation](https://sap.github.io/fosstars-rating-core/)
1. [Open source security rating](https://sap.github.io/fosstars-rating-core/oss_security_rating.html)
1. [Security ratings for well-known open source projects](https://sap.github.io/fosstars-rating-core/oss/security/)
1. [Open source rules of play rating](https://sap.github.io/fosstars-rating-core/oss_rules_of_play_rating.html)
