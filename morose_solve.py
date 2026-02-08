std_alpha128 = {'a': 0, 'b': 1, 'c': 2, 'd': 3, 'e': 4, 'f': 5, 'g': 6, 'h': 7, 'i': 8, 'j': 9, 'k': 10, 'l': 11, 'm': 12, 'n': 13, 'o': 14, 'p': 15, 'q': 16, 'r': 17, 's': 18, 't': 19, 'u': 20, 'v': 21, 'w': 22, 'x': 23, 'y': 24, 'z': 25, 'A': 26, 'B': 27, 'C': 28, 'D': 29, 'E': 30, 'F': 31, 'G': 32, 'H': 33, 'I': 34, 'J': 35, 'K': 36, 'L': 37, 'M': 38, 'N': 39, 'O': 40, 'P': 41, 'Q': 42, 'R': 43, 'S': 44, 'T': 45, 'U': 46, 'V': 47, 'W': 48, 'X': 49, 'Y': 50, 'Z': 51, '0': 52, '1': 53, '2': 54, '3': 55, '4': 56, '5': 57, '6': 58, '7': 59, '8': 60, '9': 61, '!': 62, '"': 63, '#': 64, '$': 65, '%': 66, '&': 67, "'": 68, '(': 69, ')': 70, '*': 71, '+': 72, ',': 73, '-': 74, '.': 75, '/': 76, ':': 77, ';': 78, '<': 79, '=': 80, '>': 81, '?': 82, '@': 83, '[': 84, '\\': 85, ']': 86, '^': 87, '_': 88, '`': 89, '{': 90, '|': 91, '}': 92, '~': 93, '\n': 94, ' ': 95, '∀': 96, '∃': 97, '∄': 98, '∧': 99, '∨': 100, '⊥': 101, '⊤': 102, '∈': 103, '∪': 104, '∩': 105, '⊂': 106, '⊃': 107, '⊆': 108, '⊇': 109, '∅': 110, '∂': 111, '∇': 112, 'Δ': 113, '∑': 114, '∏': 115, 'π': 116, '∫': 117, '∞': 118, '√': 119, '≠': 120, '≤': 121, '≥': 122, '≈': 123, '≡': 124, '∴': 125, '∵': 126, '•': 127}

std_128alpha = {v: k for k,v in std_alpha128.items()}

with open('./morose_text.txt', 'r') as f:
    ciphertext = f.read()

plaintext = []
idx = 0
for char in ciphertext:
    num = std_alpha128[char]
    num = (num - idx) % 128
    plaintext_char = std_128alpha[num]
    # plaintext.append(f"{char} {plaintext_char} {idx % 128}") # for repairing mistakes in alphabet
    plaintext.append(plaintext_char)
    idx += 1

print(len(set(ciphertext)))
print(len(std_alpha128))
print([key for key in std_alpha128 if key not in set(ciphertext)])
# with open('./morose_plaintext.txt', 'w') as f:
    # f.write("\n".join(plaintext))
print("".join(plaintext))

# weirdblurb = "j[_∩"
# for i in range(128):
    # print("".join(std_128alpha[(std_alpha128[char] + i) % 128] for char in weirdblurb))
