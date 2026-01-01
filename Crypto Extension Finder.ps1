Add-Type -AssemblyName PresentationFramework, PresentationCore, WindowsBase

$cryptoXaml = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        Height="480" Width="760" WindowStyle="None" AllowsTransparency="True" Background="Transparent" 
        WindowStartupLocation="CenterScreen" Opacity="0">
    <Window.Triggers>
        <EventTrigger RoutedEvent="FrameworkElement.Loaded">
            <BeginStoryboard>
                <Storyboard>
                    <DoubleAnimation Storyboard.TargetProperty="Opacity" From="0" To="1" Duration="0:0:0.4"/>
                    <DoubleAnimation Storyboard.TargetProperty="(UIElement.RenderTransform).(ScaleTransform.ScaleX)" 
                                     From="0.95" To="1" Duration="0:0:0.4">
                        <DoubleAnimation.EasingFunction><CubicEase EasingMode="EaseOut"/></DoubleAnimation.EasingFunction>
                    </DoubleAnimation>
                    <DoubleAnimation Storyboard.TargetProperty="(UIElement.RenderTransform).(ScaleTransform.ScaleY)" 
                                     From="0.95" To="1" Duration="0:0:0.4">
                        <DoubleAnimation.EasingFunction><CubicEase EasingMode="EaseOut"/></DoubleAnimation.EasingFunction>
                    </DoubleAnimation>
                </Storyboard>
            </BeginStoryboard>
        </EventTrigger>
    </Window.Triggers>
    <Window.RenderTransform>
        <ScaleTransform CenterX="0.5" CenterY="0.5"/>
    </Window.RenderTransform>
    <Border Background="#0F0F0F" BorderBrush="#8B00FF" BorderThickness="2" CornerRadius="8">
        <Grid Margin="35">
            <Grid.RowDefinitions>
                <RowDefinition Height="Auto"/>
                <RowDefinition Height="Auto"/>
                <RowDefinition Height="Auto"/>
                <RowDefinition Height="Auto"/>
                <RowDefinition Height="*"/>
            </Grid.RowDefinitions>

            <TextBlock Grid.Row="0" Text="[ CRYPTO PATTERN CHECKER ]" Foreground="#8B00FF" FontSize="18" 
                       FontWeight="ExtraBold" FontFamily="Consolas" HorizontalAlignment="Center" Margin="0,25,0,35"/>
            <Button Grid.Row="0" Name="CryptoCloseBtn" Content="X" Foreground="#FFFFFF" FontSize="14" 
                    Background="Transparent" BorderThickness="0" Cursor="Hand" HorizontalAlignment="Right" 
                    VerticalAlignment="Top" Margin="0,15,15,0"/>

            <TextBlock Grid.Row="1" Text="Enter full file path or just filename:" Foreground="#CCCCCC" 
                       FontSize="13" FontFamily="Consolas" Margin="0,0,0,10"/>

            <TextBox Grid.Row="2" Name="txtPath" Height="50" Padding="15" Margin="0,0,0,25" 
                     Background="#1A1A1A" Foreground="#FFFFFF" BorderBrush="#444444" BorderThickness="2" 
                     FontFamily="Consolas" FontSize="14" VerticalContentAlignment="Center"/>

            <StackPanel Grid.Row="3" Orientation="Horizontal" HorizontalAlignment="Center" Margin="0,0,0,25">
                <Button Name="btnCheck" Content="[ CHECK PATTERNS ]" Padding="40,15" Margin="15,0">
                    <Button.Style>
                        <Style TargetType="Button">
                            <Setter Property="Background" Value="#1A1A1A"/>
                            <Setter Property="Foreground" Value="#8B00FF"/>
                            <Setter Property="BorderBrush" Value="#444444"/>
                            <Setter Property="BorderThickness" Value="2"/>
                            <Setter Property="FontWeight" Value="ExtraBold"/>
                            <Setter Property="FontSize" Value="15"/>
                            <Setter Property="Cursor" Value="Hand"/>
                            <Setter Property="Template">
                                <Setter.Value>
                                    <ControlTemplate TargetType="Button">
                                        <Border Background="{TemplateBinding Background}" 
                                                BorderBrush="{TemplateBinding BorderBrush}" 
                                                BorderThickness="{TemplateBinding BorderThickness}" 
                                                CornerRadius="4">
                                            <ContentPresenter HorizontalAlignment="Center" VerticalAlignment="Center"/>
                                        </Border>
                                        <ControlTemplate.Triggers>
                                            <Trigger Property="IsMouseOver" Value="True">
                                                <Setter Property="Background" Value="#8B00FF"/>
                                                <Setter Property="Foreground" Value="#FFFFFF"/>
                                            </Trigger>
                                        </ControlTemplate.Triggers>
                                    </ControlTemplate>
                                </Setter.Value>
                            </Setter>
                        </Style>
                    </Button.Style>
                </Button>

                <Button Name="btnClear" Content="[ CLEAR ]" Padding="25,12" Margin="15,0">
                    <Button.Style>
                        <Style TargetType="Button">
                            <Setter Property="Background" Value="#1A1A1A"/>
                            <Setter Property="Foreground" Value="#8B00FF"/>
                            <Setter Property="BorderBrush" Value="#444444"/>
                            <Setter Property="BorderThickness" Value="2"/>
                            <Setter Property="FontWeight" Value="Bold"/>
                            <Setter Property="FontSize" Value="13"/>
                            <Setter Property="Cursor" Value="Hand"/>
                            <Setter Property="Template">
                                <Setter.Value>
                                    <ControlTemplate TargetType="Button">
                                        <Border Background="{TemplateBinding Background}" 
                                                BorderBrush="{TemplateBinding BorderBrush}" 
                                                BorderThickness="{TemplateBinding BorderThickness}" 
                                                CornerRadius="4">
                                            <ContentPresenter HorizontalAlignment="Center" VerticalAlignment="Center"/>
                                        </Border>
                                        <ControlTemplate.Triggers>
                                            <Trigger Property="IsMouseOver" Value="True">
                                                <Setter Property="Background" Value="#8B00FF"/>
                                                <Setter Property="Foreground" Value="#FFFFFF"/>
                                            </Trigger>
                                        </ControlTemplate.Triggers>
                                    </ControlTemplate>
                                </Setter.Value>
                            </Setter>
                        </Style>
                    </Button.Style>
                </Button>
            </StackPanel>

            <ScrollViewer Grid.Row="4" VerticalScrollBarVisibility="Auto" Background="#0F0F0F">
                <TextBox Name="txtOutput" IsReadOnly="True" TextWrapping="Wrap" Background="Transparent" 
                         Foreground="#FFFFFF" BorderThickness="0" FontFamily="Consolas" FontSize="13" Padding="15"/>
            </ScrollViewer>
        </Grid>
    </Border>
</Window>
"@

$cWin = [Windows.Markup.XamlReader]::Load([System.Xml.XmlNodeReader]::new([xml]$cryptoXaml))

$txtPath   = $cWin.FindName("txtPath")
$btnCheck  = $cWin.FindName("btnCheck")
$btnClear  = $cWin.FindName("btnClear")
$txtOutput = $cWin.FindName("txtOutput")

function Convert-FsrmWildcardToRegex {
    param([Parameter(Mandatory)][string]$Pattern)
    $regex = [Regex]::Escape($Pattern)
    $regex = $regex -replace '\\\*','.*' -replace '\\\?','.'
    return '^' + $regex + '$'
}

$btnCheck.Add_Click({
    $txtOutput.Text = ""
    $path = $txtPath.Text.Trim()

    if ([string]::IsNullOrWhiteSpace($path)) {
        $txtOutput.Text = "→ Please enter a file path or filename first."
        return
    }

    $filename = Split-Path -Leaf $path
    $txtOutput.Text = "Filename extracted: $filename`n`n"
    $txtOutput.AppendText("Fetching current CryptoBlocker patterns...`n")

    try {
        $url = "https://raw.githubusercontent.com/DFFspace/CryptoBlocker/master/KnownExtensions.txt"
        $response = Invoke-WebRequest -Uri $url -UseBasicParsing -TimeoutSec 15
        $json = $response.Content | ConvertFrom-Json

        $patterns = $json.filters `
            | Where-Object { $_ } `
            | ForEach-Object { $_.Trim() } `
            | Where-Object { -not $_.StartsWith("#") }

        $txtOutput.AppendText("Loaded $($patterns.Count) patterns (last updated: $($json.lastUpdated))`n`n")
    }
    catch {
        $txtOutput.Text = "ERROR: Could not download patterns.`n$_`n`nTry again later or check your internet connection."
        return
    }

    $matchesFound = @()

    foreach ($pattern in $patterns) {
        $regex = Convert-FsrmWildcardToRegex $pattern
        if ($filename -imatch $regex) {
            $matchesFound += [PSCustomObject]@{
                Pattern = $pattern
                Regex   = $regex
            }
        }
    }

    if ($matchesFound.Count -gt 0) {
        $txtOutput.AppendText("** MATCHES FOUND - These patterns would BLOCK the file **`n`n")
        $matchesFound | Sort-Object Pattern | Format-Table -AutoSize | Out-String | ForEach-Object {
            $txtOutput.AppendText($_)
        }
        $txtOutput.AppendText("`nThese extensions are known ransomware/crypto patterns.`n")
    }
    else {
        $txtOutput.AppendText("No matching ransomware/crypto patterns found.`n")
        $txtOutput.AppendText("→ The file '$filename' should NOT trigger a CryptoBlocker/FSRM alert based on current known patterns.`n")
        $txtOutput.AppendText("   (Very new ransomware might not be in the list yet)")
    }
})

$btnClear.Add_Click({
    $txtPath.Text = ""
    $txtOutput.Text = ""
})

$cWin.FindName("CryptoCloseBtn").Add_Click({ $cWin.Close() })
$cWin.Add_MouseLeftButtonDown({ $cWin.DragMove() })
$cWin.ShowDialog() | Out-Null