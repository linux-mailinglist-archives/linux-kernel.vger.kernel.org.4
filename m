Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2919F6487B0
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 18:23:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbiLIRXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 12:23:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbiLIRXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 12:23:22 -0500
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2B09109A
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 09:23:18 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id E99293200684;
        Fri,  9 Dec 2022 12:23:17 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Fri, 09 Dec 2022 12:23:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1670606597; x=
        1670692997; bh=9hu4ii4pa60puKxVLs2bO+Qkc6on+oRzGulzr+M+ffA=; b=I
        0ptrvmKZXTo0weTUUFI8eBq6hREJSdk9ne3T9CbFj6jZ9P2OjVzfNzUNZVgQYDV7
        cXg/3Kue0EaxOQS93VjWo3sbBT3050N69+g7ec52AtKrwC6cPcETV6dWuMp7XVJu
        91OaS5SPknnHyZjDg/+DcFb0G7buei+I50VaEhk4+RPb8g5YZX64i3oKQxHD/Fs9
        qe/bcu/J5c/ndXJTcIXnLXfL4NcuK2T9mCd4S2ZtoF4A6TYVqlMx1FQTTQrXr+T7
        To8wUO8IDHBT+vYk4cdRhZvKbX1DbS5//qVErtwuyF5AR8obRHDDYbEfh+jyWXqO
        NAJ7OLZ9GbrnZdBGh4tUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1670606597; x=
        1670692997; bh=9hu4ii4pa60puKxVLs2bO+Qkc6on+oRzGulzr+M+ffA=; b=Z
        Q26pLCyo4uenGQVF3K3Kec4oo1FzK1kpNlJs8jmCaqztpjh8d1nwxwBd+fF1O166
        u4kJsykRo5Vp9kzt/sglyozNDiPXGYp0nb6n3gvdfFil0roCaidGmCZ+5KsXjEdb
        x0ZqoRhLFLgdNwKtYWlZf+OahlJdZK0qE3WDEtqcA6ZSWgr92GsvfezeBcKW8rE3
        bpYTZSgfLP/hSiy46GnrOjztC/B3AlNyx/rPvO37eN3yojndw7B5Mo2LtnUPlhnf
        6vewzvot0L3fxMJyQeihrm0IzIGTwSfm12hNkXcndQRHROvgC5+yNgun55jX4WcV
        z0uwwM+IQixkCN2JKQx/A==
X-ME-Sender: <xms:BW-TY3lERiAxBzxIcSjJCu4t6bO3b65Q7tBSKlUN9TPqMFPCzaJsWg>
    <xme:BW-TY6358TQqWFnu0nI_xcrfVUUTPcsxDQuAGDvdYYDw4nEAxstdGgSxT0j5SL7Si
    lVRQGNoeQyVAmXghIk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvddvgdeljecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepgfekhfehtedvtefhjeekiefghedtffeiveeffeetffetjeffheelhfdtueev
    jeeunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpghhithhhuhgsrdgtohhmnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegr
    rhhnuggsrdguvg
X-ME-Proxy: <xmx:BW-TY9oUNRpX6srPs89s6J1xeqv8xxkb0-L--6Jr2akYx0Bst3YHDg>
    <xmx:BW-TY_koMWMd7NOpyj0spxy059KcYohScqiYpblDfDfFmQn96aWfiA>
    <xmx:BW-TY13sjVYY3hlmml9rux9RC3-g_SKYDx7KSNrcfKQoUSZQT-_S5Q>
    <xmx:BW-TY2_6HACATG33gAPwGXwax5ZfAbRPOu92vJznvg2mZptwZothLQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 52F10B60086; Fri,  9 Dec 2022 12:23:17 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1115-g8b801eadce-fm-20221102.001-g8b801ead
Mime-Version: 1.0
Message-Id: <02be69ef-cfae-4455-a428-f95517d374cb@app.fastmail.com>
In-Reply-To: <257c9d3c-5bfa-4c5a-8ba3-11982a00b1d3@app.fastmail.com>
References: <257c9d3c-5bfa-4c5a-8ba3-11982a00b1d3@app.fastmail.com>
Date:   Fri, 09 Dec 2022 18:22:56 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Linus Torvalds" <torvalds@linux-foundation.org>
Cc:     soc@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL 4/4] SoC: DT changes for 6.2
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 8950f345a67d8046d2472dd6ea81fa18ef5b4=
844:

  ARM: dts: am335x-pcm-953: Define fixed regulators in root node (2022-1=
1-09 10:09:51 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-d=
t-6.2

for you to fetch changes up to c83ce312081cf024b00a8a7fe785a90ba94b69fb:

  Merge tag 'asahi-soc-dt-6.2-v3' of https://github.com/AsahiLinux/linux=
 into soc/dt (2022-12-08 17:44:12 +0100)

----------------------------------------------------------------
SoC: DT changes for 6.2

The devicetree changes contain exactly 1000 non-merge changesets,
including a number of new arm64 SoC variants from Qualcomm and Apple,
as well as the Renesas r9a07g043f/u chip in both arm64 and riscv variants
While we have occasionally merged support for non-arm SoCs in the past,
this is now the normal path for riscv devicetree files.

The most notable changes, by SoC platform, are:

 - The Apple T6000 (M1 Pro), T6001 (M1 Max) and T6002 (M2 Ultra)
   chips now have initial support. This is particularly nice as I am
   typing this on a T6002 Mac Studio with only a small number of driver
   patches.

 - Qualcomm MSM8996 Pro (Snapdragon 821), SM6115 (Snapdragon 662), SM4250
   (Snapdragon 460), SM6375 (Snapdragon 695), SDM670 (Snapdragon 670),
   MSM8976 (Snapdragon 652) and MSM8956 (Snapdragon 650) are all mobile
   phone chips that are closely related to others we already support.
   Adding those helps support more phones and we add several models
   from Sony (Xperia 10 IV, 5 IV, X, and X compact), OnePlus (One, 3,
   3T, and Nord N100), Xiaomi (Poco F1, Mi6), Huawei (Watch) and Google
   (Pixel 3a).  There are also new variants of the Herobrine and Trogdor
   chromebook motherboards.  SA8540P is an automotive SoC used in the
   Qdrive-3 development platform

 - Rockchips gains no new SoC variants, but a lot of new boards:
   three mobile gaming systems based on RK3326 Odroid-Go/rg351 family,
   two more Anbernic gaming systems based on RK3566 and a number of
   other RK356x based single-board computers.

 - Renesas RZ/G2UL (r9a07g043) was already supported for arm64, but as
   the newly added RZ/Five is based on the same design, this now gets
   reorganized in order to share most of the dts description between
   the two and add the RZ/Five SMARC EVK board support.

Aside from that, there are the usual changes all over the tree:

 - New boards on other platforms contain two ASpeed BMC users, two
   Broadcom based Wifi routers, Zyxel NSA310S NAS, the i.MX6 based Kobo
   Aura2 ebook reader, two i.MX8 based development boards, two Uniphier
   Pro5 development boards, the STM32MP1 testbench board from DHCOR,
   the TI K3 based BeagleBone AI-64 board, and the Mediatek Helio X10
   based Sony Xperia M5 phone.

 - The Starfive JH7100 source gets reorganized in order to support the
   VisionFive V1 board.

 - Minor updates and cleanups for Intel SoCFPGA, Marvell PXA168,
   TI, ST, NXP, Apple, Broadcom, Juno, Marvell MVEBU, at91, nuvoton,
   Tegra, Mediatek, Renesas, Hisilicon, Allwinner, Samsung, ux500,
   spear, ...  The treewide cleanups now have a lot of fixes for cache
   nodes and other binding violoations.

 - Somewhat larger sets of reworks for NVIDIA Tegra, Qualcomm
   and Renesas platforms, adding a lot more on-chip device support

 - A rework of the way that DTB overlays are built.

----------------------------------------------------------------
Aakarsh Jain (1):
      ARM: dts: exynos: Add new SoC specific compatible string for Exyno=
s3250 SoC

Adam Skladowski (10):
      arm64: dts: qcom: sm6115: Add cpufreq-hw support
      arm64: dts: qcom: sm6115: Add TSENS node
      arm64: dts: qcom: sm6115: Add PRNG node
      arm64: dts: qcom: sm6115: Add rpm-stats node
      arm64: dts: qcom: sm6115: Add dispcc node
      arm64: dts: qcom: sm6115: Add mdss/dpu node
      arm64: dts: qcom: sm6115: Add GPI DMA
      arm64: dts: qcom: sm6115: Add i2c/spi nodes
      arm64: dts: qcom: sm6115: Add WCN node
      arm64: dts: qcom: sm6115: Add smmu fallback to qcom generic compat=
ible

Adrian Alonso (1):
      arm64: dts: imx8mm-evk: add vcc supply for pca6416

Adriana Kobylak (1):
      ARM: dts: aspeed: rainier,everest: Move reserved memory regions

Akhil R (1):
      arm64: tegra: Add dma-channel-mask in GPCDMA node

Alex Elder (1):
      arm64: dts: qcom: sc7280-idp: don't modify &ipa twice

Alexander Stein (4):
      arm64: dts: tqma8mpql: add support for 2nd USB (host) interface
      arm64: dts: tqma8mq-mba8mx: Add vcc supply to i2c eeproms
      arm64: dts: tqma8mpql: add PCIe support
      arm64: dts: mba8mpxl: Add PWM fan support

Alexandre Torgue (2):
      ARM: dts: stm32: add fake interrupt propoerty for ASync notif - TE=
MP/TO REMOVE
      Revert "ARM: dts: stm32: add fake interrupt propoerty for ASync no=
tif - TEMP/TO REMOVE"

Alistair Francis (1):
      ARM: dts: imx7d-remarkable2: Enable silergy,sy7636a

Amelie Delaunay (8):
      ARM: dts: stm32: update vbus-supply of usbphyc_port0 on stm32mp157=
c-ev1
      ARM: dts: stm32: add USBPHYC and dual USB HS PHY support on stm32m=
p131
      ARM: dts: stm32: add UBSH EHCI and OHCI support on stm32mp131
      ARM: dts: stm32: add USB OTG HS support on stm32mp131
      ARM: dts: stm32: enable USB HS phys on stm32mp135f-dk
      ARM: dts: stm32: enable USB Host EHCI on stm32mp135f-dk
      ARM: dts: stm32: add mcp23017 pinctrl entry for stm32mp13
      ARM: dts: stm32: add mcp23017 IO expander on I2C1 on stm32mp135f-dk

Amjad Ouled-Ameur (2):
      arm64: dts: meson-gxl: add SPI pinctrl nodes for CLK
      arm64: dts: meson-gxbb: add SPI pinctrl nodes for CLK

Anand Moon (3):
      arm64: dts: meson: Enable active coling using gpio-fan on Odroid N=
2/N2+
      arm64: dts: rockchip: Add support of external clock to ethernet no=
de on Rock 3A SBC
      arm64: dts: rockchip: Add support of regulator for ethernet node o=
n Rock 3A SBC

Andre Przywara (11):
      dt-bindings: usb: Add H616 compatible string
      arm64: dts: allwinner: h616: Add USB nodes
      arm64: dts: allwinner: h616: OrangePi Zero 2: Add USB nodes
      arm64: dts: allwinner: h616: X96 Mate: Add USB nodes
      dt-bindings: pwm: allwinner,sun4i-a10: Add F1C100s compatible
      ARM: dts: suniv: f1c100s: add PWM node
      ARM: dts: suniv: f1c100s: add I2C DT nodes
      dt-bindings: media: IR: Add F1C100s IR compatible string
      ARM: dts: suniv: f1c100s: add CIR DT node
      ARM: dts: suniv: f1c100s: add LRADC node
      ARM: dts: sunxi: H3/H5: Add phys property to USB HCI0

Andreas Kemnade (5):
      dt-bindings: arm: fsl: add compatible string for Kobo Aura 2
      ARM: dts: imx: Add devicetree for Kobo Aura 2
      ARM: dts: imx6sl-tolino-shine2hd: Add backlight
      ARM: dts: imx6sl-tolino-shine2hd: Add backlight boost
      ARM: dts: imx: e60k02: Add touchscreen

Andrej Picej (1):
      ARM: dts: imx6ul/ull: suspend i.MX6UL watchdog in wait mode

Andrew Davis (49):
      kbuild: Allow DTB overlays to built from .dtso named source files
      kbuild: Allow DTB overlays to built into .dtbo.S files
      staging: pi433: overlay: Rename overlay source file from .dts to .=
dtso
      arm64: dts: ti: k3-am64: Enable UART nodes at the board level
      arm64: dts: ti: k3-am64: Enable I2C nodes at the board level
      arm64: dts: ti: k3-am64: Enable SPI nodes at the board level
      arm64: dts: ti: k3-am64: Enable EPWM nodes at the board level
      arm64: dts: ti: k3-am64: Enable ECAP nodes at the board level
      arm64: dts: ti: k3-am64: Enable PCIe nodes at the board level
      arm64: dts: ti: k3-am64: MDIO pinmux should belong to the MDIO node
      arm64: dts: ti: k3-am64: Enable MDIO nodes at the board level
      arm64: dts: ti: k3-am64: Enable MCAN nodes at the board level
      arm64: dts: ti: k3-am64: Enable GPMC and ELM nodes at the board le=
vel
      arm64: dts: ti: k3-am62: Enable UART nodes at the board level
      arm64: dts: ti: k3-am62: Enable I2C nodes at the board level
      arm64: dts: ti: k3-am62: Enable SPI nodes at the board level
      arm64: dts: ti: k3-am62: Enable EPWM nodes at the board level
      arm64: dts: ti: k3-am62: Enable ECAP nodes at the board level
      arm64: dts: ti: k3-am62: MDIO pinmux should belong to the MDIO node
      arm64: dts: ti: k3-am62: Enable MDIO nodes at the board level
      arm64: dts: ti: k3-am62: Enable MCAN nodes at the board level
      arm64: dts: ti: k3-am62: Enable SDHCI nodes at the board level
      arm64: dts: ti: k3-am62: Enable OSPI nodes at the board level
      arm64: dts: ti: k3-j721e: Enable UART nodes at the board level
      arm64: dts: ti: k3-j721e: Enable I2C nodes at the board level
      arm64: dts: ti: k3-j721e: Enable MCASP nodes at the board level
      arm64: dts: ti: k3-j721e: Enable MCAN nodes at the board level
      arm64: dts: ti: k3-j7200: Enable UART nodes at the board level
      arm64: dts: ti: k3-j7200: Enable I2C nodes at the board level
      arm64: dts: ti: k3-j721s2: Enable UART nodes at the board level
      arm64: dts: ti: k3-j721e: Enable Mailbox nodes at the board level
      arm64: dts: ti: k3-j7200: Enable Mailbox nodes at the board level
      arm64: dts: ti: k3-j721s2: Enable Mailbox nodes at the board level
      arm64: dts: ti: k3-j721s2: Enable MCAN nodes at the board level
      arm64: dts: ti: k3-j721s2: Enable I2C nodes at the board level
      arm64: dts: ti: k3-am65: Enable UART nodes at the board level
      arm64: dts: ti: k3-am65: Enable I2C nodes at the board level
      arm64: dts: ti: k3-am65: Enable SPI nodes at the board level
      arm64: dts: ti: k3-am65: Enable EPWM nodes at the board level
      arm64: dts: ti: k3-am65: Enable ECAP nodes at the board level
      arm64: dts: ti: k3-am65: MDIO pinmux should belong to the MDIO node
      arm64: dts: ti: k3-am65: Enable MDIO nodes at the board level
      arm64: dts: ti: k3-am65: Enable MCAN nodes at the board level
      arm64: dts: ti: k3-am65: Enable PCIe nodes at the board level
      arm64: dts: ti: k3-am65: Enable Mailbox nodes at the board level
      arm64: dts: ti: k3-am65: Enable McASP nodes at the board level
      kbuild: Cleanup DT Overlay intermediate files as appropriate
      arm64: dts: freescale: Rename DTB overlay source files from .dts t=
o .dtso
      arm64: dts: renesas: Rename DTB overlay source files from .dts to =
.dtso

Andrew Powers-Holmes (2):
      arm64: dts: rockchip: Add SOQuartz blade board
      arm64: dts: rockchip: Add SOQuartz Model A baseboard

Andy Yan (2):
      dt-bindings: rockchip: Add Rockchip rk3566 box demo board
      arm64: dts: rockchip: Add dts for rockchip rk3566 box demo board

AngeloGioacchino Del Regno (19):
      arm64: dts: mediatek: mt8195: Fix CPUs capacity-dmips-mhz
      arm64: dts: mt7896a: Fix unit_address_vs_reg warning for oscillator
      arm64: dts: mt6779: Fix devicetree build warnings
      arm64: dts: mt2712e: Fix unit_address_vs_reg warning for oscillato=
rs
      arm64: dts: mt2712e: Fix unit address for pinctrl node
      arm64: dts: mt2712-evb: Fix vproc fixed regulators unit names
      arm64: dts: mt2712-evb: Fix usb vbus regulators unit names
      arm64: dts: mediatek: pumpkin-common: Fix devicetree warnings
      arm64: dts: mediatek: mt6797: Fix 26M oscillator unit name
      arm64: dts: mediatek: mt6795: Add topckgen, infra, peri clocks/res=
ets
      arm64: dts: mediatek: mt6795: Replace UART dummy clocks with peric=
fg
      arm64: dts: mediatek: mt6795: Add support for APDMA and wire up UA=
RT DMAs
      arm64: dts: mediatek: mt6795: Add support for eMMC/SD/SDIO control=
lers
      dt-bindings: arm: mediatek: Add compatible for MT6795 Sony Xperia =
M5
      arm64: dts: mediatek: Add support for MT6795 Sony Xperia M5 smartp=
hone
      arm64: dts: qcom: Add configuration for PM8950 peripheral
      arm64: dts: qcom: Add configuration for PMI8950 peripheral
      arm64: dts: qcom: Add DTS for MSM8976 and MSM8956 SoCs
      arm64: dts: qcom: Add support for SONY Xperia X/X Compact

Arnd Bergmann (45):
      Merge tag 'renesas-arm-dt-for-v6.2-tag1' of git://git.kernel.org/p=
ub/scm/linux/kernel/git/geert/renesas-devel into soc/dt
      Merge tag 'renesas-dt-bindings-for-v6.2-tag1' of git://git.kernel.=
org/pub/scm/linux/kernel/git/geert/renesas-devel into soc/dt
      Merge tag 'dt-cleanup-6.2' of https://git.kernel.org/pub/scm/linux=
/kernel/git/krzk/linux-dt into soc/dt
      Merge tag 'at91-dt-6.2' of https://git.kernel.org/pub/scm/linux/ke=
rnel/git/at91/linux into soc/dt
      Merge tag 'asahi-soc-dt-6.2' of https://github.com/AsahiLinux/linu=
x into arm/dt
      Merge tag 'ux500-dts-for-v6.2' of git://git.kernel.org/pub/scm/lin=
ux/kernel/git/linusw/linux-nomadik into arm/dt
      Merge tag 'samsung-dt64-6.2' of https://git.kernel.org/pub/scm/lin=
ux/kernel/git/krzk/linux into soc/dt
      Merge tag 'at91-dt-6.2-2' of https://git.kernel.org/pub/scm/linux/=
kernel/git/at91/linux into soc/dt
      Merge tag 'sunxi-dt-for-6.2-1' of https://git.kernel.org/pub/scm/l=
inux/kernel/git/sunxi/linux into soc/dt
      Merge branch 'dt/dtbo-rename' of git://git.kernel.org/pub/scm/linu=
x/kernel/git/robh/linux into soc/dt
      Merge tag 'imx-bindings-6.2' of git://git.kernel.org/pub/scm/linux=
/kernel/git/shawnguo/linux into soc/dt
      Merge tag 'imx-dt-6.2' of git://git.kernel.org/pub/scm/linux/kerne=
l/git/shawnguo/linux into soc/dt
      Merge tag 'imx-dt64-6.2' of git://git.kernel.org/pub/scm/linux/ker=
nel/git/shawnguo/linux into soc/dt
      Merge tag 'hisi-arm64-dt-for-6.2' of https://github.com/hisilicon/=
linux-hisi into soc/dt
      Merge tag 'stm32-dt-for-v6.2-1' of git://git.kernel.org/pub/scm/li=
nux/kernel/git/atorgue/stm32 into soc/dt
      Merge tag 'renesas-dt-bindings-for-v6.2-tag2' of git://git.kernel.=
org/pub/scm/linux/kernel/git/geert/renesas-devel into soc/dt
      Merge tag 'renesas-riscv-dt-for-v6.2-tag1' of git://git.kernel.org=
/pub/scm/linux/kernel/git/geert/renesas-devel into soc/dt
      Merge tag 'renesas-arm-dt-for-v6.2-tag2' of git://git.kernel.org/p=
ub/scm/linux/kernel/git/geert/renesas-devel into soc/dt
      Merge tag 'riscv-dt-for-v6.2-mw0' of https://git.kernel.org/pub/sc=
m/linux/kernel/git/conor/linux into soc/dt
      Merge tag 'socfpga_dts_updates_for_v6.2' of git://git.kernel.org/p=
ub/scm/linux/kernel/git/dinguyen/linux into soc/dt
      Merge tag 'tegra-for-6.2-dt-bindings-v2' of git://git.kernel.org/p=
ub/scm/linux/kernel/git/tegra/linux into soc/dt
      Merge tag 'tegra-for-6.2-arm64-dt-v2' of git://git.kernel.org/pub/=
scm/linux/kernel/git/tegra/linux into soc/dt
      Merge tag 'v6.1-next-dts64' of https://git.kernel.org/pub/scm/linu=
x/kernel/git/matthias.bgg/linux into soc/dt
      Merge tag 'tegra-for-6.2-arm-dt' of git://git.kernel.org/pub/scm/l=
inux/kernel/git/tegra/linux into soc/dt
      Merge tag 'aspeed-6.2-devicetree' of git://git.kernel.org/pub/scm/=
linux/kernel/git/joel/bmc into soc/dt
      Merge tag 'ti-k3-dt-for-v6.2' of git://git.kernel.org/pub/scm/linu=
x/kernel/git/ti/linux into soc/dt
      Merge tag 'nuvoton-6.2-devicetree' of git://git.kernel.org/pub/scm=
/linux/kernel/git/joel/bmc into soc/dt
      Merge tag 'amlogic-arm64-dt-for-v6.2' of https://git.kernel.org/pu=
b/scm/linux/kernel/git/amlogic/linux into soc/dt
      Merge tag 'renesas-arm-dt-for-v6.2-tag3' of git://git.kernel.org/p=
ub/scm/linux/kernel/git/geert/renesas-devel into soc/dt
      Merge tag 'v6.2-rockchip-dts64-1' of git://git.kernel.org/pub/scm/=
linux/kernel/git/mmind/linux-rockchip into asahi-wip
      Merge tag 'qcom-arm64-for-6.2' of https://git.kernel.org/pub/scm/l=
inux/kernel/git/qcom/linux into soc/dt
      Merge tag 'omap-for-v6.2/dt-signed' of git://git.kernel.org/pub/sc=
m/linux/kernel/git/tmlind/linux-omap into soc/dt
      Merge tag 'musb-for-v6.2-signed' of git://git.kernel.org/pub/scm/l=
inux/kernel/git/tmlind/linux-omap into soc/dt
      Merge tag 'at91-dt-6.2-3' of https://git.kernel.org/pub/scm/linux/=
kernel/git/at91/linux into soc/dt
      Merge tag 'mvebu-dt64-6.2-1' of git://git.kernel.org/pub/scm/linux=
/kernel/git/gclement/mvebu into soc/dt
      Merge tag 'mvebu-dt-6.2-1' of git://git.kernel.org/pub/scm/linux/k=
ernel/git/gclement/mvebu into soc/dt
      Merge tag 'juno-updates-6.2' of git://git.kernel.org/pub/scm/linux=
/kernel/git/sudeep.holla/linux into soc/dt
      Merge tag 'arm-soc/for-6.2/devicetree' of https://github.com/Broad=
com/stblinux into soc/dt
      Merge tag 'arm-soc/for-6.2/devicetree-arm64' of https://github.com=
/Broadcom/stblinux into soc/dt
      Merge tag 'asahi-soc-dt-6.2-v2' of https://github.com/AsahiLinux/l=
inux into soc/dt
      Merge tag 'dt-cleanup-6.2-2' of https://git.kernel.org/pub/scm/lin=
ux/kernel/git/krzk/linux-dt into soc/dt
      Merge tag 'socfpga_dts_updates_for_v6.2_part2' of git://git.kernel=
.org/pub/scm/linux/kernel/git/dinguyen/linux into soc/dt
      Merge tag 'qcom-arm64-for-6.2-2' of https://git.kernel.org/pub/scm=
/linux/kernel/git/qcom/linux into soc/dt
      Merge tag 'qcom-dts-for-6.2-2' of https://git.kernel.org/pub/scm/l=
inux/kernel/git/qcom/linux into soc/dt
      Merge tag 'asahi-soc-dt-6.2-v3' of https://github.com/AsahiLinux/l=
inux into soc/dt

Asahi Lina (2):
      arm64: dts: apple: t600x-pmgr: Fix search & replace typo
      arm64: dts: apple: t6002: Fix GPU power domains

Aurelien Jarno (11):
      arm64: dts: rockchip: add thermal support to ODROID-M1
      arm64: dts: rockchip: Add NOR flash to ODROID-M1
      arm64: dts: rockchip: Add analog audio on ODROID-M1
      arm64: dts: rockchip: Enable vop2 and hdmi tx on ODROID-M1
      arm64: dts: rockchip: Enable HDMI audio on ODROID-M1.
      arm64: dts: rockchip: Enable the GPU on ODROID-M1
      arm64: dts: rockchip: Enable the USB 2.0 ports on ODROID-M1
      arm64: dts: rockchip: Enable the USB 3.0 ports on ODROID-M1
      arm64: dts: rockchip: Add SATA support to ODROID-M1
      arm64: dts: rockchip: Add PCIEe v3 nodes to ODROID-M1
      arm64: dts: rockchip: Add IR receiver node to ODROID-M1

Biju Das (2):
      arm64: dts: renesas: r9a09g011: Add L2 Cache node
      arm64: dts: renesas: r9a09g011: Add system controller node

Bjorn Andersson (8):
      Merge branch '20220818220628.339366-8-robimarko@gmail.com' into HE=
AD
      arm64: dts: qcom: sc8280xp-x13s: Add LID switch
      Merge branch 'arm64-fixes-for-6.1' into HEAD
      arm64: dts: qcom: sa8295p-adp: Add RTC node
      arm64: dts: qcom: Align with generic osm-l3/epss-l3
      arm64: dts: qcom: sc8280xp: Add epss_l3 node
      arm64: dts: qcom: sc8280xp: Set up L3 scaling
      arm64: dts: qcom: sc8280xp: Add bwmon instances

Bo-Chen Chen (4):
      arm64: dts: mt8195: Add dp-intf nodes
      arm64: dts: mt8195: Add edptx and dptx nodes
      arm64: dts: mediatek: cherry: Add dp-intf ports
      arm64: dts: mediatek: cherry: Add edptx and dptx support

Brian Masney (1):
      arm64: dts: qcom: sa8540p-ride: enable PCIe support

Bryan O'Donoghue (18):
      ARM: dts: qcom: apq8064: Drop redundant phy-names from DSI control=
ler
      ARM: dts: qcom: msm8974: Drop redundant phy-names from DSI control=
ler
      arm64: dts: qcom: msm8916: Drop redundant phy-names from DSI contr=
oller
      arm64: dts: qcom: msm8996: Drop redundant phy-names from DSI contr=
oller
      arm64: dts: qcom: sc7180: Drop redundant phy-names from DSI contro=
ller
      arm64: dts: qcom: sc7280: Drop redundant phy-names from DSI contro=
ller
      arm64: dts: qcom: sdm660: Drop redundant phy-names from DSI contro=
ller
      arm64: dts: qcom: sdm630: Drop redundant phy-names from DSI contro=
ller
      arm64: dts: qcom: sdm845: Drop redundant phy-names from DSI contro=
ller
      arm64: dts: qcom: sm8250: Drop redundant phy-names from DSI contro=
ller
      arm64: dts: qcom: msm8916: Fix lpass compat string to match yaml
      arm64: dts: qcom: sdm845: Define the number of available ports
      arm64: dts: qcom: sdm845-db845c: Drop redundant address-cells, siz=
e-cells declaration
      arm64: dts: qcom: sdm845-db845c: Drop redundant reg =3D in port
      arm64: dts: qcom: sdm845-db845c: Use okay not ok, disabled not dis=
able for status
      arm64: dts: qcom: sdm845-db845c-navigation-mezzanine: Add navigati=
on mezzanine dts
      arm64: dts: qcom: sm8250: camss: Define ports and ports address/si=
ze cells
      arm64: dts: qcom: qrb5165-rb5-vision-mezzanine: Add vision mezzani=
ne

Caleb Connolly (6):
      arm64: dts: qcom: sdm845: commonize bluetooth UART pinmux
      arm64: dts: qcom: sdm845-*: fix uart6 aliases
      arm64: dts: qcom: pmi8998: add rradc node
      arm64: dts: qcom: sdm845-oneplus: enable rradc
      arm64: dts: qcom: sdm845-db845c: enable rradc
      arm64: dts: qcom: sdm845-xiaomi-beryllium: enable rradc

Chris Morgan (5):
      dt-bindings: arm: rockchip: Add Anbernic RG353V and RG353VS
      arm64: dts: rockchip: add Anbernic RG353V and RG353VS
      arm64: dts: rockchip: add rk817 chg to RG353P and RG503
      arm64: dts: rockchip: add poll-interval to RGxx3 devices
      arm64: dts: rockchip: Update joystick to polled for OG2

Chris Packham (1):
      ARM: dts: armada-xp: add interrupts for watchdog

Christian Marangi (2):
      ARM: dts: qcom: ipq8064: disable mmc-ddr-1_8v for sdcc1
      arm64: dts: qcom: ipq6018: improve pcie phy pcs reg table

Chukun Pan (2):
      arm64: dts: rockchip: Add regulator suffix to rock-3a
      arm64: dts: rockchip: Add PCIe v3 nodes to rock-3a

Clark Wang (1):
      ARM64: dts: imx8mp-evk: add pwm support

Claudiu Beznea (7):
      ARM: dts: at91: sama7g5: add otpc node
      ARM: dts: at91: sama7g5: add io-channel-cells to adc node
      ARM: dts: at91: sama7g5: add cells for temperature calibration
      ARM: dts: at91: sama7g5: add temperature sensor
      ARM: dts: at91: sama7g5: add thermal zones node
      ARM: dts: at91: sama7g5: use generic name for securam
      ARM: dts: at91: sam9x60ek: remove status =3D "okay" for regulators

CongDang (2):
      arm64: dts: renesas: r8a779g0: Add PWM device nodes
      arm64: dts: renesas: r8a779g0: Add TPU device node

Conor Dooley (8):
      riscv: dts: microchip: add the mpfs' fabric clock control
      riscv: dts: microchip: fix memory node unit address for icicle
      dt-bindings: pwm: fix microchip corePWM's pwm-cells
      riscv: dts: microchip: fix the icicle's #pwm-cells
      Merge branch 'riscv-visionfive_v1' into riscv-dt-for-next
      riscv: dts: microchip: remove pcie node from the sev kit
      riscv: dts: microchip: remove unused pcie clocks
      Merge branch 'riscv-thead_c9xx' into riscv-dt-for-next

Corentin Labbe (3):
      clk: rockchip: use proper crypto0 name on rk3399
      arm64: dts: rockchip: add rk3328 crypto node
      arm64: dts: rockchip: rk3399: add crypto node

Cristian Ciocaltea (3):
      dt-bindings: riscv: starfive: Add StarFive VisionFive V1 board
      riscv: dts: starfive: Add common DT for JH7100 based boards
      riscv: dts: starfive: Add StarFive VisionFive V1 device tree

Detlev Casanova (1):
      ARM: dts: imx6qdl-sabre: Add mmc aliases

Dinh Nguyen (4):
      arm: dts: socfpga: align mmc node names with dtschema
      arm: dts: socfpga: remove "clk-phase" in sdmmc_clk
      arm: dts: socfpga: Add clk-phase-sd-hs property to the sdmmc node
      arm64: dts: socfpga: Add clk-phase-sd-hs property to the sdmmc node

Dipen Patel (1):
      arm64: tegra: Enable GTE nodes

Dmitry Baryshkov (56):
      ARM: dts: qcom: apq8064: disable HDMI nodes by default
      ARM: dts: qcom: apq8064-ifc6410: use labels to patch device tree
      ARM: dts: qcom: apq8064-ifc6410: pull ext-3p3v regulator from soc =
node
      ARM: dts: qcom: apq8064-ifc6410: fix user1 LED node name
      ARM: dts: qcom: apq8064-ifc6410: pull SDCC pwrseq node up one level
      ARM: dts: qcom: apq8064-flo: use labels to patch device tree
      ARM: dts: qcom: apq8064-nexus7-flo: fix node name for ext 3p3v reg=
ulator
      ARM: dts: qcom: apq8064-cm-qs600: use labels to patch device tree
      ARM: dts: qcom: apq8064-cm-qs600: pull 3p3v regulator from soc node
      ARM: dts: qcom: apq8064-cm-qs600: pull SDCC pwrseq node up one lev=
el
      ARM: dts: qcom: apq8064-sony-xperia-lagan-yuga: use labels to patc=
h device tree
      ARM: dts: qcom: apq8064: drop amba device node
      ARM: dts: qcom: apq8064: drop unit ids from PMIC nodes
      ARM: dts: qcom: apq8064: drop qcom, prefix from SSBI node name
      ARM: dts: qcom: apq8064: fix the riva-pil node id
      ARM: dts: qcom: msm8960: drop unit ids from PMIC nodes
      ARM: dts: qcom: msm8960: drop qcom, prefix from SSBI node name
      ARM: dts: qcom: msm8960-cdp: drop unit ids from regulator node
      ARM: dts: qcom: msm8960: drop amba device node
      ARM: dts: qcom: msm8660: move pm8058 LED devices to the main DT fi=
le
      ARM: dts: qcom: apq8060-dragonboard: use labels to patch device tr=
ee
      ARM: dts: qcom: msm8660: drop unit ids from PMIC nodes
      ARM: dts: qcom: msm8660: drop qcom, prefix from SSBI node name
      dt-bindings: arm: qcom: separate msm8996pro bindings
      arm64: dts: qcom: msm8996: fix supported-hw in cpufreq OPP tables
      arm64: dts: qcom: msm8996: add support for speed bin 3
      arm64: dts: qcom: msm8996: fix GPU OPP table
      arm64: dts: qcom: msm8996pro: expand Adreno OPP table
      ARM: dts: qcom-apq8064: change DSI PHY node name to generic one
      ARM: dts: qcom-msm8974: change DSI PHY node name to generic one
      arm64: dts: qcom: sdm845: switch usb_1 phy to use combo usb+dp phy
      arm64: dts: qcom: sdm845: add displayport node
      arm64: dts: qcom: sm8450: add display clock controller
      arm64: dts: qcom: w737: correct firmware paths
      arm64: dts: qcom: miix-630: correct firmware paths
      arm64: dts: qcom: ifc6560: correct firmware paths
      arm64: dts: qcom: sagami: correct firmware paths
      arm64: dts: qcom: pdx223: correct firmware paths
      arm64: dts: qcom: nile: correct firmware paths
      arm64: dts: qcom: msm8916: change DSI PHY node name to generic one
      arm64: dts: qcom: msm8996: change DSI PHY node name to generic one
      arm64: dts: qcom: sc7180: change DSI PHY node name to generic one
      arm64: dts: qcom: sdm630: change DSI PHY node name to generic one
      arm64: dts: qcom: sdm660: change DSI PHY node name to generic one
      arm64: dts: qcom: sdm845: change DSI PHY node name to generic one
      arm64: dts: qcom: sm8250: change DSI PHY node name to generic one
      arm64: dts: qcom: msm8996: change HDMI PHY node name to generic one
      ARM: dts: qcom-apq8064: change HDMI PHY node name to generic one
      ARM: dts: qcom-ipq8064: use pll4 clock for the gcc device
      dt-bindings: qcom: add another exception to the device naming rule
      ARM: dts: qcom: mdm9615: drop unit ids from PMIC nodes
      arm64: dts: qcom: msm8996: use hdmi_phy for the MMCC's hdmipll clo=
ck
      arm64: dts: qcom: msm8996: use dsi1_phy for the MMCC's dsi1 clocks
      arm64: dts: qcom: msm8996: change order of SMMU clocks on this pla=
tform
      dt-bindings: arm: qcom: split MSM8974 Pro and MSM8974
      arm: dts: qcom: use qcom,msm8974pro for pro devices

Dmitry Torokhov (7):
      arm64: dts: qcom: msm8916-samsung-a2015: fix polarity of "enable" =
line of NFC chip
      ARM: dts: vf610-zii-dev-rev-c: fix polarity of at86rf233 reset line
      arm64: dts: qcom: msm8996: fix sound card reset line polarity
      arm64: dts: qcom: sm8250-mtp: fix reset line polarity
      arm64: dts: qcom: sc7280: fix codec reset line polarity for CRD 3.=
0/3.1
      arm64: dts: qcom: sc7280: fix codec reset line polarity for CRD 1.=
0/2.0
      ARM: mvebu: switch to using gpiod API in pm-board code

Dongjin Kim (2):
      dt-bindings: rockchip: Add Hardkernel ODROID-M1 board
      arm64: dts: rockchip: Add Hardkernel ODROID-M1 board

Doug Brown (1):
      ARM: dts: pxa168: add timer reset and clock

Douglas Anderson (2):
      arm64: dts: qcom: sc7280: Villager doesn't have NVME
      arm64: dts: qcom: sc7280: Make herobrine-audio-rt5682 mic dtsi's m=
atch more

Dylan Van Assche (1):
      arm64: dts: qcom: sdm845-shift-axolotl: fix Bluetooth

Dzmitry Sankouski (4):
      dt-bindings: arm: add samsung,starqltechn board based on sdm845 ch=
ip
      arm64: dts: qcom: starqltechn: add initial device tree for starqlt=
echn
      dt-bindings: arm: add xiaomi,sagit board based on msm8998 chip
      arm64: dts: qcom: sagit: add initial device tree for sagit

Eddie James (2):
      ARM: dts: aspeed: Add IBM Bonnell system BMC devicetree
      ARM: dts: aspeed: p10bmc: Add occ-hwmon nodes

Emil Renner Berthing (1):
      riscv: dts: microchip: icicle: Add GPIO controlled LEDs

Eugen Hristev (1):
      ARM: dts: at91: sama7g5ek: align power rails for sdmmc0/1

FUKAUMI Naoki (1):
      arm64: dts: rockchip: enable tsadc for ROCK 4C+

Fabio Estevam (4):
      dt-bindings: vendor-prefixes: Add an entry for Cloos
      dt-bindings: arm: fsl: Add an entry for Cloos PHG board
      arm64: dts: imx8mm-phg: Add initial board support
      arm64: tegra: Remove 'enable-active-low'

Fabrice Gasnier (5):
      ARM: dts: stm32: add support for USB2514B onboard hub on stm32mp15=
7c-ev1
      ARM: dts: stm32: add PWR fixed regulators on stm32mp131
      ARM: dts: stm32: add fixed regulators to support usb on stm32mp135=
f-dk
      ARM: dts: stm32: add pins for stm32g0 typec controller on stm32mp13
      ARM: dts: stm32: enable USB OTG in dual role mode on stm32mp135f-dk

Fabrizio Castro (4):
      arm64: dts: renesas: r9a09g011: Fix unit address format error
      arm64: dts: renesas: r9a09g011: Fix I2C SoC specific strings
      arm64: dts: renesas: r9a09g011: Add watchdog node
      arm64: dts: renesas: rzv2mevk2: Enable watchdog

Frank Li (7):
      arm64: dts: imx8dxl: add usb1 and usb2 support
      arm64: dts: imx8dxl: add adc0 support
      arm64: dts: imx8dxl_evk: add adc0 support
      arm64: dts: imx8dxl: add flexspi0 support
      arm64: dts: imx8dxl_evk: add flexspi0 support
      arm64: dts: imx8dxl: add lpspi support
      arm64: dts: imx8dxl_evk: add lpspi0 support

Frank Rowand (1):
      of: overlay: rename overlay source files from .dts to .dtso

Frank Wunderlich (7):
      arm64: dts: mediatek: mt2712e: swap last 2 clocks to match binding
      arm64: dts: mt8183: drop drv-type from mmc-node
      arm64: dts: mt7622: drop r_smpl property from mmc node
      arm64: dts: mt7986: fix trng node name
      arm64: dts: mt7986: add i2c node
      dt-bindings: arm64: dts: mediatek: add compatible for bananapi r3
      arm64: dts: mt7986: move wed_pcie node

Furkan Kardame (1):
      arm64: dts: rockchip: enable pcie2 on rk3566-roc-pc

Geert Uytterhoeven (18):
      arm64: dts: renesas: r8a779g0: Add DMA support
      arm64: dts: renesas: r8a779g0: Add MSIOF nodes
      arm64: dts: renesas: r8a779g0: Add INTC-EX node
      arm64: dts: renesas: white-hawk-cpu: Add PCA9654 I/O Expander
      arm64: dts: renesas: r8a779g0: Fix HSCIF0 "brg_int" clock
      arm64: dts: renesas: r8a779g0: Add SDHI node
      arm64: dts: renesas: r8a779g0: Add SCIF nodes
      arm64: dts: renesas: r8a779g0: Add remaining HSCIF nodes
      arm64: dts: renesas: r8a779a0: Update to R-Car Gen4 compatible val=
ues
      ARM: dts: renesas: Miscellaneous whitespace fixes
      arm64: dts: renesas: r8a779g0: Add L3 cache controller
      arm64: dts: renesas: r8a779g0: Add secondary CA76 CPU cores
      arm64: dts: renesas: r8a779g0: Add CPUIdle support
      arm64: dts: renesas: r8a779g0: Add CPU core clocks
      arm64: dts: renesas: r8a779g0: Add CA76 operating points
      Merge branch 'dt/dtbo-rename' of git://git.kernel.org/pub/scm/linu=
x/kernel/git/robh/linux into renesas-arm-dt-for-v6.2
      ARM: dts: am335x: Fix TDA998x ports addressing
      ARM: dts: socfpga: Fix pca9548 i2c-mux node name

Guido G=C3=BCnther (2):
      arm64: dts: librem5-devkit: Make LED use PWM
      arm64: dts: librem5-devkit: Use function and color rather than lab=
el

Hai Pham (2):
      arm64: dts: renesas: r8a779g0: Add RPC node
      arm64: dts: renesas: white-hawk-cpu: Add QSPI FLASH support

Haibo Chen (2):
      arm64: dts: imx93: add gpio alises
      arm64: dts: imx8m[m,q]-evk: change to use off-on-delay-us in regul=
ator

Han Xu (1):
      arm64: dts: imx8mp-evk: enable fspi nor on imx8mp evk

Harry Austen (4):
      arm64: dts: qcom: msm8996: standardize blsp indexing
      arm64: dts: qcom: msm8996: add blsp1_i2c6 node
      dt-bindings: arm: qcom: add oneplus3(t) devices
      arm64: dts: qcom: msm8996: add support for oneplus3(t)

Hector Martin (8):
      arm64: dts: apple: Fix j45x model years
      arm64: dts: apple: Add initial t6000/t6001/t6002 DTs
      arm64: dts: apple: Add J314 and J316 devicetrees
      MAINTAINERS: Add entries for Apple SoC cpufreq driver
      dt-bindings: cpufreq: apple,soc-cpufreq: Add binding for Apple SoC=
 cpufreq
      arm64: dts: apple: Add CPU topology & cpufreq nodes for t8103
      arm64: dts: apple: Add CPU topology & cpufreq nodes for t600x
      arm64: dts: apple: Rename dart-sio* to sio-dart*

Heiko Stuebner (2):
      Merge branch 'v6.2-shared/clockids' into v6.2-armsoc/dts64
      arm64: dts: rockchip: fix spdif@fe460000 ordering on rk356x

Horatiu Vultur (2):
      ARM: dts: lan966x: Add interrupt support for PHYs on pcb8290
      ARM: dts: lan966x: Add otp support

Iskren Chernev (4):
      dt-bindings: arm: qcom: Add compatible for oneplus,billie2 phone
      arm64: dts: qcom: sm6115: Add basic soc dtsi
      arm64: dts: qcom: sm4250: Add soc dtsi
      arm64: dts: qcom: sm4250: Add support for oneplus-billie2

James Clark (1):
      arm64: dts: fvp: Add SPE to Foundation FVP

Jami Kettunen (1):
      arm64: dts: qcom: msm8998-oneplus-common: enable RRADC

Janne Grunau (7):
      dt-bindings: apple,aic2: Add CPU PMU per-cpu pseudo-interrupts
      dt-bindings: arm: apple: Add t6001/t6002 Mac Studio compatibles
      arm64: dts: apple: Add J375 devicetrees
      arm64: dts: apple: t600x: Add MCA and its support
      arch: arm64: apple: t8103: Use standard "iommu" node name
      arch: arm64: apple: t600x: Use standard "iommu" node name
      arm64: dts: apple: Add t8103 L1/L2 cache properties and nodes

Jayesh Choudhary (8):
      arm64: dts: ti: k3-am65-main: Drop dma-coherent in crypto node
      arm64: dts: ti: k3-j721e-main: Drop dma-coherent in crypto node
      arm64: dts: ti: k3-j7200-mcu-wakeup: Drop dma-coherent in crypto n=
ode
      arm64: dts: ti: j721e-common-proc-board: Fix sound node-name
      arm64: dts: ti: k3-am65-main: Drop RNG clock
      arm64: dts: ti: k3-j721e-main: Drop RNG clock
      arm64: dts: ti: k3-am64-main: Drop RNG clock
      arm64: dts: ti: k3-j721s2-main: Enable crypto accelerator

Jiucheng Xu (1):
      arm64: dts: meson: Add DDR PMU node

Job Noorman (1):
      arm64: dts: qcom: sdm632: fairphone-fp3: add touchscreen

Joel Selvaraj (3):
      arm64: dts: qcom: split beryllium dts into common dtsi and tianma =
dts
      dt-bindings: arm: qcom: Add Xiaomi Poco F1 EBBG variant bindings
      arm64: dts: qcom: sdm845-xiaomi-beryllium-ebbg: introduce Xiaomi P=
oco F1 EBBG variant

Joel Stanley (1):
      ARM: dts: aspeed: Remove Mihawk

Johan Hovold (26):
      arm64: dts: qcom: sc8280xp: add rpmh-stats node
      arm64: dts: qcom: sc8280xp: add TCSR node
      arm64: dts: qcom: sm8150: fix UFS PHY registers
      arm64: dts: qcom: sm8250: fix UFS PHY registers
      arm64: dts: qcom: sm8350: fix UFS PHY registers
      arm64: dts: qcom: sm8450: fix UFS PHY registers
      arm64: dts: qcom: sm8250: drop bogus DP PHY clock
      arm64: dts: qcom: sm6350: drop bogus DP PHY clock
      arm64: dts: qcom: sc8280xp: fix USB MP QMP PHY nodes
      arm64: dts: qcom: sc8280xp/sa8540p: add PCIe2-4 nodes
      arm64: dts: qcom: sa8295p-adp: enable PCIe
      arm64: dts: qcom: sc8280xp-crd: rename backlight and misc regulato=
rs
      arm64: dts: qcom: sc8280xp-crd: enable NVMe SSD
      arm64: dts: qcom: sc8280xp-crd: enable SDX55 modem
      arm64: dts: qcom: sc8280xp-crd: enable WiFi controller
      arm64: dts: qcom: sc8280xp-x13s: enable NVMe SSD
      arm64: dts: qcom: sc8280xp-x13s: enable modem
      arm64: dts: qcom: sc8280xp-x13s: enable WiFi controller
      arm64: dts: qcom: sc8280xp: fix PCIe DMA coherency
      arm64: dts: qcom: sc8280xp: fix UFS reference clocks
      arm64: dts: qcom: sc8280xp: update UFS PHY nodes
      arm64: dts: qcom: sc8280xp: drop reference-clock source
      arm64: dts: qcom: sm6350: fix USB-DP PHY registers
      arm64: dts: qcom: sm8250: fix USB-DP PHY registers
      arm64: dts: qcom: clean up 'regulator-allowed-modes' indentation
      arm64: dts: qcom: sc8280xp: fix UFS DMA coherency

Jon Hunter (6):
      dt-bindings: tegra: Update headers for Tegra234
      arm64: tegra: Remove unused property for I2C
      arm64: tegra: Populate Tegra234 PWMs
      arm64: tegra: Add PWM fan for Jetson AGX Orin
      arm64: tegra: Add SBSA UART for Tegra234
      arm64: tegra: Update console for Jetson Xavier and Orin

Jonathan Neusch=C3=A4fer (7):
      ARM: dts: nuvoton,wpcm450-supermicro-x9sci-ln4f: Add GPIO line nam=
es
      ARM: dts: nuvoton: Remove bogus unit addresses from fixed-partitio=
n nodes
      ARM: dts: wpcm450: Add FIU SPI controller node
      ARM: dts: wpcm450-supermicro-x9sci-ln4f: Add SPI flash
      ARM: dts: wpcm450: Add clock controller node
      ARM: dts: wpcm450: Enable watchdog by default
      ARM: dts: nuvoton: wpcm450: Add missing aliases for serial0/serial1

Judy Hsiao (3):
      arm64: dts: qcom: sc7280: herobrine: Add pinconf settings for mi2s1
      arm64: dts: qcom: sc7280: Add sc7280-herobrine-audio-rt5682.dtsi
      arm64: dts: qcom: sc7280: Include sc7280-herobrine-audio-rt5682.dt=
si in herobrine-r1

Julian Goldsmith (1):
      ARM: dts: qcom: msm8974: Add OnePlus One

Keerthy (1):
      arm64: dts: ti: k3-j721s2: Fix the interrupt ranges property for m=
ain & wkup gpio intr

Konrad Dybcio (46):
      arm64: dts: qcom: sm8250-edo: Add NXP PN553 NFC
      arm64: dts: qcom: msm8998-yoshino: Fix up SMD regulators formatting
      MAINTAINERS: Update Konrad Dybcio's email address
      arm64: dts: qcom: msm/apq8x16-*: Fix up comments
      arm64: dts: qcom: msm/apq8x96-*: Fix up comments
      arm64: dts: qcom: msm8953: Fix up comments
      arm64: dts: qcom: msm8998-*: Fix up comments
      arm64: dts: qcom: sc8280xp-x13s: Fix up comments
      arm64: dts: qcom: sdm845-*: Fix up comments
      arm64: dts: qcom: ipq8074-*: Fix up comments
      arm64: dts: qcom: msm8992-*: Fix up comments
      arm64: dts: qcom: msm8994-*: Fix up comments
      arm64: dts: qcom: qcs404-*: Fix up comments
      arm64: dts: qcom: pm6150/l/pm7325/pms405: Fix up comments
      dt-bindings: arm: cpus: Add Kryo 660 CPUs
      dt-bindings: arm: qcom: Document SM6375 & Xperia 10 IV
      arm64: dts: qcom: Add initial device tree for SM6375
      arm64: dts: qcom: Add device tree for Sony Xperia 10 IV
      arm64: dts: qcom: sm8350-sagami: Add most RPMh regulators
      arm64: dts: qcom: sm8350-sagami: Wire up USB regulators and fix US=
B3
      arm64: dts: qcom: sdm845-polaris: Don't duplicate DMA assignment
      dt-bindings: arm: qcom: Add Xperia 5 IV (PDX224)
      arm64: dts: qcom: sm8450-nagara: Separate out Nagara platform dtsi
      arm64: dts: qcom: sm8450: Add Xperia 5 IV support
      arm64: dts: qcom: sm8450-nagara: Add Samsung touchscreen
      arm64: dts: qcom: pmk8350: Allow specifying arbitrary SID
      arm64: dts: qcom: sm6375: Add GPI DMA nodes
      arm64: dts: qcom: sm6375: Add pin configs for some QUP configurati=
ons
      arm64: dts: qcom: sm6375: Add QUPs and corresponding SPI/I2C hosts
      arm64: dts: qcom: sm6375: Add SDHCI2
      arm64: dts: qcom: sm6375-pdx225: Enable QUPs & GPI DMA
      arm64: dts: qcom: sm6375-pdx225: Add PMIC peripherals
      arm64: dts: qcom: sm6375-pdx225: Configure SMD RPM regulators
      arm64: dts: qcom: sm6375-pdx225: Configure Samsung touchscreen
      arm64: dts: qcom: sm6375-pdx225: Enable SD card slot
      arm64: dts: qcom: sm6375: Add SMP2P for ADSP&CDSP
      arm64: dts: qcom: sm6375: Add ADSP&CDSP
      arm64: dts: qcom: sm6375-pdx225: Enable ADSP & CDSP
      arm64: dts: qcom: sm8450: Use defines for power domain indices
      arm64: dts: qcom: sm8150: Use defines for power domain indices
      arm64: dts: qcom: pmk8350: Specify PBS register for PON
      arm64: dts: qcom: sm8350: Add SDHCI2
      arm64: dts: qcom: sm8350-sagami: Add GPIO line names for TLMM
      arm64: dts: qcom: sm8350-sagami: Wire up SDHCI2
      arm64: dts: qcom: msm8994: Drop spi-max-frequency from SPI host
      arm64: dts: qcom: sm8450-nagara: Add gpio line names for TLMM

Konstantin Porotchkin (1):
      arm64: dts: marvell: add optee FW definitions

Kory Maincent (2):
      arm: dts: spear600: Fix clcd interrupt
      arm: dts: spear600: Add ssp controller nodes

Krishna Kurapati (2):
      arm64: dts: qcom: sc7280: Update SNPS Phy params for SC7280
      arm64: dts: qcom: sc7280: Update SNPS Phy params for SC7280 IDP de=
vice

Krzysztof Kozlowski (131):
      ARM: dts: ste: ux500: align SPI node name with dtschema
      arm64: dts: qcom: align RPM regulators node name with bindings
      arm64: dts: qcom: sdm630: align APR services node names with dtsch=
ema
      arm64: dts: qcom: sdm845: align APR services node names with dtsch=
ema
      arm64: dts: qcom: sm8250: align APR services node names with dtsch=
ema
      arm64: dts: qcom: msm8996: fix APR services nodes
      arm64: dts: qcom: sdm845: align dai node names with dtschema
      arm64: dts: qcom: msm8996: align dai node names with dtschema
      arm64: dts: qcom: qrb5165-rb5: align dai node names with dtschema
      arm64: dts: qcom: sm8250: use generic name for LPASS clock control=
ler
      arm64: dts: qcom: sm8150: align TLMM pin configuration with DT sch=
ema
      arm64: dts: qcom: ipq6018-cp01-c1: use BLSPI1 pins
      arm64: dts: qcom: ipq6018: align TLMM pin configuration with DT sc=
hema
      arm64: dts: qcom: sm8250: align TLMM pin configuration with DT sch=
ema
      arm64: dts: qcom: sm8250-sony-xperia-edo: fix touchscreen bias-dis=
able
      arm64: dts: qcom: sc8280xp: align TLMM pin configuration with DT s=
chema
      arm64: dts: qcom: sc7280: align TLMM pin configuration with DT sch=
ema (really)
      arm64: dts: qcom: sc7280-herobrine: correct number of gpio-line-na=
mes
      arm64: dts: qcom: sc7280-idp-ec-h1: add missing QUP GPIO functions
      arm64: dts: qcom: msm8953: align TLMM pin configuration with DT sc=
hema
      arm64: dts: qcom: sdm845: align TLMM pin configuration with DT sch=
ema
      arm64: dts: qcom: sm6125-sony-xperia: add missing SD CD GPIO funct=
ions
      arm64: dts: qcom: sm6125: align TLMM pin configuration with DT sch=
ema
      arm64: dts: qcom: sdm850-lenovo-yoga-c630: correct I2C12 pins driv=
e strength
      arm64: dts: qcom: sdm850-samsung-w737: correct I2C12 pins drive st=
rength
      arm64: dts: qcom: sdm845-xiaomi-polaris: fix codec pin conf name
      ARM: dts: qcom: align RPM regulators node name with bindings
      ARM: dts: qcom: sdx55: add gpio-ranges to TLMM pinctrl
      ARM: dts: qcom: sdx55: align TLMM pin configuration with DT schema
      ARM: dts: qcom: msm8226: align TLMM pin configuration with DT sche=
ma
      ARM: dts: qcom: msm8974: align TLMM pin configuration with DT sche=
ma
      ARM: dts: qcom: use generic node name "gpio" in SPMI PMIC
      ARM: dts: am335x: drop panel endpoint unit address
      ARM: dts: sunplus: sp7021: drop incorrect spi-max-frequency
      ARM: dts: qcom: msm8974: add missing TCSR syscon compatible
      ARM: dts: qcom: msm8974: switch TCSR mutex to MMIO
      ARM: dts: qcom: correct indentation
      arm64: dts: qcom: sdm630: fix UART1 pin bias
      arm64: dts: qcom: sdm845-db845c: correct SPI2 pins drive strength
      arm64: dts: qcom: sdm845-cheza: fix AP suspend pin bias
      arm64: dts: qcom: correct white-space before {
      arm64: dts: qcom: use generic node name "gpio" in SPMI PMIC
      arm64: dts: qcom: sdm845: drop unused slimbus properties
      arm64: dts: qcom: msm8996: drop unused slimbus reg-mames
      arm64: dts: qcom: sdm845: correct slimbus children unit addresses
      arm64: dts: qcom: mms8996: correct slimbus children unit addresses
      arm64: dts: qcom: sdm845: drop unused slimbus dmas
      arm64: dts: qcom: msm8996: drop unused slimbus dmas
      arm64: dts: qcom: sdm845: align node names with DT schema
      arm64: dts: qcom: msm8996: align node names with DT schema
      dt-bindings: qcom: document preferred compatible naming
      arm64: dts: qcom: sdm630: add UART pin functions
      arm64: dts: qcom: sdm630: correct I2C8 pin functions
      arm64: dts: qcom: sdm630: align TLMM pin configuration with DT sch=
ema
      arm64: dts: qcom: msm8998: add gpio-ranges to TLMM
      arm64: dts: qcom: msm8998-oneplus-cheeseburger: fix backlight pin =
function
      arm64: dts: qcom: msm8998: align TLMM pin configuration with DT sc=
hema
      MAINTAINERS: ARM: marvell: include bindings
      ARM: dts: aspeed: align SPI node name with dtschema
      ARM: dts: ls1021: correct indentation
      ARM: dts: ti: correct indentation
      ARM: dts: armada: correct indentation
      ARM: dts: kirkwood: correct indentation
      ARM: dts: omap: correct indentation
      ARM: dts: sunxi: correct indentation
      dt-bindings: arm: qcom: document Google Cheza
      arm64: dts: qcom: sc7280: drop clock-cells from LPASS TLMM
      arm64: dts: qcom: sc7280: align LPASS pin configuration with DT sc=
hema
      arm64: dts: qcom: sm8250: correct LPASS pin pull down
      arm64: dts: qcom: sm8250: align LPASS pin configuration with DT sc=
hema
      dt-bindings: vendor-prefixes: Add ALFA Network
      dt-bindings: arm: qcom: Document IPQ4018 boards
      ARM: dts: qcom: ipq4018-ap120c-ac: Add SoC compatible
      ARM: dts: qcom: ipq4018-jalapeno: Add SoC compatible
      ARM: dts: qcom: msm8974: align TLMM pin configuration with DT sche=
ma
      dt-bindings: arm: qcom: document Mikrotik RB3011 board
      ARM: dts: qcom: ipq8064-rb3011: Add SoC compatible
      arm64: dts: qcom: sc7280: Add GPI DMA compatible fallback
      arm64: dts: qcom: sm8350: Add GPI DMA compatible fallback
      arm64: dts: qcom: sm8450: Add GPI DMA compatible fallback
      arm64: dts: qcom: sc7180-trogdor-homestar: fully configure seconda=
ry I2S pins
      arm64: dts: qcom: sc7180: revert "arm64: dts: qcom: sc7180: Avoid =
glitching SPI CS at bootup on trogdor"
      arm64: dts: qcom: sc7180: align TLMM pin configuration with DT sch=
ema
      arm64: dts: qcom: msm8996-sony-xperia-tone: drop incorrect wlan pi=
n input
      arm64: dts: qcom: msm8996: align TLMM pin configuration with DT sc=
hema
      dt-bindings: sram: qcom,imem: document SDX65
      ARM: dts: qcom: sdx65: add dedicated IMEM and syscon compatibles
      arm64: dts: qcom: msm8916: align TLMM pin configuration with DT sc=
hema
      arm64: dts: qcom: sm8450: move SDHCI pin configuration to DTSI
      arm64: dts: qcom: sm8450: disable SDHCI SDR104/SDR50 on all boards
      arm64: dts: qcom: sm8450-hdk: add SDHCI for microSD
      arm64: dts: qcom: sm8450-qrd: add SDHCI for microSD
      arm64: dts: qcom: msm8994: Correct SPI10 CS pin
      arm64: dts: qcom: msm8994: Align TLMM pin configuration with DT sc=
hema
      arm64: dts: qcom: qcs404: align TLMM pin configuration with DT sch=
ema
      arm64: dts: qcom: sm6125: fix SDHCI CQE reg names
      ARM: dts: qcom-apq8060: align TLMM pin configuration with DT schema
      arm64: dts: qcom: ipq8074: align TLMM pin configuration with DT sc=
hema
      ARM: dts: qcom-msm8960: use define for interrupt constants
      ARM: dts: qcom-msm8960-cdp: align TLMM pin configuration with DT s=
chema
      dt-bindings: arm: aspeed: adjust qcom,dc-scm-v1-bmc compatible aft=
er rename
      arm64: dts: qcom: sm8450: drop incorrect spi-max-frequency
      arm64: dts: ti: Trim addresses to 8 digits
      arm64: dts: msm8998: add MSM8998 specific compatible
      arm64: dts: msm8998: unify PCIe clock order withMSM8996
      arm64: dts: qcom: trim addresses to 8 digits
      arm64: dts: broadcom: trim addresses to 8 digits
      ARM: dts: omap: trim addresses to 8 digits
      ARM: dts: imx: trim addresses to 8 digits
      ARM: dts: lpc32xx: trim addresses to 8 digits
      ARM: dts: vexpress: align LED node names with dtschema
      ARM: dts: armada: align LED node names with dtschema
      ARM: dts: broadcom: align LED node names with dtschema
      arm64: dts: altera: align LED node names with dtschema
      ARM: dts: socfpga: align LED node names with dtschema
      ARM: dts: logicpd: align LED node names with dtschema
      ARM: dts: omap: align LED node names with dtschema
      ARM: dts: omap: echo: use preferred enable-gpios for LP5523 LED
      ARM: dts: am335x: align LED node names with dtschema
      ARM: dts: sti: align LED node names with dtschema
      ARM: dts: qcom: align LED node names with dtschema
      arm64: dts: qcom: align LED node names with dtschema
      arm64: dts: qcom: sc7180-trogdor: use generic node names
      arm64: dts: qcom: sm8450: align MMC node names with dtschema
      arm64: dts: qcom: qrb5165-rb: fix no-mmc property for SDHCI
      arm64: dts: qcom: sa8155p-adp: fix no-mmc property for SDHCI
      arm64: dts: qcom: sda660-inforce-ifc6560: fix no-mmc property for =
SDHCI
      arm64: dts: qcom: sdm845-sony-xperia-tama: fix no-mmc property for=
 SDHCI
      arm64: dts: qcom: sm8250-sony-xperia-edo: fix no-mmc property for =
SDHCI
      dt-bindings: iio: adc: qcom,spmi-vadc: extend example
      dt-bindings: iio: adc: qcom,spmi-vadc: fix PM8350 define

Kunihiko Hayashi (2):
      dt-bindings: arm: uniphier: Add Pro5 boards
      ARM: dts: uniphier: Add Pro5 board support

Kuninori Morimoto (1):
      arm64: dts: renesas: condor-common: Add missing bootargs

Lad Prabhakar (15):
      arm64: dts: renesas: rzg2lc-smarc: Include SoM DTSI into board DTS
      arm64: dts: renesas: rzg2ul-smarc: Move spi1 pinmux to carrier boa=
rd DTSI
      arm64: dts: renesas: rzg2l: Drop WDT2 nodes
      arm64: dts: renesas: r9a07g043: Introduce SOC_PERIPHERAL_IRQ() mac=
ro to specify interrupt property
      arm64: dts: renesas: r9a07g043: Split out RZ/G2UL SoC specific par=
ts
      dt-bindings: soc: renesas: Move renesas.yaml from arm to soc
      dt-bindings: soc: renesas: renesas.yaml: Document Renesas RZ/Five =
SoC
      arm64: dts: renesas: rzg2l: Drop #address-cells from pinctrl nodes
      dt-bindings: riscv: Sort the CPU core list alphabetically
      dt-bindings: riscv: Add Andes AX45MP core to the list
      riscv: dts: renesas: Add initial devicetree for Renesas RZ/Five SoC
      riscv: dts: renesas: Add minimal DTS for Renesas RZ/Five SMARC EVK
      MAINTAINERS: Add entry for Renesas RISC-V
      riscv: dts: renesas: r9a07g043f/rzfive-smarc-som: Enable ADC/OPP/T=
hermal Zones/TSU
      riscv: dts: renesas: rzfive-smarc: Enable CANFD/I2C

Li Jun (1):
      arm64: dts: imx8mm/n-evk: enable wakeup-source for usb phy

Lin, Meng-Bo (1):
      arm64: dts: qcom: msm8916-wingtech-wt88047: Add flash LED

Linus Walleij (7):
      ARM: dts: ux500: Fix up the Janice NFC chip
      ARM: dts: DBx500 cryp and hash uses power domain
      ARM: dts: ux500: Add GPS to the Kyle
      dt-bindings: ARM: add bindings for the D-Link DWL-8610AP
      ARM: dts: bcm53016: Add devicetree for D-Link DWL-8610AP
      dt-bindings: ARM: add bindings for the D-Link DIR-890L
      ARM: dts: bcm47094: Add devicetree for D-Link DIR-890L

Luca Weiss (28):
      ARM: dts: qcom: fix node name for rpm-msg-ram
      ARM: dts: qcom: add 'chassis-type' property
      ARM: dts: qcom: msm8974: fix tsens compatible
      ARM: dts: qcom: apq8084: add tsens interrupt
      ARM: dts: qcom: msm8974: Remove bogus *-cells from smd-edge
      ARM: dts: qcom: msm8974-sony-*: fix multi-led node name
      ARM: dts: qcom: pmx65: use node name "gpio" for spmi-gpio
      ARM: dts: qcom: ipq8064-rb3011: fix nand node validation
      ARM: dts: qcom: apq8084: fix compatible for l2-cache
      ARM: dts: qcom: apq8064: fix coresight compatible
      arm64: dts: qcom: msm8996: remove bogus ufs_variant node
      arm64: dts: qcom: sc7280: Fix cpufreq-epss compatible
      dt-bindings: arm: qcom: Document huawei,sturgeon device
      ARM: dts: qcom: Add support for Huawei Watch
      ARM: dts: qcom: msm8974: Add CCI bus
      ARM: dts: qcom: pm8226: fix regulators node name
      ARM: dts: qcom: pm8941: adjust coincell node name to bindings
      ARM: dts: qcom: pm8941: rename misc node name
      ARM: dts: qcom: pma8084: fix vadc channel node names
      ARM: dts: qcom: pm8941: fix vadc channel node names
      ARM: dts: qcom: pm8941: fix iadc node
      arm64: dts: qcom: pm6350: add temp sensor and thermal zone config
      arm64: dts: qcom: pm6150l: add temp sensor and thermal zone config
      arm64: dts: qcom: pm8150b: change vbus-regulator node name
      arm64: dts: qcom: pm8998: adjust coincell node name to bindings
      arm64: dts: qcom: sm7225-fairphone-fp4: Enable SD card
      ARM: dts: qcom: msm8974: clean up USB nodes
      dt-bindings: arm: qcom: Document oneplus,bacon device

Manikanta Pubbisetty (1):
      arm64: dts: qcom: sc7280: Add nodes to support WoW on WCN6750

Manivannan Sadhasivam (13):
      dt-bindings: iio: qcom: adc7-pm8350: Allow specifying SID for chan=
nels
      arm64: dts: qcom: sc8280xp-pmics: Add temp alarm for PM8280_{1/2} =
PMICs
      arm64: dts: qcom: sc8280xp-pmics: Add thermal zones for PM8280_{1/=
2} PMICs
      arm64: dts: qcom: sc8280xp-pmics: Add support for PMK8280 RESIN in=
put
      arm64: dts: qcom: sc8280xp-pmics: Add PMK8280 ADC7 block
      arm64: dts: qcom: sc8280xp-pmics: Add support for TM5 block in PMK=
8280
      arm64: dts: qcom: sc8280xp-x13s: Enable PMK8280 RESIN input
      arm64: dts: qcom: sc8280xp-x13s: Add PMK8280 VADC channels
      arm64: dts: qcom: sc8280xp-x13s: Add PM8280_{1/2} VADC channels
      arm64: dts: qcom: sc8280xp-x13s: Add PMR735A VADC channel
      arm64: dts: qcom: sc8280xp-x13s: Add PM8280_{1/2} ADC_TM5 channels
      arm64: dts: qcom: sc8280xp-x13s: Add thermal zone support
      arm64: dts: qcom: sm8450: Supply clock from cpufreq node to CPUs

Mao Jinlong (1):
      arm64: dts: qcom: sm8250: Add coresight components

Marcel Ziswiler (13):
      arm64: dts: verdin-imx8mm: verdin-imx8mp: improve include notation
      arm64: dts: colibri-imx8x: improve include notation
      arm64: dts: verdin-imx8mm: verdin-imx8mp: rename sn65dsi83 to sn65=
dsi84
      arm64: dts: verdin-imx8mm: improve pcie node
      ARM: dts: colibri-imx6: move vbus-supply to module level device tr=
ee
      ARM: dts: colibri-imx6: specify usbh_pen gpio being active-low
      ARM: dts: imx7-colibri: remove spurious debounce property
      arm64: dts: verdin-imx8mp: improve pinctrl for vbus-supplies
      arm64: dts: verdin-imx8mp: remove usb_2 over-current detection dis=
abling
      arm64: dts: verdin-imx8mp: add usb_1 over-current detection
      arm64: dts: verdin-imx8mp: disable usb port power control
      arm64: dts: verdin-imx8mp: add gpio usb-b connector
      arm64: dts: verdin-imx8mp: dahlia: mark usb_2 permanently attached

Marek Vasut (17):
      ARM: dts: stm32: Drop stm32mp15xc.dtsi from Avenger96
      ARM: dts: stm32: Rename mdio0 to mdio
      ARM: dts: stm32: Drop linux,default-trigger =3D "none" from AV96
      ARM: dts: stm32: Replace SAI format with dai-format DT property
      dt-bindings: arm: stm32: Add compatible string for DH electronics =
DHCOR Testbench board
      ARM: dts: stm32: Add DHCOR based Testbench board
      arm64: dts: imx8mm: Model PMIC to SNVS RTC clock path on Data Modu=
l i.MX8M Mini eDM SBC
      arm64: dts: imx8mm: Drop QCA clk out setup on Data Modul i.MX8M Mi=
ni eDM SBC
      ARM: dts: stm32: Drop MMCI interrupt-names
      ARM: dts: stm32: Fix AV96 WLAN regulator gpio property
      ARM: dts: qcom: Drop MMCI interrupt-names
      arm64: dts: imx8mp: Bind bluetooth UART on DH electronics i.MX8M P=
lus DHCOM
      arm64: dts: imx8mm-data-modul: Rename /watchdog-gpio to plain /wat=
chdog
      arm64: dts: imx8mm: imx8mn: imx8mp: imx8mq: Replace opp-xM with op=
p-x000000
      arm64: dts: imx8mm: Remove watchdog always-enabled property from e=
DM SBC
      dt-bindings: nvmem: snvs-lpgpr: Fix i.MX8M compatible strings
      ARM: dts: stm32: Rename mdio0 to mdio on DHCOR Testbench board

Marijn Suijten (17):
      dt-bindings: mfd: qcom-spmi-pmic: Add pm6125 compatible
      arm64: dts: qcom: pm660: Use unique ADC5_VCOIN address in node name
      arm64: dts: qcom: Add PM6125 PMIC
      arm64: dts: qcom: sm6125-seine: Include PM6125 and configure PON
      arm64: dts: qcom: sm6125-seine: Configure additional trinket therm=
istors
      arm64: dts: qcom: sm6350: Add resets for SDHCI 1/2
      arm64: dts: qcom: sm6350: Add pinctrl for SDHCI 2
      arm64: dts: qcom: sm6350-lena: Add SD Card Detect to sdc2 on/off p=
inctrl
      arm64: dts: qcom: pm6350: Include header for KEY_POWER
      arm64: dts: qcom: sm6350-lena: Include pm6350 and configure buttons
      arm64: dts: qcom: sm6350-lena: Define pm6350 and pm6150l regulators
      arm64: dts: qcom: sm6350-lena: Provide power to SDHCI 2 (SDCard sl=
ot)
      arm64: dts: qcom: sm6350-lena: Enable QUP and GPI DMA
      arm64: dts: qcom: sm6350-lena: Configure Samsung touchscreen
      arm64: dts: qcom: sm6350: Add apps_smmu with streamID to SDHCI 1/2=
 nodes
      arm64: dts: qcom: sm6125: Enable Command Queue Engine (CQE) for SD=
HCI 1
      dt-bindings: arm: qcom: Document msm8956 and msm8976 SoC and devic=
es

Martin Kepplinger (1):
      arm64: dts: imx8mq: fix dtschema warning for imx7-csi

Martin Povi=C5=A1er (4):
      arm64: dts: apple: t8103: Add AUDIO_P parent to the SIO_ADMA power=
 domain
      arm64: dts: apple: t8103: Add MCA and its support
      dt-bindings: dma: apple,admac: Add reset
      arm64: dts: apple: Add ADMAC resets on t8103/t600x

Matt Ranostay (1):
      arm64: dts: ti: Rename clock-names adc_tsc_fck to fck

Matthias Brugger (1):
      arm64: dts: mediatek: mt7986: Add SoC compatible

Matthias Kaehlcke (1):
      arm64: dts: qcom: sc7180: Configure USB as wakeup source

Matti Lehtim=C3=A4ki (3):
      ARM: dts: qcom: pm8226: Add node for the GPIOs
      dt-bindings: arm: qcom: Document samsung,matisse-wifi device
      ARM: dts: qcom: Add support for Samsung Galaxy Tab 4 10.1 (SM-T530)

Maulik Shah (1):
      arm64: dts: qcom: Add power-domains property for apps_rsc

Maxime Ripard (2):
      ARM: dts: bcm283x: Remove bcm2835-rpi-common.dtsi from SoC DTSI
      ARM: dts: bcm2835-rpi: Use firmware clocks for display

Maya Matuszczyk (5):
      arm64: dts: rockchip: Move most of Odroid Go Advance DTS into a DT=
SI
      dt-bindings: arm: rockchip: Add more RK3326 devices
      arm64: dts: rockchip: Add Odroid Go Advance Black Edition
      arm64: dts: rockchip: Add Odroid Go Super
      arm64: dts: rockchip: Add Anbernic RG351M

Melody Olvera (1):
      dt-bindings: arm: qcom: Document QDU1000/QRU1000 SoCs and boards

Mihai Sain (1):
      ARM: dts: at91: sama7g5: fix signal name of pin PD8

Mikko Perttunen (4):
      dt-bindings: Add headers for NVDEC on Tegra234
      dt-bindings: Add bindings for Tegra234 NVDEC
      arm64: tegra: Fix ranges for host1x nodes
      arm64: tegra: Add NVDEC on Tegra234

Neil Armstrong (11):
      dt-bindings: arm: qcom: move swir,mangoh-green-wp8548 board docume=
ntation to qcom.yaml
      ARM: dts: qcom: mdm9615*: add SPDX-License-Identifier
      ARM: dts: qcom: mdm9615: add missing reg in cpu@0 node
      ARM: dts: qcom: mdm9615: remove invalid spi-max-frequency gsbi3_sp=
i node
      ARM: dts: qcom: mdm9615: remove invalid interrupt-names from pl18x=
 mmc nodes
      ARM: dts: qcom: mdm9615: remove useless amba subnode
      ARM: dts: qcom: mdm9615: align pinctrl subnodes with dt-schema bin=
dings
      ARM: dts: qcom: mdm9615: wp8548-mangoh-green: fix sx150xq node nam=
es and probe-reset property
      ARM: dts: qcom-msm8660: align RPM regulators node name with bindin=
gs
      dt-bindings: amlogic: document Odroid Go Ultra compatible
      arm64: dts: amlogic: add initial Odroid Go Ultra DTS

Nicolas Frattaroli (6):
      arm64: dts: rockchip: Enable GPU on SOQuartz CM4
      arm64: dts: rockchip: Enable video output and HDMI on SOQuartz
      arm64: dts: rockchip: Enable HDMI sound on SOQuartz
      arm64: dts: rockchip: Enable PCIe 2 on SOQuartz CM4IO
      dt-bindings: arm: rockchip: Add SOQuartz Blade
      dt-bindings: arm: rockchip: Add SOQuartz Model A

Nikita Travkin (1):
      arm64: dts: qcom: msm8916-samsung-a2015: Add vibrator

N=C3=ADcolas F. R. A. Prado (3):
      arm64: dts: mediatek: kukui: Remove i2s-share properties
      arm64: dts: qcom: sc7180-trogdor: Add missing supplies for rt5682
      arm64: dts: qcom: sc7180-trogdor: Remove VBAT supply from rt5682s

Olivier Moysan (4):
      ARM: dts: stm32: add adc support to stm32mp13
      ARM: dts: stm32: add adc pins muxing on stm32mp135f-dk
      ARM: dts: stm32: add dummy vdd_adc regulator on stm32mp135f-dk
      ARM: dts: stm32: add adc support on stm32mp135f-dk

Owen Yang (2):
      dt-bindings: arm: qcom: Add zombie
      arm64: dts: qcom: sc7280: Add DT for sc7280-herobrine-zombie

Padmanabhan Rajanbabu (2):
      arm64: dts: fsd: fix drive strength macros as per FSD HW UM
      arm64: dts: fsd: fix drive strength values as per FSD HW UM

Pali Roh=C3=A1r (12):
      arm64: dts: armada-3720-turris-mox: Define slot-power-limit-milliw=
att for PCIe
      ARM: dts: dove: Fix assigned-addresses for every PCIe Root Port
      ARM: dts: armada-370: Fix assigned-addresses for every PCIe Root P=
ort
      ARM: dts: armada-xp: Fix assigned-addresses for every PCIe Root Po=
rt
      ARM: dts: armada-375: Fix assigned-addresses for every PCIe Root P=
ort
      ARM: dts: armada-38x: Fix assigned-addresses for every PCIe Root P=
ort
      ARM: dts: armada-39x: Fix assigned-addresses for every PCIe Root P=
ort
      ARM: dts: turris-omnia: Add ethernet aliases
      ARM: dts: turris-omnia: Add switch port 6 node
      ARM: dts: armada-38x: Fix compatible string for gpios
      ARM: dts: armada-39x: Fix compatible string for gpios
      arm64: dts: armada-3720-turris-mox: Add missing interrupt for RTC

Parikshit Pareek (2):
      dt-bindings: arm: qcom: Document additional sa8540p device
      arm64: dts: qcom: add SA8540P ride(Qdrive-3)

Pawel Dembicki (1):
      ARM: dts: kirkwood: Add Zyxel NSA310S board

Peng Fan (15):
      dt-bindings: clock: add i.MX8M Anatop
      arm64: dts: imx8m: align anatop with bindings
      arm64: dts: imx93: add nxp,no-divider for sysctr
      arm64: dts: imx93: add MU clock for mailbox
      arm64: dts: imx93: add extra lpspi node
      arm64: dts: imx93: add tpm nodes
      dt-bindings: spi: fsl-imx-cspi: update i.MX8MP binding
      arm64: dts: imx8mp: update ecspi compatible and clk
      arm64: dts: imx8mp: add mlmix power domain
      arm64: dts: imx8mp-evk: enable uart1/3 ports
      arm64: dts: imx8mp-evk: enable I2C2 node
      arm64: dts: imx8mn-evk: update vdd_soc dvs voltage
      arm64: dts: imx8mn-evk: set off-on-delay-us in regulator
      arm64: dts: imx8mn-evk: add i2c gpio recovery settings
      arm64: dts: imx8mn-evk: enable uart1

Peter Robinson (1):
      arm64: dts: rockchip: Add HDMI supplies on Rock960

Phil Edworthy (1):
      dt-bindings: arm: renesas: Document Renesas RZ/V2M System Configur=
ation

Philippe Schenker (6):
      ARM: dts: colibri-imx6: usb dual-role switching
      ARM: dts: colibri-imx6ull: keep peripherals disabled
      ARM: dts: colibri-imx6ull: enable default peripherals
      ARM: dts: colibri-imx6ull: add -hog to gpio hogs
      ARM: dts: colibri-imx7: fix confusing naming
      ARM: dts: colibri-imx6ull: Enable dual-role switching

Pierre Gondois (11):
      arm64: dts: Update cache properties for amlogic
      arm64: dts: Update cache properties for mediatek
      arm64: dts: Update cache properties for Arm Ltd platforms
      arm64: dts: renesas: rzg2l: Add missing cache-level properties
      arm64: dts: Update cache properties for freescale
      arm64: dts: Update cache properties for hisilicon
      arm64: tegra: Update cache properties
      arm64: dts: rockchip: update cache properties for rk3308 and rk3328
      arm64: dts: Update cache properties for marvell
      arm: dts: Update cache properties for broadcom
      arm64: dts: Update cache properties for broadcom

Potin Lai (7):
      ARM: dts: aspeed: bletchley: Change LED sys_log_id to active low
      ARM: dts: aspeed: bletchley: Disable GPIOV2 pull-down
      ARM: dts: aspeed: bletchley: Bind presence-sledX pins via gpio-keys
      ARM: dts: aspeed: bletchley: Update fusb302 nodes
      ARM: dts: aspeed: bletchley: Update and fix gpio-line-names
      ARM: dts: aspeed: bletchley: Enable emmc and ehci1
      ARM: dts: aspeed-g6: Add aliases for mdio nodes

Prathamesh Shete (1):
      arm64: tegra: Add Tegra234 SDMMC1 device tree node

Quan Nguyen (2):
      ARM: dts: aspeed: mtjade,mtmitchell: Add BMC SSIF nodes
      ARM: dts: aspeed: mtjade: Add SMPro nodes

Quentin Schulz (2):
      arm64: dts: rockchip: add PX30-=C2=B5Q7 (Ringneck) SoM with Haikou=
 baseboard
      dt-bindings: arm: rockchip: add Theobroma Systems PX30-=C2=B5Q7 (R=
ingneck) with Haikou

Rafa=C5=82 Mi=C5=82ecki (3):
      arm64: dts: broadcom: bcmbca: bcm4908: add TWD block timer
      arm64: dts: broadcom: bcmbca: bcm6858: add TWD block
      ARM: dts: BCM5301X: Correct description of TP-Link partitions

Rahul T R (1):
      arm64: dts: ti: k3-j721e-sk: Add pinmux for RPi Header

Rajeev Nandan (1):
      arm64: dts: qcom: sc7280: assign DSI clock source parents

Rajendra Nayak (2):
      arm64: dts: qcom: sc7180: Add required-opps for USB
      arm64: dts: qcom: sc7280: Add required-opps for i2c

Rayyan Ansari (2):
      ARM: dts: qcom: msm8226: Add CCI bus
      ARM: dts: qcom: msm8226: Add MMCC node

Richard Acayan (4):
      arm64: dts: qcom: add gpi-dma fallback compatible
      dt-bindings: arm: cpus: add qcom kryo 360 compatible
      dt-bindings: arm: qcom: add sdm670 and pixel 3a compatible
      arm64: dts: qcom: add sdm670 and pixel 3a device trees

Rob Herring (1):
      arm64: dts: apple: Add t600x L1/L2 cache properties and nodes

Robert Marko (13):
      arm64: dts: qcom: ipq8074: add A53 PLL node
      arm64: dts: qcom: ipq8074: add thermal nodes
      arm64: dts: qcom: ipq8074: add clocks to APCS
      arm64: dts: qcom: add PMP8074 DTSI
      arm64: dts: qcom: ipq8074-hk01: add VQMMC supply
      arm64: dts: qcom: ipq6018: fix NAND node name
      arm64: dts: qcom: ipq6018: move ARMv8 timer out of SoC node
      arm64: dts: qcom: cp01-c1: remove bootargs-append
      arm64: dts: qcom: cp01-c1: use "okay" instead of "ok"
      arm64: dts: qcom: ipq8074: pass XO and sleep clocks to GCC
      arm64: dts: qcom: hk10: use "okay" instead of "ok"
      arm64: dts: qcom: hk10: use GPIO flags for tlmm
      arm64: dts: qcom: hk01: use GPIO flags for tlmm

Robert Nelson (2):
      dt-bindings: arm: ti: Add bindings for BeagleBone AI-64
      arm64: dts: ti: Add k3-j721e-beagleboneai64

Sam Shih (3):
      arm64: dts: mt7986: harmonize device node order
      arm64: dts: mt7986: add crypto related device nodes
      arm64: dts: mt7986: add spi related device nodes

Samuel Holland (3):
      ARM: dts: axp803/axp81x: Drop GPIO LDO pinctrl nodes
      ARM: dts: axp22x/axp809: Add GPIO controller nodes
      dt-bindings: riscv: Add T-HEAD C906 and C910 compatibles

Sandipan Patra (2):
      dt-bindings: pwm: tegra: Document Tegra234 PWM
      arm64: tegra: Enable PWM users on Jetson AGX Orin

Santosh Puranik (1):
      ARM: dts: aspeed: rainier: Fix pca9551 nodes

Sascha Hauer (3):
      dt-bindings: vendor-prefixes: Add prefix for InnoComm
      dt-bindings: arm: fsl: Add InnoComm WB15 EVK
      arm64: dts: freescale: Add InnoComm i.MX8MM based WB15 SoM and EVK

Sebastian Reichel (1):
      arm64: dts: meson: remove clock-frequency from rtc

Shawn Guo (1):
      Merge remote-tracking branch 'robh/dt/dtbo-rename' into imx/dt64

Sheng-Liang Pan (5):
      dt-bindings: arm: qcom: Separate LTE/WIFI SKU for sc7280-evoker
      arm64: dts: qcom: sc7280: Add LTE SKU for sc7280-evoker family
      arm64: dts: qcom: sc7280: Add touchscreen and touchpad support for=
 evoker
      arm64: dts: qcom: sc7280: add sc7280-herobrine-audio-rt5682-3mic3.=
dtsi for evoker
      arm64: dts: qcom: sc7280: sort out the "Status" to last property w=
ith sc7280-herobrine-audio-rt5682.dtsi

Shengyu Qu (3):
      arm64: dts: rockchip: RK356x: Add I2S2 device node
      arm64: dts: rockchip: Add I2S2 node for RADXA Rock 3A
      arm64: dts: rockchip: Add nodes for SDIO/UART Wi-Fi/Bluetooth modu=
les to Radxa Rock 3A

Shenwei Wang (5):
      arm64: dts: freescale: imx8dxl: add scu_gpio node
      arm64: dts: freescale: imx8dxl-evk: enable mii_select node
      arm64: dts: imx8dxl-ss-lsio: add gpio-ranges property
      arm64: dts: imx8qm-ss-lsio: add gpio-ranges property
      arm64: dts: imx8qxp-ss-lsio: add gpio-ranges property

Sibi Sankar (2):
      arm64: dts: qcom: sc7280: Mark all Qualcomm reference boards as LTE
      arm64: dts: qcom: sc7280: Add Google Herobrine WIFI SKU dts fragme=
nt

Srinivas Kandagatla (3):
      arm64: dts: qcom: sm8450: add GPR node
      arm64: dts: qcom: sm8450: add Soundwire and LPASS
      arm64: dts: qcom: sm8450-hdk: add sound support

Srinivasa Rao Mandadapu (4):
      arm64: dts: qcom: Update soundwire secondary node names
      arm64: dts: qcom: sm8250: Remove redundant soundwire property
      arm64: dts: qcom: sc7280: Remove redundant soundwire property
      arm64: dts: qcom: sc7280: Remove unused sleep pin control nodes

Stefan Wahren (2):
      ARM: dts: bcm283x: Fix underscores in node names
      ARM: dts: bcm283x: Move ACT LED into separate dtsi

Stephan Gerhold (1):
      arm64: dts: qcom: msm8916: Drop MSS fallback compatible

Stephen Boyd (3):
      arm64: dts: qcom: Remove fingerprint node from herobrine-r1
      arm64: dts: qcom: sc7280: Fully describe fingerprint node on Herob=
rine
      arm64: dts: qcom: sc7180: Fully describe fingerprint node on Trogd=
or

Sudeep Holla (1):
      arm64: dts: fvp: Add information about L1 and L2 caches

Sven Peter (1):
      dt-bindings: iommu: dart: add t6000 compatible

Takeshi Kihara (1):
      arm64: dts: renesas: white-hawk-cpu: Add eMMC support

Teoh Ji Sheng (1):
      ARM: dts: socfpga: arria10: Increase NAND boot partition size

Thanh Quan (1):
      arm64: dts: renesas: r8a779g0: Add CMT node

Thierry Reding (25):
      ARM: tegra: Use correct compatible string for ASUS TF101 panel
      ARM: tegra: Fixup pinmux node names
      ARM: tegra: Add missing power-supply for panels
      ARM: tegra: Fix nvidia,io-reset properties
      ARM: tegra: Remove unused interrupt-parent properties
      ARM: tegra: Remove duplicate pin entry in pinmux
      dt-bindings: pinctrl: tegra: Convert to json-schema
      dt-bindings: pinctrl: tegra194: Separate instances
      dt-bindings: pwm: tegra: Convert to json-schema
      dt-bindings: usb: tegra-xusb: Convert to json-schema
      Merge branch for-6.2/dt-bindings into for-6.2/arm64/dt
      arm64: tegra: Sort nodes by unit-address
      arm64: tegra: Add missing whitespace
      arm64: tegra: Remove clock-names from PWM nodes
      arm64: tegra: Separate AON pinmux from main pinmux on Tegra194
      arm64: tegra: Add missing compatible string to Ethernet USB device
      arm64: tegra: Restructure Tegra210 PMC pinmux nodes
      arm64: tegra: Use vbus-gpios property
      arm64: tegra: Use correct compatible string for Tegra194 HDA
      arm64: tegra: Use correct compatible string for Tegra234 HDA
      arm64: tegra: Remove reset-names for QSPI
      arm64: tegra: Fixup pinmux node names
      arm64: tegra: Remove unused reset-names for QSPI
      arm64: tegra: Fix up compatible string for SDMMC1 on Tegra234
      arm64: tegra: Remove unneeded clock-names for Tegra132 PWM

Tim Harvey (2):
      arm64: dts: imx8m*-venice: add I2C GPIO bus recovery support
      arm64: dts: imx8m{m,n}-venice-gw7902: add gpio pins for new board =
revision

Tinghan Shen (2):
      arm64: dts: mt8195: Add venc node
      arm64: dts: mt8195: Add pcie and pcie phy nodes

Tom Fitzhenry (1):
      arm64: dts: rockchip: add BT/wifi nodes to Pinephone Pro

Tony Lindgren (7):
      arm64: dts: ti: k3-am65: Configure pinctrl for timer IO pads
      arm64: dts: ti: k3-am65: Add general purpose timers for am65
      arm64: dts: ti: k3-am62: Add general purpose timers for am62
      bus: ti-sysc: Add otg quirk flags for omap3 musb
      ARM: dts: Update omap3 musb to probe with ti-sysc
      ARM: OMAP2+: Drop legacy hwmod data for omap3 otg
      ARM: dts: Unify pwm-omap-dmtimer node names

Vasily Khoruzhick (1):
      arm64: dts: allwinner: a64: enable Bluetooth on Pinebook

Vidya Sagar (4):
      dt-bindings: PCI: tegra234: Add ECAM support
      arm64: tegra: Fix Prefetchable aperture ranges of Tegra234 PCIe co=
ntrollers
      arm64: tegra: Add ECAM aperture info for all the PCIe controllers
      arm64: tegra: Fix non-prefetchable aperture of PCIe C3 controller

Vijay Pothukuchi (1):
      arm64: dts: ti: k3-j721e-main: Add dts nodes for EHRPWMs

Vincent Knecht (2):
      arm64: dts: qcom: msm8916-alcatel-idol347: add GPIO torch LED
      arm64: dts: qcom: msm8916-alcatel-idol347: add LED indicator

Viorel Suman (1):
      dt-bindings: firmware: imx: sync with SCFW kit v1.13.0

Vladimir Lypak (2):
      arm64: dts: qcom: msm8953: add APPS IOMMU
      arm64: dts: qcom: msm8953: add MDSS

Vladimir Zapolskiy (1):
      arm64: dts: qcom: sm8450: Add description of camera control interf=
aces

Wolfram Sang (5):
      arm64: dts: renesas: r8a779f0: Fix HSCIF "brg_int" clock
      arm64: dts: renesas: r8a779f0: Fix SCIF "brg_int" clock
      arm64: dts: renesas: r8a779g0: Add TMU nodes
      arm64: dts: renesas: white-hawk-cpu: Sort RWDT entry correctly
      arm64: dts: renesas: spider-cpu: Switch from SCIF3 to HSCIF0

Yann Gautier (1):
      ARM: dts: stm32: add sdmmc cd-gpios for STM32MP135F-DK

Yassine Oudjana (3):
      arm64: dts: qcom: msm8996: Add MSM8996 Pro support
      arm64: dts: qcom: msm8996-xiaomi-scorpio, natrium: Use MSM8996 Pro
      arm64: dts: mediatek: mt6779: Remove syscon compatible from pin co=
ntroller

Yoshihiro Shimoda (2):
      arm64: dts: renesas: r8a779f0: Add Ethernet Switch and SERDES nodes
      arm64: dts: renesas: spider-ethernet: Enable Ethernet Switch and S=
ERDES

Yunlong Jia (2):
      dt-bindings: arm: qcom: Document additional skus for sc7180 pazque=
l360
      arm64: dts: qcom: Add sc7180-pazquel360

Zev Weiss (2):
      dt-bindings: arm: aspeed: document Delta AHE-50DC BMC
      ARM: dts: aspeed: Add Delta AHE-50DC BMC

Dirstat for brevity
   5.8% Documentation/devicetree/bindings/pinctrl/
   1.7% Documentation/devicetree/bindings/usb/
   1.7% Documentation/devicetree/bindings/
  19.3% arch/arm/boot/dts/
   1.0% arch/arm64/boot/dts/amlogic/
   6.8% arch/arm64/boot/dts/apple/
   3.9% arch/arm64/boot/dts/freescale/
   1.1% arch/arm64/boot/dts/mediatek/
   1.0% arch/arm64/boot/dts/nvidia/
  36.4% arch/arm64/boot/dts/qcom/
   3.4% arch/arm64/boot/dts/renesas/
   6.5% arch/arm64/boot/dts/rockchip/
   4.0% arch/arm64/boot/dts/ti/
   1.8% arch/
   2.0% include/dt-bindings/clock/
   1.0% include/dt-bindings/memory/
   1.3% include/dt-bindings/
