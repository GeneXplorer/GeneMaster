import os
from app.genemaster.Utils.utils import run_subprocess

class GenomeSequencing:
    def __init__(self, input_file, reference_genome, adapter_file, output_dir):
        self.input_file = input_file
        self.reference_genome = reference_genome
        self.adapter_file = adapter_file
        self.output_dir = output_dir

        if not os.path.exists(output_dir):
            os.makedirs(output_dir)

        self.qc_output_dir = os.path.join(output_dir, "qc")
        self.trimmed_output_file = os.path.join(output_dir, "trimmed.fastq")
        self.aligned_output_file = os.path.join(output_dir, "aligned.sam")
        self.bam_output_file = os.path.join(output_dir, "aligned.bam")
        self.sorted_bam_output_file = os.path.join(output_dir, "aligned_sorted.bam")
        self.assembly_output_dir = os.path.join(output_dir, "assembly")
        self.annotation_output_dir = os.path.join(output_dir, "annotation")

    def quality_control(self):
        print("Running FastQC...")
        run_subprocess(f"fastqc {self.input_file} -o {self.qc_output_dir}")
        print("FastQC complete.")

    def trim_reads(self):
        print("Running Trimmomatic...")
        run_subprocess(f"trimmomatic SE -phred33 {self.input_file} {self.trimmed_output_file} ILLUMINACLIP:{self.adapter_file}:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36")
        print("Trimmomatic complete.")

    def align_reads(self):
        print("Running BWA...")
        run_subprocess(f"bwa index {self.reference_genome}")
        run_subprocess(f"bwa mem {self.reference_genome} {self.trimmed_output_file} > {self.aligned_output_file}")
        print("BWA alignment complete.")

    def convert_to_bam(self):
        print("Converting SAM to BAM...")
        run_subprocess(f"samtools view -S -b {self.aligned_output_file} > {self.bam_output_file}")
        print("Conversion to BAM complete.")

    def sort_bam(self):
        print("Sorting BAM file...")
        run_subprocess(f"samtools sort {self.bam_output_file} -o {self.sorted_bam_output_file}")
        print("Sorting BAM complete.")

    def assemble_genome(self):
        print("Running SPAdes...")
        run_subprocess(f"spades.py -s {self.trimmed_output_file} -o {self.assembly_output_dir}")
        print("SPAdes genome assembly complete.")

    def annotate_genome(self):
        print("Running Prokka...")
        run_subprocess(f"bakta --outdir {self.annotation_output_dir} --prefix annotation {self.sorted_bam_output_file}")
        print("Bakta annotation complete.")

    def run_pipeline(self):
        self.quality_control()
        self.trim_reads()
        self.align_reads()
        self.convert_to_bam()
        self.sort_bam()
        self.assemble_genome()
        self.annotate_genome()
        print("Pipeline complete.")

