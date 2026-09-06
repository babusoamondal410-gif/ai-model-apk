#!/bin/bash

# AI Model APK Build Script
# This script automates the build process

set -e

echo "🚀 AI Model APK Build Script"
echo "=================================="

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check if Gradle exists
if ! command -v ./gradlew &> /dev/null; then
    echo -e "${YELLOW}Gradle wrapper not found. Installing...${NC}"
    ./gradlew wrapper
fi

# Parse arguments
BUILD_TYPE=${1:-debug}
CLEAN=${2:-false}

echo -e "${BLUE}Build Type: $BUILD_TYPE${NC}"

# Clean build if requested
if [ "$CLEAN" == "clean" ]; then
    echo -e "${YELLOW}Cleaning build files...${NC}"
    ./gradlew clean
fi

# Build
echo -e "${BLUE}Building APK...${NC}"
if [ "$BUILD_TYPE" == "release" ]; then
    ./gradlew assembleRelease -x test
    APK_PATH="app/build/outputs/apk/release/app-release.apk"
else
    ./gradlew assembleDebug
    APK_PATH="app/build/outputs/apk/debug/app-debug.apk"
fi

# Check if build succeeded
if [ -f "$APK_PATH" ]; then
    SIZE=$(du -h "$APK_PATH" | cut -f1)
    echo -e "${GREEN}✓ Build successful!${NC}"
    echo -e "${GREEN}APK: $APK_PATH${NC}"
    echo -e "${GREEN}Size: $SIZE${NC}"
    
    # Install on connected device
    if adb devices | grep -q "device$"; then
        read -p "Install on device? (y/n) " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            echo -e "${BLUE}Installing...${NC}"
            adb install -r "$APK_PATH"
            echo -e "${GREEN}✓ Installation complete${NC}"
        fi
    fi
else
    echo -e "${YELLOW}Build failed or APK not found${NC}"
    exit 1
fi

echo -e "${GREEN}Done!${NC}"
