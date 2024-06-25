

### Design Document for Multi-Language Project Structure

#### 1. Overview

This document outlines the structure for an AI project that supports functions, assistants, and memory management across multiple programming languages. The goal is to create a flexible and organized project that allows for functions to be written in various languages while maintaining a cohesive structure for development, testing, and deployment.

#### 2. Goals and Non-Goals

**Goals**:
- Define a clear and organized project structure supporting multiple programming languages.
- Enable seamless integration of API functions, assistants, and memory management.
- Support development, testing, and deployment workflows across different languages.
- Implement secrets management for API keys.
- Facilitate local and CI/CD testing and deployment.

**Non-Goals**:
- This document does not cover the implementation of specific AI functionalities in detail.
- Does not cover frontend integration details.

#### 3. Project Structure

The project will be structured with a root folder `ai_project`, containing subfolders for each type of component (functions, completions, assistants, memory), with subfolders for each language.

```
ai_project/
├── functions/
│   ├── python/
│   │   ├── __init__.py
│   │   ├── function1.py
│   │   ├── function2.py
│   │   └── tests/
│   │       ├── test_function1.py
│   │       └── test_function2.py
│   ├── ruby/
│   │   ├── function1.rb
│   │   ├── function2.rb
│   │   └── tests/
│   │       ├── test_function1.rb
│   │       └── test_function2.rb
│   └── other_languages/
│       ├── function1.<ext>
│       ├── function2.<ext>
│       └── tests/
│           ├── test_function1.<ext>
│           └── test_function2.<ext>
├── completions/
│   ├── prompt_parts/
│   │   ├── part1.txt
│   │   ├── part2.txt
│   │   └── partN.txt
│   ├── generate_prompt.py
│   └── tests/
│       └── test_generate_prompt.py
├── assistants/
│   ├── python/
│   │   ├── assistant1.py
│   │   ├── assistant2.py
│   │   └── tests/
│   │       ├── test_assistant1.py
│   │       └── test_assistant2.py
│   ├── ruby/
│   │   ├── assistant1.rb
│   │   ├── assistant2.rb
│   │   └── tests/
│   │       ├── test_assistant1.rb
│   │       └── test_assistant2.rb
│   └── other_languages/
│       ├── assistant1.<ext>
│       ├── assistant2.<ext>
│       └── tests/
│           ├── test_assistant1.<ext>
│           └── test_assistant2.<ext>
├── memory/
│   ├── python/
│   │   ├── memory_management.py
│   │   └── tests/
│   │       └── test_memory_management.py
│   ├── ruby/
│   │   ├── memory_management.rb
│   │   └── tests/
│   │       └── test_memory_management.rb
│   └── other_languages/
│       ├── memory_management.<ext>
│       └── tests/
│           ├── test_memory_management.<ext>
├── scripts/
│   ├── deploy.py
│   ├── manage_secrets.py
│   └── call_openai_api.py
├── config/
│   ├── secrets.json
│   ├── openai_config.yml
│   └── deployment_config.yml
├── tests/
│   ├── conftest.py
│   └── integration/
│       ├── test_integration.py
└── README.md
```

#### 4. Components

**Functions**:
- Implement individual API functions in separate files within their respective language directories.
- Write unit tests for each function in the corresponding `tests` folder.

**Completions**:
- Store prompt parts in `completions/prompt_parts`.
- Combine prompt parts using Jinja2 templates (or a similar tool) in `generate_prompt.py`.
- Write unit tests for prompt generation in `completions/tests`.

**Assistants**:
- Implement assistant logic in separate files within their respective language directories.
- Write unit tests for each assistant in the corresponding `tests` folder.

**Memory**:
- Implement memory management logic in separate files within their respective language directories.
- Write unit tests for memory management in the corresponding `tests` folder.

#### 5. Configuration and Secrets Management

**Configuration**:
- Store configuration files in the `config` directory.
- Use YAML for configuration files (e.g., `openai_config.yml`, `deployment_config.yml`).

**Secrets Management**:
- Store API keys and secrets in `config/secrets.json`.
- Use environment variables or a secrets management tool (e.g., AWS Secrets Manager) to securely manage sensitive information.
- Implement `scripts/manage_secrets.py` to handle secrets.

**Example `secrets.json`**:
```json
{
  "openai_api_key": "YOUR_OPENAI_API_KEY"
}
```

#### 6. Scripts

**Deployment Script** (`scripts/deploy.py`):
- Automate deployment using infrastructure as code tools (e.g., Terraform, AWS CloudFormation).

**Example**:
```python
import os
import subprocess

def deploy():
    # Add deployment logic here
    subprocess.run(["terraform", "apply"])

if __name__ == "__main__":
    deploy()
```

**Secrets Management Script** (`scripts/manage_secrets.py`):
- Handle fetching and storing secrets securely.

**Calling OpenAI API Script** (`scripts/call_openai_api.py`):
- Script to call OpenAI API with provided prompts and configurations.

**Example**:
```python
import openai
import json

def load_secrets():
    with open('config/secrets.json') as f:
        return json.load(f)

def call_openai(prompt):
    secrets = load_secrets()
    openai.api_key = secrets['openai_api_key']
    response = openai.Completion.create(
        engine="davinci",
        prompt=prompt,
        max_tokens=50
    )
    print(response.choices[0].text)

if __name__ == "__main__":
    prompt = "Once upon a time"
    call_openai(prompt)
```

#### 7. Testing Strategy

**Unit Tests**:
- Use `pytest` for Python and `rspec` for Ruby.
- Write tests for each component in their respective `tests` folders.

**Functional Tests**:
- Test the integration of multiple components in `tests/integration`.

**Example Functional Test** (`tests/integration/test_integration.py`):
```python
def test_function_and_memory_integration():
    from functions.python import function1
    from memory.python import memory_management

    result = function1.do_something()
    memory_management.store_result(result)
    assert memory_management.retrieve_result() == result
```

**CI/CD Integration**:
- Use GitHub Actions or another CI/CD tool to automate testing and deployment.
- Define workflows for running tests and deploying the application.

**Example GitHub Actions Workflow**:
```yaml
name: CI/CD Pipeline

on:
  push:
    branches:
      - main

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: Set up Python
        uses: actions/setup-python@v2
        with:
          python-version: '3.8'
      - name: Install dependencies
        run: |
          pip install -r requirements.txt
          gem install bundler
          bundle install
      - name: Run tests
        run: |
          pytest
          rspec
  deploy:
    runs-on: ubuntu-latest
    needs: test
    steps:
      - uses: actions/checkout@v2
      - name: Set up Python
        uses: actions/setup-python@v2
        with:
          python-version: '3.8'
      - name: Deploy
        run: |
          python scripts/deploy.py
```

#### 8. Deployment Strategy

1. **Development Environment**:
   - Use local virtual environments and Docker containers to simulate production environments.
   - Use scripts to manage deployment in development environments.

2. **Testing Environment**:
   - Set up a staging environment that mirrors production for integration and functional testing.
   - Implement CI/CD pipelines to automate testing and deployment to the staging environment.

3. **Production Environment**:
   - Use infrastructure as code tools (e.g., Terraform, AWS CloudFormation) to manage production infrastructure.
