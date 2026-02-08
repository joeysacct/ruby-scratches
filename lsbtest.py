from PIL import Image
import numpy as np

def lsb_to_text(integers):
    bits = []

    # Extract LSB from each integer
    for num in integers:
        bits.append(num & 1)  # get LSB


    bytes_to_skip = 4
    byte_list = []
    for i in range(0, len(bits), 8): # for each byte
        if i/8 < bytes_to_skip:
            continue
        # Take 8 bits at a time
        byte_bits = bits[i:i+8]
        # Convert bits to integer 
        byte_value = int(''.join(map(str, byte_bits)), 2) # MSB first version
        # byte_value = int(''.join(map(str, reversed(byte_bits))), 2) # LSB first version
        byte_list.append(byte_value) 

    # print(byte_list[0:50])
    byte_list = byte_list[0:5617]
    byte_data = bytes(byte_list)
    # print(bytes)

    utf8_string = byte_data.decode('utf-8')
    with open("morose_text.txt", "w") as output:
        output.write(utf8_string)

    k = 0
    for char in utf8_string[0:256]:
        print(f"{char} - {k}")
        k = k +1

        

    

filepath = "./chud.png"
img = Image.open(filepath)
raw_bytes = img.tobytes()
lsb_to_text(raw_bytes)

