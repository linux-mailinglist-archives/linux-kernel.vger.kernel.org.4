Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 937516ED674
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 23:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232418AbjDXVAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 17:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjDXVAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 17:00:48 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C41836181
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 14:00:45 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 3CB955C01C6;
        Mon, 24 Apr 2023 17:00:45 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Mon, 24 Apr 2023 17:00:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1682370045; x=1682456445; bh=R67JHLqjDvYsWltLRpHjPxHswJem0bDDYtE
        KAoqtVq8=; b=Z5a8O3ZByYNDSgwtwScuVV9S4Ml02mm8GKnhSrZItbCWbUvNSup
        tfS4VBezhYQNFQi+AO+IhvbqYkonwJ3iLUO1nyq/2JNzIly3vVd2nV/NTb+7eex/
        KPoCCzig5q+THcHrkdHWhNjmmpyYO9/cOSiBh6ayjX1pMJf1xk+BDszVqaMXId7R
        AYuxSAFUOR1woOa/9S1DENMEx6w4SaktnRL/YdPZBtI/8rA3M8XX+/62GJEAy2EH
        VkkLWXgy9a6JZjbPGNKsuxAE3gqwJ2psEs27FJ5EjqjQk9CBGUkE7cgLOvvmT48H
        vFgH6MJ5fNtrd1T3L6qdtmR00KskyuLlOGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1682370045; x=1682456445; bh=R67JHLqjDvYsWltLRpHjPxHswJem0bDDYtE
        KAoqtVq8=; b=LemVCJ0pK3Sp5JGGLIqd8dTx3BoveSwx7EWdcAiGF6k6oEHYCk8
        vqyupWn967Gej0HY0pIpmCmK66Wdkq60h0WOYmnBApyBfccNBN0XOk0cTknxKBJg
        Owd5ym1Hd5O9IF4cRUH4Va/lohKwxkuqf28UjiSxA0OpYtOOw95dHvSVFKwNPjOx
        xPhSMx4UQpM/aKXen9W184uygXIwIsC3Fp5fPXtXgfKjArHoNilVMKHRTZdoPxkF
        PpMUW/GqQsYZjyt5bFJyW63MMhV0fByTbrLMuXmc/VJkRRjo8E5gwlvAksLI2Zt4
        mxQFIG8krprSmwH0B1buyhLJb/JDGlgt4pA==
X-ME-Sender: <xms:_e1GZMlFyhH1393HqzcINrINOw8vX40OJ0rcVqEOMUmN5ld0X4fnxQ>
    <xme:_e1GZL1oFDlfJ0SO_SqVqqDExzFOi9WFg4YRpM0AZWdXjCPCtT_OK8MetkRt9Reka
    _igTkRUid1vU7E32Hc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfedutddgudehiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedf
    tehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrf
    grthhtvghrnhepffeludehvedvuedvieefueffheetjeffvdffleefkeelvddvfeehhfdt
    ueefiefgnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdplhhinhgrrhhordhorhhgpd
    hgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:_e1GZKq-Zg9TuaPTC1R7DBBwIcyaYIXw0qb8N19SYpSm5zmIa5nSWg>
    <xmx:_e1GZIlWp1MzQJbZ9ohcHu1Vaw8qQ35-WE6U4yAtcS6Oqk_-a7p6QA>
    <xmx:_e1GZK2yjsbXqHsUmSWiu9cOidteCcXaObsOBfT-Xzf0wvuVnS_8xw>
    <xmx:_e1GZP9JdWsaNGzmAAXj9wnfwq2bQLbtHcUY11ydvcF5enVlBj5-7Q>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id E8949B60086; Mon, 24 Apr 2023 17:00:44 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-374-g72c94f7a42-fm-20230417.001-g72c94f7a
Mime-Version: 1.0
Message-Id: <4871b5e5-c1ef-484e-990c-b585d4446ff8@app.fastmail.com>
In-Reply-To: <bbd25997-173e-4c3b-930c-65c6232908e3@app.fastmail.com>
References: <bbd25997-173e-4c3b-930c-65c6232908e3@app.fastmail.com>
Date:   Mon, 24 Apr 2023 23:00:23 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Linus Torvalds" <torvalds@linux-foundation.org>
Cc:     soc@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL 2/4] ARM: SoC drivers for v6.4
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
rivers-6.4

for you to fetch changes up to 4c87f3ff78b20da0dd118762fd66b67a98e36249:

  Merge tag 'scmi-updates-6.4' of git://git.kernel.org/pub/scm/linux/ker=
nel/git/sudeep.holla/linux into soc/drivers (2023-04-17 17:38:42 +0200)

----------------------------------------------------------------
ARM: SoC drivers for v6.4

The most notable updates this time are for Qualcomm Snapdragon platforms.
The Inline-Crypto-Engine gets a new DT binding and driver. A number of
drivers now support additional Snapdragon variants, in particular the
rsc, scm, geni, bwm, glink and socinfo, while the llcc (edac) and rpm
drivers get notable functionality updates.

Updates on other platforms include:

 - Various updates to the Mediatek mutex and mmsys drivers, including
   support for the Helio X10 SoC

 - Support for unidirectional mailbox channels in Arm SCMI firmware

 - Support for per cpu asynchronous notification in OP-TEE firmware

 - Minor updates for memory controller drivers.

 - Minor updates for Renesas, TI, Amlogic, Apple, Broadcom, Tegra,
   Allwinner, Versatile Express, Canaan, Microchip, Mediatek and i.MX
   SoC drivers, mainly updating the use of MODULE_LICENSE() macros and
   obsolete DT driver interfaces.

----------------------------------------------------------------
Abel Vesa (2):
      soc: qcom: Make the Qualcomm UFS/SDCC ICE a dedicated driver
      dt-bindings: crypto: Add Qualcomm Inline Crypto Engine

Alexander Stein (1):
      firmware: imx: scu: use dev_err_probe

Alexandre Mergnat (5):
      dt-bindings: soc: mediatek: specify which compatible requires cloc=
ks property
      dt-bindings: soc: mediatek: add display mutex for MT8365 SoC
      dt-bindings: memory-controllers: mediatek,smi-common: add mt8365
      dt-bindings: memory-controllers: mediatek,smi-larb: add mt8365
      memory: mtk-smi: mt8365: Add SMI Support

AngeloGioacchino Del Regno (13):
      soc: mediatek: mtk-mmsys: Add .remove() callback
      soc: mediatek: mtk-mmsys: Use module_platform_driver() macro
      soc: mediatek: mtk-mmsys: Compress of_device_id array entries
      soc: mediatek: mtk-mmsys: Add MODULE_DEVICE_TABLE() to allow auto-=
load
      soc: mediatek: mtk-mutex: Compress of_device_id array entries
      soc: mediatek: mtk-mutex: Replace max handles number with definiti=
on
      soc: mediatek: mtk-mutex: Use module_platform_driver() macro
      soc: mediatek: cmdq: Add inline functions for !CONFIG_MTK_CMDQ
      soc: mediatek: Cleanup ifdefs for IS_REACHABLE(CONFIG_MTK_CMDQ)
      soc: mediatek: mtk-mmsys: Split out MT8173 mmsys DDP routing table
      soc: mediatek: mtk-mmsys: Change MT8173 num_resets to 64
      soc: mediatek: mtk-mmsys: Add support for MT6795 Helio X10
      soc: mediatek: Kconfig: Add MTK_CMDQ dependency to MTK_MMSYS

Arnd Bergmann (22):
      Merge tag 'renesas-drivers-for-v6.4-tag1' of git://git.kernel.org/=
pub/scm/linux/kernel/git/geert/renesas-devel into soc/drivers
      Merge tag 'omap-for-v6.4/ti-sysc-signed' of git://git.kernel.org/p=
ub/scm/linux/kernel/git/tmlind/linux-omap into soc/drivers
      Merge tag 'memory-controller-drv-6.4' of https://git.kernel.org/pu=
b/scm/linux/kernel/git/krzk/linux-mem-ctrl into soc/drivers
      Merge tag 'optee-per-cpu-irq-for-v6.4' of https://git.linaro.org/p=
eople/jens.wiklander/linux-tee into soc/drivers
      Merge tag 'amlogic-drivers-for-v6.4' of https://git.kernel.org/pub=
/scm/linux/kernel/git/amlogic/linux into soc/drivers
      Merge tag 'optee-load-for-v6.4' of https://git.linaro.org/people/j=
ens.wiklander/linux-tee into soc/drivers
      Merge tag 'asahi-soc-rtkit-6.4' of https://github.com/AsahiLinux/l=
inux into soc/drivers
      Merge tag 'tegra-for-6.4-arm-core' of git://git.kernel.org/pub/scm=
/linux/kernel/git/tegra/linux into soc/drivers
      Merge tag 'tegra-for-6.4-soc' of git://git.kernel.org/pub/scm/linu=
x/kernel/git/tegra/linux into soc/drivers
      Merge tag 'tegra-for-6.4-firmware' of git://git.kernel.org/pub/scm=
/linux/kernel/git/tegra/linux into soc/drivers
      Merge tag 'riscv-soc-for-v6.4' of https://git.kernel.org/pub/scm/l=
inux/kernel/git/conor/linux into soc/drivers
      Merge tag 'imx-drivers-6.4' of git://git.kernel.org/pub/scm/linux/=
kernel/git/shawnguo/linux into soc/drivers
      Merge tag 'sunxi-drivers-for-6.4-1' of https://git.kernel.org/pub/=
scm/linux/kernel/git/sunxi/linux into soc/drivers
      Merge tag 'renesas-drivers-for-v6.4-tag2' of git://git.kernel.org/=
pub/scm/linux/kernel/git/geert/renesas-devel into soc/drivers
      Merge tag 'ti-driver-soc-for-v6.4' of git://git.kernel.org/pub/scm=
/linux/kernel/git/ti/linux into soc/drivers
      Merge tag 'qcom-drivers-for-6.4' of https://git.kernel.org/pub/scm=
/linux/kernel/git/qcom/linux into soc/drivers
      Merge tag 'arm-soc/for-6.4/drivers' of https://github.com/Broadcom=
/stblinux into soc/drivers
      Merge tag 'qcom-drivers-for-6.4-2' of https://git.kernel.org/pub/s=
cm/linux/kernel/git/qcom/linux into soc/drivers
      Merge tag 'v6.3-next-soc' of https://git.kernel.org/pub/scm/linux/=
kernel/git/matthias.bgg/linux into soc/drivers
      Merge tag 'memory-controller-drv-6.4-2' of https://git.kernel.org/=
pub/scm/linux/kernel/git/krzk/linux-mem-ctrl into soc/drivers
      Merge tag 'vexpress-update-6.4' of git://git.kernel.org/pub/scm/li=
nux/kernel/git/sudeep.holla/linux into soc/drivers
      Merge tag 'scmi-updates-6.4' of git://git.kernel.org/pub/scm/linux=
/kernel/git/sudeep.holla/linux into soc/drivers

Asahi Lina (1):
      soc: apple: rtkit: Fix buffer address field width

Bartosz Golaszewski (3):
      soc: qcom: smem: update max processor count
      dt-bindings: arm: qcom: add the SoC ID for SA8775P
      soc: qcom: socinfo: add support for SA8775P

Bhupesh Sharma (2):
      dt-bindings: arm: qcom,ids: Add IDs for QRB4210
      soc: qcom: socinfo: Add IDs for QRB4210

Bjorn Andersson (1):
      Merge tag '20230407105029.2274111-4-abel.vesa@linaro.org' into dri=
vers-for-6.4

Christophe JAILLET (1):
      firmware: arm_scmi: Use the bitmap API to allocate bitmaps

Christophe Kerello (1):
      memory: stm32-fmc2-ebi: depends on ARCH_STM32 instead of MACH_STM3=
2MP157

Clark Wang (1):
      firmware: imx: scu-pd: add missed lvds lpi2c and pwm power domains

Conor Dooley (10):
      mailbox: mpfs: fix an incorrect mask width
      mailbox: mpfs: switch to txdone_poll
      mailbox: mpfs: ditch a useless busy check
      mailbox: mpfs: check the service status in .tx_done()
      soc: microchip: mpfs: fix some horrible alignment
      soc: microchip: mpfs: use a consistent completion timeout
      soc: microchip: mpfs: simplify error handling in mpfs_blocking_tra=
nsaction()
      soc: microchip: mpfs: handle timeouts and failed services differen=
tly
      Merge patch series "mailbox,soc: mpfs: add support for fallible se=
rvices"
      soc: microchip: mpfs: add a prefix to rx_callback()

Cristian Marussi (5):
      firmware: arm_scmi: Fix raw coexistence mode behaviour on failure =
path
      firmware: arm_scmi: Fix device node validation for mailbox transpo=
rt
      firmware: arm_scmi: Fix xfers allocation on Rx channel
      dt-bindings: firmware: arm,scmi: Support mailboxes unidirectional =
channels
      firmware: arm_scmi: Add support for unidirectional mailbox channels

Dan Carpenter (2):
      firmware: arm_scmi: Clean up a return statement in scmi_probe
      firmware: arm_scmi: Return a literal instead of a variable

Danila Tikhonov (2):
      dt-bindings: arm: msm: Add LLCC for SM7150
      soc: qcom: llcc: Add configuration data for SM7150

David Wronek (2):
      dt-bindings: arm: qcom,ids: Add Soc ID for SM7150
      soc: qcom: socinfo: Add Soc ID for SM7150

Devi Priya (1):
      dt-bindings: soc: qcom: smd-rpm: Add IPQ9574 compatible

Diogo Ivo (2):
      memory: tegra: remove redundant variable initialization
      memory: tegra: read values from correct device

Dmitry Rokosov (1):
      firmware: meson_sm: populate platform devices from sm device tree =
data

Elliot Berman (1):
      firmware: qcom_scm: Use fixed width src vm bitmap

Etienne Carriere (2):
      dt-bindings: optee driver interrupt can be a per-cpu interrupt
      optee: add per cpu asynchronous notification

Florian Fainelli (1):
      soc: bcm: brcmstb: Remove bare-metal ARM suspend/resume code

Geert Uytterhoeven (3):
      soc: renesas: rmobile-sysc: Use of_fwnode_handle() helper
      soc: renesas: Use "#ifdef" for single-symbol definition checks
      MAINTAINERS: renesas: Add "renesas," file contents pattern

Jason Wang (1):
      bus: ti-sysc: Fix comment typo

Jeffrey Kardatzke (1):
      tee: optee: Add SMC for loading OP-TEE image

Jesse Taube (1):
      soc: canaan: Make K210_SYSCTL depend on CLK_K210

Jindong Yue (7):
      soc: imx: imx8mp-blk-ctrl: Use dev_pm_domain_attach_by_name
      soc: imx: imx8mp-blk-ctrl: Fix typo of imx8m_blk_ctrl_of_match
      soc: imx: imx8mp-blk-ctrl: Add MODULE_LICENSE
      soc: imx: imx8m-blk-ctrl: Use dev_pm_domain_attach_by_name
      soc: imx: imx8m-blk-ctrl: Add MODULE_LICENSE
      soc: imx8m: Add MODULE_LICENSE
      soc: imx8m: Support building imx8m soc driver as module

Jon Hunter (1):
      soc/tegra: pmc: Add the PMIC wake event for Tegra234

Kartik (1):
      soc/tegra: fuse: Remove nvmem root only access

Kathiravan T (1):
      dt-bindings: firmware: qcom,scm: document IPQ5332 SCM

Konrad Dybcio (18):
      soc: qcom: socinfo: Add some PMICs
      dt-bindings: arm: qcom,ids: Add IDs for QCM2290/QRB2210
      soc: qcom: socinfo: Add IDs for QCM2290/QRB2210
      soc: qcom: rpmpd: Remove SoC names from RPMPD definitions
      soc: qcom: rpmpd: Bring all definitions to the top
      soc: qcom: rpmpd: Unify Low Power Island definitions
      soc: qcom: rpmpd: Remove vdd* from struct names
      soc: qcom: rpmpd: Expand struct definition macros
      soc: qcom: rpmpd: Improve the naming
      soc: qcom: rpmpd: Make bindings assignments consistent
      soc: qcom: rpmpd: Add parent PD support
      soc: qcom: rpmpd: Hook up VDDMX as parent of SM6375 VDDGX
      soc: qcom: rpmpd: Remove useless comments
      firmware: qcom_scm: Add SM6375 compatible
      soc: qcom: icc-bwmon: Remove unused struct member
      soc: qcom: icc-bwmon: Handle global registers correctly
      dt-bindings: sram: qcom,imem: document SM6375 IMEM
      dt-bindings: firmware: document Qualcomm QCM2290 SCM

Krzysztof Kozlowski (6):
      soc: qcom: gsbi: mark OF related data as maybe unused
      soc: qcom: restrict L2 accessors to ARM64 build tests
      dt-bindings: soc: qcom,apr: correct qcom,intents type
      soc: renesas: mark OF related data as maybe unused
      soc: renesas: pwc-rzv2m: drop of_match_ptr for ID table
      dt-bindings: soc: qcom: smd-rpm: re-add missing qcom,rpm-msm8994

Li Yang (1):
      soc: renesas: renesas-soc: Release 'chipid' from ioremap()

Manivannan Sadhasivam (5):
      dt-bindings: arm: msm: Update the maintainers for LLCC
      dt-bindings: arm: msm: Fix register regions used for LLCC banks
      qcom: llcc/edac: Fix the base address used for accessing LLCC banks
      qcom: llcc/edac: Support polling mode for ECC handling
      soc: qcom: llcc: Do not create EDAC platform device on SDM845

Marek Vasut (1):
      soc: imx: imx8m-blk-ctrl: Scan subnodes and bind drivers to them

Martin Povi=C5=A1er (1):
      soc: apple: rtkit: Crop syslog messages

Matthias Brugger (1):
      soc: mediatek: mtk-svs: delete node name check

Melody Olvera (2):
      dt-bindings: firmware: qcom,scm: Update QDU1000/QRU1000 compatible
      dt-bindings: soc: qcom: aoss: Document QDU1000/QRU1000 compatible

Miaoqian Lin (1):
      soc: ti: pm33xx: Fix refcount leak in am33xx_pm_probe

Mikko Perttunen (2):
      firmware: tegra: bpmp: Fix error paths in debugfs
      soc/tegra: bpmp: Actually free memory on error path

Muhammad Usama Anjum (1):
      soc/tegra: cbb: remove linux/version.h

Mukesh Ojha (1):
      firmware: qcom_scm: Clear download bit during reboot

Neil Armstrong (4):
      dt-bindings: soc: amlogic: convert clk-measure.txt to dt-schema
      dt-bindings: soc: qcom: qcom,pmic-glink: document SM8450 compatible
      dt-bindings: soc: qcom: qcom,pmic-glink: document SM8550 compatible
      soc: qcom: pmic_glink: register ucsi aux device

Nick Alcock (7):
      memory: tegra: remove MODULE_LICENSE in non-modules
      memory: remove MODULE_LICENSE in non-modules
      kbuild, soc: sunxi: sram: remove MODULE_LICENSE in non-modules
      kbuild, soc: bcm: raspberrypi-power: remove MODULE_LICENSE in non-=
modules
      kbuild, soc: bcm: bcm2835-power: remove MODULE_LICENSE in non-modu=
les
      ARM: tegra: Remove MODULE_LICENSE in non-modules
      soc/tegra: cbb: Remove MODULE_LICENSE in non-modules

Nicolas Frayer (1):
      soc: ti: k3-ringacc: Add try_module_get() to k3_dmaring_request_du=
al_ring()

Peng Fan (1):
      soc: imx: imx8m-blk-ctrl: reordering the fields

Petlozu Pravareshwar (1):
      soc/tegra: pmc: Support software wake-up for SPE

Poovendhan Selvaraj (1):
      dt-bindings: scm: Add compatible for IPQ9574

Rob Clark (1):
      soc: qcom: smd-rpm: Use GFP_ATOMIC in write path

Rob Herring (12):
      bus: imx-weim: Remove open coded "ranges" parsing
      soc: ti: Use of_property_present() for testing DT property presence
      soc: ti: Use of_property_read_bool() for boolean properties
      memory: atmel-ebi: Use of_property_present() for testing DT proper=
ty presence
      soc: qcom: Use of_property_present() for testing DT property prese=
nce
      soc: sunxi: Use of_property_present() for testing DT property pres=
ence
      bus: ti-sysc: Remove open coded "ranges" parsing
      bus: ti-sysc: Use of_property_present() for testing DT property pr=
esence
      dt-bindings: soc: amlogic: Drop unneeded quotes
      dt-bindings: memory-controller: Drop unneeded quotes
      firmware: Use of_property_present() for testing DT property presen=
ce
      bus: vexpress-config: Add explicit of_platform.h include

Roger Lu (4):
      soc: mediatek: mtk-svs: use svs get efuse common function
      soc: mediatek: mtk-svs: use common function to disable restore vol=
tages
      soc: mediatek: mtk-svs: fix passing zero to 'PTR_ERR'
      soc: mediatek: mtk-svs: add thermal voltage compensation if needed

Roy-CW.Yeh (4):
      dt-bindings: soc: mediatek: Add support for MT8195 VPPSYS
      soc: mediatek: mmsys: add config api for RSZ switching and DCM
      soc: mediatek: mutex: Add mtk_mutex_set_mod support to set MOD1
      soc: mediatek: mutex: support MT8195 VPPSYS

Siddharth Vadapalli (1):
      soc: ti: k3-socinfo: Add entry for J784S4 SOC

Sushil Singh (1):
      soc/tegra: pmc: Add wake source interrupt for MGBE

Tushar Nimkar (1):
      soc: qcom: rpmh-rsc: Support RSC v3 minor versions

Uwe Kleine-K=C3=B6nig (2):
      soc: tegra: cbb: Drop empty platform remove function
      soc: ti: smartreflex: Simplify getting the opam_sr pointer

Varadarajan Narayanan (2):
      dt-bindings: arm: qcom,ids: Add IDs for IPQ9574 and its variants
      soc: qcom: socinfo: Add IDs for IPQ9574 and its variants

Vinod Koul (1):
      dt-bindings: firmware: document Qualcomm SC8180X SCM

Visweswara Tanuku (1):
      soc: qcom: geni-se: Update Tx and Rx fifo depth based on QUP HW ve=
rsion

Wolfram Sang (2):
      soc: renesas: rcar-sysc: Remove R-Car H3 ES1.* handling
      soc: renesas: Remove r8a77950 arch

Yang Li (1):
      soc: ti: Use devm_platform_ioremap_resource()

Yang Yingliang (2):
      bus: ti-sysc: Use list_for_each_entry() helper
      soc/tegra: cbb: tegra194: Use of_address_count() helper

Ye Xingchen (6):
      firmware: arm_scmi: Remove duplicate include header inclusion
      bus: brcmstb_gisb: Use=C2=A0devm_platform_get_and_ioremap_resource=
()
      soc: qcom: smsm: Use dev_err_probe()
      soc: amlogic: meson-pwrc: Use dev_err_probe()
      soc: mediatek: mutex: Use dev_err_probe()
      soc/tegra: flowctrl: Use devm_platform_get_and_ioremap_resource()

Zhaoyang Li (1):
      soc: bcm: brcmstb: biuctrl: fix of_iomap leak

 .../arm/amlogic/amlogic,meson-gx-ao-secure.yaml    |   4 +-
 .../arm/amlogic/amlogic,meson-mx-secbus2.yaml      |   4 +-
 .../bindings/arm/firmware/linaro,optee-tz.yaml     |   3 +-
 .../devicetree/bindings/arm/msm/qcom,llcc.yaml     | 129 ++-
 .../bindings/crypto/qcom,inline-crypto-engine.yaml |  42 +
 .../devicetree/bindings/firmware/arm,scmi.yaml     |  48 +-
 .../devicetree/bindings/firmware/qcom,scm.yaml     |   7 +
 .../memory-controllers/mediatek,smi-common.yaml    |   2 +
 .../memory-controllers/mediatek,smi-larb.yaml      |   4 +
 .../bindings/memory-controllers/renesas,dbsc.yaml  |   4 +-
 .../memory-controllers/renesas,rpc-if.yaml         |   2 +-
 .../memory-controllers/samsung,exynos5422-dmc.yaml |   6 +-
 .../bindings/soc/amlogic/amlogic,canvas.yaml       |   4 +-
 .../soc/amlogic/amlogic,meson-gx-clk-measure.yaml  |  40 +
 .../bindings/soc/amlogic/clk-measure.txt           |  21 -
 .../bindings/soc/mediatek/mediatek,mutex.yaml      |  22 +-
 .../bindings/soc/qcom/qcom,aoss-qmp.yaml           |   1 +
 .../devicetree/bindings/soc/qcom/qcom,apr.yaml     |   9 +-
 .../bindings/soc/qcom/qcom,pmic-glink.yaml         |   2 +
 .../devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml |   3 +
 .../devicetree/bindings/sram/qcom,imem.yaml        |   1 +
 Documentation/staging/tee.rst                      |  53 ++
 MAINTAINERS                                        |   1 +
 drivers/amba/tegra-ahb.c                           |   1 -
 drivers/bus/brcmstb_gisb.c                         |   4 +-
 drivers/bus/imx-weim.c                             |  19 +-
 drivers/bus/ti-sysc.c                              |  53 +-
 drivers/bus/vexpress-config.c                      |   2 +-
 drivers/edac/qcom_edac.c                           |  64 +-
 drivers/firmware/arm_scmi/bus.c                    |   3 +-
 drivers/firmware/arm_scmi/driver.c                 |  16 +-
 drivers/firmware/arm_scmi/mailbox.c                | 120 ++-
 drivers/firmware/arm_scmi/optee.c                  |   2 +-
 drivers/firmware/imx/imx-scu.c                     |   5 +-
 drivers/firmware/imx/scu-pd.c                      |   4 +
 drivers/firmware/meson/meson_sm.c                  |   5 +-
 drivers/firmware/qcom_scm.c                        |  16 +-
 drivers/firmware/tegra/bpmp-debugfs.c              |  12 +-
 drivers/firmware/tegra/bpmp.c                      |   6 +-
 drivers/mailbox/mailbox-mpfs.c                     |  55 +-
 drivers/memory/Kconfig                             |   2 +-
 drivers/memory/atmel-ebi.c                         |   2 +-
 drivers/memory/bt1-l2-ctl.c                        |   1 -
 drivers/memory/da8xx-ddrctl.c                      |   1 -
 drivers/memory/fsl_ifc.c                           |   1 -
 drivers/memory/mtk-smi.c                           |   6 +
 drivers/memory/mvebu-devbus.c                      |   1 -
 drivers/memory/tegra/mc.c                          |   1 -
 drivers/memory/tegra/tegra186-emc.c                |   1 -
 drivers/memory/tegra/tegra210-emc-cc-r21021.c      |   2 +-
 drivers/memory/tegra/tegra210-emc-table.c          |   2 -
 drivers/misc/fastrpc.c                             |   2 +-
 drivers/net/wireless/ath/ath10k/qmi.c              |   4 +-
 drivers/remoteproc/qcom_q6v5_mss.c                 |   8 +-
 drivers/remoteproc/qcom_q6v5_pas.c                 |   2 +-
 drivers/soc/amlogic/meson-gx-pwrc-vpu.c            |   8 +-
 drivers/soc/apple/rtkit.c                          |  16 +-
 drivers/soc/bcm/bcm2835-power.c                    |   1 -
 drivers/soc/bcm/brcmstb/Kconfig                    |   4 +-
 drivers/soc/bcm/brcmstb/biuctrl.c                  |   4 +
 drivers/soc/bcm/brcmstb/pm/Makefile                |   1 -
 drivers/soc/bcm/brcmstb/pm/aon_defs.h              | 105 ---
 drivers/soc/bcm/brcmstb/pm/pm-arm.c                | 874 --------------=
-------
 drivers/soc/bcm/brcmstb/pm/s2-arm.S                |  69 --
 drivers/soc/bcm/raspberrypi-power.c                |   1 -
 drivers/soc/canaan/Kconfig                         |   5 +-
 drivers/soc/imx/Kconfig                            |   2 +-
 drivers/soc/imx/imx8m-blk-ctrl.c                   |  11 +-
 drivers/soc/imx/imx8mp-blk-ctrl.c                  |   5 +-
 drivers/soc/imx/soc-imx8m.c                        |   1 +
 drivers/soc/mediatek/Kconfig                       |   1 +
 drivers/soc/mediatek/mt8173-mmsys.h                |  95 +++
 drivers/soc/mediatek/mt8195-mmsys.h                |  13 +
 drivers/soc/mediatek/mtk-mmsys.c                   | 195 ++---
 drivers/soc/mediatek/mtk-mmsys.h                   |   2 +-
 drivers/soc/mediatek/mtk-mutex.c                   | 218 +++--
 drivers/soc/mediatek/mtk-svs.c                     | 149 ++--
 drivers/soc/microchip/mpfs-sys-controller.c        |  56 +-
 drivers/soc/qcom/Kconfig                           |   6 +-
 drivers/soc/qcom/Makefile                          |   1 +
 drivers/soc/qcom/icc-bwmon.c                       | 231 +++++-
 drivers/soc/qcom/ice.c                             | 366 +++++++++
 drivers/soc/qcom/llcc-qcom.c                       | 104 ++-
 drivers/soc/qcom/pmic_glink.c                      |  65 +-
 drivers/soc/qcom/qcom_aoss.c                       |   2 +-
 drivers/soc/qcom/qcom_gsbi.c                       |   2 +-
 drivers/soc/qcom/rmtfs_mem.c                       |   2 +-
 drivers/soc/qcom/rpmh-rsc.c                        |   2 +-
 drivers/soc/qcom/rpmpd.c                           | 833 +++++++++++++-=
------
 drivers/soc/qcom/smd-rpm.c                         |   2 +-
 drivers/soc/qcom/smem.c                            |   4 +-
 drivers/soc/qcom/smsm.c                            |  11 +-
 drivers/soc/qcom/socinfo.c                         |  16 +
 drivers/soc/renesas/Kconfig                        |   7 -
 drivers/soc/renesas/pwc-rzv2m.c                    |   2 +-
 drivers/soc/renesas/r8a7795-sysc.c                 |  10 -
 drivers/soc/renesas/renesas-soc.c                  |  19 +-
 drivers/soc/renesas/rmobile-sysc.c                 |   2 +-
 drivers/soc/sunxi/sunxi_mbus.c                     |   2 +-
 drivers/soc/sunxi/sunxi_sram.c                     |   1 -
 drivers/soc/tegra/cbb/tegra-cbb.c                  |   1 -
 drivers/soc/tegra/cbb/tegra194-cbb.c               |   6 +-
 drivers/soc/tegra/cbb/tegra234-cbb.c               |   8 -
 drivers/soc/tegra/flowctrl.c                       |   4 +-
 drivers/soc/tegra/fuse/fuse-tegra.c                |   4 +-
 drivers/soc/tegra/pmc.c                            |  26 +-
 drivers/soc/tegra/powergate-bpmp.c                 |   2 +-
 drivers/soc/ti/k3-ringacc.c                        |   7 +
 drivers/soc/ti/k3-socinfo.c                        |   1 +
 drivers/soc/ti/knav_dma.c                          |   4 +-
 drivers/soc/ti/knav_qmss_acc.c                     |   2 +-
 drivers/soc/ti/knav_qmss_queue.c                   |   4 +-
 drivers/soc/ti/omap_prm.c                          |   2 +-
 drivers/soc/ti/pm33xx.c                            |   5 +-
 drivers/soc/ti/smartreflex.c                       |  30 +-
 drivers/soc/ti/wkup_m3_ipc.c                       |   6 +-
 drivers/tee/optee/Kconfig                          |  17 +
 drivers/tee/optee/optee_msg.h                      |  12 +
 drivers/tee/optee/optee_private.h                  |  24 +
 drivers/tee/optee/optee_smc.h                      |  24 +
 drivers/tee/optee/smc_abi.c                        | 259 +++++-
 include/dt-bindings/arm/qcom,ids.h                 |  11 +
 include/dt-bindings/power/r8a7795-sysc.h           |   1 -
 include/linux/firmware/qcom/qcom_scm.h             |   2 +-
 include/linux/soc/mediatek/mtk-cmdq.h              | 114 +++
 include/linux/soc/mediatek/mtk-mmsys.h             |   6 +
 include/linux/soc/mediatek/mtk-mutex.h             |  35 +
 include/linux/soc/qcom/geni-se.h                   |  42 +-
 include/linux/soc/qcom/llcc-qcom.h                 |   6 +-
 include/soc/qcom/ice.h                             |  37 +
 130 files changed, 3047 insertions(+), 2016 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/crypto/qcom,inline=
-crypto-engine.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/amlogic/amlogi=
c,meson-gx-clk-measure.yaml
 delete mode 100644 Documentation/devicetree/bindings/soc/amlogic/clk-me=
asure.txt
 delete mode 100644 drivers/soc/bcm/brcmstb/pm/aon_defs.h
 delete mode 100644 drivers/soc/bcm/brcmstb/pm/pm-arm.c
 delete mode 100644 drivers/soc/bcm/brcmstb/pm/s2-arm.S
 create mode 100644 drivers/soc/mediatek/mt8173-mmsys.h
 create mode 100644 drivers/soc/qcom/ice.c
 create mode 100644 include/soc/qcom/ice.h
