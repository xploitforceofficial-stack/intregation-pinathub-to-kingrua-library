import re
import sys

def validate_lua(filepath):
    with open(filepath, 'r', encoding='utf-8') as f:
        text = f.read()

    lines = text.split('\n')
    stack = []
    errors = []

    in_multiline_comment = False
    in_multiline_string = False

    for line_idx, line in enumerate(lines):
        line_num = line_idx + 1
        i = 0
        n = len(line)

        clean_line = ""
        while i < n:
            if not in_multiline_comment and not in_multiline_string:
                if line[i:i+4] == "--[[":
                    in_multiline_comment = True
                    i += 4
                    continue
                elif line[i:i+2] == "--":
                    break
                elif line[i:i+2] == "[[":
                    in_multiline_string = True
                    i += 2
                    continue
                else:
                    clean_line += line[i]
                    i += 1
            elif in_multiline_comment:
                if line[i:i+2] == "]]":
                    in_multiline_comment = False
                    i += 2
                else:
                    i += 1
            elif in_multiline_string:
                if line[i:i+2] == "]]":
                    in_multiline_string = False
                    i += 2
                else:
                    i += 1

        # Remove string literals
        clean_no_strings = re.sub(r'"([^"\\]|\\.)*"', '""', clean_line)
        clean_no_strings = re.sub(r"'([^'\\]|\\.)*'", "''", clean_no_strings)

        # Match tokens
        tokens = re.findall(r'\b(function|if|elseif|then|do|repeat|end|until)\b', clean_no_strings)
        idx = 0
        while idx < len(tokens):
            t = tokens[idx]
            if t == 'function':
                stack.append(('function', line_num))
            elif t == 'if':
                stack.append(('if', line_num))
            elif t == 'elseif':
                pass # part of existing 'if' block
            elif t == 'then':
                # associated with if or elseif
                pass
            elif t == 'do':
                stack.append(('do', line_num))
            elif t == 'repeat':
                stack.append(('repeat', line_num))
            elif t == 'end':
                if not stack:
                    errors.append(f"Line {line_num}: Unexpected 'end' without opening block")
                else:
                    opener, op_line = stack.pop()
                    if opener not in ('function', 'if', 'do'):
                        errors.append(f"Line {line_num}: 'end' matched unexpected '{opener}' from line {op_line}")
            elif t == 'until':
                if not stack:
                    errors.append(f"Line {line_num}: Unexpected 'until' without opening block")
                else:
                    opener, op_line = stack.pop()
                    if opener != 'repeat':
                        errors.append(f"Line {line_num}: 'until' matched unexpected '{opener}' from line {op_line}")
            idx += 1

    if stack:
        for opener, op_line in stack:
            errors.append(f"Unclosed '{opener}' opened at line {op_line}")

    if errors:
        print(f"Validation FAILED with {len(errors)} errors:")
        for err in errors[:30]:
            print(" -", err)
        return False
    else:
        print("Validation PASSED! 0 block syntax errors found.")
        return True

validate_lua('anewgame_pinathub.lua')
