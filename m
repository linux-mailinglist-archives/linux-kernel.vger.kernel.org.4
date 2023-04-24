Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44CE46ED687
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 23:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232580AbjDXVHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 17:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbjDXVG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 17:06:57 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BBE561A4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 14:06:48 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 4BF125C0347;
        Mon, 24 Apr 2023 17:06:27 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Mon, 24 Apr 2023 17:06:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1682370387; x=1682456787; bh=clY2jv0DD5WzLo3bC/ujrgNtZxxTChjuovu
        gcWkcF28=; b=g0iQ0KT1GWkejZirQKvsfG1DR+B3uikknVtvNdtGZXolkGk/By5
        czSYTygiMgk1Ep7aNRAyo8KzTA1yK7UgsuZNmvwopGJUqaVLua4rFYWAyohZjw94
        4OOam9b6FQZR4OJYeLeLfah3bPTvmlbI7Gqa+N4J1m0AXgdw1B9tQshcC8s7Tpoh
        D//0tyPa/dsTWR3f+BH51Kkv+HYrGqyCZKlvhDbZSHQTOuiImTAWi4HG2DAGtJ4t
        kw9Dlm+cMHAJAvti9H8g5QPuieP0jErnks56D5dkk3s020HMYAnsr3lsuKskfyg3
        vTeuQU36HhtBTSWTiUYd6iqIVcfZKYmpU4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1682370387; x=1682456787; bh=clY2jv0DD5WzLo3bC/ujrgNtZxxTChjuovu
        gcWkcF28=; b=GwxXypHVf8/HhBEaXgA1Va1HtU4Eekv2A+YdhC5nrQmvqNjJp2c
        Q4CEFp7qL3N/uYoTz0jjQ3MGEYCikn1kyqJqiUhmCjT7cT71neYYPfxs5BYfj1bF
        izvGwLJTAVd3VDrZJPw0vbgpBa5VyPjqoHjgd+HCaztxecHoCU9VhEzAsQRK3ayn
        fUvcUI+F0m7ey2H6Oq9Fa84mF6NFzEVykcKFoUjJ495YMufBhwvb5mMmVKEqT2Ur
        E6WWi6j/ivyxHDdJeoyHhyV9GevSYfr2jXivADsfty85LNf64DNCnZ54J/OsAB0M
        pPLx1/QQFNv1PzdpoTJXZYb8u64ANXY7R3Q==
X-ME-Sender: <xms:U-9GZKtMBxMnAo1QNM7d5exMjuMRznc5qfUCc4REw27nFOAiELESiA>
    <xme:U-9GZPdil-ic54saZLN8l90kMXWmcomfV0G39u_z2nrC-J8r9gcA2KiY-Wmfozd1R
    y4Kli23X1umEyOTeeQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfedutddgudehjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedf
    tehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrf
    grthhtvghrnhepgfekueelgeeigefhudduledtkeefffejueelheelfedutedttdfgveeu
    feefieegnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:U-9GZFxlc3BP4ghKDkGklwCf56Mf3tqpaP3Sj22M_vD13ejLaytZCQ>
    <xmx:U-9GZFM85gt9IRWzms5ThxMFILKoW9079RaavRKt_371jVVgHPxxjg>
    <xmx:U-9GZK8FAr5MzVlzWKl1fP_jozz3YS8EjY1OunuzFiGHEkSmfrlByw>
    <xmx:U-9GZAlfe-gkC6qDtTm-E0dHj1VBA5o_7s71Srhgfvx4FFqY8eF2ww>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 013DDB60086; Mon, 24 Apr 2023 17:06:26 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-374-g72c94f7a42-fm-20230417.001-g72c94f7a
Mime-Version: 1.0
Message-Id: <3579080b-db88-493c-a260-7313a81e2aa3@app.fastmail.com>
In-Reply-To: <bbd25997-173e-4c3b-930c-65c6232908e3@app.fastmail.com>
References: <bbd25997-173e-4c3b-930c-65c6232908e3@app.fastmail.com>
Date:   Mon, 24 Apr 2023 23:06:06 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Linus Torvalds" <torvalds@linux-foundation.org>
Cc:     soc@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL 4/4] ARM: SoC devicetree changes for 6.4
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,LOTS_OF_MONEY,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit eeac8ede17557680855031c6f305ece2378af=
326:

  Linux 6.3-rc2 (2023-03-12 16:36:44 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-d=
t-6.4

for you to fetch changes up to b8a4346d25024e00714fb6ceb0709075827f335d:

  Merge tag 'mvebu-dt64-6.4-1' of git://git.kernel.org/pub/scm/linux/ker=
nel/git/gclement/mvebu into soc/dt (2023-04-18 16:10:53 +0200)

----------------------------------------------------------------
ARM: SoC devicetree changes for 6.4

The devicetree changes overall are again dominated by the Qualcomm
Snapdragon platform that weighs in at over 300 changesets, but there
are many updates across other platforms as well, notably Mediatek, NXP,
Rockchips, Renesas, TI, Samsung and ST Microelectronics. These all
add new features for existing machines, as well as new machines and
SoCs.

The newly added SoCs are:

 - Allwinner T113-s, an Cortex-A7 based variant of the RISC-V
   based D1 chip.

 - StarFive JH7110, a RISC-V SoC based on the Sifive U74 core
   like its JH7100 predecessor, but with additional CPU cores
   and a GPU.

 - Apple M2 as used in current Macbook Air/Pro and Mac Mini
   gets added, with comparable support as its M1 predecessor.

 - Unisoc UMS512 (Tiger T610) is a midrange smartphone SoC

 - Qualcomm IPQ5332 and IPQ9574 are Wi-Fi 7 networking SoCs,
   based on the Cortex-A53 and Cortex-A73 cores, respectively.

 - Qualcomm sa8775p is an automotive SoC derived from the
   Snapdragon family.

Including the initial board support for the added SoC platforms,
there are 52 new machines. The largest group are 19 boards
industrial embedded boards based on the NXP i.MX6 (32-bit)
and i.MX8 (64-bit) families.

Others include:

 - Two boards based on the Allwinner f1c200s ultra-low-cost chip

 - Three "Banana Pi" variants based on the Amlogic g12b
   (A311D, S922X) SoC.

 - The Gl.Inet mv1000 router based on Marvell Armada 3720

 - A Wifi/LTE Dongle based on Qualcomm msm8916

 - Two robotics boards based on Qualcomm QRB chips

 - Three Snapdragon based phones made by Xiaomi

 - Five developments boards based on various Rockchip SoCs,
   including the rk3588s-khadas-edge2 and a few NanoPi
   models

 - The AM625 Beagleplay industrial SBC

Another 14 machines get removed: both boards for the obsolete "oxnas"
platform, three boards for the Renesas r8a77950 SoC that were only for
pre-production chips, and various chromebook models based on the Qualcomm
Sc7180 "trogdor" design that were never part of products.

----------------------------------------------------------------

Abel Vesa (4):
      arm64: dts: qcom: sm8550: Add bias pull up value to tlmm i2c data =
clk states
      arm64: dts: qcom: sm8550: Fix PCIe PHYs and controllers nodes
      arm64: dts: qcom: sm8550-mtp: Add eUSB2 repeater node
      arm64: dts: qcom: sm8550: Add the Inline Crypto Engine node

Adam Skladowski (8):
      arm64: dts: qcom: msm8976: Add and provide xo clk to rpmcc
      arm64: dts: msm8953: Replace xo_board with rpmcc sourced xo
      arm64: dts: msm8953: Provide dsi_phy clocks to gcc
      arm64: dts: msm8953: Drop unsupported dwc3 flag
      arm64: dts: msm8953: Pad regs to 8 digits
      arm64: dts: MSM8953: Add wcnss nodes
      arm64: dts: MSM8953: Add mpss nodes
      arm64: dts: MSM8953: Add lpass nodes

Alex Elder (2):
      ARM: dts: qcom: sdx65: add IPA information
      ARM: dts: qcom: sdx65: move status properties to end of nodes

Alexander Stein (2):
      arm64: dts: imx93: Add FlexSPI support
      arm64: dts: imx8mp-tqma8mpql-mba8mpxl: Enable wakeup-source for GP=
IO buttons

Alexandre Bailon (1):
      arm64: dts: mediatek: Increase the size BL31 reserved memory

Alexandre Mergnat (5):
      arm64: dts: mediatek: add i2c support for mt8365 SoC
      arm64: dts: mediatek: enable i2c0 for mt8365-evk board
      arm64: dts: mediatek: add pwrap support to mt8365 SoC
      arm64: dts: mediatek: add mmc support for mt8365 SoC
      arm64: dts: mediatek: add ethernet support for mt8365 SoC

Alexandre Torgue (1):
      ARM: dts: stm32: fix spi1 pin assignment on stm32mp15

Alexey Romanov (1):
      arm64: dts: meson-a1: add gpio_intc node

Alistair Francis (2):
      ARM: dts: imx7d-remarkable2: Enable the cyttsp5
      ARM: dts: imx7d-remarkable2: Enable the rohm,bd71815

Alyssa Rosenzweig (2):
      arm64: dts: mediatek: mt8192: Add GPU nodes
      arm64: dts: mediatek: mt8192-asurada: Enable GPU

Anand Gadiyar (2):
      arm64: dts: ti: Refractor AM625 SK dts
      arm64: ti: dts: Add support for AM62x LP SK

Andre Przywara (6):
      arm64: dts: allwinner: h5: OrangePi PC2: add OPP table to enable D=
VFS
      ARM: dts: suniv: Add Lctech Pi F1C200s devicetree
      dts: add riscv include prefix link
      ARM: dts: sunxi: add Allwinner T113-s SoC .dtsi
      dt-bindings: arm: sunxi: document MangoPi MQ-R board names
      ARM: dts: sunxi: add MangoPi MQ-R-T113 board

Andreas Kemnade (2):
      dt-bindings: arm: fsl: add compatible string for Tolino Vision
      ARM: dts: imx: Add devicetree for Tolino Vison

Andrew Davis (5):
      arm64: dts: ti: k3-j721e-sk: Remove firmware-name override for R5F
      ARM: dts: ti: Add AM57xx GP EVM board support
      ARM: dts: ti: Add AM57xx GP EVM Rev A3 board support
      ARM: dts: am57xx-idk: Add IDK displays and touchscreens
      ARM: dts: omap: Drop ti,omap36xx compatible

Andrew Lunn (4):
      ARM: dts: kirkwood: Add missing phy-mode and fixed links
      ARM: dts: orion5: Add missing phy-mode and fixed links
      ARM: dts: armada: Add missing phy-mode and fixed links
      ARM64: dts: marvell: cn9310: Add missing phy-mode

AngeloGioacchino Del Regno (31):
      arm64: dts: mediatek: mt8183-kukui: Couple VGPU and VSRAM_GPU regu=
lators
      arm64: dts: mediatek: mt8183-kukui: Override vgpu/vsram_gpu constr=
aints
      arm64: dts: mediatek: mt8183: Remove second opp-microvolt entries =
from gpu table
      arm64: dts: mt8183-pumpkin: Couple VGPU and VSRAM_GPU regulators
      arm64: dts: mediatek: mt8183-evb: Couple VGPU and VSRAM_GPU regula=
tors
      arm64: dts: mediatek: mt8183: Use mediatek,mt8183b-mali as GPU com=
patible
      arm64: dts: mediatek: mt8192: Add mfg_ref_sel clock to MFG0 domain
      arm64: dts: mediatek: mt8192-asurada: Assign sram supply to MFG1 pd
      arm64: dts: mediatek: mt8192-asurada: Fix voltage constraint for V=
gpu
      arm64: dts: mediatek: mt8192-asurada: Couple VGPU and VSRAM_OTHER =
regulators
      ...

Angus Ainslie (1):
      arm64: dts: imx8mq-librem5: add the magnetometer mount matrix

Apurva Nandan (1):
      arm64: dts: ti: k3-j784s4-evm: Add eMMC mmc0 support

Arnd Bergmann (38):
      Merge tag 'dt64-cleanup-6.4' of https://git.kernel.org/pub/scm/lin=
ux/kernel/git/krzk/linux-dt into soc/dt
      Merge tag 'dt-cleanup-6.4' of https://git.kernel.org/pub/scm/linux=
/kernel/git/krzk/linux-dt into soc/dt
      Merge tag 'renesas-dt-bindings-for-v6.4-tag1' of git://git.kernel.=
org/pub/scm/linux/kernel/git/geert/renesas-devel into soc/dt
      Merge tag 'renesas-dts-for-v6.4-tag1' of git://git.kernel.org/pub/=
scm/linux/kernel/git/geert/renesas-devel into soc/dt
      Merge tag 'omap-for-v6.4/dt-signed' of git://git.kernel.org/pub/sc=
m/linux/kernel/git/tmlind/linux-omap into soc/dt
      Merge tag 'omap-for-v6.4/dt-overlays-signed' of git://git.kernel.o=
rg/pub/scm/linux/kernel/git/tmlind/linux-omap into soc/dt
      Merge tag 'at91-dt-6.4' of git://git.kernel.org/pub/scm/linux/kern=
el/git/at91/linux into soc/dt
      ...

Ar=C4=B1n=C3=A7 =C3=9CNAL (1):
      arm: dts: mt7623: disable home key on Bananapi BPI-R2

Balsam CHIHI (2):
      arm64: dts: mediatek: mt8195: Add thermal zones and thermal nodes
      arm64: dts: mediatek: mt8195: Add temperature mitigation threshold

Bartosz Golaszewski (26):
      arm64: dts: sm8150: add the QUPv3 high-speed UART node
      arm64: dts: qcom: sa8155p-adp: enable the GNSS high-speed UART
      arm64: dts: qcom: add initial support for qcom sa8775p-ride
      arm64: dts: qcom: sa8775p: add cpufreq node
      arm64: dts: qcom: sm8150: fix the uart9 label
      arm64: dts: qcom: sa8775p: add the QUPv3 #2 node
      arm64: dts: qcom: sa8775p-ride: enable QUPv3 #2
      arm64: dts: qcom: sa8775p: add the i2c18 node
      arm64: dts: qcom: sa8775p-ride: enable i2c18
      arm64: dts: qcom: sa8775p: add the spi16 node
      arm64: dts: qcom: sa8775p-ride: enable the SPI node
      arm64: dts: qcom: sa8775p: add high-speed UART nodes
      arm64: dts: qcom: sa8775p-ride: enable the GNSS UART port
      arm64: dts: qcom: sa8775p-ride: enable the BT UART port
      ....

Ben Dooks (1):
      arm64: tegra: Add vccmq on Jetson TX2

Bhavya Kapoor (3):
      arm64: dts: ti: k3-j721e-main: Remove ti,strobe-sel property
      arm64: dts: ti: k3-j721s2-mcu-wakeup: Add support for ADC nodes
      arm64: dts: ti: k3-j721s2-common-proc-board: Add pinmux informatio=
n for ADC

Bhupesh Sharma (7):
      arm64: dts: qcom: sm6115: Add remoteproc nodes
      arm64: dts: qcom: sm6115: Cleanup USB node's label
      arm64: dts: qcom: sm6115: Move USB node's 'maximum-speed' and 'dr_=
mode' properties to dts
      arm64: dts: qcom: sm6115: Move SDHC node(s)'s 'pinctrl' properties=
 to dts
      arm64: dts: qcom: sdm845: Fix the BAM DMA engine compatible string
      dt-bindings: arm: qcom: Document the Qualcomm qrb4210-rb2 board
      arm64: dts: qcom: Add base qrb4210-rb2 board dts

Biju Das (6):
      arm64: dts: renesas: r9a09g011: Add USB3 DRD, device and host nodes
      arm64: dts: renesas: rzv2mevk2: Enable USB3 DRD, Peripheral and Ho=
st
      arm64: dts: renesas: rzv2mevk2: Enable USB3 role switch
      arm64: dts: renesas: rzv2mevk2: Add uart0 pins
      arm64: dts: renesas: rzg2l: Add clock-names and reset-names to DMA=
C nodes
      arm64: dts: renesas: r9a07g044: Enable SCI0 using DT overlay

Bjorn Andersson (6):
      Merge branch '20230307062232.4889-1-quic_kathirav@quicinc.com' int=
o arm64-for-6.4
      Merge branch 'arm64-fixes-for-6.3' into arm64-for-6.4
      Merge branch '20230208091340.124641-1-konrad.dybcio@linaro.org' in=
to HEAD
      arm64: dts: qcom: sc8280xp: Define uart2
      Merge branch '20230316072940.29137-2-quic_devipriy@quicinc.com' in=
to HEAD
      Merge branch 'ib-qcom-quad-spi' of https://git.kernel.org/pub/scm/=
linux/kernel/git/linusw/linux-pinctrl into arm64-for-6.4

Brian Masney (1):
      arm64: dts: qcom: sa8540p-ride: correct name of remoteproc_nsp0 fi=
rmware

Chanh Nguyen (1):
      ARM: dts: aspeed: mtmitchell: Enable NCSI

Chia-Wei Wang (1):
      ARM: dts: aspeed-g6: Add UDMA node

Chris Morgan (1):
      arm64: dts: rockchip: add panel to Anbernic RG353 series

Christian Hewitt (5):
      dt-bindings: arm: amlogic: add support for BananaPi M2S variants
      arm64: dts: meson: add support for BananaPi M2S variants
      arm64: dts: meson: gxbb-kii-pro: sort and tidy the dts
      arm64: dts: meson: gxbb-kii-pro: complete the bluetooth node
      arm64: dts: meson: gxbb-kii-pro: add initial audio support

Christian Marangi (4):
      ARM: dts: qcom: add per SoC compatible for qcom,kpss-gcc nodes
      ARM: dts: qcom: add and fix clock configuration for kpss-gcc nodes
      ARM: dts: qcom: add missing clock configuration for kpss-acc-v1
      ARM: dts: qcom: rename kpss-acc-v2 nodes to power-manager nodes

Christophe Kerello (1):
      ARM: dts: stm32: add FMC support on STM32MP13x SoC family

Chunyan Zhang (1):
      arm64: dts: sprd: Add support for Unisoc's UMS512

Cl=C3=A9ment L=C3=A9ger (1):
      dt-bindings: soc: renesas: renesas.yaml: Add renesas,rzn1d400-eb c=
ompatible

Conor Dooley (3):
      riscv: dts: microchip: add mpfs specific macb reset support
      riscv: dts: microchip: fix the mpfs' mailbox regs
      Merge branch 'riscv-jh7110_initial_dts' into riscv-dt-for-next

Cristian Ciocaltea (14):
      arm64: dts: rockchip: Add pwm-fan to rk3588-rock-5b
      arm64: dts: rockchip: Fix SCMI assigned clocks on rk3588s
      arm64: dts: rockchip: Assign PLL_PPLL clock rate to 1.1 GHz on rk3=
588s
      arm64: dts: rockchip: Add rk3588s I2S nodes
      arm64: dts: rockchip: Add I2S rk3588 nodes
      arm64: dts: rockchip: Add rk3588-rock-5b analog audio
      ARM: dts: sun6i: a31: Switch dma-names order for snps,dw-apb-uart =
nodes
      ARM: dts: sun8i: a23/a33: Switch dma-names order for snps,dw-apb-u=
art nodes
      ARM: dts: sun8i: v3s: Switch dma-names order for snps,dw-apb-uart =
nodes
      ARM: dts: sunxi: h3/h5: Switch dma-names order for snps,dw-apb-uar=
t nodes
      riscv: dts: allwinner: d1: Switch dma-names order for snps,dw-apb-=
uart nodes
      arm64: dts: rockchip: Drop RTC clock-frequency on rk3588-rock-5b
      arm64: dts: rockchip: Use generic name for es8316 on Pinebook Pro =
and Rock 5B
      arm64: dts: rockchip: Add vdd_cpu_big regulators to rk3588-rock-5b

Danila Tikhonov (1):
      arm64: dts: qcom: pm8150l: add spmi-flash-led node

Delphine CC Chiu (2):
      ARM: dts: aspeed: greatlakes: Add gpio names
      ARM: dts: aspeed: greatlakes: add mctp device

Devarsh Thakkar (1):
      arm64: dts: ti: k3-am62a7-sk: Fix DDR size to full 4GB

Devi Priya (3):
      dt-bindings: arm: qcom: Add ipq9574 compatible
      dt-bindings: clock: Add ipq9574 clock and reset definitions
      arm64: dts: qcom: Add ipq9574 SoC and AL02 board support

Dhruva Gole (1):
      arm64: dts: ti: k3-am625-sk: Add ti,vbus-divider property to usbss1

Dmitry Baryshkov (2):
      arm64: dts: qcom: ipq8074-hk01: enable QMP device, not the PHY node
      arm64: dts: qcom: ipq8074-hk10: enable QMP device, not the PHY node

Douglas Anderson (18):
      arm64: dts: qcom: sc7180: Delete wormdingler-rev0
      arm64: dts: qcom: sc7180: Delete kingoftown-rev0
      arm64: dts: qcom: sc7180: Delete lazor-rev0
      arm64: dts: qcom: sc7180: Delete mrbland
      dt-bindings: pinctrl: qcom: tlmm should use output-disable, not in=
put-enable
      dt-bindings: pinctrl: qcom: Add output-enable
      pinctrl: qcom: Support OUTPUT_ENABLE; deprecate INPUT_ENABLE
      MAINTAINERS: qcom: Add reviewer for Qualcomm Chromebooks
      arm64: dts: sc7180: Rename qspi data12 as data23
      arm64: dts: sc7280: Rename qspi data12 as data23
      arm64: dts: sdm845: Rename qspi data12 as data23
      ...

Dylan Van Assche (5):
      arm64: dts: qcom: sdm845: add SLPI remoteproc
      dt-bindings: firmware: qcom: scm: add SSC_Q6 and ADSP_Q6 VMIDs
      arm64: dts: qcom: sdm845: add SLPI FastRPC support
      arm64: dts: qcom: sdm845-oneplus: enable SLPI
      arm64: dts: qcom: sdm845-shift-axolotl: enable SLPI

Eddie James (3):
      ARM: dts: aspeed: everest: Add reserved memory for TPM event log
      ARM: dts: aspeed: bonnell: Remove MAC3
      ARM: dts: aspeed: bonnell: Update eeprom size

Emil Renner Berthing (6):
      dt-bindings: clock: Add StarFive JH7110 system clock and reset gen=
erator
      dt-bindings: clock: Add StarFive JH7110 always-on clock and reset =
generator
      dt-bindings: timer: Add StarFive JH7110 clint
      dt-bindings: interrupt-controller: Add StarFive JH7110 plic
      riscv: dts: starfive: Add initial StarFive JH7110 device tree
      riscv: dts: starfive: Add StarFive JH7110 VisionFive 2 board devic=
e tree

Enrico Mioso (1):
      arm64: dts: marvell: add DTS for GL.iNet GL-MV1000

Fabien Parent (2):
      arm64: dts: mediatek: Initial mt8365-evk support
      arm64: dts: mediatek: add mt6357 device-tree

Fabio Estevam (1):
      ARM: dts: nomadik: Replace deprecated spi-gpio properties

Fabrizio Castro (1):
      arm64: dts: renesas: rzv2mevk2: Add uSD card and eMMC support

Frank Li (2):
      arm64: dts: imx8qxp: add cadence usb3 support
      arm64: dts: freescale: imx8qxp-mek: enable cadence usb3

Geert Uytterhoeven (18):
      arm64: dts: renesas: r8a779g0: Add CAN-FD node
      arm64: dts: renesas: white-hawk: Add CAN-FD support
      arm64: dts: renesas: falcon: Describe CAN clock
      arm64: dts: renesas: rcar-gen3: Remove bogus "turbo-mode" properti=
es
      arm64: dts: renesas: r8a779g0: Add thermal nodes
      arm64: dts: renesas: r8a77990: Remove bogus voltages from OPP table
      arm64: dts: renesas: r8a774c0: Remove bogus voltages from OPP table
      ARM: dts: armadillo800eva: Add I2C EEPROM for MAC address
      arm64: dts: renesas: condor: Add I2C EEPROM for PMIC
      arm64: dts: renesas: ulcb: Add I2C EEPROM for PMIC
      ...

Gergo Koteles (1):
      arm64: dts: qcom: sdm845-oneplus-common: add Hall sensor

H. Nikolaus Schaller (2):
      ARM: dts: gta04: fix excess dma channel usage
      ARM: dts: omap3-gta04: fix compatible record for GTA04 board

Hal Feng (1):
      dt-bindings: riscv: Add SiFive S7 compatible

Hector Martin (2):
      dt-bindings: power: apple,pmgr-pwrstate: Add t8112 compatible
      arm64: dts: apple: t8112: Initial t8112 (M2) device trees

Heiko Stuebner (1):
      ARM: dts: rockchip: Add mmc aliases for rk3288-veyron devices

Heiner Kallweit (2):
      arm64: dts: meson: adjust order of some compatibles
      arm: dts: meson: adjust order of some compatibles

Henrik Grimler (4):
      arm64: dts: exynos: drop mshc aliases
      arm64: dts: exynos: add mmc aliases
      ARM: dts: exynos: replace mshc0 alias with mmc-ddr-1_8v property
      ARM: dts: exynos: add mmc aliases

Icenowy Zheng (5):
      ARM: dts: suniv: add USB-related device nodes
      ARM: dts: suniv: licheepi-nano: enable USB
      dt-bindings: vendor-prefixes: add Source Parts and Lctech names
      dt-binding: arm: sunxi: add two board compatible strings
      ARM: dts: suniv: add device tree for PopStick v1.1

Jacky Bai (1):
      arm64: dts: imx93: Add the bbnsm dts node

Jai Luthra (1):
      arm64: dts: ti: Enable audio on SK-AM62(-LP)

Janne Grunau (14):
      dt-bindings: arm: apple: apple,pmgr: Add t8112-pmgr compatible
      dt-bindings: watchdog: apple,wdt: Add t8112-wdt compatible
      dt-bindings: arm: cpus: Add apple,avalanche & blizzard compatibles
      dt-bindings: interrupt-controller: apple,aic2: Add apple,t8112-aic=
 compatible
      dt-bindings: iommu: apple,sart: Add apple,t8112-sart compatible st=
ring
      dt-bindings: mailbox: apple,mailbox: Add t8112 compatibles
      dt-bindings: nvme: apple: Add apple,t8112-nvme-ans2 compatible str=
ing
      dt-bindings: pci: apple,pcie: Add t8112 support
      ...

Jayesh Choudhary (3):
      arm64: dts: ti: k3-j784s4-*: Add 'ti,sci-dev-id' for NAVSS nodes
      arm64: dts: ti: k3-j784s4-main: Enable crypto accelerator
      arm64: dts: ti: k3-am62-main: Add McASP nodes

Jerome Brunet (1):
      arm64: dts: amlogic: gxl: use gxl mdio multiplexer

Jianhua Lu (4):
      arm64: dts: qcom: sm8250-xiaomi-elish: Correct venus firmware path
      arm64: dts: qcom: Split elish dts into common dtsi and elish-boe d=
ts
      arm64: dts: qcom: sm8250-xiaomi-elish-boe: Add mdss and dsi panel
      arm64: dts: qcom: sm8250-xiaomi-elish-csot: Add Xiaomi Mi Pad 5 Pr=
o CSOT variant

Jianlong Huang (1):
      riscv: dts: starfive: Add StarFive JH7110 pin function definitions

Joakim Zhang (2):
      arm64: dts: imx8qxp: add flexcan in adma
      arm64: dts: imx8qm: add can node in devicetree

Joel Selvaraj (1):
      arm64: dts: qcom: sdm845-xiaomi-beryllium: add notification LED

Johan Hovold (16):
      arm64: dts: qcom: sc8280xp-pmics: add pmk8280 rtc
      arm64: dts: qcom: sc8280xp-pmics: add pmk8280 sdam nvram
      arm64: dts: qcom: sc8280xp-crd: enable rtc
      arm64: dts: qcom: sc8280xp-x13s: enable rtc
      arm64: dts: qcom: sc8280xp: fix external display power domain
      arm64: dts: qcom: sc8280xp-x13s: mark s11b regulator as always-on
      arm64: dts: qcom: sc8280xp-x13s: mark s10b regulator as always-on
      arm64: dts: qcom: sc8280xp-x13s: mark s12b regulator as always-on
      arm64: dts: qcom: sc8280xp-x13s: mark bob regulator as always-on
      arm64: dts: qcom: sc8280xp-x13s: add pmic regulator supplies
      ...

Johan Jonker (9):
      ARM: dts: rockchip: fix rk3288 dsi node
      ARM: dts: rockchip: fix rk3288 lvds node
      ARM: dts: rockchip: fix rk3288 dp node
      arm64: dts: rockchip: fix px30 lvds node
      arm64: dts: rockchip: fix px30 dsi node
      arm64: dts: rockchip: fix rk3399 dsi node
      arm64: dts: rockchip: fix rk3399 dp node
      arm64: dts: rockchip: rename vbus-supply to phy-supply in rk3566-b=
ox-demo.dts
      arm64: dts: rockchip: remove hclk from dsi node on rk356x

John Clark (1):
      arm64: dts: rockchip: Add pinctrl gpio-ranges for rk356x

Jon Hunter (2):
      arm64: tegra: Add DSU PMUs for Tegra234
      arm64: tegra: Populate USB Type-C Controller for Jetson AGX Orin

Julien Panis (1):
      arm64: dts: ti: k3-am62: Add watchdog nodes

Kathiravan T (9):
      dt-bindings: clock: Add Qualcomm IPQ5332 GCC
      dt-bindings: qcom: add ipq5332 boards
      arm64: dts: qcom: add IPQ5332 SoC and MI01.2 board support
      arm64: dts: qcom: ipq5332: enable the download mode support
      arm64: dts: qcom: ipq5332: add SMEM support
      arm64: dts: qcom: ipq5332: enable the CPUFreq support
      arm64: dts: qcom: ipq5332: add few device nodes
      dt-bindings: arm: qcom: document MI01.6 board based on IPQ5332 fam=
ily
      arm64: dts: qcom: ipq5332: add support for the RDP468 variant

Komal Bajaj (1):
      arm64: dts: qcom: qdu1000: Add LLCC/system-cache-controller

Konrad Dybcio (60):
      arm64: dts: qcom: sm6115: Un-enable SPI5 by default
      arm64: dts: qcom: sm6375: Add missing power-domain-named to CDSP
      arm64: dts: qcom: sm8550: Use correct CPU compatibles
      dt-bindings: clock: Add Qcom SM6125 GPUCC
      dt-bindings: clock: Add Qcom SM6375 GPUCC
      dt-bindings: clock: Add Qcom SM6115 GPUCC
      ARM: dts: qcom-apq8064: Fix opp table child name
      arm64: dts: qcom: sm6375: Add RMTFS
      arm64: dts: qcom: msm8998: Fix stm-stimulus-base reg name
      arm64: dts: qcom: pm8998: Add a specific compatible for coincell c=
hg
      arm64: dts: qcom: sc7280: Add qcom,smmu-500 to Adreno SMMU
      arm64: dts: qcom: sm8150: Add qcom,smmu-500 to Adreno SMMU
      arm64: dts: qcom: sm8250: Add qcom,smmu-500 to Adreno SMMU
      arm64: dts: qcom: sm8350: Add qcom,smmu-500 to Adreno SMMU
      arm64: dts: qcom: msm8996: Add missing DWC3 quirks
      arm64: dts: qcom: sc8280xp: Use correct CPU compatibles
      arm64: dts: qcom: sc7180: Add SoC-specific compatible to cpufreq_hw
      arm64: dts: qcom: sdm845: Add SoC-specific compatible to cpufreq_hw
      arm64: dts: qcom: sm6115: Add SoC-specific compatible to cpufreq_hw
      arm64: dts: qcom: sm6350: Add SoC-specific compatible to cpufreq_hw
      arm64: dts: qcom: sm8150: Add SoC-specific compatible to cpufreq_hw
      arm64: dts: qcom: msm8998-yoshino: Use SONY GPIO names
      arm64: dts: qcom: msm8998-yoshino: Use actual pin names for pin no=
des
      arm64: dts: qcom: sm6115: Add GPUCC and Adreno SMMU
      arm64: dts: qcom: sc7280: Use the correct BWMON fallback compatible
      arm64: dts: qcom: sc8280xp: Use the correct BWMON fallback compati=
ble
      arm64: dts: qcom: sdm845: Use the correct BWMON compatible
      ...

Krishna chaitanya chundru (1):
      arm64: dts: qcom: sc7280: Mark PCIe controller as cache coherent

Krzysztof Kozlowski (130):
      ARM: dts: exynos: align STMPE ADC node name with bindings in P4 No=
te
      ARM: dts: exynos: drop fake align STMPE properties in P4 Note
      ARM: dts: exynos: add ports to TC358764 bridge on Arndale
      ARM: dts: exynos: fix WM8960 clock name in Itop Elite
      ARM: dts: exynos: correct whitespace in Midas
      ARM: dts: s5pv210: correct MIPI CSIS clock name
      ARM: dts: exynos: drop unused samsung,camclk-out property in Midas
      ARM: dts: exynos: move MIPI phy to PMU node in Exynos3250
      ARM: dts: exynos: move MIPI phy to PMU node in Exynos4
      ARM: dts: exynos: move DP and MIPI phys to PMU node in Exynos5420
      ARM: dts: exynos: move DP and MIPI phys to PMU node in Exynos5250
      arm64: dts: exynos: move MIPI phy to PMU node in Exynos5433
      arm64: dts: qcom: sm8450: correct WSA2 assigned clocks
      ...

Kuninori Morimoto (2):
      arm64: dts: renesas: r8a779g0: R-Car Sound support
      arm64: dts: renesas: white-hawk: Add R-Car Sound support

Lad Prabhakar (9):
      arm64: dts: renesas: r9a07g043u: Add Cortex-A55 PMU node
      arm64: dts: renesas: r9a07g044: Add Cortex-A55 PMU node
      arm64: dts: renesas: Drop specifying the GIC_CPU_MASK_SIMPLE() for=
 GICv3 systems
      arm64: dts: renesas: r9a07g054: Add Cortex-A55 PMU node
      arm64: dts: renesas: r9a07g044: Update IRQ numbers for SSI channels
      arm64: dts: renesas: r9a07g054: Update IRQ numbers for SSI channels
      arm64: dts: renesas: r9a07g043: Update IRQ numbers for SSI channels
      arm64: dts: renesas: r9a07g044: Add CSI and CRU nodes
      arm64: dts: renesas: rzg2l-smarc: Enable CRU, CSI support

Lakshmi Yadlapati (1):
      ARM: dts: aspeed: p10bmc: Change power supply info

Laurent Pinchart (1):
      arm64: dts: freescale: imx8mm-phyboard: Add I2C4 pinmuxing

Leonard G=C3=B6hrs (1):
      ARM: dts: stm32: Add coprocessor detach mbox on stm32mp15xx-osd32 =
SoM

Lucas Stach (1):
      arm64: dts: imx8mp-debix: add USB host support

Lucas Tanure (1):
      arm64: dts: rockchip: Add sdmmc node to rk3588

Lux Aliaga (3):
      dt-bindings: arm: qcom: Document xiaomi,laurel-sprout board
      arm64: dts: qcom: sm6125: Add UFS nodes
      arm64: dts: qcom: sm6125: Initial support for xiaomi-laurel-sprout

Manivannan Sadhasivam (54):
      arm64: dts: qcom: sm8150: Fix the iommu mask used for PCIe control=
lers
      arm64: dts: qcom: sc8280xp: Add label property to vadc channel nod=
es
      arm64: dts: qcom: sm8350: Mark UFS controller as cache coherent
      arm64: dts: qcom: sm8450: Mark UFS controller as cache coherent
      arm64: dts: qcom: sm8550: Mark UFS controller as cache coherent
      arm64: dts: qcom: sdm845: Supply clock from cpufreq node to CPUs
      arm64: dts: qcom: sc7280: Supply clock from cpufreq node to CPUs
      arm64: dts: qcom: sm6350: Supply clock from cpufreq node to CPUs
      arm64: dts: qcom: sm8550: Supply clock from cpufreq node to CPUs
      arm64: dts: qcom: sm8250: Supply clock from cpufreq node to CPUs
      arm64: dts: qcom: qdu1000: Supply clock from cpufreq node to CPUs
      arm64: dts: qcom: sc7180: Supply clock from cpufreq node to CPUs
      arm64: dts: qcom: sm8150: Supply clock from cpufreq node to CPUs
      arm64: dts: qcom: sm8350: Supply clock from cpufreq node to CPUs
      arm64: dts: qcom: sc8280xp: Supply clock from cpufreq node to CPUs
      ...

Manoj Sai (1):
      arm64: dts: rockchip: Enable USB OTG for rk3566 Radxa CM3

Mao Jinlong (1):
      arm64: dts: qcom: sm8250: Add tpdm mm/prng

Marcel Ziswiler (5):
      dt-bindings: arm: fsl: add toradex,apalis-imx8 et al.
      arm64: dts: freescale: add initial apalis imx8 aka quadmax module =
support
      arm64: dts: freescale: add apalis imx8 aka quadmax carrier board s=
upport
      arm64: dts: verdin-imx8mp: add pcie support
      arm64: dts: imx8mp-verdin-yavia: trivial minor updates

Marek Vasut (20):
      arm64: dts: imx8mp: Add PCIe support to DH electronics i.MX8M Plus=
 DHCOM and PDK2
      arm64: dts: imx8mp: Update GPIO M to CLKOUT1 on DH electronics i.M=
X8M Plus DHCOM and PDK2
      arm64: dts: imx8mp: Do not delete PHY nodes on i.MX8MP DHCOM PDK2
      arm64: dts: imx8mp: Adjust EQoS reset comment on i.MX8MP DHCOM
      arm64: dts: imx8mp: Adjust EQoS PHY address on i.MX8MP DHCOM
      arm64: dts: imx8mp: Add EQoS RMII pin mux on i.MX8MP DHCOM
      arm64: dts: imx8mp: Add FEC RMII pin mux on i.MX8MP DHCOM
      dt-bindings: soc: imx8mp-media-blk-ctrl: Align block controller ex=
ample name
      dt-bindings: soc: imx8mp-media-blk-ctrl: Add LDB subnode into sche=
ma and example
      arm64: dts: imx8mp: Drop simple-bus from fsl,imx8mp-media-blk-ctrl
      arm64: dts: imx8mp: Reorder clock and reg properties
      dt-bindings: arm: Add DH electronics i.MX8M Plus DHCOM on PDK3
      arm64: dts: imx8mp: Add support for DH electronics i.MX8M Plus DHC=
OM and PDK3
      dt-bindings: soc: imx8m-blk-ctrl: Rename blk_ctrl to blk-ctrl in e=
xamples
      dt-bindings: soc: imx-blk-ctrl: Drop leading label in blk-ctrl in =
examples
      arm64: dts: imx8mm: Add display pipeline components
      ...

Markus Niebel (1):
      arm64: dts: imx93: add missing tpm pwm instances

Martijn Braam (2):
      arm64: dts: rockchip: Add internal display support to rk3399-pinep=
hone-pro
      arm64: dts: rockchip: Add touchscreen support to rk3399-pinephone-=
pro

Martin Blumenstingl (3):
      ARM: dts: meson8: add the xtal_32k_out pin
      ARM: dts: meson8: add the SDXC_A pins
      ARM: dts: meson8m2: mxiii-plus: Enable Bluetooth and WiFi support

Martin Kepplinger (4):
      arm64: dts: imx8mq-librem5: lower the mipi csi 1 frequencies
      arm64: dts: imx8mq-librem5: describe the clock for the csi sensors
      arm64: dts: imx8mq-librem5: fix audio-1v8 regulator name
      arm64: dts: imx8mq-librem5: add brightness levels to led-backlight

Matthias Brugger (1):
      arm64: dts: mt8167: Align mmsys node name with dtschema

Max Krummenacher (1):
      arm64: dts: imx8-ss-dma: add io-channel-cells to adc nodes

Maxim Schwalm (1):
      ARM: tegra30: Use cpu* labels

Maya Matuszczyk (1):
      arm64: dts: rockchip: Add display support to Odroid Go Super

Michael Tretter (1):
      ARM: dts: imx7d: add node for PXP

Michal Vok=C3=A1=C4=8D (7):
      dt-bindings: arm: fsl: Fix copy-paste error in comment
      ARM: dts: imx6dl-yapp4: Use reset-gpios property name
      dt-bindings: arm: fsl: Add Y Soft IOTA=C2=A0Phoenix, Lynx, Pegasus=
 and Pegasus+
      ARM: dts: imx6dl-yapp4: Move phy reset into switch node
      ARM:=C2=A0dts: imx6dl-yapp4: Move status to the end of property li=
st
      ARM: dts: imx6dl-yapp4: Remove unneeded status "okay"
      ARM: dts: imx6dl-yapp43: Add support for new HW revision of the IO=
TA=C2=A0board

Moudy Ho (1):
      arm64: dts: mediatek: mt8195: add MUTEX configuration for VPPSYS

Mukesh Ojha (1):
      arm64: dts: qcom: sm8450: Add IMEM and PIL info region

Nam Nguyen (1):
      arm64: dts: renesas: v3hsk: Add clock-skew for GEther's Micrel PHY

Nancy.Lin (1):
      arm64: dts: mt8195: add display node for vdosys1

Neil Armstrong (28):
      arm64: dts: amlogic: meson-sm1-bananapi: correct usb-hub hog node =
name
      arm64: dts: amlogic: meson-gxm-s912-libretech-pc: add simple conne=
ctor node in fusb302 node
      arm64: dts: amlogic: meson-axg-jethome-jethub-j1xx: remove invalid=
 #gpio-cells in onewire node
      arm64: dts: amlogic: meson-g12b-radxa-zero2: fix pwm clock names
      arm64: dts: amlogic: meson-g12b-odroid-go-ultra: rename keypad-gpi=
o pinctrl node
      arm64: dts: amlogic: meson-s4: fix apb4 bus node name
      arm64: dts: amlogic: meson-sm1: use correct enable-gpios
      arm64: dts: amlogic: meson-gxm-s912-libretech-pc: remove unused pi=
nctrl-names from phy node
      dt-bindings: arm: amlogic: Document the boards with the BPI-CM4 co=
nnected
      arm64: dts: amlogic: Add initial support for BPI-CM4 module with B=
PI-CM4IO baseboard
      arm64: dts: qcom: pm8550b: Add eUSB2 repeater node
      arm64: dts: qcom: sm8550: fix qup_spi0_cs node
      arm64: dts: qcom: sm8550: misc style fixes
      arm64: dts: qcom: sm8350: add port subnodes in dwc3 node
      arm64: dts: qcom: sm8450: add port subnodes in dwc3 node
      ...

Niklas S=C3=B6derlund (3):
      arm64: dts: renesas: r8a779g0: Add and connect all CSI-2, ISP and =
VIN nodes
      arm64: dts: renesas: white-hawk-csi-dsi: Add and connect MAX96712
      arm64: dts: renesas: falcon-csi-dsi: Set bus-type for MAX96712

Nishanth Menon (4):
      dt-bindings: net: ti: k3-am654-cpsw-nuss: Drop pinmux header
      arm64: dts: ti: Use local header for pinctrl register values
      dt-bindings: pinctrl: k3: Deprecate header with register constants
      arm64: dts: ti: k3-am62-wakeup: Introduce RTC node

Nitin Yadav (1):
      arm64: dts: ti: k3-am62-main: Fix GPIO numbers in DT

N=C3=ADcolas F. R. A. Prado (1):
      arm64: dts: mediatek: mt8192-asurada: Add MFG0 domain supply

Oleksij Rempel (12):
      ARM: dts: imx6qdl: use enet_clk_ref instead of enet_out for the FE=
C node
      ARM: dts: imx6dl-lanmcu: configure ethernet reference clock parent
      ARM: dts: imx6dl-alti6p: configure ethernet reference clock parent
      ARM: dts: imx6dl-plybas: configure ethernet reference clock parent
      ARM: dts: imx6dl-plym2m: configure ethernet reference clock parent
      ARM: dts: imx6dl-prtmvt: configure ethernet reference clock parent
      ARM: dts: imx6dl-victgo: configure ethernet reference clock parent
      ARM: dts: imx6q-prtwd2: configure ethernet reference clock parent
      ARM: dts: imx6qdl-skov-cpu: configure ethernet reference clock par=
ent
      ARM: dts: imx6dl-eckelmann-ci4x10: configure ethernet reference cl=
ock parent
      ARM: dts: imx6ul: set enet_clk_ref to CLK_ENETx_REF_SEL
      ARM: dts: imx6ul-prti6g: configure ethernet reference clock parent

Ondrej Jirman (1):
      arm64: dts: rockchip: Add support for volume keys to rk3399-pineph=
one-pro

Patrice Chotard (1):
      ARM: dts: stm32: Add QSPI support on STM32MP13x SoC family

Peng Fan (11):
      arm64: dts: imx8mq: tqma8mq-mba8mx: drop disable-over-current
      arm64: dts: imx8mp: verdin-yavia: drop disable-over-current
      arm64: dts: imx8dxl: drop clocks from scu clock controller
      arm64: dts: imx8-apalis-v1.1: drop ci-disable-lpm
      arm64: dts: imx8mn-evk: update i2c pinctrl to match dtschema
      arm64: dts: imx8mm-ddr4-evk: update gpmi pinctrl to match dtschema
      arm64: dts: imx8mq-librem5: update pinctrl to match dtschema
      arm64: dts: imx8mm-emcon: update pinctrl to match dtschema
      arm64: dts: imx8mn-bsh-smm: update pinctrl to match dtschema
      arm64: dts: imx8mm-prt8mm: update pinctrl to match dtschema
      arm64: dts: imx8mq-librem5: add missing #clock-cells

Petr Vorel (2):
      arm64: dts: qcom: msm8994-angler: Fix cont_splash_mem mapping
      arm64: dts: qcom: msm8994-angler: removed clash with smem_region

Philippe Schenker (25):
      arm64: dts: freescale: imx8-ss-lsio: add support for lsio_pwm0-3
      arm64: dts: freescale: imx8-ss-dma: set lpspi0 max frequency to 60=
mhz
      dt-bindings: arm: fsl: Add colibri-imx8x carrier boards
      arm64: dts: colibri-imx8x: Prepare for qxp and dx variants
      arm64: dts: colibri-imx8x: Update spdx license
      arm64: dts: colibri-imx8x: Use new bracket format
      arm64: dts: colibri-imx8x: Add atmel pinctrl groups
      arm64: dts: colibri-imx8x: Add pinctrl group for csi_mclk
      arm64: dts: colibri-imx8x: Split pinctrl_hog1
      arm64: dts: colibri-imx8x: Correct pull on lcdif
      arm64: dts: colibri-imx8x: Add separate pinctrl group for cs2
      arm64: dts: colibri-imx8x: Add pinctrl group for hdmi hpd
      arm64: dts: colibri-imx8x: Add SPI
      arm64: dts: colibri-imx8x: Add gpio-line-names
      arm64: dts: colibri-imx8x: Disable touchscreen by default
      ...

Pierre-Yves MORDRET (3):
      ARM: dts: stm32: YAML validation fails for STM32MP15 ST Boards
      ARM: dts: stm32: YAML validation fails for Odyssey Boards
      ARM: dts: stm32: YAML validation fails for Argon Boards

Rafa=C5=82 Mi=C5=82ecki (6):
      arm64: dts: broadcom: bcmbca: bcm4908: fix NAND interrupt name
      arm64: dts: broadcom: bcmbca: bcm4908: fix LED nodenames
      arm64: dts: broadcom: bcmbca: bcm4908: fix procmon nodename
      arm64: dts: broadcom: bcmbca: bcm4908: add on-SoC USB ports
      arm64: dts: broadcom: bcmbca: bcm4908: add Netgear R8000P USB LED =
triggers
      arm64: dts: broadcom: bcmbca: bcm4908: add TP-Link C2300 USB LED t=
riggers

Rayyan Ansari (2):
      ARM: dts: qcom: msm8226: add clocks and clock-names to GCC node
      ARM: dts: qcom: msm8974: add correct XO clock source to GCC node

Richard Acayan (1):
      arm64: dts: qcom: sdm670: add opps for peripherals

Richard Zhu (3):
      arm64: dts: Add i.MX8MM PCIe EP support
      arm64: dts: Add i.MX8MQ PCIe EP support
      arm64: dts: Add i.MX8MP PCIe EP support

Roan van Dijk (2):
      ARM: stm32: add support for STM32MP151
      ARM: stm32: add initial documentation for STM32MP151

Rob Herring (5):
      arm64: dts: layerscape: Fix GICv3 ITS node names
      arm64: dts: marvell: armada-ap810: Fix GICv3 ITS node name
      arm64: dts: broadcom: stringray: Fix GICv3 ITS node name
      arm64: dts: cavium: Fix GICv3 ITS nodes
      dt-bindings: arm: nvidia: Drop unneeded quotes

Robert Marko (7):
      ARM: dts: qcom: ipq4018-ap120c-ac: setup serial console
      ARM: dts: qcom: ipq4018-ap120c-ac: align GPIO hog with DT schema
      ARM: dts: qcom: ipq4018-ap120c-ac: align SPI-NAND with DT schema
      ARM: dts: qcom: ipq4018-ap120c-ac: use NVMEM for ath10k caldata
      ARM: dts: qcom: ipq4019: pass XO and sleep clocks to GCC
      ARM: dts: qcom: ipq4019: remove clk-output-names for sleep clock
      arm64: dts: marvell: mochabin: enlarge PCI memory window

Robert Nelson (2):
      dt-bindings: arm: ti: Add BeaglePlay
      arm64: dts: ti: Add k3-am625-beagleplay

Roy-CW.Yeh (1):
      arm64: dts: mediatek: mt8195: add MMSYS configuration for VPPSYS

Sam Protsenko (3):
      dt-bindings: clock: exynos850: Add Exynos850 CMU_G3D
      dt-bindings: clock: exynos850: Add AUD and HSI main gate clocks
      arm64: dts: exynos: Add CMU_G3D node for Exynos850 SoC

Sameer Pujar (1):
      arm64: tegra: Audio codec support on Jetson AGX Orin

Samuel Holland (1):
      riscv: dts: allwinner: d1: Add crypto engine node

Sasha Finkelstein (3):
      arm64: dts: apple: t8103: Add PWM controller
      arm64: dts: apple: t600x: Add PWM controller
      arm64: dts: apple: t8112: Add PWM controller

Sebastian Krzyszkowiak (10):
      arm64: dts: imx8mq: Add UART DMA support
      arm64: dts: imx8mq-librem5: Describe MIC_2V4 regulator
      arm64: dts: imx8mq-librem5: Set charger parameters for each batch
      arm64: dts: imx8mq-librem5: Set the DVS voltages lower
      arm64: dts: imx8mq-librem5: Bump usdhc2 frequency to 100MHz
      arm64: dts: imx8mq-librem5: Adjust proximity sensor's near levels
      arm64: dts: imx8mq-librem5: Remove dis_u3_susphy_quirk from usb_dw=
c3_0
      arm64: dts: imx8mq-librem5: Bump BUCK1 suspend voltage to 0.81V
      arm64: dts: imx8mq-librem5: Reduce I2C frequency to 384kHz
      arm64: dts: imx8mq-librem5: Add 166MHz to DDRC OPP table

Sebastian Reichel (1):
      arm64: dts: rockchip: add rk3588 thermal sensor

Shreeya Patel (3):
      arm64: dts: rockchip: Enable watchdog support for RK3588
      dt-bindings: watchdog: rockchip: Add rockchip,rk3588-wdt string
      arm64: dts: rockchip: Enable RTC support for Rock 5B

Siddharth Vadapalli (5):
      arm64: dts: ti: k3-j784s4-evm: Enable MCU CPSW2G
      arm64: dts: ti: k3-j721e: Add CPSW9G nodes
      arm64: dts: ti: k3-j721e: Add overlay to enable CPSW9G ports in QS=
GMII mode
      arm64: dts: ti: j7200-main: Add CPSW5G nodes
      arm64: dts: ti: k3-j7200: Add overlay to enable CPSW5G ports in QS=
GMII mode

Sinthu Raja (1):
      arm64: dts: ti: k3-am68-sk-base-board: Update IO EXP GPIO lines fo=
r Rev E2

Srinivas Kandagatla (4):
      arm64: dts: qcom: sc8280xp: fix rx frame shapping info
      arm64: dts: qcom: sc8280xp: fix lpass tx macro clocks
      arm64: dts: qcom: sc8280xp-x13s: fix dmic sample rate
      arm64: dts: qcom: sc8280xp-x13s: fix va dmic dai links and routing

Steev Klimaszewski (1):
      arm64: dts: qcom: sc8280xp-x13s: Add bluetooth

Stefan Eichenberger (1):
      arm64: dts: imx8mp-verdin: add 88W8997 serdev to uart4

Stefan Wahren (12):
      ARM: dts: imx28-apf28: Convert to use label references
      ARM: dts: imx28-m28/sps1: Convert to use label references
      ARM: dts: imx28-apx4devkit: Convert to use label references
      ARM: dts: imx28-cfa10036: Convert to use label references
      ARM: dts: imx28-duckbill: Convert to use label references
      ARM: dts: imx28-duckbill-2: Include base board
      ARM: dts: imx28-evk: Convert to use label references
      ARM: dts: imx28-ts4600: Convert to use label references
      ARM: dts: imx28-tx28: add SPDX-License-Identifier
      ARM: dts: imx6ull: Add chargebyte Tarragon support
      dt-bindings: vendor-prefixes: add chargebyte
      dt-bindings: arm: fsl: Add chargebyte Tarragon

Steffen Hemer (8):
      ARM: dts: am335x-phycore-som: Add alias for TPS65910 RTC
      ARM: dts: am335x-wega: Fix audio codec by using simple-audio-card =
driver.
      ARM: dts: am335x-wega: Change node name of sound card, remove unde=
rscores.
      ARM: dts: am335x-pcm-935: Remove underscore in node names.
      ARM: dts: am335x-regor: Remove underscore in node names.
      ARM: dts: am335x-phycore-som: Remove underscore in node names.
      ARM: dts: am335x-pcm-953: Remove superseded/invalid LED trigger.
      ARM: dts: am335x-phycore-som: Remove superseded/invalid GPMC NAND =
type.

Stephan Gerhold (2):
      arm64: dts: qcom: msm8916: Fix tsens_mode unit address
      arm64: dts: qcom: msm8916: Move WCN compatible to boards

Svyatoslav Ryhel (4):
      ARM: tegra: transformers: Update WM8903 sound nodes
      ARM: tegra: transformers: Bind RT5631 sound nodes
      ARM: tegra: asus-tf101: Fix accelerometer mount matrix
      ARM: tegra30: peripherals: Add 266.5MHz nodes

Thierry Reding (4):
      dt-bindings: tegra: Document Jetson Orin NX
      dt-bindings: tegra: Document Jetson Orin NX reference platform
      arm64: tegra: Support Jetson Orin NX
      arm64: tegra: Support Jetson Orin NX reference platform

Tianling Shen (9):
      arm64: dts: rockchip: create common dtsi for NanoPi R5 series
      dt-bindings: Add doc for FriendlyARM NanoPi R5C
      arm64: dts: rockchip: Add FriendlyARM NanoPi R5C
      arm64: dts: rockchip: fix gmac support for NanoPi R5S
      arm64: dts: rockchip: remove I2S1 TDM node for the NanoPi R5 series
      dt-bindings: Add doc for FriendlyARM NanoPi R2C
      arm64: dts: rockchip: Add FriendlyARM NanoPi R2C
      dt-bindings: Add doc for Xunlong OrangePi R1 Plus LTS
      arm64: dts: rockchip: Add Xunlong OrangePi R1 Plus LTS

Trevor Woerner (1):
      riscv: dts: nezha-d1: add gpio-line-names

Tudor Ambarus (4):
      ARM: dts: at91-sama5d27_wlsom1: Set sst26vf064b SPI NOR flash at i=
ts maximum frequency
      ARM: dts: at91-sama5d27_som1: Set sst26vf064b SPI NOR flash at its=
 maximum frequency
      ARM: dts: at91: sama5d2_icp: Set sst26vf064b SPI NOR flash at its =
maximum frequency
      ARM: dts: at91: sam9x60ek: Set sst26vf064b SPI NOR flash at its ma=
ximum frequency

Uwe Kleine-K=C3=B6nig (1):
      arm64: dts: imx8mp: Add GPT blocks

Vaishnav Achath (4):
      arm64: dts: ti: k3-j721e: Add MCSPI nodes
      arm64: dts: ti: k3-j7200: Add MCSPI nodes
      arm64: dts: ti: k3-j721s2: Add MCSPI nodes
      arm64: dts: ti: k3-j784s4: Add MCSPI nodes

Valentin Caron (6):
      ARM: dts: stm32: fix slew-rate of USART2 on stm32mp15xx-dkx
      ARM: dts: stm32: clean uart aliases on stm32mp15xx-dkx boards
      ARM: dts: stm32: clean uart aliases on stm32mp15xx-exx boards
      ARM: dts: stm32: add uart nodes on stm32mp13
      ARM: dts: stm32: add pins for usart2/1/4/8 in stm32mp13-pinctrl
      ARM: dts: stm32: add uart nodes and uart aliases on stm32mp135f-dk

Vasily Khoruzhick (2):
      dt-bindings: Add doc for FriendlyARM NanoPi R5S
      arm64: dts: rockchip: Add FriendlyElec Nanopi R5S

Vignesh Raghavendra (3):
      arm64: dts: ti: k3-am625: Correct L2 cache size to 512KB
      arm64: dts: ti: k3-am62a7: Correct L2 cache size to 512KB
      dt-bindings: arm: ti: k3: Add compatible for AM62x LP SK

Vincent Guittot (1):
      arm64: dts: qcom: sdm845: correct dynamic power coefficients

William Zhang (2):
      arm64: dts: broadcom: bcmbca: Add spi controller node
      ARM: dts: broadcom: bcmbca: Add spi controller node

Wolfram Sang (3):
      arm64: dts: renesas: r8a779f0: Use proper labels for thermal zones
      arm64: dts: renesas: Remove R-Car H3 ES1.* devicetrees
      dt-bindings: soc: renesas: Remove R-Car H3 ES1.*

Xiangsheng Hou (2):
      arm64: dts: mediatek: Fix existing NAND controller node name
      arm: dts: mediatek: Fix existing NAND controller node name

Yang Xiwen (4):
      arm64: dts: qcom: msm8916-ufi: Fix sim card selection pinctrl
      dt-bindings: vendor-prefixes: Add Henan Yiming Technology Co., Ltd.
      dt-bindings: arm: qcom: Add Yiming LTE dongle uz801-v3.0 (yiming-u=
z801v3)
      arm64: dts: qcom: msm8916-yiming-uz801v3: Add initial device tree

Yixun Lan (2):
      dt-bindings: arm: rockchip: Add Khadas Edge2 board
      arm64: dts: rockchip: Add Khadas edge2 board

Yoshihiro Shimoda (4):
      arm64: dts: renesas: r8a779f0: Revise renesas,ipmmu-main
      arm64: dts: renesas: r8a779g0: Add IPMMU nodes
      arm64: dts: renesas: r8a779g0: Add iommus to DMAC nodes
      arm64: dts: renesas: r8a779g0: Add iommus to MMC node

Zev Weiss (3):
      ARM: dts: aspeed: romed8hm3: Fix GPIO polarity of system-fault LED
      ARM: dts: aspeed: e3c246d4i: Add PECI device
      ARM: dts: aspeed: asrock: Correct firmware flash SPI clocks

Zhou Peng (1):
      arm64: dts: imx8qm: add vpu decoder and encoder


   0.0% Documentation/arm/stm32/
   0.0% Documentation/arm/
   0.0% Documentation/devicetree/bindings/arm/apple/
   0.1% Documentation/devicetree/bindings/arm/tegra/
   0.0% Documentation/devicetree/bindings/arm/ti/
   0.5% Documentation/devicetree/bindings/arm/
   1.1% Documentation/devicetree/bindings/clock/
   0.0% Documentation/devicetree/bindings/gpu/host1x/
   0.0% Documentation/devicetree/bindings/i2c/
   0.0% Documentation/devicetree/bindings/interrupt-controller/
   0.0% Documentation/devicetree/bindings/iommu/
   0.0% Documentation/devicetree/bindings/mailbox/
   0.0% Documentation/devicetree/bindings/net/
   0.0% Documentation/devicetree/bindings/nvme/
   0.0% Documentation/devicetree/bindings/pci/
   0.0% Documentation/devicetree/bindings/pinctrl/
   0.0% Documentation/devicetree/bindings/power/
   0.0% Documentation/devicetree/bindings/riscv/
   0.1% Documentation/devicetree/bindings/soc/imx/
   0.0% Documentation/devicetree/bindings/soc/renesas/
   0.0% Documentation/devicetree/bindings/soc/samsung/
   0.0% Documentation/devicetree/bindings/timer/
   0.0% Documentation/devicetree/bindings/watchdog/
   0.0% Documentation/devicetree/bindings/
  21.2% arch/arm/boot/dts/
   0.0% arch/arm/mach-stm32/
   0.0% arch/arm64/boot/dts/allwinner/
   2.1% arch/arm64/boot/dts/amlogic/
   5.2% arch/arm64/boot/dts/apple/
   0.4% arch/arm64/boot/dts/broadcom/bcmbca/
   0.0% arch/arm64/boot/dts/broadcom/stingray/
   0.0% arch/arm64/boot/dts/cavium/
   0.0% arch/arm64/boot/dts/exynos/
  14.7% arch/arm64/boot/dts/freescale/
   0.3% arch/arm64/boot/dts/marvell/
   5.0% arch/arm64/boot/dts/mediatek/
   1.3% arch/arm64/boot/dts/nvidia/
  23.8% arch/arm64/boot/dts/qcom/
   5.0% arch/arm64/boot/dts/renesas/
   3.1% arch/arm64/boot/dts/rockchip/
   1.8% arch/arm64/boot/dts/sprd/
   6.7% arch/arm64/boot/dts/ti/
   0.0% arch/arm64/boot/dts/toshiba/
   0.2% arch/riscv/boot/dts/allwinner/
   0.0% arch/riscv/boot/dts/microchip/
   2.3% arch/riscv/boot/dts/starfive/
   0.1% drivers/pinctrl/qcom/
   2.7% include/dt-bindings/clock/
   0.0% include/dt-bindings/firmware/
   0.0% include/dt-bindings/pinctrl/
   0.9% include/dt-bindings/reset/
   0.0% scripts/dtc/include-prefixes/
