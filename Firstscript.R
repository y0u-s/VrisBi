#---------------------------------VrisBi-------------------------------#

# pseudocode:
# in verkopensheet: check per klantcode (alleen bij groothandel) hoeveel er zijn verkocht
# genereer een random getal die het aantal daadwerkelijke verkopen moet voorstellen
# koppel klantcode van VERKOPEN.xsls aan klantcode van CUSTOMERS.xsls en check de WINKELNAAM in CUSTOMERS.xsls
# vergelijk het aantal verkopen met de kassaverkopen per WINKELNAAM

#laadt dataset in
install.packages("readxl")
verkopen_vrisbi <- read_excel("C:/*****/VrisBi sales-analysis/verkopenvrisbi.xsls")

#we hebben alleen de verkopen via groothandel nodig
verkopen_vrisbi_groothandel <- subset(Verkopen_vrisbi, Distributiekanaalcode == 'GROOTHANDEL')

#voeg de winkelnaam toe uit Customers excel 
verkopen_vrisbi_groothandel$winkel <- CUSTOMERS_vrisbi$CustomerName[match(verkopen_vrisbi_groothandel$Klantcode, CUSTOMERS_vrisbi$SalesCustCode)]

#verwijder alle NA's
verkopen_vrisbi_groothandel <- verkopen_vrisbi_groothandel %>% drop_na()

#hernoem 'aantal' naar 'levering' om verwarring te voorkomen
names(verkopen_vrisbi_groothandel)[names(verkopen_vrisbi_groothandel) == "Aantal"] <- "Levering"

#maak een kolom aan met 'kassaverkopen' met daarin een random getal tussen max(levering) en stuk of 20
