from roman import Roman

sum = 0
with open('p089_roman.txt', 'r') as file:
    for line in file:
        line = line.strip()
        print(line)
        roman = Roman(line)
        print('Decimal: ', roman.to_decimal())
        minimal = Roman(Roman(line).to_decimal()).to_str()
        print('Minimal: ' + minimal)
        saved = len(line) - len(minimal)
        print('Saved: ', saved)
        print()
        sum += saved

print('Answer:', sum)
