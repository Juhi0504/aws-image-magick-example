#!/bin/bash

# Clean up previous build outputs
rm -rf output-al2023_1
rm -f output-al2023_1.tar.gz

# Create output directories
mkdir -p output-al2023_1/bin
mkdir -p output-al2023_1/lib
mkdir -p output-al2023_1/lib64
mkdir -p output-al2023_1/etc
mkdir -p output-al2023_1/share

# Create a container from the image
CONTAINER_ID=$(docker create al2023-libheif1.19.2_dependencies)

# Extract the binaries and libraries
echo "Extracting binaries and libraries..."

# Copy executables
docker cp $CONTAINER_ID:/usr/local/bin output-al2023_1/

# Copy libraries
docker cp $CONTAINER_ID:/usr/local/lib output-al2023_1/
# or if the libraries are in lib64 directory:
docker cp $CONTAINER_ID:/usr/local/lib64 output-al2023_1/

# Copy configuration files
docker cp $CONTAINER_ID:/usr/local/etc/ImageMagick-7 output-al2023_1/etc/

# Copy additional support files
docker cp $CONTAINER_ID:/usr/local/share/ImageMagick-7 output-al2023_1/share/

docker cp $CONTAINER_ID:/usr/lib64 output-al2023_1/lib64/


# Create simple loader script
cat > output-al2023_1/bin/run-convert.sh << 'EOF'
#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
export LD_LIBRARY_PATH="${SCRIPT_DIR}/../lib:$LD_LIBRARY_PATH"
"${SCRIPT_DIR}/magick" convert "$@"
EOF

cat > output-al2023_1/bin/run-heif-info.sh << 'EOF'
#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
export LD_LIBRARY_PATH="${SCRIPT_DIR}/../lib:$LD_LIBRARY_PATH"
"${SCRIPT_DIR}/heif-info" "$@"
EOF

chmod +x output-al2023_1/bin/run-convert.sh output-al2023_1/bin/run-heif-info.sh
chmod +x output-al2023_1/bin/magick output-al2023_1/bin/heif-info 2>/dev/null || true

# Remove container
#docker rm $CONTAINER_ID

# Create a tarball for distribution
tar -czf output-al2023_1.tar.gz output-al2023_1/

echo "Binaries and libraries have been extracted to the 'output-al2023_1' directory"
echo "A tarball has been created as 'output-al2023_1.tar.gz'"
echo "Use the scripts in output-al2023_1/bin/run-convert.sh and output-al2023_1/bin/run-heif-info.sh to run the tools"

output-al2023_1/bin/convert --version