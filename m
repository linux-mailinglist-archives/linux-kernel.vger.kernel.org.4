Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6417469B1BB
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 18:25:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbjBQRZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 12:25:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjBQRZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 12:25:11 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1012F6EBA5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 09:25:07 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 7C0BA5C00A3;
        Fri, 17 Feb 2023 12:25:06 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Fri, 17 Feb 2023 12:25:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1676654706; x=1676741106; bh=FsUYKAGN1H
        XXqlMVQwq14An+fQXzBIbM7Slh/LmXecM=; b=Gj6xrpk9/BdCdegvrWGEBVEmiP
        oyS8VHMA27icxwNGw2BBfFTb5maxvvR84YORtDJl3EFLZd6cHsyEXPzeZ8BkeSne
        GzOn5VHUWJQQ7kmxmNIWsIseDQ4bRoaGx5LRPIVo4BPtu3Kn2n83hxFDhiUz6O46
        TJN0LxbK1A6bcXoG7FJl0Ncf9c2izJ4t6W6MGuIfcbr8tf6u3d7QaFKUbUZHUGka
        UJh7syRRIzuAUppmUHmGM5MQH5blmyss6PDRbrttdHIYACXcn1CxXvCS/5n3FUt+
        vzyTc6k6b9eer6bEQiADb1fvsKq8BiDw+EEauZK7eUPpl+re74K6xDIy2jfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1676654706; x=1676741106; bh=FsUYKAGN1HXXqlMVQwq14An+fQXz
        BIbM7Slh/LmXecM=; b=mF0LSEZobDvXkFpdNPqzjMHwGvOQ9N2DPG5p9oTSSN1w
        wsSpBCzEaXVXO2G/t/3mPGvbl+Y7JeEmNXfgYCsbkDsSFIXKhoFBLzXcNgRPiwbr
        BUUamBbwAn2gWDAFjMaQ40cxJUhSZXH/8TEbPpc24SMlmyvsAXIH/TX+P8gxpkwN
        Zfym49ow9SE/T4G5hHmRZkm8r0xvyn/U8/jo9VOUIjMPrZdc/G5zuh0VoOtjd+yH
        j86VpbfKDobiMFOw2En+GzQ0Vv6nbEKjBjgaOjsJx0fPd06ilXXWT0Km2DQW1QGA
        gaVrzq6KIG4dBmDoT5qvPgNd0KkIKrgfko20Wr6b0A==
X-ME-Sender: <xms:crjvYxbHEcC4egUzs9ILLjC5imi5u4ZDrsW-ZXFaIsG2AfnE49XnUA>
    <xme:crjvY4akraR6LJa8hEW1f_jyR9LKefgweSUFr0Fts_Fwv8vtLwknc8ryg8Jv2DQvT
    doIxd6h25rMM1YDcwA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudeiledgleejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepvefhffeltdegheeffffhtdegvdehjedtgfekueevgfduffettedtkeekueef
    hedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:crjvYz_Jp_YfCrW-vaGhNumRDuXmOxQvLG8PvKYiNdvHXY735McEdQ>
    <xmx:crjvY_q1NjFWKJ3vtFHOElNc28yJmWl65D8im3z0U6YSqO1iFfLGzA>
    <xmx:crjvY8rbheYs9HPI3_o7xaTLF8paklvf6HxTg5QuSx3RPQacnJlMAA>
    <xmx:crjvY5DGjAFtqiQbDHueLHZJOCc9SpuV3l9HJcalsrpbu1uxi76uvg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 3E94BB60086; Fri, 17 Feb 2023 12:25:06 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-156-g081acc5ed5-fm-20230206.001-g081acc5e
Mime-Version: 1.0
Message-Id: <93b43729-1d89-42d0-82f3-658a9d6a3c9c@app.fastmail.com>
In-Reply-To: <99179367-0d59-4938-b44c-ca9408ad784e@app.fastmail.com>
References: <99179367-0d59-4938-b44c-ca9408ad784e@app.fastmail.com>
Date:   Fri, 17 Feb 2023 18:24:34 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Linus Torvalds" <torvalds@linux-foundation.org>
Cc:     soc@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL 1/4] ARM: unused boardfile removal for 6.3
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 9d46ce57f4d1c626bb48170226ea5e35deb5877c:

  ARM: omap1: fix building gpio15xx (2023-01-10 23:05:33 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/arm-boardfile-remove-6.3

for you to fetch changes up to a1f925bc4fa899b3c0f2dcbc432d572c36e74e71:

  mmc: omap: drop TPS65010 dependency (2023-02-11 22:00:09 +0100)

----------------------------------------------------------------
ARM: unused boardfile removal for 6.3

This is a follow-up to the deprecation of most of the old-style board
files that was merged in linux-6.0, removing them for good.

This branch is almost exclusively dead code removal based on those
annotations. Some device driver removals went through separate subsystem
trees, but the majority is in the same branch, in order to better handle
dependencies between the patches and avoid breaking bisection.

Unfortunately that leads to merge conflicts against other changes in the
subsystem trees, but they should all be trivial to resolve by removing
the files.

See commit 7d0d3fa7339e ("Merge tag 'arm-boardfiles-6.0' of
git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc") for the
description of which machines were marked unused and are now removed. The
only removals that got postponed are Terastation WXL (mv78xx0) and
Jornada720 (StrongARM1100), which turned out to still have potential
users.

----------------------------------------------------------------
Arnd Bergmann (87):
      ARM: at91: remove stale MAINTAINER file entries
      ARM: cns3xxx: remove entire platform
      mmc: remove cns3xxx driver
      ARM: ep93xx: remove old board files
      ASoC: remove unused ep93xx files
      ARM: mv78xx0: un-deprecate Terastation WXL
      ARM: orion: remove unused board files
      ARM: orion5x: remove dsa_chip_data references
      ARM: iop32x: remove the platform
      gpio: remove iop driver
      ARM: footbridge: remove CATS
      ARM: omap1: remove unused board files
      ARM: omap1: remove osk-mistral add-on board support
      ARM: omap1: remove dead code
      ARM: omap1: merge omap1_map_io functions
      ARM: omap1: remove unused omapxxxx.h headers
      usb: phy: remove phy-isp1301-omap driver
      fbdev: omapfb: remove unused board support
      spi: remove omap 100K driver
      ARM: davinci: remove unused board support
      ARM: davinci: drop DAVINCI_DMxxx references
      ARM: davinci: clean up platform support
      clk: remove davinci dm3xx drivers
      input: remove davinci keyboard driver
      ASoC: remove unused davinci support
      irqchip: remove davinci aintc driver
      staging: media: remove davinci vpfe_capture driver
      media: davinci: remove vpbe support
      ARM: sa1100: un-deprecate jornada720
      ARM: sa1100: remove unused board files
      ARM: sa1100: remove irda references
      cpufreq: remove sa1100 driver
      ARM: mmp: select specific CPU implementation
      ARM: mmp: remove all board files
      ARM: mmp: remove custom sram code
      ARM: mmp: remove device definitions
      ARM: mmp: remove old PM support
      ARM: s3c: remove all s3c24xx support
      ARM: s3c: remove s3c24xx specific hacks
      ARM: s3c: remove most s3c64xx board support
      ARM: s3c: remove adc.c
      ARM: s3c: simplify platform code
      ARM: s3c: remove s3c6400 support
      power: remove s3c adc battery driver
      hwmon: remove s3c driver
      pata: remove samsung_cf driver
      mmc: remove s3cmci driver
      clk: remove s3c24xx driver
      clk: samsung: remove s3c24xx specific pll bits
      leds: remove s3c24xx driver
      usb: gadget: remove s3c24xx drivers
      dmaengine: remove s3c24xx driver
      cpufreq: remove s3c24xx drivers
      fbdev: remove s3c2410 framebuffer
      input: remove s3c24xx touchscreen driver
      pinctrl: remove s3c24xx driver
      spi: remove s3c24xx driver
      soc: s3c: remove pm-debug hack
      ASoC: samsung: remove unused drivers
      parport: remove ax88796 driver
      ARM: pxa: remove unused board files
      ARM: pxa: remove pxa93x support
      ARM: pxa: remove irda leftover
      ARM: pxa: remove unused pxa3xx-ulpi
      ARM: pxa: prune unused device support
      power: remove z2_battery driver
      power: remove tosa_battery driver
      ata: remove palmld pata driver
      input: remove pxa930_trkball driver
      input: remove pxa930_rotary keyboard driver
      input: remove zylonite touchscreen driver
      pcmcia: remove unused pxa/sa1100 drivers
      ASoC: pxa: remove unused board support
      power: remove pda_power supply driver
      rtc: remove v3020 driver
      mfd: remove toshiba tmio drivers
      mfd: remove ucb1400 support
      mmc: remove tmio_mmc driver
      fbdev: remove tmiofb driver
      fbdev: remove w100fb driver
      usb: remove ohci-tmio driver
      w1: remove ds1wm driver
      mfd: remove htc-pasic3 driver
      ARM: remove CONFIG_UNUSED_BOARD_FILES
      usb: ohci-omap: avoid unused-variable warning
      ARM: pxa: restore mfp-pxa320.h
      mmc: omap: drop TPS65010 dependency

Lukas Bulwahn (4):
      MAINTAINERS: update file entries after arm multi-platform rework and mach-pxa removal
      MAINTAINERS: adjust SAMSUNG SOC CLOCK DRIVERS after s3c24xx support removal
      ARM: s3c: remove obsolete s3c-cpu-freq header
      ARM: debug: remove references in DEBUG_UART_8250_SHIFT to removed configs

 Documentation/admin-guide/media/davinci-vpbe.rst   |   65 -
 .../admin-guide/media/platform-cardlist.rst        |    1 -
 Documentation/admin-guide/media/v4l-drivers.rst    |    1 -
 Documentation/arm/index.rst                        |    1 -
 Documentation/arm/samsung-s3c24xx/cpufreq.rst      |   77 -
 Documentation/arm/samsung-s3c24xx/eb2410itx.rst    |   59 -
 Documentation/arm/samsung-s3c24xx/gpio.rst         |  172 --
 Documentation/arm/samsung-s3c24xx/h1940.rst        |   41 -
 Documentation/arm/samsung-s3c24xx/index.rst        |   20 -
 Documentation/arm/samsung-s3c24xx/nand.rst         |   30 -
 Documentation/arm/samsung-s3c24xx/overview.rst     |  311 ---
 Documentation/arm/samsung-s3c24xx/s3c2412.rst      |  121 --
 Documentation/arm/samsung-s3c24xx/s3c2413.rst      |   22 -
 Documentation/arm/samsung-s3c24xx/smdk2440.rst     |   57 -
 Documentation/arm/samsung-s3c24xx/suspend.rst      |  137 --
 Documentation/arm/samsung-s3c24xx/usb-host.rst     |   91 -
 Documentation/arm/samsung/gpio.rst                 |    8 -
 Documentation/arm/samsung/overview.rst             |   13 -
 .../bindings/clock/samsung,s3c2410-clock.txt       |   49 -
 .../bindings/clock/samsung,s3c2412-clock.txt       |   49 -
 .../bindings/clock/samsung,s3c2443-clock.txt       |   55 -
 .../interrupt-controller/samsung,s3c24xx-irq.txt   |   53 -
 .../devicetree/bindings/mmc/samsung,s3cmci.txt     |   42 -
 .../media/drivers/davinci-vpbe-devel.rst           |   39 -
 Documentation/driver-api/media/drivers/index.rst   |    1 -
 Documentation/power/power_supply_class.rst         |    4 +-
 Documentation/userspace-api/ioctl/ioctl-number.rst |    1 -
 MAINTAINERS                                        |  199 +-
 arch/arm/Kconfig                                   |   26 +-
 arch/arm/Kconfig.debug                             |  129 +-
 arch/arm/Makefile                                  |    4 -
 arch/arm/boot/compressed/head-sa1100.S             |    4 -
 arch/arm/boot/compressed/misc-ep93xx.h             |   13 +-
 arch/arm/boot/dts/Makefile                         |    2 -
 arch/arm/boot/dts/s3c2410-pinctrl.h                |   19 -
 arch/arm/boot/dts/s3c2416-pinctrl.dtsi             |  172 --
 arch/arm/boot/dts/s3c2416-smdk2416.dts             |   77 -
 arch/arm/boot/dts/s3c2416.dtsi                     |  124 --
 arch/arm/boot/dts/s3c24xx.dtsi                     |   92 -
 arch/arm/configs/badge4_defconfig                  |  105 --
 arch/arm/configs/cerfcube_defconfig                |   73 -
 arch/arm/configs/cm_x300_defconfig                 |  163 --
 arch/arm/configs/cns3420vb_defconfig               |   63 -
 arch/arm/configs/colibri_pxa270_defconfig          |  157 --
 arch/arm/configs/colibri_pxa300_defconfig          |   60 -
 arch/arm/configs/corgi_defconfig                   |  247 ---
 arch/arm/configs/eseries_pxa_defconfig             |   97 -
 arch/arm/configs/ezx_defconfig                     |  389 ----
 arch/arm/configs/h5000_defconfig                   |   74 -
 arch/arm/configs/hackkit_defconfig                 |   48 -
 arch/arm/configs/iop32x_defconfig                  |  126 --
 arch/arm/configs/jornada720_defconfig              |    1 -
 arch/arm/configs/lart_defconfig                    |   64 -
 arch/arm/configs/lpd270_defconfig                  |   58 -
 arch/arm/configs/lubbock_defconfig                 |   53 -
 arch/arm/configs/magician_defconfig                |  151 --
 arch/arm/configs/mainstone_defconfig               |   51 -
 arch/arm/configs/mini2440_defconfig                |  338 ----
 arch/arm/configs/mv78xx0_defconfig                 |    3 -
 arch/arm/configs/omap1_defconfig                   |    2 -
 arch/arm/configs/palmz72_defconfig                 |   75 -
 arch/arm/configs/pcm027_defconfig                  |   90 -
 arch/arm/configs/pleb_defconfig                    |   53 -
 arch/arm/configs/pxa168_defconfig                  |    3 -
 arch/arm/configs/pxa255-idp_defconfig              |   55 -
 arch/arm/configs/pxa910_defconfig                  |    2 -
 arch/arm/configs/pxa_defconfig                     |    3 -
 arch/arm/configs/s3c2410_defconfig                 |  437 -----
 arch/arm/configs/shannon_defconfig                 |   45 -
 arch/arm/configs/simpad_defconfig                  |  100 -
 arch/arm/configs/tct_hammer_defconfig              |   59 -
 arch/arm/configs/trizeps4_defconfig                |  207 --
 arch/arm/configs/viper_defconfig                   |  160 --
 arch/arm/configs/xcep_defconfig                    |   90 -
 arch/arm/configs/zeus_defconfig                    |  173 --
 arch/arm/include/debug/s3c24xx.S                   |   10 -
 arch/arm/kernel/entry-common.S                     |   15 -
 arch/arm/kernel/head.S                             |    2 +-
 arch/arm/mach-cns3xxx/Kconfig                      |   21 -
 arch/arm/mach-cns3xxx/Makefile                     |    6 -
 arch/arm/mach-cns3xxx/cns3420vb.c                  |  252 ---
 arch/arm/mach-cns3xxx/cns3xxx.h                    |  593 ------
 arch/arm/mach-cns3xxx/core.c                       |  410 ----
 arch/arm/mach-cns3xxx/core.h                       |   32 -
 arch/arm/mach-cns3xxx/devices.c                    |  108 --
 arch/arm/mach-cns3xxx/devices.h                    |   17 -
 arch/arm/mach-cns3xxx/pcie.c                       |  290 ---
 arch/arm/mach-cns3xxx/pm.c                         |  120 --
 arch/arm/mach-cns3xxx/pm.h                         |   20 -
 arch/arm/mach-davinci/Kconfig                      |  142 --
 arch/arm/mach-davinci/Makefile                     |   18 +-
 arch/arm/mach-davinci/asp.h                        |   57 -
 arch/arm/mach-davinci/board-da830-evm.c            |  690 -------
 arch/arm/mach-davinci/board-da850-evm.c            | 1550 ---------------
 arch/arm/mach-davinci/board-dm355-evm.c            |  444 -----
 arch/arm/mach-davinci/board-dm355-leopard.c        |  278 ---
 arch/arm/mach-davinci/board-dm365-evm.c            |  855 ---------
 arch/arm/mach-davinci/board-mityomapl138.c         |  638 -------
 arch/arm/mach-davinci/board-omapl138-hawk.c        |  451 -----
 arch/arm/mach-davinci/common.h                     |    7 +-
 arch/arm/mach-davinci/cputype.h                    |   53 -
 arch/arm/mach-davinci/da830.c                      |  274 ---
 arch/arm/mach-davinci/da850.c                      |  400 +---
 arch/arm/mach-davinci/da8xx.h                      |   95 +-
 arch/arm/mach-davinci/davinci.h                    |  136 --
 arch/arm/mach-davinci/devices-da8xx.c              | 1095 -----------
 arch/arm/mach-davinci/devices.c                    |  303 ---
 arch/arm/mach-davinci/dm355.c                      |  832 --------
 arch/arm/mach-davinci/dm365.c                      | 1094 -----------
 arch/arm/mach-davinci/irqs.h                       |  217 ---
 arch/arm/mach-davinci/mux.c                        |   15 -
 arch/arm/mach-davinci/mux.h                        |  315 ----
 arch/arm/mach-davinci/psc.h                        |   64 -
 arch/arm/mach-davinci/serial.c                     |   92 -
 arch/arm/mach-davinci/serial.h                     |   35 -
 arch/arm/mach-davinci/usb-da8xx.c                  |  146 --
 arch/arm/mach-davinci/usb.c                        |   87 -
 arch/arm/mach-dove/Kconfig                         |    8 -
 arch/arm/mach-dove/Makefile                        |    1 -
 arch/arm/mach-dove/dove-db-setup.c                 |  101 -
 arch/arm/mach-ep93xx/Kconfig                       |   63 -
 arch/arm/mach-ep93xx/Makefile                      |    5 -
 arch/arm/mach-ep93xx/adssphere.c                   |   41 -
 arch/arm/mach-ep93xx/gesbc9312.c                   |   41 -
 arch/arm/mach-ep93xx/micro9.c                      |  125 --
 arch/arm/mach-ep93xx/simone.c                      |  128 --
 arch/arm/mach-ep93xx/snappercl15.c                 |  162 --
 arch/arm/mach-footbridge/Kconfig                   |   12 -
 arch/arm/mach-footbridge/Makefile                  |    2 -
 arch/arm/mach-footbridge/cats-hw.c                 |   98 -
 arch/arm/mach-footbridge/cats-pci.c                |   64 -
 arch/arm/mach-footbridge/common.c                  |    3 -
 arch/arm/mach-iop32x/Kconfig                       |   54 -
 arch/arm/mach-iop32x/Makefile                      |   20 -
 arch/arm/mach-iop32x/adma.c                        |  163 --
 arch/arm/mach-iop32x/cp6.c                         |   48 -
 arch/arm/mach-iop32x/em7210.c                      |  232 ---
 arch/arm/mach-iop32x/glantank.c                    |  214 ---
 arch/arm/mach-iop32x/glantank.h                    |   12 -
 arch/arm/mach-iop32x/gpio-iop32x.h                 |   11 -
 arch/arm/mach-iop32x/hardware.h                    |   38 -
 arch/arm/mach-iop32x/i2c.c                         |   92 -
 arch/arm/mach-iop32x/iop3xx.h                      |  326 ----
 arch/arm/mach-iop32x/iq31244.c                     |  333 ----
 arch/arm/mach-iop32x/iq31244.h                     |   16 -
 arch/arm/mach-iop32x/iq80321.c                     |  192 --
 arch/arm/mach-iop32x/iq80321.h                     |   16 -
 arch/arm/mach-iop32x/irq.c                         |   95 -
 arch/arm/mach-iop32x/irqs.h                        |   48 -
 arch/arm/mach-iop32x/n2100.c                       |  367 ----
 arch/arm/mach-iop32x/n2100.h                       |   18 -
 arch/arm/mach-iop32x/pci.c                         |  404 ----
 arch/arm/mach-iop32x/pmu.c                         |   29 -
 arch/arm/mach-iop32x/restart.c                     |   17 -
 arch/arm/mach-iop32x/setup.c                       |   31 -
 arch/arm/mach-iop32x/time.c                        |  179 --
 arch/arm/mach-mmp/Kconfig                          |   96 -
 arch/arm/mach-mmp/Makefile                         |   21 +-
 arch/arm/mach-mmp/aspenite.c                       |  284 ---
 arch/arm/mach-mmp/avengers_lite.c                  |   55 -
 arch/arm/mach-mmp/brownstone.c                     |  237 ---
 arch/arm/mach-mmp/common.c                         |    5 -
 arch/arm/mach-mmp/common.h                         |    2 -
 arch/arm/mach-mmp/devices.c                        |  359 ----
 arch/arm/mach-mmp/devices.h                        |   57 -
 arch/arm/mach-mmp/flint.c                          |  131 --
 arch/arm/mach-mmp/gplugd.c                         |  206 --
 arch/arm/mach-mmp/irqs.h                           |  240 ---
 arch/arm/mach-mmp/jasper.c                         |  185 --
 arch/arm/mach-mmp/mfp-mmp2.h                       |  396 ----
 arch/arm/mach-mmp/mfp-pxa168.h                     |  355 ----
 arch/arm/mach-mmp/mfp-pxa910.h                     |  170 --
 arch/arm/mach-mmp/mfp.h                            |   35 -
 arch/arm/mach-mmp/mmp2.c                           |  175 --
 arch/arm/mach-mmp/mmp2.h                           |  104 -
 arch/arm/mach-mmp/pm-mmp2.c                        |  248 ---
 arch/arm/mach-mmp/pm-mmp2.h                        |   59 -
 arch/arm/mach-mmp/pm-pxa910.c                      |  272 ---
 arch/arm/mach-mmp/pm-pxa910.h                      |   75 -
 arch/arm/mach-mmp/pxa168.c                         |  175 --
 arch/arm/mach-mmp/pxa168.h                         |  139 --
 arch/arm/mach-mmp/pxa910.c                         |  190 --
 arch/arm/mach-mmp/pxa910.h                         |   90 -
 arch/arm/mach-mmp/regs-apbc.h                      |   19 -
 arch/arm/mach-mmp/regs-apmu.h                      |   28 -
 arch/arm/mach-mmp/regs-icu.h                       |   69 -
 arch/arm/mach-mmp/regs-timers.h                    |    5 -
 arch/arm/mach-mmp/regs-usb.h                       |  155 --
 arch/arm/mach-mmp/sram.c                           |  167 --
 arch/arm/mach-mmp/teton_bga.c                      |  100 -
 arch/arm/mach-mmp/teton_bga.h                      |   22 -
 arch/arm/mach-mmp/time.c                           |    9 +-
 arch/arm/mach-mmp/ttc_dkb.c                        |  315 ----
 arch/arm/mach-mv78xx0/Kconfig                      |   14 +-
 arch/arm/mach-mv78xx0/Makefile                     |    2 -
 arch/arm/mach-mv78xx0/db78x00-bp-setup.c           |  101 -
 arch/arm/mach-mv78xx0/rd78x00-masa-setup.c         |   86 -
 arch/arm/mach-omap1/Kconfig                        |   99 -
 arch/arm/mach-omap1/Makefile                       |   18 -
 arch/arm/mach-omap1/board-ams-delta.c              |    2 +-
 arch/arm/mach-omap1/board-fsample.c                |  366 ----
 arch/arm/mach-omap1/board-generic.c                |   85 -
 arch/arm/mach-omap1/board-h2-mmc.c                 |   74 -
 arch/arm/mach-omap1/board-h2.c                     |  448 -----
 arch/arm/mach-omap1/board-h2.h                     |   38 -
 arch/arm/mach-omap1/board-h3-mmc.c                 |   64 -
 arch/arm/mach-omap1/board-h3.c                     |  455 -----
 arch/arm/mach-omap1/board-h3.h                     |   35 -
 arch/arm/mach-omap1/board-htcherald.c              |  585 ------
 arch/arm/mach-omap1/board-innovator.c              |  481 -----
 arch/arm/mach-omap1/board-nand.c                   |   33 -
 arch/arm/mach-omap1/board-nokia770.c               |    2 +-
 arch/arm/mach-omap1/board-osk.c                    |  269 +--
 arch/arm/mach-omap1/board-palmte.c                 |    2 +-
 arch/arm/mach-omap1/board-palmtt.c                 |  285 ---
 arch/arm/mach-omap1/board-palmz71.c                |  300 ---
 arch/arm/mach-omap1/board-perseus2.c               |  333 ----
 arch/arm/mach-omap1/board-sx1.c                    |    2 +-
 arch/arm/mach-omap1/clock_data.c                   |   17 +-
 arch/arm/mach-omap1/common.h                       |   29 +-
 arch/arm/mach-omap1/devices.c                      |   59 +-
 arch/arm/mach-omap1/dma.c                          |   25 +-
 arch/arm/mach-omap1/fpga.c                         |  186 --
 arch/arm/mach-omap1/fpga.h                         |   49 -
 arch/arm/mach-omap1/gpio7xx.c                      |  272 ---
 arch/arm/mach-omap1/hardware.h                     |   48 +-
 arch/arm/mach-omap1/i2c.c                          |   14 +-
 arch/arm/mach-omap1/io.c                           |   84 +-
 arch/arm/mach-omap1/irq.c                          |   20 +-
 arch/arm/mach-omap1/irqs.h                         |    9 -
 arch/arm/mach-omap1/mcbsp.c                        |   76 -
 arch/arm/mach-omap1/mtd-xip.h                      |    4 -
 arch/arm/mach-omap1/mux.c                          |   52 -
 arch/arm/mach-omap1/omap1510.h                     |  162 --
 arch/arm/mach-omap1/omap16xx.h                     |  201 --
 arch/arm/mach-omap1/omap7xx.h                      |  106 --
 arch/arm/mach-omap1/pm.c                           |   76 +-
 arch/arm/mach-omap1/pm.h                           |   35 -
 arch/arm/mach-omap1/serial.c                       |   15 -
 arch/arm/mach-omap1/sleep.S                        |   80 -
 arch/arm/mach-omap1/sram-init.c                    |    7 +-
 arch/arm/mach-omap1/usb.c                          |   34 +-
 arch/arm/mach-orion5x/Kconfig                      |   59 -
 arch/arm/mach-orion5x/Makefile                     |    8 -
 arch/arm/mach-orion5x/common.c                     |   10 -
 arch/arm/mach-orion5x/common.h                     |    2 -
 arch/arm/mach-orion5x/db88f5281-setup.c            |  376 ----
 arch/arm/mach-orion5x/ls_hgl-setup.c               |  275 ---
 arch/arm/mach-orion5x/rd88f5181l-fxo-setup.c       |  172 --
 arch/arm/mach-orion5x/rd88f5181l-ge-setup.c        |  183 --
 arch/arm/mach-orion5x/rd88f5182-setup.c            |  288 ---
 arch/arm/mach-orion5x/rd88f6183ap-ge-setup.c       |  120 --
 arch/arm/mach-orion5x/wnr854t-setup.c              |  175 --
 arch/arm/mach-orion5x/wrt350n-v2-setup.c           |  263 ---
 arch/arm/mach-pxa/Kconfig                          |  571 +-----
 arch/arm/mach-pxa/Makefile                         |   59 +-
 arch/arm/mach-pxa/balloon3-pcmcia.c                |  137 --
 arch/arm/mach-pxa/balloon3.c                       |  821 --------
 arch/arm/mach-pxa/balloon3.h                       |  181 --
 arch/arm/mach-pxa/capc7117.c                       |  159 --
 arch/arm/mach-pxa/cm-x300.c                        |  883 ---------
 arch/arm/mach-pxa/colibri-evalboard.c              |  138 --
 arch/arm/mach-pxa/colibri-pcmcia.c                 |  165 --
 arch/arm/mach-pxa/colibri-pxa270-income.c          |  236 ---
 arch/arm/mach-pxa/colibri-pxa270.c                 |  330 ----
 arch/arm/mach-pxa/colibri-pxa300.c                 |  193 --
 arch/arm/mach-pxa/colibri-pxa320.c                 |  264 ---
 arch/arm/mach-pxa/colibri-pxa3xx.c                 |  147 --
 arch/arm/mach-pxa/colibri.h                        |   70 -
 arch/arm/mach-pxa/corgi.c                          |  826 --------
 arch/arm/mach-pxa/corgi.h                          |  110 --
 arch/arm/mach-pxa/corgi_pm.c                       |  221 ---
 arch/arm/mach-pxa/csb701.c                         |   67 -
 arch/arm/mach-pxa/csb726.c                         |  291 ---
 arch/arm/mach-pxa/csb726.h                         |   24 -
 arch/arm/mach-pxa/devices.c                        |  408 ----
 arch/arm/mach-pxa/devices.h                        |    2 -
 arch/arm/mach-pxa/e740-pcmcia.c                    |  127 --
 arch/arm/mach-pxa/eseries-gpio.h                   |   63 -
 arch/arm/mach-pxa/eseries-irq.h                    |   24 -
 arch/arm/mach-pxa/eseries.c                        | 1001 ----------
 arch/arm/mach-pxa/ezx.c                            | 1254 -------------
 arch/arm/mach-pxa/h5000.c                          |  210 ---
 arch/arm/mach-pxa/h5000.h                          |  109 --
 arch/arm/mach-pxa/himalaya.c                       |  166 --
 arch/arm/mach-pxa/hx4700-pcmcia.c                  |  118 --
 arch/arm/mach-pxa/hx4700.c                         |  942 ----------
 arch/arm/mach-pxa/hx4700.h                         |  129 --
 arch/arm/mach-pxa/icontrol.c                       |  218 ---
 arch/arm/mach-pxa/idp.c                            |  285 ---
 arch/arm/mach-pxa/idp.h                            |  195 --
 arch/arm/mach-pxa/littleton.c                      |  462 -----
 arch/arm/mach-pxa/littleton.h                      |   14 -
 arch/arm/mach-pxa/lpd270.c                         |  518 -----
 arch/arm/mach-pxa/lpd270.h                         |   40 -
 arch/arm/mach-pxa/lubbock.c                        |  649 -------
 arch/arm/mach-pxa/lubbock.h                        |   47 -
 arch/arm/mach-pxa/magician.c                       | 1112 -----------
 arch/arm/mach-pxa/magician.h                       |  125 --
 arch/arm/mach-pxa/mainstone.c                      |  738 --------
 arch/arm/mach-pxa/mainstone.h                      |  140 --
 arch/arm/mach-pxa/mfp-pxa25x.h                     |   33 -
 arch/arm/mach-pxa/mfp-pxa2xx.c                     |    4 -
 arch/arm/mach-pxa/mfp-pxa930.h                     |  495 -----
 arch/arm/mach-pxa/mioa701.c                        |  784 --------
 arch/arm/mach-pxa/mioa701.h                        |   76 -
 arch/arm/mach-pxa/mioa701_bootresume.S             |   38 -
 arch/arm/mach-pxa/mp900.c                          |  101 -
 arch/arm/mach-pxa/mxm8x10.c                        |  477 -----
 arch/arm/mach-pxa/mxm8x10.h                        |   22 -
 arch/arm/mach-pxa/palm27x.c                        |  473 -----
 arch/arm/mach-pxa/palm27x.h                        |   77 -
 arch/arm/mach-pxa/palmld-pcmcia.c                  |  111 --
 arch/arm/mach-pxa/palmld.c                         |  392 ----
 arch/arm/mach-pxa/palmld.h                         |  107 --
 arch/arm/mach-pxa/palmt5.c                         |  234 ---
 arch/arm/mach-pxa/palmt5.h                         |   82 -
 arch/arm/mach-pxa/palmtc-pcmcia.c                  |  162 --
 arch/arm/mach-pxa/palmtc.c                         |  539 ------
 arch/arm/mach-pxa/palmtc.h                         |   84 -
 arch/arm/mach-pxa/palmte2.c                        |  383 ----
 arch/arm/mach-pxa/palmte2.h                        |   64 -
 arch/arm/mach-pxa/palmtreo.c                       |  548 ------
 arch/arm/mach-pxa/palmtreo.h                       |   64 -
 arch/arm/mach-pxa/palmtx-pcmcia.c                  |  111 --
 arch/arm/mach-pxa/palmtx.c                         |  390 ----
 arch/arm/mach-pxa/palmtx.h                         |  110 --
 arch/arm/mach-pxa/palmz72.c                        |  319 ----
 arch/arm/mach-pxa/palmz72.h                        |   80 -
 arch/arm/mach-pxa/pcm027.c                         |  266 ---
 arch/arm/mach-pxa/pcm027.h                         |   73 -
 arch/arm/mach-pxa/pcm990-baseboard.c               |  408 ----
 arch/arm/mach-pxa/pcm990_baseboard.h               |  199 --
 arch/arm/mach-pxa/pm.c                             |    2 -
 arch/arm/mach-pxa/pm.h                             |   10 -
 arch/arm/mach-pxa/poodle.c                         |  484 -----
 arch/arm/mach-pxa/poodle.h                         |   92 -
 arch/arm/mach-pxa/pxa25x.c                         |    7 -
 arch/arm/mach-pxa/pxa27x.c                         |   18 +-
 arch/arm/mach-pxa/pxa27x.h                         |    3 -
 arch/arm/mach-pxa/pxa2xx.c                         |   29 -
 arch/arm/mach-pxa/pxa3xx-ulpi.c                    |  385 ----
 arch/arm/mach-pxa/pxa3xx.c                         |   89 -
 arch/arm/mach-pxa/pxa930.c                         |  217 ---
 arch/arm/mach-pxa/pxa930.h                         |    8 -
 arch/arm/mach-pxa/pxa_cplds_irqs.c                 |  200 --
 arch/arm/mach-pxa/regs-u2d.h                       |  199 --
 arch/arm/mach-pxa/regs-uart.h                      |  146 --
 arch/arm/mach-pxa/saar.c                           |  604 ------
 arch/arm/mach-pxa/sharpsl_pm.c                     |    4 -
 arch/arm/mach-pxa/spitz.c                          |   23 -
 arch/arm/mach-pxa/tavorevb.c                       |  506 -----
 arch/arm/mach-pxa/tosa-bt.c                        |  134 --
 arch/arm/mach-pxa/tosa.c                           |  946 ----------
 arch/arm/mach-pxa/tosa.h                           |  165 --
 arch/arm/mach-pxa/tosa_bt.h                        |   18 -
 arch/arm/mach-pxa/trizeps4-pcmcia.c                |  200 --
 arch/arm/mach-pxa/trizeps4.c                       |  575 ------
 arch/arm/mach-pxa/trizeps4.h                       |  166 --
 arch/arm/mach-pxa/viper-pcmcia.c                   |  180 --
 arch/arm/mach-pxa/viper-pcmcia.h                   |   12 -
 arch/arm/mach-pxa/viper.c                          | 1034 ----------
 arch/arm/mach-pxa/viper.h                          |   91 -
 arch/arm/mach-pxa/vpac270-pcmcia.c                 |  137 --
 arch/arm/mach-pxa/vpac270.c                        |  736 --------
 arch/arm/mach-pxa/vpac270.h                        |   38 -
 arch/arm/mach-pxa/xcep.c                           |  190 --
 arch/arm/mach-pxa/z2.c                             |  781 --------
 arch/arm/mach-pxa/z2.h                             |   37 -
 arch/arm/mach-pxa/zeus.c                           |  974 ----------
 arch/arm/mach-pxa/zeus.h                           |   82 -
 arch/arm/mach-pxa/zylonite.c                       |  495 -----
 arch/arm/mach-pxa/zylonite.h                       |   45 -
 arch/arm/mach-pxa/zylonite_pxa300.c                |  281 ---
 arch/arm/mach-pxa/zylonite_pxa320.c                |  213 ---
 arch/arm/mach-s3c/Kconfig                          |   92 +-
 arch/arm/mach-s3c/Kconfig.s3c24xx                  |  604 ------
 arch/arm/mach-s3c/Kconfig.s3c64xx                  |  210 ---
 arch/arm/mach-s3c/Makefile                         |   12 -
 arch/arm/mach-s3c/Makefile.s3c24xx                 |  102 -
 arch/arm/mach-s3c/Makefile.s3c64xx                 |   15 -
 arch/arm/mach-s3c/adc-core.h                       |   24 -
 arch/arm/mach-s3c/adc.c                            |  510 -----
 arch/arm/mach-s3c/anubis.h                         |   50 -
 arch/arm/mach-s3c/ata-core-s3c64xx.h               |   24 -
 arch/arm/mach-s3c/backlight-s3c64xx.h              |   22 -
 arch/arm/mach-s3c/bast-ide.c                       |   82 -
 arch/arm/mach-s3c/bast-irq.c                       |  137 --
 arch/arm/mach-s3c/bast.h                           |  194 --
 arch/arm/mach-s3c/common-smdk-s3c24xx.c            |  228 ---
 arch/arm/mach-s3c/common-smdk-s3c24xx.h            |   11 -
 arch/arm/mach-s3c/cpu.h                            |   47 -
 arch/arm/mach-s3c/cpufreq-utils-s3c24xx.c          |   94 -
 arch/arm/mach-s3c/dev-audio-s3c64xx.c              |  127 --
 arch/arm/mach-s3c/dev-backlight-s3c64xx.c          |  137 --
 arch/arm/mach-s3c/devs.c                           |  726 -------
 arch/arm/mach-s3c/devs.h                           |   37 -
 arch/arm/mach-s3c/dma-s3c24xx.h                    |   51 -
 arch/arm/mach-s3c/dma-s3c64xx.h                    |   57 -
 arch/arm/mach-s3c/dma.h                            |    9 -
 arch/arm/mach-s3c/fb-core-s3c24xx.h                |   24 -
 arch/arm/mach-s3c/gpio-cfg-helpers.h               |  124 --
 arch/arm/mach-s3c/gpio-cfg.h                       |   19 -
 arch/arm/mach-s3c/gpio-core.h                      |    3 -
 arch/arm/mach-s3c/gpio-samsung-s3c24xx.h           |  103 -
 arch/arm/mach-s3c/gpio-samsung.c                   |  443 +----
 arch/arm/mach-s3c/gpio-samsung.h                   |    7 -
 arch/arm/mach-s3c/gta02.h                          |   20 -
 arch/arm/mach-s3c/h1940-bluetooth.c                |  140 --
 arch/arm/mach-s3c/h1940.h                          |   52 -
 arch/arm/mach-s3c/hardware-s3c24xx.h               |   14 -
 arch/arm/mach-s3c/iic-core.h                       |    7 -
 arch/arm/mach-s3c/init.c                           |   26 +-
 arch/arm/mach-s3c/iotiming-s3c2410.c               |  472 -----
 arch/arm/mach-s3c/iotiming-s3c2412.c               |  278 ---
 arch/arm/mach-s3c/irq-pm-s3c24xx.c                 |  115 --
 arch/arm/mach-s3c/irq-s3c24xx-fiq-exports.c        |    9 -
 arch/arm/mach-s3c/irq-s3c24xx-fiq.S                |  112 --
 arch/arm/mach-s3c/irq-s3c24xx.c                    | 1352 -------------
 arch/arm/mach-s3c/irqs-s3c24xx.h                   |  219 ---
 arch/arm/mach-s3c/irqs.h                           |    7 -
 arch/arm/mach-s3c/mach-amlm5900.c                  |  248 ---
 arch/arm/mach-s3c/mach-anubis.c                    |  422 -----
 arch/arm/mach-s3c/mach-anw6410.c                   |  230 ---
 arch/arm/mach-s3c/mach-at2440evb.c                 |  233 ---
 arch/arm/mach-s3c/mach-bast.c                      |  583 ------
 arch/arm/mach-s3c/mach-crag6410.c                  |    1 -
 arch/arm/mach-s3c/mach-gta02.c                     |  588 ------
 arch/arm/mach-s3c/mach-h1940.c                     |  809 --------
 arch/arm/mach-s3c/mach-hmt.c                       |  282 ---
 arch/arm/mach-s3c/mach-jive.c                      |  693 -------
 arch/arm/mach-s3c/mach-mini2440.c                  |  804 --------
 arch/arm/mach-s3c/mach-mini6410.c                  |  365 ----
 arch/arm/mach-s3c/mach-n30.c                       |  682 -------
 arch/arm/mach-s3c/mach-ncp.c                       |  100 -
 arch/arm/mach-s3c/mach-nexcoder.c                  |  162 --
 arch/arm/mach-s3c/mach-osiris-dvs.c                |  178 --
 arch/arm/mach-s3c/mach-osiris.c                    |  405 ----
 arch/arm/mach-s3c/mach-otom.c                      |  124 --
 arch/arm/mach-s3c/mach-qt2410.c                    |  375 ----
 arch/arm/mach-s3c/mach-real6410.c                  |  333 ----
 arch/arm/mach-s3c/mach-rx1950.c                    |  884 ---------
 arch/arm/mach-s3c/mach-rx3715.c                    |  213 ---
 arch/arm/mach-s3c/mach-s3c2416-dt.c                |   48 -
 arch/arm/mach-s3c/mach-smartq.c                    |  424 -----
 arch/arm/mach-s3c/mach-smartq.h                    |   16 -
 arch/arm/mach-s3c/mach-smartq5.c                   |  154 --
 arch/arm/mach-s3c/mach-smartq7.c                   |  170 --
 arch/arm/mach-s3c/mach-smdk2410.c                  |  112 --
 arch/arm/mach-s3c/mach-smdk2413.c                  |  169 --
 arch/arm/mach-s3c/mach-smdk2416.c                  |  248 ---
 arch/arm/mach-s3c/mach-smdk2440.c                  |  180 --
 arch/arm/mach-s3c/mach-smdk2443.c                  |  126 --
 arch/arm/mach-s3c/mach-smdk6400.c                  |   90 -
 arch/arm/mach-s3c/mach-smdk6410.c                  |  706 -------
 arch/arm/mach-s3c/mach-tct_hammer.c                |  157 --
 arch/arm/mach-s3c/mach-vr1000.c                    |  364 ----
 arch/arm/mach-s3c/mach-vstms.c                     |  166 --
 arch/arm/mach-s3c/map-s3c.h                        |   37 -
 arch/arm/mach-s3c/map-s3c24xx.h                    |  159 --
 arch/arm/mach-s3c/map.h                            |    7 -
 arch/arm/mach-s3c/nand-core-s3c24xx.h              |   24 -
 arch/arm/mach-s3c/onenand-core-s3c64xx.h           |   32 -
 arch/arm/mach-s3c/osiris.h                         |   50 -
 arch/arm/mach-s3c/otom.h                           |   25 -
 arch/arm/mach-s3c/pll-s3c2410.c                    |   83 -
 arch/arm/mach-s3c/pll-s3c2440-12000000.c           |   95 -
 arch/arm/mach-s3c/pll-s3c2440-16934400.c           |  122 --
 arch/arm/mach-s3c/pm-core-s3c24xx.h                |   96 -
 arch/arm/mach-s3c/pm-core-s3c64xx.h                |   17 -
 arch/arm/mach-s3c/pm-core.h                        |    7 -
 arch/arm/mach-s3c/pm-h1940.S                       |   19 -
 arch/arm/mach-s3c/pm-s3c2410.c                     |  170 --
 arch/arm/mach-s3c/pm-s3c2412.c                     |  126 --
 arch/arm/mach-s3c/pm-s3c2416.c                     |   81 -
 arch/arm/mach-s3c/pm-s3c24xx.c                     |  121 --
 arch/arm/mach-s3c/pm-s3c64xx.c                     |   83 -
 arch/arm/mach-s3c/pm.c                             |    7 +-
 arch/arm/mach-s3c/pm.h                             |   12 -
 arch/arm/mach-s3c/regs-adc.h                       |   64 -
 arch/arm/mach-s3c/regs-clock-s3c24xx.h             |  146 --
 arch/arm/mach-s3c/regs-clock.h                     |    7 -
 arch/arm/mach-s3c/regs-dsc-s3c24xx.h               |   22 -
 arch/arm/mach-s3c/regs-gpio-s3c24xx.h              |  608 ------
 arch/arm/mach-s3c/regs-gpio.h                      |    7 -
 arch/arm/mach-s3c/regs-irq-s3c24xx.h               |   51 -
 arch/arm/mach-s3c/regs-irq.h                       |    7 -
 arch/arm/mach-s3c/regs-mem-s3c24xx.h               |   53 -
 arch/arm/mach-s3c/regs-s3c2443-clock.h             |  238 ---
 arch/arm/mach-s3c/regs-srom-s3c64xx.h              |   55 -
 arch/arm/mach-s3c/rtc-core-s3c24xx.h               |   23 -
 arch/arm/mach-s3c/s3c2410.c                        |  130 --
 arch/arm/mach-s3c/s3c2412-power.h                  |   34 -
 arch/arm/mach-s3c/s3c2412.c                        |  175 --
 arch/arm/mach-s3c/s3c2412.h                        |   25 -
 arch/arm/mach-s3c/s3c2416.c                        |  132 --
 arch/arm/mach-s3c/s3c2440.c                        |   71 -
 arch/arm/mach-s3c/s3c2442.c                        |   62 -
 arch/arm/mach-s3c/s3c2443.c                        |  112 --
 arch/arm/mach-s3c/s3c244x.c                        |  128 --
 arch/arm/mach-s3c/s3c24xx.c                        |  687 -------
 arch/arm/mach-s3c/s3c24xx.h                        |  124 --
 arch/arm/mach-s3c/s3c6400.c                        |   90 -
 arch/arm/mach-s3c/s3c6410.c                        |    9 -
 arch/arm/mach-s3c/s3c64xx.c                        |    8 -
 arch/arm/mach-s3c/sdhci.h                          |   25 -
 arch/arm/mach-s3c/setup-i2c-s3c24xx.c              |   23 -
 arch/arm/mach-s3c/setup-ide-s3c64xx.c              |   40 -
 arch/arm/mach-s3c/setup-sdhci-gpio-s3c24xx.c       |   31 -
 arch/arm/mach-s3c/setup-spi-s3c24xx.c              |   27 -
 arch/arm/mach-s3c/setup-ts-s3c24xx.c               |   29 -
 arch/arm/mach-s3c/simtec-audio.c                   |   76 -
 arch/arm/mach-s3c/simtec-nor.c                     |   74 -
 arch/arm/mach-s3c/simtec-pm.c                      |   60 -
 arch/arm/mach-s3c/simtec-usb.c                     |  125 --
 arch/arm/mach-s3c/simtec.h                         |   17 -
 arch/arm/mach-s3c/sleep-s3c2410.S                  |   54 -
 arch/arm/mach-s3c/sleep-s3c2412.S                  |   53 -
 arch/arm/mach-s3c/sleep-s3c24xx.S                  |   69 -
 arch/arm/mach-s3c/sleep-s3c64xx.S                  |   27 -
 arch/arm/mach-s3c/spi-core-s3c24xx.h               |   21 -
 arch/arm/mach-s3c/vr1000.h                         |  113 --
 arch/arm/mach-sa1100/Kconfig                       |  112 --
 arch/arm/mach-sa1100/Makefile                      |   21 -
 arch/arm/mach-sa1100/assabet.c                     |   34 -
 arch/arm/mach-sa1100/badge4.c                      |  338 ----
 arch/arm/mach-sa1100/cerf.c                        |  181 --
 arch/arm/mach-sa1100/collie.c                      |   33 -
 arch/arm/mach-sa1100/generic.c                     |   19 -
 arch/arm/mach-sa1100/generic.h                     |    3 -
 arch/arm/mach-sa1100/h3100.c                       |  140 --
 arch/arm/mach-sa1100/h3600.c                       |   38 -
 arch/arm/mach-sa1100/hackkit.c                     |  184 --
 arch/arm/mach-sa1100/include/mach/badge4.h         |   71 -
 arch/arm/mach-sa1100/include/mach/cerf.h           |   20 -
 arch/arm/mach-sa1100/include/mach/nanoengine.h     |   48 -
 arch/arm/mach-sa1100/include/mach/shannon.h        |   40 -
 arch/arm/mach-sa1100/include/mach/simpad.h         |  159 --
 arch/arm/mach-sa1100/lart.c                        |  177 --
 arch/arm/mach-sa1100/nanoengine.c                  |  136 --
 arch/arm/mach-sa1100/pci-nanoengine.c              |  191 --
 arch/arm/mach-sa1100/pleb.c                        |  148 --
 arch/arm/mach-sa1100/shannon.c                     |  157 --
 arch/arm/mach-sa1100/simpad.c                      |  423 -----
 arch/arm/mach-tegra/tegra.c                        |    1 -
 arch/arm/plat-orion/common.c                       |   31 -
 arch/arm/plat-orion/include/plat/common.h          |    3 -
 drivers/ata/Kconfig                                |   19 -
 drivers/ata/Makefile                               |    2 -
 drivers/ata/pata_palmld.c                          |  137 --
 drivers/ata/pata_samsung_cf.c                      |  662 -------
 drivers/clk/davinci/Makefile                       |    4 -
 drivers/clk/davinci/pll-dm355.c                    |   77 -
 drivers/clk/davinci/pll-dm365.c                    |  146 --
 drivers/clk/davinci/pll.c                          |    8 -
 drivers/clk/davinci/pll.h                          |    5 -
 drivers/clk/davinci/psc-dm355.c                    |   89 -
 drivers/clk/davinci/psc-dm365.c                    |  111 --
 drivers/clk/davinci/psc.c                          |    6 -
 drivers/clk/davinci/psc.h                          |    7 -
 drivers/clk/samsung/Kconfig                        |   32 -
 drivers/clk/samsung/Makefile                       |    4 -
 drivers/clk/samsung/clk-pll.c                      |  181 --
 drivers/clk/samsung/clk-pll.h                      |   21 -
 drivers/clk/samsung/clk-s3c2410-dclk.c             |  440 -----
 drivers/clk/samsung/clk-s3c2410.c                  |  446 -----
 drivers/clk/samsung/clk-s3c2412.c                  |  254 ---
 drivers/clk/samsung/clk-s3c2443.c                  |  438 -----
 drivers/clocksource/Kconfig                        |    2 +-
 drivers/cpufreq/Kconfig                            |    2 +-
 drivers/cpufreq/Kconfig.arm                        |   81 -
 drivers/cpufreq/Makefile                           |    7 -
 drivers/cpufreq/s3c2410-cpufreq.c                  |  155 --
 drivers/cpufreq/s3c2412-cpufreq.c                  |  240 ---
 drivers/cpufreq/s3c2416-cpufreq.c                  |  492 -----
 drivers/cpufreq/s3c2440-cpufreq.c                  |  321 ----
 drivers/cpufreq/s3c24xx-cpufreq-debugfs.c          |  163 --
 drivers/cpufreq/s3c24xx-cpufreq.c                  |  648 -------
 drivers/cpufreq/sa1100-cpufreq.c                   |  206 --
 drivers/cpufreq/sa1110-cpufreq.c                   |    6 -
 drivers/dma/Kconfig                                |   12 -
 drivers/dma/Makefile                               |    1 -
 drivers/dma/mmp_tdma.c                             |    7 +-
 drivers/dma/s3c24xx-dma.c                          | 1428 --------------
 drivers/gpio/Kconfig                               |   17 -
 drivers/gpio/Makefile                              |    2 -
 drivers/gpio/gpio-iop.c                            |   59 -
 drivers/gpio/gpio-ucb1400.c                        |   85 -
 drivers/hwmon/Kconfig                              |   17 -
 drivers/hwmon/Makefile                             |    1 -
 drivers/hwmon/s3c-hwmon.c                          |  379 ----
 drivers/i2c/busses/Kconfig                         |   11 +-
 drivers/i2c/busses/i2c-s3c2410.c                   |   72 -
 drivers/iio/adc/Kconfig                            |    6 +-
 drivers/input/keyboard/Kconfig                     |   19 -
 drivers/input/keyboard/Makefile                    |    2 -
 drivers/input/keyboard/davinci_keyscan.c           |  315 ----
 drivers/input/keyboard/pxa930_rotary.c             |  195 --
 drivers/input/mouse/Kconfig                        |    6 -
 drivers/input/mouse/Makefile                       |    1 -
 drivers/input/mouse/pxa930_trkball.c               |  250 ---
 drivers/input/touchscreen/Kconfig                  |   42 -
 drivers/input/touchscreen/Makefile                 |    3 -
 drivers/input/touchscreen/mainstone-wm97xx.c       |   10 -
 drivers/input/touchscreen/s3c2410_ts.c             |  464 -----
 drivers/input/touchscreen/ucb1400_ts.c             |  458 -----
 drivers/input/touchscreen/zylonite-wm97xx.c        |  220 ---
 drivers/irqchip/Kconfig                            |    5 -
 drivers/irqchip/Makefile                           |    1 -
 drivers/irqchip/irq-davinci-aintc.c                |  163 --
 drivers/leds/Kconfig                               |    8 -
 drivers/leds/Makefile                              |    1 -
 drivers/leds/leds-s3c24xx.c                        |   83 -
 drivers/media/platform/samsung/s3c-camif/Kconfig   |    8 +-
 drivers/media/platform/ti/davinci/Kconfig          |   16 -
 drivers/media/platform/ti/davinci/Makefile         |    3 -
 drivers/media/platform/ti/davinci/vpbe.c           |  840 ---------
 drivers/media/platform/ti/davinci/vpbe_display.c   | 1510 ---------------
 drivers/media/platform/ti/davinci/vpbe_osd.c       | 1582 ----------------
 drivers/media/platform/ti/davinci/vpbe_osd_regs.h  |  352 ----
 drivers/media/platform/ti/davinci/vpbe_venc.c      |  676 -------
 drivers/media/platform/ti/davinci/vpbe_venc_regs.h |  165 --
 drivers/media/platform/ti/davinci/vpss.c           |  529 ------
 drivers/mfd/Kconfig                                |   62 +-
 drivers/mfd/Makefile                               |    7 -
 drivers/mfd/asic3.c                                | 1071 -----------
 drivers/mfd/htc-pasic3.c                           |  210 ---
 drivers/mfd/t7l66xb.c                              |  427 -----
 drivers/mfd/tc6387xb.c                             |  228 ---
 drivers/mfd/tc6393xb.c                             |  907 ---------
 drivers/mfd/tmio_core.c                            |   70 -
 drivers/mfd/ucb1400_core.c                         |  158 --
 drivers/mmc/host/Kconfig                           |   68 +-
 drivers/mmc/host/Makefile                          |    3 -
 drivers/mmc/host/s3cmci.c                          | 1777 ------------------
 drivers/mmc/host/s3cmci.h                          |   75 -
 drivers/mmc/host/sdhci-cns3xxx.c                   |  113 --
 drivers/mmc/host/tmio_mmc.c                        |  227 ---
 drivers/mtd/nand/raw/Kconfig                       |    2 +-
 drivers/mtd/nand/raw/s3c2410.c                     |   60 -
 drivers/parport/Kconfig                            |   11 -
 drivers/parport/Makefile                           |    1 -
 drivers/parport/parport_ax88796.c                  |  418 -----
 drivers/pcmcia/Kconfig                             |   12 +-
 drivers/pcmcia/Makefile                            |    5 -
 drivers/pcmcia/pxa2xx_base.c                       |    8 +-
 drivers/pcmcia/pxa2xx_mainstone.c                  |  122 --
 drivers/pcmcia/sa1100_generic.c                    |    5 +-
 drivers/pcmcia/sa1100_h3600.c                      |    2 +-
 drivers/pcmcia/sa1100_simpad.c                     |  115 --
 drivers/pcmcia/sa1111_badge4.c                     |  158 --
 drivers/pcmcia/sa1111_generic.c                    |    8 -
 drivers/pcmcia/sa1111_lubbock.c                    |  155 --
 drivers/pinctrl/samsung/Kconfig                    |    5 -
 drivers/pinctrl/samsung/Makefile                   |    1 -
 drivers/pinctrl/samsung/pinctrl-s3c24xx.c          |  653 -------
 drivers/pinctrl/samsung/pinctrl-samsung.c          |   10 -
 drivers/power/supply/Kconfig                       |   28 -
 drivers/power/supply/Makefile                      |    4 -
 drivers/power/supply/ds2760_battery.c              |    8 -
 drivers/power/supply/pda_power.c                   |  520 -----
 drivers/power/supply/s3c_adc_battery.c             |  453 -----
 drivers/power/supply/tosa_battery.c                |  512 -----
 drivers/power/supply/z2_battery.c                  |  318 ----
 drivers/rtc/Kconfig                                |   17 +-
 drivers/rtc/Makefile                               |    1 -
 drivers/rtc/rtc-v3020.c                            |  369 ----
 drivers/soc/samsung/Kconfig                        |   26 +-
 drivers/soc/samsung/Makefile                       |    1 -
 drivers/soc/samsung/s3c-pm-debug.c                 |   79 -
 drivers/spi/Kconfig                                |   24 -
 drivers/spi/Makefile                               |    3 -
 drivers/spi/spi-omap-100k.c                        |  490 -----
 drivers/spi/spi-omap-uwire.c                       |   16 +-
 drivers/spi/spi-s3c24xx-regs.h                     |   41 -
 drivers/spi/spi-s3c24xx.c                          |  596 ------
 drivers/staging/media/Kconfig                      |    1 -
 drivers/staging/media/Makefile                     |    1 -
 .../staging/media/deprecated/vpfe_capture/Kconfig  |   58 -
 .../staging/media/deprecated/vpfe_capture/Makefile |    4 -
 drivers/staging/media/deprecated/vpfe_capture/TODO |    7 -
 .../media/deprecated/vpfe_capture/ccdc_hw_device.h |   80 -
 .../media/deprecated/vpfe_capture/dm355_ccdc.c     |  934 ---------
 .../media/deprecated/vpfe_capture/dm355_ccdc.h     |  308 ---
 .../deprecated/vpfe_capture/dm355_ccdc_regs.h      |  297 ---
 .../media/deprecated/vpfe_capture/dm644x_ccdc.c    |  879 ---------
 .../media/deprecated/vpfe_capture/dm644x_ccdc.h    |  171 --
 .../deprecated/vpfe_capture/dm644x_ccdc_regs.h     |  140 --
 .../staging/media/deprecated/vpfe_capture/isif.c   | 1127 -----------
 .../staging/media/deprecated/vpfe_capture/isif.h   |  518 -----
 .../media/deprecated/vpfe_capture/isif_regs.h      |  256 ---
 .../media/deprecated/vpfe_capture/vpfe_capture.c   | 1902 -------------------
 drivers/tty/serial/Kconfig                         |    8 +-
 drivers/tty/serial/samsung_tty.c                   |  199 --
 drivers/usb/gadget/udc/Kconfig                     |   26 -
 drivers/usb/gadget/udc/Makefile                    |    2 -
 drivers/usb/gadget/udc/omap_udc.c                  |   24 +-
 drivers/usb/gadget/udc/pxa25x_udc.c                |   62 -
 drivers/usb/gadget/udc/s3c-hsudc.c                 | 1319 -------------
 drivers/usb/gadget/udc/s3c2410_udc.c               | 1980 --------------------
 drivers/usb/gadget/udc/s3c2410_udc.h               |   99 -
 drivers/usb/gadget/udc/s3c2410_udc_regs.h          |  146 --
 drivers/usb/host/Kconfig                           |   32 +-
 drivers/usb/host/ohci-hcd.c                        |   18 -
 drivers/usb/host/ohci-omap.c                       |   14 +-
 drivers/usb/host/ohci-pxa27x.c                     |    9 -
 drivers/usb/host/ohci-sa1111.c                     |    5 +-
 drivers/usb/host/ohci-tmio.c                       |  364 ----
 drivers/usb/phy/Kconfig                            |   17 -
 drivers/usb/phy/Makefile                           |    1 -
 drivers/usb/phy/phy-isp1301-omap.c                 | 1639 ----------------
 drivers/video/backlight/locomolcd.c                |   10 -
 drivers/video/fbdev/Kconfig                        |   72 +-
 drivers/video/fbdev/Makefile                       |    3 -
 drivers/video/fbdev/omap/Kconfig                   |    9 -
 drivers/video/fbdev/omap/Makefile                  |    6 -
 drivers/video/fbdev/omap/lcd_h3.c                  |   82 -
 drivers/video/fbdev/omap/lcd_htcherald.c           |   59 -
 drivers/video/fbdev/omap/lcd_inn1510.c             |   69 -
 drivers/video/fbdev/omap/lcd_inn1610.c             |   99 -
 drivers/video/fbdev/omap/lcd_palmtt.c              |   65 -
 drivers/video/fbdev/omap/lcd_palmz71.c             |   59 -
 drivers/video/fbdev/omap/lcdc.c                    |    2 -
 drivers/video/fbdev/s3c2410fb-regs-lcd.h           |  143 --
 drivers/video/fbdev/s3c2410fb.c                    | 1142 -----------
 drivers/video/fbdev/s3c2410fb.h                    |   48 -
 drivers/video/fbdev/sa1100fb.c                     |    1 -
 drivers/video/fbdev/tmiofb.c                       | 1040 ----------
 drivers/video/fbdev/w100fb.c                       | 1644 ----------------
 drivers/video/fbdev/w100fb.h                       |  924 ---------
 drivers/w1/masters/Kconfig                         |    7 -
 drivers/w1/masters/Makefile                        |    1 -
 drivers/w1/masters/ds1wm.c                         |  675 -------
 drivers/watchdog/Kconfig                           |    9 +-
 drivers/watchdog/s3c2410_wdt.c                     |   84 +-
 drivers/watchdog/wdt285.c                          |    2 -
 include/dt-bindings/clock/s3c2410.h                |   59 -
 include/dt-bindings/clock/s3c2412.h                |   70 -
 include/dt-bindings/clock/s3c2443.h                |   91 -
 include/linux/amba/pl093.h                         |   77 -
 include/linux/clk/davinci.h                        |    9 -
 include/linux/clk/samsung.h                        |   32 -
 include/linux/mfd/asic3.h                          |  313 ----
 include/linux/mfd/htc-pasic3.h                     |   54 -
 include/linux/mfd/t7l66xb.h                        |   29 -
 include/linux/mfd/tc6387xb.h                       |   19 -
 include/linux/mfd/tc6393xb.h                       |   53 -
 include/linux/mfd/tmio.h                           |    5 -
 include/linux/parport.h                            |    5 -
 include/linux/pda_power.h                          |   39 -
 include/linux/platform_data/asoc-palm27x.h         |    9 -
 include/linux/platform_data/asoc-poodle.h          |   16 -
 include/linux/platform_data/asoc-s3c24xx_simtec.h  |   30 -
 include/linux/platform_data/ata-samsung_cf.h       |   31 -
 include/linux/platform_data/clk-s3c2410.h          |   19 -
 include/linux/platform_data/dma-mmp_tdma.h         |   36 -
 include/linux/platform_data/dma-s3c24xx.h          |   48 -
 include/linux/platform_data/fb-s3c2410.h           |   99 -
 include/linux/platform_data/irda-pxaficp.h         |   26 -
 include/linux/platform_data/irda-sa11x0.h          |   17 -
 .../linux/platform_data/keyboard-pxa930_rotary.h   |   21 -
 include/linux/platform_data/leds-omap.h            |   19 -
 include/linux/platform_data/leds-s3c24xx.h         |   18 -
 include/linux/platform_data/media/s5p_hdmi.h       |   32 -
 include/linux/platform_data/mmc-s3cmci.h           |   51 -
 include/linux/platform_data/mmp_audio.h            |   18 -
 include/linux/platform_data/mouse-pxa930_trkball.h |   11 -
 include/linux/platform_data/rtc-v3020.h            |   41 -
 include/linux/platform_data/s3c-hsudc.h            |   33 -
 include/linux/platform_data/usb-pxa3xx-ulpi.h      |   32 -
 include/linux/platform_data/usb-s3c2410_udc.h      |   33 -
 include/linux/s3c_adc_battery.h                    |   39 -
 include/linux/soc/mmp/cputype.h                    |   24 +-
 include/linux/soc/samsung/s3c-adc.h                |   32 -
 include/linux/soc/samsung/s3c-cpu-freq.h           |  145 --
 include/linux/soc/samsung/s3c-cpufreq-core.h       |  299 ---
 include/linux/soc/samsung/s3c-pm.h                 |   58 -
 include/linux/soc/ti/omap1-soc.h                   |   35 -
 include/linux/spi/s3c24xx-fiq.h                    |   33 -
 include/linux/spi/s3c24xx.h                        |   20 -
 include/linux/ucb1400.h                            |  160 --
 include/linux/z2_battery.h                         |   17 -
 include/media/davinci/vpbe.h                       |  184 --
 include/media/davinci/vpbe_display.h               |  122 --
 include/media/davinci/vpbe_osd.h                   |  382 ----
 include/media/davinci/vpbe_types.h                 |   74 -
 include/media/davinci/vpbe_venc.h                  |   37 -
 include/media/davinci/vpfe_capture.h               |  177 --
 include/media/davinci/vpss.h                       |  111 --
 include/sound/s3c24xx_uda134x.h                    |   14 -
 include/video/w100fb.h                             |  147 --
 sound/Kconfig                                      |    1 -
 sound/pci/ac97/ac97_codec.c                        |    1 -
 sound/pci/ac97/ac97_patch.c                        |   40 -
 sound/soc/cirrus/Kconfig                           |   23 -
 sound/soc/cirrus/Makefile                          |    6 -
 sound/soc/cirrus/ep93xx-ac97.c                     |  446 -----
 sound/soc/cirrus/simone.c                          |   86 -
 sound/soc/cirrus/snappercl15.c                     |  134 --
 sound/soc/pxa/Kconfig                              |  176 --
 sound/soc/pxa/Makefile                             |   33 -
 sound/soc/pxa/brownstone.c                         |  133 --
 sound/soc/pxa/corgi.c                              |  332 ----
 sound/soc/pxa/e740_wm9705.c                        |  168 --
 sound/soc/pxa/e750_wm9705.c                        |  147 --
 sound/soc/pxa/e800_wm9712.c                        |  147 --
 sound/soc/pxa/em-x270.c                            |   92 -
 sound/soc/pxa/hx4700.c                             |  207 --
 sound/soc/pxa/magician.c                           |  366 ----
 sound/soc/pxa/mioa701_wm9713.c                     |  201 --
 sound/soc/pxa/mmp-pcm.c                            |  267 ---
 sound/soc/pxa/palm27x.c                            |  162 --
 sound/soc/pxa/poodle.c                             |  291 ---
 sound/soc/pxa/tosa.c                               |  255 ---
 sound/soc/pxa/ttc-dkb.c                            |  143 --
 sound/soc/pxa/z2.c                                 |  218 ---
 sound/soc/pxa/zylonite.c                           |  266 ---
 sound/soc/samsung/Kconfig                          |   93 -
 sound/soc/samsung/Makefile                         |   26 -
 sound/soc/samsung/h1940_uda1380.c                  |  224 ---
 sound/soc/samsung/jive_wm8750.c                    |  143 --
 sound/soc/samsung/neo1973_wm8753.c                 |  360 ----
 sound/soc/samsung/regs-i2s-v2.h                    |  111 --
 sound/soc/samsung/regs-iis.h                       |   66 -
 sound/soc/samsung/rx1950_uda1380.c                 |  245 ---
 sound/soc/samsung/s3c-i2s-v2.c                     |  670 -------
 sound/soc/samsung/s3c-i2s-v2.h                     |  108 --
 sound/soc/samsung/s3c2412-i2s.c                    |  251 ---
 sound/soc/samsung/s3c2412-i2s.h                    |   22 -
 sound/soc/samsung/s3c24xx-i2s.c                    |  463 -----
 sound/soc/samsung/s3c24xx-i2s.h                    |   31 -
 sound/soc/samsung/s3c24xx_simtec.c                 |  372 ----
 sound/soc/samsung/s3c24xx_simtec.h                 |   18 -
 sound/soc/samsung/s3c24xx_simtec_hermes.c          |  112 --
 sound/soc/samsung/s3c24xx_simtec_tlv320aic23.c     |  100 -
 sound/soc/samsung/s3c24xx_uda134x.c                |  257 ---
 sound/soc/samsung/smartq_wm8987.c                  |  224 ---
 sound/soc/samsung/smdk_wm8580.c                    |  211 ---
 sound/soc/ti/Kconfig                               |   40 -
 sound/soc/ti/Makefile                              |    2 -
 sound/soc/ti/davinci-evm.c                         |  267 +--
 sound/soc/ti/davinci-vcif.c                        |  247 ---
 842 files changed, 203 insertions(+), 152624 deletions(-)
 delete mode 100644 Documentation/admin-guide/media/davinci-vpbe.rst
 delete mode 100644 Documentation/arm/samsung-s3c24xx/cpufreq.rst
 delete mode 100644 Documentation/arm/samsung-s3c24xx/eb2410itx.rst
 delete mode 100644 Documentation/arm/samsung-s3c24xx/gpio.rst
 delete mode 100644 Documentation/arm/samsung-s3c24xx/h1940.rst
 delete mode 100644 Documentation/arm/samsung-s3c24xx/index.rst
 delete mode 100644 Documentation/arm/samsung-s3c24xx/nand.rst
 delete mode 100644 Documentation/arm/samsung-s3c24xx/overview.rst
 delete mode 100644 Documentation/arm/samsung-s3c24xx/s3c2412.rst
 delete mode 100644 Documentation/arm/samsung-s3c24xx/s3c2413.rst
 delete mode 100644 Documentation/arm/samsung-s3c24xx/smdk2440.rst
 delete mode 100644 Documentation/arm/samsung-s3c24xx/suspend.rst
 delete mode 100644 Documentation/arm/samsung-s3c24xx/usb-host.rst
 delete mode 100644 Documentation/devicetree/bindings/clock/samsung,s3c2410-clock.txt
 delete mode 100644 Documentation/devicetree/bindings/clock/samsung,s3c2412-clock.txt
 delete mode 100644 Documentation/devicetree/bindings/clock/samsung,s3c2443-clock.txt
 delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/samsung,s3c24xx-irq.txt
 delete mode 100644 Documentation/devicetree/bindings/mmc/samsung,s3cmci.txt
 delete mode 100644 Documentation/driver-api/media/drivers/davinci-vpbe-devel.rst
 delete mode 100644 arch/arm/boot/dts/s3c2410-pinctrl.h
 delete mode 100644 arch/arm/boot/dts/s3c2416-pinctrl.dtsi
 delete mode 100644 arch/arm/boot/dts/s3c2416-smdk2416.dts
 delete mode 100644 arch/arm/boot/dts/s3c2416.dtsi
 delete mode 100644 arch/arm/boot/dts/s3c24xx.dtsi
 delete mode 100644 arch/arm/configs/badge4_defconfig
 delete mode 100644 arch/arm/configs/cerfcube_defconfig
 delete mode 100644 arch/arm/configs/cm_x300_defconfig
 delete mode 100644 arch/arm/configs/cns3420vb_defconfig
 delete mode 100644 arch/arm/configs/colibri_pxa270_defconfig
 delete mode 100644 arch/arm/configs/colibri_pxa300_defconfig
 delete mode 100644 arch/arm/configs/corgi_defconfig
 delete mode 100644 arch/arm/configs/eseries_pxa_defconfig
 delete mode 100644 arch/arm/configs/ezx_defconfig
 delete mode 100644 arch/arm/configs/h5000_defconfig
 delete mode 100644 arch/arm/configs/hackkit_defconfig
 delete mode 100644 arch/arm/configs/iop32x_defconfig
 delete mode 100644 arch/arm/configs/lart_defconfig
 delete mode 100644 arch/arm/configs/lpd270_defconfig
 delete mode 100644 arch/arm/configs/lubbock_defconfig
 delete mode 100644 arch/arm/configs/magician_defconfig
 delete mode 100644 arch/arm/configs/mainstone_defconfig
 delete mode 100644 arch/arm/configs/mini2440_defconfig
 delete mode 100644 arch/arm/configs/palmz72_defconfig
 delete mode 100644 arch/arm/configs/pcm027_defconfig
 delete mode 100644 arch/arm/configs/pleb_defconfig
 delete mode 100644 arch/arm/configs/pxa255-idp_defconfig
 delete mode 100644 arch/arm/configs/s3c2410_defconfig
 delete mode 100644 arch/arm/configs/shannon_defconfig
 delete mode 100644 arch/arm/configs/simpad_defconfig
 delete mode 100644 arch/arm/configs/tct_hammer_defconfig
 delete mode 100644 arch/arm/configs/trizeps4_defconfig
 delete mode 100644 arch/arm/configs/viper_defconfig
 delete mode 100644 arch/arm/configs/xcep_defconfig
 delete mode 100644 arch/arm/configs/zeus_defconfig
 delete mode 100644 arch/arm/mach-cns3xxx/Kconfig
 delete mode 100644 arch/arm/mach-cns3xxx/Makefile
 delete mode 100644 arch/arm/mach-cns3xxx/cns3420vb.c
 delete mode 100644 arch/arm/mach-cns3xxx/cns3xxx.h
 delete mode 100644 arch/arm/mach-cns3xxx/core.c
 delete mode 100644 arch/arm/mach-cns3xxx/core.h
 delete mode 100644 arch/arm/mach-cns3xxx/devices.c
 delete mode 100644 arch/arm/mach-cns3xxx/devices.h
 delete mode 100644 arch/arm/mach-cns3xxx/pcie.c
 delete mode 100644 arch/arm/mach-cns3xxx/pm.c
 delete mode 100644 arch/arm/mach-cns3xxx/pm.h
 delete mode 100644 arch/arm/mach-davinci/asp.h
 delete mode 100644 arch/arm/mach-davinci/board-da830-evm.c
 delete mode 100644 arch/arm/mach-davinci/board-da850-evm.c
 delete mode 100644 arch/arm/mach-davinci/board-dm355-evm.c
 delete mode 100644 arch/arm/mach-davinci/board-dm355-leopard.c
 delete mode 100644 arch/arm/mach-davinci/board-dm365-evm.c
 delete mode 100644 arch/arm/mach-davinci/board-mityomapl138.c
 delete mode 100644 arch/arm/mach-davinci/board-omapl138-hawk.c
 delete mode 100644 arch/arm/mach-davinci/davinci.h
 delete mode 100644 arch/arm/mach-davinci/devices.c
 delete mode 100644 arch/arm/mach-davinci/dm355.c
 delete mode 100644 arch/arm/mach-davinci/dm365.c
 delete mode 100644 arch/arm/mach-davinci/serial.c
 delete mode 100644 arch/arm/mach-davinci/serial.h
 delete mode 100644 arch/arm/mach-davinci/usb-da8xx.c
 delete mode 100644 arch/arm/mach-davinci/usb.c
 delete mode 100644 arch/arm/mach-dove/dove-db-setup.c
 delete mode 100644 arch/arm/mach-ep93xx/adssphere.c
 delete mode 100644 arch/arm/mach-ep93xx/gesbc9312.c
 delete mode 100644 arch/arm/mach-ep93xx/micro9.c
 delete mode 100644 arch/arm/mach-ep93xx/simone.c
 delete mode 100644 arch/arm/mach-ep93xx/snappercl15.c
 delete mode 100644 arch/arm/mach-footbridge/cats-hw.c
 delete mode 100644 arch/arm/mach-footbridge/cats-pci.c
 delete mode 100644 arch/arm/mach-iop32x/Kconfig
 delete mode 100644 arch/arm/mach-iop32x/Makefile
 delete mode 100644 arch/arm/mach-iop32x/adma.c
 delete mode 100644 arch/arm/mach-iop32x/cp6.c
 delete mode 100644 arch/arm/mach-iop32x/em7210.c
 delete mode 100644 arch/arm/mach-iop32x/glantank.c
 delete mode 100644 arch/arm/mach-iop32x/glantank.h
 delete mode 100644 arch/arm/mach-iop32x/gpio-iop32x.h
 delete mode 100644 arch/arm/mach-iop32x/hardware.h
 delete mode 100644 arch/arm/mach-iop32x/i2c.c
 delete mode 100644 arch/arm/mach-iop32x/iop3xx.h
 delete mode 100644 arch/arm/mach-iop32x/iq31244.c
 delete mode 100644 arch/arm/mach-iop32x/iq31244.h
 delete mode 100644 arch/arm/mach-iop32x/iq80321.c
 delete mode 100644 arch/arm/mach-iop32x/iq80321.h
 delete mode 100644 arch/arm/mach-iop32x/irq.c
 delete mode 100644 arch/arm/mach-iop32x/irqs.h
 delete mode 100644 arch/arm/mach-iop32x/n2100.c
 delete mode 100644 arch/arm/mach-iop32x/n2100.h
 delete mode 100644 arch/arm/mach-iop32x/pci.c
 delete mode 100644 arch/arm/mach-iop32x/pmu.c
 delete mode 100644 arch/arm/mach-iop32x/restart.c
 delete mode 100644 arch/arm/mach-iop32x/setup.c
 delete mode 100644 arch/arm/mach-iop32x/time.c
 delete mode 100644 arch/arm/mach-mmp/aspenite.c
 delete mode 100644 arch/arm/mach-mmp/avengers_lite.c
 delete mode 100644 arch/arm/mach-mmp/brownstone.c
 delete mode 100644 arch/arm/mach-mmp/devices.c
 delete mode 100644 arch/arm/mach-mmp/devices.h
 delete mode 100644 arch/arm/mach-mmp/flint.c
 delete mode 100644 arch/arm/mach-mmp/gplugd.c
 delete mode 100644 arch/arm/mach-mmp/irqs.h
 delete mode 100644 arch/arm/mach-mmp/jasper.c
 delete mode 100644 arch/arm/mach-mmp/mfp-mmp2.h
 delete mode 100644 arch/arm/mach-mmp/mfp-pxa168.h
 delete mode 100644 arch/arm/mach-mmp/mfp-pxa910.h
 delete mode 100644 arch/arm/mach-mmp/mfp.h
 delete mode 100644 arch/arm/mach-mmp/mmp2.c
 delete mode 100644 arch/arm/mach-mmp/mmp2.h
 delete mode 100644 arch/arm/mach-mmp/pm-mmp2.c
 delete mode 100644 arch/arm/mach-mmp/pm-mmp2.h
 delete mode 100644 arch/arm/mach-mmp/pm-pxa910.c
 delete mode 100644 arch/arm/mach-mmp/pm-pxa910.h
 delete mode 100644 arch/arm/mach-mmp/pxa168.c
 delete mode 100644 arch/arm/mach-mmp/pxa168.h
 delete mode 100644 arch/arm/mach-mmp/pxa910.c
 delete mode 100644 arch/arm/mach-mmp/pxa910.h
 delete mode 100644 arch/arm/mach-mmp/regs-apbc.h
 delete mode 100644 arch/arm/mach-mmp/regs-apmu.h
 delete mode 100644 arch/arm/mach-mmp/regs-icu.h
 delete mode 100644 arch/arm/mach-mmp/regs-usb.h
 delete mode 100644 arch/arm/mach-mmp/sram.c
 delete mode 100644 arch/arm/mach-mmp/teton_bga.c
 delete mode 100644 arch/arm/mach-mmp/teton_bga.h
 delete mode 100644 arch/arm/mach-mmp/ttc_dkb.c
 delete mode 100644 arch/arm/mach-mv78xx0/db78x00-bp-setup.c
 delete mode 100644 arch/arm/mach-mv78xx0/rd78x00-masa-setup.c
 delete mode 100644 arch/arm/mach-omap1/board-fsample.c
 delete mode 100644 arch/arm/mach-omap1/board-generic.c
 delete mode 100644 arch/arm/mach-omap1/board-h2-mmc.c
 delete mode 100644 arch/arm/mach-omap1/board-h2.c
 delete mode 100644 arch/arm/mach-omap1/board-h2.h
 delete mode 100644 arch/arm/mach-omap1/board-h3-mmc.c
 delete mode 100644 arch/arm/mach-omap1/board-h3.c
 delete mode 100644 arch/arm/mach-omap1/board-h3.h
 delete mode 100644 arch/arm/mach-omap1/board-htcherald.c
 delete mode 100644 arch/arm/mach-omap1/board-innovator.c
 delete mode 100644 arch/arm/mach-omap1/board-nand.c
 delete mode 100644 arch/arm/mach-omap1/board-palmtt.c
 delete mode 100644 arch/arm/mach-omap1/board-palmz71.c
 delete mode 100644 arch/arm/mach-omap1/board-perseus2.c
 delete mode 100644 arch/arm/mach-omap1/fpga.c
 delete mode 100644 arch/arm/mach-omap1/fpga.h
 delete mode 100644 arch/arm/mach-omap1/gpio7xx.c
 delete mode 100644 arch/arm/mach-omap1/omap1510.h
 delete mode 100644 arch/arm/mach-omap1/omap16xx.h
 delete mode 100644 arch/arm/mach-omap1/omap7xx.h
 delete mode 100644 arch/arm/mach-orion5x/db88f5281-setup.c
 delete mode 100644 arch/arm/mach-orion5x/ls_hgl-setup.c
 delete mode 100644 arch/arm/mach-orion5x/rd88f5181l-fxo-setup.c
 delete mode 100644 arch/arm/mach-orion5x/rd88f5181l-ge-setup.c
 delete mode 100644 arch/arm/mach-orion5x/rd88f5182-setup.c
 delete mode 100644 arch/arm/mach-orion5x/rd88f6183ap-ge-setup.c
 delete mode 100644 arch/arm/mach-orion5x/wnr854t-setup.c
 delete mode 100644 arch/arm/mach-orion5x/wrt350n-v2-setup.c
 delete mode 100644 arch/arm/mach-pxa/balloon3-pcmcia.c
 delete mode 100644 arch/arm/mach-pxa/balloon3.c
 delete mode 100644 arch/arm/mach-pxa/balloon3.h
 delete mode 100644 arch/arm/mach-pxa/capc7117.c
 delete mode 100644 arch/arm/mach-pxa/cm-x300.c
 delete mode 100644 arch/arm/mach-pxa/colibri-evalboard.c
 delete mode 100644 arch/arm/mach-pxa/colibri-pcmcia.c
 delete mode 100644 arch/arm/mach-pxa/colibri-pxa270-income.c
 delete mode 100644 arch/arm/mach-pxa/colibri-pxa270.c
 delete mode 100644 arch/arm/mach-pxa/colibri-pxa300.c
 delete mode 100644 arch/arm/mach-pxa/colibri-pxa320.c
 delete mode 100644 arch/arm/mach-pxa/colibri-pxa3xx.c
 delete mode 100644 arch/arm/mach-pxa/colibri.h
 delete mode 100644 arch/arm/mach-pxa/corgi.c
 delete mode 100644 arch/arm/mach-pxa/corgi.h
 delete mode 100644 arch/arm/mach-pxa/corgi_pm.c
 delete mode 100644 arch/arm/mach-pxa/csb701.c
 delete mode 100644 arch/arm/mach-pxa/csb726.c
 delete mode 100644 arch/arm/mach-pxa/csb726.h
 delete mode 100644 arch/arm/mach-pxa/e740-pcmcia.c
 delete mode 100644 arch/arm/mach-pxa/eseries-gpio.h
 delete mode 100644 arch/arm/mach-pxa/eseries-irq.h
 delete mode 100644 arch/arm/mach-pxa/eseries.c
 delete mode 100644 arch/arm/mach-pxa/ezx.c
 delete mode 100644 arch/arm/mach-pxa/h5000.c
 delete mode 100644 arch/arm/mach-pxa/h5000.h
 delete mode 100644 arch/arm/mach-pxa/himalaya.c
 delete mode 100644 arch/arm/mach-pxa/hx4700-pcmcia.c
 delete mode 100644 arch/arm/mach-pxa/hx4700.c
 delete mode 100644 arch/arm/mach-pxa/hx4700.h
 delete mode 100644 arch/arm/mach-pxa/icontrol.c
 delete mode 100644 arch/arm/mach-pxa/idp.c
 delete mode 100644 arch/arm/mach-pxa/idp.h
 delete mode 100644 arch/arm/mach-pxa/littleton.c
 delete mode 100644 arch/arm/mach-pxa/littleton.h
 delete mode 100644 arch/arm/mach-pxa/lpd270.c
 delete mode 100644 arch/arm/mach-pxa/lpd270.h
 delete mode 100644 arch/arm/mach-pxa/lubbock.c
 delete mode 100644 arch/arm/mach-pxa/lubbock.h
 delete mode 100644 arch/arm/mach-pxa/magician.c
 delete mode 100644 arch/arm/mach-pxa/magician.h
 delete mode 100644 arch/arm/mach-pxa/mainstone.c
 delete mode 100644 arch/arm/mach-pxa/mainstone.h
 delete mode 100644 arch/arm/mach-pxa/mfp-pxa930.h
 delete mode 100644 arch/arm/mach-pxa/mioa701.c
 delete mode 100644 arch/arm/mach-pxa/mioa701.h
 delete mode 100644 arch/arm/mach-pxa/mioa701_bootresume.S
 delete mode 100644 arch/arm/mach-pxa/mp900.c
 delete mode 100644 arch/arm/mach-pxa/mxm8x10.c
 delete mode 100644 arch/arm/mach-pxa/mxm8x10.h
 delete mode 100644 arch/arm/mach-pxa/palm27x.c
 delete mode 100644 arch/arm/mach-pxa/palm27x.h
 delete mode 100644 arch/arm/mach-pxa/palmld-pcmcia.c
 delete mode 100644 arch/arm/mach-pxa/palmld.c
 delete mode 100644 arch/arm/mach-pxa/palmld.h
 delete mode 100644 arch/arm/mach-pxa/palmt5.c
 delete mode 100644 arch/arm/mach-pxa/palmt5.h
 delete mode 100644 arch/arm/mach-pxa/palmtc-pcmcia.c
 delete mode 100644 arch/arm/mach-pxa/palmtc.c
 delete mode 100644 arch/arm/mach-pxa/palmtc.h
 delete mode 100644 arch/arm/mach-pxa/palmte2.c
 delete mode 100644 arch/arm/mach-pxa/palmte2.h
 delete mode 100644 arch/arm/mach-pxa/palmtreo.c
 delete mode 100644 arch/arm/mach-pxa/palmtreo.h
 delete mode 100644 arch/arm/mach-pxa/palmtx-pcmcia.c
 delete mode 100644 arch/arm/mach-pxa/palmtx.c
 delete mode 100644 arch/arm/mach-pxa/palmtx.h
 delete mode 100644 arch/arm/mach-pxa/palmz72.c
 delete mode 100644 arch/arm/mach-pxa/palmz72.h
 delete mode 100644 arch/arm/mach-pxa/pcm027.c
 delete mode 100644 arch/arm/mach-pxa/pcm027.h
 delete mode 100644 arch/arm/mach-pxa/pcm990-baseboard.c
 delete mode 100644 arch/arm/mach-pxa/pcm990_baseboard.h
 delete mode 100644 arch/arm/mach-pxa/poodle.c
 delete mode 100644 arch/arm/mach-pxa/poodle.h
 delete mode 100644 arch/arm/mach-pxa/pxa3xx-ulpi.c
 delete mode 100644 arch/arm/mach-pxa/pxa930.c
 delete mode 100644 arch/arm/mach-pxa/pxa930.h
 delete mode 100644 arch/arm/mach-pxa/pxa_cplds_irqs.c
 delete mode 100644 arch/arm/mach-pxa/regs-u2d.h
 delete mode 100644 arch/arm/mach-pxa/regs-uart.h
 delete mode 100644 arch/arm/mach-pxa/saar.c
 delete mode 100644 arch/arm/mach-pxa/tavorevb.c
 delete mode 100644 arch/arm/mach-pxa/tosa-bt.c
 delete mode 100644 arch/arm/mach-pxa/tosa.c
 delete mode 100644 arch/arm/mach-pxa/tosa.h
 delete mode 100644 arch/arm/mach-pxa/tosa_bt.h
 delete mode 100644 arch/arm/mach-pxa/trizeps4-pcmcia.c
 delete mode 100644 arch/arm/mach-pxa/trizeps4.c
 delete mode 100644 arch/arm/mach-pxa/trizeps4.h
 delete mode 100644 arch/arm/mach-pxa/viper-pcmcia.c
 delete mode 100644 arch/arm/mach-pxa/viper-pcmcia.h
 delete mode 100644 arch/arm/mach-pxa/viper.c
 delete mode 100644 arch/arm/mach-pxa/viper.h
 delete mode 100644 arch/arm/mach-pxa/vpac270-pcmcia.c
 delete mode 100644 arch/arm/mach-pxa/vpac270.c
 delete mode 100644 arch/arm/mach-pxa/vpac270.h
 delete mode 100644 arch/arm/mach-pxa/xcep.c
 delete mode 100644 arch/arm/mach-pxa/z2.c
 delete mode 100644 arch/arm/mach-pxa/z2.h
 delete mode 100644 arch/arm/mach-pxa/zeus.c
 delete mode 100644 arch/arm/mach-pxa/zeus.h
 delete mode 100644 arch/arm/mach-pxa/zylonite.c
 delete mode 100644 arch/arm/mach-pxa/zylonite.h
 delete mode 100644 arch/arm/mach-pxa/zylonite_pxa300.c
 delete mode 100644 arch/arm/mach-pxa/zylonite_pxa320.c
 delete mode 100644 arch/arm/mach-s3c/Kconfig.s3c24xx
 delete mode 100644 arch/arm/mach-s3c/Makefile.s3c24xx
 delete mode 100644 arch/arm/mach-s3c/adc-core.h
 delete mode 100644 arch/arm/mach-s3c/adc.c
 delete mode 100644 arch/arm/mach-s3c/anubis.h
 delete mode 100644 arch/arm/mach-s3c/ata-core-s3c64xx.h
 delete mode 100644 arch/arm/mach-s3c/backlight-s3c64xx.h
 delete mode 100644 arch/arm/mach-s3c/bast-ide.c
 delete mode 100644 arch/arm/mach-s3c/bast-irq.c
 delete mode 100644 arch/arm/mach-s3c/bast.h
 delete mode 100644 arch/arm/mach-s3c/common-smdk-s3c24xx.c
 delete mode 100644 arch/arm/mach-s3c/common-smdk-s3c24xx.h
 delete mode 100644 arch/arm/mach-s3c/cpufreq-utils-s3c24xx.c
 delete mode 100644 arch/arm/mach-s3c/dev-backlight-s3c64xx.c
 delete mode 100644 arch/arm/mach-s3c/dma-s3c24xx.h
 delete mode 100644 arch/arm/mach-s3c/dma-s3c64xx.h
 delete mode 100644 arch/arm/mach-s3c/dma.h
 delete mode 100644 arch/arm/mach-s3c/fb-core-s3c24xx.h
 delete mode 100644 arch/arm/mach-s3c/gpio-samsung-s3c24xx.h
 delete mode 100644 arch/arm/mach-s3c/gta02.h
 delete mode 100644 arch/arm/mach-s3c/h1940-bluetooth.c
 delete mode 100644 arch/arm/mach-s3c/h1940.h
 delete mode 100644 arch/arm/mach-s3c/hardware-s3c24xx.h
 delete mode 100644 arch/arm/mach-s3c/iotiming-s3c2410.c
 delete mode 100644 arch/arm/mach-s3c/iotiming-s3c2412.c
 delete mode 100644 arch/arm/mach-s3c/irq-pm-s3c24xx.c
 delete mode 100644 arch/arm/mach-s3c/irq-s3c24xx-fiq-exports.c
 delete mode 100644 arch/arm/mach-s3c/irq-s3c24xx-fiq.S
 delete mode 100644 arch/arm/mach-s3c/irq-s3c24xx.c
 delete mode 100644 arch/arm/mach-s3c/irqs-s3c24xx.h
 delete mode 100644 arch/arm/mach-s3c/mach-amlm5900.c
 delete mode 100644 arch/arm/mach-s3c/mach-anubis.c
 delete mode 100644 arch/arm/mach-s3c/mach-anw6410.c
 delete mode 100644 arch/arm/mach-s3c/mach-at2440evb.c
 delete mode 100644 arch/arm/mach-s3c/mach-bast.c
 delete mode 100644 arch/arm/mach-s3c/mach-gta02.c
 delete mode 100644 arch/arm/mach-s3c/mach-h1940.c
 delete mode 100644 arch/arm/mach-s3c/mach-hmt.c
 delete mode 100644 arch/arm/mach-s3c/mach-jive.c
 delete mode 100644 arch/arm/mach-s3c/mach-mini2440.c
 delete mode 100644 arch/arm/mach-s3c/mach-mini6410.c
 delete mode 100644 arch/arm/mach-s3c/mach-n30.c
 delete mode 100644 arch/arm/mach-s3c/mach-ncp.c
 delete mode 100644 arch/arm/mach-s3c/mach-nexcoder.c
 delete mode 100644 arch/arm/mach-s3c/mach-osiris-dvs.c
 delete mode 100644 arch/arm/mach-s3c/mach-osiris.c
 delete mode 100644 arch/arm/mach-s3c/mach-otom.c
 delete mode 100644 arch/arm/mach-s3c/mach-qt2410.c
 delete mode 100644 arch/arm/mach-s3c/mach-real6410.c
 delete mode 100644 arch/arm/mach-s3c/mach-rx1950.c
 delete mode 100644 arch/arm/mach-s3c/mach-rx3715.c
 delete mode 100644 arch/arm/mach-s3c/mach-s3c2416-dt.c
 delete mode 100644 arch/arm/mach-s3c/mach-smartq.c
 delete mode 100644 arch/arm/mach-s3c/mach-smartq.h
 delete mode 100644 arch/arm/mach-s3c/mach-smartq5.c
 delete mode 100644 arch/arm/mach-s3c/mach-smartq7.c
 delete mode 100644 arch/arm/mach-s3c/mach-smdk2410.c
 delete mode 100644 arch/arm/mach-s3c/mach-smdk2413.c
 delete mode 100644 arch/arm/mach-s3c/mach-smdk2416.c
 delete mode 100644 arch/arm/mach-s3c/mach-smdk2440.c
 delete mode 100644 arch/arm/mach-s3c/mach-smdk2443.c
 delete mode 100644 arch/arm/mach-s3c/mach-smdk6400.c
 delete mode 100644 arch/arm/mach-s3c/mach-smdk6410.c
 delete mode 100644 arch/arm/mach-s3c/mach-tct_hammer.c
 delete mode 100644 arch/arm/mach-s3c/mach-vr1000.c
 delete mode 100644 arch/arm/mach-s3c/mach-vstms.c
 delete mode 100644 arch/arm/mach-s3c/map-s3c24xx.h
 delete mode 100644 arch/arm/mach-s3c/nand-core-s3c24xx.h
 delete mode 100644 arch/arm/mach-s3c/onenand-core-s3c64xx.h
 delete mode 100644 arch/arm/mach-s3c/osiris.h
 delete mode 100644 arch/arm/mach-s3c/otom.h
 delete mode 100644 arch/arm/mach-s3c/pll-s3c2410.c
 delete mode 100644 arch/arm/mach-s3c/pll-s3c2440-12000000.c
 delete mode 100644 arch/arm/mach-s3c/pll-s3c2440-16934400.c
 delete mode 100644 arch/arm/mach-s3c/pm-core-s3c24xx.h
 delete mode 100644 arch/arm/mach-s3c/pm-h1940.S
 delete mode 100644 arch/arm/mach-s3c/pm-s3c2410.c
 delete mode 100644 arch/arm/mach-s3c/pm-s3c2412.c
 delete mode 100644 arch/arm/mach-s3c/pm-s3c2416.c
 delete mode 100644 arch/arm/mach-s3c/pm-s3c24xx.c
 delete mode 100644 arch/arm/mach-s3c/regs-adc.h
 delete mode 100644 arch/arm/mach-s3c/regs-clock-s3c24xx.h
 delete mode 100644 arch/arm/mach-s3c/regs-dsc-s3c24xx.h
 delete mode 100644 arch/arm/mach-s3c/regs-gpio-s3c24xx.h
 delete mode 100644 arch/arm/mach-s3c/regs-irq-s3c24xx.h
 delete mode 100644 arch/arm/mach-s3c/regs-mem-s3c24xx.h
 delete mode 100644 arch/arm/mach-s3c/regs-s3c2443-clock.h
 delete mode 100644 arch/arm/mach-s3c/regs-srom-s3c64xx.h
 delete mode 100644 arch/arm/mach-s3c/rtc-core-s3c24xx.h
 delete mode 100644 arch/arm/mach-s3c/s3c2410.c
 delete mode 100644 arch/arm/mach-s3c/s3c2412-power.h
 delete mode 100644 arch/arm/mach-s3c/s3c2412.c
 delete mode 100644 arch/arm/mach-s3c/s3c2412.h
 delete mode 100644 arch/arm/mach-s3c/s3c2416.c
 delete mode 100644 arch/arm/mach-s3c/s3c2440.c
 delete mode 100644 arch/arm/mach-s3c/s3c2442.c
 delete mode 100644 arch/arm/mach-s3c/s3c2443.c
 delete mode 100644 arch/arm/mach-s3c/s3c244x.c
 delete mode 100644 arch/arm/mach-s3c/s3c24xx.c
 delete mode 100644 arch/arm/mach-s3c/s3c24xx.h
 delete mode 100644 arch/arm/mach-s3c/s3c6400.c
 delete mode 100644 arch/arm/mach-s3c/setup-i2c-s3c24xx.c
 delete mode 100644 arch/arm/mach-s3c/setup-ide-s3c64xx.c
 delete mode 100644 arch/arm/mach-s3c/setup-sdhci-gpio-s3c24xx.c
 delete mode 100644 arch/arm/mach-s3c/setup-spi-s3c24xx.c
 delete mode 100644 arch/arm/mach-s3c/setup-ts-s3c24xx.c
 delete mode 100644 arch/arm/mach-s3c/simtec-audio.c
 delete mode 100644 arch/arm/mach-s3c/simtec-nor.c
 delete mode 100644 arch/arm/mach-s3c/simtec-pm.c
 delete mode 100644 arch/arm/mach-s3c/simtec-usb.c
 delete mode 100644 arch/arm/mach-s3c/simtec.h
 delete mode 100644 arch/arm/mach-s3c/sleep-s3c2410.S
 delete mode 100644 arch/arm/mach-s3c/sleep-s3c2412.S
 delete mode 100644 arch/arm/mach-s3c/sleep-s3c24xx.S
 delete mode 100644 arch/arm/mach-s3c/spi-core-s3c24xx.h
 delete mode 100644 arch/arm/mach-s3c/vr1000.h
 delete mode 100644 arch/arm/mach-sa1100/badge4.c
 delete mode 100644 arch/arm/mach-sa1100/cerf.c
 delete mode 100644 arch/arm/mach-sa1100/h3100.c
 delete mode 100644 arch/arm/mach-sa1100/hackkit.c
 delete mode 100644 arch/arm/mach-sa1100/include/mach/badge4.h
 delete mode 100644 arch/arm/mach-sa1100/include/mach/cerf.h
 delete mode 100644 arch/arm/mach-sa1100/include/mach/nanoengine.h
 delete mode 100644 arch/arm/mach-sa1100/include/mach/shannon.h
 delete mode 100644 arch/arm/mach-sa1100/include/mach/simpad.h
 delete mode 100644 arch/arm/mach-sa1100/lart.c
 delete mode 100644 arch/arm/mach-sa1100/nanoengine.c
 delete mode 100644 arch/arm/mach-sa1100/pci-nanoengine.c
 delete mode 100644 arch/arm/mach-sa1100/pleb.c
 delete mode 100644 arch/arm/mach-sa1100/shannon.c
 delete mode 100644 arch/arm/mach-sa1100/simpad.c
 delete mode 100644 drivers/ata/pata_palmld.c
 delete mode 100644 drivers/ata/pata_samsung_cf.c
 delete mode 100644 drivers/clk/davinci/pll-dm355.c
 delete mode 100644 drivers/clk/davinci/pll-dm365.c
 delete mode 100644 drivers/clk/davinci/psc-dm355.c
 delete mode 100644 drivers/clk/davinci/psc-dm365.c
 delete mode 100644 drivers/clk/samsung/clk-s3c2410-dclk.c
 delete mode 100644 drivers/clk/samsung/clk-s3c2410.c
 delete mode 100644 drivers/clk/samsung/clk-s3c2412.c
 delete mode 100644 drivers/clk/samsung/clk-s3c2443.c
 delete mode 100644 drivers/cpufreq/s3c2410-cpufreq.c
 delete mode 100644 drivers/cpufreq/s3c2412-cpufreq.c
 delete mode 100644 drivers/cpufreq/s3c2416-cpufreq.c
 delete mode 100644 drivers/cpufreq/s3c2440-cpufreq.c
 delete mode 100644 drivers/cpufreq/s3c24xx-cpufreq-debugfs.c
 delete mode 100644 drivers/cpufreq/s3c24xx-cpufreq.c
 delete mode 100644 drivers/cpufreq/sa1100-cpufreq.c
 delete mode 100644 drivers/dma/s3c24xx-dma.c
 delete mode 100644 drivers/gpio/gpio-iop.c
 delete mode 100644 drivers/gpio/gpio-ucb1400.c
 delete mode 100644 drivers/hwmon/s3c-hwmon.c
 delete mode 100644 drivers/input/keyboard/davinci_keyscan.c
 delete mode 100644 drivers/input/keyboard/pxa930_rotary.c
 delete mode 100644 drivers/input/mouse/pxa930_trkball.c
 delete mode 100644 drivers/input/touchscreen/s3c2410_ts.c
 delete mode 100644 drivers/input/touchscreen/ucb1400_ts.c
 delete mode 100644 drivers/input/touchscreen/zylonite-wm97xx.c
 delete mode 100644 drivers/irqchip/irq-davinci-aintc.c
 delete mode 100644 drivers/leds/leds-s3c24xx.c
 delete mode 100644 drivers/media/platform/ti/davinci/vpbe.c
 delete mode 100644 drivers/media/platform/ti/davinci/vpbe_display.c
 delete mode 100644 drivers/media/platform/ti/davinci/vpbe_osd.c
 delete mode 100644 drivers/media/platform/ti/davinci/vpbe_osd_regs.h
 delete mode 100644 drivers/media/platform/ti/davinci/vpbe_venc.c
 delete mode 100644 drivers/media/platform/ti/davinci/vpbe_venc_regs.h
 delete mode 100644 drivers/media/platform/ti/davinci/vpss.c
 delete mode 100644 drivers/mfd/asic3.c
 delete mode 100644 drivers/mfd/htc-pasic3.c
 delete mode 100644 drivers/mfd/t7l66xb.c
 delete mode 100644 drivers/mfd/tc6387xb.c
 delete mode 100644 drivers/mfd/tc6393xb.c
 delete mode 100644 drivers/mfd/tmio_core.c
 delete mode 100644 drivers/mfd/ucb1400_core.c
 delete mode 100644 drivers/mmc/host/s3cmci.c
 delete mode 100644 drivers/mmc/host/s3cmci.h
 delete mode 100644 drivers/mmc/host/sdhci-cns3xxx.c
 delete mode 100644 drivers/mmc/host/tmio_mmc.c
 delete mode 100644 drivers/parport/parport_ax88796.c
 delete mode 100644 drivers/pcmcia/pxa2xx_mainstone.c
 delete mode 100644 drivers/pcmcia/sa1100_simpad.c
 delete mode 100644 drivers/pcmcia/sa1111_badge4.c
 delete mode 100644 drivers/pcmcia/sa1111_lubbock.c
 delete mode 100644 drivers/pinctrl/samsung/pinctrl-s3c24xx.c
 delete mode 100644 drivers/power/supply/pda_power.c
 delete mode 100644 drivers/power/supply/s3c_adc_battery.c
 delete mode 100644 drivers/power/supply/tosa_battery.c
 delete mode 100644 drivers/power/supply/z2_battery.c
 delete mode 100644 drivers/rtc/rtc-v3020.c
 delete mode 100644 drivers/soc/samsung/s3c-pm-debug.c
 delete mode 100644 drivers/spi/spi-omap-100k.c
 delete mode 100644 drivers/spi/spi-s3c24xx-regs.h
 delete mode 100644 drivers/spi/spi-s3c24xx.c
 delete mode 100644 drivers/staging/media/deprecated/vpfe_capture/Kconfig
 delete mode 100644 drivers/staging/media/deprecated/vpfe_capture/Makefile
 delete mode 100644 drivers/staging/media/deprecated/vpfe_capture/TODO
 delete mode 100644 drivers/staging/media/deprecated/vpfe_capture/ccdc_hw_device.h
 delete mode 100644 drivers/staging/media/deprecated/vpfe_capture/dm355_ccdc.c
 delete mode 100644 drivers/staging/media/deprecated/vpfe_capture/dm355_ccdc.h
 delete mode 100644 drivers/staging/media/deprecated/vpfe_capture/dm355_ccdc_regs.h
 delete mode 100644 drivers/staging/media/deprecated/vpfe_capture/dm644x_ccdc.c
 delete mode 100644 drivers/staging/media/deprecated/vpfe_capture/dm644x_ccdc.h
 delete mode 100644 drivers/staging/media/deprecated/vpfe_capture/dm644x_ccdc_regs.h
 delete mode 100644 drivers/staging/media/deprecated/vpfe_capture/isif.c
 delete mode 100644 drivers/staging/media/deprecated/vpfe_capture/isif.h
 delete mode 100644 drivers/staging/media/deprecated/vpfe_capture/isif_regs.h
 delete mode 100644 drivers/staging/media/deprecated/vpfe_capture/vpfe_capture.c
 delete mode 100644 drivers/usb/gadget/udc/s3c-hsudc.c
 delete mode 100644 drivers/usb/gadget/udc/s3c2410_udc.c
 delete mode 100644 drivers/usb/gadget/udc/s3c2410_udc.h
 delete mode 100644 drivers/usb/gadget/udc/s3c2410_udc_regs.h
 delete mode 100644 drivers/usb/host/ohci-tmio.c
 delete mode 100644 drivers/usb/phy/phy-isp1301-omap.c
 delete mode 100644 drivers/video/fbdev/omap/lcd_h3.c
 delete mode 100644 drivers/video/fbdev/omap/lcd_htcherald.c
 delete mode 100644 drivers/video/fbdev/omap/lcd_inn1510.c
 delete mode 100644 drivers/video/fbdev/omap/lcd_inn1610.c
 delete mode 100644 drivers/video/fbdev/omap/lcd_palmtt.c
 delete mode 100644 drivers/video/fbdev/omap/lcd_palmz71.c
 delete mode 100644 drivers/video/fbdev/s3c2410fb-regs-lcd.h
 delete mode 100644 drivers/video/fbdev/s3c2410fb.c
 delete mode 100644 drivers/video/fbdev/s3c2410fb.h
 delete mode 100644 drivers/video/fbdev/tmiofb.c
 delete mode 100644 drivers/video/fbdev/w100fb.c
 delete mode 100644 drivers/video/fbdev/w100fb.h
 delete mode 100644 drivers/w1/masters/ds1wm.c
 delete mode 100644 include/dt-bindings/clock/s3c2410.h
 delete mode 100644 include/dt-bindings/clock/s3c2412.h
 delete mode 100644 include/dt-bindings/clock/s3c2443.h
 delete mode 100644 include/linux/amba/pl093.h
 delete mode 100644 include/linux/mfd/asic3.h
 delete mode 100644 include/linux/mfd/htc-pasic3.h
 delete mode 100644 include/linux/mfd/t7l66xb.h
 delete mode 100644 include/linux/mfd/tc6387xb.h
 delete mode 100644 include/linux/mfd/tc6393xb.h
 delete mode 100644 include/linux/pda_power.h
 delete mode 100644 include/linux/platform_data/asoc-palm27x.h
 delete mode 100644 include/linux/platform_data/asoc-poodle.h
 delete mode 100644 include/linux/platform_data/asoc-s3c24xx_simtec.h
 delete mode 100644 include/linux/platform_data/ata-samsung_cf.h
 delete mode 100644 include/linux/platform_data/clk-s3c2410.h
 delete mode 100644 include/linux/platform_data/dma-mmp_tdma.h
 delete mode 100644 include/linux/platform_data/dma-s3c24xx.h
 delete mode 100644 include/linux/platform_data/fb-s3c2410.h
 delete mode 100644 include/linux/platform_data/irda-pxaficp.h
 delete mode 100644 include/linux/platform_data/irda-sa11x0.h
 delete mode 100644 include/linux/platform_data/keyboard-pxa930_rotary.h
 delete mode 100644 include/linux/platform_data/leds-omap.h
 delete mode 100644 include/linux/platform_data/leds-s3c24xx.h
 delete mode 100644 include/linux/platform_data/media/s5p_hdmi.h
 delete mode 100644 include/linux/platform_data/mmc-s3cmci.h
 delete mode 100644 include/linux/platform_data/mmp_audio.h
 delete mode 100644 include/linux/platform_data/mouse-pxa930_trkball.h
 delete mode 100644 include/linux/platform_data/rtc-v3020.h
 delete mode 100644 include/linux/platform_data/s3c-hsudc.h
 delete mode 100644 include/linux/platform_data/usb-pxa3xx-ulpi.h
 delete mode 100644 include/linux/platform_data/usb-s3c2410_udc.h
 delete mode 100644 include/linux/s3c_adc_battery.h
 delete mode 100644 include/linux/soc/samsung/s3c-adc.h
 delete mode 100644 include/linux/soc/samsung/s3c-cpu-freq.h
 delete mode 100644 include/linux/soc/samsung/s3c-cpufreq-core.h
 delete mode 100644 include/linux/spi/s3c24xx-fiq.h
 delete mode 100644 include/linux/spi/s3c24xx.h
 delete mode 100644 include/linux/ucb1400.h
 delete mode 100644 include/linux/z2_battery.h
 delete mode 100644 include/media/davinci/vpbe.h
 delete mode 100644 include/media/davinci/vpbe_display.h
 delete mode 100644 include/media/davinci/vpbe_osd.h
 delete mode 100644 include/media/davinci/vpbe_types.h
 delete mode 100644 include/media/davinci/vpbe_venc.h
 delete mode 100644 include/media/davinci/vpfe_capture.h
 delete mode 100644 include/media/davinci/vpss.h
 delete mode 100644 include/sound/s3c24xx_uda134x.h
 delete mode 100644 include/video/w100fb.h
 delete mode 100644 sound/soc/cirrus/ep93xx-ac97.c
 delete mode 100644 sound/soc/cirrus/simone.c
 delete mode 100644 sound/soc/cirrus/snappercl15.c
 delete mode 100644 sound/soc/pxa/brownstone.c
 delete mode 100644 sound/soc/pxa/corgi.c
 delete mode 100644 sound/soc/pxa/e740_wm9705.c
 delete mode 100644 sound/soc/pxa/e750_wm9705.c
 delete mode 100644 sound/soc/pxa/e800_wm9712.c
 delete mode 100644 sound/soc/pxa/em-x270.c
 delete mode 100644 sound/soc/pxa/hx4700.c
 delete mode 100644 sound/soc/pxa/magician.c
 delete mode 100644 sound/soc/pxa/mioa701_wm9713.c
 delete mode 100644 sound/soc/pxa/mmp-pcm.c
 delete mode 100644 sound/soc/pxa/palm27x.c
 delete mode 100644 sound/soc/pxa/poodle.c
 delete mode 100644 sound/soc/pxa/tosa.c
 delete mode 100644 sound/soc/pxa/ttc-dkb.c
 delete mode 100644 sound/soc/pxa/z2.c
 delete mode 100644 sound/soc/pxa/zylonite.c
 delete mode 100644 sound/soc/samsung/h1940_uda1380.c
 delete mode 100644 sound/soc/samsung/jive_wm8750.c
 delete mode 100644 sound/soc/samsung/neo1973_wm8753.c
 delete mode 100644 sound/soc/samsung/regs-i2s-v2.h
 delete mode 100644 sound/soc/samsung/regs-iis.h
 delete mode 100644 sound/soc/samsung/rx1950_uda1380.c
 delete mode 100644 sound/soc/samsung/s3c-i2s-v2.c
 delete mode 100644 sound/soc/samsung/s3c-i2s-v2.h
 delete mode 100644 sound/soc/samsung/s3c2412-i2s.c
 delete mode 100644 sound/soc/samsung/s3c2412-i2s.h
 delete mode 100644 sound/soc/samsung/s3c24xx-i2s.c
 delete mode 100644 sound/soc/samsung/s3c24xx-i2s.h
 delete mode 100644 sound/soc/samsung/s3c24xx_simtec.c
 delete mode 100644 sound/soc/samsung/s3c24xx_simtec.h
 delete mode 100644 sound/soc/samsung/s3c24xx_simtec_hermes.c
 delete mode 100644 sound/soc/samsung/s3c24xx_simtec_tlv320aic23.c
 delete mode 100644 sound/soc/samsung/s3c24xx_uda134x.c
 delete mode 100644 sound/soc/samsung/smartq_wm8987.c
 delete mode 100644 sound/soc/samsung/smdk_wm8580.c
 delete mode 100644 sound/soc/ti/davinci-vcif.c
