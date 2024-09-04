#!/bin/usr

PORT=3000
DOC_TYPE="guides"
OUTPUT_DIR="generated_pdf"
OUTPUT_FILENAME="wb_dev_guide.pdf"

initialDocURLs="http://localhost:$PORT/$DOC_TYPE/"
WORKING_DIR=$PWD
OUTPUT_PATH="$WORKING_DIR/$OUTPUT_DIR"


# Check if output path exists
if [ -d $OUTPUT_PATH ]; then
    echo "Output filepath exists...skipping making output directory"
else
    echo "Creating output filepath..."
    mkdir $OUTPUT_PATH
fi

# Find the PID of the process using the specified port
PID=$(lsof -t -i:$PORT)

# Check if a PID was found
if [ -n "$PID" ]; then
    echo "Port $PORT is in use by process $PID. Killing it..."
    
    # Kill the process
    kill -9 "$PID"
    
    # Check if the process was killed successfully
    if [ $? -eq 0 ]; then
        echo "Process $PID killed successfully."
    else
        echo "Failed to kill process $PID."
        exit 1
    fi
else
    echo "Port $PORT is not in use."
fi

# Check if repo exists
if [ -d "$WORKING_DIR/docodile" ]; then
  echo "GitHub repo exists..."
  cd docodile
  echo "Checkout out main..."
  git checkout main
  git pull
else
    git clone https://github.com/wandb/docodile.git
    cd docodile
fi

# Install React app
yarn install 

# Start local server and give server some time before it handles requests
yarn start &  
sleep 10 

# Copy processing script to docodile
cp "$WORKING_DIR/scripts/removeTags.js" "$WORKING_DIR/docodile/scripts/"

# Remove accordian tags because this breaks PDF generator
node ./scripts/removeTags.js 

# Create PDF with docs-to-pdf
npx docs-to-pdf --initialDocURLs=$initialDocURLs \
    --contentSelector="article" \
    --paginationSelector="a.pagination-nav__link.pagination-nav__link--next" \
    --excludeSelectors=".margin-vert--xl a,[class^='tocCollapsible'],.breadcrumbs,.theme-edit-this-page" \
    --protocolTimeout="7200000" \
    --coverSub="Documentation" \
    --coverTitle="Weights & Biases" \
    --outputPDFFilename="$OUTPUT_PATH/$OUTPUT_FILENAME"
    # --coverImage="https://docusaurus.io/img/docusaurus.png" \

