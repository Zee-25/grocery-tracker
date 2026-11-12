# Grocery Inflation Tracker

How much more does a Canadian family's grocery basket cost than in 2019, and which foods drove the increase?

## Key findings
- **The basket rose 29.5% since 2019.** A family of four's weekly staples went from **$84.88 (Jan 2019)** to **$109.92 (Sep 2026)**, about **$1,300 more per year** for the same groceries.
- **Ground beef was the biggest driver.** It nearly doubled ($8.80 → $16.92/kg, +92%) and accounts for **32% of the total increase**, consistent with the beef price surge noted in Canada's Food Price Report 2026.
- **Protein and dairy drove ~78% of the increase.** Beef, chicken, milk, eggs and cheese added the most dollars to the weekly bill.
- **A high percentage increase doesn't always mean high impact.** Coffee rose 75% but contributed only 8% of the increase, because families buy smaller quantities.
- **Some produce got cheaper.** Potatoes and tomatoes fell about 20%, partly offsetting the increase.
- **Inflation is slowing.** Year-over-year increases eased from 4.1% (Jun 2026) to 2.7% (Sep 2026), below Dalhousie's 4–6% forecast for food overall.

| Item | Jan 2019 | Sep 2026 | Change | Share of increase |
|---|---|---|---|---|
| Ground beef, per kg | $8.80 | $16.92 | +92.3% | 32.4% |
| Chicken breasts, per kg | $11.97 | $14.48 | +21.0% | 15.0% |
| Milk, 4 L | $5.29 | $6.99 | +32.1% | 13.6% |
| Eggs, 1 dozen | $3.30 | $4.83 | +46.4% | 12.2% |
| Coffee, 340 g | $5.31 | $9.27 | +74.6% | 7.9% |

## Data
- Statistics Canada, *Monthly average retail prices for selected products* (Table 18-10-0245-01), pulled via the StatCan Web Data Service API
- Coverage: January 2017 to September 2026, national average (Canada)

## Basket method
The basket contains 15 weekly staples for a family of four, covering all Canada's Food Guide groups (vegetables and fruit, protein foods, grains, dairy). Items were limited to products with a complete monthly price history since January 2019. Quantities are estimates and are listed in `data/basket.csv`.

The approach is modelled on Ontario's Nutritious Food Basket, the method public health units use to cost a healthy diet for a reference family of four (Public Health Ontario, 2025). Results are compared against Canada's Food Price Report 2026 (Dalhousie University), which forecasts food prices rising 4–6% in 2026.

## Data quality checks
- All 15 basket items have a price in every month from 2017 to 2026 (items_priced = 15 for all months)
- The item-level breakdown reconciles to the total basket increase ($25.02 vs $25.04, difference due to rounding)
- No zero, negative or duplicate prices after cleaning

## Project structure
- `notebooks/`: data pull, exploration and cleaning
- `sql/`: basket cost, year-over-year change, headline and item driver queries
- `data/`: cleaned data and basket definition
- `dashboard/`: Power BI file (in progress)

## Tools
Python (Pandas), MySQL, SQL (CTEs, window functions), Git

## Limitations
- The basket covers staples only, so its cost is lower than total family food spending.
- Prices are national averages and don't capture provincial, city or store-level differences.
- Package-size changes (shrinkflation) are not captured.
- Basket quantities are estimates.

## Next steps
- Python charts and statistical test of whether inflation has slowed
- Ontario vs other provinces comparison
- Power BI dashboard with monthly automated refresh

## References
- Statistics Canada, Table 18-10-0245-01: https://www150.statcan.gc.ca/t1/tbl1/en/tv.action?pid=1810024501
- Canada's Food Price Report 2026, Dalhousie University: https://www.dal.ca/sites/agri-food/research/canada-s-food-price-report-2026.html
- Public Health Ontario, Food Insecurity & Food Affordability in Ontario (2025): https://www.publichealthontario.ca/-/media/Documents/F/25/food-insecurity-food-affordability.pdf