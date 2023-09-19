import { AppConfig } from '../types/types'
import { testDark } from './variables/testDark'
import { testLight } from './variables/testLight'

export const testConfig: AppConfig = {
  appId: 'com.cryptobase.atm.app',
  appName: 'Cryptobase Wallet',
  appNameShort: 'Cryptobase',
  appStore: 'https://apps.apple.com/app/cryptobase-atm-wallet/id6446409331',
  backupAccountSite: 'https://support.testy.com/accountbackupinfo',
  configName: 'cryptobase',
  darkTheme: testDark,
  defaultWallets: ['BTC', 'FTM:TOMB', 'ETH:USDC'],
  knowledgeBase: 'https://cryptobaseatm.com',
  lightTheme: testLight,
  notificationServers: ['https://notif1.edge.app'],
  privacyPolicySite: 'https://www.cryptobaseatm.com/privacy-policy',
  phoneNumber: '+1-307-702-0115',
  referralServers: ['https://referral1.testy.com'],
  supportsEdgeLogin: true,
  supportEmail: 'support@cryptobaseatm.com',
  supportSite: 'https://cryptobaseatm.com',
  termsOfServiceSite: 'https://cryptobaseatm.com/terms-and-conditions/',
  website: 'https://cryptobaseatm.com',
  extraTab: {
    tabTitleKey: 'title_map',
    tabType: 'edgeProvider',
    webviewUrl: 'https://www.cryptobaseatm.com/cryptobase-bitcoin-atms-locations/',
    extraTabBarIconFont: 'Feather',
    extraTabBarIconName: 'map-pin'
  },
  extraTab2: {
    tabTitleKey: 'title_receive',
    extraTab2BarIconFont: 'Feather',
    extraTab2BarIconName: 'arrow-down-left'
  }
}
