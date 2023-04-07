-- Standardize data format from DATETIME ----> DATE---

SELECT saledate, CONVERT(date,saledate)
FROM NashvilleHousing		

UPDATE NashvilleHousing	
SET saledate= CONVERT(date,saledate)

 ---OR----

ALTER TABLE NashvilleHousing
ADD SaleDateConverter Date
UPDATE NashvilleHousing
SET SaleDateConverter = CONVERT(date,saledate)

--2. Populate Property Address Data---

SELECT a.parcelID, a.PropertyAddress, b.parcelID, b.PropertyAddress, ISNULL(a.PropertyAddress, b.PropertyAddress)
FROM  NashvilleHousing a
JOIN  NashvilleHousing b
ON a.parcelID= b .parcelID 
	AND a.UniqueID <> b.UniqueID
	AND a.PropertyAddress IS NULL

UPDATE a
SET a.PropertyAddress = ISNULL(a.PropertyAddress, b.PropertyAddress)
FROM  NashvilleHousing a
JOIN  NashvilleHousing b
ON a.parcelID= b .parcelID 
	AND a.UniqueID <> b.UniqueID
	AND a.PropertyAddress IS NULL



--3.  Breaking out Address into Individual Columns (Address, City, State)

SELECT	PropertyAddress,
		SUBSTRING (PropertyAddress, 1, CHARINDEX(',', PropertyAddress)-1) AS Address,
		SUBSTRING (PropertyAddress,CHARINDEX(',', PropertyAddress)+1, LEN(PropertyAddress)) AS City
FROM  NashvilleHousing

ALTER TABLE NashvilleHousing
ADD PropertyAddressSplit VARCHAR (255)
UPDATE NashvilleHousing
SET PropertyAddressSplit = SUBSTRING (PropertyAddress, 1, CHARINDEX(',', PropertyAddress)-1)

ALTER TABLE NashvilleHousing
ADD PropertyCitySplit VARCHAR (255)
UPDATE NashvilleHousing
SET PropertyCitySplit
PropertyCitySplit = SUBSTRING (PropertyAddress,CHARINDEX(',', PropertyAddress)+1, LEN(PropertyAddress))



--ALTER TABLE NashvilleHousing
--DROP COLUMN OwnerStateSplit 
--UPDATE NashvilleHousing
--SET OwnerStateSplit = 

----WITH A AS
----(
----SELECT OwnerAddress,
----	SUBSTRING (OwnerAddress,CHARINDEX(',', OwnerAddress)+1, LEN(OwnerAddress)) AS BB
----FROM  NashvilleHousing
----WHERE OwnerAddress IS NOT NULL
----) 

----SELECT SUBSTRING (BB,CHARINDEX(',', BB)+1, LEN(BB)) 
----FROM A

SELECT OwnerAddress,
		PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3), 
		PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2),
		PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1)
FROM  NashvilleHousing
WHERE OwnerAddress IS NOT NULL

ALTER TABLE NashvilleHousing
ADD OwnerSplitAddress VARCHAR (255)
UPDATE NashvilleHousing 
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3)

ALTER TABLE NashvilleHousing
ADD OwnerSplitCity VARCHAR (255)
UPDATE NashvilleHousing 
SET OwnerSplitCity= PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2)

ALTER TABLE NashvilleHousing
ADD OwnerSplitState VARCHAR (255)
UPDATE NashvilleHousing 
SET OwnerSplitState= PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1)



--4. Change Y and N to Yes and No in "Sold as Vacant Field"

SELECT DISTINCT(SoldAsVacant), COUNT (SoldAsVacant)
FROM NashvilleHousing
GROUP BY SoldAsVacant
ORDER BY COUNT (SoldAsVacant) DESC

SELECT SoldAsVacant,
 CASE 
	WHEN SoldAsVacant = 'N' THEN 'No'
	WHEN SoldAsVacant = 'Y' THEN 'Yes'
	ELSE SoldAsVacant
	END 
FROM NashvilleHousing

UPDATE NashvilleHousing 
SET SoldAsVacant = 
 CASE 
	WHEN SoldAsVacant = 'N' THEN 'No'
	WHEN SoldAsVacant = 'Y' THEN 'Yes'
	ELSE SoldAsVacant
	END 
FROM NashvilleHousing


-----------5. Remove Duplicate------------------------------------------------------------------------------------------------------

WITH RowNumberCTE AS (
SELECT *,
		ROW_NUMBER () OVER (PARTITTION BY 
									ParcelID,
									PropertyAddress,
									SaleDate,
									SalePrice,
									LegalReference
				ORDER BY UniqueID) row_num

FROM NashvilleHousing
ORDER BY UniqueID				
)
SELECT *
FROM RowNumberCTE
WHERE row_num > 1

---DELETE DUPLICATE ROW ----

--replace select * from above quaries with DELETE---




---------6. Delete Unused Column--

SELECT *
FROM NashvilleHousing

ALTER TABLE NashvilleHousing
DROP COLUMN SaleDate, PropertyAddress, OwnerAddress













