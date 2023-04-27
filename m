Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC7F6F072D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 16:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244048AbjD0OVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 10:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243970AbjD0OVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 10:21:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DDDA5253
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 07:20:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 477E363D9E
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 14:20:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58104C433D2;
        Thu, 27 Apr 2023 14:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1682605228;
        bh=CAAG87EaQbca9EA2QnGZBptbuDrJ6v+58LnEvWeTyP4=;
        h=Date:From:To:Cc:Subject:From;
        b=iLroRjjA/EMYhMPs03k3Hg3lgcxU6zark3XGax2OXYJaVJW66izuHyAFoiBFpRCFy
         2d9XCETFTX27G3QjrmxKZ7V2CUmRt7grXE+7Cmr07MDTcMG3h+ZfFYe4vFmgYJghil
         3ywlyWrbxnAYx69mQV+SuqDn3qThiyOvFjq9vtJA=
Date:   Thu, 27 Apr 2023 16:20:26 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [GIT PULL] Staging driver updates for 6.4-rc1
Message-ID: <ZEqEqsEJZZEQSzLl@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit eeac8ede17557680855031c6f305ece2378af326:

  Linux 6.3-rc2 (2023-03-12 16:36:44 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-6.4-rc1

for you to fetch changes up to 3fac2397f562eb669ddc2f45867a253f3fc26184:

  staging: rtl8192e: Fix W_DISABLE# does not work after stop/start (2023-04-20 13:55:20 +0200)

----------------------------------------------------------------
Staging driver changes for 6.4-rc1

Here is the large set of staging driver updates for 6.4-rc1.  Once
again, we removed more code than was added, a nice trend.

It was a calm cycle, mostly all just small coding style cleanups,
included in here are:
  - removal of the greybus loopback testing tools, userspace code that
    didn't belong in a driver subdirectory and was causing problems for
    some build systems
  - platform remove callback cleanups
  - rtl8192e huge cleanups
  - other small staging driver cleanups.

All of these have been in linux-next for a while with no reported
problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Abhirup Deb (1):
      staging: vme_user: Replace "<<" with BIT macro

Archana (2):
      staging: wlan-ng: small cleanup in writeimage()
      staging: wlan-ng: small cleanup in plugimage()

Daniel Watson (2):
      staging: rtl8723bs: conform if's braces to kernel style
      staging: rtl8723bs: indent with tab, align with space

Greg Kroah-Hartman (2):
      Merge 6.3-rc2 into staging-next
      staging: greybus: drop loopback test files

Hans de Goede (4):
      drivers: staging: rtl8723bs: Fix locking in _rtw_join_timeout_handler()
      drivers: staging: rtl8723bs: Fix locking in rtw_scan_timeout_handler()
      drivers: staging: rtl8723bs: Remove unused clr_fwstate() function
      drivers: staging: rtl8723bs: Remove pmlmepriv->num_of_scanned

Khadija Kamran (20):
      staging: axis-fifo: initialize timeouts in init only
      staging: greybus: fix line ending with '('
      staging: most: remove extra blank line
      staging: most: fix line ending with '(' in video/
      staging: most: fix line ending with '(' in dim2/
      staging: ks7010: fix line ending with '('
      staging: rtl8192e: remove extra blank lines
      staging: rtl8192e: add blank lines after declarations
      staging: rtl8192e: add spaces around binary operators
      staging: rtl8192e: remove blank lines after '{'
      staging: rtl8192u: remove change history from comments
      staging: rtl8192u: remove commented out code
      staging: rtl8192u: add '*' on subsequent lines in block comment
      staging: rtl8192u: add '*/' on separate line in block comments
      staging: rtl8192e: fix unbalanced braces around else
      staging: rtl8192e: remove extra blank lines in rtllib_crypt_ccmp.c
      staging: rtl8192e: fix alignment to match open parenthesis
      staging: rtl8192e: avoid CamelCase <dot11RSNAStatsCCMPFormatErrors>
      staging: rtl8192e: avoid CamelCase <dot11RSNAStatsCCMPReplays>
      staging: rtl8192e: avoid CamelCase <dot11RSNAStatsCCMPDecryptErrors>

Lukas Bulwahn (1):
      staging: vme: clean up duplicate definitions of dependencies

Menna Mahmoud (6):
      staging: vme_user: add space around operators
      staging: vme_user: remove unnecessary blank lines
      staging: most: use inline functions for to_hdm
      staging: most: define iface_to_hdm as an inline function
      staging: rtl8723bs: use inline functions for dvobj_to_dev
      staging: greybus: remove unnecessary blank line

Michael Straube (16):
      staging: rtl8192e: rtl92e_clear_irq() is not used
      staging: rtl8723bs: MapCharToHexDigit() is not used
      staging: rtl8723bs: ParseQualifiedString() is not used
      staging: rtl8723bs: isAllSpaceOrTab() is not used
      staging: rtl8723bs: linked_info_dump() is not used
      staging: rtl8723bs: rtw_get_raw_rssi_info() is not used
      staging: rtl8192u: rtl8192_SetRFPowerState() is not used
      staging: rtl8192u: dm_shadow_init() is not used
      staging: vt6656: remove unused vnt_get_current_tsf() function
      staging: vt6655: remove unused bb_power_save_mode_on() function
      staging: vt6655: remove unused bb_power_save_mode_off() function
      staging: rtl8723bs: remove hal_btcoex_SetChipType()
      staging: rtl8192e: remove RTL819X_DEFAULT_RF_TYPE
      staging: rtl8192e: remove redundant setting of rf_type
      staging: rtl8192e: priv->rf_type is always RF_1T2R
      staging: rtl8192e: remove rf_type from struct r8192_priv

Nuno Sá (1):
      staging: iio: resolver: ads1210: fix config mode

Philipp Hortmann (101):
      staging: rtl8192e: Remove entry .get_eeprom_size from struct rtl819x_ops
      staging: rtl8192e: Remove entry .init_adapter_.. from struct rtl819x_ops
      staging: rtl8192e: Remove entry .initialize_ad.. from struct rtl819x_ops
      staging: rtl8192e: Remove entry .tx_fill_descr.. from struct rtl819x_ops
      staging: rtl8192e: Remove entry .tx_fill_cmd_d.. from struct rtl819x_ops
      staging: rtl8192e: Remove entry .rx_query_stat.. from struct rtl819x_ops
      staging: rtl8192e: Remove entry .stop_adapter from struct rtl819x_ops
      staging: rtl8192e: Remove entry .update_ratr_t.. from struct rtl819x_ops
      staging: rtl8192e: Remove entry .irq_enable from struct rtl819x_ops
      staging: rtl8192e: Remove entry .irq_disable from struct rtl819x_ops
      staging: rtl8192e: Remove entry .rx_enable from struct rtl819x_ops
      staging: rtl8192e: Remove entry .tx_enable from struct rtl819x_ops
      staging: rtl8192e: Remove entry .interrupt_re.. from struct rtl819x_ops
      staging: rtl8192e: Remove entry .tx_check_stuc.. from struct rtl819x_ops
      staging: rtl8192e: Remove entry .rx_check_stuc.. from struct rtl819x_ops
      staging: rtl8192e: Remove dead code from struct rtl819x_ops
      staging: rtl8192e: Remove entry .link_change from struct rtl819x_ops
      staging: rtl8192e: Remove entry .nic_type from struct rtl819x_ops
      staging: rtl8192e: Replace macro RTL_PCI_DEVICE with PCI_DEVICE
      staging: rtl8192e: Remove empty struct rtl819x_ops
      staging: rtl8192e: Remove checks of pointer to handle_a.. and handle_b..
      staging: rtl8192e: Remove checks of pointer to LeisureP.. and start_se..
      staging: rtl8192e: Remove checks of pointer to stop_send.. and rtllib_..
      staging: rtl8192e: Remove checks of pointer to rtllib.. and ScanOpera..
      staging: rtl8192e: Change filename r8192E_hwimg.x to table.x
      staging: rtl8192e: Remove empty Array Rtl8192PciEPHY_REGArray
      staging: rtl8192e: Remove conditions for RF_2T4R
      staging: rtl8192e: Remove unused Array Rtl8192PciERadioC_Array
      staging: rtl8192e: Remove unused Array Rtl8192PciERadioD_Array
      staging: rtl8192e: Remove unused RF90_PATH_C and ..D in rtl92e_config_rf
      staging: rtl8192e: Remove unused RF90_PATH_C and ..D for rfintfs
      staging: rtl8192e: Remove unused variable rfintfi
      staging: rtl8192e: Remove unused RF90_PATH_C and ..D for rfintfo and ..fe
      staging: rtl8192e: Remove unused RF90_PATH_C and ..D for rf3wireOffset
      staging: rtl8192e: Remove unused variable rfLSSI_Select and rfTxGainStage
      staging: rtl8192e: Remove unused variable rfHSSIPara1 and rfSwitchControl
      staging: rtl8192e: Remove unused variable rfAGCControl1 and rfAGCControl2
      staging: rtl8192e: Remove unused variable rfRxIQImbalance and rfRxAFE
      staging: rtl8192e: Remove unused variable rfTxIQImbalance and rfTxAFE
      staging: rtl8192e: Remove unused RF90_PATH_C and ..D for rfLSSIReadBack
      staging: rtl8192e: Remove unused RF90_PATH_C and ..D for rfHSSIPara2
      staging: rtl8192e: Replace RF90_PATH_C in test expression of for loop
      staging: rtl8192e: Remove function rtl92e_is_legal_rf_path
      staging: rtl8192e: Join constants AGCTAB_ArrayLength with ..LengthPciE
      staging: rtl8192e: Join constants MACPHY_ArrayLength with ..LengthPciE
      staging: rtl8192e: Join constants RadioA_ArrayLength with ..LengthPciE
      staging: rtl8192e: Join constants RadioB_ArrayLength with ..LengthPciE
      staging: rtl8192e: Join constants MACPHY_Array_PGLength with ..LengthPciE
      staging: rtl8192e: Join constants PHY_REG_1T2RArray.. with ..LengthPciE
      staging: rtl8192e: Join constants Rtl819XMACPHY_..PG with Rtl8192PciE..
      staging: rtl8192e: Join constants Rtl819XMACPHY_.. with Rtl8192PciE..
      staging: rtl8192e: Join constants Rtl819XRadioA_.. with ..RadioA_..
      staging: rtl8192e: Join constants Rtl819XRadioB_.. with ..RadioB_..
      staging: rtl8192e: Join constants Rtl819XAGCTAB_.. with ..PciEAGCTAB..
      staging: rtl8192e: Join constants Rtl819XPHY_REG_.. with ..PciEPHY_REG_..
      staging: rtl8192e: Remove unused variable rtl819XAGCTAB_Array
      staging: rtl8192e: Remove double defined constants bMaskBytex and more
      staging: rtl8192e: Replace macro skb_tail_pointer_rsl with standard function
      staging: rtl8192e: Remove unused macro queue_delayed_work_rsl and more
      staging: rtl8192e: Replace macro INIT_DELAYED_WORK_RSL with standard macro
      staging: rtl8192e: Replace macro INIT_WORK_RSL with standard macro
      staging: rtl8192e: Replace macro container_of_work_rsl with standard macro
      staging: rtl8192e: Replace macro iwe_stream_add_event_rsl with standard function
      staging: rtl8192e: Replace macro iwe_stream_add_point_rsl with standard function
      staging: rtl8192e: Remove priv->rf_chip in _rtl92e_phy_rf_read
      staging: rtl8192e: Remove priv->rf_chip in _rtl92e_phy_rf_write
      staging: rtl8192e: Remove priv->rf_chip in rtl92e_set_tx_power
      staging: rtl8192e: Remove priv->rf_chip in rtl92e_config_phy
      staging: rtl8192e: Remove priv->rf_chip in _rtl92e_set_tx_power_level
      staging: rtl8192e: Remove priv->rf_chip in _rtl92e_phy_switch_channel_step
      staging: rtl8192e: Remove priv->rf_chip in _rtl92e_set_bw_mode_work_item
      staging: rtl8192e: Remove priv->rf_chip in _rtl92e_set_rf_power_state
      staging: rtl8192e: Remove rf_chip in _rtl92e_get_supported_wireless_mode
      staging: rtl8192e: Remove priv->rf_chip in _rtl92e_get_channel_map
      staging: rtl8192e: Remove priv->rf_chip
      staging: rtl8192e: Remove rtl92e_config_phy
      staging: rtl8192e: Remove _rtl92e_get_supported_wireless_mode
      staging: rtl8192e: Remove 5G wireless_mode in rtl92e_set_wireless_mode
      staging: rtl8192e: Remove unused if clauses in rtl92e_set_wireless_mode
      staging: rtl8192e: Remove wireless modes A, N_5G from _rtl92e_hwconfig
      staging: rtl8192e: Remove wireless modes A, N_5G from rtl92e_set_channel
      staging: rtl8192e: Remove wireless mode WIRELESS_MODE_N_5G
      staging: rtl8192e: Remove RF_Type from .._dm_tx_update_tssi_weak_signal
      staging: rtl8192e: Remove enum RF_1T2R and RF_Type
      staging: rtl8192e: Remove local variable Value and powerlevelOFDM24G
      staging: rtl8192e: Remove case customer_id = RT_CID_DLINK
      staging: rtl8192e: Remove case customer_id = RT_CID_819x_CAMEO, ..
      staging: rtl8192e: Remove case customer_id = RT_CID_DEFAULT, ..
      staging: rtl8192e: Remove macro IS_HARDWARE_TYPE_8192SE
      staging: rtl8192e: Remove unused function _rtl92e_dm_init_wa_broadcom_iot
      staging: rtl8192e: Remove one of two checks for hardware RTL8192SE
      staging: rtl8192e: Remove unused variable RF_Type
      staging: rtl8192e: Remove unchanged variable RegRfPsLevel
      staging: rtl8192e: Remove unused function rtl92e_disable_nic
      staging: rtl8192e: Remove unused macro RT_SET_PS_LEVEL
      staging: rtl8192e: Remove second initialization of bActuallySet
      staging: rtl8192e: Remove set to true while true of bfirst_after_down
      staging: rtl8192e: Remove unchanged variable chan_forced
      staging: rtl8192e: Remove unchanged variable frame_sync_monitor
      staging: rtl8192e: Remove unchanged variables bfsync_processing and more
      staging: rtl8192e: Fix W_DISABLE# does not work after stop/start

Rohit Chavan (1):
      staging: vme: remove blank line after return statement

Shibo Li (2):
      staging: rtl8712: Remove extra spaces
      staging: rtl8712: Fix multiple line dereference

Srihari S (1):
      staging: rtl8172: Add blank lines after declarations

Sumitra Sharma (10):
      Staging: qlge: Fix indentation in conditional statement
      Staging: octeon: Fix line ending with '('
      Staging: greybus: Fix lines ending with '('
      Staging: nvec: Remove macro definition to_nvec_led
      staging: greybus: Inline gpio_chip_to_gb_gpio_controller()
      staging: greybus: Inline gb_audio_manager_module()
      staging: greybus: Inline pwm_chip_to_gb_pwm_chip()
      staging: rtl8192e: fix line ending with '('
      staging: rtl8192e: remove extra blank lines
      staging: rtl8192e: Add blank lines after declarations

Tom Rix (2):
      staging: rts5208: remove unused xd_check_err_code function
      staging: rtl8192u: remove unused ieee80211_SignalStrengthTranslate function

Uwe Kleine-König (13):
      staging: axis-fifo: Convert to platform remove callback returning void
      staging: emxx_udc: Convert to platform remove callback returning void
      staging: fieldbus: arcx-anybus: Convert to platform remove callback returning void
      staging: greybus: arche-apb-ctrl: Convert to platform remove callback returning void
      staging: greybus: arche: Convert to platform remove callback returning void
      staging: most: dim2: Convert to platform remove callback returning void
      staging: nvec: Convert to platform remove callback returning void
      staging: nvec: nvec_kbd: Convert to platform remove callback returning void
      staging: nvec_power: Convert to platform remove callback returning void
      staging: nvec_ps2: Convert to platform remove callback returning void
      staging: octeon: ethernet: Convert to platform remove callback returning void
      staging: vc04_services: bcm2835-camera: Convert to platform remove callback returning void
      staging: vc04_services: vchiq_arm: Convert to platform remove callback returning void

Yang Li (1):
      staging: most: dim2: Use devm_platform_get_and_ioremap_resource()

 drivers/staging/axis-fifo/axis-fifo.c              |  34 +-
 drivers/staging/emxx_udc/emxx_udc.c                |   6 +-
 drivers/staging/fieldbus/anybuss/arcx-anybus.c     |   5 +-
 drivers/staging/greybus/arche-apb-ctrl.c           |   6 +-
 drivers/staging/greybus/arche-platform.c           |   6 +-
 drivers/staging/greybus/audio_manager_module.c     |  47 +-
 drivers/staging/greybus/audio_topology.c           |   5 +-
 drivers/staging/greybus/gpio.c                     |   7 +-
 drivers/staging/greybus/greybus_authentication.h   |   1 -
 drivers/staging/greybus/pwm.c                      |   6 +-
 drivers/staging/greybus/tools/.gitignore           |   2 -
 drivers/staging/greybus/tools/Android.mk           |  10 -
 drivers/staging/greybus/tools/Makefile             |  33 -
 drivers/staging/greybus/tools/README.loopback      | 198 -----
 drivers/staging/greybus/tools/lbtest               | 169 ----
 drivers/staging/greybus/tools/loopback_test.c      | 979 ---------------------
 drivers/staging/iio/resolver/ad2s1210.c            |   2 +-
 drivers/staging/ks7010/ks_hostif.c                 |   5 +-
 drivers/staging/most/dim2/dim2.c                   |  15 +-
 drivers/staging/most/dim2/hal.c                    |   5 +-
 drivers/staging/most/i2c/i2c.c                     |   5 +-
 drivers/staging/most/video/video.c                 |   3 +-
 drivers/staging/nvec/nvec.c                        |   6 +-
 drivers/staging/nvec/nvec_kbd.c                    |   6 +-
 drivers/staging/nvec/nvec_paz00.c                  |   5 +-
 drivers/staging/nvec/nvec_power.c                  |   6 +-
 drivers/staging/nvec/nvec_ps2.c                    |   6 +-
 drivers/staging/octeon/ethernet.c                  |   5 +-
 drivers/staging/octeon/octeon-stubs.h              |   4 +-
 drivers/staging/qlge/qlge_dbg.c                    |  35 +-
 drivers/staging/rtl8192e/rtl8192e/Makefile         |   2 +-
 drivers/staging/rtl8192e/rtl8192e/r8190P_def.h     |  11 -
 drivers/staging/rtl8192e/rtl8192e/r8190P_rtl8256.c |  10 -
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c     |  82 +-
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.h     |   1 -
 .../staging/rtl8192e/rtl8192e/r8192E_firmware.c    |   2 +-
 drivers/staging/rtl8192e/rtl8192e/r8192E_hw.h      |   7 -
 drivers/staging/rtl8192e/rtl8192e/r8192E_hwimg.h   |  33 -
 drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c     | 609 ++++---------
 drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h     |  32 -
 drivers/staging/rtl8192e/rtl8192e/r8192E_phyreg.h  |  37 -
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c       | 204 +----
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h       |  69 --
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c         | 258 ++----
 drivers/staging/rtl8192e/rtl8192e/rtl_pci.c        |   6 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_ps.c         |   3 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_wx.c         |   8 +-
 .../rtl8192e/rtl8192e/{r8192E_hwimg.c => table.c}  |  22 +-
 drivers/staging/rtl8192e/rtl8192e/table.h          |  27 +
 drivers/staging/rtl8192e/rtl819x_HT.h              |   3 -
 drivers/staging/rtl8192e/rtl819x_TSProc.c          |   3 +-
 drivers/staging/rtl8192e/rtllib.h                  |  44 +-
 drivers/staging/rtl8192e/rtllib_crypt_ccmp.c       |  32 +-
 drivers/staging/rtl8192e/rtllib_rx.c               |  80 +-
 drivers/staging/rtl8192e/rtllib_softmac.c          |  47 +-
 drivers/staging/rtl8192e/rtllib_softmac_wx.c       |  12 +-
 drivers/staging/rtl8192e/rtllib_wx.c               |  42 +-
 drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c  |  38 -
 drivers/staging/rtl8192u/r8192U_dm.c               | 244 +----
 drivers/staging/rtl8192u/r8192U_dm.h               |   1 -
 drivers/staging/rtl8192u/r819xU_phy.c              |  87 --
 drivers/staging/rtl8192u/r819xU_phy.h              |   2 -
 drivers/staging/rtl8712/rtl8712_efuse.h            |   1 +
 drivers/staging/rtl8712/rtl871x_mlme.c             |  97 +-
 drivers/staging/rtl8723bs/core/rtw_mlme.c          |  17 +-
 drivers/staging/rtl8723bs/hal/hal_btcoex.c         |   8 -
 drivers/staging/rtl8723bs/hal/hal_com.c            | 108 ---
 drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c  |   1 -
 drivers/staging/rtl8723bs/include/drv_types.h      |   6 +-
 drivers/staging/rtl8723bs/include/hal_btcoex.h     |   1 -
 drivers/staging/rtl8723bs/include/hal_com.h        |   9 -
 drivers/staging/rtl8723bs/include/ieee80211.h      |  49 +-
 drivers/staging/rtl8723bs/include/rtw_mlme.h       |  20 -
 drivers/staging/rtl8723bs/include/rtw_recv.h       |   9 +-
 drivers/staging/rts5208/xd.c                       |   7 -
 .../vc04_services/bcm2835-camera/bcm2835-camera.c  |   6 +-
 .../vc04_services/interface/vchiq_arm/vchiq_arm.c  |   6 +-
 drivers/staging/vme_user/Kconfig                   |   3 +-
 drivers/staging/vme_user/vme_fake.c                |   5 -
 drivers/staging/vme_user/vme_tsi148.c              |  13 +-
 drivers/staging/vme_user/vme_tsi148.h              | 534 +++++------
 drivers/staging/vt6655/baseband.c                  |  44 -
 drivers/staging/vt6655/baseband.h                  |   2 -
 drivers/staging/vt6656/card.c                      |  21 -
 drivers/staging/vt6656/card.h                      |   1 -
 drivers/staging/wlan-ng/prism2fw.c                 |   8 +-
 86 files changed, 894 insertions(+), 3762 deletions(-)
 delete mode 100644 drivers/staging/greybus/tools/.gitignore
 delete mode 100644 drivers/staging/greybus/tools/Android.mk
 delete mode 100644 drivers/staging/greybus/tools/Makefile
 delete mode 100644 drivers/staging/greybus/tools/README.loopback
 delete mode 100755 drivers/staging/greybus/tools/lbtest
 delete mode 100644 drivers/staging/greybus/tools/loopback_test.c
 delete mode 100644 drivers/staging/rtl8192e/rtl8192e/r8192E_hwimg.h
 rename drivers/staging/rtl8192e/rtl8192e/{r8192E_hwimg.c => table.c} (95%)
 create mode 100644 drivers/staging/rtl8192e/rtl8192e/table.h
