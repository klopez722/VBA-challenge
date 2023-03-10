Attribute VB_Name = "Module1"
Sub yearstockdata()

        
        'copy to each worksheet
        For Each ws In Worksheets
        
        'Table headers
        ws.Cells(1, 9).Value = "Ticker"
        ws.Cells(1, 10).Value = "Yearly Change"
        ws.Cells(1, 11).Value = "Percent Change"
        ws.Cells(1, 12).Value = "Total Stock Volume"
        ws.Range("O2").Value = "Greatest % Increase"
        ws.Range("O3").Value = "Greatest % Decrease"
        ws.Range("O4").Value = "Greatest Total Volume"
        ws.Range("P1").Value = "Ticker"
        ws.Range("Q1").Value = "Value"

       'initial variables
        Dim tickername As String
        Dim tickervolume As Double
            tickervolume = 0
        Dim summary_ticker_row As Integer
            summary_ticker_row = 2
        Dim open_price As Double
            open_price = ws.Cells(2, 3).Value
        Dim close_price As Double
        Dim yearly_change As Double
        Dim percent_change As Double
        Dim GreatestIncrease As Double
            GreatestIncrease = 0
        Dim GreatestDecrease As Double
            GreatestDecrease = 0
        Dim LastRowValue As Long
        Dim GreatestTotalVolume As Double
            GreatestTotalVolume = 0


        'Calculating last row
        lastrow = ws.Cells(Rows.Count, 1).End(xlUp).Row

        For i = 2 To lastrow


        If ws.Cells(i + 1, 1).Value <> ws.Cells(i, 1).Value Then
        
              'Setting ticker name
              tickername = ws.Cells(i, 1).Value

              'Add the volume of trade
              tickervolume = tickervolume + ws.Cells(i, 7).Value

              'Print the ticker name in the summary table
              ws.Range("I" & summary_ticker_row).Value = tickername

              'Print the ticker total amount to the summary table
              ws.Range("L" & summary_ticker_row).Value = tickervolume
            
            'close and yearly change
    
            close_price = ws.Cells(i, 6).Value
            yearly_change = (close_price - open_price)
             ws.Range("J" & summary_ticker_row).Value = yearly_change

             'determine percent change
                If (open_price = 0) Then

                    percent_change = 0

                Else
                    
                    percent_change = yearly_change / open_price
                
                End If

              'format range to incude two decimal places and percent symbol
              ws.Range("K" & summary_ticker_row).Value = percent_change
              ws.Range("K" & summary_ticker_row).NumberFormat = "0.00%"
   
              'Adding one to the summary row table
              summary_ticker_row = summary_ticker_row + 1

              'Reset ticker total
              tickervolume = 0
            
            'Opening price
            open_price = ws.Cells(i + 1, 3)
            
            Else
              
               'Ticker Volume total
              tickervolume = tickervolume + ws.Cells(i, 7).Value

            
            End If
        
        Next i

    
    'find the last row of the summary table

    lastrow_summary_table = ws.Cells(Rows.Count, 9).End(xlUp).Row
    
    'Color code yearly change(red,green)
    
    For i = 2 To lastrow_summary_table
            If ws.Cells(i, 10).Value > 0 Then
                ws.Cells(i, 10).Interior.ColorIndex = 10
            Else
                ws.Cells(i, 10).Interior.ColorIndex = 3
            End If
    Next i
    
            
    
            
            ' Calculate Greatest % Increase, Greatest % Decrease and Greatest Total Volume
            lastrow = ws.Cells(Rows.Count, 11).End(xlUp).Row
        
            ' Final Results
            For i = 2 To lastrow
                If ws.Range("K" & i).Value > ws.Range("Q2").Value Then
                    ws.Range("Q2").Value = ws.Range("K" & i).Value
                    ws.Range("P2").Value = ws.Range("I" & i).Value
                End If

                If ws.Range("K" & i).Value < ws.Range("Q3").Value Then
                    ws.Range("Q3").Value = ws.Range("K" & i).Value
                    ws.Range("P3").Value = ws.Range("I" & i).Value
                End If

                If ws.Range("L" & i).Value > ws.Range("Q4").Value Then
                    ws.Range("Q4").Value = ws.Range("L" & i).Value
                    ws.Range("P4").Value = ws.Range("I" & i).Value
                End If

            Next i
        
            

    Next ws
End Sub



