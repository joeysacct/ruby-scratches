filepath = "./chud.png"

output = []

ls_bits = []
with open(filepath, 'rb') as gar:
    content = gar.read()
    for char in content:
        ls_bits.append(char & 1)
j = 0
for offset in range(0,10):
    output = []
    for i in range(0,len(ls_bits), 8):
        byte = ls_bits[i+offset:i+8+offset]
        num = int("".join(map(str, byte)), 2)
        output.append(f"{chr(num)}")
        j = j + 1
        if j == 30:
            break
    print("".join(output))
# print("".join(chr(byte) for byte in output))
