# Thor Integration for Script Writing and Code Generation

## Overview

This document outlines the usage of Thor for generating design document structures in the ai-bootstrap project.

## Goals
- Simplify the creation of standardized design document structures.
- Automate repetitive tasks using Thor generators.
- Ensure consistency across all generated documents.

## Thor Generator

### Directory Structure

- **lib/generators/**: Contains the Thor generator scripts.
- **templates/**: Contains the template files used by the generator.

### Generator Script

The main generator script is `lib/generators/design_document_generator.rb`. It defines the structure and content of the generated files.

### Templates

Template files are located in the `templates/` directory. They are processed by the generator to create the final files.

### Usage

To generate a new design document structure, run the following command:

```sh
ruby script/generate_design_doc_structure.rb <project_name>