# Programming_Language_FP

#### Class: *Programing Languages*

##### Participants :
1.*Luis Revilla* - *A01022320* 
2. *Naji M A Saadat* - *A01025599* 


## Description

Our project proposal is to use racket language to do “​Backtesting to Financial Indicators​” in order to see which indicator works better on the data that we will be reading (Stock Market values). This is useful because when you are trading it is easier to see if the market is going up or down with those indicators, but having the wrong indicator could lead to different performance indicators causing misleading decisions. So we will be calculating the best indicator to each market value inputted.
To resume the problem that we will be solving is to have the ​best indicator intraday of each stock market in order to make it easier to see how the ​value performs in some indicators. Those indicators will be ​SMA, EMA, TMA, MACD, RSI, STOC and the performance per day​.

## Requirements
1. CSV file with data collection of each day  (File Input)
2. Racket 


## Indicators in the proposal 
1. SMA (It is Simple Moving Average which is the average of the closing prices in a certain period of time. ))
2. EMA (It is a moving average as SMA but it has higher weight on the recent indicator.)
3. TMA (It is the average price of an asset over a number of data points normally over multiple price bars.)
4. MACD ( Indicator that show the relationship between two moving averages of a security’s price)
5. RSI ( Indicator that shows the measure between the magnitude of recent prices change to by which overbought and oversold conditions )
6. STOC (Indicator that shows the percentage of change of the price)


## Functions 

### define read-csv: Read the data from the CSV
    Example Function is called by: (get-column 5).
    Functions used to read CSV file:

    Function | Description | Example
    :---: | :---: | :---:
    read-csv | Parsing function of the csv | N/A
    (all-rows path reader) | Converts the csv into a list of lists where ever sublist is a row of the csv | (cdr(all-rows csv-path read-csv))
    (get-column col) | Function that returns a list containing the values of the desired column | (get-column 5)

### (define (get-SMA days): Obtain SMA indicator 
    Example Function is called by: (get-SMA 10)
    Functions used to get SMA indicator:

    Function | Description | Example
    :---: | :---: | :---:
    (suma-SMA col n) | ;Function that get the average of the next n elements of a list| (suma-SMA (get-column 5) 10)
    (get-SMA days) | Function that returns the average of the next n element of a list in a list | (get-SMA 10) 

### (define (get-EMA col days): Obtain EMA indicator
    Example Function is called by: (get-EMA (get-column 5) 10)
    Functions used to get EMA indicator:

    Function | Description | Example
    :---: | :---: | :---:
    (sum-EMA val1 val2 days) | Function that solves part of the equation in order to get the EMA | (sum-EMA val1 val2 days)
    (get-EMA col days) | Function that returns the EMA solved of a list | (get-EMA (get-column 5) 10)

### (define (get-TMA days): Obtain TMA indicator
    Example Function is called by: (get-TMA 10)
    Functions used to get TMA indicator:

    Function | Description | Example
    :---: | :---: | :---:
    (get-factores n) | Function that returns a list with factors up to n | (get-factores 5)
    (solve-TMA l days) | Function that helps to solve the equation of TMA indicator | (solve-TMA result 5)
    (sum-TMA col days) | Function that get product of n elements of a list and the factors and return it in a list | (sum-TMA (get-column 5) 10)
    (sum-TMA2 days) | Function that retunrns the TMA of n of the first element | (sum-TMA2 10)

### (define (get-MACD col day1 day2): Obtain MACD indicator
    Example Function is called by: (get-MACD (get-column 5) 10 20)
    Functions used to get MACD indicator:

    Function | Description | Example
    :---: | :---: | :---:
    (get-MACD col day1 day2) | Function that return the MACD indicator of a list | (get-MACD (get-column 5) 10 20)

### (define (get-STOC): Obtain Stochrastic indicator
    Example Function is called by: (get-STOC)
    Functions used to get STOC indicator:

    Function | Description | Example
    :---: | :---: | :---:
    (min) | Function that return the difference between the closed price and the min value of the last 5 lower prices | (min)
    (max) | Function that return the difference between the max price and the min value of the last 5 lower prices | (max)
    (mid) | Function that divides (min) / (max) | (mid)
    (get-STOC) | Function that returns the strchrastic indicator | (get-STOC)

### Other used code: Different characterisitics
    Useful function that are part of different codes:
    Function | Description | Example
    :---: | :---: | :---:
    (length lst) | Function that returns the length of a list | (length (get-column 5))
    (last_element l) | ;Function that returns the last element of a list | (last_element (get-column 5))
    (get-elements col n) | Functions that returns a list n element of another list | (get-elements (get-column 5) 5)
    (jump col n) | Function that skips n elements of a list | (jump (get-EMA (get-column 5) 10) 10)

    

---
