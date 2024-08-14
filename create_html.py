import os

def create_html_for_directory(directory, output_file):
    with open(output_file, 'w') as f:
        f.write("<!DOCTYPE html>\n<html>\n<head>\n<title>Directory Structure</title>\n</head>\n<body>\n")
        f.write("<h1>2024 CEMC Summer Conference for CS Teachers &mdash; Resources</h1>\n<ul>\n")
        
        for root, dirs, files in os.walk(directory):
            # Sort directories and files alphabetically
            dirs.sort()
            files.sort()
            
            # Exclude the .git directory from being traversed
            dirs[:] = [d for d in dirs if d != '.git']
            
            # Determine the relative path from the root to the current directory
            relative_path = os.path.relpath(root, directory)
            if 'resources' in relative_path:
                # Calculate the indentation level based on depth within the 'resources' folder
                level = relative_path.count(os.sep)
                indent = '\t' * level
            else:
                indent = ''
                
            if root != directory:  # Only add a folder heading if it's not the root directory
                f.write(f'{indent}<li><strong>{os.path.basename(root)}/</strong>\n<ul>\n')
            
            for file in files:
                # Skip unwanted files including the output HTML file itself
                if file in ['.DS_Store', 'README.md', '.gitignore', output_file] or file.endswith('.py'):
                    continue
                file_path = os.path.relpath(os.path.join(root, file), directory)
                # Adjust indentation for files in the root directory
                if root == directory:
                    f.write(f'<li><a href="{file_path}">{file}</a></li>\n')
                else:
                    f.write(f'{indent}\t<li><a href="{file_path}">{file}</a></li>\n')
            
            if root != directory:
                f.write(f'{indent}</ul>\n</li>\n')
        
        f.write("</ul>\n</body>\n</html>")

if __name__ == "__main__":
    current_directory = os.getcwd()  # Get the current directory
    output_html_file = "index.html"
    create_html_for_directory(current_directory, output_html_file)
    print(f'HTML file created: {output_html_file}')