Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8472B6A1C72
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 13:51:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbjBXMvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 07:51:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbjBXMvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 07:51:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FA7561EFA
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 04:51:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B819FB81C77
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 12:51:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12269C433D2;
        Fri, 24 Feb 2023 12:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1677243095;
        bh=geMwP7vVPIhTQ6PXvzLZ1QqUcOjZ0zK/vbJrIu2UaQg=;
        h=Date:From:To:Cc:Subject:From;
        b=e6xPKn5cMSMoDfMcXFudfa1oPXF+SGrvoL9qL+YbjZayrY7RBC0XDYUjhdvDAk2+V
         Y2O6B0KbihPXworRlcRoebSHRekrVtNeiMT8pQjbCoPeBJlv9VCB4nWT954I9CADHe
         EywqC+vLTqJWyd3c88mZSgOuZ4OVwIU86J44M6yY=
Date:   Fri, 24 Feb 2023 13:51:32 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [GIT PULL] Staging driver updates for 6.3-rc1
Message-ID: <Y/iy1MgXVLkmtOQP@kroah.com>
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

The following changes since commit 2241ab53cbb5cdb08a6b2d4688feb13971058f65:

  Linux 6.2-rc5 (2023-01-21 16:27:01 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-6.3-rc1

for you to fetch changes up to b5929325f06300d28696b9a030539a4009154788:

  staging: r8188eu: Revert "staging: r8188eu: simplify rtw_get_ff_hwaddr" (2023-02-16 13:55:03 +0100)

----------------------------------------------------------------
Staging driver update for 6.3-rc1

Here is the "boring" staging driver update for 6.3-rc1.

Nothing major in here at all, it's just lots of tiny code cleanups to
bring some of the staging drivers more in line with the real portion of
the kernel (apis and coding style.)  Overall we remove more lines of
code than we add, always a nice result.

The big work was done by Martin Kaiser and Philipp Hortmann, both
tackling some of the older wifi drivers, removing unused code and
structures and a file in one case.

Full details of the changes are in the shortlog.

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Abhirup Deb (1):
      staging: vme_user: Replace the "<<" with BIT macro

Anup Sharma (2):
      Staging: rtl8192u: ieee80211: Fix indentation errors by removing extra spaces
      staging: rtl8723bs: hal: Fix codespell-reported spelling mistakes

Brent Pappas (1):
      staging: greybus: gpio: Replace macro irq_data_to_gpio_chip with function

Deepak R Varma (2):
      staging: greybus: Replace zero-length array by DECLARE_FLEX_ARRAY() helper
      staging: wlan-ng: Remove unused code

Denis Arefev (1):
      staging: rts5208: Added value check

Greg Kroah-Hartman (2):
      Merge 6.2-rc5 into staging-next
      staging: pi433: fix memory leak with using debugfs_lookup()

Guru Mehar Rachaputi (1):
      staging: pi433: Added information about bit_rate configuration

Jongwoo Han (1):
      staging: vc04_services: mmal-vchiq: fix typo in comment

Kang Minchul (1):
      staging: r8188eu: Prefer kcalloc over kzalloc

Larry Finger (1):
      staging: r8188eu: Fix some endian problems

Martin Kaiser (113):
      staging: r8188eu: merge on_action_public_vendor into its caller
      staging: r8188eu: merge on_action_public_default into its only caller
      staging: r8188eu: remove intermediate pframe pointer
      staging: r8188eu: remove intermediate token variable
      staging: r8188eu: make xmitframe_swencrypt a void function
      staging: r8188eu: remove some unused CAM defines
      staging: r8188eu: cmd_seq is write-only
      staging: r8188eu: return immediately if we're not meant to encrypt
      staging: r8188eu: remove unused parameter
      staging: r8188eu: simplify rtl8188eu_xmit_tasklet
      staging: r8188eu: remove rtl8188eu_init_xmit_priv
      staging: r8188eu: remove duplicate psta check
      staging: r8188eu: simplify frame type check
      staging: r8188eu: simplify rtw_make_wlanhdr's error handling
      staging: r8188eu: clean up qos_option setting
      staging: r8188eu: remove unused bpending array
      staging: r8188eu: remove unused dma_transfer_addr
      staging: r8188eu: bm_pending is not used
      staging: r8188eu: terminate_xmitthread_sema is not used
      staging: r8188eu: tx_retevt semaphore is not used
      staging: r8188eu: remove unnecessary rtw_free_xmitframe call
      staging: r8188eu: phwxmit parameter is unused
      staging: r8188eu: rtw_init_hwxmits is not needed
      staging: r8188eu: beq_cnt is write-only
      staging: r8188eu: bkq_cnt is write-only
      staging: r8188eu: viq_cnt is write-only
      staging: r8188eu: voq_cnt is write-only
      staging: r8188eu: replace switch with if
      staging: r8188eu: dir_dev is unused
      staging: r8188eu: remove unused hal_xmit_handler define
      staging: r8188eu: txirp_cnt is write-only
      staging: r8188eu: remove unused QSLT defines
      staging: r8188eu: xmit_priv's vcs_type is not used
      staging: r8188eu: xmit_priv's vcs is not used
      staging: r8188eu: xmit_priv's vcs_setting is not used
      staging: r8188eu: refactor status handling in usb_write_port_complete
      staging: r8188eu: reformat usb_write_port_complete
      staging: r8188eu: remove unused function parameter
      staging: r8188eu: always process urb status
      staging: r8188eu: remove NULL check for usb_kill_urb
      staging: r8188eu: remove struct io_priv
      staging: r8188eu: remove io function prototypes
      staging: r8188eu: remove ioreq function prototypes
      staging: r8188eu: remove async read function prototypes
      staging: r8188eu: remove async write function prototypes
      staging: r8188eu: remove struct io_queue
      staging: r8188eu: remove attrib function prototypes
      staging: r8188eu: remove rtw_write_scsi function prototype
      staging: r8188eu: remove dev_power_down function prototype
      staging: r8188eu: remove struct reg_protocol_rd
      staging: r8188eu: remove struct reg_protocol_wt
      staging: r8188eu: remove interface handler prototypes
      staging: r8188eu: remove readmem and writemem prototypes
      staging: r8188eu: remove IO defines
      staging: r8188eu: remove struct io_req
      staging: r8188eu: remove usb buffer macros
      staging: r8188eu: pass struct adapter to usb_read
      staging: r8188eu: we use a constant number of hw_xmit entries
      staging: r8188eu: pass struct adapter to usb_write
      staging: r8188eu: remove struct intf_hdl
      staging: r8188eu: remove struct intf_priv
      staging: r8188eu: simplify the sta loop in rtw_dequeue_xframe
      staging: r8188eu: simplify the code to initialise inx
      staging: r8188eu: remove an obsolete comment
      staging: r8188eu: remove unused function parameter
      staging: r8188eu: remove dead assignment
      staging: r8188eu: use list_empty
      staging: r8188eu: simplify dequeue_one_xmitframe
      staging: r8188eu: remove redundant parameter
      staging: r8188eu: make rtw_chk_hi_queue_cmd a void function
      staging: r8188eu: decrement qcnt in rtw_dequeue_xframe
      staging: r8188eu: simplify dequeue_one_xmitframe
      staging: r8188eu: use list_head for xmitframe list
      staging: r8188eu: merge dequeue_one_xmitframe into its caller
      staging: r8188eu: use lists for hwxmits
      staging: r8188eu: fix rtw_xmitframe_enqueue error handling
      staging: r8188eu: remove rtw_xmitframe_enqueue
      staging: r8188eu: struct agg_pkt_info is unused
      staging: r8188eu: apsd_setting is unused
      staging: r8188eu: merge rtw_free_hwxmits into its only caller
      staging: r8188eu: usb_read_port_complete needs no regs parameter
      staging: r8188eu: remove defines that strip regs parameter
      staging: r8188eu: remove unused defines
      staging: r8188eu: remove usb_ops_linux.h
      staging: r8188eu: rtw_free_xmitframe_queue needs no spinlock
      staging: r8188eu: change function param from __queue to list_head
      staging: r8188eu: change another function param from __queue to list_head
      staging: r8188eu: make sta_pending a list_head
      staging: r8188eu: use kernel helper to iterate over a list
      staging: r8188eu: legacy_dz is initialised but never used
      staging: r8188eu: apsd is initialised but never used
      staging: r8188eu: option in struct sta_xmit_priv is not used
      staging: r8188eu: replace switch-case with if
      staging: r8188eu: clean up NULL check for rcu pointer
      staging: r8188eu: pass a struct recv_buf to rtw_read_port
      staging: r8188eu: use standard error codes in rtw_read_port
      staging: r8188eu: use standard error codes in rtl8188eu_inirp_init
      staging: r8188eu: remove intf_start pointer
      staging: r8188eu: handle rtl8188eu_inirp_init errors
      staging: r8188eu: remove intf_stop pointer
      staging: r8188eu: make ips_enter static
      staging: r8188eu: make ips_leave static
      staging: r8188eu: remove change_rfpwrstate
      staging: r8188eu: merge do_queue_select into its only caller
      staging: r8188eu: simplify rtw_alloc_xmitframe
      staging: r8188eu: remove unused frametag defines
      staging: r8188eu: xmit_buf's ff_hwaddr is not used
      staging: r8188eu: simplify xmit_buf flags
      staging: r8188eu: simplify rtw_get_ff_hwaddr
      staging: r8188eu: bagg_pkt parameter is not used
      staging: r8188eu: merge _rtw_enqueue_cmd into its caller
      staging: r8188eu: replace hand coded loop with list_for_each_entry
      staging: r8188eu: Revert "staging: r8188eu: simplify rtw_get_ff_hwaddr"

Matt Jan (3):
      staging: vme_user: add the spaces around the "*"
      staging: vme_user: remove unnecessary spaces
      staging: vme_user: replace 'unsigned' with 'unsigned int'

Michael Straube (7):
      staging: r8188eu: convert rtw_writeN() to common error logic
      staging: r8188eu: convert PHY_MACConfig8188E() to common error logic
      staging: r8188eu: convert phy_RF6052_Config_ParaFile() to common error logic
      staging: r8188eu: convert phy_BB8188E_Config_ParaFile() to common error logic
      staging: r8188eu: convert PHY_BBConfig8188E() to common error logic
      staging: r8188eu: correct error logic of rtl8188eu_init_recv_priv()
      staging: r8188eu: correct error logic of _rtw_init_recv_priv()

Parthiban Veerasooran (1):
      most: add maintainer entry

Phil Elwell (1):
      staging: vchiq_core: Add comments to remote event parts

Philipp Hortmann (66):
      staging: rtl8192e: Rename ChannelPlan, eeprom_ChannelPlan and CckPwEnl
      staging: rtl8192e: Rename TSSI_13dBm, Pwr_Track and NumTotalRFPath
      staging: rtl8192e: Rename CCKPresentAtt...
      staging: rtl8192e: Rename TxPowerLevelCCK...
      staging: rtl8192e: Rename TxPowerLevelOFDM24G...
      staging: rtl8192e: Rename MCSTxPowerL.., LegacyHTTxPowe.. and AntennaTx..
      staging: rtl8192e: Rename SetRFPowerSta.., RfReg0Value and bTXPowerDa..
      staging: rtl8192e: Rename bDynamicTxHig.., bDynamicTxL.. and bLastDTPF..
      staging: rtl8192e: Rename bLastDTPFlag_Low, OFDM_index and CCK_index
      staging: rtl8192e: Rename Record_CCK_2.., Record_CCK_4.. and DefaultIn..
      staging: rtl8192e: Rename rateCountDi.., ContinueDif.. and TxCounter
      staging: rtl8192e: Rename bResetInPro.., framesyncMo.. and nCur40MhzPri..
      staging: rtl8192e: Rename SetBWModeIn.., SwChnlInPro.. and ThermalMet..
      staging: rtl8192e: Rename CrystalCap, EEPROMLegacyHTT.. and EEPROMCrys..
      staging: rtl8192e: Rename EEPROMTherma.., EEPROMAntPw.. and EEPROMTxPow..
      staging: rtl8192e: Rename EEPROMTxPower.., AutoloadF.. and SilentReset..
      staging: rtl8192e: Rename EEPROMTxPower.., AutoloadF.. and SilentReset..
      staging: rtl8192e: Rename LongRetryL.., ShortRetryL.. and ReceiveConfig
      staging: rtl8192e: Rename LastRxDescTSF, LoopbackMode and pFirmware
      staging: rtl8192e: Rename PHYRegDef, CurrentChannelBW and CustomerID
      staging: rtl8192e: Remove unused variable SifsTime
      staging: rtl8192e: Remove unused variable framesyncC34
      staging: rtl8192e: Remove unused variable PwrDomainProtect
      staging: rtl8192e: Remove unused variable H2CTxCmdSeq
      staging: rtl8192e: Remove unused variable RF_C_TxPwDiff
      staging: rtl8192e: Remove unused variable DM_Type
      staging: rtl8192e: Combine three loops to one to init tx_pwr_level_...
      staging: rtl8192e: Init tx_pwr_level_cck_a and friends directly
      staging: rtl8192e: Remove zeroed arrays tx_pwr_level_cck_a and friends
      staging: rtl8192e: Remove ant_pwr_diff which is always zero
      staging: rtl8192e: Remove u4RegValue which is always zero
      staging: rtl8192e: Remove repeated set to zero of powerlevel and friend
      staging: rtl8192e: Remove unused variable bfirst_init
      staging: rtl8192e: Rename eeprom_CustomerID, SwChnlStage and SwChnlStep
      staging: rtl8192e: Rename btxpower_trackin.., Slide_Beaco.. and Slide_B..
      staging: rtl8192e: Remove unused variables rxrdu and rxok
      staging: rtl8192e: Remove unused variables rxdatacrcerr and rxmgmtcrcerr
      staging: rtl8192e: Remove unused variables rxcrcerrmin and friends
      staging: rtl8192e: Remove unused variables numpacket.. and received_pre..
      staging: rtl8192e: Remove unused variables numqry_..
      staging: rtl8192e: Remove unused variables num_proc.., recei.. and rxov..
      staging: rtl8192e: Remove unused variables rxint, ints and shints
      staging: rtl8192e: Remove unused variables txov.., txbeokint and txbkokint
      staging: rtl8192e: Remove unused variables txviok.., txvook.. and txbea..
      staging: rtl8192e: Remove unused variables txbeac.., txman.. and txcmdp..
      staging: rtl8192e: Remove unused variables txbytes.., txbyt.. and signa..
      staging: rtl8192e: Rename TxBBGainTab.., CCKTxBBGainTab.. and RT_CID_81..
      staging: rtl8192e: Rename sCrcLng
      staging: rtl8192e: Remove unused variable rxSNRdB
      staging: rtl8192e: Remove unused constants from enum rt_customer_id
      staging: rtl8192e: Rename BaseBand_Config_PHY_REG and BaseBand_Config_AGC_TAB
      staging: rtl8192e: Remove unused constants at beginning of r8192E_hw.h
      staging: rtl8192e: Remove unused constants in _RTL8192Pci_HW
      staging: rtl8192e: Remove used constants MSR_LINK_SH.. and MSR_LINK_N..
      staging: rtl8192e: Rename _RTL8192Pci_HW, MXDMA2_NoLimit and TPPoll
      staging: rtl8192e: Rename TPPoll_CQ, AcmHwCtrl and AcmHw_BeqEn
      staging: rtl8192e: Rename AcmHw_ViqEn, AcmHw_VoqEn and ANAPAR_FOR_8192PciE
      staging: rtl8192e: Remove blank lines in r8192E_hw.h, rtl_core.h and ..
      staging: rtl8192e: Rename MacBlkCtrl and remove double definition
      staging: rtl8192e: Rename OFDM_Table.., CCK_Table_.. and RxPathSelecti..
      staging: rtl8192e: Rename RxPathSelectio.., RateAdaptive.. and RateAdap..
      staging: rtl8192e: Rename RateAdaptiveTH.., VeryLowRSSI and WAIotTHVal
      staging: rtl8192e: Rename Enable, cck_Rx_path and SS_TH_low
      staging: rtl8192e: Rename diff_TH and disabledRF
      staging: rtl8192e: Rename DM_RxPathSelTable
      staging: rtl8192e: Use BIT() instead of << for bit field MSR_LINK_MASK

Stefan Wahren (1):
      staging: vchiq_arm: Improve error log for vchiq_platform_init

Umang Jain (12):
      staging: vc04_services: Replace vchiq_status return type to int
      staging: vc04_services: Drop VCHIQ_SUCCESS usage
      staging: vc04_services: Drop VCHIQ_ERROR usage
      staging: vc04_services: Drop VCHIQ_RETRY usage
      staging: vc04_services: vchiq_arm: Drop VCHIQ_RETRY usage on disconnect
      staging: vc04_services: Drop enum vchiq_status remnants
      staging: vc04_services: vchiq: Drop custom return values from TODO
      staging: vc04_services: Drop __VCCOREVER__ remnants
      staging: vc04_services: bcm2835-audio: Drop include Makefile directive
      staging: vc04_services: bcm2835-camera: Drop include Makefile directive
      staging: vc04_services: vchiq-mmal: Drop include Makefile directive
      staging: vc04_services: interface: Drop include Makefile directive

Xu Panda (2):
      staging: ks7010: use strscpy() to instead of strncpy()
      staging: r8188eu: use strscpy() to instead of strncpy()

Yuan Can (1):
      staging: emxx_udc: Add checks for dma_alloc_coherent()

 MAINTAINERS                                        |  10 +
 drivers/staging/emxx_udc/emxx_udc.c                |   7 +-
 drivers/staging/greybus/gpio.c                     |   6 +-
 drivers/staging/greybus/usb.c                      |   2 +-
 drivers/staging/ks7010/ks_wlan_net.c               |   3 +-
 drivers/staging/pi433/TODO                         |   3 +
 drivers/staging/pi433/pi433_if.c                   |  11 +-
 drivers/staging/r8188eu/core/rtw_cmd.c             |  67 +--
 drivers/staging/r8188eu/core/rtw_fw.c              |  10 +-
 drivers/staging/r8188eu/core/rtw_mlme.c            |   5 -
 drivers/staging/r8188eu/core/rtw_mlme_ext.c        |  31 +-
 drivers/staging/r8188eu/core/rtw_pwrctrl.c         |  23 +-
 drivers/staging/r8188eu/core/rtw_recv.c            |  30 +-
 drivers/staging/r8188eu/core/rtw_sta_mgt.c         |  26 +-
 drivers/staging/r8188eu/core/rtw_xmit.c            | 478 +++++++--------------
 drivers/staging/r8188eu/hal/rtl8188e_cmd.c         |   4 +-
 drivers/staging/r8188eu/hal/rtl8188e_phycfg.c      |  35 +-
 drivers/staging/r8188eu/hal/rtl8188e_rf6052.c      |   7 +-
 drivers/staging/r8188eu/hal/rtl8188eu_xmit.c       |  42 +-
 drivers/staging/r8188eu/hal/usb_halinit.c          |  31 +-
 drivers/staging/r8188eu/hal/usb_ops_linux.c        |  80 ++--
 drivers/staging/r8188eu/include/drv_types.h        |   4 -
 drivers/staging/r8188eu/include/hal_intf.h         |   2 +-
 drivers/staging/r8188eu/include/osdep_intf.h       |  32 --
 drivers/staging/r8188eu/include/rtl8188e_cmd.h     |   2 +-
 drivers/staging/r8188eu/include/rtl8188e_spec.h    |  21 -
 drivers/staging/r8188eu/include/rtl8188e_xmit.h    |  16 +-
 drivers/staging/r8188eu/include/rtw_cmd.h          |   3 +-
 drivers/staging/r8188eu/include/rtw_io.h           | 257 +----------
 drivers/staging/r8188eu/include/rtw_pwrctrl.h      |   3 -
 drivers/staging/r8188eu/include/rtw_xmit.h         |  57 +--
 drivers/staging/r8188eu/include/usb_ops.h          |   2 -
 drivers/staging/r8188eu/include/usb_ops_linux.h    |  29 --
 drivers/staging/r8188eu/os_dep/ioctl_linux.c       |   6 +-
 drivers/staging/r8188eu/os_dep/os_intfs.c          |  17 +-
 drivers/staging/r8188eu/os_dep/usb_intf.c          |  33 +-
 drivers/staging/r8188eu/os_dep/usb_ops_linux.c     | 106 +----
 drivers/staging/rtl8192e/rtl8192e/r8190P_rtl8256.c |  22 +-
 drivers/staging/rtl8192e/rtl8192e/r8192E_cmdpkt.c  |   2 +-
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c     | 355 ++++++---------
 .../staging/rtl8192e/rtl8192e/r8192E_firmware.c    |   4 +-
 drivers/staging/rtl8192e/rtl8192e/r8192E_hw.h      | 219 +---------
 drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c     | 374 ++++++++--------
 drivers/staging/rtl8192e/rtl8192e/r8192E_phyreg.h  |   2 -
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c       |  86 +---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h       | 208 +++------
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c         | 342 ++++++++-------
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.h         |  45 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_pm.c         |   2 +-
 drivers/staging/rtl8192u/ieee80211/ieee80211.h     |   2 +-
 drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c  |  14 +-
 drivers/staging/rts5208/ms.c                       |   2 +
 drivers/staging/vc04_services/Makefile             |   2 -
 .../staging/vc04_services/bcm2835-audio/Makefile   |   2 -
 .../vc04_services/bcm2835-audio/bcm2835-vchiq.c    |  12 +-
 .../staging/vc04_services/bcm2835-audio/bcm2835.h  |   3 +-
 .../staging/vc04_services/bcm2835-camera/Makefile  |   5 -
 .../vc04_services/bcm2835-camera/bcm2835-camera.c  |  10 +-
 .../vc04_services/bcm2835-camera/controls.c        |   6 +-
 .../include/linux/raspberrypi/vchiq.h              |  63 ++-
 drivers/staging/vc04_services/interface/TODO       |   5 -
 .../vc04_services/interface/vchiq_arm/vchiq_arm.c  | 136 +++---
 .../vc04_services/interface/vchiq_arm/vchiq_arm.h  |   8 +-
 .../vc04_services/interface/vchiq_arm/vchiq_core.c | 226 +++++-----
 .../vc04_services/interface/vchiq_arm/vchiq_core.h |  38 +-
 .../vc04_services/interface/vchiq_arm/vchiq_dev.c  |  36 +-
 .../interface/vchiq_arm/vchiq_ioctl.h              |  11 +-
 drivers/staging/vc04_services/vchiq-mmal/Makefile  |   5 -
 .../staging/vc04_services/vchiq-mmal/mmal-vchiq.c  |  15 +-
 drivers/staging/vme_user/vme.h                     |  26 +-
 drivers/staging/vme_user/vme_bridge.h              |  36 +-
 drivers/staging/wlan-ng/hfa384x.h                  | 171 --------
 72 files changed, 1330 insertions(+), 2666 deletions(-)
 delete mode 100644 drivers/staging/r8188eu/include/usb_ops_linux.h
