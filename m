Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 518756A4764
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 17:56:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbjB0Q4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 11:56:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbjB0Q4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 11:56:47 -0500
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDFEA233EC
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 08:56:43 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 20085320085B;
        Mon, 27 Feb 2023 11:56:43 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Mon, 27 Feb 2023 11:56:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1677517002; x=1677603402; bh=Jeajp62/zU
        dIeHkF/bpA8FKchSKKZ0649uxDONLl6JA=; b=tPJfi027VgV8rgJPCalLDXvQO9
        UpEY5NFLFgamJU0i49tB2ePx2MnKYsuNtdaGp9wEip29ySDBEF0QIhKzi/SUbAtx
        HmR5EYtJCDVL0Ypi04XJpYdGo23joqGxUjn2ujYOOMgr0Oz18+EyIVtvntundLjh
        7ILvpWxya4MMVkfnDPe2fZmngoqJbA0u1HlFtAi8YyjSMmdA51FFmPV5rcVHMBKp
        Vvy5ORjbIrZ87vG49enKq6Gu+L10H+bkFvJJjuS2sADnMQbfku+wrNepIa1XQpE9
        qH75GqR077CxRnBGHrpt4LC3chhRWI+/kPv3fYRUwNvw5A75mD05uxheGKYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1677517002; x=1677603402; bh=Jeajp62/zUdIe
        HkF/bpA8FKchSKKZ0649uxDONLl6JA=; b=YXSd+pPQP8ulPuHa/n4Q0X9qN3PNy
        6zmCIJJ44BV6UhodahqUlry0fYx7/vynL/EvwtRAo2q1TjQZos9ptWmCAUDWkXWw
        dt61W2yTTrw8kT4pFDatjaLw5cFzU2GBfY/OS692r1KhD7MqI/YSzA9+Xj6ZP/B1
        ob7CHQtlwUshz5ydQml1bJYBfuUnRFQu7Bt6LT5w+YHP4Taqa8ba8mgAzGkFuPD2
        mvC2xUIJMHd1HkkD2rTTEnKI6ZJWNwLGZonRiz7unX62tV6h3vHFIDM8F+UB3pkU
        VUXnT8PKQtsZrwaA0IsEzLhOJMulKnTAKD/gEpj8o7FvgaqokEr/IMTiw==
X-ME-Sender: <xms:yuD8Yzwc21Bnj7bXNS9Qs3USNxnYWjnOk1CNDS6P4Ry9woknsXIk-w>
    <xme:yuD8Y7QJ75-eKZ-PfasF-bk-g-IKN2Wkqu0UklP4V4rBZtwvSjd2qszUowS0btb_K
    uhcoq5eLlAvgmE9L0s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudeltddgledtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkfffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeejjeeggfeuiedvfedtteevgfelheeifffhjedtkeeglefgiedufeeigfevveel
    ueenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhgihhthhhusgdrtghomhenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghr
    nhgusgdruggv
X-ME-Proxy: <xmx:yuD8Y9Uxz9xQTUQR-zmJtEw9J9M0WA17eDH96a3VnsR4c3a9yGXGvw>
    <xmx:yuD8Y9gBPRaGn3Z1e_vDgUVfFqr2adCtcvB_Uf_ZQ5AnP64gJxc8_g>
    <xmx:yuD8Y1CdBYfuWOsRWtiA7TWAirQIJm4I64MF8Ur5dJ5Gt-AD1YLy_g>
    <xmx:yuD8Yy5wkUmos_X29sTCfH-MIqo6m0p09Q9RwyemgV2V6CFXy8yTGg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 7D4E4B6008D; Mon, 27 Feb 2023 11:56:42 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-183-gbf7d00f500-fm-20230220.001-gbf7d00f5
Mime-Version: 1.0
Message-Id: <99657e61-81b7-4f03-b81d-fd2a49e67eef@app.fastmail.com>
Date:   Mon, 27 Feb 2023 17:56:07 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Linus Torvalds" <torvalds@linux-foundation.org>
Cc:     soc@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL 1/2] ARM: SoC drivers for 6.3
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

The following changes since commit b7bfaa761d760e72a969d116517eaa12e404c=
262:

  Linux 6.2-rc3 (2023-01-08 11:49:43 -0600)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-d=
rivers-6.3

for you to fetch changes up to 524af30c931382726b6a46ee4f392fb6e60f8a03:

  Merge tag 'qcom-drivers-for-6.3-3' of https://git.kernel.org/pub/scm/l=
inux/kernel/git/qcom/linux into soc/drivers (2023-02-15 15:01:04 +0100)

----------------------------------------------------------------
ARM: SoC drivers for 6.3

As usual, there are lots of minor driver changes across SoC platforms
from  NXP, Amlogic, AMD Zynq, Mediatek, Qualcomm, Apple and Samsung.
These usually add support for additional chip variations in existing
drivers, but also add features or bugfixes.

The SCMI firmware subsystem gains a unified raw userspace interface
through debugfs, which can be used for validation purposes.

Newly added drivers include:

 - New power management drivers for StarFive JH7110, Allwinner D1 and
   Renesas RZ/V2M

 - A driver for Qualcomm battery and power supply status

 - A SoC device driver for identifying Nuvoton WPCM450 chips

 - A regulator coupler driver for Mediatek MT81xxv

----------------------------------------------------------------
This is a follow-up to the earlier four pull requests for the soc
tree, this is all that was still missing from last week.
----
Abel Vesa (1):
      dt-bindings: firmware: document Qualcomm SM8550 SCM

Alexandre Mergnat (2):
      dt-bindings: soc: mediatek: convert pwrap documentation
      dt-bindings: mfd: mediatek: Add bindings for MT6357 PMIC

Allen-KH Cheng (2):
      soc: mediatek: pm-domains: Add buck isolation offset and mask to p=
ower domain data
      soc: mediatek: pm-domains: Add buck isolation setting in power dom=
ain

AngeloGioacchino Del Regno (4):
      dt-bindings: soc: qcom: Add bindings for Qualcomm Ramp Controller
      soc: qcom: Add Qualcomm Ramp Controller driver
      soc: mediatek: Introduce mediatek-regulator-coupler driver
      soc: mediatek: mtk-devapc: Switch to devm_clk_get_enabled()

Arnd Bergmann (18):
      Merge tag 'renesas-drivers-for-v6.3-tag1' of git://git.kernel.org/=
pub/scm/linux/kernel/git/geert/renesas-devel into soc/drivers
      Merge tag 'scmi-updates-6.3' of git://git.kernel.org/pub/scm/linux=
/kernel/git/sudeep.holla/linux into soc/drivers
      Merge tag 'memory-controller-drv-6.3-2' of https://git.kernel.org/=
pub/scm/linux/kernel/git/krzk/linux-mem-ctrl into soc/drivers
      Merge tag 'riscv-soc-for-v6.3-mw0' of https://git.kernel.org/pub/s=
cm/linux/kernel/git/conor/linux into soc/drivers
      Merge tag 'renesas-drivers-for-v6.3-tag2' of git://git.kernel.org/=
pub/scm/linux/kernel/git/geert/renesas-devel into soc/drivers
      Merge tag 'sunxi-drivers-for-6.3-1' of https://git.kernel.org/pub/=
scm/linux/kernel/git/sunxi/linux into soc/drivers
      Merge tag 'arm-soc/for-6.3/drivers' of https://github.com/Broadcom=
/stblinux into soc/drivers
      Merge tag 'imx-drivers-6.3' of git://git.kernel.org/pub/scm/linux/=
kernel/git/shawnguo/linux into soc/drivers
      Merge tag 'amlogic-drivers-for-v6.3' of https://git.kernel.org/pub=
/scm/linux/kernel/git/amlogic/linux into soc/drivers
      soc: sunxi: select CONFIG_PM
      Merge tag 'zynqmp-soc-for-v6.3' of https://github.com/Xilinx/linux=
-xlnx into soc/drivers
      Merge tag 'v6.2-next-soc' of https://git.kernel.org/pub/scm/linux/=
kernel/git/matthias.bgg/linux into soc/drivers
      Merge tag 'samsung-drivers-6.3-2' of https://git.kernel.org/pub/sc=
m/linux/kernel/git/krzk/linux into soc/drivers
      Merge tag 'asahi-soc-rtkit-pmgr-6.3' of https://github.com/AsahiLi=
nux/linux into soc/drivers
      soc: qcom: pmic_glink: add CONFIG_NET/CONFIG_OF dependencies
      Merge tag 'qcom-drivers-for-6.3' of https://git.kernel.org/pub/scm=
/linux/kernel/git/qcom/linux into soc/drivers
      Merge tag 'qcom-drivers-for-6.3-2' of https://git.kernel.org/pub/s=
cm/linux/kernel/git/qcom/linux into soc/drivers
      Merge tag 'qcom-drivers-for-6.3-3' of https://git.kernel.org/pub/s=
cm/linux/kernel/git/qcom/linux into soc/drivers

Asahi Lina (4):
      soc: apple: rtkit: Add a private pointer to apple_rtkit_shmem
      soc: apple: rtkit: Export non-devm init/free functions
      soc: apple: rtkit: Add register dump decoding to crashlog
      soc: apple: rtkit: Do not copy the reg state structure to the stack

Bagas Sanjaya (2):
      soc: qcom: dcc: Fix examples list on /sys/kernel/debug/dcc/.../[li=
st-number]/config documentation
      soc: qcom: dcc: rewrite description of dcc sysfs files

Bartosz Golaszewski (3):
      dt-bindings: power: qcom,rpmpd: document sa8775p
      soc: qcom: rmphpd: add power domains for sa8775p
      dt-bindings: firmware: qcom,scm: add qcom,scm-sa8775p compatible

Bjorn Andersson (10):
      soc: qcom: ramp_controller: Include linux/bitfield.h
      soc: qcom: ramp_controller: Make things static
      Merge branch '20230109130523.298971-3-konrad.dybcio@linaro.org' in=
to drivers-for-6.3
      Merge tag 'qcom-driver-fixes-for-6.2' into drivers-for-6.3
      soc: qcom: dcc: Drop driver for now
      dt-bindings: soc: qcom: Introduce PMIC GLINK binding
      soc: qcom: pmic_glink: Introduce base PMIC GLINK driver
      soc: qcom: pmic_glink: Introduce altmode support
      Merge branch '20230201041853.1934355-1-quic_bjorande@quicinc.com' =
into drivers-for-6.3
      power: supply: Introduce Qualcomm PMIC GLINK power supply

Bryan O'Donoghue (1):
      dt-bindings: soc: qcom: smd-rpm: Exclude MSM8936 from glink-channe=
ls

Christian Marangi (2):
      dt-bindings: arm: qcom,ids: Add Soc IDs for IPQ8064 and variants
      soc: qcom: socinfo: Add Soc IDs for IPQ8064 and variants

Christophe JAILLET (1):
      PM: AVS: qcom-cpr: Fix an error handling path in cpr_probe()

Cong Dang (1):
      memory: renesas-rpc-if: Remove redundant division of dummy

Conor Dooley (1):
      Merge patch series "JH7110 PMU Support"

Cristian Marussi (31):
      firmware: arm_scmi: Clear stale xfer->hdr.status
      firmware: arm_scmi: Harden shared memory access in fetch_response
      firmware: arm_scmi: Harden shared memory access in fetch_notificat=
ion
      firmware: arm_scmi: Fix virtio channels cleanup on shutdown
      firmware: arm_scmi: Simplify chan_available transport operation
      firmware: arm_scmi: Use dedicated devices to initialize channels
      firmware: arm_scmi: Move protocol registration helpers
      firmware: arm_scmi: Add common notifier helpers
      firmware: arm_scmi: Refactor protocol device creation
      firmware: arm_scmi: Move handle get/set helpers
      firmware: arm_scmi: Refactor device create/destroy helpers
      firmware: arm_scmi: Introduce a new lifecycle for protocol devices
      firmware: arm_scmi: Split bus and driver into distinct modules
      firmware: arm_scmi: Refactor xfer in-flight registration routines
      firmware: arm_scmi: Refactor polling helpers
      firmware: arm_scmi: Refactor scmi_wait_for_message_response
      firmware: arm_scmi: Add flags field to xfer
      firmware: arm_scmi: Add xfer helpers to provide raw access
      firmware: arm_scmi: Move errors defs and code to common.h
      firmware: arm_scmi: Add internal platform/channel identifiers
      include: trace: Add platform and channel instance references
      debugfs: Export debugfs_create_str symbol
      firmware: arm_scmi: Populate a common SCMI debugfs root
      firmware: arm_scmi: Add debugfs ABI documentation for common entri=
es
      firmware: arm_scmi: Add core raw transmission support
      firmware: arm_scmi: Add debugfs ABI documentation for raw mode
      firmware: arm_scmi: Reject SCMI drivers when configured in raw mode
      firmware: arm_scmi: Call raw mode hooks from the core stack
      firmware: arm_scmi: Add the raw mode co-existence support
      firmware: arm_scmi: Add per-channel raw injection support
      firmware: arm_scmi: Clarify raw per-channel ABI documentation

Dawei Li (1):
      soc: qcom: apr: make remove callback of apr driver void returned

Deepak R Varma (2):
      soc: imx: imx93-pd: No need to set device_driver owner
      soc: imx: imx93-src: No need to set device_driver owner

Dmitry Baryshkov (1):
      dt-bindings: power: qcom,rpmpd: add RPMH_REGULATOR_LEVEL_LOW_SVS_L1

Elliot Berman (1):
      firmware: qcom_scm: Move qcom_scm.h to include/linux/firmware/qcom/

Emil Renner Berthing (2):
      dt-bindings: sifive,ccache0: Support StarFive JH7110 SoC
      soc: sifive: ccache: Add StarFive JH7110 support

Fabien Parent (2):
      dt-bindings: input: mtk-pmic-keys: add binding for MT6357 PMIC
      Input: mtk-pmic-keys: add MT6357 support

Fabrizio Castro (1):
      soc: renesas: Add PWC support for RZ/V2M

Gaosheng Cui (1):
      driver: soc: xilinx: fix memory leak in xlnx_add_cb_for_notify_eve=
nt()

Garmin.Chang (2):
      dt-bindings: power: Add MT8188 power domains
      soc: mediatek: pm-domains: Add support for mt8188

Geert Uytterhoeven (7):
      Merge tag 'renesas-r8a779g0-dt-binding-defs-tag2' into renesas-dri=
vers-for-v6.3
      memory: renesas-rpc-if: Split-off private data from struct rpcif
      memory: renesas-rpc-if: Move resource acquisition to .probe()
      memory: renesas-rpc-if: Always use dev in rpcif_probe()
      memory: renesas-rpc-if: Improve Runtime PM handling
      memory: renesas-rpc-if: Pass device instead of rpcif to rpcif_*()
      memory: renesas-rpc-if: Remove Runtime PM wrappers

Guru Das Srinagesh (2):
      dt-bindings: firmware: qcom,scm: Add optional interrupt
      firmware: qcom: scm: Add wait-queue handling logic

Hector Martin (2):
      soc: apple: rtkit: Add apple_rtkit_idle() function
      soc: apple: apple-pmgr-pwrstate: Switch to IRQ-safe mode

Jonathan Neusch=C3=A4fer (1):
      soc: nuvoton: Add SoC info driver for WPCM450

Kathiravan T (2):
      dt-bindings: arm: qcom,ids: Add IDs for IPQ5332 and its variant
      soc: qcom: socinfo: Add IDs for IPQ5332 and its variant

Konrad Dybcio (4):
      dt-bindings: reserved-memory: rmtfs: Make qcom,vmid an array
      dt-bindings: firmware: qcom: scm: Separate VMIDs from header to bi=
ndings
      Revert "soc: qcom: rpmpd: Add SM4250 support"
      Revert "dt-bindings: power: rpmpd: Add SM4250 support"

Krzysztof Kozlowski (11):
      dt-bindings: soc: samsung: exynos-sysreg: split from syscon
      dt-bindings: soc: samsung: exynos-sysreg: add dedicated SYSREG com=
patibles to Exynos5433
      dt-bindings: soc: samsung: exynos-sysreg: add clocks for Exynos850
      dt-bindings: soc: samsung: exynos-sysreg: correct indentation for =
deprecated
      dt-bindings: firmware: qcom,scm: document MSM8226 clocks
      dt-bindings: firmware: qcom,scm: narrow clocks and interconnects
      MAINTAINERS: arm64: tesla: correct pattern for directory
      dt-bindings: phy: samsung,dp-video-phy: deprecate syscon phandle
      dt-bindings: phy: samsung,mipi-video-phy: deprecate syscon phandle
      phy: samsung,dp-video-phy: deprecate syscon phandle
      phy: samsung,mipi-video-phy: deprecate syscon phandle

Loic Poulain (1):
      soc: qcom: rmtfs: Optionally map RMTFS to more VMs

Lucas Stach (5):
      soc: imx: add Kconfig symbols for blk-ctrl drivers
      soc: imx: imx8mp-blk-ctrl: add instance specific probe function
      soc: imx: imx8mp-blk-ctrl: expose high performance PLL clock
      soc: imx: imx8m-blk-ctrl: set LCDIF panic read hurry level
      soc: imx: imx8mp-blk-ctrl: set HDMI LCDIF panic read hurry level

Marek Vasut (1):
      firmware: xilinx: Clear IOCTL_SET_SD_TAPDELAY using PM_MMIO_WRITE

Matthias Brugger (4):
      soc: mediatek: mtk-svs: clean up platform probing
      soc: mediatek: mtk-svs: improve readability of platform_probe
      soc: mediatek: mtk-svs: move svs_platform_probe into probe
      soc: mediatek: mtk-svs: delete superfluous platform data entries

Melody Olvera (2):
      dt-bindings: firmware: scm: Add QDU1000/QRU1000 compatible
      dt-bindings: soc: qcom,rpmh-rsc: Update to allow for generic nodes

Michal Simek (1):
      firmware: xilinx: Remove kernel-doc marking in the code

Miles Chen (1):
      firmware: meson_sm: stop using 0 as NULL pointer

Minghao Chi (1):
      bus: imx-weim: use devm_platform_get_and_ioremap_resource()

Moudy Ho (1):
      dt-bindings: arm: mediatek: mmsys: Add support for MT8195 VPPSYS

Naman Jain (2):
      soc: qcom: socinfo: Add support for new fields in revision 16
      soc: qcom: socinfo: Add support for new field in revision 17

Nancy.Lin (11):
      dt-bindings: arm: mediatek: mmsys: add vdosys1 compatible for MT81=
95
      dt-bindings: reset: mt8195: add vdosys1 reset control bit
      soc: mediatek: add mtk-mmsys ethdr and mdp_rdma components
      soc: mediatek: add mtk-mmsys support for mt8195 vdosys1
      soc: mediatek: refine code to use mtk_mmsys_update_bits API
      soc: mediatek: add mtk-mmsys config API for mt8195 vdosys1
      soc: mediatek: add cmdq support of mtk-mmsys config API for mt8195=
 vdosys1
      soc: mediatek: mmsys: add mmsys for support 64 reset bits
      soc: mediatek: mmsys: add reset control for MT8195 vdosys1
      soc: mediatek: add mtk-mutex component - dp_intf1
      soc: mediatek: add mtk-mutex support for mt8195 vdosys1

Nathan Lu (4):
      dt-bindings: mediatek: modify VDOSYS0 mmsys device tree Documentat=
ions for MT8188
      dt-bindings: mediatek: modify VDOSYS0 mutex device tree Documentat=
ions for MT8188
      soc: mediatek: add mtk-mmsys support for mt8188 vdosys0
      soc: mediatek: add mtk-mutex support for mt8188 vdosys0

Neil Armstrong (4):
      dt-bindings: soc: qcom: convert non-smd RPM bindings to dt-schema
      Merge branch 'v6.3/bindings' of https://git.kernel.org/pub/scm/lin=
ux/kernel/git/amlogic/linux into HEAD
      dt-bindings: firmware: convert meson_sm.txt to dt-schema
      dt-bindings: power: amlogic,meson-gx-pwrc: mark bindings as deprec=
ated

Niklas Cassel (1):
      MAINTAINERS: Update qcom CPR maintainer entry

Randy Dunlap (1):
      soc: sunxi: SUN20I_PPU should depend on PM

Ricardo Ribalda (1):
      soc: mediatek: mtk-svs: Enable the IRQ later

Roger Lu (4):
      soc: mediatek: mtk-svs: restore default voltages when svs_init02()=
 fail
      soc: mediatek: mtk-svs: reset svs when svs_resume() fail
      soc: mediatek: mtk-svs: keep svs alive if CONFIG_DEBUG_FS not supp=
orted
      soc: mtk-svs: mt8183: refactor o_slope calculation

Roy-CW.Yeh (1):
      soc: mediatek: mmsys: add support for MT8195 VPPSYS

Samuel Holland (3):
      soc: sunxi: sram: Only iterate over SRAM children
      dt-bindings: power: Add Allwinner D1 PPU
      soc: sunxi: Add Allwinner D1 PPU driver

Shang XiaoJing (1):
      soc: mediatek: mtk-svs: Use pm_runtime_resume_and_get() in svs_ini=
t01()

Souradeep Chowdhury (3):
      dt-bindings: soc: qcom,dcc: Add the dtschema
      soc: qcom: dcc: Add driver support for Data Capture and Compare un=
it(DCC)
      MAINTAINERS: Add the entry for DCC(Data Capture and Compare) drive=
r support

Sriranjani P (3):
      dt-bindings: soc: samsung: exynos-sysreg: Add tesla FSD sysreg com=
patibles
      dt-bindings: soc: samsung: exynos-sysreg: add dedicated SYSREG com=
patibles to Exynos850
      dt-bindings: soc: samsung: exynos-sysreg: add dedicated SYSREG com=
patibles to Exynosautov9

Stephan Gerhold (6):
      dt-bindings: soc: qcom: apr: Make qcom,protection-domain optional =
again
      soc: qcom: apr: Make qcom,protection-domain optional again
      soc: qcom: socinfo: Fix soc_id order
      dt-bindings: arm: qcom,ids: Add QRD board ID
      dt-bindings: arm: qcom,ids: Add a bunch of older SoCs
      soc: qcom: socinfo: Add a bunch of older SoCs

Stephen Boyd (1):
      soc: qcom: stats: Populate all subsystem debugfs files

Tam Nguyen (2):
      dt-bindings: power: r8a779g0: Add missing A3DUL power domain
      soc: renesas: r8a779g0-sysc: Add missing A3DUL power domain

Tinghan Shen (1):
      soc: mediatek: mtk-pm-domains: Allow mt8186 ADSP default power on

Tom Rix (1):
      soc: qcom: pmic_glink: remove redundant calculation of svid

Tomeu Vizoso (3):
      dt-bindings: reset: meson-g12a: Add missing NNA reset
      dt-bindings: power: Add G12A NNA power domain
      soc: amlogic: meson-pwrc: Add NNA power domain for A311D

Uwe Kleine-K=C3=B6nig (2):
      soc: mediatek: mutex: Drop empty platform remove function
      soc: bcm: bcm2835-power: Drop empty platform remove function

Walker Chen (2):
      dt-bindings: power: Add starfive,jh7110-pmu
      soc: starfive: Add StarFive JH71XX pmu driver

Yang Li (1):
      soc: qcom: dcc: Fix unsigned comparison with less than zero

Yongqiang Niu (1):
      mtk-mmsys: Change mtk-mmsys & mtk-mutex to modules

Zeng Heng (1):
      soc: mediatek: mtk-svs: add missing MODULE_DEVICE_TABLE

devi priya (1):
      soc: qcom: smd-rpm: Add IPQ9574 compatible

ye xingchen (1):
      memory: ti-emif-pm: Use device_get_match_data() to simplify the co=
de

 Documentation/ABI/testing/debugfs-driver-dcc       |  127 ++
 Documentation/ABI/testing/debugfs-scmi             |   70 +
 Documentation/ABI/testing/debugfs-scmi-raw         |  117 ++
 .../bindings/arm/mediatek/mediatek,mmsys.yaml      |    4 +
 .../bindings/firmware/amlogic,meson-gxbb-sm.yaml   |   39 +
 .../bindings/firmware/meson/meson_sm.txt           |   15 -
 .../devicetree/bindings/firmware/qcom,scm.yaml     |   68 +-
 .../bindings/input/mediatek,pmic-keys.yaml         |    1 +
 .../devicetree/bindings/leds/leds-mt6323.txt       |    2 +-
 .../devicetree/bindings/mfd/mediatek,mt6357.yaml   |  111 ++
 Documentation/devicetree/bindings/mfd/mt6397.txt   |    2 +-
 Documentation/devicetree/bindings/mfd/qcom-rpm.txt |  283 ----
 Documentation/devicetree/bindings/mfd/syscon.yaml  |    6 -
 .../bindings/phy/samsung,dp-video-phy.yaml         |    5 +-
 .../bindings/phy/samsung,mipi-video-phy.yaml       |   11 +-
 .../bindings/power/allwinner,sun20i-d1-ppu.yaml    |   54 +
 .../bindings/power/amlogic,meson-gx-pwrc.txt       |    4 +-
 .../bindings/power/mediatek,power-controller.yaml  |    2 +
 .../devicetree/bindings/power/qcom,rpmpd.yaml      |    2 +-
 .../bindings/power/starfive,jh7110-pmu.yaml        |   45 +
 .../bindings/reserved-memory/qcom,rmtfs-mem.yaml   |    6 +-
 .../devicetree/bindings/riscv/sifive,ccache0.yaml  |    9 +-
 .../bindings/soc/mediatek/mediatek,mutex.yaml      |    1 +
 .../bindings/soc/mediatek/mediatek,pwrap.yaml      |  147 ++
 .../devicetree/bindings/soc/mediatek/pwrap.txt     |   75 -
 .../bindings/soc/qcom/qcom,apr-services.yaml       |    5 +-
 .../devicetree/bindings/soc/qcom/qcom,dcc.yaml     |   44 +
 .../soc/qcom/qcom,msm8976-ramp-controller.yaml     |   36 +
 .../bindings/soc/qcom/qcom,pmic-glink.yaml         |   95 ++
 .../devicetree/bindings/soc/qcom/qcom,rpm.yaml     |  101 ++
 .../bindings/soc/qcom/qcom,rpmh-rsc.yaml           |    3 +-
 .../devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml |    1 +
 .../soc/samsung/samsung,exynos-sysreg.yaml         |   87 ++
 MAINTAINERS                                        |   18 +-
 arch/arm/mach-qcom/platsmp.c                       |    2 +-
 drivers/bus/imx-weim.c                             |    4 +-
 drivers/cpuidle/cpuidle-qcom-spm.c                 |    2 +-
 drivers/firmware/arm_scmi/Kconfig                  |   32 +
 drivers/firmware/arm_scmi/Makefile                 |    9 +-
 drivers/firmware/arm_scmi/bus.c                    |  395 ++++--
 drivers/firmware/arm_scmi/common.h                 |  100 +-
 drivers/firmware/arm_scmi/driver.c                 | 1225 +++++++++++--=
----
 drivers/firmware/arm_scmi/mailbox.c                |    6 +-
 drivers/firmware/arm_scmi/optee.c                  |    6 +-
 drivers/firmware/arm_scmi/protocols.h              |    7 +
 drivers/firmware/arm_scmi/raw_mode.c               | 1443 +++++++++++++=
+++++++
 drivers/firmware/arm_scmi/raw_mode.h               |   31 +
 drivers/firmware/arm_scmi/shmem.c                  |    9 +-
 drivers/firmware/arm_scmi/smc.c                    |    6 +-
 drivers/firmware/arm_scmi/virtio.c                 |   11 +-
 drivers/firmware/meson/meson_sm.c                  |    2 +-
 drivers/firmware/qcom_scm-legacy.c                 |    2 +-
 drivers/firmware/qcom_scm-smc.c                    |   88 +-
 drivers/firmware/qcom_scm.c                        |   92 +-
 drivers/firmware/qcom_scm.h                        |    8 +
 drivers/firmware/xilinx/zynqmp.c                   |   27 +-
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c              |    2 +-
 drivers/gpu/drm/msm/adreno/adreno_gpu.c            |    2 +-
 drivers/gpu/drm/msm/hdmi/hdmi_hdcp.c               |    2 +-
 drivers/input/keyboard/mtk-pmic-keys.c             |   17 +
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom-debug.c   |    2 +-
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c         |    2 +-
 drivers/iommu/arm/arm-smmu/qcom_iommu.c            |    2 +-
 drivers/media/platform/qcom/venus/firmware.c       |    2 +-
 drivers/memory/renesas-rpc-if.c                    |  155 ++-
 drivers/memory/ti-emif-pm.c                        |    7 +-
 drivers/misc/fastrpc.c                             |    2 +-
 drivers/mmc/host/sdhci-msm.c                       |    2 +-
 drivers/mtd/hyperbus/rpc-if.c                      |   18 +-
 drivers/net/ipa/ipa_main.c                         |    2 +-
 drivers/net/wireless/ath/ath10k/qmi.c              |    2 +-
 drivers/phy/samsung/phy-exynos-dp-video.c          |    7 +-
 drivers/phy/samsung/phy-exynos-mipi-video.c        |    7 +-
 drivers/pinctrl/qcom/pinctrl-msm.c                 |    2 +-
 drivers/power/supply/Kconfig                       |    9 +
 drivers/power/supply/Makefile                      |    1 +
 drivers/power/supply/qcom_battmgr.c                | 1411 +++++++++++++=
++++++
 drivers/remoteproc/qcom_q6v5_mss.c                 |    2 +-
 drivers/remoteproc/qcom_q6v5_pas.c                 |    2 +-
 drivers/remoteproc/qcom_wcnss.c                    |    2 +-
 drivers/soc/Kconfig                                |    2 +
 drivers/soc/Makefile                               |    4 +-
 drivers/soc/amlogic/meson-ee-pwrc.c                |   17 +
 drivers/soc/apple/apple-pmgr-pwrstate.c            |   11 +-
 drivers/soc/apple/rtkit-crashlog.c                 |   93 ++
 drivers/soc/apple/rtkit.c                          |   36 +-
 drivers/soc/bcm/bcm2835-power.c                    |    6 -
 drivers/soc/imx/Kconfig                            |   11 +
 drivers/soc/imx/Makefile                           |    6 +-
 drivers/soc/imx/imx8m-blk-ctrl.c                   |   27 +-
 drivers/soc/imx/imx8mp-blk-ctrl.c                  |  108 ++
 drivers/soc/imx/imx93-pd.c                         |    1 -
 drivers/soc/imx/imx93-src.c                        |    1 -
 drivers/soc/mediatek/Kconfig                       |    7 +-
 drivers/soc/mediatek/Makefile                      |    1 +
 drivers/soc/mediatek/mt8186-pm-domains.h           |    4 +-
 drivers/soc/mediatek/mt8188-mmsys.h                |  149 ++
 drivers/soc/mediatek/mt8188-pm-domains.h           |  623 +++++++++
 drivers/soc/mediatek/mt8195-mmsys.h                |  146 ++
 drivers/soc/mediatek/mtk-devapc.c                  |   11 +-
 drivers/soc/mediatek/mtk-mmsys.c                   |  200 ++-
 drivers/soc/mediatek/mtk-mmsys.h                   |    2 +
 drivers/soc/mediatek/mtk-mutex.c                   |  113 +-
 drivers/soc/mediatek/mtk-pm-domains.c              |   13 +
 drivers/soc/mediatek/mtk-pm-domains.h              |    5 +
 drivers/soc/mediatek/mtk-regulator-coupler.c       |  159 +++
 drivers/soc/mediatek/mtk-svs.c                     |  155 ++-
 drivers/soc/nuvoton/Kconfig                        |   11 +
 drivers/soc/nuvoton/Makefile                       |    2 +
 drivers/soc/nuvoton/wpcm450-soc.c                  |  109 ++
 drivers/soc/qcom/Kconfig                           |   27 +
 drivers/soc/qcom/Makefile                          |    3 +
 drivers/soc/qcom/apr.c                             |    3 +-
 drivers/soc/qcom/cpr.c                             |    6 +-
 drivers/soc/qcom/mdt_loader.c                      |    2 +-
 drivers/soc/qcom/ocmem.c                           |    2 +-
 drivers/soc/qcom/pmic_glink.c                      |  336 +++++
 drivers/soc/qcom/pmic_glink_altmode.c              |  478 +++++++
 drivers/soc/qcom/qcom_stats.c                      |   10 +-
 drivers/soc/qcom/ramp_controller.c                 |  343 +++++
 drivers/soc/qcom/rmtfs_mem.c                       |   31 +-
 drivers/soc/qcom/rpmhpd.c                          |   34 +
 drivers/soc/qcom/rpmpd.c                           |   18 -
 drivers/soc/qcom/smd-rpm.c                         |    1 +
 drivers/soc/qcom/socinfo.c                         |  112 +-
 drivers/soc/renesas/Kconfig                        |    4 +
 drivers/soc/renesas/Makefile                       |    1 +
 drivers/soc/renesas/pwc-rzv2m.c                    |  141 ++
 drivers/soc/renesas/r8a779g0-sysc.c                |    1 +
 drivers/soc/sifive/Kconfig                         |    2 +-
 drivers/soc/starfive/Kconfig                       |   12 +
 drivers/soc/starfive/Makefile                      |    3 +
 drivers/soc/starfive/jh71xx_pmu.c                  |  383 ++++++
 drivers/soc/sunxi/Kconfig                          |    9 +
 drivers/soc/sunxi/Makefile                         |    1 +
 drivers/soc/sunxi/sun20i-ppu.c                     |  207 +++
 drivers/soc/sunxi/sunxi_sram.c                     |    3 +
 drivers/soc/xilinx/xlnx_event_manager.c            |    4 +-
 drivers/soc/xilinx/zynqmp_pm_domains.c             |    2 +-
 drivers/spi/spi-rpc-if.c                           |   14 +-
 drivers/thermal/qcom/lmh.c                         |    2 +-
 drivers/ufs/host/ufs-qcom-ice.c                    |    2 +-
 fs/debugfs/file.c                                  |    1 +
 include/dt-bindings/arm/qcom,ids.h                 |   83 ++
 include/dt-bindings/firmware/qcom,scm.h            |   16 +
 .../dt-bindings/power/allwinner,sun20i-d1-ppu.h    |   10 +
 include/dt-bindings/power/mediatek,mt8188-power.h  |   44 +
 include/dt-bindings/power/meson-g12a-power.h       |    1 +
 include/dt-bindings/power/qcom-rpmpd.h             |   30 +-
 include/dt-bindings/power/r8a779g0-sysc.h          |    1 +
 include/dt-bindings/power/starfive,jh7110-pmu.h    |   17 +
 .../dt-bindings/reset/amlogic,meson-g12a-reset.h   |    4 +-
 include/dt-bindings/reset/mt8195-resets.h          |   45 +
 include/linux/{ =3D> firmware/qcom}/qcom_scm.h       |    6 +-
 include/linux/firmware/xlnx-zynqmp.h               |    4 +
 include/linux/scmi_protocol.h                      |    5 -
 include/linux/soc/apple/rtkit.h                    |   26 +
 include/linux/soc/mediatek/infracfg.h              |  121 ++
 include/linux/soc/mediatek/mtk-mmsys.h             |   25 +
 include/linux/soc/qcom/apr.h                       |    2 +-
 include/linux/soc/qcom/pmic_glink.h                |   32 +
 include/memory/renesas-rpc-if.h                    |   34 +-
 include/trace/events/scmi.h                        |   18 +-
 sound/soc/qcom/qdsp6/q6core.c                      |    4 +-
 164 files changed, 10170 insertions(+), 1354 deletions(-)
 create mode 100644 Documentation/ABI/testing/debugfs-driver-dcc
 create mode 100644 Documentation/ABI/testing/debugfs-scmi
 create mode 100644 Documentation/ABI/testing/debugfs-scmi-raw
 create mode 100644 Documentation/devicetree/bindings/firmware/amlogic,m=
eson-gxbb-sm.yaml
 delete mode 100644 Documentation/devicetree/bindings/firmware/meson/mes=
on_sm.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/mediatek,mt635=
7.yaml
 delete mode 100644 Documentation/devicetree/bindings/mfd/qcom-rpm.txt
 create mode 100644 Documentation/devicetree/bindings/power/allwinner,su=
n20i-d1-ppu.yaml
 create mode 100644 Documentation/devicetree/bindings/power/starfive,jh7=
110-pmu.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/mediatek/media=
tek,pwrap.yaml
 delete mode 100644 Documentation/devicetree/bindings/soc/mediatek/pwrap=
.txt
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,dcc.=
yaml
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,msm8=
976-ramp-controller.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,pmic=
-glink.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,rpm.=
yaml
 create mode 100644 Documentation/devicetree/bindings/soc/samsung/samsun=
g,exynos-sysreg.yaml
 create mode 100644 drivers/firmware/arm_scmi/raw_mode.c
 create mode 100644 drivers/firmware/arm_scmi/raw_mode.h
 create mode 100644 drivers/power/supply/qcom_battmgr.c
 create mode 100644 drivers/soc/mediatek/mt8188-mmsys.h
 create mode 100644 drivers/soc/mediatek/mt8188-pm-domains.h
 create mode 100644 drivers/soc/mediatek/mtk-regulator-coupler.c
 create mode 100644 drivers/soc/nuvoton/Kconfig
 create mode 100644 drivers/soc/nuvoton/Makefile
 create mode 100644 drivers/soc/nuvoton/wpcm450-soc.c
 create mode 100644 drivers/soc/qcom/pmic_glink.c
 create mode 100644 drivers/soc/qcom/pmic_glink_altmode.c
 create mode 100644 drivers/soc/qcom/ramp_controller.c
 create mode 100644 drivers/soc/renesas/pwc-rzv2m.c
 create mode 100644 drivers/soc/starfive/Kconfig
 create mode 100644 drivers/soc/starfive/Makefile
 create mode 100644 drivers/soc/starfive/jh71xx_pmu.c
 create mode 100644 drivers/soc/sunxi/sun20i-ppu.c
 create mode 100644 include/dt-bindings/firmware/qcom,scm.h
 create mode 100644 include/dt-bindings/power/allwinner,sun20i-d1-ppu.h
 create mode 100644 include/dt-bindings/power/mediatek,mt8188-power.h
 create mode 100644 include/dt-bindings/power/starfive,jh7110-pmu.h
 rename include/linux/{ =3D> firmware/qcom}/qcom_scm.h (96%)
 create mode 100644 include/linux/soc/qcom/pmic_glink.h
