# Homebrew Tools

[![Last Commit](https://img.shields.io/github/last-commit/seferino-fernandez/homebrew-tools)](https://github.com/seferino-fernandez/homebrew-tools/commits/main)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

This repository is a personal [Homebrew](https://brew.sh/) tap for my custom command-line tools and other utilities.

## How to Use

To get started, you only need to "tap" this repository once. This adds it to Homebrew's list of formula sources, making the tools within it available for installation.

```sh
brew tap seferino-fernandez/tools
```

After tapping, you can install any of the available formulas using the `brew install` command.

For example, to install the `noaa-weather` CLI:

```sh
brew install noaa-weather
```

## Available Formulas

The following tools are currently available for installation through this tap:

| Formula        | Description                                        | Source Repository                                                                     |
| :------------- | :------------------------------------------------- | :------------------------------------------------------------------------------------ |
| `noaa-weather` | A command-line interface for the NOAA Weather API. | [seferino-fernandez/noaa_weather](https://github.com/seferino-fernandez/noaa_weather) | 

## License

This tap and the formulas within are available under the [MIT License](https://opensource.org/licenses/MIT) unless otherwise noted in a specific formula's source repository.
