#!/bin/bash

# Define the tool version
TOOL_VERSION="0.1.0"

# Create a virtual environment
echo "Creating virtual environment..."
python3 -m venv penv

# Activate virtual environment based on OS
if [[ "$OSTYPE" == "linux-gnu"* || "$OSTYPE" == "darwin"* ]]; then
    # Linux or macOS
    source penv/bin/activate
elif [[ "$OSTYPE" == "cygwin" || "$OSTYPE" == "msys" || "$OSTYPE" == "win32" ]]; then
    # Windows
    source penv/Scripts/activate
else
    echo "Unsupported OS: $OSTYPE"
    exit 1
fi

# Create project directory structure
echo "Creating project directories and files..."
mkdir -p app/genemaster
mkdir -p app/tests

touch app/genemaster/__init__.py
touch app/genemaster/cli.py
touch app/genemaster/dna_analysis.py
touch app/genemaster/rna_analysis.py
touch app/genemaster/protein_analysis.py
touch app/genemaster/utils.py

touch app/tests/test_dna_analysis.py
touch app/tests/test_rna_analysis.py
touch app/tests/test_protein_analysis.py

cat > setup.py <<EOL
from setuptools import setup, find_packages

setup(
    name='genemaster',
    version='$TOOL_VERSION',
    packages=find_packages(),
    install_requires=[
        'biopython>=1.83',
        'click>=8.1.7',
        'matplotlib>=3.9.0',
        'seaborn>=0.13.2',
        'pyvcf>=0.6.8',
        'gseapy>=1.1.3'
    ],
    entry_points={
        'console_scripts': [
            'genemaster=genemaster.cli:cli',
        ],
    },
)
EOL

cat > README.md <<EOL
# GeneMaster

## Description
GeneMaster is a comprehensive bioinformatics CLI tool designed to streamline the analysis of DNA, RNA, and protein sequencing data. It integrates the best tools for sequence handling, alignment, variant calling, and functional analysis into a single, easy-to-use command-line interface.

## Installation
\`\`\`sh
pip install .
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

cat > requirements.txt <<EOL
    biopython>=1.83
    click>=8.1.7
    matplotlib>=3.9.0
    seaborn>=0.13.2
    pyvcf>=0.6.8
    gseapy>=1.1.3
EOL

# Print completion message
echo "Setup complete. Virtual environment created and project structure initialized."
echo "To activate the virtual environment, use the following command based on your OS:"
echo "Linux/macOS: source penv/bin/activate"
echo "Windows: source penv/Scripts/activate"
