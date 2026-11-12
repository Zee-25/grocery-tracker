"""Pull StatCan retail prices, clean them, and update the basket summary."""
import io
import zipfile
from pathlib import Path

import pandas as pd
import requests

ROOT = Path(__file__).resolve().parents[1]
DATA = ROOT / "data"
TABLE = "18100245"


def get_table(pid):
    url = f"https://www150.statcan.gc.ca/t1/wds/rest/getFullTableDownloadCSV/{pid}/en"
    r = requests.get(url, timeout=60)
    r.raise_for_status()
    zip_url = r.json()["object"]
    z = zipfile.ZipFile(io.BytesIO(requests.get(zip_url, timeout=300).content))
    return pd.read_csv(z.open(f"{pid}.csv"))


def clean(prices):
    df = prices[["REF_DATE", "GEO", "Products", "VALUE"]].copy()
    df.columns = ["date", "province", "product", "price"]
    df["date"] = pd.to_datetime(df["date"])
    df["product"] = df["product"].str.strip()
    df = df.dropna(subset=["price"])
    assert (df["price"] > 0).all(), "Found zero or negative prices"
    assert not df.duplicated(["date", "province", "product"]).any(), "Found duplicate rows"
    return df


def basket_summary(df, basket):
    m = df[df["province"] == "Canada"].merge(basket, on="product")
    m["cost"] = m["price"] * m["quantity"]
    g = m.groupby("date").agg(basket_cost=("cost", "sum"), items=("product", "count"))
    g = g[g["items"] == len(basket)].drop(columns="items")
    g["yoy_pct"] = (g["basket_cost"].pct_change(12) * 100).round(1)
    g["basket_cost"] = g["basket_cost"].round(2)
    return g.reset_index()


def main():
    basket = pd.read_csv(DATA / "basket.csv")
    df = clean(get_table(TABLE))

    # Stop if the newest month is missing any basket item
    latest = df["date"].max()
    latest_items = set(df[(df["province"] == "Canada") & (df["date"] == latest)]["product"])
    missing = set(basket["product"]) - latest_items
    if missing:
        raise SystemExit(f"Latest month {latest:%Y-%m} is missing basket items: {missing}")

    (DATA / "clean").mkdir(parents=True, exist_ok=True)
    df.to_csv(DATA / "clean" / "prices_clean.csv", index=False)

    summary = basket_summary(df, basket)
    summary.to_csv(DATA / "basket_monthly.csv", index=False)

    last = summary.iloc[-1]
    print(f"Rows: {len(df):,} | Latest month: {latest:%Y-%m} | "
          f"Weekly basket ${last.basket_cost:.2f} | YoY {last.yoy_pct:+.1f}%")


if __name__ == "__main__":
    main()