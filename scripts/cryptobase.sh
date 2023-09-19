function cbaseUpdates() {
  #!/bin/bash

# Check for correct number of arguments
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <filename> <search_string> <replace_string>"
    exit 1
fi

# Capture arguments
filename="$1"
search_string="$2"
replace_string="$3"

# Use sed to replace the string in-place
sed -i '' -e "s/$search_string/$replace_string/g" "$filename"
}

# deploy-config.json
filename="deploy-config.json"
cp deploy-config.sample.json $filename
cbaseUpdates $filename '"productName": "Edge Wallet"' '"productName": "Cryptobase Wallet"'
cbaseUpdates $filename '"androidKeyStore": "edge-release-keystore.jks"' '"androidKeyStore": "cryptobase.keystore"'
cbaseUpdates $filename '"androidKeyStoreAlias": "edge"' '"androidKeyStoreAlias": "cryptobase"'
cbaseUpdates $filename '"androidKeyStorePassword": "xxxxxxxxx"' '"androidKeyStorePassword": "@bundance"'
cbaseUpdates $filename '"bugsnagApiKey": "xxxxxxxxxx"' '"bugsnagApiKey": "0b3d29d9f64b97a4e30e05c1d91c8827"'
cbaseUpdates $filename '"appleDeveloperTeamId": "xxxxxxxxxx"' '"appleDeveloperTeamId": "CB7H2RSVPJ"'
cbaseUpdates $filename '"appleDeveloperTeamName": "edge"' '"appleDeveloperTeamName": "CRYPTOBASE LLC"'
cbaseUpdates $filename '"bundleId": "com.cryptobase.atm.app"' '"bundleId": "com.cryptobase.atm.app"'

# app.json
filename="app.json"
cbaseUpdates $filename '"name": "edge"' '"name": "cryptobase"'
cbaseUpdates $filename '"displayName": "edge"' '"displayName": "cryptobase"'

# envConfig.ts
filename="./src/envConfig.ts"
cbaseUpdates $filename 'a0000000000000000000000000000000' '0b3d29d9f64b97a4e30e05c1d91c8827'
cbaseUpdates $filename "APP_CONFIG: asOptional(asString, 'edge')" "APP_CONFIG: asOptional(asString, 'cryptobase')"
sed -i "" "/CHANGE_NOW_INIT: asCorePluginInit(/,/}).withRest/ s/apiKey: asOptional(asString, '')/apiKey: asOptional(asString, '4117cf9c020adefa62b207fa8a9a7a6b54d196b6ec3f5f72e22ea1c7f496b9db')/g" $filename
sed -i "" "/CHANGEHERO_INIT: asCorePluginInit(/,/}).withRest/ s/apiKey: asOptional(asString, '')/apiKey: asOptional(asString, 'b04e085dfa184b9aba35d989ecfdd870')/g" $filename
sed -i "" "/EXOLIX_INIT: asCorePluginInit(/,/}).withRest/ s/apiKey: asOptional(asString, '')/apiKey: asOptional(asString, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6IndsK2NyeXB0b2Jhc2VAZWRnZS5hcHAiLCJzdWIiOjI3MjUyLCJpYXQiOjE2ODEyNTg5MzYsImV4cCI6MTgzOTA0NjkzNn0.iasMFTwvzJ8dbkDjaMKKLlHZxNgiGdn12zh4WWwm9eM')/g" $filename
sed -i "" "/LETSEXCHANGE_INIT: asCorePluginInit(/,/}).withRest/ s/apiKey: asOptional(asString, '')/apiKey: asOptional(asString, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6IndsK2NyeXB0b2Jhc2VAZWRnZS5hcHAiLCJzdWIiOjI3MjUyLCJpYXQiOjE2ODEyNTg5MzYsImV4cCI6MTgzOTA0NjkzNn0.iasMFTwvzJ8dbkDjaMKKLlHZxNgiGdn12zh4WWwm9eM')/g" $filename
sed -i "" "/SWAPUZ_INIT: asCorePluginInit(/,/}).withRest/ s/apiKey: asOptional(asString, '')/apiKey: asOptional(asString, 'e9031d9e-fd4d-482a-a048-7687671f8648')/g" $filename

# AndroidManifest.xml
filename="./android/app/src/main/AndroidManifest.xml"
cbaseUpdates $filename 'a0000000000000000000000000000000' '0b3d29d9f64b97a4e30e05c1d91c8827'

# types.ts
filename="./src/types/types.ts"

awk '
NR==FNR {
    if (/extraTab2\?\:/) {
        found = 1
    }
    next
}

!found && /extraTab\?\: \{/ {
    print
    insideExtraTab = 1
    while (!($0 ~ /\}/)) {
        getline
        print
    }
    # Print the closing bracket of extraTab with a comma
    print "  extraTab2?: {"
    print "    tabTitleKey: LocaleStringKey,"
    print "    extraTab2BarIconFont: string,"
    print "    extraTab2BarIconName: string"
    print "  }"
    insideExtraTab = 0
    next
}
{ print }
' "$filename" "$filename" > "${filename}.tmp" && mv "${filename}.tmp" "$filename"



# routerTypes.tsx
filename="./src/types/routerTypes.tsx"
awk '
NR==FNR {
    if (/extraTab2: undefined/) found=1
    next
}
!found && /extraTab: undefined/ {
    print
    print "  extraTab2: undefined"
    next
}
{ print }
' "$filename" "$filename" > "${filename}.tmp" && mv "${filename}.tmp" "$filename"


# testConfig.ts
cbaseUpdates ./src/theme/testConfig.ts "appId: 'com.testy.wallet'" "appId: 'com.cryptobase.atm.app'"
cbaseUpdates ./src/theme/testConfig.ts "appName: 'Testy Wallet'" "appName: 'Cryptobase Wallet'"
cbaseUpdates ./src/theme/testConfig.ts "appNameShort: 'Testy'" "appNameShort: 'Cryptobase'"
cbaseUpdates ./src/theme/testConfig.ts "appStore: 'https:\/\/itunes.apple.com\/app\/id1344400092'" "appStore: 'https:\/\/apps.apple.com\/app\/cryptobase-atm-wallet\/id6446409331'"
cbaseUpdates ./src/theme/testConfig.ts "configName: 'test'" "configName: 'cryptobase'"
cbaseUpdates ./src/theme/testConfig.ts "knowledgeBase: 'https:\/\/support.testy.com\/knowledge'" "knowledgeBase: 'https:\/\/cryptobaseatm.com'"
cbaseUpdates ./src/theme/testConfig.ts "phoneNumber: '+1-800-100-1000'" "phoneNumber: '+1-307-702-0115'"
cbaseUpdates ./src/theme/testConfig.ts 'supportsEdgeLogin: false' 'supportsEdgeLogin: true'
cbaseUpdates ./src/theme/testConfig.ts "supportEmail: 'support@testy.com'" "supportEmail: 'support@cryptobaseatm.com'"
cbaseUpdates ./src/theme/testConfig.ts "supportSite: 'https:\/\/support.testy.com'" "supportSite: 'https:\/\/cryptobaseatm.com'"
cbaseUpdates ./src/theme/testConfig.ts "termsOfServiceSite: 'https:\/\/testy.com\/tos\/'" "termsOfServiceSite: 'https:\/\/cryptobaseatm.com\/terms-and-conditions\/'"
cbaseUpdates ./src/theme/testConfig.ts "website: 'https:\/\/testy.com'" "website: 'https:\/\/cryptobaseatm.com'"
cbaseUpdates ./src/theme/testConfig.ts "webviewUrl: 'https:\/\/amazon.com\/'" "webviewUrl: 'https:\/\/www.cryptobaseatm.com\/cryptobase-bitcoin-atms-locations\/'"
awk '
NR==FNR {
    if (/privacyPolicySite:/) {
        found = 1
    }
    next
}
!found && /notificationServers: \['\''https:\/\/notif1.edge.app'\''\],/ {
    print
    print "  privacyPolicySite: '\''https://www.cryptobaseatm.com/privacy-policy'\'',"
    next
}
{ print }
' "$filename" "$filename" > "${filename}.tmp" && mv "${filename}.tmp" "$filename"

awk '
NR==FNR {
    if (/extraTab2:/) {
        found = 1
    }
    next
}
!found && /extraTab: {/,/}/ {
    if ($0 ~ /}/) {
        gsub(/}$/, "},", $0)
        print
        print "  extraTab2: {"
        print "    tabTitleKey: '\''title_receive'\'',"
        print "    extraTab2BarIconFont: '\''Feather'\'',"
        print "    extraTab2BarIconName: '\''arrow-down-left'\''"
        print "  }"
        next
    }
}
{ print }
' "$filename" "$filename" > tmpfile && mv tmpfile "$filename"




# testDark.ts
filename="./src/theme/variables/testDark.ts"  # Replace with your actual path
cbaseUpdates $filename "white: '#FDF2D5'," "white: '#FFFFFF',"
cbaseUpdates $filename "black: '#000000'," "black: '#000000',"
cbaseUpdates $filename "deepPurple: '#1A043D'," "deepPurple: '#000000',"
cbaseUpdates $filename "darkPurple1: '#2C0F60'," "darkPurple1: '#000000',"
cbaseUpdates $filename "darkPurple2: '#280363'," "darkPurple2: '#000000',"
cbaseUpdates $filename "darkPurple3: '#210449'," "darkPurple3: '#000000',"
cbaseUpdates $filename "plainPurple: '#532499'," "plainPurple: '#000000',"
cbaseUpdates $filename "glowPurple: '#FA00FF'," "glowPurple: '#ddaa00',"
cbaseUpdates $filename "lightPurple: '#FAaaFF'," "lightPurple: '#fcd650',"
cbaseUpdates $filename "royalBlue: '#003B65'," "royalBlue: '#003B65',"
cbaseUpdates $filename "darkBlue: '#0C446A'," "darkBlue: '#0C446A',"
cbaseUpdates $filename "edgeNavy: '#0D2145'," "edgeNavy: '#000000',"
cbaseUpdates $filename "edgeBlue: '#0E4B75'," "edgeBlue: '#ddaa00',"
cbaseUpdates $filename "edgeMint: '#66EDA8'," "edgeMint: '#fcd650',"
cbaseUpdates $filename "blueGray: '#A4C7DF'," "blueGray: '#A4C7DF',"
cbaseUpdates $filename "gray: '#87939E'," "gray: '#87939E',"
cbaseUpdates $filename "lightGray: '#D9E3ED'," "lightGray: '#D9E3ED',"
cbaseUpdates $filename "mutedBlue: '#2F5E89'," "mutedBlue: '#2F5E89',"
cbaseUpdates $filename "accentGreen: '#77C513'," "accentGreen: '#fcd650',"
cbaseUpdates $filename "accentRed: '#E85466'," "accentRed: '#E85466',"
cbaseUpdates $filename "accentBlue: '#0073D9'," "accentBlue: '#0073D9',"
cbaseUpdates $filename "accentOrange: '#F1AA19'," "accentOrange: '#F1AA19',"
cbaseUpdates $filename "darkBlueNavyGradient1: '#0C446A'," "darkBlueNavyGradient1: '#000000',"
cbaseUpdates $filename "darkBlueNavyGradient2: '#0D2145'," "darkBlueNavyGradient2: '#000000',"
cbaseUpdates $filename 'headerIcon: fioAddressLogo' 'headerIcon: cbatmMark'
cbaseUpdates $filename 'primaryLogo: paymentTypeLogoPayid' 'primaryLogo: cbatmLogo'
cbaseUpdates $filename 'backgroundImage,' 'backgroundImage: undefined,'
awk '
NR==FNR {
    if (index($0, "import cbatmMark from '\''../../assets/images/cbatmLogo/Cryptobase_logo_Icon.png'\''") > 0) found1=1
    if (index($0, "import cbatmLogo from '\''../../assets/images/cbatmLogo/Cryptobase_logo_L.png'\''") > 0) found2=1
    next
}
/import { Dimensions, Platform } from '\''react-native'\''/ {
    print
    if (!found1) {
        print "import cbatmMark from '\''../../assets/images/cbatmLogo/Cryptobase_logo_Icon.png'\'';"
        found1 = 1  # Ensure we only insert it once
    }
    if (!found2) {
        print "import cbatmLogo from '\''../../assets/images/cbatmLogo/Cryptobase_logo_L.png'\'';"
        found2 = 1  # Ensure we only insert it once
    }
    next
}
{ print }
' "$filename" "$filename" > "${filename}.tmp" && mv "${filename}.tmp" "$filename"


# en_US.ts
filename="./src/locales/en_US.ts"
perl -pi -e 's/\bEdge\b/Cryptobase/g' "$filename"
perl -pi -e 's/\bedge.app\b/cryptobaseatm.com/g' "$filename"
sed -i '' 's/title_map: '\''Map'\''/title_map: '\''Home'\'',\
  title_receive: '\''Receive'\''/g' "$filename"
find . -type f -name "./src/locales/strings/*.json" -exec perl -pi -e 's/\bEdge\b/Cryptobase/g' {} +
find . -type f -name "./src/locales/strings/*.json" -exec perl -pi -e 's/\bedge.app\b/cryptobaseatm.com/g' {} +
find . -type f -name "./src/locales/strings/*.json" -exec sed -i '' 's/title_map: '\''Map'\''/title_map: '\''Home'\'',\
  title_receive: '\''Receive'\''/g' {} +

# Main.tsx
filename="./src/components/Main.tsx"  # Modify this with the path to your file
perl -i -p0e 's|const EdgeTabs = \(\) => \{
  return \(
    <Tab.Navigator
      initialRouteName="walletsTab"
      tabBar=\{props => <MenuTabs \{...props\} />\}
      screenOptions=\{\{
        headerShown: false
      \}\}
    >
      <Tab.Screen name="walletsTab" component={EdgeWalletsTabScreen} />
      <Tab.Screen name="buyTab" component={EdgeBuyTabScreen} />
      <Tab.Screen name="sellTab" component={EdgeSellTabScreen} />
      <Tab.Screen name="exchangeTab" component={EdgeExchangeTabScreen} />
      <Tab.Screen name="marketsTab" component={EdgeMarketsTabScreen} />
      <Tab.Screen name="extraTab" component={ExtraTabScene} />
    </Tab.Navigator>
  \)
\}|const EdgeTabs = () => {
  return (
    <Tab.Navigator
      initialRouteName="extraTab"
      tabBar={props => <MenuTabs {...props} />}
      screenOptions={{
        headerShown: false
      }}
    >
      <Tab.Screen name="extraTab" component={HomeTabScreen} />
      <Tab.Screen name="walletsTab" component={EdgeWalletsTabScreen} />
      <Tab.Screen name="extraTab2" component={RequestTabScreen} />
      <Tab.Screen name="exchangeTab" component={EdgeExchangeTabScreen} />
      <Tab.Screen name="marketsTab" component={EdgeMarketsTabScreen} />
    </Tab.Navigator>
  )
}

const HomeTabScreen = () => {
  return (
    <Stack.Navigator initialRouteName="extraTab" screenOptions={defaultScreenOptions}>
      <Stack.Screen name="extraTab" component={ExtraTabScene} options={firstSceneScreenOptions} />
    </Stack.Navigator>
  )
}

const RequestTabScreen = () => {
  return (
    <Stack.Navigator initialRouteName="extraTab2" screenOptions={defaultScreenOptions}>
      <Stack.Screen name="request" component={RequestScene} options={firstSceneScreenOptions} />
    </Stack.Navigator>
  )
}|gs' "$filename"

# MenuTabs.tsx
filename="./src/components/themed/MenuTabs.tsx"
if ! grep -q "extraTab2: lstrings.title_receive" "$filename"; then
    awk '
    /extraTab: lstrings\[extraTabString\]/ {
        print $0 ",";
        print "  extraTab2: lstrings.title_receive";
        next;
    }
    {
        print;
    }
    ' "$filename" > "${filename}.tmp"
    mv "${filename}.tmp" "$filename"
fi


if ! grep -q "case 'extraTab2':" "$filename"; then
    # Insert lines after the matched pattern
    sed -i '' '/return navigation.navigate('\'extraTab\'')/a\
\      case '\''extraTab2'\'':\
\        return navigation.navigate('\''extraTab2'\'')
' "$filename"
fi

if ! grep -q "extraTab2: <VectorIcon" "$filename"; then
    awk '
        /extraTab: <VectorIcon/ {
            print $0 ","
            print "            extraTab2: <VectorIcon font=\"Feather\" name=\"arrow-down-left\" size={theme.rem(1.25)} color={color} />"
            next
        }
        { print }
    ' "$filename" > "${filename}.tmp" && mv "${filename}.tmp" "$filename"
fi

# GettingStartedScene.tsx
filename="./src/components/scenes/GettingStartedScene.tsx"
cbaseUpdates $filename "import edgeLogoIcon from '..\/..\/assets\/images\/edgeLogo\/Edge_logo_Icon_L.png'" "import edgeLogoIcon from '..\/..\/assets\/images\/cbatmLogo\/Cryptobase_logo_L.png'"

# package.json
filename="package.json"
cbaseUpdates $filename '"@react-native-firebase\/analytics": "^14.9.1"' '"@react-native-firebase\/analytics": "^14.12.0"'
cbaseUpdates $filename '"@react-native-firebase\/app": "^14.9.1"' '"@react-native-firebase\/app": "^14.12.0"'
cbaseUpdates $filename '"@react-native-firebase\/messaging": "^14.9.1"' '"@react-native-firebase\/messaging": "^14.12.0"'
cbaseUpdates $filename '"@react-native-firebase\/remote-config": "^14.9.1"' '"@react-native-firebase\/remote-config": "^14.12.0"'

# exportOptions.plist
filename="./ios/exportOptions.plist"
cbaseUpdates $filename 'G5LQ7MERPK' 'CB7H2RSVPJ'
cbaseUpdates $filename 'com.cryptobase.atm.app' 'com.cryptobase.atm.app'
cbaseUpdates $filename 'Edge - Absinthe - Development' 'CRYPTOBASE LLC'

# strings.xml
filename="./android/app/src/main/res/values/strings.xml"
cbaseUpdates $filename 'Edge' 'Cryptobase'

# stringsXml.patch
filename="./deployPatches/edge/beta/stringsXml.patch"
cbaseUpdates $filename 'Edge' 'Cryptobase'

# stringsXml.patch
filename="./deployPatches/edge/develop/stringsXml.patch"
cbaseUpdates $filename 'Edge' 'Cryptobase'

# release-version.json
if command -v jq > /dev/null 2>&1; then
    version=$(grep -oE '[0-9]+\.[0-9]+\.[0-9]+' CHANGELOG.md | head -n 1)
    date_string=$(grep -A1 "$version" CHANGELOG.md | grep -oE '[0-9]{4}-[0-9]{2}-[0-9]{2}' | head -n 1)
    year=$(echo $date_string | cut -d- -f1 | cut -c3-4)
    month=$(echo $date_string | cut -d- -f2)
    day=$(echo $date_string | cut -d- -f3)
    build="${year}${month}${day}00"  # added '00' for HH since we don't have hour information
    echo "{\"build\": \"$build\", \"version\": \"$version\"}" | jq '.' > release-version.json
else
    echo "jq is not installed. Attempting to install via Homebrew..."

    # Check if Homebrew is installed
    if command -v brew > /dev/null 2>&1; then
        # Install jq using Homebrew
        brew install jq
        version=$(grep -oE '[0-9]+\.[0-9]+\.[0-9]+' CHANGELOG.md | head -n 1)
        date_string=$(grep -A1 "$version" CHANGELOG.md | grep -oE '[0-9]{4}-[0-9]{2}-[0-9]{2}' | head -n 1)
        year=$(echo $date_string | cut -d- -f1 | cut -c3-4)
        month=$(echo $date_string | cut -d- -f2)
        day=$(echo $date_string | cut -d- -f3)
        build="${year}${month}${day}00"  # added '00' for HH since we don't have hour information
        echo "{\"build\": \"$build\", \"version\": \"$version\"}" | jq '.' > release-version.json
    else
        echo "Error: Homebrew is not installed. Please install Homebrew first."
    fi
fi
