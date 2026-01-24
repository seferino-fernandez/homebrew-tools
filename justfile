# Homebrew Formula Management

# List available commands
default:
    @just --list

# Update a formula to the latest release
update-formula formula repo:
    #!/usr/bin/env bash
    set -euo pipefail
    
    echo "🔍 Fetching latest release for {{repo}}..."
    LATEST_TAG=$(gh release view --repo {{repo}} --json tagName --jq '.tagName')
    echo "📦 Latest version: $LATEST_TAG"
    
    # Create temp directory for downloads
    TEMP_DIR=$(mktemp -d)
    cd "$TEMP_DIR"
    
    echo "⬇️  Downloading release assets..."
    gh release download "$LATEST_TAG" --repo {{repo}} --pattern '*.tar.gz'

    # Calculate checksums
    echo "🔐 Calculating checksums..."
    INTEL_FILE=$(ls *x86_64-apple-darwin*.tar.gz 2>/dev/null || echo "")
    ARM_FILE=$(ls *aarch64-apple-darwin*.tar.gz 2>/dev/null || echo "")
    LINUX_FILE=$(ls *x86_64-unknown-linux-gnu*.tar.gz 2>/dev/null || echo "")

    if [[ -n "$INTEL_FILE" ]]; then
        INTEL_SHA=$(shasum -a 256 "$INTEL_FILE" | cut -d' ' -f1)
        echo "macOS Intel SHA256: $INTEL_SHA"
    fi

    if [[ -n "$ARM_FILE" ]]; then
        ARM_SHA=$(shasum -a 256 "$ARM_FILE" | cut -d' ' -f1)
        echo "macOS ARM SHA256: $ARM_SHA"
    fi

    if [[ -n "$LINUX_FILE" ]]; then
        LINUX_SHA=$(shasum -a 256 "$LINUX_FILE" | cut -d' ' -f1)
        echo "Linux x86_64 SHA256: $LINUX_SHA"
    fi

    # Clean up temp directory
    cd - > /dev/null
    rm -rf "$TEMP_DIR"

    echo "✅ Ready to update Formula/{{formula}}.rb with:"
    echo "   Version: $LATEST_TAG"
    [[ -n "$INTEL_FILE" ]] && echo "   macOS Intel SHA256: $INTEL_SHA"
    [[ -n "$ARM_FILE" ]] && echo "   macOS ARM SHA256: $ARM_SHA"
    [[ -n "$LINUX_FILE" ]] && echo "   Linux x86_64 SHA256: $LINUX_SHA"
    echo ""
    echo "Run 'just apply-update {{formula}} {{repo}} $LATEST_TAG' to apply changes"

# Apply the update to a formula file
apply-update formula repo version:
    #!/usr/bin/env bash
    set -euo pipefail
    
    echo "🔄 Updating Formula/{{formula}}.rb to version {{version}}..."
    
    # Create temp directory for downloads to get checksums
    TEMP_DIR=$(mktemp -d)
    cd "$TEMP_DIR"
    
    gh release download "{{version}}" --repo {{repo}} --pattern '*.tar.gz'

    INTEL_FILE=$(ls *x86_64-apple-darwin*.tar.gz 2>/dev/null || echo "")
    ARM_FILE=$(ls *aarch64-apple-darwin*.tar.gz 2>/dev/null || echo "")
    LINUX_FILE=$(ls *x86_64-unknown-linux-gnu*.tar.gz 2>/dev/null || echo "")

    if [[ -n "$INTEL_FILE" ]]; then
        INTEL_SHA=$(shasum -a 256 "$INTEL_FILE" | cut -d' ' -f1)
    fi

    if [[ -n "$ARM_FILE" ]]; then
        ARM_SHA=$(shasum -a 256 "$ARM_FILE" | cut -d' ' -f1)
    fi

    if [[ -n "$LINUX_FILE" ]]; then
        LINUX_SHA=$(shasum -a 256 "$LINUX_FILE" | cut -d' ' -f1)
    fi

    cd - > /dev/null
    rm -rf "$TEMP_DIR"

    # Update the formula file
    FORMULA_FILE="Formula/{{formula}}.rb"

    # Extract version number from tag (remove prefix if present)
    VERSION_NUM=$(echo "{{version}}" | sed 's/.*-v//' | sed 's/^v//')

    # Update version
    sed -i '' "s/version \".*\"/version \"$VERSION_NUM\"/" "$FORMULA_FILE"

    # Update macOS Intel URL and SHA
    if [[ -n "$INTEL_FILE" ]]; then
        sed -i '' "s|url \".*x86_64-apple-darwin.*\"|url \"https://github.com/{{repo}}/releases/download/{{version}}/$INTEL_FILE\"|" "$FORMULA_FILE"
        sed -i '' "/x86_64-apple-darwin/,/sha256/ s/sha256 \".*\"/sha256 \"$INTEL_SHA\"/" "$FORMULA_FILE"
    fi

    # Update macOS ARM URL and SHA
    if [[ -n "$ARM_FILE" ]]; then
        sed -i '' "s|url \".*aarch64-apple-darwin.*\"|url \"https://github.com/{{repo}}/releases/download/{{version}}/$ARM_FILE\"|" "$FORMULA_FILE"
        sed -i '' "/aarch64-apple-darwin/,/sha256/ s/sha256 \".*\"/sha256 \"$ARM_SHA\"/" "$FORMULA_FILE"
    fi

    # Update Linux x86_64 URL and SHA
    if [[ -n "$LINUX_FILE" ]]; then
        sed -i '' "s|url \".*x86_64-unknown-linux-gnu.*\"|url \"https://github.com/{{repo}}/releases/download/{{version}}/$LINUX_FILE\"|" "$FORMULA_FILE"
        sed -i '' "/x86_64-unknown-linux-gnu/,/sha256/ s/sha256 \".*\"/sha256 \"$LINUX_SHA\"/" "$FORMULA_FILE"
    fi

    echo "✅ Updated $FORMULA_FILE to version {{version}}"

# Update noaa-weather formula (convenience command)
update-noaa:
    just update-formula noaa-weather seferino-fernandez/noaa_weather

# Apply update to noaa-weather formula
apply-noaa version:
    just apply-update noaa-weather seferino-fernandez/noaa_weather {{version}}

# Full update process for noaa-weather
update-noaa-complete:
    #!/usr/bin/env bash
    set -euo pipefail
    
    echo "🚀 Starting complete update process for noaa-weather..."
    
    # Get latest version
    LATEST_TAG=$(gh release view --repo seferino-fernandez/noaa_weather --json tagName --jq '.tagName')
    echo "📦 Latest version: $LATEST_TAG"
    
    # Inspect the release first
    echo "🔍 Inspecting release contents..."
    just inspect-release seferino-fernandez/noaa_weather "$LATEST_TAG"
    
    echo ""
    echo "❓ Does the binary name match 'noaa-weather' in your formula? (y/N)"
    read -r CONFIRM
    if [[ ! "$CONFIRM" =~ ^[Yy]$ ]]; then
        echo "❌ Update cancelled. Check binary name and update formula if needed."
        exit 1
    fi
    
    # Apply the update
    just apply-noaa "$LATEST_TAG"
    
    echo "🧪 Running validation..."
    just validate noaa-weather
    
    echo "✅ Update complete!"

# Update with manual confirmation (safer)
update-noaa-safe:
    just update-noaa-complete

# Validate a formula
validate formula:
    @echo "🔍 Validating {{formula}} formula..."
    @echo "📝 Checking formula syntax..."
    ruby -c Formula/{{formula}}.rb
    @echo "🎨 Checking formula style..."
    brew style Formula/{{formula}}.rb

# Test a formula installation
test-install formula:
    @echo "🧪 Testing installation of {{formula}}..."
    brew install --build-from-source ./Formula/{{formula}}.rb
    brew test {{formula}}

# Clean up any temporary files
clean:
    @echo "🧹 Cleaning up..."
    @find . -name "*.tar.gz" -delete 2>/dev/null || true
    @find . -name "*.zip" -delete 2>/dev/null || true

# Show current formula versions
show-versions:
    @echo "📋 Current formula versions:"
    @grep -h "version" Formula/*.rb | sed 's/^[[:space:]]*/  /'

# Download release assets manually for inspection
download-assets repo tag:
    @echo "⬇️  Downloading assets for {{repo}}@{{tag}}..."
    gh release download {{tag}} --repo {{repo}} --pattern '*.tar.gz'
    @echo "✅ Downloaded to current directory"

# Inspect binary contents of a release before updating
inspect-release repo tag:
    #!/usr/bin/env bash
    set -euo pipefail
    
    echo "🔍 Inspecting release {{repo}}@{{tag}}..."
    
    # Create temp directory for inspection
    TEMP_DIR=$(mktemp -d)
    cd "$TEMP_DIR"
    
    echo "⬇️  Downloading release assets..."
    gh release download "{{tag}}" --repo {{repo}} --pattern '*.tar.gz'

    INTEL_FILE=$(ls *x86_64-apple-darwin*.tar.gz 2>/dev/null || echo "")
    ARM_FILE=$(ls *aarch64-apple-darwin*.tar.gz 2>/dev/null || echo "")
    LINUX_FILE=$(ls *x86_64-unknown-linux-gnu*.tar.gz 2>/dev/null || echo "")

    echo ""
    echo "📦 Archive Analysis:"

    if [[ -n "$INTEL_FILE" ]]; then
        echo ""
        echo "  macOS Intel archive: $INTEL_FILE"
        echo "  Contents:"
        tar -tzf "$INTEL_FILE" | sed 's/^/    /'

        # Extract and check if it's executable
        tar -xzf "$INTEL_FILE"
        BINARY_NAME=$(tar -tzf "$INTEL_FILE" | head -1 | tr -d '/')
        if [[ -f "$BINARY_NAME" ]]; then
            echo "  Binary name: $BINARY_NAME"
            if [[ -x "$BINARY_NAME" ]]; then
                echo "  ✅ Binary is executable"
                # Try to get version info
                if ./"$BINARY_NAME" --version 2>/dev/null || ./"$BINARY_NAME" -V 2>/dev/null || ./"$BINARY_NAME" version 2>/dev/null; then
                    echo "  ✅ Version command works"
                else
                    echo "  ⚠️  Version command may not work"
                fi
            else
                echo "  ❌ Binary is not executable"
            fi
        fi
    fi

    if [[ -n "$ARM_FILE" ]]; then
        echo ""
        echo "  macOS ARM archive: $ARM_FILE"
        echo "  Contents:"
        tar -tzf "$ARM_FILE" | sed 's/^/    /'

        # Just check contents, don't try to execute on wrong architecture
        BINARY_NAME=$(tar -tzf "$ARM_FILE" | head -1 | tr -d '/')
        echo "  Binary name: $BINARY_NAME"
    fi

    if [[ -n "$LINUX_FILE" ]]; then
        echo ""
        echo "  Linux x86_64 archive: $LINUX_FILE"
        echo "  Contents:"
        tar -tzf "$LINUX_FILE" | sed 's/^/    /'

        # Just check contents, don't try to execute Linux binary on macOS
        BINARY_NAME=$(tar -tzf "$LINUX_FILE" | head -1 | tr -d '/')
        echo "  Binary name: $BINARY_NAME"
    fi

    # Clean up
    cd - > /dev/null
    rm -rf "$TEMP_DIR"

    echo ""
    echo "✅ Inspection complete. Check binary names match your formula's install section."

# Inspect the latest release for noaa-weather
inspect-noaa:
    #!/usr/bin/env bash
    set -euo pipefail
    
    LATEST_TAG=$(gh release view --repo seferino-fernandez/noaa_weather --json tagName --jq '.tagName')
    echo "🔍 Inspecting latest noaa-weather release: $LATEST_TAG"
    just inspect-release seferino-fernandez/noaa_weather "$LATEST_TAG"
