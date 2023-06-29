Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18CEA742973
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 17:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232647AbjF2PYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 11:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232596AbjF2PXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 11:23:52 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 774BA35B6
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 08:23:50 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id BC41E3200945;
        Thu, 29 Jun 2023 11:23:49 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 29 Jun 2023 11:23:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1688052229; x=1688138629; bh=bstP08gdPaA9jQIillnZupFeM7RDuOMuY91
        d+Y8sUsM=; b=uVvUfiGBbTAwk9Kn6XdlLWG2WYzuv6zuASG3JJtCeBXHA2UNdi4
        0yDDrByzEC16bTXRoL/fqTPBCNIwViYTMuYNLaJdMEBWGUZjHCois56DwW+1HnpY
        a52FKDuoW2VG4ouQARgTGDjbdPrX7VeoUcZQvRq1PRfBggrPs0d7d76FrUlelsPq
        FxCFfbKFx4K/gdjEnGwE3yVbgTbtF7QmIprL+ZFL4/Umtw2+V6DPN+15HVNhYEBl
        q7C0QMDzeJlfqJNoDfVAba0IOtmbkmZv2Dt10I2nNp+e7pPdPojuL87b5Chilltr
        tcwgqUDIpnJTMmUy1tWe4Mf3JLoSMbRD3ow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1688052229; x=1688138629; bh=bstP08gdPaA9jQIillnZupFeM7RDuOMuY91
        d+Y8sUsM=; b=WsncIff/4+uQHWCE+kDFSvnqjigM4+1onB4xer0zvU89i48Y9wj
        dI6aBCsm7w8iDVNU4xhi6cI8Fel1xOYHfc8Mryz+U+PA8uT0ZTvboBSFh5vwhP5W
        9NkVvwQYdzXpOIe/N2dIZcrYTBHQntu/53rJtSmDBTtbtzWGA6nyavxiqTK8oQRi
        0WlqxGNiqNUR8xh5LIkf/ErLToNm77XDWE1drecaTSCEluzxhihZ7KSStio5Hmuq
        0nCE8FM7AbCjdjRONT+X6ZDVb5EOixmy3xu4ioycXsNMeTRcbx0Bn0TNRmAjtPPK
        +IPVtq7PmeP3F4UWK4F0w+Xsgs/o1O3FJ/A==
X-ME-Sender: <xms:BaKdZKhPz1mAM2c3dk_Ya4Eimq7938Noj6gMCiZ0lRHpFRUtnWs6OA>
    <xme:BaKdZLD2q-XLkTecC7D_ja87XeNyHi9OJZ5BWa8g9IOSRWPBYK-xhEBipP1nGc_rt
    bYtn8bOlpq0Th3vNMA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrtdeggdekkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepgfekhfehtedvtefhjeekiefghedtffeiveeffeetffetjeffheelhfdtueev
    jeeunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpghhithhhuhgsrdgtohhmnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegr
    rhhnuggsrdguvg
X-ME-Proxy: <xmx:BaKdZCGBekuKVId1R_1g5EGUacpExtQigRGdR6131yoXl5it7bSlow>
    <xmx:BaKdZDQNfCDPVb5GVOZOHb7vN5iBfQZMyDfnO_3ofv0HnbbaNEfAJw>
    <xmx:BaKdZHwb4sg_vcsrL0spT1imVW9SlU-yW89NzWZ_4UbE0JyDGMQFDQ>
    <xmx:BaKdZAoLDIwSats86SoHx8Kq2ZtBnreVtYO8HpQeDoxH0KGusgSx0g>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id F0FDFB60086; Thu, 29 Jun 2023 11:23:48 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-499-gf27bbf33e2-fm-20230619.001-gf27bbf33
Mime-Version: 1.0
Message-Id: <7393ae1d-66a3-40a3-adcb-347c0fafa6a6@app.fastmail.com>
In-Reply-To: <80fba92e-3836-4d27-8be6-1e5f7b5b2f53@app.fastmail.com>
References: <80fba92e-3836-4d27-8be6-1e5f7b5b2f53@app.fastmail.com>
Date:   Thu, 29 Jun 2023 17:23:28 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Linus Torvalds" <torvalds@linux-foundation.org>
Cc:     soc@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL 5/5] ARM: SoC changes for 6.5
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 44c026a73be8038f03dbdeef028b642880cf1=
511:

  Linux 6.4-rc3 (2023-05-21 14:05:48 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-a=
rm-6.5

for you to fetch changes up to c1d57ee6eb99699f5ccd92fc6e8c5a79103dcaae:

  ARM: omap2: Fix copy/paste bug (2023-06-22 17:30:09 +0200)

----------------------------------------------------------------
ARM: SoC changes for 6.5

These are mostly minor cleanups and bugfixes that address harmless
problems.

The largest branch is a conversion of the omap platform
to use GPIO descriptors throughout the tree, for any devices that
are not fully converted to devicetree.

The Samsung Exynos platform gains back support for the Exynos4212
chip that was previously unused and removed but is now used for
the Samsung Galaxy Tab3.

----------------------------------------------------------------
Arnd Bergmann (17):
      ARM: davinci: fix davinci_cpufreq_init() declaration
      ARM: ep93xx: fix missing-prototype warnings
      ARM: highbank: add missing include
      ARM: imx: add missing include
      ARM: lpc32xx: add missing include
      ARM: omap1: add missing include
      ARM: omap2: fix missing tick_broadcast() prototype
      ARM: orion5x: fix d2net gpio initialization
      ARM: pxa: fix missing-prototypes warnings
      ARM: sa1100: address missing prototype warnings
      ARM: spear: include "pl080.h" for pl080_get_signal() prototype
      ARM: versatile: mark mmc_status() static
      Merge tag 'gpio-omap-descriptors-v6.5' of git://git.kernel.org/pub=
/scm/linux/kernel/git/linusw/linux-gpio into soc/arm
      Merge tag 'omap-for-v6.5/cleanup-signed' of git://git.kernel.org/p=
ub/scm/linux/kernel/git/tmlind/linux-omap into soc/arm
      Merge tag 'samsung-soc-6.5' of https://git.kernel.org/pub/scm/linu=
x/kernel/git/krzk/linux into soc/arm
      Input: ads7846 - fix pointer cast warning
      Merge tag 'arm-soc/for-6.5/maintainers' of https://github.com/Broa=
dcom/stblinux into soc/arm

Artur Weber (1):
      ARM: exynos: Re-introduce Exynos4212 support

Florian Fainelli (1):
      MAINTAINERS: Replace my email address

Franziska Naepelt (2):
      ARM: omap: Fix checkpatch issues
      ARM: omap2: Fix checkpatch issues

Justin Chen (1):
      MAINTAINERS: Replace my email address

Kamal Dasu (1):
      MAINTAINERS: Replace my email address

Linus Walleij (15):
      ARM/mfd/gpio: Fixup TPS65010 regression on OMAP1 OSK1
      ARM: omap1: Drop header on AMS Delta
      ARM: omap1: Remove reliance on GPIO numbers from PalmTE
      ARM: omap1: Remove reliance on GPIO numbers from SX1
      Input: ads7846 - Convert to use software nodes
      ARM/mmc: Convert old mmci-omap to GPIO descriptors
      ARM: omap1: Fix up the Nokia 770 board device IRQs
      ARM: omap1: Make serial wakeup GPIOs use descriptors
      ARM: omap1: Exorcise the legacy GPIO header
      ARM/gpio: Push OMAP2 quirk down into TWL4030 driver
      ARM: omap2: Get USB hub reset GPIO from descriptor
      ARM: omap2: Rewrite WLAN quirk to use GPIO descriptors
      ARM/musb: omap2: Remove global GPIO numbers from TUSB6010
      Input: ads7846 - Fix usage of match data
      ARM: omap2: Fix copy/paste bug

Lukas Bulwahn (1):
      ARM: s3c: remove obsolete config S3C64XX_SETUP_IDE

Prathu Baronia (1):
      arm: omap1: replace printk() with pr_err macro

Uwe Kleine-K=C3=B6nig (1):
      ARM: s3c: Switch i2c drivers back to use .probe()

 MAINTAINERS                                   |  42 +++---
 arch/arm/common/sa1111.c                      |   2 +-
 arch/arm/mach-davinci/common.c                |   1 +
 arch/arm/mach-davinci/common.h                |   6 -
 arch/arm/mach-ep93xx/timer-ep93xx.c           |   3 +-
 arch/arm/mach-exynos/Kconfig                  |   5 +
 arch/arm/mach-exynos/common.h                 |   8 +
 arch/arm/mach-exynos/exynos.c                 |   2 +
 arch/arm/mach-exynos/firmware.c               |   8 +-
 arch/arm/mach-exynos/pm.c                     |   2 +-
 arch/arm/mach-exynos/suspend.c                |   4 +
 arch/arm/mach-highbank/pm.c                   |   2 +
 arch/arm/mach-imx/pm-imx25.c                  |   1 +
 arch/arm/mach-lpc32xx/serial.c                |   1 +
 arch/arm/mach-omap1/board-ams-delta.c         |   1 -
 arch/arm/mach-omap1/board-nokia770.c          | 207 ++++++++++++++++---=
-------
 arch/arm/mach-omap1/board-osk.c               | 146 ++++++++++++------
 arch/arm/mach-omap1/board-palmte.c            |  51 ++++---
 arch/arm/mach-omap1/board-sx1-mmc.c           |   1 -
 arch/arm/mach-omap1/board-sx1.c               |  40 ++++-
 arch/arm/mach-omap1/devices.c                 |   1 -
 arch/arm/mach-omap1/gpio15xx.c                |   1 -
 arch/arm/mach-omap1/gpio16xx.c                |   1 -
 arch/arm/mach-omap1/irq.c                     |   1 -
 arch/arm/mach-omap1/pm.c                      |   2 +-
 arch/arm/mach-omap1/serial.c                  |  31 ++--
 arch/arm/mach-omap1/sram-init.c               |   2 +-
 arch/arm/mach-omap2/board-generic.c           |   1 +
 arch/arm/mach-omap2/board-n8x0.c              | 156 ++++++-------------
 arch/arm/mach-omap2/omap-wakeupgen.c          |   1 +
 arch/arm/mach-omap2/omap_device.c             |   1 -
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c    |  11 +-
 arch/arm/mach-omap2/omap_phy_internal.c       |  12 +-
 arch/arm/mach-omap2/pdata-quirks.c            | 132 ++++++++--------
 arch/arm/mach-omap2/sdrc2xxx.c                |   2 -
 arch/arm/mach-omap2/sram.c                    |   4 +-
 arch/arm/mach-omap2/ti81xx-restart.c          |   3 +-
 arch/arm/mach-omap2/usb-tusb6010.c            |  20 +--
 arch/arm/mach-omap2/usb-tusb6010.h            |  12 ++
 arch/arm/mach-orion5x/board-dt.c              |   3 +
 arch/arm/mach-orion5x/common.h                |   6 +
 arch/arm/mach-pxa/generic.h                   |  15 --
 arch/arm/mach-pxa/mfp-pxa2xx.c                |   1 +
 arch/arm/mach-pxa/pxa25x.c                    |   1 +
 arch/arm/mach-pxa/pxa27x.c                    |   3 +
 arch/arm/mach-pxa/reset.c                     |   1 +
 arch/arm/mach-pxa/spitz.c                     |  11 +-
 arch/arm/mach-pxa/spitz_pm.c                  |   2 +-
 arch/arm/mach-s3c/Kconfig.s3c64xx             |   6 -
 arch/arm/mach-s3c/mach-crag6410-module.c      |   2 +-
 arch/arm/mach-sa1100/assabet.c                |   2 +-
 arch/arm/mach-sa1100/pm.c                     |   2 +
 arch/arm/mach-spear/pl080.c                   |   1 +
 arch/arm/mach-versatile/versatile.c           |   2 +-
 arch/mips/alchemy/devboards/db1000.c          |  11 +-
 drivers/clk/pxa/clk-pxa25x.c                  |   2 +
 drivers/clk/pxa/clk-pxa27x.c                  |   3 +-
 drivers/gpio/gpio-twl4030.c                   |  52 +++++--
 drivers/hwmon/max1111.c                       |   1 +
 drivers/input/touchscreen/ads7846.c           | 114 +++++---------
 drivers/mfd/tps65010.c                        |  14 +-
 drivers/mmc/host/omap.c                       |  46 +++++-
 drivers/usb/gadget/udc/pxa27x_udc.c           |   6 -
 drivers/usb/host/ohci-pxa27x.c                |   7 +-
 drivers/usb/musb/musb_core.c                  |   1 -
 drivers/usb/musb/musb_core.h                  |   2 -
 drivers/usb/musb/tusb6010.c                   |  53 +++++--
 drivers/video/fbdev/omap/lcd_mipid.c          |  10 ++
 include/linux/mfd/tps65010.h                  |  11 +-
 include/linux/mfd/twl.h                       |   3 -
 include/linux/platform_data/asoc-pxa.h        |   1 +
 include/linux/platform_data/davinci-cpufreq.h |   6 +
 include/linux/platform_data/lcd-mipid.h       |   2 -
 include/linux/platform_data/mmc-omap.h        |   2 -
 include/linux/platform_data/pxa2xx_udc.h      |   6 +
 include/linux/soc/pxa/smemc.h                 |  16 ++
 include/linux/spi/ads7846.h                   |   2 -
 include/linux/usb/musb.h                      |  13 --
 sound/arm/pxa2xx-ac97-lib.c                   |   2 -
 79 files changed, 766 insertions(+), 605 deletions(-)
 create mode 100644 arch/arm/mach-omap2/usb-tusb6010.h
