with open("scratch/expanded_part1.lua", "r", encoding="utf-8") as f:
    p1 = f.read()

with open("scratch/expanded_part2.lua", "r", encoding="utf-8") as f:
    p2 = f.read()

with open("scratch/expanded_part3.lua", "r", encoding="utf-8") as f:
    p3 = f.read()

with open("scratch/expanded_part4.lua", "r", encoding="utf-8") as f:
    p4 = f.read()

full_code = p1 + p2 + p3 + p4

with open("anewgame_pinathub.lua", "w", encoding="utf-8") as f:
    f.write(full_code)

print("Assembled anewgame_pinathub.lua successfully!")
print("Total characters:", len(full_code))
print("Total lines:", len(full_code.splitlines()))
