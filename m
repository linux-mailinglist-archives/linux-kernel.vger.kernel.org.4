Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 915126F2B63
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 00:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbjD3WgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Apr 2023 18:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjD3WgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Apr 2023 18:36:19 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC092197;
        Sun, 30 Apr 2023 15:36:16 -0700 (PDT)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id ED5A01BF203;
        Sun, 30 Apr 2023 22:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1682894175;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=f2ThtBXPrm6crhdTz0zQVJ3bF8A3FmajM0999On8F8Q=;
        b=T/4djMvPFBG/mBKlB2Eu8HPdVMKzeWzTZbmzAU/g21fBG4h1nMmYNm3lDhwJBa3EZWydC0
        H8XpC3sgUzKBeXXZkU2QQDrShk98Nt2WTjE2WiYkIH6/Fw3ClHbEg+S0q/JlB/Mp55GOmb
        kN58TtnUR247rsicS2jC/nuS/JLGxOzRSO3N8dxCmjf/688msVr5jwxobG1IzREHUUgocV
        hzJShvhHTjibkep6puYNraqfQ8gtZOxRavEbwFCXOKgARoWk6o2cUMsBvO8Zs7yzHM7KNO
        WeBetc6UbR20BO+8Ck+GTHvA3hlccqxWKPHOLORNQxrQEwrhRt00VQyjnH9qjA==
Date:   Mon, 1 May 2023 00:36:14 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] RTC for 6.4
Message-ID: <20230430223614c48c29a6@mail.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

Here is the RTC subsystem pull request for 6.4. Not much this cycle,
there is the conversion to remove_new and many small fixes in drivers.

The following changes since commit fe15c26ee26efa11741a7b632e9f23b01aca4cc6:

  Linux 6.3-rc1 (2023-03-05 14:52:03 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/rtc-6.4

for you to fetch changes up to e99ab4abebf825de2ce65f6c6c32ee30e00bb077:

  rtc: armada38x: use devm_platform_ioremap_resource_byname() (2023-04-28 08:07:23 +0200)

----------------------------------------------------------------
RTC for 6.4

Subsystem:
 - Convert to platform remove callback returning void

Drivers:
 - meson-vrtc: fix a firmware display issue

----------------------------------------------------------------
Conor Dooley (1):
      rtc: mpfs: convert SOC_MICROCHIP_POLARFIRE to ARCH_MICROCHIP_POLARFIRE

Dhruva Gole (1):
      rtc: k3: handle errors while enabling wake irq

Javier Carrasco (2):
      rtc: pcf8523: fix coding-style issues
      rtc: pcf8523: remove unnecessary OR operation

Krzysztof Kozlowski (2):
      rtc: omap: include header for omap_rtc_power_off_program prototype
      rtc: ds1390: mark OF related data as maybe unused

Lars-Peter Clausen (1):
      rtc: jz4740: Make sure clock provider gets removed

Martin Blumenstingl (1):
      rtc: meson-vrtc: Use ktime_get_real_ts64() to get the current time

Rob Herring (2):
      rtc: sun6i: Use of_property_present() for testing DT property presence
      dt-bindings: rtc: Drop unneeded quotes

Uwe Kleine-König (41):
      rtc: 88pm80x: Convert to platform remove callback returning void
      rtc: 88pm860x: Convert to platform remove callback returning void
      rtc: ab8500: Convert to platform remove callback returning void
      rtc: ac100: Convert to platform remove callback returning void
      rtc: asm9260: Convert to platform remove callback returning void
      rtc: at91sam9: Convert to platform remove callback returning void
      rtc: brcmstb-waketimer: Convert to platform remove callback returning void
      rtc: cadence: Convert to platform remove callback returning void
      rtc: cmos: Convert to platform remove callback returning void
      rtc: cros-ec: Convert to platform remove callback returning void
      rtc: ds1685: Convert to platform remove callback returning void
      rtc: ftrtc010: Convert to platform remove callback returning void
      rtc: hid-sensor-time: Convert to platform remove callback returning void
      rtc: lpc24xx: Convert to platform remove callback returning void
      rtc: max77686: Convert to platform remove callback returning void
      rtc: mc13xxx: Convert to platform remove callback returning void
      rtc: mpc5121: Convert to platform remove callback returning void
      rtc: mpfs: Convert to platform remove callback returning void
      rtc: mt7622: Convert to platform remove callback returning void
      rtc: mxc_v2: Convert to platform remove callback returning void
      rtc: omap: Convert to platform remove callback returning void
      rtc: palmas: Convert to platform remove callback returning void
      rtc: pcf50633: Convert to platform remove callback returning void
      rtc: pic32: Convert to platform remove callback returning void
      rtc: pm8xxx: Convert to platform remove callback returning void
      rtc: rc5t583: Convert to platform remove callback returning void
      rtc: rtd119x: Convert to platform remove callback returning void
      rtc: rzn1: Convert to platform remove callback returning void
      rtc: s3c: Convert to platform remove callback returning void
      rtc: sa1100: Convert to platform remove callback returning void
      rtc: spear: Convert to platform remove callback returning void
      rtc: stm32: Convert to platform remove callback returning void
      rtc: stmp3xxx: Convert to platform remove callback returning void
      rtc: sunplus: Convert to platform remove callback returning void
      rtc: tegra: Convert to platform remove callback returning void
      rtc: tps6586x: Convert to platform remove callback returning void
      rtc: twl: Convert to platform remove callback returning void
      rtc: vt8500: Convert to platform remove callback returning void
      rtc: wm8350: Convert to platform remove callback returning void
      rtc: xgene: Convert to platform remove callback returning void
      rtc: zynqmp: Convert to platform remove callback returning void

Ye Xingchen (2):
      rtc: sunplus: use devm_platform_ioremap_resource_byname()
      rtc: armada38x: use devm_platform_ioremap_resource_byname()

 .../bindings/rtc/allwinner,sun4i-a10-rtc.yaml           |  2 +-
 .../bindings/rtc/allwinner,sun6i-a31-rtc.yaml           |  2 +-
 .../devicetree/bindings/rtc/atmel,at91rm9200-rtc.yaml   |  2 +-
 .../devicetree/bindings/rtc/atmel,at91sam9260-rtt.yaml  |  2 +-
 .../devicetree/bindings/rtc/brcm,brcmstb-waketimer.yaml |  2 +-
 .../devicetree/bindings/rtc/faraday,ftrtc010.yaml       |  4 ++--
 .../devicetree/bindings/rtc/microcrystal,rv3032.yaml    |  2 +-
 .../devicetree/bindings/rtc/mstar,msc313-rtc.yaml       |  2 +-
 .../devicetree/bindings/rtc/nuvoton,nct3018y.yaml       |  2 +-
 Documentation/devicetree/bindings/rtc/nxp,pcf2127.yaml  |  2 +-
 Documentation/devicetree/bindings/rtc/rtc-mxc.yaml      |  2 +-
 Documentation/devicetree/bindings/rtc/rtc-mxc_v2.yaml   |  2 +-
 Documentation/devicetree/bindings/rtc/sa1100-rtc.yaml   |  4 ++--
 Documentation/devicetree/bindings/rtc/st,stm32-rtc.yaml |  2 +-
 Documentation/devicetree/bindings/rtc/ti,k3-rtc.yaml    |  2 +-
 Documentation/devicetree/bindings/rtc/trivial-rtc.yaml  |  2 +-
 drivers/rtc/Kconfig                                     |  2 +-
 drivers/rtc/rtc-88pm80x.c                               |  5 ++---
 drivers/rtc/rtc-88pm860x.c                              |  6 ++----
 drivers/rtc/rtc-ab8500.c                                |  6 ++----
 drivers/rtc/rtc-ac100.c                                 |  6 ++----
 drivers/rtc/rtc-armada38x.c                             |  7 ++-----
 drivers/rtc/rtc-asm9260.c                               |  5 ++---
 drivers/rtc/rtc-at91sam9.c                              |  6 ++----
 drivers/rtc/rtc-brcmstb-waketimer.c                     |  6 ++----
 drivers/rtc/rtc-cadence.c                               |  6 ++----
 drivers/rtc/rtc-cmos.c                                  |  5 ++---
 drivers/rtc/rtc-cros-ec.c                               |  6 ++----
 drivers/rtc/rtc-ds1390.c                                |  2 +-
 drivers/rtc/rtc-ds1685.c                                |  6 ++----
 drivers/rtc/rtc-ftrtc010.c                              |  6 ++----
 drivers/rtc/rtc-hid-sensor-time.c                       |  6 ++----
 drivers/rtc/rtc-jz4740.c                                |  3 ++-
 drivers/rtc/rtc-lpc24xx.c                               |  6 ++----
 drivers/rtc/rtc-max77686.c                              |  6 ++----
 drivers/rtc/rtc-mc13xxx.c                               |  6 ++----
 drivers/rtc/rtc-meson-vrtc.c                            |  4 ++--
 drivers/rtc/rtc-mpc5121.c                               |  6 ++----
 drivers/rtc/rtc-mpfs.c                                  |  6 ++----
 drivers/rtc/rtc-mt7622.c                                |  6 ++----
 drivers/rtc/rtc-mxc_v2.c                                |  5 ++---
 drivers/rtc/rtc-omap.c                                  |  7 +++----
 drivers/rtc/rtc-palmas.c                                |  5 ++---
 drivers/rtc/rtc-pcf50633.c                              |  6 ++----
 drivers/rtc/rtc-pcf8523.c                               | 17 ++++++++---------
 drivers/rtc/rtc-pic32.c                                 |  6 ++----
 drivers/rtc/rtc-pm8xxx.c                                |  5 ++---
 drivers/rtc/rtc-rc5t583.c                               |  5 ++---
 drivers/rtc/rtc-rtd119x.c                               |  6 ++----
 drivers/rtc/rtc-rzn1.c                                  |  6 ++----
 drivers/rtc/rtc-s3c.c                                   |  6 ++----
 drivers/rtc/rtc-sa1100.c                                |  6 ++----
 drivers/rtc/rtc-spear.c                                 |  6 ++----
 drivers/rtc/rtc-stm32.c                                 |  6 ++----
 drivers/rtc/rtc-stmp3xxx.c                              |  8 +++-----
 drivers/rtc/rtc-sun6i.c                                 |  2 +-
 drivers/rtc/rtc-sunplus.c                               |  9 +++------
 drivers/rtc/rtc-tegra.c                                 |  6 ++----
 drivers/rtc/rtc-ti-k3.c                                 |  3 ++-
 drivers/rtc/rtc-tps6586x.c                              |  5 ++---
 drivers/rtc/rtc-twl.c                                   |  6 ++----
 drivers/rtc/rtc-vt8500.c                                |  6 ++----
 drivers/rtc/rtc-wm8350.c                                |  6 ++----
 drivers/rtc/rtc-xgene.c                                 |  5 ++---
 drivers/rtc/rtc-zynqmp.c                                |  6 ++----
 65 files changed, 122 insertions(+), 197 deletions(-)

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
