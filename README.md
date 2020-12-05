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
### (define (get-SMA days): Obtain SMA indicator 
    Example Function is called by: (get-SMA 10)
### (define (get-EMA col days): Obtain EMA indicator
    Example Function is called by: (get-EMA (get-column 5) 10)
### (define (get-TMA days): Obtain TMA indicator
    Example Function is called by: (get-TMA 10)
### (define (get-MACD col day1 day2): Obtain TMA indicator
    Example Function is called by: (get-MACD (get-column 5) 10 20)
### (define (get-STOC): Obtain Stochrastic indicator
    Example Function is called by: (get-STOC)
    

---
