import click
from app.genemaster.DNA import GenomeSequencing

@click.command()
@click.argument('input_file')
@click.argument('reference_genome')
@click.argument('adapter_file')
@click.argument('output_dir')
def run_pipeline(input_file, reference_genome, adapter_file, output_dir):
    """Run the genome sequencing pipeline with the provided input file, reference genome, adapter file, and output directory."""
    pipeline = GenomeSequencing(input_file, reference_genome, adapter_file, output_dir)
    pipeline.run_pipeline()

if __name__ == "__main__":
    run_pipeline()