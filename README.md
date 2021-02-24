# Xcodebuild lcov action

Xcodebuild Code Coverage Report.

## Summary Report

The action will report a test coverage summary in you job logs:

```
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
URLConvertible.swift               24                 6    75.00%          16                 4    75.00%          61                 4    93.44%
URLMatchResult.swift               17                 6    64.71%           7                 1    85.71%          26                 3    88.46%
URLMatcher.swift                   25                 4    84.00%           8                 1    87.50%          45                 3    93.33%
URLPatternComponent.swift           9                 0   100.00%           3                 0   100.00%          24                 0   100.00%
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
TOTAL                              75                16    78.67%          34                 6    82.35%         156                10    93.59%
```

## LCOV Report

The action will also create a coverage file that can be digest by other actions, such as [romeovs/lcov-reporter-action](https://github.com/romeovs/lcov-reporter-action) that can comment PRs with the coverage report.

## Inputs

#### `derived-data-path`

**Required** Specify the directory where build products and other derived data can be found.

#### `target`

**Required** The target name to report.

#### `output-file`

**Optional** Specify a file path to write coverage report into. By default, the coverage will be reported to `./coverage/lcov.info`. If the directory does not exist, it is created.

#### `file-format`

**Optional** Use the specified output format. The supported formats are: “text” (JSON), “lcov” (Default).

## Example usage
```yml
- name: Run tests
  uses: sersoft-gmbh/xcodebuild-action@v1
  with:
      project: MyApp.xcodeproj
      scheme: MyApp
      derived-data-path: ./output
      destination: "OS=14.4,name=iPhone 12 Pro"
      action: test
      enable-code-coverage: true

- name: Test Coverage
  uses: maxep/xcodebuild-lcov-action@0.1.0
  with:
      derived-data-path: ./output
      target: MyApp.app
      output-file: ./output/lcov.info
```