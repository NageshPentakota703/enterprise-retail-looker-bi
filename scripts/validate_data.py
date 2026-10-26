"""Local, dependency-free data checks for the synthetic retail dataset."""
from pathlib import Path
import csv
from decimal import Decimal

ROOT = Path(__file__).resolve().parents[1]

def read(name):
    with (ROOT / "data" / name).open(newline="", encoding="utf-8") as f:
        return list(csv.DictReader(f))

def validate():
    customers, products, orders, items = (read(n) for n in ("customers.csv", "products.csv", "orders.csv", "order_items.csv"))
    for label, rows, key in (("customers", customers, "customer_id"), ("products", products, "product_id"), ("orders", orders, "order_id"), ("items", items, "order_item_id")):
        keys = [r[key] for r in rows]
        assert all(keys), f"{label}: missing primary key"
        assert len(keys) == len(set(keys)), f"{label}: duplicate primary key"
    cust_ids = {r["customer_id"] for r in customers}
    prod_ids = {r["product_id"] for r in products}
    order_lookup = {r["order_id"]: r for r in orders}
    assert all(o["customer_id"] in cust_ids for o in orders), "orphan customer"
    assert all(i["order_id"] in order_lookup and i["product_id"] in prod_ids for i in items), "orphan item"
    assert all(o["status"] in {"completed", "cancelled"} for o in orders)
    assert all(int(i["quantity"]) > 0 and Decimal(i["unit_price"]) >= 0 and Decimal(i["unit_cost"]) >= 0 for i in items)
    completed = [i for i in items if order_lookup[i["order_id"]]["status"] == "completed"]
    revenue = sum((Decimal(i["quantity"]) * Decimal(i["unit_price"]) for i in completed), Decimal(0))
    profit = sum((Decimal(i["quantity"]) * (Decimal(i["unit_price"]) - Decimal(i["unit_cost"])) for i in completed), Decimal(0))
    count = len({i["order_id"] for i in completed})
    return {"customers": len(customers), "products": len(products), "orders": len(orders), "order_items": len(items), "completed_orders": count, "revenue": revenue, "gross_profit": profit, "aov": revenue / count if count else None}

if __name__ == "__main__":
    for key, value in validate().items():
        print(f"{key}: {value}")
    print("PASS: primary keys, relationships, value constraints, and metric calculations")
