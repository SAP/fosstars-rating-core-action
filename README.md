[![REUSE status](https://api.reuse.software/badge/github.com/SAP/fosstars-rating-core-action)](https://api.reuse.software/info/github.com/SAP/fosstars-rating-core-action)

# Fosstars ratings

This action calculates [a security rating for an open source project](https://sap.github.io/fosstars-rating-core/oss_security_rating.html).
The rating contains a security score and a label. The score is a number from 0 to 10.
It shows how well the project cares about security. The label can be `Good`, `Moderate`, `Bad` and `Unclear`.

The rating procedure takes into account multiple factors:

*  How well the open source project implements security testing.
*  How well the project’s community is aware of best security practices and adopt them.
*  How well vulnerabilities are patched in the project.
*  How the community commits to supporting the project.
*  How active and popular the project is.

Fosstars uses only publicly available data about open source projects.

The action creates a detailed report that explains how the rating was calculated.
In addition, the report contains recommendations for improving the security rating.

The action also generates one of the following badges:

*  ![Good security rating](https://raw.githubusercontent.com/SAP/fosstars-rating-core-action/main/images/security-fosstars-good.svg)
*  ![Moderate security rating](https://raw.githubusercontent.com/SAP/fosstars-rating-core-action/main/images/security-fosstars-moderate.svg)
*  ![Bad security rating](https://raw.githubusercontent.com/SAP/fosstars-rating-core-action/main/images/security-fosstars-bad.svg)
*  ![Unclear security rating](https://raw.githubusercontent.com/SAP/fosstars-rating-core-action/main/images/security-fosstars-unclear.svg)
*  ![Unknown security rating](https://raw.githubusercontent.com/SAP/fosstars-rating-core-action/main/images/security-fosstars-unknown.svg)

The report and the badge are stored in a specified branch.

## Inputs

### `report-branch`

**Required** A branch where the report and the badge should be stored. Default `fosstars`.

### `token`

**Required** A token for fetching data about the project via GitHub API,
and for committing the report and badge to the specified branch.

### `report-file`

**Optional** A file name for the report. Default `fosstars_report.md`.

### `badge-file`

**Optional** A file name for the badge. Default `fosstars_badge.svg`.

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
      - uses: SAP/fosstars-rating-core-action
        with:
          report-branch: fosstars-report
          report-file: fosstars_security_rating.md
          badge-file: fosstars_security_rating.svg
          token: ${{ secrets.GITHUB_TOKEN }}
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

1.  [Fosstars home page](https://github.com/SAP/fosstars-rating-core)
1.  [Fosstars documentation](https://sap.github.io/fosstars-rating-core/)
1.  [Open source security rating](https://sap.github.io/fosstars-rating-core/oss_security_rating.html)
1.  [Security ratings for well-known open source projects](https://sap.github.io/fosstars-rating-core/oss/security/)
