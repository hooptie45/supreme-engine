Feature: Sync Project Files
  Scenario: Sync files from YAML input
    Given a YAML input
      """
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
      """
    When I run the sync_project script
    Then the following files should be created:
      | test/file1.txt |
      | test/file2.txt |
      | test/file3.txt |
