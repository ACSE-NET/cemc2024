import os

def create_markdown_for_directory(directory, output_file):
    with open(output_file, 'w') as f:
        f.write("# Directory Structure\n\n")
        for root, dirs, files in os.walk(directory):
            # Exclude the .git directory from being traversed
            dirs[:] = [d for d in dirs if d != '.git']
            
            # Determine whether to start indenting based on the presence of the 'resources' folder
            if 'resources' in root:
                # Calculate the indentation level based on depth within the 'resources' folder
                level = root.replace(directory, '').count(os.sep) - root.replace(directory, '').find('resources') // len(os.sep)
                indent = '\t' * level
            else:
                level = 0
                indent = ''
                
            if root != directory:  # Only add a folder heading if it's not the root directory
                f.write(f'{indent}- **{os.path.basename(root)}/**\n')
            sub_indent = '\t' * (level + 1 if 'resources' in root else 0)
            for file in files:
                # Skip unwanted files
                if file in ['.DS_Store', 'README.md', '.gitignore', output_file] or file.endswith('.py'):
                    continue
                file_path = os.path.relpath(os.path.join(root, file), directory)
                # Adjust indentation for files in the root directory
                if root == directory:
                    f.write(f'- [{file}]({file_path})\n')
                else:
                    f.write(f'{sub_indent}- [{file}]({file_path})\n')

if __name__ == "__main__":
    current_directory = os.getcwd()  # Get the current directory
    output_markdown_file = "directory_structure.md"
    create_markdown_for_directory(current_directory, output_markdown_file)
    print(f'Markdown file created: {output_markdown_file}')