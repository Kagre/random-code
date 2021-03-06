'Copyright 2016 Gregory Kaiser
'
'This file is part of my random-code libarary.
'
'My random-code library is free software: you can redistribute it and/or modify
'it under the terms of the GNU Lesser General Public License as published by
'the Free Software Foundation, either version 3 of the License, or
'(at your option) any later version.
'
'My random-code library is distributed in the hope that it will be useful,
'but WITHOUT ANY WARRANTY; without even the implied warranty of
'MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
'GNU Lesser General Public License for more details.
'
'You should have received a copy of the GNU Lesser General Public License
'along with my random-code library.  If not, see <http://www.gnu.org/licenses/>.

Public Function IsFunction(ref As Range) As Boolean
    IsFunction = (Left(ref.Cells.Formula, 1) = "=")
End Function

Public Function JoinRange(ToJoin As Range, Optional Delimiter As String = ",") As String
    Dim c As Range, start As Boolean
    start = True
    For Each c In ToJoin.Cells
    If Not IsEmpty(c) Then
    If c.Value <> "" Then
        JoinRange = IIf(start, "", JoinRange & Delimiter) & c.Value
        start = False
    End If: End If
    Next c
End Function

Public Function bKey(ByVal K1 As Range, ByVal K2 As Range, Optional ByVal sep As String = ":") As String
    bKey = UCase(Trim(K1.Value)) & sep & UCase(Trim(K2.Value))
End Function

Public Function xXOR(a As Boolean, B As Boolean) As Boolean: xXOR = a Xor B: End Function

Public Function PowerMod(ByVal base As Long, ByVal exponent As Long, ByVal modulus As Long) As Long
    PowerMod = 1
    base = base Mod modulus
    Do While exponent > 0
        If exponent Mod 2 = 1 Then PowerMod = (PowerMod * base) Mod modulus
        exponent = exponent \ 2
        base = (base * base) Mod modulus
    Loop
End Function

Public Function LogMod(ByVal base As Long, ByVal target As Long, ByVal modulus As Long) As Long
    Dim val As Long: val = 1
    Dim exponent As Long: exponent = 1
    base = base Mod modulus
    val = base
    Do While exponent <= modulus And val <> target
'        Debug.Print val & " --> " & (val * base) Mod modulus
        val = (val * base) Mod modulus
        If val = base Then
            LogMod = -1
            Exit Function
        End If
        exponent = exponent + 1
    Loop
    LogMod = IIf(exponent <= modulus, exponent, -1)
End Function

Public Function FindA(ByVal n As Long) As Long
    For FindA = 2 To n
        If PowerMod(FindA, n - 1, n) = 1 Then Exit For
    Next FindA
    If PowerMod(FindA, n - 1, n) <> 1 Then FindA = -1
End Function

'turn off the green cell warnings for numbers stored as text, and the like
Public Sub IgnoreCellEvalErr()
    Dim c As Range
    On Error Resume Next
    For Each c In Selection.Cells
        c.Errors(xlEvaluateToError).Ignore = True
    Next c
    On Error GoTo 0
End Sub
