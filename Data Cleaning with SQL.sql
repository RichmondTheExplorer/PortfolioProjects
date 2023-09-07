--Data Cleaning in SQL queries
Select * 
From PortfolioProject..NashvilleHousing
---------------------------------------------------------------------------------------------------------------------------
--Standardize Data Format 
Select SaleDateConverted, CONVERT(Date, saledate)
From PortfolioProject..NashvilleHousing

Update PortfolioProject..NashvilleHousing
SET SaleDate = CONVERT(Date, saledate) 

Alter table PortfolioProject..NashvilleHousing
Add SaleDateConverted Date;

Update PortfolioProject..NashvilleHousing
SET SaleDateConverted = CONVERT(Date, saledate)

---------------------------------------------------------------------------------------------------------------------------
--Populate Property Address Data

Select *
From PortfolioProject..NashvilleHousing
--Where PropertyAddress is null
where PropertyAddress is null
order by ParcelID


Select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress, b.PropertyAddress)
From PortfolioProject..NashvilleHousing a
Join  PortfolioProject..NashvilleHousing b
    on a.ParcelID = b.ParcelID
	AND a.[uniqueID] <> b.[uniqueID]
where a.propertyAddress is null

UPDATE a
SET propertyAddress = ISNULL(a.PropertyAddress, b.PropertyAddress)
From PortfolioProject..NashvilleHousing a
Join  PortfolioProject..NashvilleHousing b
    on a.ParcelID = b.ParcelID
	AND a.[uniqueID] <> b.[uniqueID]

---------------------------------------------------------------------------------------------------------------------------
--Breaking out Address into individual Columns (Address, City, State)
Select PropertyAddress
From PortfolioProject..NashvilleHousing

SELECT 
SUBSTRING(PropertyAddress, 1, CHARINDEX(',',PropertyAddress)-1) as Address,
CHARINDEX(',',PropertyAddress)--giving index of where the , is

From PortfolioProject..NashvilleHousing

--Address without ,
SELECT 
SUBSTRING(PropertyAddress, 1, CHARINDEX(',',PropertyAddress)-1) as Address
From PortfolioProject..NashvilleHousing

SELECT 
SUBSTRING(PropertyAddress, 1, CHARINDEX(',',PropertyAddress)-1) as Address,
SUBSTRING(PropertyAddress, CHARINDEX(',',PropertyAddress)+1, LEN(PropertyAddress)) as 
Address 

From PortfolioProject..NashvilleHousing

Alter table PortfolioProject..NashvilleHousing
Add PropertySplitAddress Nvarchar(255);

Update PortfolioProject..NashvilleHousing
SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',',PropertyAddress)-1)

Alter table PortfolioProject..NashvilleHousing
Add PropertySplitCity Nvarchar(255);

Update PortfolioProject..NashvilleHousing
SET PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',',PropertyAddress)+1, LEN(PropertyAddress))

Select * 
From PortfolioProject..NashvilleHousing

--Owner Address
Select OwnerAddress
FROM PortfolioProject..NashvilleHousing

SELECT 
PARSENAME(REPLACE(OwnerAddress,',','.'), 3)
,PARSENAME(REPLACE(OwnerAddress,',','.'), 2)
,PARSENAME(REPLACE(OwnerAddress,',','.'), 1)

FROM PortfolioProject..NashvilleHousing
--So two methods substring hard one n PARSENAME easy one

Alter table PortfolioProject..NashvilleHousing
Add OwnerSplitAddress Nvarchar(255);

Update PortfolioProject..NashvilleHousing
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress,',','.'), 3)

Alter table PortfolioProject..NashvilleHousing
Add OwnerSplitCity Nvarchar(255);

Update PortfolioProject..NashvilleHousing
SET OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress,',','.'), 2)

Alter table PortfolioProject..NashvilleHousing
Add OwnerSplitState Nvarchar(255);

Update PortfolioProject..NashvilleHousing
SET OwnerSplitState = PARSENAME(REPLACE(OwnerAddress,',','.'), 1)

---------------------------------------------------------------------------------------------------------------------------
--Change 1 and 0 to Yes and No in "Sold as Vacant" field
Select Distinct(SoldAsVacant), Count(SoldAsVacant)
From PortfolioProject..NashvilleHousing
Group by SoldAsVacant
order by SoldAsVacant

Select SoldAsVacant
,CASE CAST(SoldAsVacant as nvarchar(255))
      WHEN 0 THEN 'No'
      WHEN 1 THEN 'Yes'
	  ELSE CAST(SoldAsVacant as nvarchar(255))
	  END
From PortfolioProject..NashvilleHousing

Update PortfolioProject..NashvilleHousing
SET CAST(SoldAsVacant as nvarchar(255)) = CASE CAST(SoldAsVacant as nvarchar(255))
      WHEN 0 THEN 'No'
      WHEN 1 THEN 'Yes'
	  ELSE CAST(SoldAsVacant as nvarchar(255))
	  END

---------------------------------------------------------------------------------------------------------------------------
--Remove Duplicates

--Write CTE and some window functions to Find Out duplicates
WITH RowNumCTE AS (
Select *,
    ROW_NUMBER() OVER(
	PARTITION BY ParcelID,
	             PropertyAddress,
				 SalePrice,
				 SaleDate,
				 LegalReference
				 ORDER BY 
				     UniqueID
					 ) row_num

From PortfolioProject..NashvilleHousing
--order by ParcelID
)

Select *
From RowNumCTE
where row_num > 1
Order by propertyAddress

--Delete duplicate rows
WITH RowNumCTE AS (
Select *,
    ROW_NUMBER() OVER(
	PARTITION BY ParcelID,
	             PropertyAddress,
				 SalePrice,
				 SaleDate,
				 LegalReference
				 ORDER BY 
				     UniqueID
					 ) row_num

From PortfolioProject..NashvilleHousing
--order by ParcelID
)

Delete
From RowNumCTE
where row_num > 1

---------------------------------------------------------------------------------------------------------------------------
--Delete Unused Columns
Select * 
From PortfolioProject..NashvilleHousing

ALTER TABLE PortfolioProject..NashvilleHousing
DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress

ALTER TABLE PortfolioProject..NashvilleHousing
DROP COLUMN SaleDate
