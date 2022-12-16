Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36B1864E844
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 09:44:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbiLPIoY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 03:44:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbiLPIoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 03:44:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 693F437FAB
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 00:44:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B6172B81D1C
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 08:44:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE716C433EF;
        Fri, 16 Dec 2022 08:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1671180256;
        bh=OfJhBZBAJgXNzymqXWfKReheipdGIlaWFBoYm6JPQKU=;
        h=Date:From:To:Cc:Subject:From;
        b=lY9xaoMW9z/6i9WQ80g2lt6j9QAbBnsfRPhXPPfUsXjEEwHKhQKIVnRVBidiVen6Y
         P+ghK5r8K8WrRYkWUwud1CqveJCLskDgn6rOqE6+Z64ARYY9QHL6jSxnNehc4k9HjT
         jjC8oqJT+Jqmep0ftCqinzIYnVbscIxAR0bfHfMk=
Date:   Fri, 16 Dec 2022 09:44:13 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [GIT PULL] Staging driver changes for 6.2-rc1
Message-ID: <Y5wv3SDxQMwtuKvx@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 9abf2313adc1ca1b6180c508c25f22f9395cc780:

  Linux 6.1-rc1 (2022-10-16 15:36:24 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-6.2-rc1

for you to fetch changes up to 37aa6b98237082a4bf882b4d986329b94ebd447d:

  vme: Use root_device_register() not underlined version (2022-12-08 17:00:18 +0100)

----------------------------------------------------------------
Staging driver changes for 6.2-rc1

Here is the large set of staging driver changes for 6.2-rc1.

Another round of cleanups for staging drivers with no big additions.
Overall more lines were removed than added, always a nice sign, with
nothing happening in here other than general coding style cleanups and
minor fixes in the drivers.  Full, boring, details are in the shortlog.

All of these have been in linux-next for a while with no reported
problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Aaron Lawrence (16):
      Staging: rtl8192e: rtl819x_HTProc: fixed missing blank space
      Staging: rtl8192e: rtl819x_HTProc: fixed alignment matching open parenthesis
      Staging: rtl8192e: rtl819x_HTProc: fixed unnecessary parentheses
      Staging: rtl8192e: rtllib_tx: fixed multiple blank lines
      Staging: rtl8192e: rtllib_tx: fixed alignment matching open parenthesis
      Staging: rtl8192e: rtllib_tx: added spaces around operators
      Staging: rtl8192e: rtllib_tx: fixed lines ending with an open parenthesis
      Staging: rtl8192e: rtllib_tx: removed unnecessary blank line before a close brace
      staging: rtl8192e: rtllib_crypt_wep: multiple blank lines removal
      staging: rtl8192e: rtllib_module: remove unnecessary parentheses
      staging: rtl8192e: rtllib_crypt_tkip: multiple blank lines removal
      staging: rtl8192e: rtllib_crypt_tkip: blank line before close brace removal
      staging: rtl8192e: rtllib_crypt_tkip: fixed alignment matching open parentheses
      staging: rtl8192e: rtllib_crypt_tkip: fixes on unbalanced braces
      staging: rtl8192e: rtllib_crypt_tkip: split multiple assignments
      staging: rtl8192e: rtllib_crypt_tkip: rewritten comparison to NULL

Anjandev Momi (4):
      Staging: rtl8192e: remove unnecessary parentheses
      Staging: rtl8192e: remove multiple blank lines
      Staging: rtl8192e: make alignment match open parenthesis
      Staging: rtl8192e: add blank line after function declaration

Brent Pappas (1):
      staging: gdm724x: Replace macro GDM_TTY_READY with static inline function

Chen Zhongjin (2):
      vme: Fix error not catched in fake_init()
      vme: Use root_device_register() not underlined version

Colin Ian King (7):
      staging: rtl8192u: Fix spelling mistake athros -> Atheros and fix grammer
      staging: rtl8723bs: Remove redundant initialization of variable efuseValue
      staging: sm750fb: Kconfig: Fix spelling mistake "accelearion" -> "acceleration"
      staging: octeon: remove redundant variable total_freed
      staging: rtl8712: Remove variable xcnt
      staging: rtl8192e: rtl819x_HTProc: make arrays const and one static
      staging: rtl8192e: Fix spelling mistake "ContryIE" -> "CountryIE"

Dan Carpenter (1):
      staging: rtl8192u: Fix use after free in ieee80211_rx()

Danijel Korent (1):
      staging: rtl8192e: Added spaces around operators in rtl_cam.c/rtl_eeprom.c

Deepak R Varma (32):
      staging: iio: frequency: ad9834: merge unnecessary split lines
      staging: most: dim2: correct misleading struct type name
      staging: r8188eu: use Linux kernel variable naming convention
      staging: r8188eu: reformat long computation lines
      staging: r8188eu: remove {} for single statement blocks
      staging: r8188eu: use htons macro instead of __constant_htons
      staging: r8188eu: correct misspelled words in comments
      staging: r8188eu: Add space between function & macro parameters
      staging: r8188eu: Associate pointer symbol with parameter name
      staging: r8188eu: replace leading spaces by tabs
      staging: r8188eu: Put '{" on the symbol declaration line
      staging: r8188eu: Correct missing or extra space in the statements
      staging: r8188eu: Remove unused macros
      staging: wlan-ng: remove commented debug printk messages
      staging: rtl8192u: remove unnecessary function implementation
      staging: wlan-ng: Remove unused struct wlan_ie_ssid references
      staging: wlan-ng: Remove unused struct wlan_ie_supp_rates references
      staging: wlan-ng: Remove unused struct wlan_ie_tim references
      staging: wlan-ng: Remove unused struct wlan_ie_ibss_parms references
      staging: wlan-ng: Remove unused struct p80211macarray definition
      staging: wlan-ng: Remove unused function declarations
      staging: wlan-ng: Remove unused structure definitions
      staging: rtl8192e: Use min_t/max_t macros for variable comparison
      staging: rtl8723bs: Use min/max macros for variable comparison
      staging: r8188eu: remove unused ijk_matrix_regs_set implementation
      staging: rtl8723bs: replace underutilized struct by array variable
      staging: emxx_udc: use min helper macro for variable comparison
      staging: r8188eu: remove unused struct declarations
      staging: r8188eu: simplify complex pointer casting
      staging: r8188eu: remove unnecessary casting
      staging: fieldbus: use sysfs_emit() in show functions
      staging: rtl8192u: remove redundant macro definitions

Dragan Cvetic (3):
      staging: rtl8192e: Remove single statement braces
      staging: rtl8192e: Rename CurSTAConnectState and PreSTAConnectState
      staging: rtl8192e: Rename Op, Length and Value

Duoming Zhou (1):
      drivers: staging: r8188eu: Fix sleep-in-atomic-context bug in rtw_join_timeout_handler

Emily Peri (8):
      staging: rtl8723bs: Removed extra tabs in conditional statements
      staging: rtl8723bs: align block comment stars
      staging: rtl8723bs: remove unnecessary parenthesis
      staging: rtl8723bs: remove tab in variable definition
      staging: rtl8723bs: add newline after variable declaration
      staging: rtl8723bs: use tab instead of spaces for indent
      staging: rtl8723bs: Fix indentation in conditional statements
      staging: rtl8723bs: replace ternary statement with min_t macro

Gabhyun Kim (1):
      staging: rtl8192e: Remove line breaks to match coding style

Gaosheng Cui (1):
      staging: vme_user: Fix possible UAF in tsi148_dma_list_add

Geert Uytterhoeven (1):
      staging: octeon: cvmx_ptr_to_phys() should return physaddr_t

Gustavo A. R. Silva (1):
      staging: ks7010: Avoid clashing function prototypes

Jack Schofield (3):
      staging: greybus: loopback_test: Add blank line after declaration.
      staging: greybus: loopback_test: Remove void function return statement
      staging: greybus: loopback_test: Remove extra blank lines

Kang Minchul (4):
      staging: r8188eu: remove unnecessary variable in ioctl_linux
      staging: r8188eu: remove unnecessary vaiable in rtw_recv
      staging: r8188eu: remove unnecessary variable in rtl8188eu_xmit
      staging: r8188eu: make rtw_sta_flush to void

Larry Finger (1):
      staging: rtl8192e: Fix divide fault when calculating beacon age

Martin Kaiser (97):
      staging: r8188eu: remove bLedLinkBlinkInProgress
      staging: r8188eu: replace one GetAddr3Ptr call
      staging: r8188eu: get reason code from mgmt struct
      staging: r8188eu: clarify the bBusyTraffic assignment
      staging: r8188eu: use sa instead of Addr2
      staging: r8188eu: get bssid from mgmt struct
      staging: r8188eu: exit for deauth from unknown station
      staging: r8188eu: remove unnecessary return
      staging: r8188eu: summarize two flags checks
      staging: r8188eu: ignore_received_deauth is a boolean
      staging: r8188eu: fix led register settings
      staging: r8188eu: handle rtw_write8 errors in SwLedOn
      staging: r8188eu: fix status updates in SwLedOff
      staging: r8188eu: SwLedOn needs no padapter parameter
      staging: r8188eu: SwLedOff needs no padapter parameter
      staging: r8188eu: remove two unused defines
      staging: r8188eu: don't include rtw_led.h from rtw_cmd.h
      staging: r8188eu: remove padapter from struct led_priv
      staging: r8188eu: set two more state variables
      staging: r8188eu: summarize tx/rx and scan blinking
      staging: r8188eu: restructure mlme subfunction handling
      staging: r8188eu: make OnAssocReq static
      staging: r8188eu: make OnAssocRsp static
      staging: r8188eu: make OnProbeReq static
      staging: r8188eu: make OnProbeRsp static
      staging: r8188eu: make OnBeacon static
      staging: r8188eu: make OnDisassoc static
      staging: r8188eu: make OnAuthClient static
      staging: r8188eu: make OnDeAuth static
      staging: r8188eu: make OnAction static
      staging: r8188eu: make OnAuth static
      staging: r8188eu: change mlme handlers to void
      staging: r8188eu: remove unnecessary label
      staging: r8188eu: remove unnecessary else branch
      staging: r8188eu: remove unnecessary return
      staging: r8188eu: remove an else branch
      staging: r8188eu: go2asoc is not needed
      staging: r8188eu: use standard multicast addr check
      staging: r8188eu: don't set pcmd_obj components to 0
      staging: r8188eu: NetworkTypeInUse is not in use
      staging: r8188eu: remove wait_ack param from _issue_probereq_p2p
      staging: r8188eu: bCardDisableWOHSM is write-only
      staging: r8188eu: replace get_da with ieee80211_get_DA
      staging: r8188eu: remove get_da
      staging: r8188eu: replace a GetAddr1Ptr call
      staging: r8188eu: remove duplicate category check
      staging: r8188eu: make on_action_public static void
      staging: r8188eu: make OnAction_back static void
      staging: r8188eu: make OnAction_p2p static void
      staging: r8188eu: remove category check in OnAction_p2p
      staging: r8188eu: replace switch-case with if
      staging: r8188eu: replace GetAddr1Ptr call in OnAction_p2p
      staging: r8188eu: clean up on_action_public
      staging: r8188eu: remove return value from on_action_public_vendor
      staging: r8188eu: remove return value from on_action_public_default
      staging: r8188eu: rtw_action_public_decache's token is a u8
      staging: r8188eu: check destination address in OnAction
      staging: r8188eu: use ether_addr_equal for address comparison
      staging: r8188eu: use hdr->frame_control instead of fc
      staging: r8188eu: use ieee80211_get_SA
      staging: r8188eu: use ether_addr_equal in OnAction
      staging: r8188eu: don't store addba request
      staging: r8188eu: remove some obsolete comments
      staging: r8188eu: reorder assignments, clarify the header format
      staging: r8188eu: reformat a function header
      staging: r8188eu: remove state checks in rtw_led_control
      staging: r8188eu: clean up rtw_hal_init
      staging: r8188eu: remove get_fwstate
      staging: r8188eu: merge two rtw_free_network_nolock functions
      staging: r8188eu: remove checks in dump_mgntframe
      staging: r8188eu: use a qos_hdr in validate_recv_data_frame
      staging: r8188eu: drop another removal/stop check
      staging: r8188eu: drop removal/stop check in dump_mgntframe_and_wait_ack
      staging: r8188eu: drop return value from issue_probereq_ex
      staging: r8188eu: remove wait_ms parameter
      staging: r8188eu: fix the number of probereq retries
      staging: r8188eu: simplify the checks for zero address
      staging: r8188eu: use ieee80211 helper for protected bit
      staging: r8188eu: replace one GetAddr3Ptr call
      staging: r8188eu: read timestamp from ieee80211_mgmt
      staging: r8188eu: replace GetAddr2Ptr calls
      staging: r8188eu: pass only ies to process_p2p_ps_ie
      staging: r8188eu: use ie buffer in update_beacon_info
      staging: r8188eu: simplify update_sta_support_rate params
      staging: r8188eu: exit if beacon is not from our bss
      staging: r8188eu: stop beacon processing if kmalloc fails
      staging: r8188eu: simplify error handling for missing station
      staging: r8188eu: remove a variable
      staging: r8188eu: use ieee80211_mgmt to parse addresses
      staging: r8188eu: read reason code from ieee80211_mgmt
      staging: r8188eu: move bBusyTraffic update
      staging: r8188eu: handle the non-ap case first
      staging: r8188eu: simplify err handling for unknown station
      staging: r8188eu: merge two probereq_p2p functions
      staging: r8188eu: remove unused da parameter
      staging: r8188eu: use subtype helpers in collect_bss_info
      staging: r8188eu: use subtype helper in rtw_check_bcn_info

Matt Jan (1):
      staging: vme_user: remove multiple blank lines

Michael Straube (19):
      staging: r8188eu: merge odm_types.h into other headers
      staging: r8188eu: convert rtw_init_evt_priv() to common error logic
      staging: r8188eu: convert rtw_init_cmd_priv() to common error logic
      staging: r8188eu: convert rtw_init_mlme_priv() to common error logic
      staging: r8188eu: convert _rtw_init_sta_priv() to common error logic
      staging: r8188eu: convert rtw_reset_drv_sw() to void
      staging: r8188eu: convert rtw_free_drv_sw() to void
      staging: r8188eu: remove unused macros from wifi.h
      staging: r8188eu: use min() instead of ternary operator
      staging: r8188eu: replace ternary operator with min, max, abs macros
      staging: r8188eu: remove extern from function prototypes
      staging: r8188eu: convert rtw_free_stainfo() to void
      staging: r8188eu: convert three functions to bool
      staging: r8188eu: clean up error handling in rtw_start_drv_threads()
      staging: r8188eu: rename three functions
      staging: r8188eu: convert aes_cipher() to void
      staging: r8188eu: convert rtw_xmit_resource_alloc() to common error logic
      staging: r8188eu: convert _rtw_init_xmit_priv() to common error logic
      staging: r8188eu: binstallGrpkey is set to _FAIL

Nam Cao (4):
      Revert "staging: r8712u: Tracking kmemleak false positives."
      staging: rtl8712: check for alloc fail in _r8712_init_recv_priv()
      staging: rtl8712: check for return value of _r8712_init_xmit_priv()
      staging: rtl8712: fix potential memory leak

Peter Robinson (4):
      staging: rtl8192u: Provide a TODO file for this driver
      staging: rtl8192e: Update the TODO file for this driver
      staging: ks7010: Update the TODO file for this driver
      staging: wlan-ng: Provide a TODO file for this driver

Philipp Hortmann (25):
      staging: rtl8192e: Remove unchanged variable bFwCtrlLPS
      staging: rtl8192e: Remove unchanged variable bInactivePs
      staging: rtl8192e: Remove unused variable bIPSModeBackup
      staging: rtl8192e: Remove unused variable bInPowerSaveMode
      staging: rtl8192e: Remove unused variable isRFOff
      staging: rtl8192e: Remove unchanged variable RegRfOff
      staging: rtl8192e: Remove unchanged variable bDisableNormalResetCheck
      staging: rtl8192e: Remove unused variable bForcedSilentReset
      staging: rtl8192e: Remove unused variable ScanDelay
      staging: rtl8192e: Remove unused variable bDriverIsGoingToUnload
      staging: rtl8192e: Rename bTxDisableRate.., RegMaxLPSAwa.. and bTxUseD..
      staging: rtl8192e: Rename Regdot11HTOper.., bSupportM.. and PowerSaveCo..
      staging: rtl8192e: Rename Regdot11TxHT.., dot11HTOpera.. and RegHTSuppRa..
      staging: rtl8192e: Rename pPSC
      staging: rtl8192e: Rename RFInProgres.., bEnableHT and RegChannelPlan
      staging: rtl8192e: Rename LinkDetectInfo
      staging: rtl8192e: Rename bNetPromisc.., IntelPromiscu.. and bPromiscu..
      staging: rtl8192e: Rename bFilterSour.., CCKPresentAt.. and ResetProg..
      staging: rtl8192e: Rename InterruptLog, RxCounter and bHwRfOffAction
      staging: rtl8192e: Rename pHTInfo
      staging: rtl8192e: Remove unchanged variable AcmMethod
      staging: rtl8192e: Remove unused variable skb_aggQ
      staging: rtl8192e: Remove unused variable initialized_at_probe
      staging: rtl8192e: Remove unused variable ChannelAccessSetting
      staging: rtl8192e: Remove unused variable int_log

Phillip Potter (2):
      staging: r8188eu: convert rtw_setdatarate_cmd to correct error semantics
      staging: r8188eu: change return type of rtw_set_802_11_disassociate to void

Rigel Di Scala (1):
      Staging: rtl8192e: fix a brace style issue

Rui Li (1):
      staging: rtl8192e: remove unnecessary braces for single statement blocks

Tanjuate Brunostar (3):
      staging: rts5208: split long line of code
      staging: vt6655: change variable name wTimeStampOff
      staging: vt6655: change 2 variable names wFB_Opt0 and wFB_Opt1

Umang Jain (3):
      Revert "staging: mmal-vchiq: Avoid use of bool in structures"
      vc04_services: mmal-vchiq: Use bool for vchiq_mmal_component.in_use
      vc04_services: bcm2835-camera: Use bool values for mmal_fmt.remove_padding

Uwe Kleine-König (3):
      staging: most: i2c: Convert to i2c's .probe_new()
      staging: olpc_dcon: Convert to i2c's .probe_new()
      staging: iio: ade7854: Convert to i2c's .probe_new()

Yogesh Hegde (1):
      staging: rtl8192e: Rename variables rateIndex and rateBitmap to avoid CamelCase

YueHaibing (1):
      staging: rtl8192e: Fix potential use-after-free in rtllib_rx_Monitor()

 arch/mips/include/asm/octeon/cvmx.h                |   4 +-
 drivers/staging/emxx_udc/emxx_udc.c                |   5 +-
 drivers/staging/fieldbus/dev_core.c                |  17 +-
 drivers/staging/gdm724x/gdm_tty.c                  |  13 +-
 drivers/staging/greybus/tools/loopback_test.c      |  15 +-
 drivers/staging/iio/frequency/ad9834.c             |   6 +-
 drivers/staging/iio/meter/ade7854-i2c.c            |   5 +-
 drivers/staging/ks7010/TODO                        |   3 +
 drivers/staging/ks7010/ks_wlan_net.c               | 248 +++----
 drivers/staging/most/dim2/dim2.c                   |   4 +-
 drivers/staging/most/dim2/hal.c                    |   4 +-
 drivers/staging/most/dim2/hal.h                    |   6 +-
 drivers/staging/most/i2c/i2c.c                     |   4 +-
 drivers/staging/octeon/ethernet-tx.c               |   2 -
 drivers/staging/octeon/octeon-stubs.h              |   2 +-
 drivers/staging/olpc_dcon/olpc_dcon.c              |   4 +-
 drivers/staging/r8188eu/core/rtw_ap.c              |   7 +-
 drivers/staging/r8188eu/core/rtw_br_ext.c          | 126 ++--
 drivers/staging/r8188eu/core/rtw_cmd.c             |  34 +-
 drivers/staging/r8188eu/core/rtw_ioctl_set.c       |   6 +-
 drivers/staging/r8188eu/core/rtw_led.c             |  79 +--
 drivers/staging/r8188eu/core/rtw_mlme.c            |  51 +-
 drivers/staging/r8188eu/core/rtw_mlme_ext.c        | 747 ++++++++-------------
 drivers/staging/r8188eu/core/rtw_p2p.c             |  19 +-
 drivers/staging/r8188eu/core/rtw_pwrctrl.c         |   2 +-
 drivers/staging/r8188eu/core/rtw_recv.c            |  27 +-
 drivers/staging/r8188eu/core/rtw_security.c        |   4 +-
 drivers/staging/r8188eu/core/rtw_sta_mgt.c         |  16 +-
 drivers/staging/r8188eu/core/rtw_wlan_util.c       |  36 +-
 drivers/staging/r8188eu/core/rtw_xmit.c            |  54 +-
 drivers/staging/r8188eu/hal/HalPhyRf_8188e.c       |  12 +-
 drivers/staging/r8188eu/hal/hal_intf.c             |  19 +-
 drivers/staging/r8188eu/hal/odm_RTL8188E.c         |   6 +-
 drivers/staging/r8188eu/hal/rtl8188e_hal_init.c    |   8 +-
 drivers/staging/r8188eu/hal/rtl8188e_phycfg.c      |  16 +-
 drivers/staging/r8188eu/hal/rtl8188e_rxdesc.c      |  28 +-
 drivers/staging/r8188eu/hal/rtl8188eu_xmit.c       |   3 +-
 drivers/staging/r8188eu/include/Hal8188EPhyReg.h   |   4 +-
 drivers/staging/r8188eu/include/drv_types.h        |   1 -
 drivers/staging/r8188eu/include/odm.h              |  10 +-
 drivers/staging/r8188eu/include/odm_RTL8188E.h     |   7 +
 drivers/staging/r8188eu/include/odm_types.h        |  16 -
 drivers/staging/r8188eu/include/osdep_intf.h       |   6 +-
 drivers/staging/r8188eu/include/osdep_service.h    |   6 +-
 drivers/staging/r8188eu/include/rtl8188e_hal.h     |   7 +-
 drivers/staging/r8188eu/include/rtl8188e_spec.h    |  18 +-
 drivers/staging/r8188eu/include/rtw_ap.h           |   2 +-
 drivers/staging/r8188eu/include/rtw_cmd.h          |  71 +-
 drivers/staging/r8188eu/include/rtw_io.h           |  16 +-
 drivers/staging/r8188eu/include/rtw_ioctl_set.h    |   6 +-
 drivers/staging/r8188eu/include/rtw_led.h          |   3 -
 drivers/staging/r8188eu/include/rtw_mlme.h         |  29 +-
 drivers/staging/r8188eu/include/rtw_mlme_ext.h     |  58 +-
 drivers/staging/r8188eu/include/rtw_recv.h         |   4 +-
 drivers/staging/r8188eu/include/rtw_xmit.h         |   4 +-
 drivers/staging/r8188eu/include/sta_info.h         |  18 +-
 drivers/staging/r8188eu/include/wifi.h             |  77 +--
 drivers/staging/r8188eu/include/wlan_bssdef.h      |  51 --
 drivers/staging/r8188eu/os_dep/ioctl_linux.c       |  28 +-
 drivers/staging/r8188eu/os_dep/os_intfs.c          |  41 +-
 drivers/staging/rtl8192e/TODO                      |  18 +-
 drivers/staging/rtl8192e/rtl8192e/r8190P_def.h     |  15 -
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c     |  55 +-
 drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c     |  50 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_cam.c        |  43 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c       | 191 +++---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h       |  36 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c         | 123 ++--
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.h         |  10 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_eeprom.c     |   2 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_ps.c         |  95 ++-
 drivers/staging/rtl8192e/rtl8192e/rtl_wx.c         |  94 ++-
 drivers/staging/rtl8192e/rtl819x_BAProc.c          |  38 +-
 drivers/staging/rtl8192e/rtl819x_HT.h              |   2 +-
 drivers/staging/rtl8192e/rtl819x_HTProc.c          | 405 ++++++-----
 drivers/staging/rtl8192e/rtl819x_Qos.h             |   7 -
 drivers/staging/rtl8192e/rtl819x_TSProc.c          |   2 +-
 drivers/staging/rtl8192e/rtllib.h                  |  51 +-
 drivers/staging/rtl8192e/rtllib_crypt_tkip.c       |  52 +-
 drivers/staging/rtl8192e/rtllib_crypt_wep.c        |   8 -
 drivers/staging/rtl8192e/rtllib_module.c           |   8 +-
 drivers/staging/rtl8192e/rtllib_rx.c               |  38 +-
 drivers/staging/rtl8192e/rtllib_softmac.c          | 173 +++--
 drivers/staging/rtl8192e/rtllib_softmac_wx.c       |  19 +-
 drivers/staging/rtl8192e/rtllib_tx.c               | 120 ++--
 drivers/staging/rtl8192e/rtllib_wx.c               |   6 +-
 drivers/staging/rtl8192u/TODO                      |  16 +
 drivers/staging/rtl8192u/ieee80211/ieee80211.h     |  64 --
 .../rtl8192u/ieee80211/ieee80211_crypt_tkip.c      |   6 -
 .../staging/rtl8192u/ieee80211/ieee80211_module.c  |   3 -
 drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c  |   6 +-
 drivers/staging/rtl8712/os_intfs.c                 |  27 +-
 drivers/staging/rtl8712/recv_osdep.h               |   8 +-
 drivers/staging/rtl8712/rtl8712_recv.c             |   7 +-
 drivers/staging/rtl8712/rtl8712_xmit.c             |   3 +-
 drivers/staging/rtl8712/rtl871x_recv.c             |  16 +-
 drivers/staging/rtl8723bs/core/rtw_efuse.c         |   2 +-
 drivers/staging/rtl8723bs/core/rtw_ieee80211.c     |  12 +-
 drivers/staging/rtl8723bs/core/rtw_ioctl_set.c     |  17 +-
 drivers/staging/rtl8723bs/core/rtw_mlme.c          |  30 +-
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c      |   2 +-
 drivers/staging/rtl8723bs/core/rtw_recv.c          |   6 +-
 drivers/staging/rtl8723bs/core/rtw_sta_mgt.c       |   2 +-
 drivers/staging/rtl8723bs/core/rtw_wlan_util.c     |  12 +-
 drivers/staging/rtl8723bs/hal/HalPhyRf_8723B.c     |  21 +-
 drivers/staging/rtl8723bs/hal/odm.h                |  12 +-
 drivers/staging/rtl8723bs/hal/odm_DIG.c            |   5 +-
 drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c  |   2 +-
 drivers/staging/rts5208/sd.c                       |   3 +-
 drivers/staging/sm750fb/Kconfig                    |   2 +-
 .../vc04_services/bcm2835-camera/bcm2835-camera.c  |  30 +-
 .../staging/vc04_services/vchiq-mmal/mmal-vchiq.c  |  18 +-
 .../staging/vc04_services/vchiq-mmal/mmal-vchiq.h  |   6 +-
 drivers/staging/vme_user/vme.h                     |   2 -
 drivers/staging/vme_user/vme_fake.c                |   9 +-
 drivers/staging/vme_user/vme_tsi148.c              |   7 +-
 drivers/staging/vme_user/vme_tsi148.h              |   7 -
 drivers/staging/vt6655/rxtx.c                      |  36 +-
 drivers/staging/wlan-ng/TODO                       |  16 +
 drivers/staging/wlan-ng/p80211mgmt.h               | 301 ---------
 drivers/staging/wlan-ng/p80211netdev.c             |  22 -
 drivers/staging/wlan-ng/p80211types.h              |   6 -
 122 files changed, 1741 insertions(+), 2789 deletions(-)
 delete mode 100644 drivers/staging/r8188eu/include/odm_types.h
 create mode 100644 drivers/staging/rtl8192u/TODO
 create mode 100644 drivers/staging/wlan-ng/TODO
