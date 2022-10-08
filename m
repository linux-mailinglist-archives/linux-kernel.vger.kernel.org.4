Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 512B65F85B5
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 17:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbiJHPBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 11:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbiJHPBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 11:01:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8622134987
        for <linux-kernel@vger.kernel.org>; Sat,  8 Oct 2022 08:01:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 142AE6068C
        for <linux-kernel@vger.kernel.org>; Sat,  8 Oct 2022 15:01:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C16AEC433C1;
        Sat,  8 Oct 2022 15:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1665241295;
        bh=Ok0R994xYexkb7ieTsybIQvmS5RBVIFaSxD87dTj9r4=;
        h=Date:From:To:Cc:Subject:From;
        b=ifP7YZbhVNBmUodv98I6BU+Kthrrm7VImax6zSpor0m6Vw6D22mt+Hrd6d6Dr0AhR
         WnhKtCEgo8PbMN1dX90cWkHW4Eg4G9NRhB9Dg3ujsIwbDRQEa1EBNQ5XrLwTs8PnaM
         x3VY+B3CpYqUBqnenW3V/KKQYAbFffo/0MKIMaU8=
Date:   Sat, 8 Oct 2022 17:02:16 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [GIT PULL] Staging driver changes for 6.1-rc1
Message-ID: <Y0GQ+GimB8eTuRDL@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 7e18e42e4b280c85b76967a9106a13ca61c16179:

  Linux 6.0-rc4 (2022-09-04 13:10:01 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-6.1-rc1

for you to fetch changes up to 4256e500f61922a3e59c7ecb6a11aab972d41b18:

  staging: rtl8192e: Rename variable Bandwidth to avoid CamelCase (2022-09-30 14:34:38 +0200)

----------------------------------------------------------------
Staging driver changes for 6.1-rc1

Here is the large set of staging driver changes for 6.1-rc1.

Nothing really interesting in here at all except we deleted a driver
(fwserial) as no one had been using it for a long time.  Other than
that, just the normal cleanups and minor fixes:
  - rtl8723bs driver cleanups
  - loads of r8188eu driver cleanups, making the driver smaller and
    fixing up some firmware dependency issues.
  - vt6655 driver cleanups.
  - lots of other small staging driver cleanups.

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alman Khan (1):
      staging: rtl8192e: Describe each kernel config option

Asif Khan (1):
      staging: rtl8712: fix camelcase in UserPriority

Christopher Carbone (1):
      staging: sm750fb: split multiple assignments to lines

Dragan Cvetic (1):
      staging: rtl8192e: Rename Tx_Retry_Count_Reg

GUO Zihua (4):
      staging: rtl8712: Fix return type for implementation of ndo_start_xmit
      staging: rtl8192e: Fix return type for implementation of ndo_start_xmit
      staging: rtl8723bs: Delete un-necessary return for _rtw_xmit_entry()
      staging: rtl8723bs: Fix return type for implementation of ndo_start_xmit

Gaosheng Cui (1):
      staging: wlan-ng: remove unused p80211wext_handler_def declaration

Greg Kroah-Hartman (3):
      Merge 6.0-rc4 into staging-next
      staging: greybus: audio_helper: remove unused and wrong debugfs usage
      staging: fwserial: delete the driver.

Grzegorz Szymaszek (5):
      staging: r8188eu: add firmware dependency
      staging: r8188eu: set firmware path in a macro
      staging: r8188eu: use KBUILD_MODNAME instead of a string constant
      staging: r8188eu: drop the DRV_NAME macro
      staging: r8188eu: drop the DRIVERVERSION macro

Jilin Yuan (1):
      staging/rtl8192e: fix repeated words in comments

Kang Minchul (7):
      staging: rtl8723bs: remove braces in single statement blocks
      staging: rtl8723bs: Insert blank line after declarations
      staging: rtl8723bs: Fix coding style issue in block comment
      staging: rtl8723bs: replace code indent as tabs
      staging: rtl8723bs: Relocate constant on the right side of test
      staging: rtl8723bs: Make switch and case at the same indent
      staging: rtl8723bs: Add a blank line after declarations

Li zeming (1):
      staging/rtl8723bs/core: remove inactive initialization

Liu Shixin (1):
      staging: pi433: use DEFINE_SHOW_ATTRIBUTE to simplify pi433_debugfs_regs

Martin Kaiser (59):
      staging: r8188eu: txpktbuf_bndy does not depend on wifi_spec
      staging: r8188eu: handle errors from ReadAdapterInfo8188EU
      staging: r8188eu: make rtw_handle_dualmac a void function
      staging: r8188eu: return an error code in rtw_usb_if1_init
      staging: r8188eu: replace a get_da call
      staging: r8188eu: read status_code from struct ieee80211_mgmt
      staging: r8188eu: read capability info from struct ieee80211_mgmt
      staging: r8188eu: read aid from struct ieee80211_mgmt
      staging: r8188eu: simplify the calculation of ie start offset
      staging: r8188eu: Hal_MappingOutPipe should return an int
      staging: r8188eu: process HalUsbSetQueuePipeMapping8188EUsb's return value
      staging: r8188eu: merge two small functions
      staging: r8188eu: move endpoint init functions to usb_halinit.c
      staging: r8188eu: summarize endpoint-related settings
      staging: r8188eu: remove OutEpNumber
      staging: r8188eu: remove comments about endpoint mapping
      staging: r8188eu: summarize common Queue2Pipe settings
      staging: r8188eu: simplify three_out_pipe
      staging: r8188eu: simplify two_out_pipe
      staging: r8188eu: remove _InitNormalChipOneOutEpPriority
      staging: r8188eu: we always use HQ and NQ for two endpoints
      staging: r8188eu: simplify _InitNormalChipTwoOutEpPriority
      staging: r8188eu: remove a temporary variable
      staging: r8188eu: make numNQ a u8
      staging: r8188eu: change all num...Q variables to u8
      staging: r8188eu: remove two unused defines
      staging: r8188eu: the high prio queue is always selected
      staging: r8188eu: don't restart "no link" blinking unnecessarily
      staging: r8188eu: always cancel blink_work
      staging: r8188eu: always update the status variables
      staging: r8188eu: remove channel parameters from rtw_sitesurvey_cmd
      staging: r8188eu: simplify the LED_CTL_POWER_OFF case
      staging: r8188eu: don't restart WPS blinking unnecessarily
      staging: r8188eu: always cancel blink_work before WPS blinking
      staging: r8188eu: always update status before WPS blinking
      staging: r8188eu: always cancel blink_work when WPS failed
      staging: r8188eu: reset blink state when WPS fails
      staging: r8188eu: do not "scan blink" if we have a link
      staging: r8188eu: remove empty rtw_set_scan_deny macro
      staging: r8188eu: remove rtw_set_scan_deny_timer_hdl
      staging: r8188eu: remove rtw_clear_scan_deny
      staging: r8188eu: rtw_is_scan_deny is always false
      staging: r8188eu: simplify the code to prevent scan blinking restart
      staging: r8188eu: cancel blink_work before scan blinking
      staging: r8188eu: update status before scan blinking
      staging: r8188eu: simplify the code to prevent tx/rx blinking restart
      staging: r8188eu: cancel blink_work before tx/rx blinking
      staging: r8188eu: update status before scan blinking
      staging: r8188eu: simplify the code to prevent link blinking restart
      staging: r8188eu: cancel blink_work before link blinking
      staging: r8188eu: update status before link blinking
      staging: r8188eu: cancel blink_work during wps stop
      staging: r8188eu: update status before wps success blinking
      staging: r8188eu: remove bLedNoLinkBlinkInProgress
      staging: r8188eu: remove BlinkingLedState
      staging: r8188eu: remove duplicate bSurpriseRemoved check
      staging: r8188eu: remove two unused enum entries
      staging: r8188eu: don't check bSurpriseRemoved in SwLedOff
      staging: r8188eu: don't check for stop/removal in the blink worker

Michael Straube (73):
      staging: r8188eu: convert dump_chip_info() to use netdev_dbg()
      staging: r8188eu: refactor dump_chip_info()
      staging: r8188eu: make handle_txrpt_ccx_88e() static
      staging: r8188eu: make rtl8188eu_{init,free}_recv_priv() static
      staging: r8188eu: use ffs() in phy_CalculateBitShift()
      staging: r8188eu: avoid camel case in phy_CalculateBitShift()
      staging: r8188eu: clean up comment for phy_calculate_bit_shift()
      staging: r8188eu: do not spam the kernel log
      staging: r8188eu: merge rtw_os_recvbuf_resource_free() into rtw_recv.c
      staging: r8188eu: merge rtw_os_recvbuf_resource_alloc() into rtw_recv.c
      staging: r8188eu: make rtw_handle_tkip_mic_err() static
      staging: r8188eu: make rtw_recv_indicatepkt() static
      staging: r8188eu: make rtw_init_recv_timer() static
      staging: r8188eu: remove rtw_endofpktfile()
      staging: r8188eu: make init_mlme_ext_timer() static
      staging: r8188eu: make init_addba_retry_timer() static
      staging: r8188eu: make rtw_indicate_sta_disassoc_event() static
      staging: r8188eu: move rtw_indicate_sta_assoc_event() to rtw_ap.c
      staging: r8188eu: make rtw_report_sec_ie() static
      staging: r8188eu: remove unneeded initializations
      staging: r8188eu: make rtw_reset_securitypriv() static
      staging: r8188eu: merge rtw_{os,}_indicate_disconnect()
      staging: r8188eu: merge rtw_{os,}_indicate_connect()
      staging: r8188eu: merge rtw_{os,}_indicate_scan_done()
      staging: r8188eu: remove unused function parameter
      staging: r8188eu: remove ODM_ConfigRFWithHeaderFile()
      staging: r8188eu: make rtw_remainder_len() static
      staging: r8188eu: make rtw_os_xmit_schedule() static
      staging: r8188eu: rename rtw_os_xmit_schedule()
      staging: r8188eu: make rtw_os_xmit_resource_alloc() static
      staging: r8188eu: rename rtw_os_xmit_resource_alloc()
      staging: r8188eu: make rtw_os_xmit_resource_free() static
      staging: r8188eu: rename rtw_os_xmit_resource_free()
      staging: r8188eu: make _rtw_open_pktfile() static
      staging: r8188eu: rename _rtw_open_pktfile()
      staging: r8188eu: make _rtw_pktfile_read() static
      staging: r8188eu: rename _rtw_pktfile_read()
      staging: r8188eu: remove unnecessary initialization to zero
      staging: r8188eu: move struct pkt_file to rtw_xmit.h
      staging: r8188eu: move rtw_os_xmit_complete() to rtw_xmit.c
      staging: r8188eu: rename rtw_os_xmit_complete()
      staging: r8188eu: make rtw_os_pkt_complete() static
      staging: r8188eu: rename rtw_os_pkt_complete()
      staging: r8188eu: remove os_dep/xmit_linux.c
      staging: r8188eu: remove xmit_osdep.h
      staging: r8188eu: remove unused module parameter rtw_chip_version
      staging: r8188eu: make two functions static
      staging: r8188eu: remove os_dep/mlme_linux.c
      staging: r8188eu: remove mlme_osdep.h
      staging: r8188eu: remove some unused enums
      staging: r8188eu: remove unused parameters from _BeaconFunctionEnable()
      staging: r8188eu: remove unused parameter from UpdateBrateTbl()
      staging: r8188eu: make two functions static
      staging: r8188eu: remove unnecessary return labels.
      staging: r8188eu: make c2h_evt_read() static
      staging: r8188eu: rename odm_SignalScaleMapping()
      staging: r8188eu: clean up camel case in odm_signal_scale_mapping()
      staging: r8188eu: remove unnecessary initialization
      staging: r8188eu: rename odm_QueryRxPwrPercentage()
      staging: r8188eu: clean up camel case in odm_query_rxpwrpercentage()
      staging: r8188eu: replace tabs with space in odm_query_rxpwrpercentage()
      staging: r8188eu: make _netdev_open() static
      staging: r8188eu: remove unused prototypes from recv_osdep.h
      staging: r8188eu: remove recv_osdep.h
      staging: r8188eu: make odm_ConfigMAC_8188E() static
      staging: r8188eu: make odm_ConfigRF_RadioA_8188E() static
      staging: r8188eu: remove hal/odm_RegConfig8188E.c
      staging: r8188eu: convert ODM_ReadAndConfig_MAC_REG_8188E() to int
      staging: r8188eu: convert ODM_ReadAndConfig_RadioA_1T_8188E() to int
      staging: r8188eu: convert ODM_ReadAndConfig_PHY_REG_1T_8188E() to int
      staging: r8188eu: convert ODM_ReadAndConfig_AGC_TAB_1T_8188E() to int
      staging: r8188eu: remove PHY_RF6052_Config8188E()
      staging: r8188eu: remove PHY_RFConfig8188E()

Minghao Chi (1):
      staging: r8188eu: remove unnecessary null check

Mingyi Kang (1):
      staging: vme_user: Fix checkpatch warnings in vme_tsi148.c

Nam Cao (25):
      staging: r8188eu: remove ioctl_cfg80211.h
      staging: rtl8723bs: remove function rtw_odm_dbg_comp_msg
      staging: rtl8723bs: remove function rtw_get_ch_setting_union
      staging: rtl8723bs: remove function rtw_odm_ability_set
      staging: rtl8723bs: remove function GetFractionValueFromString
      staging: rtl8723bs: remove function IsCommentString
      staging: rtl8723bs: remove function rtw_odm_adaptivity_parm_msg
      staging: rtl8723bs: remove function rtw_odm_dbg_comp_set
      staging: rtl8723bs: remove static const variable odm_comp_str
      staging: rtl8723bs: remove unused function ODM_InbandNoise_Monitor
      staging: rtl8723bs: remove member noise_level from struct dm_odm_t
      staging: rtl8723bs: remove odm_NoiseMonitor.h and odm_NoiseMonitor.c
      staging: rtl8723bs: delete rtw_setdatarate_cmd
      staging: rtl8723bs: delete function rtw_set_chplan_cmd
      staging: rtl8723bs: remove rtw_change_ifname
      staging: rtl8723bs: delete rtw_odm.c and rtw_odm.h
      staging: rtl8723bs: remove odm_PauseDIG
      staging: rtl8723bs: remove GetHexValueFromString
      staging: rtl8723bs: remove hal_btcoex_SetManualControl
      staging: rtl8723bs: remove rtw_hal_is_disable_sw_channel_plan
      staging: rtl8723bs: remove IsHexDigit
      staging: rtl8723bs: remove rtw_is_wps_ie
      staging: vt6655: remove unnecessary null check
      staging: vt6655: fix potential memory leak
      staging: vt6655: fix some erroneous memory clean-up loops

Nathan Huckleberry (3):
      staging: rtl8192u: Fix return type of ieee80211_xmit
      staging: octeon: Fix return type of cvm_oct_xmit and cvm_oct_xmit_pow
      staging: r8188eu: Fix return type of rtw_xmit_entry

Philipp Hortmann (60):
      staging: vt6655: Convert macro MACvReceive0 to function
      staging: vt6655: Rename function MACvReceive0 and add parameter
      staging: vt6655: Replace MACvReceive1 with function vt6655_mac_dma_ctl
      staging: vt6655: Replace MACvTransmit0 with function vt6655_mac_dma_ctl
      staging: vt6655: Replace MACvTransmitAC0 with function vt6655_mac_dma_ctl
      staging: vt6655: Convert macro MACvEnableProtectMD to function
      staging: vt6655: Create one function for two macros
      staging: vt6655: Rename function MACvEnableProtectMD
      staging: vt6655: Convert macro MACvDisableProtectMD
      staging: vt6655: Convert macro MACvEnableBarkerPreambleMd
      staging: vt6655: Convert macro MACvDisableBarkerPreambleMd
      staging: rtl8192e: Remove blank lines in rtl_core.c
      staging: rtl8192e: Rename Tx... and RxCheckStuckHandler
      staging: rtl8192e: Remove Unnecessary ftrace-like logging
      staging: rtl8192e: Remove PHY_SetRFPowerState and rename StateToSet
      staging: vt6655: Remove declaration of s_vCalculateOFDMRParameter
      staging: vt6655: Convert macro MACvSetBBType to function
      staging: vt6655: Rename function MACvSetBBType
      staging: vt6655: Rename macro MACvSelectPage0
      staging: vt6655: Rename macro MACvSelectPage1
      staging: vt6655: Replace macro MACvSetRFLE_LatchBase
      staging: vt6655: Rename function MACbIsRegBitsOff
      staging: vt6655: Delete function MACbIsIntDisable
      staging: vt6655: Rename function MACvSetShortRetryLimit
      staging: rtl8192e: Rename ChangeSource
      staging: rtl8192e: Rename bActionAllowed
      staging: rtl8192e: Rename bConnectBySSID
      staging: rtl8192e: Rename rtState
      staging: rtl8192e: Rename RFWaitCounter
      staging: rtl8192e: Rename RFChangeInProgress
      staging: rtl8192e: Rename bHwRadioOff
      staging: rtl8192e: Rename CurSlotTime
      staging: vt6655: Cleanup and rename function MACvSetLoopbackMode
      staging: vt6655: Cleanup and rename function MACvSaveContext
      staging: vt6655: Cleanup and rename function MACvRestoreContext
      staging: vt6655: Cleanup and rename function MACbSafeSoftwareReset
      staging: vt6655: Rename function MACbSafeRxOff
      staging: vt6655: Rename function MACbSafeTxOff
      staging: vt6655: Rename function MACbSafeStop
      staging: vt6655: Rename function MACvSetCurrRx0DescAddr
      staging: vt6655: Rename function MACvSetCurrRx1DescAddr
      staging: vt6655: Cleanup and rename function MACvSetCurrTXDescAddr
      staging: vt6655: Rename function MACvSetCurrTx0DescAddrEx
      staging: vt6655: Rename function MACvSetCurrAC0DescAddrEx
      staging: rtl8192e: Remove ftrace-like logging in r8192E_firmware.c, ...
      staging: rtl8192e: Remove ftrace-like logging in r8192E_dev.c
      staging: rtl8192e: Remove ftrace-like logging in r8192E_phy.c
      staging: rtl8192e: Remove ftrace-like logging in rtl_dm.c
      staging: rtl8192e: Remove ftrace-like logging in rtl_ps.c
      staging: rtl8192e: Remove ftrace-like logging in rtl819x_BAProc.c, ...
      staging: rtl8192e: Rename eRFPowerState, eRfOff and eRfOn
      staging: rtl8192e: Rename eRfSleep, eRfPowerStateToSet and RfOffReason
      staging: rtl8192e: Rename dot11Cur..., bCurTxBW40MHz and bCurrentRT2...
      staging: rtl8192e: Rename bSwBwInPro..., bRegRT2RTAg... and bCurrentRT...
      staging: rtl8192e: Rename szRT2RTAggBuffer, bRegRxRe... and bCurRxReo...
      staging: rtl8192e: Rename RxRe...WinSize, RxReorder... and RxReorderDr...
      staging: rtl8192e: Rename PeerMimoPs, IOTAction and IOTRaFunc
      staging: rtl8192e: Rename SelfMimoPs, CurrentOpMode and bForcedShortGI
      staging: rtl8192e: Rename CurrentMPDU..., ForcedAMPDU... and ForcedMPDU...
      staging: rtl8192e: Remove unused variables ForcedAMSDUMaxSize, ...

Phillip Potter (1):
      staging: r8188eu: convert rtw_p2p_enable to correct error code semantics

Shang XiaoJing (3):
      staging: fwserial: Switch to kfree_rcu() API
      staging: r8188eu: Use skb_put_data() instead of skb_put/memcpy pair
      staging: rtl8192e: cmdpkt: Use skb_put_data() instead of skb_put/memcpy pair

Sidong Yang (1):
      staging: pi433: fix wrong debug message on rf69_write_fifo()

Tong Zhang (4):
      staging: rtl8192u: move debug stuff to its own file
      staging: rtl8192u: remove unnecessary cast
      staging: rtl8192u: move debug files to debugfs
      staging: rtl8192u: fix rmmod warn when device is renamed

Valentin Vidic (1):
      staging: rtl8192e: fix CamelCase variables

Wolfram Sang (1):
      staging: move from strlcpy with unused retval to strscpy

Xiaoke Wang (5):
      staging: rtl8723bs: fix potential memory leak in rtw_init_drv_sw()
      staging: rtl8723bs: fix a potential memory leak in rtw_init_cmd_priv()
      staging: r8188eu: fix a potential memory leak in rtw_init_cmd_priv()
      staging: r8188eu: add kfree() on an error path of rtw_xmit_resource_alloc()
      staging: r8188eu: fix potential memory leak in _rtw_init_xmit_priv()

Yogesh Hegde (1):
      staging: rtl8192e: Rename variable Bandwidth to avoid CamelCase

Yu Zhe (1):
      staging: r8188eu: use time_after_eq(a,b) to replace "a>=b"

 drivers/staging/Kconfig                            |    2 -
 drivers/staging/Makefile                           |    1 -
 drivers/staging/fwserial/Kconfig                   |   32 -
 drivers/staging/fwserial/Makefile                  |    3 -
 drivers/staging/fwserial/TODO                      |   14 -
 drivers/staging/fwserial/dma_fifo.c                |  294 --
 drivers/staging/fwserial/dma_fifo.h                |  117 -
 drivers/staging/fwserial/fwserial.c                | 2890 --------------------
 drivers/staging/fwserial/fwserial.h                |  359 ---
 drivers/staging/greybus/audio_helper.c             |   11 -
 drivers/staging/octeon/ethernet-tx.c               |    4 +-
 drivers/staging/octeon/ethernet-tx.h               |    4 +-
 drivers/staging/pi433/pi433_if.c                   |   16 +-
 drivers/staging/pi433/rf69.c                       |    2 +-
 drivers/staging/r8188eu/Makefile                   |    6 -
 drivers/staging/r8188eu/core/rtw_ap.c              |   42 +
 drivers/staging/r8188eu/core/rtw_br_ext.c          |    1 -
 drivers/staging/r8188eu/core/rtw_cmd.c             |   91 +-
 drivers/staging/r8188eu/core/rtw_fw.c              |    2 +-
 drivers/staging/r8188eu/core/rtw_ioctl_set.c       |   13 +-
 drivers/staging/r8188eu/core/rtw_led.c             |  285 +-
 drivers/staging/r8188eu/core/rtw_mlme.c            |  153 +-
 drivers/staging/r8188eu/core/rtw_mlme_ext.c        |   84 +-
 drivers/staging/r8188eu/core/rtw_p2p.c             |   19 +-
 drivers/staging/r8188eu/core/rtw_pwrctrl.c         |    2 +-
 drivers/staging/r8188eu/core/rtw_recv.c            |  204 +-
 drivers/staging/r8188eu/core/rtw_sta_mgt.c         |   28 +-
 drivers/staging/r8188eu/core/rtw_wlan_util.c       |   45 +-
 drivers/staging/r8188eu/core/rtw_xmit.c            |  269 +-
 drivers/staging/r8188eu/hal/HalHWImg8188E_BB.c     |   68 +-
 drivers/staging/r8188eu/hal/HalHWImg8188E_MAC.c    |   14 +-
 drivers/staging/r8188eu/hal/HalHWImg8188E_RF.c     |   39 +-
 drivers/staging/r8188eu/hal/hal_com.c              |  173 --
 drivers/staging/r8188eu/hal/odm_HWConfig.c         |   65 +-
 drivers/staging/r8188eu/hal/odm_RegConfig8188E.c   |   89 -
 drivers/staging/r8188eu/hal/rtl8188e_cmd.c         |    2 -
 drivers/staging/r8188eu/hal/rtl8188e_hal_init.c    |   40 +-
 drivers/staging/r8188eu/hal/rtl8188e_phycfg.c      |   45 +-
 drivers/staging/r8188eu/hal/rtl8188e_rf6052.c      |   15 +-
 drivers/staging/r8188eu/hal/rtl8188e_xmit.c        |   22 -
 drivers/staging/r8188eu/hal/rtl8188eu_recv.c       |   91 -
 drivers/staging/r8188eu/hal/rtl8188eu_xmit.c       |    4 +-
 drivers/staging/r8188eu/hal/usb_halinit.c          |  205 +-
 drivers/staging/r8188eu/hal/usb_ops_linux.c        |   15 +-
 drivers/staging/r8188eu/include/Hal8188EPhyCfg.h   |    1 -
 drivers/staging/r8188eu/include/HalHWImg8188E_BB.h |    4 +-
 .../staging/r8188eu/include/HalHWImg8188E_MAC.h    |    3 +-
 drivers/staging/r8188eu/include/HalHWImg8188E_RF.h |    2 +-
 drivers/staging/r8188eu/include/drv_types.h        |    7 +-
 drivers/staging/r8188eu/include/hal_com.h          |    4 -
 drivers/staging/r8188eu/include/hal_intf.h         |    5 +-
 drivers/staging/r8188eu/include/ioctl_cfg80211.h   |   89 -
 drivers/staging/r8188eu/include/mlme_osdep.h       |   19 -
 drivers/staging/r8188eu/include/odm_HWConfig.h     |    1 -
 .../staging/r8188eu/include/odm_RegConfig8188E.h   |   21 -
 drivers/staging/r8188eu/include/odm_types.h        |    5 -
 drivers/staging/r8188eu/include/osdep_intf.h       |    3 +
 drivers/staging/r8188eu/include/recv_osdep.h       |   30 -
 drivers/staging/r8188eu/include/rtl8188e_hal.h     |   11 +-
 drivers/staging/r8188eu/include/rtl8188e_recv.h    |    2 -
 drivers/staging/r8188eu/include/rtl8188e_rf.h      |    2 +-
 drivers/staging/r8188eu/include/rtl8188e_spec.h    |   12 +-
 drivers/staging/r8188eu/include/rtl8188e_xmit.h    |    8 -
 drivers/staging/r8188eu/include/rtw_ap.h           |    2 -
 drivers/staging/r8188eu/include/rtw_cmd.h          |    4 +-
 drivers/staging/r8188eu/include/rtw_led.h          |    8 -
 drivers/staging/r8188eu/include/rtw_mlme.h         |   20 +-
 drivers/staging/r8188eu/include/rtw_mlme_ext.h     |    4 -
 drivers/staging/r8188eu/include/rtw_recv.h         |    3 +
 drivers/staging/r8188eu/include/rtw_xmit.h         |   16 +-
 drivers/staging/r8188eu/include/wlan_bssdef.h      |    4 -
 drivers/staging/r8188eu/include/xmit_osdep.h       |   49 -
 drivers/staging/r8188eu/os_dep/ioctl_linux.c       |   16 +-
 drivers/staging/r8188eu/os_dep/mlme_linux.c        |  205 --
 drivers/staging/r8188eu/os_dep/os_intfs.c          |   18 +-
 drivers/staging/r8188eu/os_dep/osdep_service.c     |   11 +-
 drivers/staging/r8188eu/os_dep/recv_linux.c        |  165 --
 drivers/staging/r8188eu/os_dep/usb_intf.c          |   59 +-
 drivers/staging/r8188eu/os_dep/xmit_linux.c        |  237 --
 drivers/staging/rtl8192e/Kconfig                   |   12 +-
 drivers/staging/rtl8192e/rtl8192e/r8190P_rtl8256.c |   12 +-
 drivers/staging/rtl8192e/rtl8192e/r8190P_rtl8256.h |    2 +-
 drivers/staging/rtl8192e/rtl8192e/r8192E_cmdpkt.c  |    5 +-
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c     |  185 +-
 .../staging/rtl8192e/rtl8192e/r8192E_firmware.c    |    7 -
 drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c     |  164 +-
 drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h     |    5 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_cam.c        |   26 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c       |  296 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h       |   14 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c         |  210 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.h         |    6 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_pci.c        |   26 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_pm.c         |    5 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_ps.c         |   68 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_wx.c         |   68 +-
 drivers/staging/rtl8192e/rtl819x_BAProc.c          |    9 +-
 drivers/staging/rtl8192e/rtl819x_HT.h              |   53 +-
 drivers/staging/rtl8192e/rtl819x_HTProc.c          |  128 +-
 drivers/staging/rtl8192e/rtl819x_TSProc.c          |    2 +-
 drivers/staging/rtl8192e/rtllib.h                  |   16 +-
 drivers/staging/rtl8192e/rtllib_debug.h            |    6 -
 drivers/staging/rtl8192e/rtllib_rx.c               |   10 +-
 drivers/staging/rtl8192e/rtllib_softmac.c          |   42 +-
 drivers/staging/rtl8192e/rtllib_softmac_wx.c       |    6 -
 drivers/staging/rtl8192e/rtllib_tx.c               |   26 +-
 drivers/staging/rtl8192u/Makefile                  |    1 +
 drivers/staging/rtl8192u/ieee80211/ieee80211.h     |    2 +-
 drivers/staging/rtl8192u/ieee80211/ieee80211_tx.c  |    6 +-
 drivers/staging/rtl8192u/r8192U.h                  |    9 +
 drivers/staging/rtl8192u/r8192U_core.c             |  226 +-
 drivers/staging/rtl8192u/r8192U_debugfs.c          |  188 ++
 drivers/staging/rtl8712/xmit_linux.c               |   18 +-
 drivers/staging/rtl8712/xmit_osdep.h               |    2 +-
 drivers/staging/rtl8723bs/Makefile                 |    2 -
 drivers/staging/rtl8723bs/core/rtw_cmd.c           |  100 +-
 drivers/staging/rtl8723bs/core/rtw_ieee80211.c     |   17 -
 drivers/staging/rtl8723bs/core/rtw_mlme.c          |    2 +-
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c      |   21 -
 drivers/staging/rtl8723bs/core/rtw_odm.c           |  195 --
 drivers/staging/rtl8723bs/core/rtw_recv.c          |   44 +-
 drivers/staging/rtl8723bs/hal/hal_btcoex.c         |    5 -
 drivers/staging/rtl8723bs/hal/hal_com.c            |  119 -
 drivers/staging/rtl8723bs/hal/hal_intf.c           |    5 -
 drivers/staging/rtl8723bs/hal/odm.h                |    2 -
 drivers/staging/rtl8723bs/hal/odm_DIG.c            |   57 -
 drivers/staging/rtl8723bs/hal/odm_DIG.h            |    2 -
 drivers/staging/rtl8723bs/hal/odm_NoiseMonitor.c   |  130 -
 drivers/staging/rtl8723bs/hal/odm_NoiseMonitor.h   |   39 -
 drivers/staging/rtl8723bs/hal/odm_precomp.h        |    1 -
 drivers/staging/rtl8723bs/include/drv_types.h      |    3 -
 drivers/staging/rtl8723bs/include/hal_btcoex.h     |    1 -
 drivers/staging/rtl8723bs/include/hal_com.h        |    9 -
 drivers/staging/rtl8723bs/include/hal_intf.h       |    2 -
 drivers/staging/rtl8723bs/include/ieee80211.h      |    1 -
 drivers/staging/rtl8723bs/include/rtw_cmd.h        |    3 -
 drivers/staging/rtl8723bs/include/rtw_mlme_ext.h   |    1 -
 drivers/staging/rtl8723bs/include/rtw_odm.h        |   28 -
 drivers/staging/rtl8723bs/include/xmit_osdep.h     |    4 +-
 drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c  |  109 +-
 drivers/staging/rtl8723bs/os_dep/os_intfs.c        |   60 +-
 drivers/staging/rtl8723bs/os_dep/osdep_service.c   |   50 -
 drivers/staging/rtl8723bs/os_dep/xmit_linux.c      |   17 +-
 drivers/staging/sm750fb/sm750.c                    |   12 +-
 drivers/staging/vme_user/vme_tsi148.c              |   70 +-
 drivers/staging/vt6655/baseband.c                  |    2 +-
 drivers/staging/vt6655/card.c                      |   30 +-
 drivers/staging/vt6655/channel.c                   |    4 +-
 drivers/staging/vt6655/device_main.c               |  104 +-
 drivers/staging/vt6655/mac.c                       |  141 +-
 drivers/staging/vt6655/mac.h                       |  124 +-
 drivers/staging/wlan-ng/p80211netdev.h             |    2 -
 152 files changed, 2149 insertions(+), 8160 deletions(-)
 delete mode 100644 drivers/staging/fwserial/Kconfig
 delete mode 100644 drivers/staging/fwserial/Makefile
 delete mode 100644 drivers/staging/fwserial/TODO
 delete mode 100644 drivers/staging/fwserial/dma_fifo.c
 delete mode 100644 drivers/staging/fwserial/dma_fifo.h
 delete mode 100644 drivers/staging/fwserial/fwserial.c
 delete mode 100644 drivers/staging/fwserial/fwserial.h
 delete mode 100644 drivers/staging/r8188eu/hal/odm_RegConfig8188E.c
 delete mode 100644 drivers/staging/r8188eu/hal/rtl8188e_xmit.c
 delete mode 100644 drivers/staging/r8188eu/hal/rtl8188eu_recv.c
 delete mode 100644 drivers/staging/r8188eu/include/ioctl_cfg80211.h
 delete mode 100644 drivers/staging/r8188eu/include/mlme_osdep.h
 delete mode 100644 drivers/staging/r8188eu/include/odm_RegConfig8188E.h
 delete mode 100644 drivers/staging/r8188eu/include/recv_osdep.h
 delete mode 100644 drivers/staging/r8188eu/include/xmit_osdep.h
 delete mode 100644 drivers/staging/r8188eu/os_dep/mlme_linux.c
 delete mode 100644 drivers/staging/r8188eu/os_dep/recv_linux.c
 delete mode 100644 drivers/staging/r8188eu/os_dep/xmit_linux.c
 create mode 100644 drivers/staging/rtl8192u/r8192U_debugfs.c
 delete mode 100644 drivers/staging/rtl8723bs/core/rtw_odm.c
 delete mode 100644 drivers/staging/rtl8723bs/hal/odm_NoiseMonitor.c
 delete mode 100644 drivers/staging/rtl8723bs/hal/odm_NoiseMonitor.h
 delete mode 100644 drivers/staging/rtl8723bs/include/rtw_odm.h
