from setuptools import setup, find_packages

setup(
    name='genemaster',
    version='',
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
