if (!(Test-Path 'build.json')) {
    Write-Output "No build.json is found.  It is needed for this build to work".
    exit 1;
}

$build = (Get-Content .\build.json | Out-String | ConvertFrom-Json)
if (!($build)) {
    Write-Output "Cannot parse build.json"
    exit 1;
}

if ($build.version) {
    Write-Output "Validating Version:  $_"
    if ($null -eq $build.version.major) {
        Write-Output "$_ is missing the major property"
        exit 1;
    }
    else {
        if (-Not ($build.version.major -is [int])) {
            Write-Output "$_ major property is not of type int"
            exit 1;
        }
    }

    if ($null -eq $build.version.minor) {
        Write-Output "$_ is missing the minor property"
        exit 1;
    }
    else {
        if (-Not ($build.version.minor -is [int])) {
            Write-Output "$_ minor property is not of type int"
            exit 1;
        }
    }

}
else {
    Write-Output "$_ is missing the version property"
    exit 1;
}


if ($build.builds) {
    Write-Output "Validating Builds:  $_"
    $build.builds | ForEach-Object {
        if (!($_.path)) {
            Write-Output "$_ is missing the path attribute"
            exit 1;
        }
    }
}

if ($build.deploys) {
    $build.deploys | ForEach-Object {
        Write-Output "Validating Deploys:  $_"
        if (!($_.path)) {
            Write-Output "$_ is missing the path attribute"
            exit 1;
        }
        if (!($_.name)) {
            Write-Output "$_ is missing the name attribute"
            exit 1;
        }
    }
}

if ($build.packages) {
    Write-Output "Validating Packages:  $_"
    $build.packages | ForEach-Object {
        if (!($_.path)) {
            Write-Output "$_ is missing the path attribute"
            exit 1
        }
    }
}

if ($build.clientState) {
    Write-Output "Validating ClientState:  $_"
    if ($null -eq $build.clientState.name) {
        Write-Output "$_ is missing the name property"
        exit 1;
    }
    else {
        if (-Not ($build.clientState.name -is [string])) {
            Write-Output "$_ name property is not of type string"
            exit 1;
        }
    }
}
else {
    Write-Output "$_ is missing the clientState property"
    exit 1;
}

if ($build.swagger) {
    Write-Output "Validating swagger feature:  $_"
    if (-Not ($build.swagger.enabled -is [Boolean])) {
        Write-Output "$_ enabled property is not of type boolean"
        exit 1;
    }
}