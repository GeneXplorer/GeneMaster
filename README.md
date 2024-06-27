# GeneMaster

## Description
GeneMaster is a comprehensive bioinformatics CLI tool designed to streamline the analysis of DNA, RNA, and protein sequencing data. It integrates the best tools for sequence handling, alignment, variant calling, and functional analysis into a single, easy-to-use command-line interface.

## Installation
```sh
pip install .
```

## Usage
To start the tool and choose the type of analysis:
```sh
genemaster start
```

### DNA Analysis Commands:
- **Read sequences from a FASTA file**
  ```sh
  genemaster read_fasta <file_path>
  ```

- **Align two sequences**
  ```sh
  genemaster align_sequences <seq1> <seq2>
  ```

- **Run BLAST**
  ```sh
  genemaster run_blast <query> <db> <output>
  ```

- **Read VCF file**
  ```sh
  genemaster read_vcf <file_path>
  ```

### RNA Analysis Commands:
- **Read sequences from a FASTQ file**
  ```sh
  genemaster read_fastq <file_path>
  ```

- **Quantify gene expression**
  ```sh
  genemaster quantify_expression <seq_file> <index> <output>
  ```

- **Perform differential expression analysis**
  ```sh
  genemaster differential_expression <counts_file> <design_file> <output>
  ```

### Protein Analysis Commands:
- **Read sequences from a FASTA file (Protein)**
  ```sh
  genemaster read_fasta_protein <file_path>
  ```

- **Predict protein structure**
  ```sh
  genemaster predict_structure <seq_file> <output>
  ```

- **Analyze protein domains**
  ```sh
  genemaster analyze_domains <seq_file> <output>
  ```

## Contributing
Contributions are welcome! Please submit a pull request or open an issue for suggestions.
