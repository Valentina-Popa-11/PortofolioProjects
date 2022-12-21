
SELECT 
      * 
FROM 
      PortofolioProject.dbo.FruitVegPrices

-- Stardardize Date Format

SELECT 
      date, 
      CONVERT(Date, date)
FROM 
      PortofolioProject.dbo.FruitVegPrices

ALTER TABLE 
      FruitVegPrices
ADD DateConverted Date;

UPDATE 
      FruitVegPrices
SET 
      DateConverted = CONVERT(Date, date)

-- Check categories included
SELECT 
      DISTINCT(category)
FROM 
      FruitVegPrices

-- Select just fruits and vegetables
SELECT 
      category, 
      item, 
      variety, 
      DateConverted AS date, 
      price, 
      unit
FROM 
      FruitVegPrices
WHERE 
      category = 'vegetable' 
      OR 
      category = 'fruit'
ORDER BY 
      DateConverted 

-- Create a view for further visualization
CREATE VIEW 
      PriceOverTime AS 
SELECT 
      category, 
      item, 
      variety, 
      DateConverted AS date, 
      price, 
      unit
FROM 
      FruitVegPrices
WHERE 
      category = 'vegetable' 
      OR 
      category = 'fruit'

