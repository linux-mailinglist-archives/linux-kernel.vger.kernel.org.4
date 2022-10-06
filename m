Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4847B5F6390
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 11:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231317AbiJFJY3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 05:24:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbiJFJYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 05:24:25 -0400
Received: from new4-smtp.messagingengine.com (new4-smtp.messagingengine.com [66.111.4.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 679749836C
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 02:24:22 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 1563A5809FA;
        Thu,  6 Oct 2022 05:24:21 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Thu, 06 Oct 2022 05:24:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1665048261; x=
        1665051861; bh=99xCyZsSMA0lcCc1PMzntlBoFK5d/a+TON1dfl9DASA=; b=r
        d2FsWMiF9LbTUs+/uCP/rxKjG1pPss3Tv18zJhj+a5FOjtNwV9CACBmGHt1OEqW1
        uOubXUBYfE8csLIfIkDB1Aql9BDBHCNLhMpFxNXoa2ZiB0i/lEnJlp3vh5bsAddU
        nYLaYRAsnFe0a3sNkLYYCsP7h/te9rg76H9qvji2h1Yw905VKAP73ryJv1Q80Vj0
        +yI2t8dI8Mwyb9yPpccNm5dDIN5su5jQWZrxQJj/C5f+hsWItfB5LOdUm4a4kK74
        lftNt4gp4l9iqkM7GAjhCYgsacT+EyyYs06lIq4rPaqNkgmd8FL1flUdBq40DIhz
        luIfAW3Iv457cYq6YsJxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1665048261; x=
        1665051861; bh=99xCyZsSMA0lcCc1PMzntlBoFK5d/a+TON1dfl9DASA=; b=0
        E3OKEmZZI10J1uytTarq10wHWoq+o6ho3TrF0GMauCXLU4v+iH+wMIrInSfHTFfc
        LmzUvYIpowvbvTnOGIICBbcZF6PM2ZsvNaEGZNg2P1sNS0Ttizpv0RvOj1OfbjgB
        DiUa1PFCcNdIKKzfybgFWOpy/r6glxgMmv820/AInFo1L/loVgHDmOem9woz+1MV
        P/MNqkeDXLpkKQwaEfHUf2umdl9epEqaXbmVRP5UUFx3m/vwZ08UDhilF8MZZRKT
        AL6WmWzg1tZuZmmLfie1i/1xFuCOJXSBBjxIlASJqflhorUR2Z3Aa454Zl5fIB2O
        KytiVdRNnlfCZgG8Bd/3Q==
X-ME-Sender: <xms:xJ4-Y8ES7PUUMTB7yVSeabQlxp58RrSnvAKDUv8r_f5svLlo0DcMRA>
    <xme:xJ4-Y1V-P77sGGw4DBWezmVduJ1AerK7TR8iQwcXmtvn6JUC64BOb8bRjZbinKP0Q
    ov-LgkKOm_ab9zaHMk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeeihedgudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpedvhfffheejvdfghfejuddvfffghfejhfeguedvieevkefgvdfgtdevveek
    tedugfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhgihhthhhusgdrtghomhdptg
    houggvrghurhhorhgrrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:xJ4-Y2KARTDLDyKLMdAmTF2flwRSSNYaLCpeZJrY2YGVvGu8LgeMMQ>
    <xmx:xJ4-Y-EhK5oQqlk77AZCT2tci30OzwkmFLb-NVTJsanZhralVThR1w>
    <xmx:xJ4-YyVXffr39PFIDCw7g70niix4SKTF6eX36sxlQGUWZ3R02sWnUA>
    <xmx:xJ4-Y1codmkjuLVkrpm0VURt2e0Bi4otl_xD0OoormGy3C2YxTLn7Q>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 5BC76B60089; Thu,  6 Oct 2022 05:24:20 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1015-gaf7d526680-fm-20220929.001-gaf7d5266
Mime-Version: 1.0
Message-Id: <7eea916e-4757-4c17-8a49-c67267ab7ea7@app.fastmail.com>
In-Reply-To: <70d8e5d8-6fa4-496d-88d6-2604d0c3e982@app.fastmail.com>
References: <70d8e5d8-6fa4-496d-88d6-2604d0c3e982@app.fastmail.com>
Date:   Thu, 06 Oct 2022 11:23:59 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Linus Torvalds" <torvalds@linux-foundation.org>
Cc:     soc@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL 2/4] ARM: SoC driver updates for 6.1
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
rivers-6.1

for you to fetch changes up to 4413794917ba3ff42ade432870248b500253f152:

  ARM: remove check for CONFIG_DEBUG_LL_SER3 (2022-09-28 22:39:21 +0200)

----------------------------------------------------------------
ARM: driver updates for 6.1

The drivers branch for 6.1 is a bit larger than for most releases.  Most
of the changes come from SoC maintainers for the drivers/soc subsystem:

 - A new driver for error handling on the NVIDIA Tegra
   'control backbone' bus.

 - A new driver for Qualcomm LLCC/DDR bandwidth measurement

 - New Rockchip rv1126 and rk3588 power domain drivers

 - DT binding updates for memory controllers, older Rockchip
   SoCs, various Mediatek devices, Qualcomm SCM firmware

 - Minor updates to Hisilicon LPC bus, the Allwinner SRAM
   driver, the Apple rtkit firmware driver, Tegra firmware

 - Minor updates for SoC drivers (Samsung, Mediatek, Renesas,
   Tegra, Qualcomm, Broadcom, NXP, ...)

There are also some separate subsystem with downstream maintainers that
merge updates this way:

 - Various updates and new drivers in the memory controller
   subsystem for Mediatek and Broadcom SoCs

 - Small set of changes in preparation to add support for FF-A
   v1.1 specification later, in the Arm FF-A firmware subsystem

 - debugfs support in the PSCI firmware subsystem

----------------------------------------------------------------
Abel Vesa (2):
      soc: qcom: stats: Add SDM845 stats config and compatible
      dt-bindings: soc: qcom: stats: Document SDM845 compatible

Adam Skladowski (1):
      dt-bindings: firmware: document Qualcomm SM6115 SCM

Allen-KH Cheng (2):
      dt-bindings: soc: mediatek: Add mdp3 mutex support for mt8186
      soc: mediatek: mutex: Add mt8186 mutex mod settings for mdp3

Andy Shevchenko (4):
      bus: hisi_lpc: Don't dereference fwnode handle
      bus: hisi_lpc: Use devm_platform_ioremap_resource
      bus: hisi_lpc: Correct error code for timeout
      bus: hisi_lpc: Don't guard ACPI IDs with ACPI_PTR()

AngeloGioacchino Del Regno (8):
      soc: mediatek: mtk-svs: Switch to platform_get_irq()
      soc: mediatek: mtk-svs: Remove hardcoded irqflags
      soc: mediatek: mtk-svs: Drop of_match_ptr() for of_match_table
      soc: mediatek: mtk-svs: Use devm variant for dev_pm_opp_of_add_tab=
le()
      soc: mediatek: mtk-svs: Commonize t-calibration-data fuse array re=
ad
      soc: mediatek: mtk-svs: Use bitfield access macros where possible
      dt-bindings: soc: mediatek: Add display mutex support for MT6795
      soc: mediatek: mutex: Add support for MT6795 Helio X10 display mut=
ex

Arnd Bergmann (19):
      Merge tag 'renesas-drivers-for-v6.1-tag1' of git://git.kernel.org/=
pub/scm/linux/kernel/git/geert/renesas-devel into arm/drivers
      Merge tag 'amlogic-drivers-for-v6.1' of git://git.kernel.org/pub/s=
cm/linux/kernel/git/amlogic/linux into arm/drivers
      Merge tag 'memory-controller-drv-6.1' of https://git.kernel.org/pu=
b/scm/linux/kernel/git/krzk/linux-mem-ctrl into arm/drivers
      Merge tag 'memory-controller-drv-brcm-6.1' of https://git.kernel.o=
rg/pub/scm/linux/kernel/git/krzk/linux-mem-ctrl into arm/drivers
      Merge tag 'memory-controller-drv-mediatek-6.1' of https://git.kern=
el.org/pub/scm/linux/kernel/git/krzk/linux-mem-ctrl into arm/drivers
      Merge tag 'v6.1-rockchip-drivers1' of git://git.kernel.org/pub/scm=
/linux/kernel/git/mmind/linux-rockchip into arm/drivers
      Merge tag 'samsung-drivers-6.1' of https://git.kernel.org/pub/scm/=
linux/kernel/git/krzk/linux into arm/drivers
      Merge tag 'arm-soc/for-6.1/drivers' of https://github.com/Broadcom=
/stblinux into arm/drivers
      Merge tag 'ffa-updates-6.1' of git://git.kernel.org/pub/scm/linux/=
kernel/git/sudeep.holla/linux into arm/drivers
      Merge tag 'tegra-for-6.1-soc' of git://git.kernel.org/pub/scm/linu=
x/kernel/git/tegra/linux into arm/drivers
      Merge tag 'tegra-for-6.1-firmware' of git://git.kernel.org/pub/scm=
/linux/kernel/git/tegra/linux into arm/drivers
      Merge tag 'imx-drivers-6.1' of git://git.kernel.org/pub/scm/linux/=
kernel/git/shawnguo/linux into arm/drivers
      Merge tag 'sunxi-drivers-for-6.1-1' of https://git.kernel.org/pub/=
scm/linux/kernel/git/sunxi/linux into arm/drivers
      Merge tag 'v6.0-next-soc' of https://git.kernel.org/pub/scm/linux/=
kernel/git/matthias.bgg/linux into arm/drivers
      Merge tag 'qcom-drivers-for-6.1' of https://git.kernel.org/pub/scm=
/linux/kernel/git/qcom/linux into arm/drivers
      Merge tag 'hisi-drivers-for-6.1' of https://github.com/hisilicon/l=
inux-hisi into arm/drivers
      Merge tag 'tegra-for-6.1-cbb' of git://git.kernel.org/pub/scm/linu=
x/kernel/git/tegra/linux into arm/drivers
      Merge tag 'v6.1-rockchip-drivers2' of git://git.kernel.org/pub/scm=
/linux/kernel/git/mmind/linux-rockchip into arm/drivers
      Merge tag 'memory-controller-drv-6.1-2' of https://git.kernel.org/=
pub/scm/linux/kernel/git/krzk/linux-mem-ctrl into arm/drivers

Bjorn Andersson (1):
      Merge tag '20220825043859.30066-3-manivannan.sadhasivam@linaro.org=
' into drivers-for-6.1

Chengci.Xu (4):
      dt-bindings: memory: mediatek: Add mt8188 smi binding
      memory: mtk-smi: Add return value for configure port function
      memory: mtk-smi: Add enable IOMMU SMC command for MM master
      memory: mtk-smi: mt8188: Add SMI Support

Christophe JAILLET (2):
      soc: mediatek: pm-domains: Simplify some error message
      soc/tegra: pmc: Use devm_clk_get_optional()

David Heidelberg (1):
      dt-bindings: firmware: convert Qualcomm SCM binding to the yaml

Debarati Biswas (1):
      memory: dfl-emif: Update the dfl emif driver support revision 1

Dmitry Baryshkov (2):
      firmware/psci: Print a warning if PSCI doesn't accept PC mode
      firmware/psci: Add debugfs support to ease debugging

Dmitry Osipenko (1):
      soc/tegra: fuse: Drop Kconfig dependency on TEGRA20_APB_DMA

Elaine Zhang (1):
      soc: rockchip: power-domain: do not enable domain when adding it

Finley Xiao (2):
      dt-bindings: power: add power-domain header for rk3588
      soc: rockchip: power-domain: add power domain support for rk3588

Florian Fainelli (3):
      dt-bindings: memory-controller: Document Broadcom STB MEMC
      Documentation: sysfs: Document Broadcom STB memc sysfs knobs
      memory: brcmstb_memc: Add Broadcom STB memory controller driver

Frank Wunderlich (1):
      dt-bindings: soc: grf: add pcie30-{phy,pipe}-grf

Frieder Schrempf (3):
      dt-bindings: arm: fsl: imx6ul-kontron: Update bindings
      dt-bindings: arm: fsl: Rename compatibles for Kontron i.MX8MM SoM/=
board
      dt-bindings: arm: fsl: Add Kontron BL i.MX8MM OSM-S board

Gaosheng Cui (1):
      firmware: qcom: scm: remove unused __qcom_scm_init declaration

Geert Uytterhoeven (1):
      soc: renesas: Identify R-Car H3Ne-1.7G

Guilherme G. Piccoli (1):
      soc: bcm: brcmstb: Document panic notifier action and remove usele=
ss header

Hector Martin (1):
      soc: apple: rtkit: Add apple_rtkit_poll

Heiko Stuebner (2):
      Merge branch 'v6.1-shared/powerdomain' into v6.1-armsoc/drivers
      Merge branch 'v6.1-shared/powerdomain' into v6.1-armsoc/drivers

Jagan Teki (6):
      dt-bindings: power: Add power-domain header for RV1126
      dt-bindings: power: rockchip: Document RV1126 power-controller
      soc: rockchip: power-domain: Add RV1126 power domains
      dt-bindings: power: rockchip: Document RV1126 PMU IO domains
      dt-bindings: soc: rockchip: Document RV1126 grf
      dt-bindings: soc: rockchip: Document RV1126 pmugrf

Jean Delvare (1):
      soc: mediatek: Let PMIC Wrapper and SCPSYS depend on OF

Jeff Johnson (1):
      soc: qcom: qmi: use const for struct qmi_elem_info

Jianqun Xu (1):
      soc: rockchip: io-domain: Add RV1126 IO domains

Jinpeng Cui (1):
      soc: qcom: icc-bwmon: remove redundant ret variable

Johan Jonker (2):
      dt-bindings: arm: rockchip: pmu: add rockchip,rk3128-pmu
      dt-bindings: soc: rockchip: grf: add rockchip,rk3128-grf

John Garry (1):
      bus: hisi_lpc: Use platform_device_register_full()

Konrad Dybcio (4):
      soc: qcom: socinfo: Add an ID for SM6375
      soc: qcom: socinfo: Add PM6125 ID
      dt-bindings: power: rpmpd: Add SM6375 power domains
      soc: qcom: rpmpd: Add SM6375 support

Krzysztof Kozlowski (13):
      dt-bindings: interconnect: qcom,msm8998-bwmon: add support for SDM=
845 LLCC BWMON
      soc: qcom: icc-bwmon: re-use IRQ enable/clear define
      soc: qcom: icc-bwmon: drop unused registers
      soc: qcom: icc-bwmon: store reference to variant data in container
      soc: qcom: icc-bwmon: clear all registers on init
      soc: qcom: icc-bwmon: store count unit per variant
      soc: qcom: icc-bwmon: use regmap and prepare for BWMON v5
      soc: qcom: icc-bwmon: add per-variant quirks
      soc: qcom: icc-bwmon: add support for SDM845 LLCC BWMON
      dt-bindings: media: samsung,exynos5250-gsc: convert to dtschema
      MAINTAINERS: pwm-fan: Drop Bartlomiej Zolnierkiewicz
      MAINTAINERS: Drop Bartlomiej Zolnierkiewicz
      dt-bindings: power: qcom,rpmpd: drop non-working codeaurora.org em=
ails

Lad Prabhakar (2):
      soc: renesas: Kconfig: Enable IRQC driver for RZ/G2L SoC
      soc: renesas: Identify RZ/Five SoC

Liang He (8):
      memory: pl353-smc: Fix refcount leak bug in pl353_smc_probe()
      memory: of: Fix refcount leak bug in of_get_ddr_timings()
      memory: of: Fix refcount leak bug in of_lpddr3_get_ddr_timings()
      soc: qcom: smsm: Fix refcount leak bugs in qcom_smsm_probe()
      soc: qcom: smem_state: Add refcounting for the 'state->of_node'
      soc: amlogic: meson-pwrc: Hold reference returned by of_get_parent=
()
      soc/tegra: fuse: Add missing of_node_put() in tegra_init_fuse()
      soc/tegra: fuse: Add missing of_node_put()

Lucas Stach (1):
      soc: imx: imx8mp-blk-ctrl: handle PCIe PHY resets

Manivannan Sadhasivam (2):
      soc: qcom: llcc: Rename reg_offset structs to reflect LLCC version
      soc: qcom: llcc: Pass LLCC version based register offsets to EDAC =
driver

Marcel Ziswiler (1):
      dt-bindings: clk: imx8mm: don't use multiple blank lines

Martyn Welch (1):
      dt-bindings: arm: fsl: Add MSC SM2S-IMX8PLUS SoM and SM2-MB-EP1 Ca=
rrier

N=C3=ADcolas F. R. A. Prado (1):
      soc: mediatek: mtk-svs: Explicitly include bitfield header

Paul Bolle (1):
      ARM: remove check for CONFIG_DEBUG_LL_SER3

Peng Fan (17):
      dt-bindings: soc: imx: add interconnect property for i.MX8MP media=
 blk ctrl
      dt-bindings: soc: imx: add interconnect property for i.MX8MP hdmi =
blk ctrl
      dt-bindings: soc: imx: add interconnect property for i.MX8MP hsio =
blk ctrl
      dt-bindings: power: imx8mp-power: add HDMI HDCP/HRV
      dt-bindings: soc: imx: drop minItems for i.MX8MM vpu blk ctrl
      dt-bindings: soc: imx: add interconnect property for i.MX8MM vpu b=
lk ctrl
      dt-bindings: soc: imx: add i.MX8MP vpu blk ctrl
      dt-bindings: mfd: syscon: Add i.MX93 blk ctrl system registers
      dt-bindings: soc: add i.MX93 SRC
      dt-bindings: soc: add i.MX93 mediamix blk ctrl
      soc: imx: add icc paths for i.MX8MP media blk ctrl
      soc: imx: add icc paths for i.MX8MP hsio/hdmi blk ctrl
      soc: imx: add i.MX8MP HDMI blk ctrl HDCP/HRV_MWR
      soc: imx: imx8m-blk-ctrl: add i.MX8MP VPU blk ctrl
      soc: imx: imx8m-blk-ctrl: Use genpd_xlate_onecell
      soc: imx: add i.MX93 SRC power domain driver
      soc: imx: add i.MX93 media blk ctrl driver

Petlozu Pravareshwar (1):
      soc/tegra: pmc: Check device node status property

Qing Wang (1):
      firmware: tegra: Switch over to memdup_user()

Rajendra Nayak (3):
      dt-bindings: interconnect: qcom,msm8998-bwmon: Add support for sc7=
280 BWMONs
      soc: qcom: icc-bwmon: add support for sc7280 LLCC BWMON
      soc: qcom: icc-bwmon: force clear counter/irq registers

Samuel Holland (8):
      soc: sunxi: sram: Actually claim SRAM regions
      soc: sunxi: sram: Prevent the driver from being unbound
      soc: sunxi: sram: Fix probe function ordering issues
      soc: sunxi: sram: Fix debugfs info for A64 SRAM C
      soc: sunxi: sram: Return void from the release function
      soc: sunxi: sram: Save a pointer to the OF match data
      soc: sunxi: sram: Export the LDO control register
      soc: sunxi: sram: Add support for the D1 system control

Sebastian Reichel (2):
      dt-bindings: arm: rockchip: add rk5388 compatible string to pmu.ya=
ml
      dt-bindings: power: rockchip: Add bindings for rk3588

Sen Chu (1):
      dt-bindings: soc: mediatek: pwrap: add compatible for mt8188

Serge Semin (4):
      dt-bindings: memory: synopsys,ddrc-ecc: Detach Zynq DDRC controlle=
r support
      dt-bindings: memory: snps,dw-umctl2-ddrc: Use more descriptive dev=
ice name
      dt-bindings: memory: snps,dw-umctl2-ddrc: Replace opencoded number=
s with macros
      dt-bindings: memory: snps,dw-umctl2-ddrc: Extend schema with IRQs/=
resets/clocks props

Shenwei Wang (2):
      dt-bindings: firmware: add missing resource IDs for imx8dxl
      dt-bindings: arm: imx: update fsl.yaml for imx8dxl

Sudeep Holla (10):
      firmware: arm_ffa: Add pointer to the ffa_dev_ops in struct ffa_dev
      tee: optee: Drop ffa_ops in optee_ffa structure using ffa_dev->ops=
 directly
      firmware: arm_ffa: Remove ffa_dev_ops_get()
      firmware: arm_ffa: Add support for querying FF-A features
      firmware: arm_ffa: Use FFA_FEATURES to detect if native versions a=
re supported
      firmware: arm_ffa: Make memory apis ffa_device independent
      firmware: arm_ffa: Rename ffa_dev_ops as ffa_ops
      firmware: arm_ffa: Add v1.1 get_partition_info support
      firmware: arm_ffa: Set up 32bit execution mode flag using partiion=
 property
      firmware: arm_ffa: Split up ffa_ops into info, message and memory =
operations

Sumit Gupta (4):
      soc/tegra: Set ERD bit to mask inband errors
      soc/tegra: cbb: Add CBB 1.0 driver for Tegra194
      soc/tegra: cbb: Add driver for Tegra234 CBB 2.0
      soc/tegra: cbb: Add support for Tegra241 (Grace)

Thierry Reding (3):
      soc/tegra: pmc: Remove leading space
      soc/tegra: pmc: Add support for simple wake events
      soc/tegra: pmc: Add USB port wake events for Tegra194

Tim Harvey (1):
      dt-bindings: arm: Add i.MX8M Mini Gateworks GW7904 board

Tinghan Shen (4):
      dt-bindings: memory: mediatek,smi: Update condition for mt8195 smi=
 node
      dt-bindings: power: mediatek: Refine multiple level power domain n=
odes
      dt-bindings: power: mediatek: Support naming power controller node=
 with unit address
      dt-bindings: power: mediatek: Update maintainer list

William Zhang (1):
      arm64: bcmbca: Make BCM4908 drivers depend on ARCH_BCMBCA

Xinlei Lee (1):
      soc: mediatek: Add mmsys func to adapt to dpi output for MT8186

YueHaibing (1):
      soc: qcom: Make QCOM_RPMPD depend on OF

 .../ABI/testing/sysfs-platform-brcmstb-memc        |   15 +
 .../devicetree/bindings/arm/bcm/brcm,brcmstb.txt   |   11 +-
 Documentation/devicetree/bindings/arm/fsl.yaml     |   58 +-
 .../devicetree/bindings/arm/rockchip/pmu.yaml      |    4 +
 .../devicetree/bindings/firmware/qcom,scm.txt      |   61 -
 .../devicetree/bindings/firmware/qcom,scm.yaml     |  148 ++
 .../bindings/interconnect/qcom,msm8998-bwmon.yaml  |    3 +
 .../devicetree/bindings/media/exynos5-gsc.txt      |   38 -
 .../bindings/media/samsung,exynos5250-gsc.yaml     |  109 +
 .../memory-controllers/brcm,brcmstb-memc-ddr.yaml  |   52 +
 .../memory-controllers/mediatek,smi-common.yaml    |   15 +-
 .../memory-controllers/mediatek,smi-larb.yaml      |    3 +
 .../memory-controllers/snps,dw-umctl2-ddrc.yaml    |  118 +
 .../memory-controllers/synopsys,ddrc-ecc.yaml      |   76 -
 .../memory-controllers/xlnx,zynq-ddrc-a05.yaml     |   38 +
 Documentation/devicetree/bindings/mfd/syscon.yaml  |    2 +
 .../bindings/power/mediatek,power-controller.yaml  |  135 +-
 .../devicetree/bindings/power/qcom,rpmpd.yaml      |    3 +-
 .../bindings/power/rockchip,power-controller.yaml  |    4 +
 .../bindings/power/rockchip-io-domain.yaml         |   30 +
 .../bindings/soc/imx/fsl,imx8mm-vpu-blk-ctrl.yaml  |  110 +-
 .../bindings/soc/imx/fsl,imx8mp-hdmi-blk-ctrl.yaml |    9 +
 .../bindings/soc/imx/fsl,imx8mp-hsio-blk-ctrl.yaml |   10 +
 .../soc/imx/fsl,imx8mp-media-blk-ctrl.yaml         |   14 +
 .../bindings/soc/imx/fsl,imx93-media-blk-ctrl.yaml |   80 +
 .../devicetree/bindings/soc/imx/fsl,imx93-src.yaml |   96 +
 .../bindings/soc/mediatek/mediatek,mutex.yaml      |    2 +
 .../devicetree/bindings/soc/mediatek/pwrap.txt     |    1 +
 .../devicetree/bindings/soc/qcom/qcom-stats.yaml   |    1 +
 .../devicetree/bindings/soc/rockchip/grf.yaml      |    7 +
 MAINTAINERS                                        |   15 +-
 arch/arm/boot/compressed/head.S                    |    4 -
 drivers/bus/hisi_lpc.c                             |   96 +-
 drivers/cpuidle/cpuidle-psci-domain.c              |    4 +-
 drivers/firmware/arm_ffa/bus.c                     |    4 +-
 drivers/firmware/arm_ffa/driver.c                  |  132 +-
 drivers/firmware/psci/psci.c                       |  118 +-
 drivers/firmware/qcom_scm.h                        |    2 -
 drivers/firmware/tegra/bpmp-debugfs.c              |   13 +-
 drivers/i2c/busses/Kconfig                         |    4 +-
 drivers/memory/Kconfig                             |    9 +
 drivers/memory/Makefile                            |    1 +
 drivers/memory/brcmstb_memc.c                      |  301 +++
 drivers/memory/dfl-emif.c                          |   62 +-
 drivers/memory/mtk-smi.c                           |  109 +-
 drivers/memory/of_memory.c                         |    2 +
 drivers/memory/pl353-smc.c                         |    1 +
 drivers/mtd/parsers/Kconfig                        |    6 +-
 drivers/net/ethernet/broadcom/Kconfig              |    4 +-
 drivers/pci/controller/Kconfig                     |    2 +-
 drivers/phy/broadcom/Kconfig                       |    4 +-
 drivers/pinctrl/bcm/Kconfig                        |    4 +-
 drivers/reset/Kconfig                              |    2 +-
 drivers/soc/amlogic/meson-ee-pwrc.c                |    5 +-
 drivers/soc/amlogic/meson-gx-pwrc-vpu.c            |    5 +-
 drivers/soc/apple/rtkit.c                          |    6 +
 drivers/soc/bcm/bcm63xx/Kconfig                    |    4 +-
 drivers/soc/bcm/brcmstb/pm/pm-arm.c                |   16 +-
 drivers/soc/imx/Kconfig                            |    8 +
 drivers/soc/imx/Makefile                           |    2 +
 drivers/soc/imx/imx8m-blk-ctrl.c                   |   96 +-
 drivers/soc/imx/imx8mp-blk-ctrl.c                  |   89 +-
 drivers/soc/imx/imx93-blk-ctrl.c                   |  436 ++++
 drivers/soc/imx/imx93-pd.c                         |  164 ++
 drivers/soc/imx/imx93-src.c                        |   33 +
 drivers/soc/mediatek/Kconfig                       |    2 +
 drivers/soc/mediatek/mt8186-mmsys.h                |    6 +
 drivers/soc/mediatek/mtk-mmsys.c                   |   20 +
 drivers/soc/mediatek/mtk-mutex.c                   |   44 +
 drivers/soc/mediatek/mtk-pm-domains.c              |    6 +-
 drivers/soc/mediatek/mtk-pmic-wrap.c               |    2 +-
 drivers/soc/mediatek/mtk-scpsys.c                  |    2 +-
 drivers/soc/mediatek/mtk-svs.c                     |  284 ++-
 drivers/soc/qcom/Kconfig                           |    2 +-
 drivers/soc/qcom/icc-bwmon.c                       |  479 +++-
 drivers/soc/qcom/llcc-qcom.c                       |   92 +-
 drivers/soc/qcom/qcom_stats.c                      |    9 +
 drivers/soc/qcom/qmi_encdec.c                      |   50 +-
 drivers/soc/qcom/qmi_interface.c                   |   12 +-
 drivers/soc/qcom/rpmpd.c                           |   22 +
 drivers/soc/qcom/smem_state.c                      |    3 +-
 drivers/soc/qcom/smsm.c                            |   20 +-
 drivers/soc/qcom/socinfo.c                         |    2 +
 drivers/soc/renesas/Kconfig                        |   11 +
 drivers/soc/renesas/renesas-soc.c                  |   14 +
 drivers/soc/rockchip/io-domain.c                   |   20 +
 drivers/soc/rockchip/pm_domains.c                  |  130 +-
 drivers/soc/sunxi/sunxi_sram.c                     |   74 +-
 drivers/soc/tegra/Kconfig                          |   10 +-
 drivers/soc/tegra/Makefile                         |    1 +
 drivers/soc/tegra/cbb/Makefile                     |    9 +
 drivers/soc/tegra/cbb/tegra-cbb.c                  |  190 ++
 drivers/soc/tegra/cbb/tegra194-cbb.c               | 2364 +++++++++++++=
+++++++
 drivers/soc/tegra/cbb/tegra234-cbb.c               | 1113 +++++++++
 drivers/soc/tegra/fuse/fuse-tegra.c                |    1 +
 drivers/soc/tegra/fuse/tegra-apbmisc.c             |   36 +-
 drivers/soc/tegra/pmc.c                            |   45 +-
 drivers/tee/optee/ffa_abi.c                        |   46 +-
 drivers/tee/optee/optee_private.h                  |    1 -
 drivers/tty/serial/Kconfig                         |    4 +-
 drivers/watchdog/Kconfig                           |    2 +-
 include/dt-bindings/clock/imx8mm-clock.h           |    1 -
 include/dt-bindings/firmware/imx/rsrc.h            |    7 +
 include/dt-bindings/power/fsl,imx93-power.h        |   15 +
 include/dt-bindings/power/imx8mp-power.h           |    6 +
 include/dt-bindings/power/qcom-rpmpd.h             |   12 +
 include/dt-bindings/power/rk3588-power.h           |   69 +
 include/dt-bindings/power/rockchip,rv1126-power.h  |   35 +
 include/linux/arm_ffa.h                            |   36 +-
 include/linux/soc/apple/rtkit.h                    |   12 +
 include/linux/soc/mediatek/mtk-mmsys.h             |    2 +
 include/linux/soc/mediatek/mtk-mutex.h             |    2 +
 include/linux/soc/mediatek/mtk_sip_svc.h           |    3 +
 include/linux/soc/qcom/llcc-qcom.h                 |   30 +
 include/linux/soc/qcom/qmi.h                       |   20 +-
 include/linux/soc/sunxi/sunxi_sram.h               |    2 +-
 include/soc/mediatek/smi.h                         |    5 +
 include/soc/tegra/fuse.h                           |    6 +
 include/soc/tegra/tegra-cbb.h                      |   47 +
 include/uapi/linux/psci.h                          |   14 +
 samples/qmi/qmi_sample_client.c                    |   10 +-
 121 files changed, 7578 insertions(+), 900 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-platform-brcmstb-memc
 delete mode 100644 Documentation/devicetree/bindings/firmware/qcom,scm.=
txt
 create mode 100644 Documentation/devicetree/bindings/firmware/qcom,scm.=
yaml
 delete mode 100644 Documentation/devicetree/bindings/media/exynos5-gsc.=
txt
 create mode 100644 Documentation/devicetree/bindings/media/samsung,exyn=
os5250-gsc.yaml
 create mode 100644 Documentation/devicetree/bindings/memory-controllers=
/brcm,brcmstb-memc-ddr.yaml
 create mode 100644 Documentation/devicetree/bindings/memory-controllers=
/snps,dw-umctl2-ddrc.yaml
 delete mode 100644 Documentation/devicetree/bindings/memory-controllers=
/synopsys,ddrc-ecc.yaml
 create mode 100644 Documentation/devicetree/bindings/memory-controllers=
/xlnx,zynq-ddrc-a05.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/imx/fsl,imx93-=
media-blk-ctrl.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/imx/fsl,imx93-=
src.yaml
 create mode 100644 drivers/memory/brcmstb_memc.c
 create mode 100644 drivers/soc/imx/imx93-blk-ctrl.c
 create mode 100644 drivers/soc/imx/imx93-pd.c
 create mode 100644 drivers/soc/imx/imx93-src.c
 create mode 100644 drivers/soc/tegra/cbb/Makefile
 create mode 100644 drivers/soc/tegra/cbb/tegra-cbb.c
 create mode 100644 drivers/soc/tegra/cbb/tegra194-cbb.c
 create mode 100644 drivers/soc/tegra/cbb/tegra234-cbb.c
 create mode 100644 include/dt-bindings/power/fsl,imx93-power.h
 create mode 100644 include/dt-bindings/power/rk3588-power.h
 create mode 100644 include/dt-bindings/power/rockchip,rv1126-power.h
 create mode 100644 include/soc/tegra/tegra-cbb.h
