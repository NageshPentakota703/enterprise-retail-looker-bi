import sys
import unittest
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parents[1] / "scripts"))
from validate_data import validate, read

class RetailDataTests(unittest.TestCase):
    def test_integrity_and_metrics(self):
        result = validate()
        self.assertEqual(result["orders"], 120)
        self.assertGreater(result["completed_orders"], 0)
        self.assertGreater(result["revenue"], result["gross_profit"])
        self.assertEqual(result["aov"] * result["completed_orders"], result["revenue"])

    def test_fact_grain_and_multi_item_orders(self):
        items = read("order_items.csv")
        self.assertEqual(len(items), len({r["order_item_id"] for r in items}))
        self.assertGreater(len(items), len({r["order_id"] for r in items}))

    def test_cancelled_orders_exist_for_filter_testing(self):
        orders = read("orders.csv")
        self.assertTrue(any(r["status"] == "cancelled" for r in orders))

if __name__ == "__main__":
    unittest.main()
