#!/usr/bin/env python3

import yaml
import os
import sys
import argparse

def create_files_from_yaml(data, base_path=None):
    summaries = []

    for file in data['files']:
        path = file['path']
        if base_path and not path.startswith(base_path):
            continue
        content = file['content']
        os.makedirs(os.path.dirname(path), exist_ok=True)
        with open(path, 'w') as f:
            f.write(content)
        summaries.append(f"{path}: {content.splitlines()[0]}")

    return summaries

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Sync project files from YAML input.")
    parser.add_argument('--path', type=str, help='Base path to narrow the scope of files processed.')
    args = parser.parse_args()

    # Read YAML content from standard input
    yaml_content = sys.stdin.read()
    data = yaml.safe_load(yaml_content)

    summaries = create_files_from_yaml(data, args.path)

    for summary in summaries:
        print(summary)
