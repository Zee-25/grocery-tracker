# Grocery Inflation Tracker

How much more does a Canadian family's grocery basket cost than in 2019, and which foods drove the increase?

## Key findings
- **The basket rose 32.9% since 2019.** A family of four's average weekly staples cost went from **$83.91 in 2019** to **$111.54 over the last 12 months (Oct 2025 to Sep 2026)**, about **$1,437 more per year** for the same groceries.
- **Ground beef was the biggest driver.** Its average price rose 74% ($9.22 → $16.08/kg) and it accounts for **25% of the total increase**, consistent with the beef price surge noted in Canada's Food Price Report 2026.
- **Protein and dairy drove about two-thirds of the increase.** Beef, chicken, milk, eggs and cheese account for 66% of the extra weekly cost.
- **Every item in the basket got more expensive.** Increases ranged from +2.8% (potatoes) to +80.8% (coffee).
- **A high percentage increase doesn't always mean high impact.** Coffee rose the most (+81%) but contributed only 8% of the increase, because families buy smaller quantities.
- **Inflation is slowing.** Year-over-year increases eased from 4.1% (Jun 2026) to 2.7% (Sep 2026), below Dalhousie's 4–6% forecast for food overall.

| Item | Avg 2019 | Avg last 12 months | Change | Share of increase |
|---|---|---|---|---|
| Ground beef, per kg | $9.22 | $16.08 | +74.4% | 24.8% |
| Chicken breasts, per kg | $11.81 | $14.58 | +23.4% | 15.0% |
| Milk, 4 L | $5.23 | $6.93 | +32.5% | 12.3% |
| Eggs, 1 dozen | $3.40 | $4.80 | +41.3% | 10.2% |
| Coffee, 340 g | $5.20 | $9.39 | +80.8% | 7.6% |

## Data
- Statistics Canada, *Monthly average retail prices for selected products* (Table 18-10-0245-01), pulled via the StatCan Web Data Service API
- Coverage: January 2017 to September 2026, national average (Canada)

## Basket method
The basket contains 15 weekly staples for a family of four, covering all Canada's Food Guide groups (vegetables and fruit, protein foods, grains, dairy). Items were limited to products with a complete monthly price history since January 2019. Quantities are estimates and are listed in `data/basket.csv`.

The approach is modelled on Ontario's Nutritious Food Basket, the method public health units use to cost a healthy diet for a reference family of four (Public Health Ontario, 2025). Results are compared against Canada's Food Price Report 2026 (Dalhousie University), which forecasts food prices rising 4–6% in 2026.

## Data quality checks
- All 15 basket items have a price in every month from 2017 to 2026 (items_priced = 15 for all months)
- The item-level breakdown reconciles exactly to the total basket increase ($27.63)
- No zero, negative or duplicate prices after cleaning
- **Seasonality:** several produce items swing strongly by season (tomatoes peak in winter, potatoes bottom out at harvest). An early version compared January 2019 with September 2026, which made potatoes and tomatoes appear ~20% cheaper and understated the total increase (29.5%). All comparisons now use 12-month averages (2019 vs. the latest 12 months) to remove seasonal effects.

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