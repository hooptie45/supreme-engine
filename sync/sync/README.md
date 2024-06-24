# SyncProject

SyncProject is a utility for synchronizing project files from a YAML input. It supports reading YAML content from standard input and creating the specified files and directories.

## Usage

To use SyncProject, you can pipe the YAML content directly into the script:

```sh
pbpaste | ruby sync/sync_project.rb
```

### Arguments

- `--path`: Optional. Base path to narrow the scope of files processed.

## Example

Here's an example of the YAML content:

```yaml
files:
  - path: "test/file1.txt"
    content: |
      Hello, this is file 1.
  - path: "test/file2.txt"
    content: |
      Hi, this is file 2.
  - path: "test/file3.txt"
    content: |
      Hey, this is file 3.
```

Copy the above content and run the following command:

```sh
pbpaste | ruby sync/sync_project.rb
```

This will create the specified files in your project.
