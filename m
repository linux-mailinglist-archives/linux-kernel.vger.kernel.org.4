Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC9A45F639C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 11:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231396AbiJFJ0w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 05:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbiJFJ0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 05:26:48 -0400
Received: from new4-smtp.messagingengine.com (new4-smtp.messagingengine.com [66.111.4.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 955CA98CBC
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 02:26:42 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 3589A580935;
        Thu,  6 Oct 2022 05:26:41 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Thu, 06 Oct 2022 05:26:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1665048401; x=
        1665052001; bh=88cyJEcOQ9kzxW03OV9KAkDksNI8RVkwdYuhUjfvglE=; b=i
        AesX3ACQrhGk4qECNyfXdG3EIkxbNX8dzEe1pbCFJscqtDzmKA/ReCzjn23NTeIv
        9t3BEOsk6RX2lYl6gTy7R6OlSLHBGEZsLLgAbCNzs7S9CRxT8+fzT85pfVXPMhUA
        cSInBklW5VL74e8OwJMPH3cN7k2KPjbWrtEmm+eczIfj/T+ZVvJaksL6AACagg6H
        aHHz2+Z6AKvH35iqVUm07Qq/x9UKeZsB9s5Q3N+kKSx5ewLcJK8eiZXLsREwF5ow
        fOqg/YD24GqfSRw+ZW+xLZZ7yMsEBv1teOQ1XM+RzoMYDLLcnUCjgVDbzW13Lqg+
        L3IUBPCAtX2DrdgS20Hfg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1665048401; x=
        1665052001; bh=88cyJEcOQ9kzxW03OV9KAkDksNI8RVkwdYuhUjfvglE=; b=T
        uPUHTpeNUA6W+0tycNDLWzcAQG5pF9c9zpuoiQo9xi38BbYHxhaSooU2iueB14zm
        g5T+9TbPhm13oWf/CBIPRNq0IesZRA4l2mE6lzCSVaXC+kKFGdTsh5Lzm8mOuhXr
        5IjOdTrJCFHcsVt2o3LX4tVSgyY2CXYiaiL94+T8C6iWfXstfehooBNCkEZAYmU2
        qsElYXnBZb674ezejeWe7TUXoJg/Po+LclnfKRoHReANi2IFNRzwxAh8rIvaCLu9
        tPzUq+GZM1+j9YK4bs4/GGUvekLarcIvlRj4+ZWQQmabtcBIIvHCSpb/qLhyAw6q
        CzHP1J0WKurzx3MAB+HbQ==
X-ME-Sender: <xms:UJ8-YwqRPyleIjHxRbCzVxhC5U7cAL5CrZiUg9fRdRjA5SMcdW3nkw>
    <xme:UJ8-Y2rZjVVbJrsOeMDCKlgcKD5aXkNm78Z1iC4agkGm62n6GvA_E4jymyVsEvF9Y
    Pcj8suJtnH2MgTYfEM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeeihedgudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpefgkefhheetvdethfejkeeigfehtdffieevfeefteffteejffehlefhtdeu
    veejueenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhgihhthhhusgdrtghomhenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnuges
    rghrnhgusgdruggv
X-ME-Proxy: <xmx:UJ8-Y1Mm0y-0ofD8wjyExlrvWCGgn_-BuWWbO9lJ5527OAfCwus-ag>
    <xmx:UJ8-Y35PvaT0xPMGr7ItKwjA1hcEvo9cA0Kv4JX-z0GyTZUmP4wP-Q>
    <xmx:UJ8-Y_7QcQIkUnJ41Sejkfyto8nOIbojEERGamX37nRk-SAOdQn6AA>
    <xmx:UJ8-Y5SMU6shiFKy1Pbtuxd8uo6Iqvq_MiAff2nEaA4cbjYxm4zDqw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 096DCB60086; Thu,  6 Oct 2022 05:26:39 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1015-gaf7d526680-fm-20220929.001-gaf7d5266
Mime-Version: 1.0
Message-Id: <20370a5f-b433-4511-9764-c8a2b3ecd972@app.fastmail.com>
In-Reply-To: <70d8e5d8-6fa4-496d-88d6-2604d0c3e982@app.fastmail.com>
References: <70d8e5d8-6fa4-496d-88d6-2604d0c3e982@app.fastmail.com>
Date:   Thu, 06 Oct 2022 11:26:19 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Linus Torvalds" <torvalds@linux-foundation.org>
Cc:     soc@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL 3/4] ARM SoC devicetree updates for 6.1
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

The following changes since commit b90cb1053190353cc30f0fef0ef1f378ccc06=
3c5:

  Linux 6.0-rc3 (2022-08-28 15:05:29 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/arm-d=
t-6.1

for you to fetch changes up to 114b9da7ebd964697a7ca5f85f68f61503e91f3a:

  Revert "ARM: dts: BCM5301X: Add basic PCI controller properties" (2022=
-10-05 10:22:40 +0200)

----------------------------------------------------------------
ARM: devicetree updates for 6.1

Most of the changes fall into one of three categories: adding support
for additional devices on existing machines, cleaning up issues found
by the ongoing conversion to machine-readable bindings, and addressing
minor mistakes in the existing DT data.

Across SoC vendors, Qualcomm and Freescale stick out as getting the most
updates, which corresponds to their dominance in the mobile phone and
embedded industrial markets, respectively.

There are 636 non-merge changeset in this branch, which is a little
lower than most times, but more importantly we only add 36 machine
files, which is about half of what we had the past few releases.

Eight new SoCs are added, but all of them are variations of already
supported SoC families, and most of them come with one reference board
design from the SoC vendor:

 - Mediatek MT8186 is a Chromebook/Tablet type SoC, similar to the
   MT65xx series of phone SoCs, with two Cortex-A76 and six Cortex-A55
   cores.

 - TI AM62A is another member of the K3 family with Cortex-A53 cores,
   this one is targetted at Video/Vision processing for industrial
   and automotive applications.

 - NXP i.MX8DXL is another chip for this market in the ever-growing
   i.MX8 family, this one again with two Cortex-A35 cores.

 - Renesas R-Car H3Ne-1.7G (R8A779MB) and R-Car V3H2 (R8A77980A) are
   minor updates of R8A77951 and R8A77980, respectively.

 - Qualcomm IPQ8064-v2.0, IPQ8062 and IPQ8065 are all variants of the
   IPQ8064 chip, with minimally different features.

The AMD Pensando Elba and Apple M1 Ultra SoC support was getting close
this time, but in the end did not make the cut.

The new machines based on existing SoC support are fairly uneventful:

 - Sony Xperia 1 IV is a fairly recent phone based on Qualcomm
   Snapdragon 8 Gen 1.

 - Three Samsung phones based on Snapdragon 410: Galaxy E5, E7 and
   Grand Max. These are added for both 32-bit and 64-bit kernels,
   as they originally shipped running 32-bit code.

 - Two new servers using AST2600 BMCs: AMD DaytonaX and Ampere
   Mt. Mitchell

 - Three new machines based on Rockchips RK3399 and RK3566:
   Anberic RG353P and RG503, Pine64 Pinephone Pro, Open AI Lab

 - Multiple NXP i.MX6/i.MX8 based boards: Kontron SL/BL i.MX8MM OSM-S,
   i.MX8MM Gateworks GW7904, MSC SM2S-IMX8PLUS SoM and carrier board

 - Two development boards in the Microchip AT91 family:
   SAMA5D3-EDS and lan966x-pcb8290.

 - Minor variants of existing boards using Amlogic, Broadcom, Marvell,
   Rockchips, Freescale Layerscape and Socionext Uniphier SoCs.

----------------------------------------------------------------
Abel Vesa (2):
      arm64: dts: qcom: sdm845: Reduce reg size for aoss_qmp
      arm64: dts: qcom: sdm845: Add the RPMh stats node

Akhil P Oommen (1):
      arm64: dts: qcom: sc7280: Update gpu opp table

Akhil R (1):
      arm64: tegra: Add GPCDMA support for Tegra I2C

Alain Volmat (4):
      ARM: dts: stm32: add i2c nodes into stm32mp131.dtsi
      ARM: dts: stm32: enable i2c1 and i2c5 on stm32mp135f-dk.dts
      ARM: dts: stm32: add spi nodes into stm32mp131.dtsi
      ARM: dts: stm32: add pinctrl and disabled spi5 node in stm32mp135f=
-dk

Alexander Stein (9):
      ARM: dts: imx6: delete interrupts property if interrupts-extended =
is set
      ARM: dts: imx6q-mccmon6: Add fsl,err006687-workaround-present prop=
erty
      ARM: dts: imx6q: add missing properties for sram
      ARM: dts: imx6dl: add missing properties for sram
      ARM: dts: imx6qp: add missing properties for sram
      ARM: dts: imx6sl: add missing properties for sram
      ARM: dts: imx6sll: add missing properties for sram
      ARM: dts: imx6sx: add missing properties for sram
      arm64: dts: tqma8mpql: add USB DR support

Allen-KH Cheng (6):
      arm64: dts: Add MediaTek MT8186 dts and evaluation board and Makef=
ile
      arm64: dts: mt8192: Add pwm node
      arm64: dts: mt8192: Add mipi_tx node
      arm64: dts: mediatek: Add mmsys #reset-cells property for mt8192
      arm64: dts: mt8192: Add display nodes
      arm64: dts: mt8192: Add dsi node

Andrew Davis (4):
      arm64: dts: ti: k3-am65-main: Disable RNG node
      arm64: dts: ti: k3-am65-main: Move SA2UL to unused PSI-L thread ID
      arm64: dts: ti: k3-am65-main: Do not exclusively claim SA2UL
      arm64: dts: ti: k3-j7200-mcu-wakeup: Add SA2UL node

Andy Yan (3):
      dt-bindings: vendor-prefixes: Add OPEN AI LAB
      dt-bindings: arm: rockchip: Add EAIDK-610
      arm64: dts: rockchip: Add dts for a rk3399 based board EAIDK-610

AngeloGioacchino Del Regno (8):
      arm64: dts: mediatek: cherry: Enable the System Companion Processor
      arm64: dts: mediatek: cherry: Wire up the ChromeOS Embedded Contro=
ller
      arm64: dts: mediatek: cherry: Add Google Security Chip (GSC) TPM
      arm64: dts: mediatek: cherry: Add keyboard mapping for the top row
      arm64: dts: mediatek: cherry: Enable secondary SD/MMC controller
      arm64: dts: mediatek: cherry: Enable Elantech eKTH3000 i2c trackpad
      arm64: dts: mediatek: cherry: Enable MT6315 regulators on SPMI bus
      arm64: dts: mediatek: mt6795: Add CPUX system timer node

Angus Ainslie (2):
      arm64: dts: imx8mq-librem5: add USB type-c properties for role swi=
tching
      arm64: dts: imx8mq-librem5: add usb-role-switch property to dwc3

Aparna M (1):
      arm64: dts: ti: k3-am642-sk: Add DT entry for onboard LEDs

Arnd Bergmann (31):
      Merge tag 'gemini-dts-v6.1-1' of git://git.kernel.org/pub/scm/linu=
x/kernel/git/linusw/linux-nomadik into arm/dt
      Merge tag 'at91-dt-6.1' of git://git.kernel.org/pub/scm/linux/kern=
el/git/at91/linux into arm/dt
      Merge tag 'renesas-arm-dt-for-v6.1-tag1' of git://git.kernel.org/p=
ub/scm/linux/kernel/git/geert/renesas-devel into arm/dt
      Merge tag 'renesas-dt-bindings-for-v6.1-tag1' of git://git.kernel.=
org/pub/scm/linux/kernel/git/geert/renesas-devel into arm/dt
      Merge tag 'amlogic-arm64-dt-for-v6.1' of git://git.kernel.org/pub/=
scm/linux/kernel/git/amlogic/linux into arm/dt
      Merge tag 'v6.1-rockchip-dts64-1' of git://git.kernel.org/pub/scm/=
linux/kernel/git/mmind/linux-rockchip into arm/dt
      Merge tag 'v6.1-rockchip-dts32-1' of git://git.kernel.org/pub/scm/=
linux/kernel/git/mmind/linux-rockchip into arm/dt
      Merge tag 'stm32-dt-for-v6.1-1' of git://git.kernel.org/pub/scm/li=
nux/kernel/git/atorgue/stm32 into arm/dt
      Merge tag 'samsung-dt64-6.1' of https://git.kernel.org/pub/scm/lin=
ux/kernel/git/krzk/linux into arm/dt
      Merge tag 'arm-soc/for-6.1/devicetree' of https://github.com/Broad=
com/stblinux into arm/dt
      Merge tag 'arm-soc/for-6.1/devicetree-arm64' of https://github.com=
/Broadcom/stblinux into arm/dt
      Merge tag 'at91-dt-6.1-2' of https://git.kernel.org/pub/scm/linux/=
kernel/git/at91/linux into arm/dt
      Merge tag 'tegra-for-6.1-dt-bindings' of git://git.kernel.org/pub/=
scm/linux/kernel/git/tegra/linux into arm/dt
      Merge tag 'tegra-for-6.1-arm64-dt' of git://git.kernel.org/pub/scm=
/linux/kernel/git/tegra/linux into arm/dt
      Merge tag 'imx-bindings-6.1' of git://git.kernel.org/pub/scm/linux=
/kernel/git/shawnguo/linux into arm/dt
      Merge tag 'imx-dt-6.1' of git://git.kernel.org/pub/scm/linux/kerne=
l/git/shawnguo/linux into arm/dt
      Merge tag 'imx-dt64-6.1' of git://git.kernel.org/pub/scm/linux/ker=
nel/git/shawnguo/linux into arm/dt
      Merge tag 'sunxi-dt-for-6.1-1' of https://git.kernel.org/pub/scm/l=
inux/kernel/git/sunxi/linux into arm/dt
      Merge tag 'v6.0-next-dts64' of https://git.kernel.org/pub/scm/linu=
x/kernel/git/matthias.bgg/linux into arm/dt
      Merge tag 'renesas-arm-dt-for-v6.1-tag2' of git://git.kernel.org/p=
ub/scm/linux/kernel/git/geert/renesas-devel into arm/dt
      Merge tag 'ti-k3-dt-for-v6.1' of https://git.kernel.org/pub/scm/li=
nux/kernel/git/ti/linux into arm/dt
      Merge tag 'qcom-dts-for-6.1' of https://git.kernel.org/pub/scm/lin=
ux/kernel/git/qcom/linux into arm/dt
      Merge tag 'qcom-arm64-for-6.1' of https://git.kernel.org/pub/scm/l=
inux/kernel/git/qcom/linux into arm/dt
      Merge tag 'mvebu-dt64-6.1-1' of git://git.kernel.org/pub/scm/linux=
/kernel/git/gclement/mvebu into arm/dt
      Merge tag 'omap-for-6.1/dt-signed' of git://git.kernel.org/pub/scm=
/linux/kernel/git/tmlind/linux-omap into arm/dt
      Merge tag 'mvebu-dt-6.1-1' of git://git.kernel.org/pub/scm/linux/k=
ernel/git/gclement/mvebu into arm/dt
      Merge tag 'v6.1-rockchip-dts64-2' of git://git.kernel.org/pub/scm/=
linux/kernel/git/mmind/linux-rockchip into arm/dt
      Merge tag 'aspeed-6.1-devicetree' of git://git.kernel.org/pub/scm/=
linux/kernel/git/joel/bmc into arm/dt
      Merge branch 'uniphier/dt' into arm/dt
      Merge tag 'samsung-dt-dt64-6.1-2' of https://git.kernel.org/pub/sc=
m/linux/kernel/git/krzk/linux into arm/dt
      Revert "ARM: dts: BCM5301X: Add basic PCI controller properties"

Bhadram Varka (1):
      dt-bindings: net: Add Tegra234 MGBE

Bhupesh Sharma (2):
      arm64: dts: qcom: sc8280xp-pmics: Remove reg entry & use correct n=
ode name for pmc8280c_lpg node
      arm64: dts: qcom: sa8155p-adp: Remove unused properties from eth n=
ode

Biju Das (9):
      arm64: dts: renesas: r9a07g043: Add DMA support to RSPI
      arm64: dts: renesas: r9a07g044: Add DMA support to RSPI
      arm64: dts: renesas: r9a07g054: Add DMA support to RSPI
      arm64: dts: renesas: r9a07g043: Fix audio clk node names
      arm64: dts: renesas: r9a07g044: Fix SCI{Rx,Tx} interrupt types
      arm64: dts: renesas: r9a07g054: Fix SCI{Rx,Tx} interrupt types
      arm64: dts: renesas: r9a07g043: Fix SCI{Rx,Tx} interrupt types
      ARM: dts: r9a06g032: Add CAN{0,1} nodes
      ARM: dts: r9a06g032-rzn1d400-db: Enable CAN1

Biwen Li (1):
      arm64: dts: ls208xa-rdb: fix errata E-00013

Bob Moragues (2):
      dt-bindings: arm: qcom: document zoglin board
      arm64: dts: qcom: sc7280: Add support for zoglin

Brian Norris (2):
      dt-bindings: arm: rockchip: Add gru-scarlet sku{2,4} variants
      arm64: dts: rockchip: Support gru-scarlet sku{2,4} variants

Bryan O'Donoghue (1):
      arm64: dts: qcom: pm8350c: Drop PWM reg declaration

Chanho Park (6):
      dt-bindings: clock: exynosautov9: correct clock numbering of peric=
0/c1
      dt-bindings: clock: exynosautov9: add fys0 clock definitions
      dt-bindings: clock: exynosautov9: add fsys1 clock definitions
      dt-bindings: clock: exynosautov9: add schema for cmu_fsys0/1
      arm64: dts: exynosautov9: add fsys0/1 clock DT nodes
      dt-bindings: serial: samsung: add exynosautov9-uart compatible

Chris Morgan (5):
      arm64: dts: rockchip: add rk817 chg to Odroid Go Advance
      dt-bindings: vendor-prefixes: add Anbernic
      dt-bindings: arm: rockchip: Add Anbernic RG353P and RG503
      arm64: dts: rockchip: add Anbernic RG353P and RG503
      arm64: dts: rockchip: Add DSI and DSI-DPHY nodes to rk356x

Chris Packham (2):
      arm64: dts: marvell: Add UART1-3 for AC5/AC5X
      arm64: dts: marvell: 98dx25xx: use correct property for i2c gpios

Christian Gmeiner (1):
      arm64: dts: ti: k3-am64-main: Add main_cpts label

Christian Hewitt (2):
      dt-bindings: arm: amlogic: add Beelink GT1 Ultimate binding
      arm64: dts: meson: add support for Beelink GT1 Ultimate

Christian Marangi (5):
      ARM: dts: qcom: ipq8064: add v2 dtsi variant
      ARM: dts: qcom: ipq8064: add ipq8062 variant
      ARM: dts: qcom: ipq8064: add ipq8065 variant
      ARM: dts: qcom: ipq8064: reorganize node order and sort them
      ARM: dts: qcom: ipq8064: pad addresses to 8 digit

Christoph Niedermaier (1):
      ARM: dts: imx6qdl-dhcom: Move IPU iomux node from PDK2 to SoM file

Chukun Pan (2):
      arm64: dts: rockchip: add rtc to rock3a
      arm64: dts: rockchip: Enable PCIe controller on rock3a

Clark Wang (1):
      arm64: dts: imx8ulp: increase the clock speed of LPSPI

Claudiu Beznea (1):
      ARM: dts: at91: sam9x60ek: remove simple-bus for regulators

Cl=C3=A9ment P=C3=A9ron (3):
      arm64: dts: allwinner: h6: Add cooling map for GPU
      arm64: dts: allwinner: h6: Add GPU OPP table
      arm64: dts: allwinner: beelink-gs1: Enable GPU OPP

Corentin Labbe (2):
      ARM: dts: gemini: ns2502: permit to use gigabit
      ARM: dts: gemini: ssi1328: permit to use gigabit

C=C3=A9dric Le Goater (1):
      ARM: dts: aspeed: ast2600-evb: Enable Quad SPI RX tranfers

Daniel Parks (1):
      arm64: dts: ti: k3-j721e-main: fix RNG node clock id

David Jander (1):
      ARM: dts: imx6qdl-vicut1.dtsi: Add backlight-isb node

Diogo Ivo (2):
      arm64: dts: tegra: smaug: Add Bluetooth node
      arm64: dts: tegra: smaug: Add Wi-Fi node

Dmitry Baryshkov (18):
      ARM: dts: qcom: apq8084: add rpm-stats device node
      ARM: dts: qcom: msm8974: add rpm-stats device node
      arm64: dts: qcom: stop using snps,dw-pcie falback
      arm64: dts: qcom: replace deprecated perst-gpio with perst-gpios
      arm64: dts: qcom: msm8916: add clocks to the GCC device node
      ARM: dts: qcom: stop using snps,dw-pcie falback
      ARM: dts: qcom-*: replace deprecated perst-gpio with perst-gpios
      arm64: dts: qcom: sm8250: move DSI opp table to the dsi0 node
      ARM: dts: qcom: msm8660: add pxo/cxo clocks to the GCC node
      ARM: dts: qcom: msm8660: fix node names for fixed clocks
      ARM: dts: qcom: apq8064: add clocks to the LCC device node
      ARM: dts: qcom: msm8960: add clocks to the LCC device node
      ARM: dts: qcom: apq8064: add clocks to the GCC device node
      ARM: dts: qcom: msm8960: add clocks to the GCC device node
      ARM: dts: qcom: apq8064: add clocks to the MMCC device node
      ARM: dts: qcom: msm8960: add clocks to the MMCC device node
      arm64: dts: qcom: msm8996: add #clock-cells and XO clock to the HD=
MI PHY node
      arm64: dts: qcom: sm8250: provide additional MSI interrupts

Dmitry Torokhov (3):
      ARM: dts: exynos: correct s5k6a3 reset polarity on Midas family
      arm64: dts: exynos: fix polarity of "enable" line of NFC chip in T=
M2
      ARM: dts: exynos: fix polarity of VBUS GPIO of Origen

Douglas Anderson (2):
      dt-bindings: arm: qcom: Adjust LTE SKUs for sc7280-villager
      arm64: dts: qcom: sc7280-villager: Adjust LTE SKUs

Duc Nguyen (1):
      arm64: dts: renesas: r8a779f0: Add MSIOF nodes

Eric Biggers (1):
      arm64: dts: qcom: sm8450: add Inline Crypto Engine registers and c=
lock

FUKAUMI Naoki (8):
      arm64: dts: rockchip: add LED for ROCK Pi 4A/B/C/A+/B+
      arm64: dts: rockchip: add LEDs for ROCK 4C+
      arm64: dts: rockchip: connect vcca_1v8 to APIO5_VDD on rk3399-rock=
-4c-plus
      arm64: dts: rockchip: fix regulator structure on rk3399-rock-4c-pl=
us
      arm64: dts: rockchip: sort nodes/properties on rk3399-rock-4c-plus
      arm64: dts: rockchip: fix regulator name on rk3399-rock-4
      arm64: dts: rockchip: sort nodes/properties on rk3399-rock-4
      arm64: dts: rockchip: add avdd-0v9-supply and avdd-1v8-supply on r=
k3399 rock 4c and pi4

Fabien Parent (2):
      arm64: dts: mediatek: mt8183: add keyboard node
      arm64: dts: mediatek: mt8183-pumpkin: add keypad support

Fabio Estevam (3):
      arm64: dts: meson-g12a: Remove 'enable-active-low'
      arm64: dts: meson-sm1-sei610: Remove 'enable-active-low'
      arm64: dts: imx8mm/n-venice-gw7902: Remove invalid property

Frank Wunderlich (3):
      arm64: dts: rockchip: Add PCIe v3 nodes to rk3568
      arm64: dts: rockchip: Add PCIe v3 nodes to BPI-R2-Pro
      arm64: dts: rockchip: Add regulator suffix to BPI-R2-Pro

Frieder Schrempf (11):
      ARM: dts: imx6ul-kontron: Simplify devicetree structure
      ARM: dts: imx6ul-kontron: Add imx6ull-kontron-bl to Makefile
      dt-bindings: arm: fsl: imx6ul-kontron: Update bindings
      dt-bindings: arm: fsl: Rename compatibles for Kontron i.MX8MM SoM/=
board
      dt-bindings: arm: fsl: Add Kontron BL i.MX8MM OSM-S board
      arm64: dts: imx8mm-kontron: Adjust compatibles, file names and mod=
el strings
      arm64: dts: imx8mm-kontron: Use the VSELECT signal to switch SD ca=
rd IO voltage
      arm64: dts: imx8mm-kontron: Remove low DDRC operating point
      arm64: dts: imx8mm-kontron: Use voltage rail names from schematic =
for PMIC regulator-names
      arm64: dts: imx8mm-kontron: Add SPI NOR partition layout
      arm64: dts: Add support for Kontron SL/BL i.MX8MM OSM-S

Furkan Kardame (1):
      arm64: dts: rockchip: Enable video output on rk3566-roc-pc

Geert Uytterhoeven (24):
      dt-bindings: arm: renesas: Document R-Car H3Ne-1.7G SoC and boards
      arm64: dts: renesas: Add Renesas R8A779MB SoC support
      arm64: dts: renesas: r8a779g0: Fix HSCIF0 interrupt number
      arm64: dts: renesas: r8a774e1: Rename i2c_dvfs to iic_pmic
      arm64: dts: qcom: sdm845-xiaomi-polaris: Fix sde_dsi_active pinctrl
      Merge tag 'renesas-fixes-for-v6.0-tag1' into renesas-arm-dt-for-v6=
.1
      MAINTAINERS: Merge ARM/Renesas ARM64 and ARM/SH-Mobile ARM archite=
ctures
      arm64: dts: renesas: r8a779g0: Add RWDT node
      arm64: dts: renesas: white-hawk-cpu: Enable watchdog timer
      arm64: dts: renesas: r8a779g0: Add pinctrl device node
      arm64: dts: renesas: white-hawk-cpu: Add serial port pin control
      arm64: dts: renesas: r8a779g0: Add I2C nodes
      arm64: dts: renesas: white-hawk: Add I2C0 and EEPROMs
      arm64: dts: renesas: white-hawk: Add CSI/DSI sub-board
      arm64: dts: renesas: white-hawk: Add Ethernet sub-board
      arm64: dts: renesas: r8a779g0: Add GPIO nodes
      arm64: dts: renesas: white-hawk-cpu: Add GP LEDs
      arm64: dts: renesas: white-hawk-cpu: Add push switches
      arm64: dts: renesas: r8a779g0: Add RAVB nodes
      arm64: dts: renesas: white-hawk: Move aliases and chosen
      arm64: dts: renesas: white-hawk-cpu: Add Ethernet support
      arm64: dts: renesas: spider: Move aliases and chosen
      arm64: dts: renesas: r8a779a0: Update to R-Car Gen4 compatible val=
ues
      ARM: dts: renesas: Fix USB PHY device and child node names

Georgi Vlaev (2):
      arm64: dts: ti: k3-am62-main: Add epwm nodes
      arm64: dts: ti: k3-am625-sk: Add epwm nodes

Gowtham Tammana (1):
      arm64: dts: ti: k3-j7200-main: Add main domain watchdog entries

Guido G=C3=BCnther (1):
      arm64: dts: imx8mq-librem5: add RGB pwm notification leds

Haibo Chen (1):
      ARM: dts: imx7d-sdb: config the max pressure for tsc2046

Horatiu Vultur (3):
      ARM: dts: lan966x: add support for pcb8290
      ARM: dts: lan966x: add led configuration
      ARM: dts: lan966x: disable aes

Hou Zhiqiang (3):
      arm64: dts: ls1043a: Add SCFG phandle for PCIe nodes
      arm64: dts: ls1043a: Add big-endian property for PCIe nodes
      arm64: dts: ls1046a: Add big-endian property for PCIe nodes

Hugh Cole-Baker (1):
      arm64: dts: rockchip: enable gamma control on RK3399

Ioana Radulescu (1):
      arm64: dts: ls2080a-rdb: add phy nodes

Jagan Teki (5):
      dt-bindings: arm: rockchip: Document Radxa ROCK 4C+
      arm64: dts: rockchip: Add RK3399-T OPP table
      arm64: dts: rockchip: rk3399: Radxa ROCK 4C+
      ARM: dts: stm32: Fix typo in license text for Engicam boards
      arm64: dts: imx8mm: Fix typo in license text for Engicam boards

Jakob Hauser (1):
      arm64: dts: qcom: msm8916-samsung-serranove: Add magnetometer

Jason-JH.Lin (2):
      arm64: dts: mt8195: Add gce node
      arm64: dts: mt8195: Add display node for vdosys0

Jerry Ray (2):
      dt-bindings: arm: at91: Add info on SAMA5D3-EDS
      dts: arm: at91: Add SAMA5D3-EDS Board

Jimmy Chen (3):
      dt-bindings: arm: qcom: document sc7280 and villager board
      arm64: dts: qcom: sc7280: Add herobrine-villager-r1
      arm64: dts: qcom: Add LTE SKUs for sc7280-villager family

Joel Stanley (3):
      ARM: dts: aspeed: ast2600-evb: Update I2C devices
      ARM: dts: aspeed: ast2600evb: Fix compatible string
      ARM: dts: aspeed: ast2600-evb-a1: Add compatible

Johan Hovold (14):
      arm64: dts: qcom: sc8280xp-crd: disable touchscreen pull-up
      arm64: dts: qcom: sc8280xp-crd: move HID pin config
      arm64: dts: qcom: sc8280xp-crd: mark HID wakeup sources
      arm64: dts: qcom: sc8280xp-lenovo-thinkpad-x13s: disable touchscre=
en pull-up
      arm64: dts: qcom: sc8280xp-lenovo-thinkpad-x13s: move HID pin conf=
ig
      arm64: dts: qcom: sc8280xp-lenovo-thinkpad-x13s: mark HID wakeup s=
ources
      arm64: dts: qcom: sc8280xp-lenovo-thinkpad-x13s: add alternate tou=
chpad
      arm64: dts: qcom: sc8280xp-crd: disallow regulator mode switches
      arm64: dts: qcom: sc8280xp-lenovo-thinkpad-x13s: disallow regulato=
r mode switches
      arm64: dts: qcom: sa8295p-adp: disallow regulator mode switches
      arm64: dts: qcom: sc8280xp: mark USB controllers as wakeup-sources
      arm64: dts: qcom: fix syscon node names
      arm64: dts: qcom: ipq8074: fix PCIe PHY serdes size
      arm64: dts: qcom: sm8450: fix UFS PHY serdes size

Johan Jonker (2):
      ARM: dts: rockchip: fix rk3036 emac node compatible string
      ARM: dts: rockchip: restyle emac nodes

Joy Zou (2):
      ARM: dts: imx: update sdma node name format
      arm64: dts: imx8mq: update sdma node name format

Judy Hsiao (2):
      arm64: dts: rockchip: use BCLK to GPIO switch on rk3399
      arm64: dts: qcom: sc7280: Fix Dmic no sound on villager-r1

Karthikeyan Pasupathi (2):
      ARM: dts: aspeed: Yosemite V2: Enable OCP debug card
      ARM: dts: aspeed: yosemitev2: Disable the EEPROM driver

Ken Chen (1):
      ARM: dts: aspeed-g6: Enable more UART controllers

Konrad Dybcio (4):
      dt-bindings: arm: qcom: Document Sony Xperia 1 IV (PDX223)
      arm64: dts: qcom: sm8450: Adjust memory map
      arm64: dts: qcom: sm8450: Add SDHCI2
      arm64: dts: qcom: Add device tree for Sony Xperia 1 IV

Konstantin Aladyshev (2):
      dt-bindings: arm: aspeed: document AMD DaytonaX
      ARM: dts: aspeed: Add AMD DaytonaX BMC

Krishna chaitanya chundru (2):
      arm64: dts: qcom: sc7280: Add missing aggre0, aggre1 clocks
      dt-bindings: pci: QCOM Add missing sc7280 aggre0, aggre1 clocks

Krzysztof Kozlowski (70):
      arm64: dts: qcom: sdm845: narrow LLCC address space
      arm64: dts: qcom: sdm845: add LLCC BWMON
      ARM: dts: imx: align SPI node name with dtschema
      ARM: dts: imx: align LED node names with dtschema
      ARM: dts: imx: align gpio-keys node names with dtschema
      ARM: dts: vf610: align SPI node name with dtschema
      arm64: dts: qcom: msm8992-xiaomi-libra: split qcom,msm-id into tup=
les
      arm64: dts: qcom: msm8998: add MSM8998 SDCC specific compatible
      dt-bindings: mfd: qcom,tcsr: add several devices
      arm64: dts: qcom: msm8996: split TCSR halt regs out of mutex
      arm64: dts: qcom: msm8996: switch TCSR mutex to MMIO
      arm64: dts: qcom: msm8998: split TCSR halt regs out of mutex
      arm64: dts: qcom: msm8998: switch TCSR mutex to MMIO
      arm64: dts: qcom: sc7180: add missing TCSR syscon compatible
      arm64: dts: qcom: sc7180: split TCSR halt regs out of mutex
      arm64: dts: qcom: sc7180: switch TCSR mutex to MMIO
      arm64: dts: qcom: sc7280: split TCSR halt regs out of mutex
      arm64: dts: qcom: sdm845: split TCSR halt regs out of mutex
      arm64: dts: qcom: sdm845: switch TCSR mutex to MMIO
      arm64: dts: qcom: qcs404: switch TCSR mutex to MMIO
      arm64: dts: qcom: sdm630: split TCSR halt regs out of mutex
      arm64: dts: qcom: sdm630: switch TCSR mutex to MMIO
      arm64: dts: qcom: sm8150: split TCSR halt regs out of mutex
      arm64: dts: qcom: sm8150: switch TCSR mutex to MMIO
      ARM: dts: qcom: msm8960: override nodes by label
      ARM: dts: qcom: msm8226: override nodes by label
      ARM: dts: qcom: msm8660: override nodes by label
      ARM: dts: qcom: msm8660-surf: move fixed regulator out of soc
      ARM: dts: qcom: use GPIO flags for tlmm
      arm64: dts: qcom: sdm845-db845c: drop power-domains from CCI I2C s=
ensors
      arm64: dts: qcom: sdm845-db845c: drop gpios from CCI I2C sensors
      arm64: dts: qcom: use GPIO flags for tlmm
      arm64: dts: qcom: pmk8350: drop incorrect io-channel-ranges
      arm64: dts: qcom: pmk8350: drop interrupt-names from ADC
      arm64: dts: qcom: align SPMI PMIC ADC node name with dtschema
      arm64: dts: qcom: align SPMI PMIC regulators node name with dtsche=
ma
      arm64: dts: qcom: align SPMI PMIC LPG node name with dtschema
      arm64: dts: qcom: align SPMI PMIC Power-on node name with dtschema
      arm64: dts: qcom: align PMIC GPIO pin configuration with DT schema
      arm64: dts: qcom: sc7280-idp: correct ADC channel node name and un=
it address
      arm64: dts: qcom: sdm845-mtp: correct ADC settle time
      ARM: dts: qcom: align SPMI PMIC ADC node name with dtschema
      ARM: dts: qcom: pm8941: align SPMI PMIC LPG node name with dtschema
      ARM: dts: qcom: pmx55: align SPMI PMIC Power-on node name with dts=
chema
      ARM: dts: armada-xp: align SPI node name with dtschema
      arm64: dts: qcom: sc7280: correct CPU BWMON unit address
      arm64: dts: qcom: sm6125: align TLMM pin configuration with DT sch=
ema
      arm64: dts: qcom: sm6350: align TLMM pin configuration with DT sch=
ema
      arm64: dts: qcom: sm8350-sagami: correct TS pin property
      arm64: dts: qcom: sm8350: align TLMM pin configuration with DT sch=
ema
      arm64: dts: qcom: sm8450: align TLMM pin configuration with DT sch=
ema
      arm64: dts: qcom: sc7280: align TLMM pin configuration with DT sch=
ema
      arm64: dts: qcom: sc7280-herobrine: correct TLMM gpio-line-names
      arm64: dts: qcom: ipq6018: add missing TCSR syscon compatible
      arm64: dts: qcom: msm8953: add missing TCSR syscon compatible
      arm64: dts: qcom: qcs404: add missing TCSR syscon compatible
      arm64: dts: qcom: msm8996: add missing TCSR syscon compatible
      arm64: dts: qcom: ipq6018: switch TCSR mutex to MMIO
      arm64: dts: qcom: msm8994: switch TCSR mutex to MMIO
      ARM: dts: qcom: apq8084: switch TCSR mutex to MMIO
      ARM: dts: qcom: msm8226: switch TCSR mutex to MMIO
      arm64: dts: qcom: align SDHCI reg-names with DT schema
      ARM: dts: qcom: align SDHCI reg-names with DT schema
      ARM: dts: qcom: align SDHCI clocks with DT schema
      arm64: dts: qcom: pmi8994: add missing MPP compatible fallback
      arm64: dts: qcom: msm8994-msft-lumia-octagon: align resin node nam=
e with bindings
      arm64: dts: qcom: msm8996-xiaomi: align PMIC GPIO pin configuratio=
n with DT schema
      arm64: dts: qcom: sa8295p-adp: add fallback compatible to PMIC GPI=
Os
      arm64: dts: qcom: sa8295p-adp: add missing gpio-ranges in PMIC GPI=
Os
      ARM: dts: s5pv210: correct double "pins" in pinmux node

Kuldeep Singh (1):
      ARM: dts: ls1021a: Use generic node name for DMA

Kunihiko Hayashi (19):
      ARM: dts: uniphier: Rename pvtctl node to thermal-sensor
      ARM: dts: uniphier: Rename usb-phy node for USB2 to usb-controller
      ARM: dts: uniphier: Rename usb-glue node for USB3 to usb-controller
      ARM: dts: uniphier: Rename gpio-hog node
      ARM: dts: uniphier: Use GIC interrupt definitions
      ARM: dts: uniphier: Add ahci controller nodes for Pro4
      ARM: dts: uniphier: Add ahci controller nodes for PXs2
      ARM: dts: uniphier: Move interrupt-parent property to each child n=
ode in uniphier-support-card
      ARM: dts: uniphier: Remove compatible "snps,dw-pcie-ep" from pcie-=
ep node
      arm64: dts: uniphier: Rename pvtctl node to thermal-sensor
      arm64: dts: uniphier: Rename usb-phy node for USB2 to usb-controll=
er
      arm64: dts: uniphier: Rename usb-glue node for USB3 to usb-control=
ler
      arm64: dts: uniphier: Rename gpio-hog nodes
      arm64: dts: uniphier: Use GIC interrupt definitions
      arm64: dts: uniphier: Add ahci controller nodes for PXs3
      arm64: dts: uniphier: Add USB-device support for PXs3 reference bo=
ard
      arm64: dts: uniphier: Fix opp-table node name for LD20
      arm64: dts: uniphier: Remove compatible "snps,dw-pcie" from pcie n=
ode
      arm64: dts: uniphier: Add L2 cache node

Kuninori Morimoto (6):
      dt-bindings: arm: renesas: Document Renesas R-Car V3H2 SoC and boa=
rd
      arm64: dts: renesas: Add condor-common.dtsi
      arm64: dts: renesas: Add r8a77980a.dtsi
      arm64: dts: renesas: Add V3H2 Condor-I board support
      arm64: dts: renesas: spider-cpu: Add missing bootargs
      arm64: dts: renesas: white-hawk-cpu: Add missing bootargs

Lad Prabhakar (11):
      arm64: dts: renesas: r9a07g044: Add IRQC node
      arm64: dts: renesas: r9a07g044: Update pinctrl node to handle GPIO=
 interrupts
      arm64: dts: renesas: r9a07g054: Add IRQC node
      arm64: dts: renesas: r9a07g054: Update pinctrl node to handle GPIO=
 interrupts
      dt-bindings: soc: renesas: renesas,rzg2l-sysc: Document RZ/Five SoC
      dt-bindings: interrupt-controller: Add macros for NMI and IRQ0-7 i=
nterrupts present on RZ/G2L SoC
      arm64: dts: renesas: rzg2l-smarc-som: Add PHY interrupt support fo=
r ETH{0/1}
      arm64: dts: renesas: Drop clock-names property from RPC node
      arm64: dts: renesas: rzg2ul-smarc-som: Drop enabling wdt2
      arm64: dts: renesas: rzg2ul-smarc: Include SoM DTSI into board DTS
      arm64: dts: renesas: Adjust whitespace around '{'

Laurentiu Tudor (4):
      arm64: dts: ls1043a: add missing dma ranges property
      arm64: dts: ls1043a: use a pseudo-bus to constrain usb and sata dm=
a size
      arm64: dts: ls1046a: add missing dma ranges property
      arm64: dts: ls1046a: use a pseudo-bus to constrain usb and sata dm=
a size

Li Yang (12):
      arm64: dts: ls208xa-qds: add mdio mux nodes from on-board FPGA
      arm64: dts: ls1043a: fix the wrong size of dcfg space
      arm64: dts: ls1043a: Enable usb3-lpm-capable for usb3 node
      arm64: dts: ls1043a: use pcie aer/pme interrupts
      arm64: dts: ls1043a: make dma-coherent global to the SoC
      arm64: dts: ls1043a: add gpio based i2c recovery information
      arm64: dts: ls1043a-qds: add mmio based mdio-mux support
      arm64: dts: ls1043a-rdb: add pcf85263 rtc node
      arm64: dts: ls1046a: Enable usb3-lpm-capable for usb3 node
      arm64: dts: ls1046a: make dma-coherent global to the SoC
      arm64: dts: ls1046a: add gpios based i2c recovery information
      arm64: dts: ls1046a-qds: add mmio based mdio-mux nodes for FPGA

Lin, Meng-Bo (5):
      dt-bindings: qcom: Document bindings for new msm8916-samsung-e2015=
 devices
      arm64: dts: qcom: msm8916-samsung-e2015: Add initial common dtsi
      ARM: dts: qcom-msm8916-samsung-e2015: Include dts from arm64
      arm64: dts: qcom: msm8916-samsung-e2015: Add touchkey
      arm64: dts: qcom: msm8916-samsung-a2015: Rename touchscreen analog=
 regulator

Linus Walleij (5):
      ARM: dts: Let Gemini NS2502 parse redboot partitions
      ARM: dts: qcom: msm8660: Add GSBI1 SPI bus
      ARM: dts: qcom: msm8660: Add GSBI3 I2C bus
      ARM: dts: qcom: apq8060-dragonboard: Add TMA340 to APQ8060 DragonB=
oard
      ARM: dts: integrator: Tag PCI host with device_type

Luca Weiss (8):
      arm64: dts: qcom: sm6350: Add interconnect support
      arm64: dts: qcom: pm6150l: add missing adc channels
      arm64: dts: qcom: sm6350: Add GPI DMA nodes
      arm64: dts: qcom: Add pm7250b PMIC
      arm64: dts: qcom: sm7225-fairphone-fp4: Add pm7250b PMIC
      ARM: dts: qcom: msm8226: Add ADSP node
      ARM: dts: qcom: apq8026-asus-sparrow: Enable ADSP
      ARM: dts: qcom: apq8026-lg-lenok: Enable ADSP

Lucas Stach (1):
      ARM: dts: imx6qdl-kontron-samx6i: hook up DDC i2c bus

Marcel Ziswiler (18):
      ARM: dts: imx6-sabrelite: change to use SPDX identifiers
      ARM: dts: imx6qdl-mba6: don't use multiple blank lines
      ARM: dts: imx6qdl: phytec: no spaces at start of line, indent use =
tabs
      ARM: dts: imx6qdl-sabre: change to use SPDX identifiers
      ARM: dts: imx7d-pico: indent use tabs, no spaces at start of line
      ARM: dts: vf610: no spaces in indent but tabs
      ARM: dts: vf610-twr: indent use tabs, no spaces at start of line
      ARM: dts: vf610: don't use multiple blank lines
      ARM: dts: vf610: ddr pinmux
      ARM: dts: imx6sl: use tabs for code indent
      ARM: dts: imx6sx-udoo-neo: don't use multiple blank lines
      dt-bindings: clk: imx8mm: don't use multiple blank lines
      arm64: dts: imx8mm-venice-gw72xx-0x: blank line at end of file
      arm64: dts: imx8mp-verdin: don't use multiple blank lines
      arm64: dts: mnt-reform2: don't use multiple blank lines
      arm64: dts: imx8ulp: no executable source file permission
      arm64: dts: verdin-imx8mm: rename sn65dsi83 to sn65dsi84
      arm64: dts: verdin-imx8mm: add lvds panel node

Marcin Wojtas (2):
      ARM: mvebu: add audio I2S controller to Armada 38x Device Tree
      ARM: mvebu: add audio support to Armada 385 DB

Marco Felsch (1):
      ARM: dts: imx6qdl-kontron-samx6i: move phy reset into phy-node

Marek Beh=C3=BAn (1):
      ARM: dts: turris-omnia: Fix mpp26 pin name and comment

Marek Vasut (4):
      arm64: dts: imx8mp: Add HW variant details to i.MX8M Plus DHCOM PD=
K2
      arm64: dts: imx8mp: Drop Atheros PHY header from i.MX8M Plus DHCOM=
 PDK2
      arm64: dts: imx8mp: Add SoM compatible to i.MX8M Plus DHCOM PDK2
      arm64: dts: imx8mp: Add SNVS LPGPR

Markus Reichl (1):
      arm64: dts: rockchip: Add HDMI supplies on rk3399-roc-pc

Martijn Braam (1):
      arm64: dts: rockchip: Add initial support for Pine64 PinePhone Pro

Martin Kepplinger (2):
      arm64: dts: imx8mq-librem5: describe the voice coil motor for focu=
s control
      arm64: dts: imx8mq-librem5: fix mipi_csi description

Martyn Welch (2):
      dt-bindings: arm: fsl: Add MSC SM2S-IMX8PLUS SoM and SM2-MB-EP1 Ca=
rrier
      arm64: dts: imx8mp-msc-sm2s: Add device trees for MSC SM2S-IMX8PLU=
S SoM and carrier board

Matt Ranostay (1):
      arm64: dts: ti: k3-j7200: fix main pinmux range

Matthias Kaehlcke (4):
      arm64: dts: qcom: sc7280-herobrine: Don't enable the USB 2.0 port
      arm64: dts: qcom: sc7280-qcard: Add alias 'wifi0'
      arm64: dts: qcom: sc7180-trogdor: Add nodes for onboard USB hub
      arm64: dts: qcom: sc7280-herobrine: Add nodes for onboard USB hub

Max Krummenacher (1):
      arm64: dts: imx8mp-verdin: add cpu-supply

Michael Riesch (4):
      arm64: dts: rockchip: add vcc_cam regulator to rock-3a
      arm64: dts: rockchip: add vcc_mipi regulator to rock-3a
      arm64: dts: rockchip: specify pinctrl for i2c adapters on rock-3a
      arm64: dts: rockchip: add csi dphy node to rk356x

Michael Walle (2):
      ARM: dts: kirkwood: lsxl: fix serial line
      ARM: dts: kirkwood: lsxl: remove first ethernet port

Michal Vok=C3=A1=C4=8D (1):
      ARM: dts: imx6dl-yapp4: Bind the backlight controller to the LCD p=
anel

Mikko Perttunen (2):
      dt-bindings: Add Host1x context stream IDs on Tegra234
      arm64: tegra: Add context isolation domains on Tegra234

Mohan Kumar (2):
      arm64: tegra: Enable HDA node for Jetson AGX Orin
      arm64: tegra: Add iommus for HDA on Tegra234

Moudy Ho (1):
      arm64: dts: mt8183: add MediaTek MDP3 nodes

Nicolas Frattaroli (4):
      arm64: dts: rockchip: Add analog audio output on quartz64-b
      arm64: dts: rockchip: Add PCIe 2 nodes to quartz64-b
      arm64: dts: rockchip: Add Hantro encoder node to rk356x
      arm64: dts: rockchip: Enable HDMI and GPU on quartz64-b

Nishanth Menon (2):
      dt-bindings: arm: ti: k3: Sort the am654 board enums
      dt-bindings: arm: ti: k3: Sort the SoC definitions alphabetically

N=C3=ADcolas F. R. A. Prado (1):
      arm64: dts: mediatek: Add missing xHCI clocks for mt8192 and mt8195

Oleksij Rempel (1):
      ARM: dts: imx6: skov: migrate to resistive-adc-touch

Ondrej Jirman (1):
      arm64: dts: rockchip: Fix SD card controller probe on Pinephone Pro

Pali Roh=C3=A1r (16):
      ARM: dts: kirkwood: Add definitions for PCIe legacy INTx interrupts
      ARM: dts: dove: Add definitions for PCIe legacy INTx interrupts
      ARM: dts: armada-370.dtsi: Add definitions for PCIe legacy INTx in=
terrupts
      ARM: dts: armada-xp-98dx3236.dtsi: Add definitions for PCIe legacy=
 INTx interrupts
      ARM: dts: armada-xp-mv78230.dtsi: Add definitions for PCIe legacy =
INTx interrupts
      ARM: dts: armada-xp-mv78260.dtsi: Add definitions for PCIe legacy =
INTx interrupts
      ARM: dts: armada-xp-mv78460.dtsi: Add definitions for PCIe legacy =
INTx interrupts
      ARM: dts: armada-375.dtsi: Add definitions for PCIe legacy INTx in=
terrupts
      ARM: dts: armada-380.dtsi: Add definitions for PCIe legacy INTx in=
terrupts
      ARM: dts: armada-39x.dtsi: Add definitions for PCIe legacy INTx in=
terrupts
      ARM: dts: kirkwood: Add definitions for PCIe error interrupts
      ARM: dts: dove: Add definitions for PCIe error interrupts
      ARM: dts: armada-38x: Add gpio-ranges for pin muxing
      ARM: mvebu: Add spdif-pins mpp pins for Armada 38x
      ARM: dts: turris-omnia: Define S/PDIF audio card
      ARM: dts: turris-omnia: Add label for wan port

Pankaj Bansal (2):
      arm64: dts: ls208x: remove NXP Erratum A008585 from LS2088A.
      arm64: dts: ls1046a-qds: Modify the qspi flash frequency

Patrice Chotard (1):
      ARM: dts: stm32: Create separate pinmux for qspi cs pin in stm32mp=
15-pinctrl.dtsi

Peng Fan (30):
      dt-bindings: soc: imx: add interconnect property for i.MX8MP media=
 blk ctrl
      dt-bindings: soc: imx: add interconnect property for i.MX8MP hdmi =
blk ctrl
      dt-bindings: soc: imx: add interconnect property for i.MX8MP hsio =
blk ctrl
      ARM: dts: imx7ulp: update the LPI2C clock-names
      ARM: dts: imx7ulp: Add IPG clock for lpi2c
      dt-bindings: power: imx8mp-power: add HDMI HDCP/HRV
      dt-bindings: soc: imx: drop minItems for i.MX8MM vpu blk ctrl
      dt-bindings: soc: imx: add interconnect property for i.MX8MM vpu b=
lk ctrl
      dt-bindings: soc: imx: add i.MX8MP vpu blk ctrl
      dt-bindings: mfd: syscon: Add i.MX93 blk ctrl system registers
      dt-bindings: soc: add i.MX93 SRC
      dt-bindings: soc: add i.MX93 mediamix blk ctrl
      arm64: dts: imx8mp: add interconnects for media blk ctrl
      arm64: dts: imx8mp: add interconnect for hsio blk ctrl
      arm64: dts: imx8mp: add vpu pgc nodes
      arm64: dts: imx8mp: add VPU blk ctrl node
      arm64: dts: imx8-ss-dma: add IPG clock for i2c
      arm64: dts: imx8ulp: drop undocumented property in cgc
      arm64: dts: imx8ulp: correct the scmi sram node name
      arm64: dts: imx8ulp: add pmu node
      arm64: dts: imx8ulp: add mailbox node
      arm64: dts: imx93: correct SDHC clk entry
      arm64: dts: imx93: add gpio clk
      arm64: dts: imx93: add s4 mu node
      arm64: dts: imx93: add blk ctrl node
      arm64: dts: imx93: add a55 pmu
      arm64: dts: imx93: add lpi2c nodes
      arm64: dts: imx93: add lpspi nodes
      arm64: dts: imx93: add src node
      arm64: dts: imx93: add mediamix blk ctrl node

Peter Chiu (1):
      arm64: dts: mt7986: add built-in Wi-Fi device nodes

Peter Ujfalusi (1):
      arm64: dts: ti: k3-am64-main: Enable crypto accelerator

Phil Edworthy (3):
      arm64: dts: renesas: r9a09g011: Add pinctrl node
      arm64: dts: renesas: r9a09g011: Add i2c nodes
      arm64: dts: renesas: rzv2m evk: Enable i2c

Philipp Zabel (1):
      ARM: dts: imx6qdl-tqma6x: add fixed power supplies

Philippe Schenker (1):
      arm64: dts: verdin-imx8mm: introduce hdmi-connector

Piotr Oniszczuk (1):
      arm64: dts: rockchip: Add VPU support for RK3568/RK3566

Potin Lai (2):
      ARM: dts: aspeed: bletchley: Add USB debug card IPMB node
      ARM: dts: aspeed: bletchley: Remove hdc1080 node

Priyanka Jain (1):
      arm64: dts: ls2081a-rdb: Add DTS for NXP LS2081ARDB

Quan Nguyen (3):
      dt-bindings: arm: aspeed: document Ampere Mt.Mitchell BMC compatib=
les
      ARM: dts: aspeed: Add device tree for Ampere's Mt. Mitchell BMC
      ARM: dts: aspeed: mtjade: Remove gpio-keys entries

Quentin Schulz (1):
      arm64: dts: rockchip: add i2s0 I2S/PDM/TDM 8ch controller to px30

Rafa=C5=82 Mi=C5=82ecki (4):
      arm64: dts: broadcom: bcm4908: add remaining LED pins
      arm64: dts: broadcom: bcm4908: add LEDs controller block
      arm64: dts: broadcom: bcm4908: add Asus GT-AC5300 LEDs
      ARM: dts: BCM5301X: Add basic PCI controller properties

Rajendra Nayak (2):
      arm64: dts: qcom: sc7280: Add cpu and llcc BWMON
      arm64: dts: qcom: sc7280: Add required-opps for USB

Richard Zhu (2):
      arm64: dts: imx8mp: Add iMX8MP PCIe support
      arm64: dts: imx8mp-evk: Add PCIe support

Robert Marko (10):
      dt-bindings: vendor-prefixes: add Methode Electronics
      dt-bindings: marvell: convert Armada 37xx compatibles to YAML
      arm64: dts: marvell: espressobin-ultra: add generic Espressobin co=
mpatible
      arm64: dts: marvell: uDPU: add missing SoC compatible
      arm64: dts: marvell: uDPU: align LED-s with bindings
      arm64: dts: marvell: uDPU: remove LED node pinctrl-names
      arm64: dts: marvell: rename temp sensor nodes
      arm64: dts: marvell: split Methode uDPU DTS
      dt-bindings: marvell: armada-37xx: add Methode eDPU compatible
      arm64: dts: marvell: add support for Methode eDPU

Roger Quadros (2):
      arm64: dts: ti: k3-am64-main: Add GPMC memory controller node
      arm64: dts: ti: k3-am64-main: Add ELM (Error Location Module) node

Sam Protsenko (5):
      dt-bindings: clock: exynos850: Add Exynos850 CMU_AUD
      dt-bindings: clock: exynos850: Add Exynos850 CMU_IS
      dt-bindings: clock: exynos850: Add Exynos850 CMU_MFCMSCL
      arm64: dts: exynos: Add CMU_AUD, CMU_IS and CMU_MFCMSCL for Exynos=
850
      arm64: dts: exynos: Add SysMMU nodes for Exynos850

Samuel Holland (3):
      arm64: dts: allwinner: a100: Add I2C DMA requests
      dt-bindings: sram: sunxi-sram: Clean up the compatible lists
      dt-bindings: sram: sunxi-sram: Add D1 compatible string

Satya Priya (2):
      arm64: dts: qcom: sc7280: Cleanup the lpasscc node
      arm64: dts: qcom: sc7280: Update lpasscore node

Sebastian Krzyszkowiak (1):
      arm64: dts: imx8mq-librem5: Add bq25895 as max17055's power supply

Sergiu Moga (4):
      ARM: dts: at91: sama7g5: Swap rx and tx for spi11
      ARM: dts: at91: sam9x60ek: Add DBGU compatibles to uart1
      ARM: dts: at91: Add `atmel,usart-mode` required property to serial=
 nodes
      spi: dt-bindings: atmel,at91rm9200-spi: Add DMA related properties

Sheng-Liang Pan (2):
      dt-bindings: arm: qcom: document sc7280 and evoker board
      arm64: dts: qcom: sc7280: Add device tree for herobrine evoker

Shenwei Wang (5):
      dt-bindings: firmware: add missing resource IDs for imx8dxl
      dt-bindings: arm: imx: update fsl.yaml for imx8dxl
      arm64: dts: imx8: add a node label to ddr-pmu
      arm64: dts: freescale: add i.MX8DXL SoC support
      arm64: dts: freescale: add support for i.MX8DXL EVK board

Srinivasa Rao Mandadapu (12):
      arm64: dts: qcom: sc7280: Add nodes for soundwire and va tx rx dig=
ital macro codecs
      arm64: dts: qcom: sc7280: Enable digital codecs and soundwire for =
CRD 1.0/2.0 and IDP boards
      arm64: dts: qcom: sc7280: Enable digital codecs and soundwire for =
CRD 3.0/3.1
      arm64: dts: qcom: sc7280: Add wcd9385 codec node for CRD 1.0/2.0 a=
nd IDP boards
      arm64: dts: qcom: sc7280: Add wcd9385 codec node for CRD 3.0/3.1
      arm64: dts: qcom: sc7280: Add max98360a codec for CRD 1.0/2.0 and =
IDP boards
      arm64: dts: qcom: sc7280: herobrine: Add max98360a codec node
      arm64: dts: qcom: sc7280: Add lpass cpu node
      arm64: dts: qcom: sc7280: Enable lpass cpu node for CRD 1.0/2.0 an=
d IDP boards.
      arm64: dts: qcom: sc7280: Enable lpass cpu node for CRD 3.0/3.1
      arm64: dts: qcom: sc7280: Add sound node for CRD 1.0/2.0 and IDP b=
oards
      arm64: dts: qcom: sc7280: Add sound node for CRD 3.0/3.1

Stephen Boyd (1):
      arm64: dts: qcom: sc7180-trogdor: Keep pm6150_adc enabled for TZ

Suman Anna (1):
      arm64: dts: ti: k3-am64: Add SA2UL address space to Main CBASS ran=
ges

Taniya Das (4):
      arm64: dts: qcom: sc7280: Update lpassaudio clock controller for r=
esets
      dt-bindings: clock: Add "qcom,adsp-pil-mode" property
      dt-bindings: clock: Add resets for LPASS audio clock controller fo=
r SC7280
      dt-bindings: clock: Add support for external MCLKs for LPASS on SC=
7280

Thierry Reding (5):
      Merge branch 'for-6.1/dt-bindings' into for-6.1/arm64/dt
      arm64: tegra: Fix up compatible for Tegra234 GPCDMA
      arm64: tegra: Add MGBE nodes on Tegra234
      arm64: tegra: Enable MGBE on Jetson AGX Orin Developer Kit
      arm64: tegra: Fixup iommu-map property formatting

Tianling Shen (2):
      dt-bindings: Add doc for FriendlyARM NanoPi R4S Enterprise Edition
      arm64: dts: rockchip: Add RK3399 NanoPi R4S Enterprise Edition

Tim Harvey (10):
      ARM: dts: imx6qdl-gw52xx: add CAN regulator
      ARM: dts: imx6qdl-gw53xx: add CAN regulator
      ARM: dts: imx6qdl-gw54xx: add CAN regulator
      dt-bindings: arm: Add i.MX8M Mini Gateworks GW7904 board
      arm64: dts: imx8mm-venice-gw7903: add digital I/O ctl gpios
      arm64: dts: imx8mp-venice-gw74xx: add USB DR support
      arm64: dts: imx8mp-venice-gw74xx: add cpu-supply node for cpufreq
      arm64: dts: imx8mp-venice-gw74xx: add WiFi/BT module support
      arm64: dts: imx: Add i.mx8mm Gateworks gw7904 dts support
      arm64: dts: imx8mp-venice-gw74xx: add PCIe support

Tinghan Shen (9):
      arm64: dts: mediatek: Update mt81xx scpsys node to align with dt-b=
indings
      arm64: dts: mt8195: Disable watchdog external reset signal
      arm64: dts: mt8195: Add vdosys and vppsys clock nodes
      arm64: dts: mt8195: Add power domains controller
      arm64: dts: mt8195: Add spmi node
      arm64: dts: mt8195: Add scp node
      arm64: dts: mt8195: Add audio related nodes
      arm64: dts: mt8195: Add iommu and smi nodes
      arm64: dts: mediatek: Fix build warnings of mt8173 vcodec nodes

Tom Fitzhenry (1):
      dt-bindings: arm: rockchip: Add PinePhone Pro bindings

Tommaso Merciai (3):
      arm64: dts: rockchip: set max drive-strength for cif_clkout_m0 on =
px30-evb
      arm64: dts: rockchip: add pinctrl for mipi-pdn pin on px30-evb
      arm64: dts: rockchip: use pin constant for reset-gpios on px30-evb

Trevor Wu (1):
      arm64: dts: mt8195: Specify audio reset controller

Tzung-Bi Shih (1):
      arm64: dts: mt8195: Disable I2C0 node

Uwe Kleine-K=C3=B6nig (1):
      ARM: dts: stm32: Add timer interrupts on stm32mp15

Vidya Sagar (3):
      arm64: tegra: Add regulators required for PCIe
      arm64: tegra: Add P2U and PCIe controller nodes to Tegra234 DT
      arm64: tegra: Enable PCIe slots in P3737-0000 board

Vignesh Raghavendra (5):
      dt-bindings: arm: ti: Rearrange IOPAD macros alphabetically
      dt-bindings: arm: ti: Add bindings for AM62A7 SoC
      dt-bindings: pinctrl: k3: Introduce pinmux definitions for AM62A
      arm64: dts: ti: Introduce AM62A7 family of SoCs
      arm64: dts: ti: Add support for AM62A7-SK

Vladimir Oltean (4):
      arm64: dts: ls1028a: move DSA CPU port property to the common SoC =
dtsi
      arm64: dts: ls1028a: mark enetc port 3 as a DSA master too
      arm64: dts: ls1028a: enable swp5 and eno3 for all boards
      arm64: dts: ls1028a-rdb: add more ethernet aliases

Vyacheslav Bocharov (2):
      arm64: dts: meson-axg: add support for JetHub D1p (j110)
      dt-bindings: arm: amlogic: add bindings for Jethub D1p (j110)

Wei Fang (2):
      arm64: dts: imx8ulp: Add the fec support
      arm64: dts: imx8ulp-evk: Add the fec support

William Zhang (6):
      dt-bindings: arm64: bcmbca: Merge BCM4908 into BCMBCA
      dt-bindings: arm64: bcmbca: Update BCM4908 description
      arm64: dts: bcmbca: update BCM4908 board dts files
      arm64: dts: Move BCM4908 dts to bcmbca folder
      arm64: dts: Add BCM4908 generic board dts
      arm64: bcmbca: Merge ARCH_BCM4908 to ARCH_BCMBCA

Wolfram Sang (11):
      arm64: dts: renesas: r8a779f0: Add SDHI0 support
      arm64: dts: renesas: spider-cpu: Enable eMMC0
      arm64: dts: renesas: r8a779f0: Add CMT support
      arm64: dts: renesas: r8a779f0: Add TMU nodes
      arm64: dts: renesas: r8a779{51|60|65}: Put I2C aliases to board fi=
les
      arm64: dts: renesas: r8a77970: Put I2C aliases to board files
      arm64: dts: renesas: r8a77980: Put I2C aliases to board files
      arm64: dts: renesas: r8a77990: Put I2C aliases to board files
      arm64: dts: renesas: r8a779a0: Put I2C aliases to board files
      arm64: dts: renesas: r8a774a1: Put I2C aliases to board files
      ARM: dts: stm32: argon: remove spidev node

Xiaowei Bao (1):
      arm64: dts: ls1046a: Add the PME interrupt and big-endian to PCIe =
EP nodes

YC Hung (1):
      arm64: dts: mt8195: Add adsp node and adsp mailbox nodes

YT Lee (1):
      arm64: dts: mt8195: Add cpufreq node

Yangtao Li (1):
      arm64: dts: allwinner: a100: Add device node for DMA controller

Yassine Oudjana (2):
      arm64: dts: qcom: msm8996-xiaomi-*: Add LEDs
      arm64: dts: qcom: Use WCD9335 DT bindings

Yegor Yefremov (6):
      ARM: dts: am335x-baltos: change nand-xfer-type
      ARM: dts: am335x-baltos: add GPIO names for ir3220 and ir5221 devi=
ces
      ARM: dts: am335x-baltos: add GPIO names for ir2110 device
      ARM: dts: am335x-netcan: add GPIO names for NetCAN Plus device
      ARM: dts: am335x-netcom: add GPIO names for NetCom Plus 8-port dev=
ices
      ARM: dts: am335x-netcom: add GPIO names for NetCom Plus 2-port dev=
ices

Yunlong Jia (2):
      arm64: dts: qcom: Add SKU6 for sc7180-trogdor-pazquel-lte-parade
      dt-bindings: arm: qcom: Document additional sku6 for sc7180 pazquel


dirstat only for brevity:
   0.0% Documentation/devicetree/bindings/arm/aspeed/
   0.2% Documentation/devicetree/bindings/arm/bcm/
   0.2% Documentation/devicetree/bindings/arm/marvell/
   0.0% Documentation/devicetree/bindings/arm/ti/
   0.7% Documentation/devicetree/bindings/arm/
   0.5% Documentation/devicetree/bindings/clock/
   0.0% Documentation/devicetree/bindings/mfd/
   0.5% Documentation/devicetree/bindings/net/
   0.0% Documentation/devicetree/bindings/pci/
   0.0% Documentation/devicetree/bindings/serial/
   0.9% Documentation/devicetree/bindings/soc/imx/
   0.0% Documentation/devicetree/bindings/soc/renesas/
   0.0% Documentation/devicetree/bindings/spi/
   0.4% Documentation/devicetree/bindings/sram/
   0.0% Documentation/devicetree/bindings/
  20.1% arch/arm/boot/dts/
   0.4% arch/arm64/boot/dts/allwinner/
   2.3% arch/arm64/boot/dts/amlogic/
   0.0% arch/arm64/boot/dts/broadcom/bcm4908/
   0.4% arch/arm64/boot/dts/broadcom/bcmbca/
   0.0% arch/arm64/boot/dts/broadcom/
   0.4% arch/arm64/boot/dts/exynos/
  15.9% arch/arm64/boot/dts/freescale/
   0.9% arch/arm64/boot/dts/marvell/
  10.1% arch/arm64/boot/dts/mediatek/
   5.5% arch/arm64/boot/dts/nvidia/
  14.5% arch/arm64/boot/dts/qcom/
   7.1% arch/arm64/boot/dts/renesas/
  11.3% arch/arm64/boot/dts/rockchip/
   1.5% arch/arm64/boot/dts/socionext/
   3.7% arch/arm64/boot/dts/ti/
   0.0% arch/arm64/
   1.1% include/dt-bindings/clock/
   0.0% include/dt-bindings/firmware/imx/
   0.0% include/dt-bindings/interrupt-controller/
   0.0% include/dt-bindings/memory/
   0.0% include/dt-bindings/pinctrl/
   0.0% include/dt-bindings/power/
