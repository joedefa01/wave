#!/bin/bash

executeByOSType() {
    OS_TYPE=$(uname -s)

    case "$OS_TYPE" in
        Linux)
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/joedefa01/nextgen/HEAD/linux-install.sh)"
            ;;
        Darwin)
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/joedefa01/nextgen/HEAD/macos-install.sh)"
            ;;
        FreeBSD)
            echo "Unsupported OS: FreeBSD"
            ;;
        CYGWIN*|MINGW32*|MSYS*|MINGW*)
            echo "Unsupported OS: Windows"
            ;;
        *)
            echo "Unsupported OS: $OS_TYPE"
            ;;
    esac
}

# Call the function
executeByOSType
