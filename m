Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 149FE7459B6
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 12:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbjGCKJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 06:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbjGCKJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 06:09:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63AA9E6E
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 03:09:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DAD7860EA5
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 10:09:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6F01C433C7;
        Mon,  3 Jul 2023 10:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688378973;
        bh=0VXnz2lzhEaoJyuGniWD2weT09+XzdMlYXcvVh1Z0Rk=;
        h=Date:From:To:Cc:Subject:From;
        b=qMCxk38m9zZRRrFqk7T1cJ1HCJFHwg/acBgmRE+26+UxGAaqthWybYyoJhTnVjMuZ
         1GCX1roG2FddwYn12XODld+TkKAmNDY6siO1a3LqMoZJVmd2RrifGwQ7GULw/cxN7A
         qS0+6MDgqYZOF2+uFfwHqkVInAmsyA48XDB9egyY=
Date:   Mon, 3 Jul 2023 12:09:30 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [GIT PULL] Staging driver updates for 6.5-rc1
Message-ID: <ZKKeWkpCEqxHZ7qK@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit ac9a78681b921877518763ba0e89202254349d1b:

  Linux 6.4-rc1 (2023-05-07 13:34:35 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-6.5-rc1

for you to fetch changes up to 4a22870cede374d80c5d2f9c5b79253a5a667832:

  staging: rtl8192e: Remove whitespace and blank lines (2023-06-23 10:18:27 +0200)

----------------------------------------------------------------
Staging driver updates for 6.5-rc1

Here is a set of staging driver updates for 6.5-rc1.  It's a small
update this merge window, nothing major at all, overall just under 1000
lines of code removed, not a huge churn.

Nothing major to highlight here either, just lots of small coding style
fixes.

All of these have been in linux-next for a while with no reported
problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Andy Shevchenko (1):
      staging: pi433: Remove stray gpiod_unexport() call

Arnd Bergmann (1):
      staging: vchiq_arm: mark vchiq_platform_init() static

Atin Bainada (1):
      staging: rtl8723bs: replace ternary operator with if-else block

Bagas Sanjaya (1):
      drivers: staging: wlan-ng: Remove GPL/MPL boilerplate

Daniel Watson (1):
      staging: rtl8723bs: use tabs for indentation

David Tadokoro (1):
      staging: rtl8192e: clean unnecessary braces warning on r8192E_phy.c

Deepanshu Kartikey (1):
      Staging: rts5208: rtsx: Removed new line in else and else if

Franziska Naepelt (3):
      staging: rtl8723bs: Fix indentation issues
      staging: rtl8723bs: Fix block comment issue
      staging: rtl8723bs: Fix blank line issues

John Grace (1):
      staging: rtl8192e: avoid CamelCase <RATRIndex>

Luke Koch (1):
      staging: wlan-ng: replace rate macros

Michael Straube (7):
      staging: rtl8192e: add missing spaces around operators
      staging: rtl8192e: remove blank lines
      staging: rtl8192e: clean up brace coding style issues
      staging: rtl8192e: convert else if sequence to switch
      staging: rtl8192e: remove return statement from void function
      staging: rtl8192e: remove comparison to true
      staging: rtl8192e: remove 5G related code

Niklas Schnelle (1):
      staging: add HAS_IOPORT dependencies

Philipp Hortmann (24):
      staging: rtl8192e: Remove undefined function data_hard_stop
      staging: rtl8192e: Remove undefined function data_hard_resume
      staging: rtl8192e: Remove functions rtllib_start_hw_scan and stop
      staging: rtl8192e: Remove undefined function reset_port
      staging: rtl8192e: Remove undefined function hard_start_xmit
      staging: rtl8192e: Remove undefined function set_security
      staging: rtl8192e: Remove undefined function SetFwCmdHandler
      staging: rtl8192e: Remove undefined function UpdateBeaconInterruptHandler
      staging: rtl8192e: Remove undefined function LedControlHandler
      staging: rtl8192e: Exclude scan_mutex in rtllib_softmac_stop_scan
      staging: rtl8192e: Unlock wx_mutex not in rtllib_wx_set_scan
      staging: rtl8192e: Add cfg80211.h and remove defined variables
      staging: rtl8192e: Use standard api to calculate frequency to channel
      staging: rtl8192e: Use standard api to calculate channel to frequency
      staging: rtl8192e: Add missing entry CFG80211 in Kconfig
      staging: rtl8192e: Remove variable stats->freq as it is constant
      staging: rtl8192e: Remove unsupported modes IEEE_N_5G and IEEE_A
      staging: rtl8192e: Rename constant IEEE_x to WIRELESS_MODE_x
      staging: rtl8192e: Remove unused enum led_ctl_mode
      staging: rtl8192e: Rename rtllib_state to rtl_link_state
      staging: rtl8192e: Rename state to link_state
      staging: rtl8192e: Rename RTLLIB_NOLINK to MAC80211_NOLINK
      staging: rtl8192e: Rename RTLLIB_LINKED to MAC80211_LINKED
      staging: rtl8192e: Rename RTLLIB_LINKED_SCANNING

Prathu Baronia (1):
      axis-fifo: remove the unnecessary dev_info()

Stephan Snyman (1):
      staging: rtl8192e: add missing braces {}

Tree Davies (1):
      staging: rtl8192e: Remove whitespace and blank lines

Umang Jain (1):
      staging: vchiq_arm: Remove extra struct vchiq_instance declaration

Uwe Kleine-König (2):
      staging: olpc_dcon: Switch i2c driver back to use .probe()
      staging: most: Switch i2c driver back to use .probe()

Yogesh Hegde (12):
      staging: rtl8192e: Remove unused rf_set_sens variable
      staging: rtl8192e: Remove unused _rtl92e_wx_get_sens function
      staging: rtl8192e: Remove unused _rtl92e_wx_set_sens function
      staging: rtl8192e: Remove unused sens and max_sens from r8192_priv struct
      staging: rtl8192e: Rename tmpRegA and TempCCk
      staging: rtl8192e: Rename tmpOFDMindex and tmpCCKindex
      staging: rtl8192e: Rename tmpCCK20Mindex and tmpCCK40Mindex
      staging: rtl8192e: Refactor tmp_ofdm_index variable assignment
      staging: rtl8192e: Rename variable SetWirelessMode
      staging: rtl8192e: Rename variable SetBWModeHandler
      staging: rtl8192e: Rename variable LeisurePSLeave
      staging: rtl8192e: Rename variable InitialGainHandler

 drivers/staging/axis-fifo/axis-fifo.c              |   3 -
 drivers/staging/most/i2c/i2c.c                     |   2 +-
 drivers/staging/olpc_dcon/olpc_dcon.c              |   2 +-
 drivers/staging/pi433/pi433_if.c                   |   1 -
 drivers/staging/rtl8192e/rtl8192e/Kconfig          |   1 +
 drivers/staging/rtl8192e/rtl8192e/r8190P_def.h     |   8 -
 drivers/staging/rtl8192e/rtl8192e/r8190P_rtl8256.c |   6 +-
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c     |  97 +++---
 drivers/staging/rtl8192e/rtl8192e/r8192E_hw.h      |   1 -
 drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c     |  62 ++--
 drivers/staging/rtl8192e/rtl8192e/r8192E_phyreg.h  |   6 -
 drivers/staging/rtl8192e/rtl8192e/rtl_cam.c        |   2 -
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c       |  82 ++---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h       |   3 -
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c         | 168 +++++------
 drivers/staging/rtl8192e/rtl8192e/rtl_ethtool.c    |   4 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_pm.c         |   2 -
 drivers/staging/rtl8192e/rtl8192e/rtl_ps.c         |  20 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_wx.c         |  73 +----
 drivers/staging/rtl8192e/rtl819x_HT.h              |  67 ++---
 drivers/staging/rtl8192e/rtl819x_HTProc.c          |  12 +-
 drivers/staging/rtl8192e/rtl819x_Qos.h             |   1 -
 drivers/staging/rtl8192e/rtl819x_TS.h              |   2 -
 drivers/staging/rtl8192e/rtllib.h                  |  87 +-----
 drivers/staging/rtl8192e/rtllib_rx.c               |  63 ++--
 drivers/staging/rtl8192e/rtllib_softmac.c          | 333 +++++++--------------
 drivers/staging/rtl8192e/rtllib_softmac_wx.c       |  85 ++----
 drivers/staging/rtl8192e/rtllib_tx.c               |  16 +-
 drivers/staging/rtl8192e/rtllib_wx.c               |  31 +-
 drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c  |   5 +-
 drivers/staging/rtl8723bs/include/sta_info.h       |  26 +-
 drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c  |  62 +---
 drivers/staging/rts5208/rtsx.c                     |  20 +-
 drivers/staging/sm750fb/Kconfig                    |   2 +-
 .../include/linux/raspberrypi/vchiq.h              |   2 -
 .../vc04_services/interface/vchiq_arm/vchiq_arm.c  |   4 +-
 drivers/staging/vt6655/Kconfig                     |   2 +-
 drivers/staging/wlan-ng/hfa384x.h                  |  21 --
 drivers/staging/wlan-ng/hfa384x_usb.c              |  21 --
 drivers/staging/wlan-ng/p80211conv.c               |  21 --
 drivers/staging/wlan-ng/p80211conv.h               |  21 --
 drivers/staging/wlan-ng/p80211hdr.h                |  21 --
 drivers/staging/wlan-ng/p80211ioctl.h              |  21 --
 drivers/staging/wlan-ng/p80211metadef.h            |  21 --
 drivers/staging/wlan-ng/p80211metastruct.h         |  39 +--
 drivers/staging/wlan-ng/p80211mgmt.h               |  21 --
 drivers/staging/wlan-ng/p80211msg.h                |  21 --
 drivers/staging/wlan-ng/p80211netdev.c             |  21 --
 drivers/staging/wlan-ng/p80211netdev.h             |  21 --
 drivers/staging/wlan-ng/p80211req.c                |  21 --
 drivers/staging/wlan-ng/p80211req.h                |  21 --
 drivers/staging/wlan-ng/p80211types.h              |  21 --
 drivers/staging/wlan-ng/p80211wep.c                |  21 --
 drivers/staging/wlan-ng/prism2fw.c                 |  21 --
 drivers/staging/wlan-ng/prism2mgmt.c               |  73 +----
 drivers/staging/wlan-ng/prism2mgmt.h               |  21 --
 drivers/staging/wlan-ng/prism2mib.c                |  21 --
 drivers/staging/wlan-ng/prism2sta.c                |  21 --
 58 files changed, 446 insertions(+), 1428 deletions(-)
