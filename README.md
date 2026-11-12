# Grocery Inflation Tracker

How much more does a Canadian family's grocery basket cost than in 2019, and which foods drove the increase?

## Data
- Statistics Canada, Monthly average retail prices for selected products (Table 18-10-0245-01), pulled via the StatCan Web Data Service API

## Basket method
The basket contains 15 weekly staples for a family of four, covering all Canada's Food Guide groups (vegetables and fruit, protein foods, whole grains, dairy). Items were limited to products with a complete monthly price history since January 2019. Quantities are estimates and are listed in `data/basket.csv`.

The approach is modelled on Ontario's Nutritious Food Basket, the method public health units use to cost a healthy diet for a reference family of four (Public Health Ontario, 2025). Results are compared against Canada's Food Price Report 2026 (Dalhousie University), which projects a family of four will spend $17,571.79 on food in 2026.

## Project structure
- `notebooks/`: data exploration and analysis
- `src/`: scripts to pull and clean data
- `sql/`: database queries
- `data/`: cleaned data and basket definition
- `dashboard/`: Power BI file

## Tools
Python (Pandas), MySQL, Power BI, Git

## Limitations
- This basket covers staples only, so its cost will be lower than total family food spending.
- Prices are provincial and national averages and don't capture store-level differences or shrinkflation.

## Status
In progress: data pulled and cleaned, basket defined. Next: SQL analysis.