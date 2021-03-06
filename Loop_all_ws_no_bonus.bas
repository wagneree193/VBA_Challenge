Attribute VB_Name = "Loop_all_ws_no_bonus"
Sub VBAStockTest()
'loop through worksheets
'output ticker symbol in new column
'create column yearly change fm open to close
'create column percent change from open to close per year
'create column total stock volume
'calculate yearly change
'conditional formatting +/- g/r for yearly change
'calculate percent change
'calculate total stock volume

'Create variables to hold ticker, yearly change, percent change, and total volume
    Dim Ticker_Row As Double
    Dim Ticker_Name As String
    Dim Yearly_Change As Double
    Dim Percent_Change As Double
    Dim Total_Stock_Volume As Double
    Dim Summary_Table_Row As Double
    
    

'-----------------------------
'LOOP THROUGH ALL SHEETS
'-----------------------------

For Each ws In Worksheets


    'Find last row automatically
    'LastRow = ws.Cells(Rows.Count, 1).End(xlUp).Row
     LastRow = ws.Cells(Rows.Count, 1).End(xlUp).Row
     
    'Find last column automatically
    'LastColumn = ws.Cells(1, Columns.Count).End(xlToLeft).Column
     LastColumn = ws.Cells(1, Columns.Count).End(xlToLeft).Column
     
    
    'Make summary table to right of the test data
    'lastcol plus 3 will automatically populate a column header 3 cells to the right in row 1
    'quotations around the column header designates as string instead of the variable created in first step
    'add ws. to all after confirming it works on A sheet
    ws.Cells(1, LastColumn + 3).Value = "Ticker"
    ws.Cells(1, LastColumn + 4).Value = "Yearly Change"
    ws.Cells(1, LastColumn + 5).Value = "Percent Change"
    ws.Cells(1, LastColumn + 6).Value = "Total Stock Volume"
    
    'Output Ticker symbol with for loop
    'Do total volume in this step too because it is simple arithmetic
    'Tell excel where to output ticker and volume
    Ticker_Row = 2
    Summary_Table_Row = 2
    Dim Open_Price As Double
    Dim Close_Price As Double
    
    For i = 2 To LastRow
      'If next row ticker is different
      If ws.Cells(i + 1, 1).Value <> ws.Cells(i, 1).Value Then
         Open_Price = ws.Cells(2, 3).Value
         Close_Price = ws.Cells(i, LastColumn - 1).Value
         
        'Set Ticker name
         Ticker_Name = ws.Cells(i, 1).Value
         
         'Calculate total volume
         Total_Stock_Volume = Total_Stock_Volume + ws.Cells(i, 7).Value
         
         'Calculate yearly change
        Yearly_Change = Close_Price - Open_Price
        
         'Calculate percent change
         Percent_Change = (Close_Price - Open_Price) / Open_Price
         'Format percent change as %
         ws.Range("L" & Summary_Table_Row).Style = "Percent"
         
         'Print Ticker name in the summary table
         ws.Range("J" & Ticker_Row).Value = Ticker_Name
         
         'Print volume in summary table
         ws.Range("M" & Summary_Table_Row).Value = Total_Stock_Volume
         
         'Print year change in summary table
         ws.Range("K" & Summary_Table_Row).Value = Yearly_Change
         
         'nest if statements to assign correct colors
           If Yearly_Change > 0 Then
           ws.Range("k" & Summary_Table_Row).Interior.ColorIndex = 4
             Else
             ws.Range("K" & Summary_Table_Row).Interior.ColorIndex = 3
           End If
        
         
         'Print percent change in summary table
         ws.Range("L" & Summary_Table_Row).Value = Percent_Change
          
         'Add row to summary table
         Ticker_Row = Ticker_Row + 1
         Summary_Table_Row = Summary_Table_Row + 1
         Open_Price = ws.Cells(i + 1, 3).Value
         
         'Starting pt for total volume
         Total_Stock_Volume = 0
         
       Else
          'if next row ticker is same
          Total_Stock_Volume = Total_Stock_Volume + ws.Cells(i, 7).Value
          
    End If
    

 Next i
    
 Next ws
 
 
End Sub



