import unittest

from roman import Roman

class RomanTest(unittest.TestCase):
    def test_to_decimal(self):
        self.assertEqual(1, Roman('I').to_decimal())
        self.assertEqual(5, Roman('V').to_decimal())
        self.assertEqual(4, Roman('IV').to_decimal())
        self.assertEqual(13, Roman('XIII').to_decimal())
        self.assertEqual(1650, Roman('MDCL').to_decimal())

    def test_to_str(self):
        self.assertEqual('I', Roman(1).to_str())
        self.assertEqual('IV', Roman(4).to_str())
        self.assertEqual('IX', Roman(9).to_str())
        self.assertEqual('I', Roman(1).to_str())
        self.assertEqual('XLIX', Roman(49).to_str())
        self.assertEqual('LVII', Roman(57).to_str())
        self.assertEqual('CIV', Roman(104).to_str())
        self.assertEqual('CDXCV', Roman(495).to_str())
        self.assertEqual('CDXCVI', Roman(496).to_str())
        self.assertEqual('MDCL', Roman(1650).to_str())
        self.assertEqual('CMXCI', Roman(991).to_str())

if __name__ == '__main__':
    unittest.main()
