# High-Delivery-Phenomenon-Analysis-in-China-Stock-Market
The outcome suggests that companies caters the investors' preference to lower-price stock which is the driver of the high delivery phenomenon.      
For more information about stock splits and catering theory, read the reference papers.

## Data Source
Stock data ranges from 2011 to 2018 and comes from Wind database.   

## Variables Description
The proxy variable of investors preference to lower-price stock is P_CME calculated by log(Average PB of the 30% stocks with lowest price) - log(Average PB of the 30% stocks with highest price)   

The proxy variable of behavioral characters of High Delivery Phenomenon is Send_ratio which is the Stock divident delivery per current share.   

The control variables are accounting factors which are easily readable in the data profile.   

## Codes Description
Use Data Preprocessing.R to clean and restructure raw data.
Use the two Regression.R to run the regressions.    

## Reference:   
Baker, H. Kent, and Patricia L. Gallagher. “Management's View of Stock Splits.” Financial Management, vol. 9, no. 2, 1980, pp. 73–77. JSTOR, www.jstor.org/stable/3665171.    
Baker, H. Kent, and Gary E. Powell. “Further Evidence on Managerial Motives for Stock Splits.” Quarterly Journal of Business and Economics, vol. 32, no. 3, 1993, pp. 20–31. JSTOR, www.jstor.org/stable/40473089.    
Baker, M.,  R. Greenwood and J. Wurgler. "Catering through Nominal Share Prices." The Journal of Finance, vol. 64, no. 6, 2009, pp. 2559-2590. DOI, https://doi.org/10.1111/j.1540-6261.2009.01511.x.
