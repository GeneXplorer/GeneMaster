#!/bin/bash

# Create project directory structure
echo "Creating project directories and files..."
# Base directory name
base_dir=app/genemaster

# Create base directory if it doesn't exist
if [ ! -d "$base_dir" ]; then
  mkdir -p $base_dir
  mkdir -p $base_dir/tests
  echo "Created base directory: $base_dir"
else
  echo "Base directory already exists: $base_dir"
fi


# Define the VERSION file path
version_file="app/VERSION"

# Check if the VERSION file exists
if [ ! -f "$version_file" ]; then
  echo "VERSION file not found in $base_dir"
  echo "Creating VERSION file with initial version 0.0.1"
  echo "0.0.1" > "$version_file"
fi


# Create a virtual environment

if [ ! -d "penv" ]; then
  python3 -m venv penv
  echo "Creating virtual environment..."
else
  echo "Environment folder already exists"
fi

echo "To activate the virtual environment, use the following command based on your OS:"
# Activate virtual environment based on OS
if [[ "$OSTYPE" == "linux-gnu"* || "$OSTYPE" == "darwin"* ]]; then
    # Linux or macOS
    source penv/bin/activate
    echo "Linux/macOS: source penv/bin/activate"
elif [[ "$OSTYPE" == "cygwin" || "$OSTYPE" == "msys" || "$OSTYPE" == "win32" ]]; then
    # Windows
    source penv/Scripts/activate
    echo "Windows: source penv/Scripts/activate"
else
    echo "Unsupported OS: $OSTYPE"
    exit 1
fi

# DNA directory name
dna_folder=$base_dir/DNA

# Array of class names
dna_classes=("GenomeSequencing" "DNAExtraction" "DNAFragmentation" "LibraryPreparation" "Sequencing" "SequenceAssembly" "GenomeAnnotation" "DataAnalysis")

# Create base directory if it doesn't exist
if [ ! -d "$dna_folder" ]; then
  mkdir -p $dna_folder
  echo "Created  directory: $dna_folder"
else
  echo "Directory already exists: $dna_folder"
fi

# Iterate through class names to create directories and files
for class in "${dna_classes[@]}"
do
  # Create directory for each class if it doesn't exist
  dir="$dna_folder/$class"
  if [ ! -d "$dir" ]; then
    mkdir -p $dir
    echo "Created directory: $dir"
  else
    echo "Directory already exists: $dir"
  fi

  # Create an empty Python file with the class name if it doesn't exist
  if [ ! -f "$dir/${class}.py" ]; then
    touch "$dir/${class}.py"
    echo "Created file: $dir/${class}.py"
  else
    echo "File already exists: $dir/${class}.py"
  fi

  # Create an __init__.py file if it doesn't exist
  if [ ! -f "$dir/__init__.py" ]; then
    touch "$dir/__init__.py"
    echo "Created file: $dir/__init__.py"
  else
    echo "File already exists: $dir/__init__.py"
  fi

  # Create a README file for each class if it doesn't exist
  readme_file="$dir/README.md"
  if [ ! -f "$readme_file" ]; then
    echo "# $class" > "$readme_file"
    echo "This directory contains the implementation for the $class class." >> "$readme_file"
    echo "Created file: $readme_file"
  else
    echo "File already exists: $readme_file"
  fi
done

echo "DNA Directory structure created successfully."

# Create base directory if it doesn't exist
if [ ! -f "README.md" ]; then
  mkdir -p README.md
  echo "Created  directory: README.md"

  cat > README.md <<EOL
  # GeneMaster

  ## Description
  GeneMaster is a comprehensive bioinformatics CLI tool designed to streamline the analysis of DNA, RNA, and protein sequencing data. It integrates the best tools for sequence handling, alignment, variant calling, and functional analysis into a single, easy-to-use command-line interface.

  ## Installation
  \`\`\`sh
  pip install -e .
  \`\`\`

  ## Usage
  To start the tool and choose the type of analysis:
  \`\`\`sh
  genemaster start
  \`\`\`

  ### DNA Analysis Commands:
  - **Read sequences from a FASTA file**
    \`\`\`sh
    genemaster read_fasta <file_path>
    \`\`\`

  - **Align two sequences**
    \`\`\`sh
    genemaster align_sequences <seq1> <seq2>
    \`\`\`

  - **Run BLAST**
    \`\`\`sh
    genemaster run_blast <query> <db> <output>
    \`\`\`

  - **Read VCF file**
    \`\`\`sh
    genemaster read_vcf <file_path>
    \`\`\`

  ### RNA Analysis Commands:
  - **Read sequences from a FASTQ file**
    \`\`\`sh
    genemaster read_fastq <file_path>
    \`\`\`

  - **Quantify gene expression**
    \`\`\`sh
    genemaster quantify_expression <seq_file> <index> <output>
    \`\`\`

  - **Perform differential expression analysis**
    \`\`\`sh
    genemaster differential_expression <counts_file> <design_file> <output>
    \`\`\`

  ### Protein Analysis Commands:
  - **Read sequences from a FASTA file (Protein)**
    \`\`\`sh
    genemaster read_fasta_protein <file_path>
    \`\`\`

  - **Predict protein structure**
    \`\`\`sh
    genemaster predict_structure <seq_file> <output>
    \`\`\`

  - **Analyze protein domains**
    \`\`\`sh
    genemaster analyze_domains <seq_file> <output>
    \`\`\`
## Contributing
Contributions are welcome! Please submit a pull request or open an issue for suggestions.
EOL
else
  echo "Directory already exists: README.md"
fi

cat > requirements.txt <<EOL
    bakta>=1.8.1
    click>=8.1.7
    biopython>=1.83
    seaborn>=0.13.2
    matplotlib>=3.9.0
    setuptools>=70.1.1
EOL


echo "Updating pip & Installing required packages"

pip install -q --upgrade pip
pip install -q -r requirements.txt
pip freeze > requirements.txt


# Print completion message
echo "Setup complete. Virtual environment created and project structure initialized."




# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to install a tool if it does not exist
install_tool() {
    local tool_name=$1
    local install_command=$2
    local version_command=$3

    if command_exists $tool_name; then
        echo "$tool_name is already installed. Version:"
        eval $version_command
    else
        echo "$tool_name is not installed. Installing..."
        eval $install_command
        if command_exists $tool_name; then
            echo "$tool_name installation successful. Version:"
            eval $version_command
        else
            echo "Error installing $tool_name."
        fi
    fi
}

# Detect the OS type
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    # Linux
    package_manager="sudo apt-get install -y"
    wget_command="sudo apt-get install -y wget"
elif [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS
    package_manager="brew install"
    wget_command="brew install wget"
else
    echo "Unsupported OS: $OSTYPE"
    exit 1
fi

# Install wget if not already installed
install_tool "wget" "$wget_command" "wget --version"

# Install FastQC
install_tool "fastqc" "$package_manager fastqc" "fastqc --version"

# Install Trimmomatic
if [ ! -f "/usr/local/bin/trimmomatic.jar" ]; then
    echo "Trimmomatic is not installed. Installing..."
    wget http://www.usadellab.org/cms/uploads/supplementary/Trimmomatic/Trimmomatic-0.39.zip
    unzip Trimmomatic-0.39.zip
    sudo mv Trimmomatic-0.39/trimmomatic-0.39.jar /usr/local/bin/trimmomatic.jar
    echo "Trimmomatic installation successful."
else
    echo "Trimmomatic is already installed."
    java -jar /usr/local/bin/trimmomatic.jar -version
fi

# Install BWA
install_tool "bwa" "$package_manager bwa" "bwa 2>&1 | grep -m 1 'Version'"

# Install Samtools
install_tool "samtools" "$package_manager samtools" "samtools --version | head -n 1"

# Install SPAdes
if [[ "$OSTYPE" == "darwin"* ]]; then
    install_tool "spades.py" "brew install brewsci/bio/spades" "spades.py --version"
else
    install_tool "spades.py" "$package_manager spades" "spades.py --version"
fi

