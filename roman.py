class Roman:
    CHAR_TO_INT = {
        'I': 1,
        'V': 5,
        'X': 10,
        'L': 50,
        'C': 100,
        'D': 500,
        'M': 1000
    }

    COMBS = [
        ['M', 1000],
        ['CM', 900],
        ['D', 500],
        ['CD', 400],
        ['C', 100],
        ['XC', 90],
        ['L', 50],
        ['XL', 40],
        ['X', 10],
        ['IX', 9],
        ['V', 5],
        ['IV', 4],
        ['I', 1],
    ]

    def __init__(self, value):
        if isinstance(value, str):
            self.string_value = value
        if isinstance(value, int):
            self.decimal_value = value

    def to_decimal(self):
        result = 0
        max_char = 0
        for c in reversed(self.string_value):
            char_value = self.CHAR_TO_INT[c]
            if char_value >= max_char:
                result += char_value
                max_char = char_value
            else:
                result -= char_value
        return result

    def to_str(self):
        if self.decimal_value <= 0:
            return ''
        for comb in self.COMBS:
            combkey = comb[0]
            combval = comb[1]
            if self.decimal_value >= combval:
                return combkey + Roman(self.decimal_value - combval).to_str()
