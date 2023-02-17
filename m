Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 516F569B1C1
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 18:28:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjBQR2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 12:28:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBQR2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 12:28:46 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 173556C008
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 09:28:41 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 82EF15C00D6;
        Fri, 17 Feb 2023 12:28:40 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Fri, 17 Feb 2023 12:28:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1676654920; x=
        1676741320; bh=c8ybVSCEPRvsTmab9f3N1ogOZENL8l27dM2A7GnC420=; b=q
        vTolhbgcBrXrGIc9+ZdjbvSBkigJWKuCp0O83kk+Wula92OLSDUYQcNkFXGa5xq5
        glR3KCQRqIl2yY/WWiFMtAGBjmc/pCkRbNrtX3fyZaj8jLAubLbeJdHDNh3r9pxJ
        hmr0cTNfr20zhPJqb5ZaB4TD424FnxPPLZuWuyXNX+So7xjR+DyfElETnJjJXqCH
        I2w38/mC0l/vXDbiMeZjfGFWwFU9Rd06ItvyApR1bZlqxJQUj9noQ2LMPNo1b7EZ
        X8RpQ2MDWyvAT34smkMwixA6VqzSk/t2H81HzUQYfjsAuDrqHfyS/WDa1jdy9DJm
        //nC4NDQAOsLeJuvB12Uw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1676654920; x=
        1676741320; bh=c8ybVSCEPRvsTmab9f3N1ogOZENL8l27dM2A7GnC420=; b=f
        TzsxsGAdFbJz3j9TUJl/eDK8/ZMHby7rI1RQ531PRfDVW2MuEqY4wDVkz8a7MMw7
        T93d3WmiGHG2aNssnYHlc6k58EcjMl+OGNZ5CuV/1l4QAByYnnlAEwhhF1ZJEQkU
        +ER4MJLFWQrMCnDslwBpStDKVAcDjO1k5ZBWRIIhj020JtI8sy32SSyrI8vJWRSx
        8xe3jbhccqiwqcxbEJ4p69SHJ9z+Y6CnqT6PDmARWHW+qV+/wDU1KFRdsBmp5Bfn
        sU95gMtpni3A8ojVMLN/HwFSXSFppL9UHEf/Wb0TYvYz6hl+5mrboARKcKXroKGv
        H817e4yj7aHjsBLcv/YWA==
X-ME-Sender: <xms:SLnvYzrh8tEm1sE3NdCP2Ci65HALLW9u6G_L_Pghkvn-JOtwbA-HZw>
    <xme:SLnvY9odMtDYQ1HCLm6z4N8IoCC1nwNaTLl6Ab8UZrGw6WKCL60qH_SJ2cNafotq_
    8wUqQuiQwQ3W8w7yVg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudeiledgleejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpefgkefhheetvdethfejkeeigfehtdffieevfeefteffteejffehlefhtdeu
    veejueenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhgihhthhhusgdrtghomhenuc
    evlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnuges
    rghrnhgusgdruggv
X-ME-Proxy: <xmx:SLnvYwPqgDQJL4myRru87uUzxM0zZudKDmRpZ0bgBHBeKCe4-OW78g>
    <xmx:SLnvY27Bycacd1PfZ0aE742jjxi6t-g6VGeeDERLBVG9ThcBjZvaug>
    <xmx:SLnvYy70W9k11LtoGbzrSlpNsCd-VppkxTOLF0FgBFcdMPxyRl6jWA>
    <xmx:SLnvY4RMYlF6Djv2UQmpduOkcbNVRvtyCNLesI28a-bnPQmKSJs2zA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 360D2B60086; Fri, 17 Feb 2023 12:28:40 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-156-g081acc5ed5-fm-20230206.001-g081acc5e
Mime-Version: 1.0
Message-Id: <4f42519a-d087-416a-b7d6-aa9f63d2c395@app.fastmail.com>
In-Reply-To: <99179367-0d59-4938-b44c-ca9408ad784e@app.fastmail.com>
References: <99179367-0d59-4938-b44c-ca9408ad784e@app.fastmail.com>
Date:   Fri, 17 Feb 2023 18:28:19 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Linus Torvalds" <torvalds@linux-foundation.org>
Cc:     soc@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL 4/4] SoC: DT changes for 6.3
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 175281f80695569c7f9cf062e5d0ddc4addc1=
09f:

  ARM: dts: stm32: Fix qspi pinctrl phandle for stm32mp151a-prtt1l (2023=
-01-17 14:48:44 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-d=
t-6.3

for you to fetch changes up to e43efb6d713bca3855909a2f9caec280a2b0a503:

  dt-bindings: riscv: correct starfive visionfive 2 compatibles (2023-02=
-16 22:08:25 +0100)

----------------------------------------------------------------
SoC: DT changes for 6.3

About a quarter of the changes are for 32-bit arm, mostly filling in
device support for existing machines and adding minor cleanups, mostly
for Qualcomm and Samsung based machines.

Two new 32-bit SoCs are added, both are quad-core Cortex-A7 chips from
Rockchips that have been around for a while but were lacking kernel
support so far: RV1126 is a Vision SoC with an NPU and is used in the
Edgeble Neural Compute Module 2(Neu2) board, while RK3128 is design for
TV boxes and so far only comes with a dts for its refernece design.

The other 32-bit boards that were added are two ASpeed AST2600 based BMC
boards, the Microchip sam9x60_curiosity development board (Armv5 based!),
the Enclustra PE1 FPGA-SoM baseboard, and a few more boards for i.MX53
and i.MX6ULL.

On the RISC-V side, there are fewer patches, but a total of ten new
single-board computers based on variations of the Allwinner D1/T113 chip,
plus one more board based on Microchip Polarfire.

As usual, arm64 has by far the most changes here, with over 700 non-merge
changesets, among them over 400 alone for Qualcomm. The newly added SoCs
this time are all recent high-end embedded SoCs for various markets,
each on comes with support for its reference board:

 - Qualcomm SM8550 (Snapdragon 8 Gen 2) for mobile phones
 - Qualcomm QDU1000/QRU1000 5G RAN platform
 - Rockchips RK3588/RK3588s for tablets, chromebooks and SBCs
 - TI J784S4 for industrial and automotive applications

In total, there are 46 new arm64 machines:
 - Reference platforms for each of the five new SoCs
 - Three Amlogic based development boards
 - Six embedded machines based on NXP i.MX8MM and i.MX8MP
 - The Mediatek mt7986a based Banana Pi R3 router
 - Six tablets based on Qualcomm MSM8916 (Snapdragon 410),
   SM6115 (Snapdragon 662) and SM8250 (Snapdragon 865)
 - Two LTE dongles, also based on MSM8916
 - Seven mobile phones, based on Qualcomm MSM8953 (Snapdragon 610),
   SDM450 and SDM632
 - Three chromebooks based on Qualcomm SC7280 (Snapdragon 7c)
 - Nine development boards based on Rockchips RK3588, RK3568,
   RK3566 and RK3328.
 - Five development machines based on TI K3 (AM642/AM654/AM68/AM69)

The cleanup of dtc warnings continues across all platforms, adding
to the total number of changes.

----------------------------------------------------------------
Abel Vesa (14):
      dt-bindings: interconnect: Add Qualcomm SM8550
      interconnect: qcom: Add SM8550 interconnect provider driver
      dt-bindings: arm: qcom: Document SM8550 SoC and boards
      dt-bindings: clock: Add SM8550 TCSR CC clocks
      arm64: dts: qcom: Add base SM8550 dtsi
      arm64: dts: qcom: Add base SM8550 MTP dts
      arm64: dts: qcom: sm8550: Add UFS host controller and phy nodes
      arm64: dts: qcom: sm8550-mtp: Add UFS host controller and PHY node
      arm64: dts: qcom: sm8550: Add interconnect path to SCM node
      arm64: dts: qcom: sm8550: Add PCIe PHYs and controllers nodes
      arm64: dts: qcom: sm8550-mtp: Add PCIe PHYs and controllers nodes
      arm64: dts: qcom: sm8550: Add USB PHYs and controller nodes
      arm64: dts: qcom: sm8550-mtp: Add USB PHYs and HC nodes
      arm64: dts: qcom: sm8550: Fix the aoss_qmp node name

Adam Ford (8):
      arm64: dts: imx8mp: Enable spba-bus on AIPS3
      arm64: boot: dts: r8a774[a/b/e]1-beacon: Consolidate sound clocks
      dt-bindings: arm: Add Beacon EmbeddedWorks i.MX8M Plus kit
      arm64: dts: freescale: Introduce imx8mp-beacon-kit
      arm64: dts: renesas: beacon-renesom: Fix gpio expander reference
      arm64: dts: renesas: beacon-renesom: Update Ethernet PHY ID
      arm64: dts: renesas: beacon-renesom: Fix audio clock rate
      arm64: dts: renesas: r8a774[be]1-beacon: Sync aliases with RZ/G2M

Adam Skladowski (1):
      arm64: dts: qcom: msm8953: Add device tree for Xiaomi Redmi Note 4X

Alejandro Tafalla (1):
      arm64: dts: qcom: msm8953: Add device tree for Xiaomi Mi A2 Lite

Alex Elder (3):
      arm64: dts: qcom: sc7280: only enable IPA for boards with a modem
      ARM: dts: qcom: use qcom,gsi-loader for IPA
      arm64: dts: qcom: use qcom,gsi-loader for IPA

Alex Riabchenko (1):
      arm64: dts: rockchip: Add IR receiver to BPI-R2Pro

Alexander Stein (5):
      ARM: dts: tqma6ul + mba6ulx: Fix temperature sensor compatible
      arm64: dts: tqma8m*: Fix temperature sensor compatible
      arm64: dts: imx8mp: Add LCDIF2 & LDB nodes
      arm64: dts: freescale: Add LVDS overlay for TQMa8MPxL
      ARM: dts: ls1021a: Disable CAN nodes by default

Alexandre Mergnat (2):
      arm64: dts: mt6358: change node names
      arm64: dts: mt8173: change node name

Ali El-Haj-Mahmoud (1):
      arm: dts: aspeed: tyan s8036: Enable kcs interrupts

Allen-KH Cheng (9):
      arm64: dts: mt8186: Add power domains controller
      arm64: dts: mt8186: Add IOMMU and SMI nodes
      arm64: dts: mt8186: Add dsi node
      arm64: dts: mediatek: mt8186: Add crypto support for eMMC controll=
er
      arm64: dts: mediatek: mt8186: Add ADSP mailbox nodes
      arm64: dts: mediatek: mt8186: Add audio controller node
      arm64: dts: mediatek: mt8186: Add DPI node
      arm64: dts: mediatek: mt7986: Fix watchdog compatible
      arm64: dts: mediatek: mt8516: Fix the watchdog node name

Amelie Delaunay (1):
      ARM: dts: stm32: Fix User button on stm32mp135f-dk

Amit Pundir (1):
      arm64: dts: qcom: sdm845-xiaomi-beryllium: Add reserved memory reg=
ion

Anand Moon (3):
      ARM: dts: rockchip: Add ethernet rgmiim1 pin-control for rv1126
      ARM: dts: rockchip: Add Ethernet GMAC node for RV1126
      ARM: dts: rockchip: Enable Ethernet on rv1126 Neu2-IO

Andre Przywara (1):
      ARM: dts: sun8i: a83t: bananapi-m3: describe SATA disk regulator

Andreas Kemnade (3):
      ARM: dts: omap: gta04: add BNO055 IMU chip
      ARM: dts: omap: gta04a5: cleanup i2c node names
      ARM: dts: imx: e70k02: Add touchscreen

Andrew Davis (1):
      arm64: dts: xilinx: Rename DTB overlay source files from .dts to .=
dtso

Andrew Halaney (2):
      arm64: dts: qcom: sa8540p-ride: Fix some i2c pinctrl settings
      arm64: dts: qcom: sa8540p-ride: Document i2c busses

Andy Yan (3):
      dt-bindings: arm: rockchip: Add EmbedFire LubanCat 2
      arm64: dts: rockchip: Add dts for EmbedFire rk3568 LubanCat 2
      arm64: dts: rockchip: Enable wifi module AP6398s for rk3566 box de=
mo

AngeloGioacchino Del Regno (23):
      arm64: dts: qcom: sm6125: Add IOMMU context to DWC3
      arm64: dts: mediatek: mt8195: Use P1 clocks for PCIe1 controller
      arm64: dts: mediatek: mt8195: Add power domain to U3PHY1 T-PHY
      arm64: dts: mt8195: Add complete CPU caches information
      arm64: dts: mt8192: Add complete CPU caches information
      arm64: dts: mt8186: Add complete CPU caches information
      arm64: dts: mt8183: Add complete CPU caches information
      arm64: dts: mt6795: Add complete CPU caches information
      arm64: dts: mediatek: cherry: Add Audio Front End (AFE) support
      arm64: dts: mediatek: cherry: Enable the Audio DSP for SOF
      arm64: dts: mediatek: cherry: Add external codecs and speaker ampl=
ifier
      arm64: dts: mediatek: cherry: Add sound card configuration
      arm: dts: mt7629: Remove extra interrupt from timer node
      arm64: dts: mediatek: mt8173-elm: Move display to ps8640 auxiliary=
 bus
      arm64: dts: mt8195: Fix CPU map for single-cluster SoC
      arm64: dts: mt8192: Fix CPU map for single-cluster SoC
      arm64: dts: mt8186: Fix CPU map for single-cluster SoC
      arm64: dts: mt8195: Change idle states names to reflect actual fun=
ction
      arm64: dts: mt8186: Change idle states names to reflect actual fun=
ction
      arm64: dts: mt8192: Change idle states names to reflect actual fun=
ction
      arm64: dts: mediatek: mt7622: Add missing pwm-cells to pwm node
      arm64: dts: mediatek: mt8186: Fix watchdog compatible
      arm64: dts: mediatek: mt8195: Fix watchdog compatible

Apurva Nandan (4):
      dt-bindings: arm: ti: Add bindings for J784s4 SoC
      dt-bindings: pinctrl: k3: Introduce pinmux definitions for J784s4
      arm64: dts: ti: Add initial support for J784S4 SoC
      arm64: dts: ti: Add support for J784S4 EVM board

Arnd Bergmann (47):
      Merge tag 'renesas-dts-for-v6.3-tag1' of git://git.kernel.org/pub/=
scm/linux/kernel/git/geert/renesas-devel into arm/dt
      Merge tag 'at91-dt-6.3' of https://git.kernel.org/pub/scm/linux/ke=
rnel/git/at91/linux into arm/dt
      Merge tag 'dt64-cleanup-6.3' of https://git.kernel.org/pub/scm/lin=
ux/kernel/git/krzk/linux-dt into arm/dt
      Merge tag 'samsung-dt64-6.3' of https://git.kernel.org/pub/scm/lin=
ux/kernel/git/krzk/linux into arm/dt
      Merge tag 'omap-for-v6.3/dt-signed' of git://git.kernel.org/pub/sc=
m/linux/kernel/git/tmlind/linux-omap into arm/dt
      Merge tag 'samsung-drivers-6.3' of https://git.kernel.org/pub/scm/=
linux/kernel/git/krzk/linux into arm/dt
      Merge tag 'gemini-dts-v6.3' of git://git.kernel.org/pub/scm/linux/=
kernel/git/linusw/linux-nomadik into arm/dt
      Merge tag 'dt-cleanup-6.3' of https://git.kernel.org/pub/scm/linux=
/kernel/git/krzk/linux-dt into arm/dt
      Merge tag 'ux500-dts-v6.3' of git://git.kernel.org/pub/scm/linux/k=
ernel/git/linusw/linux-nomadik into arm/dt
      Merge tag 'qcom-dts-for-6.3' of https://git.kernel.org/pub/scm/lin=
ux/kernel/git/qcom/linux into arm/dt
      Merge tag 'riscv-dt-for-v6.3-mw0' of https://git.kernel.org/pub/sc=
m/linux/kernel/git/conor/linux into arm/dt
      Merge tag 'qcom-arm64-for-6.3' of https://git.kernel.org/pub/scm/l=
inux/kernel/git/qcom/linux into arm/dt
      Merge tag 'renesas-dt-bindings-for-v6.3-tag1' of git://git.kernel.=
org/pub/scm/linux/kernel/git/geert/renesas-devel into arm/dt
      Merge tag 'renesas-dts-for-v6.3-tag2' of git://git.kernel.org/pub/=
scm/linux/kernel/git/geert/renesas-devel into arm/dt
      Merge tag 'tegra-for-6.3-dt-bindings' of git://git.kernel.org/pub/=
scm/linux/kernel/git/tegra/linux into arm/dt
      Merge tag 'tegra-for-6.3-arm-dt' of git://git.kernel.org/pub/scm/l=
inux/kernel/git/tegra/linux into arm/dt
      Merge tag 'tegra-for-6.3-arm64-dt' of git://git.kernel.org/pub/scm=
/linux/kernel/git/tegra/linux into arm/dt
      Merge tag 'sunxi-dt-for-6.3-1' of https://git.kernel.org/pub/scm/l=
inux/kernel/git/sunxi/linux into arm/dt
      Merge tag 'arm-soc/for-6.3/devicetree' of https://github.com/Broad=
com/stblinux into arm/dt
      Merge tag 'arm-soc/for-6.3/devicetree-arm64' of https://github.com=
/Broadcom/stblinux into arm/dt
      Merge tag 'samsung-dt-6.3' of https://git.kernel.org/pub/scm/linux=
/kernel/git/krzk/linux into arm/dt
      Merge tag 'samsung-dt64-6.3-2' of https://git.kernel.org/pub/scm/l=
inux/kernel/git/krzk/linux into arm/dt
      Merge tag 'dt64-cleanup-6.3-2' of https://git.kernel.org/pub/scm/l=
inux/kernel/git/krzk/linux-dt into arm/dt
      Merge tag 'dt-cleanup-6.3-2' of https://git.kernel.org/pub/scm/lin=
ux/kernel/git/krzk/linux-dt into arm/dt
      Merge tag 'imx-bindings-6.3' of git://git.kernel.org/pub/scm/linux=
/kernel/git/shawnguo/linux into arm/dt
      Merge tag 'imx-dt-6.3' of git://git.kernel.org/pub/scm/linux/kerne=
l/git/shawnguo/linux into arm/dt
      Merge tag 'imx-dt64-6.3' of git://git.kernel.org/pub/scm/linux/ker=
nel/git/shawnguo/linux into arm/dt
      Merge tag 'amlogic-arm64-dt-for-v6.3' of https://git.kernel.org/pu=
b/scm/linux/kernel/git/amlogic/linux into arm/dt
      Merge tag 'amlogic-arm-dt-for-v6.3' of https://git.kernel.org/pub/=
scm/linux/kernel/git/amlogic/linux into arm/dt
      Merge tag 'zynqmp-dt-for-v6.3' of https://github.com/Xilinx/linux-=
xlnx into arm/dt
      Merge tag 'zynq-dt-for-v6.3' of https://github.com/Xilinx/linux-xl=
nx into arm/dt
      Merge tag 'v6.2-next-dts32' of https://git.kernel.org/pub/scm/linu=
x/kernel/git/matthias.bgg/linux into arm/dt
      Merge tag 'v6.2-next-dts64' of https://git.kernel.org/pub/scm/linu=
x/kernel/git/matthias.bgg/linux into arm/dt
      Merge tag 'v6.3-rockchip-dts64-1' of git://git.kernel.org/pub/scm/=
linux/kernel/git/mmind/linux-rockchip into arm/dt
      Merge tag 'v6.3-rockchip-dts32-1' of git://git.kernel.org/pub/scm/=
linux/kernel/git/mmind/linux-rockchip into arm/dt
      Merge tag 'stm32-dt-for-v6.3-1' of git://git.kernel.org/pub/scm/li=
nux/kernel/git/atorgue/stm32 into arm/dt
      Merge tag 'mvebu-dt-6.3-1' of git://git.kernel.org/pub/scm/linux/k=
ernel/git/gclement/mvebu into arm/dt
      Merge tag 'mvebu-dt64-6.3-1' of git://git.kernel.org/pub/scm/linux=
/kernel/git/gclement/mvebu into arm/dt
      Merge tag 'ti-k3-dt-for-v6.3' of https://git.kernel.org/pub/scm/li=
nux/kernel/git/ti/linux into arm/dt
      Merge tag 'socfpga_dts_updates_for_v6.3' of git://git.kernel.org/p=
ub/scm/linux/kernel/git/dinguyen/linux into arm/dt
      Merge tag 'aspeed-6.3-devicetree' of git://git.kernel.org/pub/scm/=
linux/kernel/git/joel/bmc into arm/dt
      Merge tag 'at91-dt-6.3-2' of https://git.kernel.org/pub/scm/linux/=
kernel/git/at91/linux into arm/dt
      Merge tag 'samsung-dt-6.3-2' of https://git.kernel.org/pub/scm/lin=
ux/kernel/git/krzk/linux into arm/dt
      Merge tag 'qcom-dts-for-6.3-2' of https://git.kernel.org/pub/scm/l=
inux/kernel/git/qcom/linux into arm/dt
      Merge tag 'qcom-arm64-for-6.3-2' of https://git.kernel.org/pub/scm=
/linux/kernel/git/qcom/linux into arm/dt
      Merge tag 'qcom-arm64-for-6.3-3' of https://git.kernel.org/pub/scm=
/linux/kernel/git/qcom/linux into arm/dt
      Merge tag 'socfpga_dts_updates_for_v6.3_part2' of git://git.kernel=
.org/pub/scm/linux/kernel/git/dinguyen/linux into arm/dt

Aswath Govindraju (2):
      arm64: dts: ti: k3-am62-main: Add support for USB
      arm64: dts: ti: k3-am625-sk: Add support for USB

Balsam CHIHI (1):
      arm64: dts: mt8195: Add efuse node to mt8195

Bartosz Golaszewski (1):
      dt-bindings: arm: qcom: add the sa8775p-ride board

Bernhard Rosenkr=C3=A4nzer (4):
      dt-bindings: arm64: dts: mediatek: Add mt8365-evk board
      arm64: dts: mediatek: Remove pins-are-numbered property
      ARM: dts: mediatek: Remove pins-are-numbered property
      ARM: dts: stm32: Remove the pins-are-numbered property

Bhupesh Sharma (4):
      arm64: dts: qcom: sm6115: Add debug related nodes
      arm64: dts: qcom: sm6115: Add geni debug uart node for qup0
      arm64: dts: qcom: sm6115: Add watchdog node to dtsi
      arm64: dts: qcom: sm6115: Add smp2p nodes

Biao Huang (1):
      arm64: dts: mt8195: Add Ethernet controller

Bjorn Andersson (19):
      ARM: dts: msm8974: castor: Define pm8841 regulators
      Merge branch 'icc-sm8550-immutable' of https://git.kernel.org/pub/=
scm/linux/kernel/git/djakov/icc into arm64-for-6.3
      Merge branch '20230104093450.3150578-2-abel.vesa@linaro.org' into =
arm64-for-6.3
      Revert "dt-bindings: arm: qcom: Add SM6115(P) and Lenovo Tab P11"
      arm64: dts: qcom: sc8280xp: Define some of the display blocks
      arm64: dts: qcom: sc8280xp-crd: Enable EDP
      arm64: dts: qcom: sa8295-adp: Enable DP instances
      arm64: dts: qcom: sc8280xp: Vote for CX in USB controllers
      arm64: dts: qcom: sc8280xp: Use MMCX for all DP controllers
      arm64: dts: qcom: sc8280xp: Define CMA region for CRD and X13s
      Merge tag 'qcom-arm64-fixes-for-6.2' into arm64-for-6.3
      Merge tag 'qcom-dts-fixes-for-6.2' into dts-for-6.3
      Merge branch '20230103-topic-sm8550-upstream-dispcc-v3-1-8a03d348c=
572@linaro.org' into HEAD
      Merge branch 'icc-qdu1000-immutable' of https://git.kernel.org/pub=
/scm/linux/kernel/git/djakov/icc into HEAD
      Merge branch '20230112204446.30236-2-quic_molvera@quicinc.com' int=
o arm64-for-6.3
      Merge branch '20221213152617.296426-1-konrad.dybcio@linaro.org' in=
to HEAD
      arm64: dts: qcom: sc8280xp: Add USB-C-related DP blocks
      arm64: dts: qcom: sc8280xp-crd: Introduce pmic_glink
      arm64: dts: qcom: sc8280xp-x13s: Enable external display

Brian Masney (8):
      arm64: dts: qcom: sc8280xp: rename qup2_uart17 to uart17
      arm64: dts: qcom: sc8280xp: rename qup2_i2c5 to i2c21
      arm64: dts: qcom: sc8280xp: rename qup0_i2c4 to i2c4
      arm64: dts: qcom: sc8280xp: add missing i2c nodes
      arm64: dts: qcom: sc8280xp: add missing spi nodes
      arm64: dts: qcom: sa8540p-ride: add i2c nodes
      arm64: dts: qcom: sc8280xp: add aliases for i2c4 and i2c21
      arm64: dts: qcom: sc8280xp: add rng device tree node

Bryan O'Donoghue (12):
      ARM: dts: qcom: apq8064: add compat qcom,apq8064-dsi-ctrl
      ARM: dts: qcom: msm8974: Add compat qcom,msm8974-dsi-ctrl
      arm64: dts: qcom: msm8916: Add compat qcom,msm8916-dsi-ctrl
      arm64: dts: qcom: msm8953: Add compat qcom,msm8953-dsi-ctrl
      arm64: dts: qcom: msm8996: Add compat qcom,msm8996-dsi-ctrl
      arm64: dts: qcom: sc7180: Add compat qcom,sc7180-dsi-ctrl
      arm64: dts: qcom: sc7280: Add compat qcom,sc7280-dsi-ctrl
      arm64: dts: qcom: sdm630: Add compat qcom,sdm660-dsi-ctrl
      arm64: dts: qcom: sdm660: Add compat qcom,sdm660-dsi-ctrl
      arm64: dts: qcom: sdm845: Add compat qcom,sdm845-dsi-ctrl
      arm64: dts: qcom: sm8250: Add compat qcom,sm8250-dsi-ctrl
      dt-bindings: arm: qcom: Document MSM8939 SoC binding

Caleb Connolly (1):
      arm64: dts: qcom: sdm845-oneplus-*: add audio devices

Chen-Yu Tsai (5):
      arm64: dts: mediatek: mt8183: Fix systimer 13 MHz clock description
      arm64: dts: mediatek: mt8192: Fix systimer 13 MHz clock description
      arm64: dts: mediatek: mt8195: Fix systimer 13 MHz clock description
      arm64: dts: mediatek: mt8186: Fix systimer 13 MHz clock description
      arm64: dts: mediatek: mt8192: Mark scp_adsp clock as broken

Chris Morgan (6):
      arm64: dts: rockchip: Change audio card name for Odroid Go
      arm64: dts: rockchip: don't set cpll rate for Odroid Go
      arm64: dts: rockchip: update px30 thermal zones for GPU
      arm64: dts: rockchip: Update leds for Odroid Go Advance
      arm64: dts: rockchip: add Hynitron cst340 for Anbernic 353 series
      arm64: dts: rockchip: add display to RG503

Christian Hewitt (12):
      arm64: dts: meson: remove CPU opps below 1GHz for G12A boards
      arm64: dts: meson: add Broadcom WiFi to P212 dtsi
      arm64: dts: meson: move pwm_ef node in P212 dtsi
      arm64: dts: meson: remove WiFi/BT nodes from Khadas VIM1
      arm64: dts: meson: add audio playback to S905X-P212 dts
      arm64: dts: meson: radxa-zero: allow usb otg mode
      arm64: dts: meson: bananapi-m5: switch VDDIO_C pin to OPEN_DRAIN
      arm64: dts: meson: bananapi-m5: remove redundant status from sound=
 node
      arm64: dts: meson: bananapi-m5: convert dts to dtsi
      dt-bindings: arm: amlogic: add support for BananaPi M2-Pro
      arm64: dts: meson: add support for BananaPi M2-Pro
      dt-bindings: arm: amlogic: add support for Radxa Zero2

Christian Marangi (1):
      ARM: dts: qcom: ipq8064: move reg-less nodes outside soc node

Christoph Niedermaier (4):
      dt-bindings: arm: fsl: Add PDK2, PicoITX and DRC02 boards for the =
DHCOM i.MX6ULL SoM
      ARM: dts: imx6ull-dhcom: Add DH electronics DHCOM i.MX6ULL SoM and=
 PDK2 board
      ARM: dts: imx6ull-dhcom: Add DHCOM based PicoITX board
      ARM: dts: imx6ull-dhcom: Add DHSOM based DRC02 board

Christopher Obbard (4):
      arm64: dts: rockchip: Add rock-5b board
      arm64: dts: rockchip: Update sdhci alias for rock-5a
      arm64: dts: rockchip: Remove empty line from rock-5a
      arm64: dts: rockchip: Update sdhci alias for rock-5b

Chukun Pan (4):
      dt-bindings: arm: rockchip: add Radxa CM3I E25
      arm64: dts: rockchip: Add Radxa CM3I E25
      dt-bindings: arm: rockchip: Add Orange Pi R1 Plus
      arm64: dts: rockchip: rk3328: Add Orange Pi R1 Plus

Conor Dooley (12):
      RISC-V: introduce ARCH_FOO kconfig aliases for SOC_FOO symbols
      RISC-V: kconfig.socs: convert usage of SOC_CANAAN to ARCH_CANAAN
      RISC-V: kbuild: convert all use of SOC_FOO to ARCH_FOO
      RISC-V: stop selecting the PolarFire SoC clock driver
      RISC-V: stop selecting SiFive clock and serial drivers directly
      RISC-V: stop directly selecting drivers for SOC_CANAAN
      Merge tag 'soc2arch-immutable' into riscv-dt-for-next
      dt-bindings: vendor-prefixes: Add entry for Aldec
      dt-bindings: riscv: microchip: document the Aldec TySoM
      riscv: dts: microchip: add the Aldec TySoM's devicetree
      Merge patch series "Add a devicetree for the Aldec PolarFire SoC T=
ySoM"
      dt-bindings: riscv: correct starfive visionfive 2 compatibles

Corentin Labbe (1):
      ARM: dts: intel-ixp42x-welltech-epbx100: add ethernet node

Daniel Scally (3):
      dt-bindings: vendor-prefixes: Add Polyhex Technology Co.
      dt-bindings: arm: fsl: Enumerate Debix Model A Board
      arm64: dts: Add device tree for the Debix Model A Board

Danila Tikhonov (1):
      arm64: dts: qcom: msm8953: Add device tree for Xiaomi Mi A1

Dasnavis Sabiya (2):
      dt-bindings: arm: ti: Add binding for AM69 Starter Kit
      arch: arm64: dts: Add support for AM69 Starter Kit

David Heidelberg (1):
      arm64: dts: meson-gxm-khadas-vim2: use gpio-fan matrix instead of =
an array

Delphine CC Chiu (2):
      dt-bindings: arm: aspeed: add Facebook Greatlakes board
      ARM: dts: aspeed: greatlakes: Add Facebook greatlakes (AST2600) BMC

Dhruva Gole (1):
      arm64: dts: ti: k3-am62-main: Fix clocks for McSPI

Dinh Nguyen (3):
      arm64: dts: add pinctrl-single property for Stratix10/Agilex
      arm64: dts: stratix10: add i2c pins for pinctrl
      arm64: dts: socfpga: change address-cells to support 64-bit addres=
sing

Dmitry Baryshkov (57):
      arm64: dts: qcom: qcs404: use symbol names for PCIe resets
      arm64: dts: qcom: qcs404: add power-domains-cells to gcc node
      arm64: dts: qcom: qcs404: add clocks to the gcc node
      arm64: dts: qcom: qcs404: add xo clock to rpm clock controller
      arm64: dts: qcom: qcs404: register PCIe PHY as a clock provider
      arm64: dts: qcom: sm8450: add RPMH_REGULATOR_LEVEL_LOW_SVS_D1
      arm64: dts: qcom: sm8450: add display hardware devices
      arm64: dts: qcom: sm8450-hdk: enable display hardware
      ARM: dts: qcom: msm8974: add second DSI host and PHY
      ARM: dts: qcom: msm8974: add clocks and clock-names to gcc device
      ARM: dts: qcom: msm8974: add clocks and clock-names to mmcc device
      dt-bindings: vendor-prefixes: add Startkit
      dt-bindings: arm: fsl: Add the Starterkit SK-iMX53 board
      ARM: dts: imx: Add support for SK-iMX53 board
      ARM: dts: qcom: msm8974: Add compat qcom,msm8974-dsi-ctrl to dsi1
      arm64: dts: qcom: sm8150: Add compat qcom,sm8150-dsi-ctrl
      arm64: dts: qcom: sm8450: Add compat qcom,sm8450-dsi-ctrl
      arm64: dts: qcom: sm8450-qrd: add missing PMIC includes
      arm64: dts: qcom: sm8450-hdk: add missing PMIC includes
      arm64: dts: qcom: msm8998: get rid of test clock
      arm64: dts: qcom: sdm845: make DP node follow the schema
      arm64: dts: qcom: msm8996-oneplus-common: drop vdda-supply from DS=
I PHY
      arm64: dts: qcom: msm8996: mark apcs as clock provider
      arm64: dts: qcom: sm8150: drop the virtual ipa-virt device
      arm64: dts: qcom: sm8250: drop the virtual ipa-virt device
      arm64: dts: qcom: sm8350: add PCIe devices
      arm64: dts: qcom: sm8350-hdk: enable PCIe devices
      arm64: dts: qcom: use UFS symbol clocks provided by PHY
      ARM: dts: qcom: msm8974: add xo clock to rpm clock controller
      ARM: dts: qcom-msm8974: specify per-sensor calibration cells
      ARM: dts: qcom-apq8084: specify per-sensor calibration cells
      arm64: dts: qcom: msm8956: use SoC-specific compat for tsens
      arm64: dts: qcom: msm8916: specify per-sensor calibration cells
      arm64: dts: qcom: msm8976: specify per-sensor calibration cells
      arm64: dts: qcom: qcs404: specify per-sensor calibration cells
      arm64: dts: qcom: add SoC specific compat strings to mdp5 nodes
      ARM: dts: qcom-msm8974: add SoC specific compat string to mdp5 node
      arm64: dts: qcom: rename mdss nodes to display-subsystem
      arm64: dts: qcom: rename mdp nodes to display-controller
      ARM: dts: qcom-msm8974: rename mdss node to display-subsystem
      ARM: dts: qcom: rename mdp nodes to display-controller
      ARM: dts: qcom: apq8084: add clocks and clock-names to gcc device
      arm64: dts: qcom: msm8996: support using GPLL0 as kryocc input
      arm64: dts: qcom: sc8280xp-crd: drop #sound-dai-cells from eDP node
      arm64: dts: qcom: sc8280xp: add p1 register blocks to DP nodes
      arm64: dts: qcom: sm8350: use qcom,sm8350-dsi-ctrl compatibles
      ARM: dts: qcom: apq8064: add #clock-cells to the HDMI PHY node
      ARM: dts: qcom: apq8064: use hdmi_phy for the MMCC's hdmipll clock
      arm64: dts: qcom: msm8996: enable UFS interconnects
      arm64: dts: qcom: msm8996 switch from RPM_SMD_BB_CLK1 to RPM_SMD_X=
O_CLK_SRC
      arm64: dts: qcom: msm8996: add CBF device entry
      ARM: dts: qcom: apq8064: add second DSI host and PHY
      arm64: dts: qcom: sm8350: reorder device nodes
      arm64: dts: qcom: sm8350: move more nodes to correct place
      arm64: dts: qcom: sm8350: finish reordering nodes
      arm64: dts: qcom: sm8350: add GPU, GMU, GPU CC and SMMU nodes
      arm64: dts: qcom: sm8350-hdk: enable GPU

Douglas Anderson (9):
      arm64: dts: qcom: sc7180: Bump up trogdor ts_reset_l drive strength
      arm64: dts: qcom: sc7180: Add trogdor eDP/touchscreen regulator of=
f-on-time
      arm64: dts: qcom: sc7180: Start the trogdor eDP/touchscreen regula=
tor on
      arm64: dts: qcom: sc7180: Add pazquel360 touschreen
      arm64: dts: qcom: sc7280: On QCard, regulator L3C should be 1.8V
      arm64: dts: qcom: sc7280: Add 3ms ramp to herobrine's pp3300_left_=
in_mlb
      arm64: dts: qcom: sc7280: Hook up the touchscreen IO rail on villa=
ger
      arm64: dts: qcom: sc7280: Hook up the touchscreen IO rail on evoker
      arm64: dts: qcom: sc7280: Power herobrine's 3.3 eDP/TS rail more p=
roperly

Durai Manickam KR (3):
      ARM: dts: at91: sam9x60: fix spi4 node
      dt-bindings: arm: at91: Add info on sam9x60 curiosity
      ARM: dts: at91: sam9x60_curiosity: Add device tree for sam9x60 cur=
iosity board

Dzmitry Sankouski (1):
      arm64: dts: qcom: Re-enable resin on MSM8998 and SDM845 boards

Eddie James (1):
      ARM: dts: aspeed: p10bmc: Enable UART2

Emil Renner Berthing (1):
      dt-bindings: riscv: Add StarFive JH7110 SoC and VisionFive 2 board

Eric Chanudet (4):
      arm64: dts: qcom: rename pm8450a dtsi to sa8540p-pmics
      arm64: dts: qcom: sa8450p-pmics: add rtc node
      arm64: dts: qcom: sa8295p-adp: use sa8540p-pmics
      arm64: dts: qcom: pm8941-rtc add alarm register

Eugen Hristev (1):
      ARM: dts: at91: sama7g5: add nodes for video capture

Eugene Lepshy (1):
      arm64: dts: qcom: msm8953: Add device tree for Xiaomi Redmi 5 Plus

Fabio Estevam (2):
      ARM: dts: imx53: Fix sram.yaml warnings
      ARM: dts: imx51: Fix sram.yaml warnings

Fabrizio Castro (5):
      arm64: dts: renesas: r9a09g011: Add eMMC and SDHI support
      dt-bindings: soc: renesas: Add RZ/V2M PWC
      arm64: dts: renesas: r9a09g011: Reword ethernet status
      arm64: dts: renesas: r9a09g011: Add PWC support
      arm64: dts: renesas: v2mevk2: Add PWC support

Frank Wunderlich (1):
      arm64: dts: mt7986: add Bananapi R3

Frieder Schrempf (1):
      arm64: dts: imx8mm-kontron: Add RTC aliases

Furkan Kardame (1):
      arm64: dts: rockchip: add audio nodes to rk3566-roc-pc

Gabriela David (1):
      arm64: dts: qcom: sdm632: Add device tree for Motorola G7 Power

Geert Uytterhoeven (5):
      arm64: dts: renesas: r8a779f0: Add CA55 operating points
      arm64: dts: renesas: ulcb-kf: Fix pca9548 i2c-mux node names
      ARM: dts: ti: Fix pca954x i2c-mux node names
      arm64: dts: renesas: r8a779g0: Add Cortex-A76 1.8 GHz opp
      arm64: dts: renesas: eagle: Add SCIF_CLK support

Giulio Benetti (1):
      ARM: dts: imxrt1050: increase mmc max-frequency property

Haibo Chen (2):
      arm64: dts: imx93: add flexcan nodes
      arm64: dts: imx93: add ADC support

Harini Katakam (2):
      ARM: dts: zynq: Add xlnx prefix to GEM compatible string
      arm64: dts: zynqmp: Add xlnx prefix to GEM compatible string

Heiner Kallweit (1):
      arm64: dts: amlogic: Fix non-compliant SD/SDIO node names

Herve Codina (1):
      ARM: dts: r9a06g032: Add the USBF controller node

Hsin-Yi Wang (2):
      arm64: dts: mt8183: kukui: Split out keyboard node and describe de=
tachables
      arm64: dts: mt8183: jacuzzi: Move panel under aux-bus

Jagan Teki (20):
      dt-bindings: arm: rockchip: Add pmu compatible for rv1126
      ARM: dts: rockchip: Add Rockchip RV1126 pinctrl
      ARM: dts: rockchip: Add Rockchip RV1126 SoC
      dt-bindings: vendor-prefixes: Add Edgeble AI Technologies Pvt. Ltd.
      dt-bindings: arm: rockchip: Add Edgeble Neural Compute Module 2
      ARM: dts: rockchip: Add Edgeble RV1126 Neural Compute Module 2(Neu=
2)
      ARM: dts: rockchip: Add Edgeble Neural Compute Module 2(Neu2) IO b=
oard
      arm64: dts: rockchip: rk3588: Add Edgeble Neu6 Model A SoM
      arm64: dts: rockchip: rk3588: Add Edgeble Neu6 Model A IO
      dt-bindings: arm: rockchip: Add Edgeble Neural Compute Module 6
      dt-bindings: arm: rockchip: Add Radxa Compute Module 3
      arm64: dts: rockchip: Add rk3566 based Radxa Compute Module 3
      arm64: dts: rockchip: Add Radxa Compute Module 3 IO board
      arm64: dts: rockchip: Update eMMC, SD aliases for Radxa SoM boards
      arm64: dts: rockchip: Update eMMC, SD aliases for Radxa SBC boards
      arm64: dts: rockchip: rk3566: Enable WiFi, BT support for Radxa CM3
      arm64: dts: rockchip: Fix compatible for Radxa CM3
      arm64: dts: rockchip: Add missing CM3i fallback compatible for Rad=
xa E25
      arm64: dts: rockchip: Drop unneeded model for Radxa CM3i
      arm64: dts: rockchip: Correct the model name for Radxa E25

Jamie Douglass (1):
      arm64: dts: qcom: msm8992-lg-bullhead: Correct memory overlaps wit=
h the SMEM and MPSS memory regions

Jan Kiszka (2):
      arm64: dts: ti: iot2050: Add layout of OSPI flash
      dt-bindings: arm: ti: Add binding for Siemens IOT2050 M.2 variant

Jasper Korten (1):
      arm64: dts: qcom: Add device tree for Samsung Galaxy Tab A 9.7 (20=
15)

Jianhua Lu (2):
      dt-bindings: arm: qcom: Add Xiaomi Mi Pad 5 Pro (xiaomi-elish)
      arm64: dts: qcom: sm8250: Add device tree for Xiaomi Mi Pad 5 Pro

Jianqun Xu (1):
      arm64: dts: rockchip: Add rk3588 pinctrl data

Johan Hovold (12):
      arm64: dts: qcom: sc8280xp-x13s: move 'thermal-zones' node
      arm64: dts: qcom: sc8280xp-x13s: move 'regulator-vph-pwr' node
      arm64: dts: qcom: sc8280xp-x13s: enable eDP display
      arm64: dts: qcom: sa8540p-pmics: add missing interrupt include
      arm64: dts: qcom: sa8540p-pmics: rename pmic labels
      arm64: dts: qcom: sc8280xp-crd: allow vreg_l3b to be disabled
      arm64: dts: qcom: sc8280xp: disable sound nodes
      arm64: dts: qcom: sc8280xp-x13s: move vamacro node
      arm64: dts: qcom: sc8280xp-x13s: move wcd938x codec node
      arm64: dts: qcom: sm8450-hdk: move wcd938x codec node
      arm64: dts: qcom: sm8250: clean up wcd938x codec node
      arm64: dts: qcom: sm8550: fix USB-DP PHY resets

Johan Jonker (8):
      dt-bindings: arm: rockchip: Add Rockchip RK3128 Evaluation board
      ARM: dts: rockchip: add rk3128 soc dtsi
      ARM: dts: rockchip: add rk3128-evb
      ARM: dts: rockchip: add space between label and nodename nfc pinct=
rl on rk3128
      ARM: dts: rockchip: add brcmf node to rk3066a-mk808
      dt-bindings: phy: rockchip: convert rockchip-dp-phy.txt to yaml
      dt-bindings: soc: rockchip: grf: add rockchip,rk3288-dp-phy.yaml
      dt-bindings: phy: rename phy-rockchip-inno-usb2.yaml

Jon Hunter (4):
      arm64: tegra: Populate address/size cells for Tegra234 I2C
      arm64: tegra: Populate Jetson AGX Orin EEPROMs
      arm64: tegra: Add dma-coherent property for Tegra194 XUDC
      arm64: tegra: Populate the XUDC node for Tegra234

Jonas Karlman (2):
      arm64: dts: rockchip: assign rate to clk_rtc_32k on rk356x
      arm64: dts: rockchip: fix hdmi cec on rock-3a

Jordan Chang (3):
      dt-bindings: vendor-prefixes: Add prefix for Ufi Space
      dt-bindings: arm: aspeed: document Ufispace NCPLite BMC
      ARM: dts: aspeed: Add device tree for Ufispace NCPLite BMC

Judy Hsiao (1):
      arm64: dts: qcom: sc7280: add DP audio to herobrine rt5682 1-mic d=
tsi

Julian Braha (1):
      arm64: dts: qcom: sdm450: Add device tree for Motorola Moto G6

Julian Weigt (1):
      ARM: dts: qcom: msm8974-castor: Enable charging over USB

Kever Yang (2):
      arm64: dts: rockchip: Add base DT for rk3588 SoC
      arm64: dts: rockchip: Add rk3588-evb1 board

Konrad Dybcio (78):
      arm64: dts: qcom: sm8350-sagami: Configure SLG51000 PMIC on PDX215
      arm64: dts: qcom: sm8350-sagami: Add GPIO line names for PMIC GPIOs
      arm64: dts: qcom: msm8996-tone: Fix USB taking 6 minutes to wake up
      arm64: dts: qcom: sm6115: Fix UFS node
      arm64: dts: qcom: sm6115: Provide xo clk to rpmcc
      arm64: dts: qcom: sm6115: Provide real SMD RPM XO to SDC1/2
      dt-bindings: arm: qcom: Add SM6115(P) and Lenovo Tab P11
      arm64: dts: qcom: Add Lenovo Tab P11 (J606F/XiaoXin Pad) dts
      arm64: dts: qcom: sm6115: Add thermal zones
      arm64: dts: qcom: sm6350: Fix up the ramoops node
      arm64: dts: qcom: msm8996-tone: Enable SDHCI1
      arm64: dts: qcom: msm8996-tone: Move status last
      arm64: dts: qcom: sm8150-kumano: Add GPIO keys
      arm64: dts: qcom: sm8150-kumano: Add NXP PN553 NFC
      arm64: dts: qcom: msm8996: Add additional A2NoC clocks
      arm64: dts: qcom: ipq6018: Use lowercase hex
      arm64: dts: qcom: msm8996: Use lowercase hex
      arm64: dts: qcom: msm8998: Use lowercase hex
      arm64: dts: qcom: sdm630: Use lowercase hex
      arm64: dts: qcom: sdm660: Use lowercase hex
      arm64: dts: qcom: sdm845: Use lowercase hex
      arm64: dts: qcom: sm8250: Use lowercase hex
      arm64: dts: qcom: sm8150: Use lowercase hex
      arm64: dts: qcom: sdm845: Fix some whitespace/newlines
      arm64: dts: qcom: sm8350-sagami: Rectify GPIO keys
      arm64: dts: qcom: sm8150: Add DISPCC node
      arm64: dts: qcom: sm8150: Wire up MDSS
      arm64: dts: qcom: sm8450-nagara: Include PMIC DTSIs
      arm64: dts: qcom: sm8450-nagara: Add GPIO line names for PMIC GPIOs
      arm64: dts: qcom: sm8450-nagara: Add GPIO keys
      arm64: dts: qcom: sm8450-nagara: Set up camera regulators
      arm64: dts: qcom: sm8450-nagara: Enable PMIC RESIN+PON
      arm64: dts: qcom: sm8450-nagara: Configure SLG51000 PMIC
      arm64: dts: qcom: sm8250-edo: Remove misleading comments
      arm64: dts: qcom: sm8350-sagami: Disable empty i2c bus
      arm64: dts: qcom: sm8450-nagara: Disable empty i2c bus
      arm64: dts: qcom: msm8916: Add fallback CCI compatible
      arm64: dts: qcom: sdm845: Add fallback CCI compatible
      arm64: dts: qcom: sm8250: Add fallback CCI compatible
      arm64: dts: qcom: sm8450: Add fallback CCI compatible
      arm64: dts: qcom: sm8350: Drop standalone smem node
      arm64: dts: qcom: msm8998: Use RPM XO
      dt-bindings: arm: qcom: Add SM6115(P) and Lenovo Tab P11
      arm64: dts: qcom: sdm630-nile: Don't use underscores in node names
      arm64: dts: qcom: sdm630-nile: Reserve simplefb memory
      arm64: dts: qcom: sm6350: Add OSM L3 node
      arm64: dts: qcom: sm6350: Set up DDR & L3 scaling
      arm64: dts: qcom: ipq6018: Pad addresses to 8 hex digits
      arm64: dts: qcom: ipq6018: Fix up indentation
      arm64: dts: qcom: ipq6018: Sort nodes properly
      arm64: dts: qcom: ipq6018: Add/remove some newlines
      arm64: dts: qcom: ipq6018: Use lowercase hex
      arm64: dts: qcom: sc8280xp: Pad addresses to 8 hex digits
      arm64: dts: qcom: sm8150: Pad addresses to 8 hex digits
      arm64: dts: qcom: sm6350: Pad addresses to 8 hex digits
      arm64: dts: qcom: sdm845: Pad addresses to 8 hex digits
      arm64: dts: qcom: sm8250: Pad addresses to 8 hex digits
      arm64: dts: qcom: sm8350: Pad addresses to 8 hex digits
      arm64: dts: qcom: sc7180: Pad addresses to 8 hex digits
      arm64: dts: qcom: sc7280: Pad addresses to 8 hex digits
      arm64: dts: qcom: msm8994-octagon: Pad addresses to 8 hex digits
      arm64: dts: qcom: sm8450: Pad addresses to 8 hex digits
      arm64: dts: qcom: msm8994-kitakami: Pad addresses to 8 hex digits
      arm64: dts: qcom: sm6115: Pad addresses to 8 hex digits
      arm64: dts: qcom: sm8350: Add missing #address/size-cells to DSIn
      arm64: dts: qcom: sm8350: Fix DSI1 interrupt
      arm64: dts: qcom: sm8350: Feed DSI1 PHY clocks to DISPCC
      arm64: dts: qcom: sm8350: Fix DSI PHY compatibles
      arm64: dts: qcom: sm8350: Fix DSI PLL size
      arm64: dts: qcom: sm8350: Add mdss_ prefix to DSIn out labels
      arm64: dts: qcom: sm8350: Hook up DSI1 to MDP
      arm64: dts: qcom: sm8450-nagara: Correct firmware paths
      arm64: dts: qcom: sm6115: Add mdss_ prefix to mdss nodes
      arm64: dts: qcom: sm6115: Use 64 bit addressing
      arm64: dts: qcom: sm8450: Fix DSIn PHY compatible
      arm64: dts: qcom: sm8250: Disable wsamacro and swr0 by default
      dt-bindings: clock: add QCOM SM6350 camera clock bindings
      arm64: dts: qcom: pmk8350: Use the correct PON compatible

Konstantin Aladyshev (5):
      ARM: dts: aspeed: ethanolx: Enable VUART
      ARM: dts: aspeed: ethanolx: Correct EEPROM device name
      ARM: dts: aspeed: ethanolx: Add label for the master partition
      ARM: dts: aspeed: ethanolx: Enable CTS/RTS pins on UART1
      ARM: dts: aspeed: ethanolx: Add BIOS flash chip

Krzysztof Kozlowski (200):
      arm64: dts: exynos: add dedicated SYSREG compatibles to Exynos5433
      arm64: dts: exynos: use 8-bit for SPI IR LED duty-cycle in TM2
      arm64: dts: exynos: drop pwm-names from MAX77843 haptic in TM2
      arm64: dts: exynos: drop clock-frequency from CPU nodes in TM2
      arm64: dts: exynos: correct properties of MAX98504 in TM2
      dt-bindings: soc: samsung: exynos-sysreg: split from syscon
      dt-bindings: soc: samsung: exynos-sysreg: add dedicated SYSREG com=
patibles to Exynos5433
      dt-bindings: soc: samsung: exynos-sysreg: add clocks for Exynos850
      arm64: dts: qcom: msm8996: drop address/size cells from smd-edge
      arm64: dts: qcom: qcs404: align CDSP PAS node with bindings
      arm64: dts: qcom: sc7180: align MPSS PAS node with bindings
      arm64: dts: qcom: sc7280: align MPSS PAS node with bindings
      ARM: dts: qcom: sdx55-mtp: add MPSS remoteproc memory-region
      arm64: dts: qcom: msm8996-xiaomi-gemini: use preferred enable-gpio=
s for LP5562 LED
      arm64: dts: qcom: sdm845: drop 0x from unit address
      arm64: dts: qcom: sc7180: move QUP and QSPI opp tables out of SoC =
node
      arm64: dts: qcom: sdm845: move DSI/QUP/QSPI opp tables out of SoC =
node
      arm64: dts: qcom: sdm845: move sound node out of soc
      arm64: dts: qcom: sm8250: move sound and codec nodes out of soc
      arm64: dts: qcom: sm8250: add cache size
      arm64: dts: qcom: sm8350-sony-xperia-sagami: specify which LDO mod=
es are allowed
      ARM: dts: qcom: sdx55: add specific compatible for USB HS PHY
      ARM: dts: qcom: sdx65: add specific compatible for USB HS PHY
      arm64: dts: qcom: sm8350: align MMC node names with DT schema
      arm64: dts: qcom: msm8996: align bus node names with DT schema
      arm64: dts: qcom: sm8250: drop unused clock-frequency from va-macro
      arm64: dts: qcom: sm8450: re-order GCC clocks
      arm64: dts: qcom: use generic node name for CS35L41 speaker
      arm64: dts: imx: align LED node names with dtschema
      ARM: dts: imx: align LED node names with dtschema
      ARM: dts: vf610: align LED node names with dtschema
      arm64: dts: imx8dxl: drop 0x from unit address
      ARM: dts: meson: align LED node names with dtschema
      arm64: dts: amlogic: align LED node names with dtschema
      arm64: dts: qcom: sm8450: disable by default Soundwire and VA-macro
      arm64: dts: qcom: sc8280xp: align PSCI domain names with DT schema
      arm64: dts: qcom: sm6375: align PSCI domain names with DT schema
      arm64: dts: qcom: sm8150: align PSCI domain names with DT schema
      arm64: dts: qcom: sm8250: align PSCI domain names with DT schema
      arm64: dts: qcom: sm8350: align PSCI domain names with DT schema
      arm64: dts: qcom: sm8450: align PSCI domain names with DT schema
      arm64: dts: xilinx: align LED node names with dtschema
      arm64: dts: mediatek: align LED node names with dtschema
      arm64: dts: qcom: sdm845-db845c: fix audio codec interrupt pin name
      arm64: dts: qcom: sdm845-xiaomi-beryllium: fix audio codec interru=
pt pin name
      arm64: dts: qcom: sdm845: align TLMM pin configuration with DT sch=
ema
      arm64: dts: qcom: sdm845: do not customize SPI0 pin drive/bias
      dt-bindings: soc: samsung: exynos-sysreg: correct indentation for =
deprecated
      arm64: dts: exynos: drop unsupported I2C properties in Espresso
      ARM: dts: exynos: drop unused pinctrl-names from Galaxy Tab
      arm64: dts: broadcom: align SMMU node names with DT schema
      arm64: dts: qcom: sc7180: order top-level nodes alphabetically
      arm64: dts: qcom: sdm845: order top-level nodes alphabetically
      ARM: dts: qcom: reverse compatibles to match bindings
      ARM: dts: qcom: apq8064: drop second clock frequency from timer
      ARM: dts: qcom: ipq8064: drop second clock frequency from timer
      ARM: dts: qcom: mdm9615: drop second clock frequency from timer
      ARM: dts: qcom: msm8960: drop second clock frequency from timer
      ARM: dts: qcom: msm8960: add qcom,kpss-wdt-mdm9615
      arm64: dts: qcom: sc7180: correct SPMI bus address cells
      arm64: dts: qcom: sc7280: correct SPMI bus address cells
      arm64: dts: qcom: sc8280xp: correct SPMI bus address cells
      arm64: dts: qcom: rename AOSS QMP nodes
      arm64: dts: qcom: replace underscores in node names
      dt-bindings: arm: qcom: add board-id/msm-id for MSM8956, SDM636 an=
d SM4250
      arm64: dts: qcom: sm8450: correct Soundwire wakeup interrupt name
      ARM: dts: qcom: add missing space before {
      arm64: dts: qcom: add missing space before {
      arm64: dts: microchip: drop 0x from unit address
      ARM: dts: socfpga: drop 0x from unit address
      ARM: dts: stih410: align HDMI CEC node names with dtschema
      ARM: dts: keystone: align LED node names with dtschema
      ARM: dts: dove: align LED node names with dtschema
      ARM: dts: at91: align LED node names with dtschema
      arm64: dts: hisilicon: align LED node names with dtschema
      MAINTAINERS: arm64: tesla: correct pattern for directory
      arm64: dts: qcom: sm8350: drop unused dispcc power-domain-names
      arm64: dts: qcom: sc7180-trogdor: align DAI children names with DT=
 schema
      arm64: dts: qcom: sm8250: drop unused clock-frequency from rx-macro
      arm64: dts: qcom: sc8280xp: drop bogus clock-controller property
      arm64: dts: qcom: sc8280xp: drop unused properties from tx-macro
      arm64: dts: qcom: msm8916-samsung-a2015: correct motor pinctrl nod=
e name
      arm64: dts: qcom: sc7280-idp: add amp pin config function
      ARM: dts: qcom: align OPP table node name with DT schema
      arm64: dts: qcom: align OPP table node name with DT schema
      arm64: dts: qcom: sm8250: drop unused clock-frequency from wsa-mac=
ro
      arm64: dts: qcom: sm8250: drop unused properties from tx-macro
      arm64: dts: qcom: sdm845-db845c: drop label from I2C controllers
      ARM: dts: meson8: align OPP table names with DT schema
      ARM: dts: exynos: align OPP table names with DT schema
      ARM: dts: exynos: drop incorrect power-supplies in P4 Note
      ARM: dts: exynos: correct wr-active property in Exynos3250 Rinato
      ARM: dts: exynos: drop unsupported desc-num in Exynos3250
      ARM: dts: exynos: correct cd-gpios property in Exynos4412 Itop Eli=
te
      ARM: dts: exynos: align pin node names in Exynos4412
      arm64: dts: exynos: drop unsupported UFS properties in ExynosAutov=
9 SADK
      ARM: dts: exynos: add ports in HDMI bridge in Exynos4412 Midas
      ARM: dts: exynos: add panel supply in Tiny4412
      ARM: dts: exynos: add backlight supply in P4 Note
      ARM: dts: exynos: align HSOTG/USB node names
      ARM: dts: exynos: correct SATA clocks in Exynos5250
      ARM: dts: exynos: correct HS200 property in Exynos5260
      ARM: dts: exynos: correct HSI2C properties in Exynos5410 Odroid XU
      ARM: dts: broadcom: align UART node name with bindings
      arm64: dts: broadcom: drop deprecated serial device_type
      ARM: dts: socfpga: align UART node name with bindings
      ARM: dts: mstar: align UART node name with bindings
      ARM: dts: cx92755: align UART node name with bindings
      arm64: dts: mediatek: mt7622: drop serial clock-names
      arm64: dts: mediatek: mt8183: drop double interrupts
      ARM: dts: ste: align LED node names with dtschema
      dt-bindings: power: fsl,imx-gpc: document fsl,imx6ul-gpc compatible
      dt-bindings: power: fsl,imx-gpc: correct compatibles
      dt-bindings: power: fsl,imx-gpc: document interrupt-controller
      ARM: dts: exynos: correct HDMI phy compatible in Exynos4
      ARM: dts: exynos: use generic node names for phy
      ARM: dts: exynos: use lowercase hex addresses
      ARM: dts: arm: align UART node name with bindings
      arm64: dts: apm: drop deprecated serial device_type
      arm64: dts: amazon: drop deprecated serial device_type
      ARM: dts: alpine: align UART node name with bindings
      ARM: dts: axm55xx: align UART node name with bindings
      ARM: dts: moxart: align UART node name with bindings
      ARM: dts: dm814x: align UART node name with bindings
      ARM: dts: stih418: align OPP table names with DT schema
      ARM: dts: imx: use generic node name for rave-sp
      arm64: dts: realtek: align UART node name with bindings
      arm64: dts: hisilicon: align UART node name with bindings
      arm64: dts: synaptics: align UART node name with bindings
      ARM: dts: berlin: align UART node name with bindings
      ARM: dts: sun8i: h3-beelink-x2: align HDMI CEC node names with dts=
chema
      arm64: dts: exynos: disable non-working GPU on Exynos7 Espresso
      arm64: dts: exynos: add ADC supply on Exynos7 Espresso
      arm64: dts: exynos: correct Bluetooth LED triger on E850-96
      arm64: dts: exynos: add VPH_PWR regulator on TM2
      arm64: dts: exynos: add interrupt-controller to WM5110 on TM2
      arm64: dts: exynos: correct wlf,micd-dbtime on TM2
      arm64: dts: exynos: use lowercase hex addresses
      arm64: dts: microchip: use "okay" for status
      arm64: dts: apm: use "okay" for status
      arm64: dts: amd: use "okay" for status
      ARM: dts: exynos: move exynos-bus nodes out of soc in Exynos5420
      ARM: dts: exynos: move exynos-bus nodes out of soc in Exynos3250
      ARM: dts: exynos: move exynos-bus nodes out of soc in Exynos4210
      ARM: dts: exynos: move exynos-bus nodes out of soc in Exynos4412
      arm64: dts: exynos: move exynos-bus nodes out of soc in Exynos5433
      ARM: dts: exynos: add unit address to DWC3 node wrapper in Exynos5=
250
      ARM: dts: exynos: add unit address to DWC3 node wrapper in Exynos5=
4xx
      arm64: dts: exynos: add unit address to DWC3 node wrapper in Exyno=
s5433
      arm64: dts: exynos: add unit address to DWC3 node wrapper in Exyno=
s7
      arm64: dts: imx8q: use generic node name for rave-sp
      arm64: dts: qcom: sm8550: add GPR and LPASS pin controller
      arm64: dts: qcom: sc7280-herobrine-audio-wcd9385: drop incorrect p=
roperties
      arm64: dts: qcom: sc7280-idp: drop incorrect properties
      ARM: dts: qcom: use "okay" for status
      ARM: dts: qcom-sdx55: align RPMh regulator nodes with bindings
      ARM: dts: qcom-sdx65: align RPMh regulator nodes with bindings
      arm64: dts: qcom: use generic node name for Bluetooth
      arm64: dts: qcom: sm8350: drop incorrect cells from serial
      arm64: dts: qcom: sm8450: drop incorrect cells from serial
      arm64: dts: qcom: sm8550: drop incorrect cells from serial
      arm64: dts: qcom: sdm845-db845c: add generic sound compatible
      arm64: dts: qcom: sdm845-xiaomi-beryllium: add generic sound compa=
tible
      arm64: dts: qcom: sdm850-lenovo-yoga: correct sound compatible
      arm64: dts: qcom: sdm845: move codec to separate file
      arm64: dts: qcom: sdm845-audio-wcd9340: commonize pinctrl
      arm64: dts: qcom: sdm845-audio-wcd9340: commonize clocks
      arm64: dts: qcom: sa8295p-adp: align RPMh regulator nodes with bin=
dings
      arm64: dts: qcom: sc7180: align RPMh regulator nodes with bindings
      arm64: dts: qcom: sc8280xp: align RPMh regulator nodes with bindin=
gs
      arm64: dts: qcom: sdm845: align RPMh regulator nodes with bindings
      arm64: dts: qcom: sm7225: align RPMh regulator nodes with bindings
      arm64: dts: qcom: sm8150: align RPMh regulator nodes with bindings
      arm64: dts: qcom: sm8250: align RPMh regulator nodes with bindings
      arm64: dts: qcom: sm8350: align RPMh regulator nodes with bindings
      arm64: dts: qcom: sm8450: align RPMh regulator nodes with bindings
      arm64: dts: qcom: sm8550: add specific SMMU compatible
      arm64: dts: qcom: sm8550-mtp: correct vdd-l5-l16-supply
      arm64: dts: qcom: sm8350: fixup SDHCI interconnect arguments
      ARM: dts: qcom: apq8060-dragonboard: align MPP pin node names with=
 DT schema
      ARM: dts: qcom: sdx55: correct TLMM gpio-ranges
      ARM: dts: qcom: align OPP table names with DT schema
      arm64: dts: qcom: sm8350-hdk: align pin config node names with bin=
dings
      arm64: dts: qcom: sm8350-hdk: correct LT9611 pin function
      arm64: dts: qcom: msm8953: correct TLMM gpio-ranges
      arm64: dts: qcom: sm6115: correct TLMM gpio-ranges
      arm64: dts: qcom: sc8280xp: correct LPASS GPIO gpio-ranges
      ARM: dts: exynos: align status led name with bindings on Origen4210
      ARM: dts: exynos: drop default status from I2C10 on Arndale
      ARM: dts: exynos: drop redundant address/size cells from I2C10 on =
Arndale
      ARM: dts: exynos: move I2C10 out of soc node on Arndale
      ARM: dts: exynos: correct SPI nor compatible in SMDKv310
      ARM: dts: exynos: correct SPI nor compatible in SMDK5250
      ARM: dts: exynos: add "gpios" suffix to wlf,ldo1ena on Midas
      ARM: dts: exynos: add "gpios" suffix to wlf,ldo1ena on Arndale
      ARM: dts: s5pv210: add "gpios" suffix to wlf,ldo1ena on Aries
      ARM: dts: exynos: correct max98090 DAI argument in Snow
      arm64: dts: qcom: ipq6018: align RPM G-Link node with bindings
      arm64: dts: qcom: qcs404: align RPM G-Link node with bindings
      arm64: dts: qcom: msm8996: align RPM G-Link clock-controller node =
with bindings

Kunihiko Hayashi (9):
      ARM: dts: uniphier: Align node names for SoC-dependent controller =
and PHYs with bindings
      ARM: dts: uniphier: Add missing reg properties for glue layer
      ARM: dts: uniphier: Add syscon compatible string to soc-glue-debug
      ARM: dts: uniphier: Add syscon-uhs-mode to SD node
      arm64: dts: uniphier: Align node names for SoC-dependent controlle=
r and PHYs with bindings
      arm64: dts: uniphier: Add missing reg properties for glue layer no=
des
      arm64: dts: uniphier: Add syscon compatible string to soc-glue-deb=
ug
      arm64: dts: uniphier: Add syscon-uhs-mode to SD node
      arm64: dts: uniphier: Fix property name in PXs3 USB node

Kuninori Morimoto (8):
      ARM: dts: renesas: #sound-dai-cells is used when simple-card
      arm64: dts: renesas: #sound-dai-cells is used when simple-card
      arm64: dts: renesas: Add ulcb{-kf} Audio Graph Card dtsi
      arm64: dts: renesas: Add ulcb{-kf} Audio Graph Card2 dtsi
      arm64: dts: renesas: Add ulcb{-kf} Simple Audio Card dtsi
      arm64: dts: renesas: Add ulcb{-kf} Audio Graph Card2 MIX + TDM Spl=
it dtsi
      arm64: dts: renesas: Add ulcb{-kf} Audio Graph Card MIX + TDM Spli=
t dtsi
      arm64: dts: renesas: Add ulcb{-kf} Simple Audio Card MIX + TDM Spl=
it dtsi

Kuogee Hsieh (1):
      arm64: dts: qcom: add data-lanes and link-freuencies into dp_out e=
ndpoint

Lad Prabhakar (6):
      riscv: dts: renesas: rzfive-smarc-som: Enable WDT
      riscv: dts: renesas: rzfive-smarc-som: Enable OSTM nodes
      riscv: dts: renesas: rzfive-smarc-som: Drop PHY interrupt support =
for ETH{0,1}
      arm64: dts: renesas: r9a07g043u: Add IRQC node
      arm64: dts: renesas: r9a07g043u: Update pinctrl node to handle GPI=
O interrupts
      arm64: dts: renesas: rzg2ul-smarc-som: Add PHY interrupt support f=
or ETH{0/1}

Laurent Pinchart (4):
      ARM: dts: stm32: Use new media bus type macros
      ARM: dts: omap: Use new media bus type macros
      ARM: dts: renesas: Use new media bus type macros
      ARM: dts: freescale: Use new media bus type macros

Lin, Meng-Bo (14):
      arm64: dts: qcom: msm8916-samsung-grandmax: Add properties functio=
n and color for keyled
      dt-bindings: qcom: Document msm8916-acer-a1-724
      arm64: dts: qcom: msm8916-acer-a1-724: Add initial device tree
      arm64: dts: qcom: msm8916-acer-a1-724: Add accelerometer/magnetome=
ter
      arm64: dts: qcom: msm8916-acer-a1-724: Add touchscreen
      dt-bindings: vendor-prefixes: Add GPLUS
      dt-bindings: qcom: Document msm8916-gplus-fl8005a
      arm64: dts: qcom: msm8916-gplus-fl8005a: Add initial device tree
      arm64: dts: qcom: msm8916-gplus-fl8005a: Add touchscreen
      arm64: dts: qcom: msm8916-gplus-fl8005a: Add flash LED
      dt-bindings: qcom: Document bindings for msm8916-samsung-j5x
      arm64: dts: qcom: msm8916-samsung-j5-common: Add initial common de=
vice tree
      arm64: dts: qcom: msm8916-samsung-j5-common: Add new device trees
      arm64: dts: qcom: msm8916-samsung-j5-common: Add Hall sensor

Linus Walleij (6):
      ARM: dts: gemini: Push down flash address/size cells
      ARM: dts: gemini: wbd111: Use RedBoot partion parser
      ARM: dts: gemini: wbd222: Use RedBoot partion parser
      ARM: dts: gemini: Fix USB block version
      ARM: dts: gemini: Enable DNS313 FOTG210 as periph
      ARM: dts: ux500: Add clkout-clock node

Luca Weiss (22):
      ARM: dts: qcom: msm8974-*: re-add remoteproc supplies
      ARM: dts: qcom: msm8974-castor: Fix touchscreen init
      arm64: dts: qcom: sdm632-fairphone-fp3: Add NFC
      arm64: dts: qcom: sm7225-fairphone-fp4: Add pmk8350 PMIC
      arm64: dts: qcom: pm6150l: add spmi-flash-led node
      arm64: dts: qcom: sm7225-fairphone-fp4: configure flash LED
      dt-bindings: arm: qcom: document new msm8953-family devices
      arm64: dts: qcom: msm8953: Adjust reserved-memory nodes
      arm64: dts: qcom: pm7250b: Add BAT_ID vadc channel
      arm64: dts: qcom: sm6350: add IPA node
      arm64: dts: qcom: sm7225-fairphone-fp4: enable IPA
      ARM: dts: qcom: pm8941: Add vibrator node
      ARM: dts: qcom: msm8974-oneplus-bacon: Add vibrator
      ARM: dts: qcom: msm8974-oneplus-bacon: Add volume keys and hall se=
nsor
      ARM: dts: qcom: msm8974-oneplus-bacon: Add backlight
      ARM: dts: qcom: msm8974-oneplus-bacon: Add notification LED
      arm64: dts: qcom: sm6350: Add camera clock controller
      arm64: dts: qcom: sm6350: Add CCI nodes
      arm64: dts: qcom: sm7225-fairphone-fp4: Enable CCI busses
      arm64: dts: qcom: sm6350: Use specific qmpphy compatible
      arm64: dts: qcom: sm7225-fairphone-fp4: move status property down
      arm64: dts: qcom: sm7225-fairphone-fp4: enable remaining i2c busses

Lucas Stach (3):
      arm64: dts: imx8mp: move PCIe controller clock config to SoC dtsi
      dt-bindings: soc: imx8mp-hsio-blk-ctrl: add clock cells
      arm64: dts: imx8mp: add clock-cells to hsio-blk-ctrl

Lucas Tanure (1):
      arm64: dts: rockchip: Fix RX delay for ethernet phy on rk3588s-roc=
k5a

Manikandan Muralidharan (5):
      ARM: dts: at91: sam9x60: Fix the label numbering for the flexcom f=
unctions
      ARM: dts: at91: sam9x60: move flexcom definitions
      ARM: dts: at91: sam9x60: Specify the FIFO size for the Flexcom UART
      ARM: dts: at91: sam9x60: Add DMA bindings for the flexcom nodes
      ARM: dts: at91: sam9x60: Add missing flexcom definitions

Manivannan Sadhasivam (5):
      arm64: dts: qcom: sm8450: Use GIC-ITS for PCIe0 and PCIe1
      arm64: dts: qcom: sm8450: Allow both GIC-ITS and internal MSI cont=
roller
      ARM: dts: qcom: sdx55: Add Qcom SMMU-500 as the fallback for IOMMU=
 node
      ARM: dts: qcom: sdx65: Add Qcom SMMU-500 as the fallback for IOMMU=
 node
      arm64: dts: qcom: sc8280xp-pmics: Specify interrupt parent explici=
tly

Manoj Sai (2):
      arm64: dts: rockchip: increase spi-max-frequency of nor flash for =
roc-rk3399-pc
      arm64: dts: rockchip: Enable Ethernet for Radxa CM3 IO

Marcel Ziswiler (4):
      ARM: dts: colibri-imx6: improve wake-up with gpio key
      ARM: dts: colibri-imx6ull: improve wake-up with gpio key
      ARM: dts: apalis/colibri-imx6/6ull/7: proper gpio-key node names
      arm64: dts: verdin-imx8mp: unify gpio-key node name

Marco Felsch (1):
      arm64: dts: imx8mm-evk: use correct gpio-expander compatible

Marek Vasut (28):
      arm64: dts: imx8m: Align SoC unique ID node unit address
      arm64: dts: imx8m: Document the fuse address calculation
      arm64: dts: imx8m: Add TMU phandle to calibration data in OCOTP
      arm64: dts: imx8mp: Drop deprecated regulator-compatible from i.MX=
8M Plus DHCOM
      arm64: dts: imx8mm: Drop deprecated regulator-compatible from Vari=
scite VAR-SOM-MX8MM
      arm64: dts: imx8mn: Drop deprecated regulator-compatible from Vari=
scite VAR-SOM-MX8MN
      arm64: dts: imx8mn: Add LDO5 regulator-name to Variscite VAR-SOM-M=
X8MN
      arm64: dts: imx8mm: Update i.MX8M Mini Toradex Verdin based Menlo =
board compatible string
      ARM: dts: mxs: Drop dma-apb interrupt-names
      ARM: dts: imx6qdl: Drop dma-apb interrupt-names
      ARM: dts: imx6sx: Drop dma-apb interrupt-names
      ARM: dts: imx6ul: Drop dma-apb interrupt-names
      ARM: dts: imx7s: Drop dma-apb interrupt-names
      arm64: dts: imx8mm: Drop dma-apb interrupt-names
      arm64: dts: imx8mn: Drop dma-apb interrupt-names
      arm64: dts: imx8mp: Add Hantro G1, G2 DT nodes
      dt-bindings: arm: Move MX8Menlo board to i.MX8M Mini Toradex Verdi=
n SoM entry
      dt-bindings: arm: Split i.MX8M Mini NITROGEN SoM based boards
      dt-bindings: arm: Split i.MX8M Plus DHCOM based boards
      dt-bindings: arm: Move i.MX8MM Cloos PHG Board to TQM entry
      ARM: dts: vfxxx: Swap SAI DMA order
      arm64: dts: imx8mm: Deduplicate PCIe clock-names property
      arm64: dts: imx8mq: Deduplicate PCIe clock-names property
      arm64: dts: imx8mp: Reorder clock to match fsl,imx6q-pcie.yaml
      arm64: dts: imx8mp: Improve bluetooth UART on DH electronics i.MX8=
M Plus DHCOM
      arm64: dts: imx8mm: Drop sd-vsel-gpios from i.MX8M Mini Verdin SoM
      arm64: dts: imx8mp: Drop sd-vsel-gpios from i.MX8M Plus Verdin SoM
      arm64: dts: imx8mp: Drop sd-vsel-gpios from i.MX8M Plus DHCOM SoM

Marijn Suijten (17):
      arm64: dts: qcom: sm8150-kumano: Panel framebuffer is 2.5k instead=
 of 4k
      arm64: dts: qcom: pmi8950: Correct rev_1250v channel label to mv
      arm64: dts: qcom: Use plural _gpios node label for PMIC gpios
      arm64: dts: qcom: sm8150-kumano: Configure resin as volume up key
      arm64: dts: qcom: sm8150: Enable split pagetables for Adreno SMMU
      arm64: dts: qcom: sm6350-lena: Flatten gpio-keys pinctrl state
      arm64: dts: qcom: sm6125-seine: Configure PM6125 regulators
      arm64: dts: qcom: sm6125-seine: Provide regulators to HS USB2 PHY
      arm64: dts: qcom: sm6125-seine: Provide regulators to SDHCI 1
      arm64: dts: qcom: sm6125-seine: Configure SD Card slot on SDHCI 2
      arm64: dts: qcom: sm6125-seine: Lock eMMC and SD Card IDs via alia=
ses
      arm64: dts: qcom: sm6125: Reorder HSUSB PHY clocks to match bindin=
gs
      arm64: dts: qcom: sm6125: Add apps_smmu with streamID to SDHCI 1/2=
 nodes
      arm64: dts: qcom: sm6125-seine: Clean up gpio-keys (volume down)
      arm64: dts: qcom: sm6125: Add QUPs with SPI and I2C Serial Engines
      arm64: dts: qcom: sm6125-seine: Enable GPI DMA 0, QUP 0 and I2C SEs
      arm64: dts: qcom: sdm845-tama: Add volume up and camera GPIO keys

Mark Jackson (5):
      ARM: dts: am335x-nano: Fix GPIO settings for RTS/CTS pins on UART3=
 & 4
      ARM: dts: am335x-nano: Enable RS485 mode for UART3 & 4
      ARM: dts: am335x-nano: Enable I2C temperature sensor
      ARM: dts: am335x-nano: Fix GPIO settings for MMC pins
      ARM: dts: am335x-nano: Enable USB host

Markuss Broks (5):
      arm64: dts: qcom: msm8916-samsung-j5-common: Add MUIC support
      ARM: dts: exynos: Use Exynos5420 compatible for the MIPI video phy
      ARM: dts: exynos: Use Exynos5422 compatible for the DSI controller
      dt-bindings: arm: samsung: Add compatible for Samsung Galaxy S5 (S=
M-G900H)
      ARM: dts: exynos: Add Samsung Galaxy S5 (SM-G900H) board

Martin Blumenstingl (8):
      arm64: dts: meson-gxl: jethub-j80: Fix WiFi MAC address node
      arm64: dts: meson-gxl: jethub-j80: Fix Bluetooth MAC node name
      arm64: dts: meson-axg: jethub-j1xx: Fix MAC address node names
      arm64: dts: meson-gx: Fix Ethernet MAC address unit name
      arm64: dts: meson-g12a: Fix internal Ethernet PHY unit name
      arm64: dts: meson-gx: Fix the SCPI DVFS node name and unit address
      ARM: dts: meson8: Add more L2 (PL310) cache properties
      ARM: dts: meson8b: Add more L2 (PL310) cache properties

Martin Botka (3):
      arm64: dts: qcom: sm6125: Configure APPS SMMU
      arm64: dts: qcom: sm6125: Add GPI DMA nodes
      arm64: dts: qcom: sm6125: Add pin configs for QUP SPI/I2C Serial E=
ngines

Martin Kepplinger (1):
      arm64: dts: imx8mq-librem5: use multicolor leds description for RG=
B led

Matti Lehtim=C3=A4ki (2):
      ARM: dts: qcom: apq8026-samsung-matisse-wifi: Enable ADSP
      ARM: dts: qcom: apq8026-samsung-matisse-wifi: Add display backlight

Melody Olvera (5):
      dt-bindings: interconnect: Add QDU1000/QRU1000 devices
      interconnect: qcom: Add QDU1000/QRU1000 interconnect driver
      dt-bindings: clock: Add QDU1000 and QRU1000 GCC clocks
      arm64: dts: qcom: Add base QDU1000/QRU1000 DTSIs
      arm64: dts: qcom: Add base QDU1000/QRU1000 IDP DTs

Michael Grzeschik (1):
      arm64: zynqmp: Enable hs termination flag for USB dwc3 controller

Michael Riesch (1):
      arm64: dts: rockchip: add pinctrls for 16-bit/18-bit rgb interface=
 to rk356x

Michael Walle (1):
      arm64: dts: ls1028a: sl28: get MAC addresses from VPD

Michal Simek (4):
      arm64: xilinx: Fix opp-table-cpu
      arm64: dts: zynqmp: Remove clock-names from GEM in zynqmp-clk-ccf.=
dtsi
      ARM: zynq: Comment interrupt names IRQs for pl330
      ARM: zynq: Use recommended dma-controller name instead of dmac

Micha=C5=82 Grzelak (1):
      ARM: dts: dove.dtsi: Move ethphy to fix schema error

Mikko Perttunen (1):
      arm64: tegra: Mark host1x as dma-coherent on Tegra194/234

Mukesh Ojha (1):
      arm64: dts: qcom: sm8450: Add TCSR halt register space

Neil Armstrong (37):
      Merge branch 'v6.3/bindings' of https://git.kernel.org/pub/scm/lin=
ux/kernel/git/amlogic/linux into v6.3/arm64-dt
      arm64: dts: qcom: Add pm8010 pmic dtsi
      arm64: dts: qcom: Add PM8550 pmic dtsi
      arm64: dts: qcom: Add PM8550b pmic dtsi
      arm64: dts: qcom: Add PM8550ve pmic dtsi
      arm64: dts: qcom: Add PM8550vs pmic dtsi
      arm64: dts: qcom: Add PMK8550 pmic dtsi
      arm64: dts: qcom: Add PMR735d pmic dtsi
      arm64: dts: qcom: sm8550: add I2C Master Hub nodes
      arm64: dts: qcom: sm8550: add QCrypto nodes
      dt-bindings: clock: document SM8550 DISPCC clock controller
      arm64: dts: qcom: sm8550: add display hardware devices
      arm64: dts: qcom: sm8550-mtp: enable display hardware
      arm64: dts: qcom: sm8550-mtp: add DSI panel
      arm64: dts: qcom: sm8550: add adsp, cdsp & mdss nodes
      arm64: dts: qcom: sm8550-mtp: enable adsp, cdsp & mdss
      arm64: dts: amlogic: meson-gx: fix SCPI clock dvfs node name
      arm64: dts: amlogic: meson-axg: fix SCPI clock dvfs node name
      arm64: dts: amlogic: meson-gx: add missing SCPI sensors compatible
      arm64: dts: amlogic: meson-axg-jethome-jethub-j1xx: fix supply nam=
e of USB controller node
      arm64: dts: amlogic: meson-gxl-s905d-sml5442tw: drop invalid clock=
-names property
      arm64: dts: amlogic: meson-gx: add missing unit address to rng nod=
e name
      arm64: dts: amlogic: meson-gxl-s905w-jethome-jethub-j80: fix inval=
id rtc node name
      arm64: dts: amlogic: meson-axg-jethome-jethub-j1xx: fix invalid rt=
c node name
      arm64: dts: amlogic: meson-gxl: add missing unit address to eth-ph=
y-mux node name
      arm64: dts: amlogic: meson-gx-libretech-pc: fix update button name
      arm64: dts: amlogic: meson-sm1-bananapi-m5: fix adc keys node names
      arm64: dts: amlogic: meson-gxl-s905d-phicomm-n1: fix led node name
      arm64: dts: amlogic: meson-gxbb-kii-pro: fix led node name
      arm64: dts: amlogic: meson-g12b-odroid-go-ultra: fix rk818 pmic pr=
operties
      arm64: dts: amlogic: meson-sm1-odroid-hc4: fix active fan thermal =
trip
      dt-bindings: arm: amlogic: document Odroid-N2L
      arm64: dts: meson-g12b: move common node into new odroid.dtsi
      arm64: dts: meson-g12b-odroid: Add initial support for Hardkernel =
ODROID-N2L
      arm64: dts: qcom: sm8550: fix DSI controller compatible
      arm64: dts: qcom: pmk8550: fix PON compatible
      arm64: dts: qcom: sm8550: remove invalid interconnect property fro=
m cryptobam

Nikita Travkin (1):
      dt-bindings: qcom: Document samsung,gt58 and gt510

Nikolaus Voss (1):
      ARM: dts: imx6qdl: use MAC-address from nvmem

Nitin Yadav (1):
      arm64: dts: ti: k3-am62-main: Update OTAP and ITAP delay select

N=C3=ADcolas F. R. A. Prado (5):
      arm64: dts: mediatek: asurada: Add display regulators
      arm64: dts: mediatek: asurada: Add display backlight
      arm64: dts: mediatek: asurada: Enable internal display
      arm64: dts: mediatek: asurada: Enable audio support
      arm64: dts: mediatek: asurada: Add aliases for i2c and mmc

Olivier Moysan (9):
      ARM: dts: stm32: remove sai kernel clock on stm32mp15xx-dkx
      ARM: dts: stm32: rename sound card on stm32mp15xx-dkx
      ARM: dts: stm32: add i2s nodes on stm32mp131
      ARM: dts: stm32: add sai nodes on stm32mp131
      ARM: dts: stm32: add spdifrx node on stm32mp131
      ARM: dts: stm32: add dfsdm node on stm32mp131
      ARM: dts: stm32: add timers support on stm32mp131
      ARM: dts: stm32: add timer pins muxing for stm32mp135f-dk
      ARM: dts: stm32: add timers support on stm32mp135f-dk

Owen Yang (3):
      dt-bindings: arm: qcom: Add zombie with NVMe
      arm64: dts: qcom: sc7280: Add DT for sc7280-herobrine-zombie with =
NVMe
      arm64: dts: qcom: sc7280: Adjust zombie PWM frequency

Padmanabhan Rajanbabu (4):
      arm64: dts: fsd: fix PUD values as per FSD HW UM
      arm64: dts: fsd: Add I2S DAI node for Tesla FSD
      arm64: dts: fsd: Add codec node for Tesla FSD
      arm64: dts: fsd: Add sound card node for Tesla FSD

Pali Roh=C3=A1r (1):
      arm64: dts: marvell: Fix compatible strings for Armada 3720 boards

Patrick Delaunay (2):
      ARM: dts: stm32: Update part number NVMEM description on stm32mp131
      ARM: dts: stm32: fix compatible for BSEC on STM32MP13

Pavankumar Kondeti (1):
      arm64: dts: qcom: sm8550: fix xo clock source in cpufreq-hw node

Peng Fan (6):
      dt-bindings: soc: imx: add IOMUXC GPR support
      arm64: dts: imx8mq: correct iomuxc-gpr compatible
      arm64: dts: imx8mm: correct iomuxc-gpr compatible
      arm64: dts: imx8mn: update iomuxc-gpr node name
      arm64: dts: imx8mp: use syscon for iomuxc-gpr
      ARM: dts: imx7s: correct iomuxc gpr mux controller cells

Petr Vorel (3):
      arm64: dts: qcom: msm8992-bullhead: Fix cont_splash_mem size
      arm64: dts: qcom: msm8992-bullhead: Disable dfps_data_mem
      arm64: dts: qcom: msm8992-lg-bullhead: Enable regulators

Philippe Schenker (10):
      ARM: dts: apalis-imx6: Disable usb over-current
      ARM: dts: colibri-imx6: Disable usb over-current
      ARM: dts: colibri-imx6ull: Disable usb over-current
      ARM: dts: colibri-imx7: Disable usb over-current
      arm64: dts: verdin-imx8mm: Disable usb over-current
      arm64: dts: imx8mm-verdin-dev: Do not include dahlia dtsi
      arm64: dts: imx8mp-verdin-dev: Do not include dahlia dtsi
      dt-bindings: arm: fsl: Add verdin yavia carrier-board
      arm64: dts: imx8mm-verdin: Add yavia carrier board
      arm64: dts: imx8mp-verdin: Add yavia carrier board

Pierre Gondois (4):
      arm64: dts: exynos: Update cache properties
      arm64: dts: fsd: Update cache properties
      arm64: dts: qcom: Update cache properties
      arm64: dts: Update cache properties for ti

Pin-yen Lin (1):
      arm64: dts: mt8173-elm: Switch to SMC watchdog

Piyush Mehta (1):
      arm64: dts: zynqmp: Add mode-pin GPIO controller DT node

Potin Lai (2):
      ARM: dts: aspeed: bletchley: Rename flash1 label
      ARM: dts: aspeed: bletchley: Enable wdtrst1

Quentin Schulz (1):
      arm64: dts: qcom: msm8998-fxtec: fix touchscreen reset GPIO polari=
ty

Rajendra Nayak (2):
      dt-bindings: arm: qcom: Document the sc7280 CRD Pro boards
      arm64: dts: qcom: sc7280: Add a herobrine CRD Pro SKU

Rayyan Ansari (4):
      ARM: dts: qcom: pm8226: sort includes alphabetically and nodes by =
address
      ARM: dts: qcom: pm8226: add PON device node along with resin sub-n=
ode
      ARM: dts: qcom: pm8226: add IADC node
      ARM: dts: qcom: msm8226: add RPMCC node

Richard Acayan (4):
      arm64: dts: qcom: sdm670: add qfprom node
      arm64: dts: qcom: sdm670: add missing usb hstx nvmem cell
      arm64: dts: qcom: sdm670-google-sargo: keep pm660 ldo8 on
      arm64: dts: qcom: sdm670: add interconnects

Rob Herring (1):
      arm64: dts: qcom: sc7280: Fix CPU nodes compatible string

Robert Foss (5):
      arm64: dts: qcom: sm8350: Add display system nodes
      arm64: dts: qcom: sm8350-hdk: Enable display & dsi nodes
      arm64: dts: qcom: sm8350-hdk: Enable lt9611uxc dsi-hdmi bridge
      arm64: dts: qcom: sm8350: Add &tlmm gpio-line-names
      arm64: dts: qcom: sm8350: Use 2 interconnect cells

Robert Marko (9):
      arm64: dts: qcom: ipq8074: add SoC specific compatible to MDIO
      arm64: dts: qcom: ipq8074: correct USB3 QMP PHY-s clock output nam=
es
      arm64: dts: qcom: ipq8074: fix Gen2 PCIe QMP PHY
      arm64: dts: qcom: ipq8074: fix Gen3 PCIe QMP PHY
      arm64: dts: qcom: ipq8074: correct Gen2 PCIe ranges
      arm64: dts: qcom: ipq8074: set Gen2 PCIe pcie max-link-speed
      arm64: dts: qcom: ipq8074: fix Gen3 PCIe node
      arm64: dts: qcom: ipq8074: correct PCIe QMP PHY output clock names
      arm64: dts: qcom: ipq8074: add QFPROM node

Sam Shih (3):
      arm64: dts: mt7986: add usb related device nodes
      arm64: dts: mt7986: add mmc related device nodes
      arm64: dts: mt7986: add pcie related device nodes

Samuel Holland (15):
      ARM: dts: sun8i: a33: Add DPHY interrupt
      arm64: dts: allwinner: a64: Add DPHY interrupt
      ARM: dts: sunxi: Fix GPIO LED node names
      ARM: dts: sun8i: nanopi-duo2: Fix regulator GPIO reference
      MAINTAINERS: Match the sun20i family of Allwinner SoCs
      dt-bindings: vendor-prefixes: Add Allwinner D1/D1s board vendors
      dt-bindings: riscv: Add Allwinner D1/D1s board compatibles
      riscv: dts: allwinner: Add the D1/D1s SoC devicetree
      riscv: dts: allwinner: Add MangoPi MQ devicetree
      riscv: dts: allwinner: Add Allwinner D1 Nezha devicetree
      riscv: dts: allwinner: Add Sipeed Lichee RV devicetrees
      riscv: dts: allwinner: Add MangoPi MQ Pro devicetree
      riscv: dts: allwinner: Add Dongshan Nezha STU devicetree
      riscv: Add the Allwinner SoC family Kconfig option
      riscv: dts: allwinner: d1: Add power controller node

Sean Anderson (1):
      arm64: ls1046ardb: Use in-band-status for SFP module

Sebastian Reichel (3):
      dt-bindings: soc: rockchip: add initial rk3588 syscon compatibles
      dt-bindings: arm: rockchip: add initial rk3588 boards
      arm64: dts: rockchip: Add rock-5a board

Shazad Hussain (1):
      arm64: dts: qcom: sa8540p-ride: enable pcie2a node

Sibi Sankar (5):
      arm64: dts: qcom: msm8996: Add a carveout for modem metadata
      arm64: dts: qcom: msm8998: Add a carveout for modem metadata
      arm64: dts: qcom: sdm845: Add a carveout for modem metadata
      arm64: dts: qcom: sc7180: Add a carveout for modem metadata
      arm64: dts: qcom: sc7280: Add a carveout for modem metadata

Sicelo A. Mhlongo (2):
      ARM: dts: n900: rename accelerometer node
      ARM: dts: n900: use iio driver for accelerometer

Siddharth Manthan (1):
      arm64: dts: qcom: Add device tree for Samsung Galaxy Tab A 8.0 (20=
15)

Sinthu Raja (3):
      dt-bindings: arm: ti: Add binding for AM68 SK
      arm64: dts: ti: Add initial support for AM68 SK System on Module
      arm64: dts: ti: k3-am68-sk: Add support for AM68 SK base board

Sireesh Kodali (1):
      arm64: dts: qcom: msm8953: Add device tree for Motorola G5 Plus

Souradeep Chowdhury (4):
      arm64: dts: qcom: sm8150: Add Data Capture and Compare(DCC) suppor=
t node
      arm64: dts: qcom: sc7280: Add Data Capture and Compare(DCC) suppor=
t node
      arm64: dts: qcom: sc7180: Add Data Capture and Compare(DCC) suppor=
t node
      arm64: dts: qcom: sdm845: Add Data Capture and Compare(DCC) suppor=
t node

Srinivas Kandagatla (3):
      arm64: dts: qcom: sc8280xp: add gpr node
      arm64: dts: qcom: sc8280xp: add SoundWire and LPASS
      arm64: dts: qcom: sc8280xp-x13s: Add soundcard support

Srinivasa Rao Mandadapu (1):
      arm64: dts: qcom: sc7180: Set performance state for audio

Sriranjani P (6):
      arm64: dts: fsd: add sysreg device node
      arm64: dts: exynos: add dedicated SYSREG compatibles to Exynos850
      arm64: dts: exynos: add dedicated SYSREG compatibles to Exynosauto=
v9
      dt-bindings: soc: samsung: exynos-sysreg: Add tesla FSD sysreg com=
patibles
      dt-bindings: soc: samsung: exynos-sysreg: add dedicated SYSREG com=
patibles to Exynos850
      dt-bindings: soc: samsung: exynos-sysreg: add dedicated SYSREG com=
patibles to Exynosautov9

Steev Klimaszewski (1):
      arm64: dts: qcom: c630: Fix firmware paths

Stefan Eichenberger (1):
      arm64: dts: imx8mm-verdin: enable hpd on hdmi-connector

Stefan Wahren (2):
      dt-bindings: arm: fsl: Fix bindings for APF28Dev board
      dt-bindings: arm: Document the rest of i.MX28 based boards

Steffen Trumtrar (3):
      ARM: dts: zynq: add QSPI controller node
      dt-bindings: altera: Add enclustra mercury PE1
      ARM: dts: socfpga: Add enclustra PE1 devicetree

Stephan Gerhold (2):
      arm64: dts: qcom: msm8916: Enable blsp_dma by default
      arm64: dts: qcom: msm8916: Add DMA for all I2C controllers

Thierry Reding (8):
      arm64: tegra: Fix typo in gpio-ranges property
      arm64: tegra: Fix duplicate regulator on Jetson TX1
      arm64: tegra: Sort includes
      arm64: tegra: Bump #address-cells and #size-cells
      arm64: tegra: Sort nodes by unit-address, then alphabetically
      ARM: tegra: Sort nodes by unit-address, then alphabetically
      arm64: tegra: Drop I2C iommus and dma-coherent properties
      dt-bindings: tegra: Allow #{address,size}-cells =3D <2>

Tomeu Vizoso (3):
      dt-bindings: reset: meson-g12a: Add missing NNA reset
      dt-bindings: power: Add G12A NNA power domain
      arm64: dts: Add DT node for the VIPNano-QI on the A311D

Tomi Valkeinen (2):
      arm64: dts: renesas: r8a779g0: Add display related nodes
      arm64: dts: renesas: white-hawk-cpu: Add DP output support

Vaishnav Achath (1):
      arm64: dts: ti: k3-j7200: Fix wakeup pinmux range

Vignesh Raghavendra (5):
      arm64: dts: ti: k3-am62a-mcu: Add MCU domain peripherals
      arm64: dts: ti: k3-am62a-main: Add more peripheral nodes
      arm64: dts: ti: k3-am62a7-sk: Enable ethernet port
      arm64: dts: ti: k3-am62a7-sk: Enable USB1 node
      arm64: dts: ti: Makefile: Rearrange entries alphabetically

Vinod Koul (5):
      arm64: dts: qcom: sm8450-hdk: Add LT9611uxc HDMI bridge
      arm64: dts: qcom: sm8450-hdk: Enable HDMI Display
      arm64: dts: qcom: sm8450: add spmi node
      arm64: dts: qcom: sm8450-qrd: add pmic files
      arm64: dts: qcom: sm8450-hdk: add pmic files

Vivek Yadav (1):
      arm64: dts: fsd: Add MCAN device node

Vladimir Oltean (2):
      arm64: dts: ls1028a: declare cache-coherent page table walk featur=
e for IOMMU
      arm64: dts: ls1088a: declare cache-coherent page table walk featur=
e for IOMMU

Wadim Egorov (2):
      dt-bindings: arm: ti: Add bindings for PHYTEC AM64x based hardware
      arm64: dts: ti: Add support for phyBOARD-Electra-AM642

Wayne Chang (1):
      arm64: tegra: Enable XUSB host function on Jetson AGX Orin

Wei Fang (1):
      arm64: dts: imx8dxl-evk: Disable hibernation mode of AR8031 for EQ=
OS

Wenhao Cui (3):
      dt-bindings: vendor-prefixes: Document EmbedFire
      dt-bindings: arm: rockchip: Add EmbedFire LubanCat 1
      arm64: dts: rockchip: Add EmbedFire LubanCat 1

Wolfram Sang (1):
      arm64: dts: renesas: condor-i: add HS400 support for eMMC

Yang Xiwen (3):
      dt-bindings: vendor-prefixes: add thwc
      dt-bindings: qcom: Document msm8916-thwc-uf896 and ufi001c
      arm64: dts: qcom: msm8916-thwc: Add initial device trees

Yoshihiro Shimoda (2):
      arm64: dts: renesas: spider-cpu: Enable UFS device
      arm64: dts: renesas: r8a779f0: Add iommus to MMC node

Youghandhar Chintala (1):
      arm64: dts: qcom: sc7280: Add wifi alias for SC7280-idp

Yunlong Jia (1):
      arm64: dts: qcom: sc7180: set ath10k output power calibration stri=
ng

Yuntian Zhang (1):
      arm64: dts: meson: add support for Radxa Zero2

chao zeng (1):
      arm64: dts: ti: iot2050: Add support for M.2 variant

kyrie wu (2):
      arm64: dts: mt8195: add jpeg encode device node
      arm64: dts: mt8195: add jpeg decode device node

Dirstat for brevity:
   0.0% Documentation/devicetree/bindings/arm/aspeed/
   0.0% Documentation/devicetree/bindings/arm/rockchip/
   0.0% Documentation/devicetree/bindings/arm/samsung/
   0.0% Documentation/devicetree/bindings/arm/ti/
   0.4% Documentation/devicetree/bindings/arm/
   0.0% Documentation/devicetree/bindings/bus/
   0.3% Documentation/devicetree/bindings/clock/
   0.0% Documentation/devicetree/bindings/display/tegra/
   0.2% Documentation/devicetree/bindings/interconnect/
   0.0% Documentation/devicetree/bindings/mfd/
   0.0% Documentation/devicetree/bindings/phy/
   0.0% Documentation/devicetree/bindings/power/
   0.1% Documentation/devicetree/bindings/riscv/
   0.0% Documentation/devicetree/bindings/soc/imx/
   0.0% Documentation/devicetree/bindings/soc/renesas/
   0.0% Documentation/devicetree/bindings/soc/rockchip/
   0.1% Documentation/devicetree/bindings/soc/samsung/
   0.0% Documentation/devicetree/bindings/sound/
   0.0% Documentation/devicetree/bindings/
  15.2% arch/arm/boot/dts/
   0.0% arch/arm64/boot/dts/allwinner/
   0.0% arch/arm64/boot/dts/altera/
   0.0% arch/arm64/boot/dts/amazon/
   0.0% arch/arm64/boot/dts/amd/
   2.9% arch/arm64/boot/dts/amlogic/
   0.0% arch/arm64/boot/dts/apm/
   0.0% arch/arm64/boot/dts/broadcom/northstar2/
   0.0% arch/arm64/boot/dts/broadcom/stingray/
   0.2% arch/arm64/boot/dts/exynos/
   4.0% arch/arm64/boot/dts/freescale/
   0.0% arch/arm64/boot/dts/hisilicon/
   0.0% arch/arm64/boot/dts/intel/
   0.0% arch/arm64/boot/dts/marvell/
   3.9% arch/arm64/boot/dts/mediatek/
   0.0% arch/arm64/boot/dts/microchip/
   6.9% arch/arm64/boot/dts/nvidia/
  35.7% arch/arm64/boot/dts/qcom/
   0.0% arch/arm64/boot/dts/realtek/
   2.4% arch/arm64/boot/dts/renesas/
  11.1% arch/arm64/boot/dts/rockchip/
   0.1% arch/arm64/boot/dts/socionext/
   0.0% arch/arm64/boot/dts/synaptics/
   0.3% arch/arm64/boot/dts/tesla/
   5.5% arch/arm64/boot/dts/ti/
   0.0% arch/arm64/boot/dts/xilinx/
   2.4% arch/riscv/boot/dts/allwinner/
   0.0% arch/riscv/boot/dts/canaan/
   0.1% arch/riscv/boot/dts/microchip/
   0.0% arch/riscv/boot/dts/renesas/
   0.0% arch/riscv/boot/dts/sifive/
   0.0% arch/riscv/boot/dts/starfive/
   0.0% arch/riscv/boot/dts/
   0.0% arch/riscv/
   5.0% drivers/interconnect/qcom/
   0.7% include/dt-bindings/clock/
   0.4% include/dt-bindings/interconnect/
   0.0% include/dt-bindings/pinctrl/
   0.0% include/dt-bindings/power/
   0.0% include/dt-bindings/reset/
 890 files changed, 77766 insertions(+), 19113 deletions(-)
