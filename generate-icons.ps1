Add-Type -AssemblyName System.Drawing

function Build-Icon {
    param(
        [int]$sz,
        [string]$file
    )
    $bmp = [System.Drawing.Bitmap]::new($sz, $sz)
    $g = [System.Drawing.Graphics]::FromImage($bmp)
    $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
    
    $rect = [System.Drawing.Rectangle]::new(0, 0, $sz, $sz)
    $brush = [System.Drawing.Drawing2D.LinearGradientBrush]::new($rect, [System.Drawing.Color]::FromArgb(255, 36, 26, 20), [System.Drawing.Color]::FromArgb(255, 16, 12, 10), 45.0)
    $g.FillRectangle($brush, $rect)
    
    # Gold border
    $pen = [System.Drawing.Pen]::new([System.Drawing.Color]::FromArgb(255, 224, 159, 62), [float]($sz * 0.04))
    $pad = [int]($sz * 0.08)
    $g.DrawEllipse($pen, $pad, $pad, ($sz - 2*$pad), ($sz - 2*$pad))
    
    # Cup body
    $cupW = [int]($sz * 0.44)
    $cupH = [int]($sz * 0.32)
    $cupX = [int](($sz - $cupW)/2)
    $cupY = [int]($sz * 0.42)
    $goldBrush = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(255, 244, 178, 81))
    $g.FillRectangle($goldBrush, $cupX, $cupY, $cupW, [int]($cupH * 0.75))
    $g.FillPie($goldBrush, $cupX, [int]($cupY + $cupH * 0.4), $cupW, [int]($cupH * 0.7), 0.0, 180.0)
    
    # Handle
    $hPen = [System.Drawing.Pen]::new([System.Drawing.Color]::FromArgb(255, 244, 178, 81), [float]($sz * 0.045))
    $g.DrawArc($hPen, [int]($cupX + $cupW - ($sz*0.04)), [int]($cupY + ($sz*0.03)), [int]($sz*0.16), [int]($sz*0.22), 270.0, 180.0)
    
    # Saucer
    $sPen = [System.Drawing.Pen]::new([System.Drawing.Color]::FromArgb(255, 224, 159, 62), [float]($sz * 0.04))
    $g.DrawLine($sPen, [int]($cupX - $sz*0.07), [int]($cupY + $cupH + $sz*0.04), [int]($cupX + $cupW + $sz*0.07), [int]($cupY + $cupH + $sz*0.04))
    
    # Steam
    $steamPen = [System.Drawing.Pen]::new([System.Drawing.Color]::FromArgb(180, 250, 246, 240), [float]($sz * 0.03))
    $g.DrawLine($steamPen, [int]($sz*0.5), [int]($cupY - $sz*0.14), [int]($sz*0.5), [int]($cupY - $sz*0.03))
    $g.DrawLine($steamPen, [int]($sz*0.4), [int]($cupY - $sz*0.10), [int]($sz*0.4), [int]($cupY - $sz*0.03))
    $g.DrawLine($steamPen, [int]($sz*0.6), [int]($cupY - $sz*0.10), [int]($sz*0.6), [int]($cupY - $sz*0.03))
    
    $bmp.Save($file, [System.Drawing.Imaging.ImageFormat]::Png)
    $g.Dispose()
    $bmp.Dispose()
    Write-Host "Saved $file"
}

$dir = Split-Path -Parent $MyInvocation.MyCommand.Path
Build-Icon -sz 192 -file "$dir\icon-192.png"
Build-Icon -sz 512 -file "$dir\icon-512.png"
Build-Icon -sz 180 -file "$dir\apple-touch-icon.png"
