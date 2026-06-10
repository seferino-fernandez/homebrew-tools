# Homebrew Formula Management

# List available commands
default:
    @just --list

# Show the latest release version and per-arch checksums for a formula
update-formula formula repo:
    #!/usr/bin/env bash
    set -euo pipefail

    echo "🔍 Fetching latest release for {{repo}}..."
    LATEST_TAG=$(gh release view --repo {{repo}} --json tagName --jq '.tagName')
    echo "📦 Latest version: $LATEST_TAG"

    TEMP_DIR=$(mktemp -d)

    # Exact per-target archive names. The formula name is the asset prefix, so an
    # exact filename avoids matching a sibling tool that shares this prefix
    # (e.g. "rhood" must not pick up "rhood-mcp" archives).
    INTEL_MAC="{{formula}}-x86_64-apple-darwin.tar.gz"
    ARM_MAC="{{formula}}-aarch64-apple-darwin.tar.gz"
    INTEL_LINUX="{{formula}}-x86_64-unknown-linux-gnu.tar.gz"
    ARM_LINUX="{{formula}}-aarch64-unknown-linux-gnu.tar.gz"

    echo "⬇️  Downloading release assets..."
    for f in "$INTEL_MAC" "$ARM_MAC" "$INTEL_LINUX" "$ARM_LINUX"; do
        gh release download "$LATEST_TAG" --repo {{repo}} --pattern "$f" --dir "$TEMP_DIR" 2>/dev/null || true
    done

    sha() { if [[ -f "$TEMP_DIR/$1" ]]; then shasum -a 256 "$TEMP_DIR/$1" | cut -d' ' -f1; fi; }

    echo "🔐 Checksums:"
    [[ -f "$TEMP_DIR/$INTEL_MAC"   ]] && echo "  macOS Intel : $(sha "$INTEL_MAC")"
    [[ -f "$TEMP_DIR/$ARM_MAC"     ]] && echo "  macOS ARM   : $(sha "$ARM_MAC")"
    [[ -f "$TEMP_DIR/$INTEL_LINUX" ]] && echo "  Linux Intel : $(sha "$INTEL_LINUX")"
    [[ -f "$TEMP_DIR/$ARM_LINUX"   ]] && echo "  Linux ARM   : $(sha "$ARM_LINUX")"

    rm -rf "$TEMP_DIR"
    echo ""
    echo "Run 'just apply-update {{formula}} {{repo}} $LATEST_TAG' to apply changes"

# Apply a version + checksum update to a formula file
apply-update formula repo version:
    #!/usr/bin/env bash
    set -euo pipefail

    echo "🔄 Updating Formula/{{formula}}.rb to version {{version}}..."
    TEMP_DIR=$(mktemp -d)

    INTEL_MAC="{{formula}}-x86_64-apple-darwin.tar.gz"
    ARM_MAC="{{formula}}-aarch64-apple-darwin.tar.gz"
    INTEL_LINUX="{{formula}}-x86_64-unknown-linux-gnu.tar.gz"
    ARM_LINUX="{{formula}}-aarch64-unknown-linux-gnu.tar.gz"

    for f in "$INTEL_MAC" "$ARM_MAC" "$INTEL_LINUX" "$ARM_LINUX"; do
        gh release download "{{version}}" --repo {{repo}} --pattern "$f" --dir "$TEMP_DIR" 2>/dev/null || true
    done

    sha() { if [[ -f "$TEMP_DIR/$1" ]]; then shasum -a 256 "$TEMP_DIR/$1" | cut -d' ' -f1; fi; }
    INTEL_MAC_SHA=$(sha "$INTEL_MAC")
    ARM_MAC_SHA=$(sha "$ARM_MAC")
    INTEL_LINUX_SHA=$(sha "$INTEL_LINUX")
    ARM_LINUX_SHA=$(sha "$ARM_LINUX")

    rm -rf "$TEMP_DIR"

    FORMULA_FILE="Formula/{{formula}}.rb"
    BASE="https://github.com/{{repo}}/releases/download/{{version}}"
    VERSION_NUM=$(echo "{{version}}" | sed 's/^v//')

    sed -i '' "s/version \".*\"/version \"$VERSION_NUM\"/" "$FORMULA_FILE"

    if [[ -n "$INTEL_MAC_SHA" ]]; then
        sed -i '' "s|url \".*x86_64-apple-darwin.*\"|url \"$BASE/$INTEL_MAC\"|" "$FORMULA_FILE"
        sed -i '' "/x86_64-apple-darwin/,/sha256/ s/sha256 \".*\"/sha256 \"$INTEL_MAC_SHA\"/" "$FORMULA_FILE"
    fi
    if [[ -n "$ARM_MAC_SHA" ]]; then
        sed -i '' "s|url \".*aarch64-apple-darwin.*\"|url \"$BASE/$ARM_MAC\"|" "$FORMULA_FILE"
        sed -i '' "/aarch64-apple-darwin/,/sha256/ s/sha256 \".*\"/sha256 \"$ARM_MAC_SHA\"/" "$FORMULA_FILE"
    fi
    if [[ -n "$INTEL_LINUX_SHA" ]]; then
        sed -i '' "s|url \".*x86_64-unknown-linux-gnu.*\"|url \"$BASE/$INTEL_LINUX\"|" "$FORMULA_FILE"
        sed -i '' "/x86_64-unknown-linux-gnu/,/sha256/ s/sha256 \".*\"/sha256 \"$INTEL_LINUX_SHA\"/" "$FORMULA_FILE"
    fi
    if [[ -n "$ARM_LINUX_SHA" ]]; then
        sed -i '' "s|url \".*aarch64-unknown-linux-gnu.*\"|url \"$BASE/$ARM_LINUX\"|" "$FORMULA_FILE"
        sed -i '' "/aarch64-unknown-linux-gnu/,/sha256/ s/sha256 \".*\"/sha256 \"$ARM_LINUX_SHA\"/" "$FORMULA_FILE"
    fi

    echo "✅ Updated $FORMULA_FILE to version {{version}}"

# Update noaa-weather formula (convenience command)
update-noaa:
    just update-formula noaa-weather seferino-fernandez/noaa_weather

# Apply update to noaa-weather formula
apply-noaa version:
    just apply-update noaa-weather seferino-fernandez/noaa_weather {{version}}

# Inspect + show checksums for rhood (CLI)
update-rhood:
    just update-formula rhood seferino-fernandez/rhood-rs

# Apply a version update to the rhood (CLI) formula
apply-rhood version:
    just apply-update rhood seferino-fernandez/rhood-rs {{version}}

# Inspect + show checksums for rhood-mcp (MCP server)
update-rhood-mcp:
    just update-formula rhood-mcp seferino-fernandez/rhood-rs

# Apply a version update to the rhood-mcp formula
apply-rhood-mcp version:
    just apply-update rhood-mcp seferino-fernandez/rhood-rs {{version}}

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
