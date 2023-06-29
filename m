Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE22E742966
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 17:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232587AbjF2PWd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 11:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232556AbjF2PW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 11:22:28 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED6BAA
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 08:22:25 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id CBEF13200905;
        Thu, 29 Jun 2023 11:22:24 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 29 Jun 2023 11:22:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1688052144; x=1688138544; bh=CAArRemdiF7p/gCaFAhs1xSgtLO0aMfUWrE
        3eexA4mk=; b=djRfkEZF4ziS+ffyIv3YZnycYHT3Xk4dheqYULGnjVQis5xzrJG
        LY/VMyTAe0m5TWb0/NzO+5NE5uPLQ/MyidFfYh5CK5t3a5yGrcr9+1m/luxqPJKz
        dZEH/i58zybPSQUeTqNP9RWW/sIx+9JYTgcPsc4NlWfbpNc8f6TyUO1mhNmo2+nd
        pvgHGTJpoxx9Dt9OZzzoKVPR63lqKIaXBVjzZ4yKTCx0ekG9rDXglDUbqkHSRiw6
        cbGUZ3jKrBwmixiLO0K5eFHX7ruf1lWQkcHrdvQSsZ6MjE5S+CFM/PPGyi88hoNY
        EJ6ceoy+BwZcUmRF6cEhI9Ty2/Iu9lb+b0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1688052144; x=1688138544; bh=CAArRemdiF7p/gCaFAhs1xSgtLO0aMfUWrE
        3eexA4mk=; b=aYwQjuauIbQ/XV3Zud7N+ZImV9ySnEhqz6SMVMVr4uvNxFK/57s
        3LO9HJrupKdpro6K2HQApTi7262/NZsyIFz0plsqjRXjpnwtURJ9jbvS/BCjbgrM
        EtFMLmP6C3FyDqT2mH3sLMXVfjPLCKyTF7YpFyf+98Hl4bnJO4DQlUA1GRzhO6UL
        ktirvXtAgIkRVoUi6ZBHy1E83biz4u4Tha8nR8msZ2jyhqMWTOYPW3dai8kCmphx
        WRF0MZ4EgVTA83ymweZgUvsS1K00Zm1rZ/ylDcVHZUOltx0bMvACHmxnhnofhMoo
        99ffMDgy9ZCCDiiSwE+pj5QJHvTjfpVnyNQ==
X-ME-Sender: <xms:sKGdZH9IVsp9NLMttk2E8In_4y3AfHedEtZ2KnZgpz92PPvZ4bW-tA>
    <xme:sKGdZDsU6eo5-WbcGuh604dmai6QfI7Ne8bERGnv3TIOVBS5KAu8iwN4PTDewT4-Y
    AhrgQhsQETCEWWT-Cs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrtdeggdekkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepleefheehfeekhfdugeefheeggfdvjefgleeuueegleehuefgffegkeetieef
    heegnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpphgvnhhguhhtrhhonhhigidrug
    gvpdhgihhthhhusgdrtghomhdplhhinhgrrhhordhorhhgnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:sKGdZFD3LjUdOxqcVwkunBnWI7HcTGHJsbTf_b8MI5GYoo7j0-WvMA>
    <xmx:sKGdZDeZ1HmwuZdS9ZWXiIW-hdI2DEqfVcY0lCys3yvGjEy-rlOmHw>
    <xmx:sKGdZMNqJA71YBIDobABGvdJKuuC6G1W_S8Ku73KiAN3vs3Uj3EJ2Q>
    <xmx:sKGdZG302ig-CDcLZYmghxnF0VE9_MHfBicuOrP6B3K4bBQCxli2yg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 1C3C7B60086; Thu, 29 Jun 2023 11:22:23 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-499-gf27bbf33e2-fm-20230619.001-gf27bbf33
Mime-Version: 1.0
Message-Id: <8b646c94-72b3-44c6-81fb-13d069284217@app.fastmail.com>
In-Reply-To: <80fba92e-3836-4d27-8be6-1e5f7b5b2f53@app.fastmail.com>
References: <80fba92e-3836-4d27-8be6-1e5f7b5b2f53@app.fastmail.com>
Date:   Thu, 29 Jun 2023 17:22:02 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Linus Torvalds" <torvalds@linux-foundation.org>
Cc:     soc@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL 3/5] ARM: SoC drivers for 6.5
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

  https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-d=
rivers-6.5

for you to fetch changes up to 356fa4975950d48d12b6ee9f9050ad429db25852:

  Merge tag 'soc-fsl-next-v6.5' of git://git.kernel.org/pub/scm/linux/ke=
rnel/git/leo/linux into soc/drivers (2023-06-27 22:54:34 +0200)

----------------------------------------------------------------
ARM: SoC drivers for 6.5

Nothing surprising in the SoC specific drivers, with the usual updates:

 * Added or improved SoC driver support for Tegra234, Exynos4121, RK3588,
   as well as multiple Mediatek and Qualcomm chips

 * SCMI firmware gains support for multiple SMC/HVC transport and version
   3.2 of the protocol

 * Cleanups amd minor changes for the reset controller, memory controlle=
r,
   firmware and sram drivers

 * Minor changes to amd/xilinx, samsung, tegra, nxp, ti, qualcomm,
   amlogic and renesas SoC specific drivers

----------------------------------------------------------------

NOTE: there is a simple merge conflict between the removal of
an old reset controller driver and the addition of a different
one in the soc-newsoc-6.5 tag.

Aakarsh Jain (1):
      dt-bindings: media: s5p-mfc: convert bindings to json-schema

Alain Volmat (1):
      reset: sti: rely on regmap_field_read_poll_timeout for ack wait

Alexey Romanov (1):
      drivers: meson: secure-pwrc: always enable DMA domain

Allen-KH Cheng (1):
      dt-bindings: spmi: spmi-mtk-pmif: Document mediatek,mt8195-spmi as=
 fallback of mediatek,mt8186-spmi

Andrew F. Davis (1):
      soc: ti: pruss: Add pruss_{request,release}_mem_region() API

AngeloGioacchino Del Regno (8):
      dt-bindings: soc: mediatek: pwrap: Add compatible for MT6795 Helio=
 X10
      soc: mediatek: pwrap: Move PMIC read test sequence in function
      soc: mediatek: pwrap: Add kerneldoc for struct pwrap_slv_type
      soc: mediatek: mtk-pmic-wrap: Add support for companion PMICs
      soc: mediatek: mtk-pmic-wrap: Add support for MT6331 w/ MT6332 com=
panion
      soc: mediatek: pwrap: Add support for MT6795 Helio X10
      dt-bindings: pwm: Add compatible for MediaTek MT6795
      dt-bindings: phy: mediatek,dsi-phy: Add compatible for MT6795 Heli=
o X10

Arnd Bergmann (22):
      Merge tag 'renesas-drivers-for-v6.5-tag1' of git://git.kernel.org/=
pub/scm/linux/kernel/git/geert/renesas-devel into soc/drivers
      Merge tag 'reset-for-v6.5' of git://git.pengutronix.de/pza/linux i=
nto soc/drivers
      arm-cci: add cci_enable_port_for_self prototype
      Merge tag 'sram-for-soc' of git://git.kernel.org/pub/scm/linux/ker=
nel/git/linusw/linux-nomadik into soc/drivers
      Merge tag 'renesas-drivers-for-v6.5-tag2' of git://git.kernel.org/=
pub/scm/linux/kernel/git/geert/renesas-devel into soc/drivers
      Merge tag 'samsung-drivers-6.5' of https://git.kernel.org/pub/scm/=
linux/kernel/git/krzk/linux into soc/drivers
      Merge tag 'omap-for-v6.5/ti-sysc-signed' of git://git.kernel.org/p=
ub/scm/linux/kernel/git/tmlind/linux-omap into soc/drivers
      Merge tag 'zynqmp-soc-for-v6.5' of https://github.com/Xilinx/linux=
-xlnx into soc/drivers
      Merge tag 'tegra-for-6.5-soc' of git://git.kernel.org/pub/scm/linu=
x/kernel/git/tegra/linux into soc/drivers
      Merge tag 'tegra-for-6.5-firmware' of git://git.kernel.org/pub/scm=
/linux/kernel/git/tegra/linux into soc/drivers
      Merge tag 'tegra-for-6.5-memory' of git://git.kernel.org/pub/scm/l=
inux/kernel/git/tegra/linux into soc/drivers
      Merge tag 'tegra-for-6.5-pci' of git://git.kernel.org/pub/scm/linu=
x/kernel/git/tegra/linux into soc/drivers
      Merge tag 'qcom-drivers-for-6.5' of https://git.kernel.org/pub/scm=
/linux/kernel/git/qcom/linux into soc/drivers
      Merge tag 'v6.4-next-soc' of https://git.kernel.org/pub/scm/linux/=
kernel/git/matthias.bgg/linux into soc/drivers
      Merge tag 'qcom-drivers-for-6.5-2' of https://git.kernel.org/pub/s=
cm/linux/kernel/git/qcom/linux into soc/drivers
      Merge tag 'ti-driver-soc-for-v6.5' of https://git.kernel.org/pub/s=
cm/linux/kernel/git/ti/linux into soc/drivers
      Merge tag 'amlogic-drivers-for-v6.5' of https://git.kernel.org/pub=
/scm/linux/kernel/git/amlogic/linux into soc/drivers
      Merge tag 'v6.5-rockchip-drivers1' of git://git.kernel.org/pub/scm=
/linux/kernel/git/mmind/linux-rockchip into soc/drivers
      Merge tag 'scmi-updates-6.5' of git://git.kernel.org/pub/scm/linux=
/kernel/git/sudeep.holla/linux into soc/drivers
      Merge tag 'memory-controller-drv-6.5' of https://git.kernel.org/pu=
b/scm/linux/kernel/git/krzk/linux-mem-ctrl into soc/drivers
      Merge tag 'optee-use-kmemdup-for-6.5' of https://git.linaro.org/pe=
ople/jens.wiklander/linux-tee into soc/drivers
      Merge tag 'soc-fsl-next-v6.5' of git://git.kernel.org/pub/scm/linu=
x/kernel/git/leo/linux into soc/drivers

Artur Weber (2):
      dt-bindings: soc: samsung: exynos-pmu: add Exynos4212 compatible
      soc: samsung: exynos-pmu: Re-introduce Exynos4212 support

Bartosz Golaszewski (1):
      dt-bindings: soc: qcom: aoss-qmp: add compatible for sa8775p

Bhupesh Sharma (1):
      dt-bindings: soc: qcom: eud: Fix compatible string in the example

Bjorn Andersson (1):
      soc: qcom: mdt_loader: Fix split image detection

Boris Brezillon (1):
      soc: rockchip: power-domain: add rk3588 mem module support

Chen-Yu Tsai (1):
      soc: mediatek: SVS: Fix MT8192 GPU node name

Christian Marangi (1):
      soc: qcom: mdt_loader: Fix unconditional call to scm_pas_mem_setup

Claudiu Beznea (1):
      memory: atmel-sdramc: remove the driver

Cristian Marussi (3):
      firmware: arm_scmi: Refactor the internal powercap get/set helpers
      firmware: arm_scmi: Add Powercap protocol enable support
      powercap: arm_scmi: Add support for disabling powercaps on a zone

Dan Carpenter (2):
      driver: soc: xilinx: use _safe loop iterator to avoid a use after =
free
      soc: qcom: Fix a IS_ERR() vs NULL bug in probe

Geert Uytterhoeven (4):
      iopoll: Call cpu_relax() in busy loops
      iopoll: Do not use timekeeping in read_poll_timeout_atomic()
      Merge tag 'iopoll-busy-loop-timeout-tag' into renesas-drivers-for-=
v6.5
      soc: renesas: rmobile-sysc: Convert to readl_poll_timeout_atomic()

Gokul krishna Krishnakumar (1):
      soc: qcom: mdt_loader: Enhance split binary detection

Heiner Kallweit (2):
      MAINTAINERS: add PHY-related files to Amlogic SoC file list
      dt-bindings: interrupt-controller: Convert Amlogic Meson GPIO inte=
rrupt controller binding

Jason-JH.Lin (1):
      soc: mediatek: remove DDP_DOMPONENT_DITHER from enum

Jiapeng Chong (2):
      soc: mediatek: mtk-mutex: Remove unnecessary .owner
      tee: optee: Use kmemdup() to replace kmalloc + memcpy

Kartik (1):
      soc/tegra: fuse: Fix Tegra234 fuse size

Kathiravan T (4):
      dt-bindings: arm: qcom,ids: add SoC ID for IPQ5312 and IPQ5302
      soc: qcom: socinfo: Add Soc ID for IPQ5312 and IPQ5302
      dt-bindings: arm: qcom,ids: add SoC ID for IPQ5300
      soc: qcom: socinfo: Add Soc ID for IPQ5300

Komal Bajaj (1):
      dt-bindings: sram: qcom,imem: document qdu1000

Konrad Dybcio (5):
      dt-bindings: soc: qcom: Add RPM Master stats
      soc: qcom: Introduce RPM master stats driver
      MAINTAINERS: Add Konrad Dybcio as linux-arm-msm co-maintainer
      dt-bindings: soc: qcom,rpmh-rsc: Require power-domains
      soc: qcom: icc-bwmon: Fix MSM8998 count unit

Krzysztof Kozlowski (3):
      dt-bindings: soc: qcom: smd-rpm: allow MSM8226 over SMD
      memory: brcmstb_dpfe: fix testing array offset after use
      dt-bindings: memory-controllers: drop unneeded quotes

Linus Walleij (2):
      dt-bindings: sram: Add compatible for ST-Ericsson U8500 eSRAM
      misc: sram: Generate unique names for subpools

Luca Weiss (1):
      soc: qcom: ocmem: Add OCMEM hardware version print

Lukas Bulwahn (1):
      reset: sti: simplify driver's config and build

Matti Lehtim=C3=A4ki (1):
      dt-bindings: sram: qcom,imem: Document MSM8226

Michal Simek (2):
      MAINTAINERS: Remove Hyun and Anurag from maintainer list
      MAINTAINERS: Switch to @amd.com emails

Min-Hua Chen (1):
      soc: qcom: rpmpd: use correct __le32 type

Naman Jain (2):
      soc: qcom: socinfo: Add support for new fields in revision 18
      soc: qcom: socinfo: Add support for new fields in revision 19

Nava kishore Manne (1):
      firmware: xilinx: Update the zynqmp_pm_fpga_load() API

Neil Armstrong (2):
      reset: oxnas: remove obsolete reset driver
      qcom: pmic_glink: enable altmode for SM8450

Nikunj Kela (2):
      dt-bindings: firmware: arm,scmi: support for parameter in smc/hvc =
call
      firmware: arm_scmi: Augment SMC/HVC to allow optional parameters

Osama Muhammad (1):
      wkup_m3_ipc.c: Fix error checking for debugfs_create_dir

Peter De Schrijver (1):
      firmware: tegra: bpmp: Add support for DRAM MRQ GSCs

Philipp Zabel (2):
      reset: starfive: select AUXILIARY_BUS
      reset: mpfs: select AUXILIARY_BUS

Randy Dunlap (2):
      soc/fsl/qe: fix usb.c build errors
      soc: rockchip: dtpm: use C99 array init syntax

Rob Herring (1):
      soc: xilinx: Use of_property_present() for testing DT property pre=
sence

Robert Marko (7):
      dt-bindings: arm: qcom,ids: Add IDs for IPQ5018 family
      soc: qcom: socinfo: Add IDs for IPQ5018 family
      soc: qcom: socinfo: move SMEM item struct and defines to a header
      soc: qcom: smem: Switch to EXPORT_SYMBOL_GPL()
      soc: qcom: smem: introduce qcom_smem_get_soc_id()
      cpufreq: qcom-nvmem: use SoC ID-s from bindings
      cpufreq: qcom-nvmem: use helper to get SMEM SoC ID

Rohit Agarwal (1):
      dt-bindings: firmware: scm: Add compatible for SDX75

Sebastian Reichel (2):
      dt-bindings: soc: rockchip: add rk3588 usb2phy syscon
      dt-bindings: soc: rockchip: add rk3588 pipe-phy syscon

Shubhi Garg (1):
      dt-bindings: tegra: Document compatible for IGX

Simon Horman (2):
      soc: ti: pruss: Avoid cast to incompatible function type
      soc: ti: pruss: Allow compile-testing

Stefan Kristiansson (1):
      soc/tegra: fuse: Add support for Tegra264

Suman Anna (2):
      soc: ti: pruss: Add pruss_cfg_read()/update(), pruss_cfg_get_gpmux=
()/set_gpmux() APIs
      soc: ti: pruss: Add helper functions to set GPI mode, MII_RT_event=
 and XFR

Sumit Gupta (7):
      dt-bindings: tegra: Add ICC IDs for dummy memory clients
      memory: tegra: Add interconnect support for DRAM scaling in Tegra2=
34
      memory: tegra: Add memory clients for Tegra234
      memory: tegra: Add software memory clients in Tegra234
      memory: tegra: Make CPU cluster BW request a multiple of MC channe=
ls
      PCI: tegra194: Fix possible array out of bounds access
      PCI: tegra194: Add interconnect support in Tegra234

Tejun Heo (1):
      soc: qcom: qmi: Use alloc_ordered_workqueue() to create ordered wo=
rkqueues

Tero Kristo (1):
      soc: ti: pruss: Add pruss_get()/put() API

Thierry Reding (4):
      Merge branch 'for-6.5/dt-bindings' into for-6.5/memory
      Merge branch 'for-6.5/memory' into for-6.5/pci
      soc/tegra: pmc: Simplify debugfs initialization
      soc/tegra: pmc: Use devm_clk_notifier_register()

Tony Lindgren (1):
      bus: ti-sysc: Fix dispc quirk masking bool variables

Uwe Kleine-K=C3=B6nig (9):
      soc: qcom: ramp_controller: Improve error message for failure in .=
remove()
      bus: fsl-mc: Only warn once about errors on device unbind
      bus: fsl-mc: dprc: Push down error message from fsl_mc_driver_remo=
ve()
      bus: fsl-mc: fsl-mc-allocator: Drop if block with always wrong con=
dition
      bus: fsl-mc: fsl-mc-allocator: Improve error reporting
      soc: fsl: dpio: Suppress duplicated error reporting on device remo=
ve
      bus: fsl-mc: Make remove function return void
      bus: fsl-mc: fsl-mc-allocator: Initialize mc_bus_dev before use
      bus: fsl-mc: fsl-mc-allocator: Drop a write-only variable

Vijaya Krishna Nivarthi (1):
      soc: qcom: geni-se: Do not bother about enable/disable of interrup=
ts in secondary sequencer

Viswanath L (1):
      soc/tegra: pmc: Add AON SW Wake support for Tegra234

Wolfram Sang (2):
      memory: renesas-rpc-if: Fix PHYCNT.STRTIM setting
      soc: renesas: rcar-rst: Allow WDT reset on R-Car V3U

Yang Li (1):
      soc: ti: smartreflex: Use devm_platform_ioremap_resource()

Ye Xingchen (7):
      reset: ath79: Use devm_platform_ioremap_resource()
      reset: axs10x: Use devm_platform_ioremap_resource()
      reset: lpc18xx: Use devm_platform_ioremap_resource()
      reset: reset-hsdk: Use devm_platform_ioremap_resource()
      reset: meson: Use devm_platform_ioremap_resource()
      reset: brcmstb-rescal: Use devm_platform_ioremap_resource()
      reset: meson-audio-arb: Use dev_err_probe()

 Documentation/devicetree/bindings/arm/tegra.yaml   |   5 +
 .../devicetree/bindings/firmware/arm,scmi.yaml     |   8 +-
 .../devicetree/bindings/firmware/qcom,scm.yaml     |   1 +
 .../amlogic,meson-gpio-intc.txt                    |  38 --
 .../amlogic,meson-gpio-intc.yaml                   |  72 +++
 .../devicetree/bindings/media/s5p-mfc.txt          |  78 ---
 .../devicetree/bindings/media/samsung,s5p-mfc.yaml | 184 +++++++
 .../memory-controllers/nvidia,tegra20-emc.yaml     |   2 +-
 .../bindings/memory-controllers/ti,gpmc.yaml       |   2 +-
 .../devicetree/bindings/phy/mediatek,dsi-phy.yaml  |   4 +
 .../devicetree/bindings/pwm/mediatek,pwm-disp.yaml |   4 +-
 .../devicetree/bindings/reset/oxnas,reset.txt      |  32 --
 .../bindings/soc/mediatek/mediatek,pwrap.yaml      |   1 +
 .../bindings/soc/qcom/qcom,aoss-qmp.yaml           |   1 +
 .../devicetree/bindings/soc/qcom/qcom,eud.yaml     |   4 +-
 .../bindings/soc/qcom/qcom,rpm-master-stats.yaml   |  69 +++
 .../bindings/soc/qcom/qcom,rpmh-rsc.yaml           |   2 +
 .../devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml |   1 +
 .../devicetree/bindings/soc/rockchip/grf.yaml      |   3 +
 .../bindings/soc/samsung/exynos-pmu.yaml           |   5 +
 .../bindings/spmi/mtk,spmi-mtk-pmif.yaml           |  11 +-
 .../devicetree/bindings/sram/qcom,imem.yaml        |   2 +
 Documentation/devicetree/bindings/sram/sram.yaml   |   1 +
 MAINTAINERS                                        |  20 +-
 arch/arm/mach-at91/Kconfig                         |   4 -
 drivers/bus/fsl-mc/dprc-driver.c                   |  12 +-
 drivers/bus/fsl-mc/fsl-mc-allocator.c              |  35 +-
 drivers/bus/fsl-mc/fsl-mc-bus.c                    |   7 +-
 drivers/bus/ti-sysc.c                              |   4 +-
 drivers/cpufreq/qcom-cpufreq-nvmem.c               |  63 +--
 drivers/crypto/caam/caamalg_qi2.c                  |   4 +-
 drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c            |   4 +-
 drivers/firmware/arm_scmi/driver.c                 |   1 +
 drivers/firmware/arm_scmi/powercap.c               | 173 +++++-
 drivers/firmware/arm_scmi/smc.c                    |  30 +-
 drivers/firmware/tegra/bpmp-tegra186.c             | 204 +++++--
 drivers/firmware/tegra/bpmp.c                      |   4 +-
 drivers/firmware/xilinx/zynqmp.c                   |  12 +-
 drivers/memory/Kconfig                             |  11 -
 drivers/memory/Makefile                            |   1 -
 drivers/memory/atmel-sdramc.c                      |  74 ---
 drivers/memory/brcmstb_dpfe.c                      |   4 +-
 drivers/memory/renesas-rpc-if.c                    |  53 +-
 drivers/memory/tegra/mc.c                          |  24 +
 drivers/memory/tegra/mc.h                          |   1 +
 drivers/memory/tegra/tegra186-emc.c                | 133 +++++
 drivers/memory/tegra/tegra234.c                    | 595 ++++++++++++++=
++++++-
 drivers/misc/sram.c                                |   9 +-
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c   |   4 +-
 drivers/net/ethernet/freescale/dpaa2/dpaa2-ptp.c   |   4 +-
 .../net/ethernet/freescale/dpaa2/dpaa2-switch.c    |   4 +-
 drivers/pci/controller/dwc/pcie-tegra194.c         |  44 +-
 drivers/powercap/arm_scmi_powercap.c               |  16 +
 drivers/remoteproc/pru_rproc.c                     |  15 -
 drivers/reset/Kconfig                              |   6 +-
 drivers/reset/Makefile                             |   1 -
 drivers/reset/reset-ath79.c                        |   4 +-
 drivers/reset/reset-axs10x.c                       |   4 +-
 drivers/reset/reset-brcmstb-rescal.c               |   4 +-
 drivers/reset/reset-hsdk.c                         |   7 +-
 drivers/reset/reset-lpc18xx.c                      |   4 +-
 drivers/reset/reset-meson-audio-arb.c              |   7 +-
 drivers/reset/reset-meson.c                        |   4 +-
 drivers/reset/reset-oxnas.c                        | 114 ----
 drivers/reset/starfive/Kconfig                     |   3 +-
 drivers/reset/sti/Kconfig                          |   4 -
 drivers/reset/sti/Makefile                         |   4 +-
 drivers/reset/sti/reset-syscfg.c                   |  18 +-
 drivers/soc/amlogic/meson-secure-pwrc.c            |   2 +-
 drivers/soc/fsl/dpio/dpio-driver.c                 |   8 +-
 drivers/soc/fsl/qe/Kconfig                         |   1 +
 drivers/soc/mediatek/mtk-mutex.c                   |   1 -
 drivers/soc/mediatek/mtk-pmic-wrap.c               | 292 +++++++++-
 drivers/soc/mediatek/mtk-svs.c                     |   4 +-
 drivers/soc/qcom/Kconfig                           |  11 +
 drivers/soc/qcom/Makefile                          |   1 +
 drivers/soc/qcom/icc-bwmon.c                       |   2 +-
 drivers/soc/qcom/mdt_loader.c                      |  49 +-
 drivers/soc/qcom/ocmem.c                           |  10 +
 drivers/soc/qcom/pmic_glink.c                      |   8 +-
 drivers/soc/qcom/qcom-geni-se.c                    |  28 +-
 drivers/soc/qcom/qmi_interface.c                   |   2 +-
 drivers/soc/qcom/ramp_controller.c                 |  11 +-
 drivers/soc/qcom/rpm_master_stats.c                | 163 ++++++
 drivers/soc/qcom/rpmpd.c                           |   4 +-
 drivers/soc/qcom/smem.c                            |  31 +-
 drivers/soc/qcom/socinfo.c                         | 111 ++--
 drivers/soc/renesas/rcar-rst.c                     |  15 +-
 drivers/soc/renesas/rmobile-sysc.c                 |  29 +-
 drivers/soc/rockchip/dtpm.c                        |  54 +-
 drivers/soc/rockchip/pm_domains.c                  | 160 ++++--
 drivers/soc/samsung/exynos-pmu.c                   |   9 +
 drivers/soc/samsung/exynos-pmu.h                   |   2 +
 drivers/soc/samsung/exynos4-pmu.c                  |  13 +-
 drivers/soc/tegra/fuse/fuse-tegra30.c              |   2 +-
 drivers/soc/tegra/fuse/tegra-apbmisc.c             |   3 +-
 drivers/soc/tegra/pmc.c                            |  31 +-
 drivers/soc/ti/Kconfig                             |   2 +-
 drivers/soc/ti/pruss.c                             | 263 ++++++++-
 drivers/soc/ti/pruss.h                             |  88 +++
 drivers/soc/ti/smartreflex.c                       |   4 +-
 drivers/soc/ti/wkup_m3_ipc.c                       |   2 +-
 drivers/soc/xilinx/xlnx_event_manager.c            |   6 +-
 drivers/soc/xilinx/zynqmp_power.c                  |   4 +-
 drivers/tee/optee/smc_abi.c                        |   3 +-
 drivers/vfio/fsl-mc/vfio_fsl_mc.c                  |   3 +-
 include/dt-bindings/arm/qcom,ids.h                 |  11 +
 include/dt-bindings/memory/tegra234-mc.h           |   5 +
 include/linux/arm-cci.h                            |   2 +
 include/linux/fsl/mc.h                             |   2 +-
 include/linux/iopoll.h                             |  24 +-
 include/linux/pruss_driver.h                       | 123 +++++
 include/linux/scmi_protocol.h                      |  18 +
 include/linux/soc/mediatek/mtk-mmsys.h             |   3 +-
 include/linux/soc/qcom/smem.h                      |   2 +
 include/linux/soc/qcom/socinfo.h                   |  77 +++
 include/linux/tegra-icc.h                          |  65 +++
 include/soc/tegra/fuse.h                           |   3 +-
 include/soc/tegra/mc.h                             |   8 +
 119 files changed, 3112 insertions(+), 946 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/interrupt-controll=
er/amlogic,meson-gpio-intc.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controll=
er/amlogic,meson-gpio-intc.yaml
 create mode 100644 Documentation/devicetree/bindings/media/samsung,s5p-=
mfc.yaml
 delete mode 100644 Documentation/devicetree/bindings/reset/oxnas,reset.=
txt
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,rpm-=
master-stats.yaml
 delete mode 100644 drivers/memory/atmel-sdramc.c
 delete mode 100644 drivers/reset/reset-oxnas.c
 create mode 100644 drivers/soc/qcom/rpm_master_stats.c
 create mode 100644 drivers/soc/ti/pruss.h
 create mode 100644 include/linux/soc/qcom/socinfo.h
 create mode 100644 include/linux/tegra-icc.h
