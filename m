Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1479667523D
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 11:19:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjATKTw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 05:19:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjATKTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 05:19:43 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E8C754B16
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 02:19:41 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id B9F325C0161;
        Fri, 20 Jan 2023 05:19:38 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Fri, 20 Jan 2023 05:19:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1674209978; x=1674296378; bh=mKjS13WoyLwESRPkMk2FTqdHF/1NhLqmRm2
        GstK37d0=; b=QkqXor6NJVqHnsHvnHSyiDcaoFHnFVUB7uWLJkrhm+KSnqHrU7t
        bAXaM3jv8uoBg+VvMG/WzC9z/5f1Ho3uiF6004XLrFkJWodADYQcFavkyQ8NKWB0
        0mLAHn0qHl2uyB+E9NZDvea4CY9DPLQx6n99CM2TRWUYDoSuy3qFAYk45zri8xr0
        gC5wr/g+G4Akv59Z4tbRvqZofsW5DSBNm38Solo+YqMf9htT9lJTgekzqyKE4qza
        3KX/Wb73uNwmNDGaDo4dV6CjSTuQcwktjeekqyAVGJU+E10DhHaVHClBAmIt9NeP
        tdUKkO3e3OZyzgeC6AtVjoUQI0KnqpNT5+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:message-id:mime-version
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1674209978; x=
        1674296378; bh=mKjS13WoyLwESRPkMk2FTqdHF/1NhLqmRm2GstK37d0=; b=r
        3Zs6cnFFA9E5npaee2BrkQvCT0xy8vripULQXWPq7z7GkTVWmINobcBNG78+yUvg
        hU6HryHYfu8EoyaEXadTynbtW+wyHa5U5xCQqEXrbu1iSsn4kb29JuxqyauFjjY2
        I3ih2ZrkKpGsdnb7XCwrhU0ohHRxEiIr9hpwmRwASCg/xjUGK5H12lcGeltX0cqw
        IR5pmr6GRZ5h7kZrmFanJL49FYKbAkJV1MVPreygzlGuu625ynsR3HBfmzItvwzU
        5qZ4sKrNYhP9ZUyF0VWEuJ/qIxlQuIcCxznyCp62lAshaaA5hqAMHtjpHpEXXmAX
        YyfhMjybZLJhQWCM8OrGQ==
X-ME-Sender: <xms:umrKYy_Pwse-C1D0pDLiRMSTmeUK8okQ8xF0u4m69monYXygQouO5w>
    <xme:umrKYyuNYB1NfNAVH0kxgn_hLx7blSwh6Mjt-vEDN5JQR8-rwtAAFUsr00qjl7fRi
    VfC1UmXxU1ERLCDI4c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudduvddgudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkfffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhepfeffvdefieffieejieethefgvddtvdfgudehveehtedvgfdvjeffudejjeettdel
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpphgvnhhguhhtrhhonhhigidruggvpd
    hgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:umrKY4AV9aXinLdS0Qyhx4jhDc0Di772TcdqLvB_6fiqGbvHSSwFHg>
    <xmx:umrKY6eTjvEe3QEeFFEPxJBTgONVU0-UCW7gSMZ1g4zjcIGL1einwA>
    <xmx:umrKY3OslB7UlbhiH6FZQVQmo0oA5kFdWy5jBpSOe9ptW46S_O9lZw>
    <xmx:umrKY93Mj9zSQau4x5mBgidN0tAQvJgmCDCNgDHWcLbA7UnoOQLQsg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 876C2B60086; Fri, 20 Jan 2023 05:19:38 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-85-gd6d859e0cf-fm-20230116.001-gd6d859e0
Mime-Version: 1.0
Message-Id: <bcb75322-43e6-4e17-b0f4-59d9a5fb844f@app.fastmail.com>
Date:   Fri, 20 Jan 2023 11:19:19 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Linus Torvalds" <torvalds@linux-foundation.org>
Cc:     soc@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] ARM: SoC DT and driver fixes 6.2
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 88603b6dc419445847923fcb7fe5080067a30f98:

  Linux 6.2-rc2 (2023-01-01 13:53:16 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-fixes-6.2

for you to fetch changes up to d2c865553adb7ad9abf3894cbb209cf1bc95484a:

  firmware: zynqmp: fix declarations for gcc-13 (2023-01-20 10:54:05 +0100)

----------------------------------------------------------------
ARM: SoC DT and driver fixes 6.2

Lots of dts fixes for Qualcomm Snapdragon and NXP i.MX platforms,
including:

 - A regression fix for SDHCI controllers on Inforce 6540, and
   another SDHCI fix on SM8350

 - Reenable cluster idle on sm8250 after the the code fix is upstream

 - multiple fixes for the QMP PHY binding, needing an incompatible
   dt change

 - The reserved memory map is updated on Xiaomi Mi 4C and Huawei Nexus
   6P, to avoid instabilities caused by use of protected memory regions

 - Fix i.MX8MP DT for missing GPC Interrupt, power-domain typo and USB
   clock error

 - A couple of verdin-imx8mm DT fixes for audio playback support

 - Fix pca9547 i2c-mux node name for i.MX and Vybrid device trees

 - Fix an imx93-11x11-evk uSDHC pad setting problem that causes Micron
   eMMC CMD8 CRC error in HS400ES/HS400 mode

The remaining ARM and RISC-V platforms only have very few
smaller dts bugfixes this time:

 - A fix for the SiFive unmatched board's PCI memory space

 - A revert to fix a regression with GPIO on Marvell Armada

 - A fix for the UART address on Marvell AC5

 - Missing chip-select phandles for stm32 boards

 - Selecting the correct clock for the sam9x60 memory controller

 - Amlogic based Odroid-HC4 needs a revert to restore USB
   functionality.

And finally, there are some minor code fixes:

 - Build fixes for OMAP1, pxa, riscpc, raspberry pi firmware, and zynq
   firmware

 - memory controller driver fixes for an OMAP regression and older bugs
   on tegra, atmel and mvebu

 - reset controller fixes for ti-sci and uniphier platforms

 - ARM SCMI firmware fixes for a couple of rare corner cases

 - Qualcomm platform driver fixes for incorrect error handling and a
   backwards compatibility fix for the apr driver using older dtb

 - NXP i.MX SoC driver fixes for HDMI output, error handling in the imx8
   soc-id and missing reference counting on older cpuid code

----------------------------------------------------------------
Adam Ford (3):
      arm64: dts: imx8mm-beacon: Fix ecspi2 pinmux
      arm64: dts: imx8mp: Fix missing GPC Interrupt
      arm64: dts: imx8mp: Fix power-domain typo

Alexandre Belloni (1):
      ARM: footbridge: drop unnecessary inclusion

Arnd Bergmann (18):
      ARM: pxa: enable PXA310/PXA320 for DT-only build
      Merge tag 'memory-controller-drv-fixes-6.2' of https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-mem-ctrl into arm/fixes
      Merge tag 'scmi-fixes-6.2' of git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux into arm/fixes
      Merge tag 'amlogic-fixes-v6.2-rc' of https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux into arm/fixes
      Merge tag 'reset-fixes-for-v6.2' of git://git.pengutronix.de/pza/linux into arm/fixes
      Merge tag 'imx-fixes-6.2' of git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux into arm/fixes
      ARM: omap1: fix !ARCH_OMAP1_ANY link failures
      ARM: omap1: fix building gpio15xx
      Merge branch 'armsoc-build-fixes' of https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc into arm/fixes
      Merge tag 'qcom-dts-fixes-for-6.2' of https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux into arm/fixes
      Merge tag 'qcom-arm64-fixes-for-6.2' of https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux into arm/fixes
      Merge tag 'qcom-driver-fixes-for-6.2' of https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux into arm/fixes
      Merge tag 'arm-soc/for-6.2/drivers-fixes' of https://github.com/Broadcom/stblinux into arm/fixes
      Merge tag 'mvebu-fixes-6.2-1' of git://git.kernel.org/pub/scm/linux/kernel/git/gclement/mvebu into arm/fixes
      Merge tag 'riscv-dt-fixes-for-v6.2-rc4' of https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux into arm/fixes
      Merge tag 'stm32-dt-for-v6.2-fixes-1' of git://git.kernel.org/pub/scm/linux/kernel/git/atorgue/stm32 into arm/fixes
      Merge tag 'at91-fixes-6.2' of https://git.kernel.org/pub/scm/linux/kernel/git/at91/linux into arm/fixes
      firmware: zynqmp: fix declarations for gcc-13

Ashish Mhetre (1):
      memory: tegra: Remove clients SID override programming

Ben Dooks (1):
      riscv: dts: sifive: fu740: fix size of pcie 32bit memory

Benedikt Niedermayr (1):
      memory: omap-gpmc: fix wait pin validation

Chris Packham (1):
      arm64: dts: marvell: AC5/AC5X: Fix address for UART1

Christophe JAILLET (1):
      PM: AVS: qcom-cpr: Fix an error handling path in cpr_probe()

Claudiu Beznea (1):
      ARM: dts: at91: sam9x60: fix the ddr clock for sam9x60

Cristian Marussi (4):
      firmware: arm_scmi: Clear stale xfer->hdr.status
      firmware: arm_scmi: Harden shared memory access in fetch_response
      firmware: arm_scmi: Harden shared memory access in fetch_notification
      firmware: arm_scmi: Fix virtio channels cleanup on shutdown

Dario Binacchi (1):
      ARM: imx: add missing of_node_put()

Dominik Kobinski (2):
      arm64: dts: msm8992-bullhead: add memory hole region
      arm64: dts: msm8994-angler: fix the memory map

Emanuele Ghidoli (2):
      arm64: dts: verdin-imx8mm: fix dahlia audio playback
      arm64: dts: verdin-imx8mm: fix dev board audio playback

Fabio Estevam (4):
      arm64: dts: imx8mp-phycore-som: Remove invalid PMIC property
      ARM: dts: imx6ul-pico-dwarf: Use 'clock-frequency'
      ARM: dts: imx7d-pico: Use 'clock-frequency'
      ARM: dts: imx6qdl-gw560x: Remove incorrect 'uart-has-rtscts'

Gaosheng Cui (2):
      memory: atmel-sdramc: Fix missing clk_disable_unprepare in atmel_ramc_probe()
      memory: mvebu-devbus: Fix missing clk_disable_unprepare in mvebu_devbus_probe()

Geert Uytterhoeven (3):
      ARM: dts: imx: Fix pca9547 i2c-mux node name
      ARM: dts: vf610: Fix pca9548 i2c-mux node names
      arm64: dts: freescale: Fix pca954x i2c-mux node names

Haibo Chen (1):
      arm64: dts: imx93-11x11-evk: correct clock and strobe pad setting

Hui Tang (1):
      reset: uniphier-glue: Fix possible null-ptr-deref

Johan Hovold (2):
      arm64: dts: qcom: sc8280xp: fix primary USB-DP PHY reset
      arm64: dts: qcom: sc8280xp: fix USB-DP PHY nodes

Klaus Kudielka (2):
      Revert "ARM: dts: armada-38x: Fix compatible string for gpios"
      Revert "ARM: dts: armada-39x: Fix compatible string for gpios"

Konrad Dybcio (2):
      arm64: dts: qcom: msm8992: Don't use sfpb mutex
      arm64: dts: qcom: msm8992-libra: Fix the memory map

Krzysztof Kozlowski (3):
      ARM: dts: qcom: apq8084-ifc6540: fix overriding SDHCI
      arm64: dts: qcom: sm8350: correct SDHCI interconnect arguments
      arm64: dts: imx8mq-thor96: fix no-mmc property for SDHCI

Li Jun (1):
      arm64: dts: imx8mp: correct usb clocks

Lucas Stach (2):
      soc: imx: imx8mp-blk-ctrl: enable global pixclk with HDMI_TX_PHY PD
      soc: imx: imx8mp-blk-ctrl: don't set power device name

Marco Felsch (1):
      arm64: dts: imx8mp-evk: pcie0-refclk cosmetic cleanup

Marek Vasut (1):
      arm64: dts: imx8mm: Drop xtal clock specifier from eDM SBC

Maxime Ripard (1):
      firmware: raspberrypi: Fix type assignment

Miaoqian Lin (1):
      soc: imx8m: Fix incorrect check for of_clk_get_by_name()

Patrice Chotard (4):
      ARM: dts: stm32: Fix qspi pinctrl phandle for stm32mp15xx-dhcor-som
      ARM: dts: stm32: Fix qspi pinctrl phandle for stm32mp15xx-dhcom-som
      ARM: dts: stm32: Fix qspi pinctrl phandle for stm32mp157c-emstamp-argon
      ARM: dts: stm32: Fix qspi pinctrl phandle for stm32mp151a-prtt1l

Pierre-Olivier Mercier (1):
      Revert "arm64: dts: meson-sm1-odroid-hc4: disable unused USB PHY0"

Randy Dunlap (1):
      reset: ti-sci: honor TI_SCI_PROTOCOL setting when not COMPILE_TEST

Stephan Gerhold (2):
      dt-bindings: soc: qcom: apr: Make qcom,protection-domain optional again
      soc: qcom: apr: Make qcom,protection-domain optional again

Tim Harvey (1):
      arm64: dts: imx8mm-venice-gw7901: fix USB2 controller OC polarity

Ulf Hansson (1):
      Revert "arm64: dts: qcom: sm8250: Disable the not yet supported cluster idle state"

 .../bindings/soc/qcom/qcom,apr-services.yaml       |  5 +-
 arch/arm/boot/dts/armada-38x.dtsi                  |  4 +-
 arch/arm/boot/dts/armada-39x.dtsi                  |  4 +-
 arch/arm/boot/dts/imx53-ppd.dts                    |  2 +-
 arch/arm/boot/dts/imx6qdl-gw560x.dtsi              |  1 -
 arch/arm/boot/dts/imx6ul-pico-dwarf.dts            |  2 +-
 arch/arm/boot/dts/imx7d-pico-dwarf.dts             |  4 +-
 arch/arm/boot/dts/imx7d-pico-nymph.dts             |  4 +-
 arch/arm/boot/dts/qcom-apq8084-ifc6540.dts         | 20 +++---
 arch/arm/boot/dts/qcom-apq8084.dtsi                |  4 +-
 arch/arm/boot/dts/sam9x60.dtsi                     |  2 +-
 arch/arm/boot/dts/stm32mp151a-prtt1l.dtsi          |  8 ++-
 arch/arm/boot/dts/stm32mp157c-emstamp-argon.dtsi   |  8 ++-
 arch/arm/boot/dts/stm32mp15xx-dhcom-som.dtsi       |  8 ++-
 arch/arm/boot/dts/stm32mp15xx-dhcor-som.dtsi       |  8 ++-
 arch/arm/boot/dts/vf610-zii-dev-rev-b.dts          |  2 +-
 arch/arm/boot/dts/vf610-zii-dev-rev-c.dts          |  2 +-
 arch/arm/mach-footbridge/isa-rtc.c                 |  1 -
 arch/arm/mach-imx/cpu-imx25.c                      |  1 +
 arch/arm/mach-imx/cpu-imx27.c                      |  1 +
 arch/arm/mach-imx/cpu-imx31.c                      |  1 +
 arch/arm/mach-imx/cpu-imx35.c                      |  1 +
 arch/arm/mach-imx/cpu-imx5.c                       |  1 +
 arch/arm/mach-omap1/Kconfig                        |  5 +-
 arch/arm/mach-omap1/Makefile                       |  4 --
 arch/arm/mach-omap1/gpio15xx.c                     |  1 +
 arch/arm/mach-omap1/io.c                           | 32 ++++-----
 arch/arm/mach-omap1/mcbsp.c                        | 21 ------
 arch/arm/mach-omap1/pm.h                           |  7 --
 arch/arm/mach-pxa/Kconfig                          |  2 +
 .../boot/dts/amlogic/meson-sm1-odroid-hc4.dts      |  8 +--
 arch/arm64/boot/dts/freescale/fsl-ls1012a-qds.dts  |  2 +-
 arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts  |  2 +-
 arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts  |  2 +-
 arch/arm64/boot/dts/freescale/fsl-ls1088a-qds.dts  |  2 +-
 arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts  |  2 +-
 .../arm64/boot/dts/freescale/fsl-ls1088a-ten64.dts |  2 +-
 arch/arm64/boot/dts/freescale/fsl-ls208xa-qds.dtsi |  2 +-
 arch/arm64/boot/dts/freescale/fsl-ls208xa-rdb.dtsi |  2 +-
 .../arm64/boot/dts/freescale/fsl-lx2160a-cex7.dtsi |  2 +-
 .../dts/freescale/imx8mm-beacon-baseboard.dtsi     |  4 +-
 .../dts/freescale/imx8mm-data-modul-edm-sbc.dts    |  2 +-
 .../boot/dts/freescale/imx8mm-nitrogen-r2.dts      |  2 +-
 .../boot/dts/freescale/imx8mm-venice-gw7901.dts    |  1 +
 .../boot/dts/freescale/imx8mm-verdin-dahlia.dtsi   |  1 +
 .../boot/dts/freescale/imx8mm-verdin-dev.dtsi      |  1 +
 arch/arm64/boot/dts/freescale/imx8mp-evk.dts       |  4 +-
 .../boot/dts/freescale/imx8mp-phycore-som.dtsi     | 10 ---
 arch/arm64/boot/dts/freescale/imx8mp.dtsi          | 15 ++--
 arch/arm64/boot/dts/freescale/imx8mq-nitrogen.dts  |  4 +-
 arch/arm64/boot/dts/freescale/imx8mq-thor96.dts    |  4 +-
 arch/arm64/boot/dts/freescale/imx8qxp-mek.dts      |  2 +-
 arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts  |  6 +-
 arch/arm64/boot/dts/marvell/ac5-98dx25xx.dtsi      |  2 +-
 arch/arm64/boot/dts/qcom/msm8992-lg-bullhead.dtsi  |  6 ++
 arch/arm64/boot/dts/qcom/msm8992-xiaomi-libra.dts  | 77 ++++++++++++++++-----
 arch/arm64/boot/dts/qcom/msm8992.dtsi              |  4 --
 .../dts/qcom/msm8994-huawei-angler-rev-101.dts     | 19 +++++-
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi             | 79 +++++++---------------
 arch/arm64/boot/dts/qcom/sm8250.dtsi               |  1 -
 arch/arm64/boot/dts/qcom/sm8350.dtsi               |  4 +-
 arch/riscv/boot/dts/sifive/fu740-c000.dtsi         |  2 +-
 drivers/firmware/arm_scmi/driver.c                 |  2 +
 drivers/firmware/arm_scmi/shmem.c                  |  9 ++-
 drivers/firmware/arm_scmi/virtio.c                 |  7 +-
 drivers/memory/atmel-sdramc.c                      |  6 +-
 drivers/memory/mvebu-devbus.c                      |  3 +-
 drivers/memory/omap-gpmc.c                         |  3 +-
 drivers/memory/tegra/tegra186.c                    | 36 ----------
 drivers/reset/Kconfig                              |  2 +-
 drivers/reset/reset-uniphier-glue.c                |  4 +-
 drivers/soc/imx/imx8mp-blk-ctrl.c                  |  7 +-
 drivers/soc/imx/soc-imx8m.c                        |  4 +-
 drivers/soc/qcom/apr.c                             |  3 +-
 drivers/soc/qcom/cpr.c                             |  6 +-
 include/linux/firmware/xlnx-zynqmp.h               |  8 +--
 include/linux/soc/ti/omap1-io.h                    |  4 +-
 include/soc/bcm2835/raspberrypi-firmware.h         |  2 +-
 78 files changed, 262 insertions(+), 286 deletions(-)
