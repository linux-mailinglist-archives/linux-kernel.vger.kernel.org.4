Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1B366487A6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 18:22:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbiLIRVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 12:21:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbiLIRVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 12:21:43 -0500
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D7BC1C42A
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 09:21:39 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 7F11F32005B5;
        Fri,  9 Dec 2022 12:21:37 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Fri, 09 Dec 2022 12:21:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1670606497; x=
        1670692897; bh=qNGDdLQtmRGQO81DNZpaNou8soo7m7mUh68lOczmjZk=; b=T
        QEWee7hX+dB35VB22fw8ObPyNUlTNHExMEFcCerGntiTOL7ujaXTTg2TX6enboAK
        87BIxsTmpkOpRFeJCyAHN835NkDGTRbumRMs4HPGmCWs2CkWfQyVt1z6Cfj441T1
        e6/oTFvKH3F43eyFUSK00/1lDY/tLd8CgU5Tgpj5ZaQSHeImQak5lknwmJlefz3n
        b32/nrWuieots+z22Srk1Epp6kI80LE1uZwY46P3k9f4b/R1MiDbcPNRot9gxZPU
        IJfSZ+qc5Fmi9bILVhfFpE6gmHiEj88oGnmUtaIfBdGe6C7REalG7thn0T4YZorA
        lIr8aW1KwGdllT2AvA17g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1670606497; x=
        1670692897; bh=qNGDdLQtmRGQO81DNZpaNou8soo7m7mUh68lOczmjZk=; b=R
        cD03AzWwtW+Q3AAJBnObVtXeXqlHixNU/5SucRtuHUI142F8liDZR4XIxA/R3i5O
        Fb4PUuJXxB0bGTOxUuY6MTi7zpOZSViFclUM5XikRl2791e7bKd+ZHyFX/ZfO98S
        k5brX8CYvUZ2LIR/7gbTY0m6zjLza2d8FT5zrGAPHq20uJeWxmqYt+LGmqKbeCg1
        HCPmuINGGi8eE1TnpgiAa1aG0+brTYEieSK0nRuiW0TFfR+JbrBE/pEFv4D+5nHy
        gWVBSdnmWmLovlYQ40YP+s1Mq8gJgy4g3YQCqiXFn2sIMizusUf/Jxo17p0x1881
        I3+sBO1tBX6WpYh2DBJxQ==
X-ME-Sender: <xms:oW6TY558yCu9SRB89J0cPwKp8_FzkgSjP-uRdeZEQZWuTkM8EHDVMw>
    <xme:oW6TY24f8fGgG9GueX2oMtVVMWfFuhO5ziPrWlnnuDep_lVuVbp9aoUPqf5wKKwTY
    TbxacmnoMz887BrE2U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvddvgdeljecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffeludehvedvuedvieefueffheetjeffvdffleefkeelvddvfeehhfdtueef
    iefgnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdplhhinhgrrhhordhorhhgpdhgih
    hthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:oW6TYweOr_qjsnctAp-tT3Rd9ODDBkGvEAHXVPBAshkI1gTILX2qcA>
    <xmx:oW6TYyIvsbuGhH4_uVwPE3PVBNwMiQ6gfDB4XCbPDM2AwnVDZGAEXA>
    <xmx:oW6TY9JhZUbLkll_rGMyKHcjGdvLls4-s5Q2Zx0iMJskmUAo1nw8dA>
    <xmx:oW6TY7g8XkcyG79IaOti_QcheaaAesVQsSimXkHrlaBOQ-c41GVzIA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 0144EB60086; Fri,  9 Dec 2022 12:21:36 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1115-g8b801eadce-fm-20221102.001-g8b801ead
Mime-Version: 1.0
Message-Id: <07ecf411-70a8-4c15-b3ba-378072c14a02@app.fastmail.com>
In-Reply-To: <257c9d3c-5bfa-4c5a-8ba3-11982a00b1d3@app.fastmail.com>
References: <257c9d3c-5bfa-4c5a-8ba3-11982a00b1d3@app.fastmail.com>
Date:   Fri, 09 Dec 2022 18:21:15 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Linus Torvalds" <torvalds@linux-foundation.org>
Cc:     soc@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL 3/4] SoC driver updates for 6.2
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

The following changes since commit 247f34f7b80357943234f93f247a1ae6b6c3a=
740:

  Linux 6.1-rc2 (2022-10-23 15:27:33 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-d=
rivers-6.2

for you to fetch changes up to 9379885d07c466a9207e88c0fd0c8b3541536fe3:

  Merge tag 'qcom-drivers-for-6.2-2' of https://git.kernel.org/pub/scm/l=
inux/kernel/git/qcom/linux into soc/drivers (2022-12-07 22:07:48 +0100)

----------------------------------------------------------------
SoC driver updates for 6.2

There are few major updates in the SoC specific drivers, mainly the usual
reworks and support for variants of the existing SoC.  While this remains
Arm centric for the most part, the branch now also contains updates to
risc-v and loongarch specific code in drivers/soc/.

Notable changes include:

 - Support for the newly added Qualcomm Snapdragon variants
   (MSM8956, MSM8976, SM6115, SM4250, SM8150, SA8155 and SM8550) in the
   soc ID, rpmh, rpm, spm and powerdomain drivers.

 - Documentation for the somewhat controversial qcom,board-id
   properties that are required for booting a number of machines

 - A new SoC identification driver for the loongson-2 (loongarch)
   platform

 - memory controller updates for stm32, tegra, and renesas.

 - a new DT binding to better describe LPDDR2/3/4/5 chips in
   the memory controller subsystem

 - Updates for Tegra specific drivers across multiple subsystems,
   improving support for newer SoCs and better identification

 - Minor fixes for Broadcom, Freescale, Apple, Renesas, Sifive,
   TI, Mediatek and Marvell SoC drivers

----------------------------------------------------------------
Abel Vesa (9):
      dt-bindings: power: rpmpd: Add SM8550 to rpmpd binding
      soc: qcom: rpmhpd: Add SM8550 power domains
      soc: qcom: rpmh-rsc: Add support for RSC v3 register offsets
      soc: qcom: rpmh-rsc: Avoid unnecessary checks on irq-done response
      soc: qcom: socinfo: Add SM8550 ID
      soc: qcom: llcc: Add v4.1 HW version support
      dt-bindings: arm: msm: Add LLCC compatible for SM8550
      soc: qcom: llcc: Add configuration data for SM8550
      dt-bindings: soc: qcom: aoss: Add compatible for SM8550

AngeloGioacchino Del Regno (5):
      dt-bindings: soc: qcom: spm: Add compatibles for MSM8976 L2
      soc: qcom: spm: Implement support for SAWv2.3, MSM8976 L2 PM
      dt-bindings: soc: qcom: qcom,smd-rpm: Use qcom,smd-channels on MSM=
8976
      dt-bindings: arm: qcom,ids: Add SoC IDs for MSM8956 and MSM8976
      soc: qcom: socinfo: Add MSM8956/76 SoC IDs to the soc_id table

Arnd Bergmann (18):
      Merge tag 'memory-controller-drv-6.2' of https://git.kernel.org/pu=
b/scm/linux/kernel/git/krzk/linux-mem-ctrl into arm/drivers
      Merge tag 'renesas-drivers-for-v6.2-tag1' of git://git.kernel.org/=
pub/scm/linux/kernel/git/geert/renesas-devel into arm/drivers
      Merge tag 'optee-for-6.2' of https://git.linaro.org/people/jens.wi=
klander/linux-tee into soc/drivers
      Merge tag 'renesas-drivers-for-v6.2-tag2' of git://git.kernel.org/=
pub/scm/linux/kernel/git/geert/renesas-devel into soc/drivers
      Merge tag 'imx-drivers-6.2' of git://git.kernel.org/pub/scm/linux/=
kernel/git/shawnguo/linux into soc/drivers
      Merge tag 'memory-controller-drv-6.2-2' of https://git.kernel.org/=
pub/scm/linux/kernel/git/krzk/linux-mem-ctrl into soc/drivers
      Merge tag 'riscv-soc-for-v6.2-mw0' of https://git.kernel.org/pub/s=
cm/linux/kernel/git/conor/linux into soc/drivers
      Merge tag 'tegra-for-6.2-soc-v2' of git://git.kernel.org/pub/scm/l=
inux/kernel/git/tegra/linux into soc/drivers
      Merge tag 'tegra-for-6.2-firmware-v2' of git://git.kernel.org/pub/=
scm/linux/kernel/git/tegra/linux into soc/drivers
      Merge tag 'tegra-for-6.2-clk-v2' of git://git.kernel.org/pub/scm/l=
inux/kernel/git/tegra/linux into soc/drivers
      Merge tag 'tegra-for-6.2-memory-v2' of git://git.kernel.org/pub/sc=
m/linux/kernel/git/tegra/linux into soc/drivers
      Merge tag 'v6.1-next-soc' of https://git.kernel.org/pub/scm/linux/=
kernel/git/matthias.bgg/linux into soc/drivers
      Merge tag 'qcom-drivers-for-6.2' of https://git.kernel.org/pub/scm=
/linux/kernel/git/qcom/linux into soc/drivers
      Merge tag 'ti-driver-soc-for-v6.2-v2' of git://git.kernel.org/pub/=
scm/linux/kernel/git/ti/linux into soc/drivers
      tegra: mark BPMP driver as little-endian only
      Merge tag 'asahi-soc-rtkit-sart-6.2' of https://github.com/AsahiLi=
nux/linux into soc/drivers
      Merge tag 'arm-soc/for-6.2/drivers' of https://github.com/Broadcom=
/stblinux into soc/drivers
      Merge tag 'qcom-drivers-for-6.2-2' of https://git.kernel.org/pub/s=
cm/linux/kernel/git/qcom/linux into soc/drivers

Benedikt Niedermayr (3):
      memory: omap-gpmc: wait pin additions
      dt-bindings: memory-controllers: ti,gpmc: add wait-pin polarity
      memory: omap-gpmc: fix coverity issue "Control flow issues"

Benjamin Gaignard (1):
      soc: imx: imx8m-blk-ctrl: Defer probe if 'bus' genpd is not yet re=
ady

Bhupesh Sharma (6):
      dt-bindings: power: rpmpd: Add SM4250 support
      soc: qcom: rpmpd: Add SM4250 support
      dt-bindings: arm: qcom,ids: Add SoC IDs for SM8150 and SA8155
      soc: qcom: socinfo: Add SM8150 and SA8155 SoC IDs to the soc_id ta=
ble
      dt-bindings: arm: qcom,ids: Add SoC IDs for SM6115 / SM4250 and va=
riants
      soc: qcom: socinfo: Add SM6115 / SM4250 SoC IDs to the soc_id table

Bjorn Andersson (1):
      soc: qcom: rpmhpd: Use highest corner until sync_state

Chen Jiahao (1):
      drivers: soc: ti: knav_qmss_queue: Mark knav_acc_firmwares as stat=
ic

Christophe JAILLET (3):
      firmware: ti_sci: Use the bitmap API to allocate bitmaps
      firmware: ti_sci: Use the non-atomic bitmap API when applicable
      firmware: ti_sci: Use devm_bitmap_zalloc when applicable

Cong Dang (1):
      memory: renesas-rpc-if: Clear HS bit during hardware initialization

Dmitry Torokhov (1):
      soc: fsl: qe: request pins non-exclusively

Doug Brown (1):
      ARM: mmp: fix timer_read delay

Fabien Parent (3):
      dt-bindings: soc: mediatek: pwrap: add MT8365 SoC bindings
      soc: mediatek: pwrap: add support for sys & tmr clocks
      soc: mediatek: pwrap: add mt8365 SoC support

Frank Li (1):
      firmware: imx: scu-pd: add missed USB_1_PHY pd

Geert Uytterhoeven (1):
      memory: renesas-rpc-if: Add support for R-Car Gen4

Georgi Vlaev (1):
      firmware: ti_sci: Fix polled mode during system suspend

Gustavo A. R. Silva (1):
      soc: qcom: smd-rpm: Replace zero-length array with DECLARE_FLEX_AR=
RAY() helper

Hai Pham (1):
      dt-bindings: memory: renesas,rpc-if: Document R-Car V4H support

Jason-JH.Lin (3):
      dt-bindings: arm: mediatek: mmsys: change compatible for MT8195
      Revert "soc: mediatek: add mtk-mmsys support for mt8195 vdosys0"
      soc: mediatek: add mtk-mmsys support for mt8195 vdosys0

Jeff Johnson (1):
      soc: qcom: pdr: Make QMI message rules const

Jiasheng Jiang (1):
      soc: qcom: apr: Add check for idr_alloc and of_property_read_strin=
g_index

Jon Hunter (2):
      dt-bindings: tegra: Update headers for Tegra234
      memory: tegra: Add DLA clients for Tegra234

Julius Werner (4):
      dt-bindings: memory: Factor out common properties of LPDDR bindings
      dt-bindings: memory: Add numeric LPDDR compatible string variant
      dt-bindings: memory: Add jedec,lpddr4 and jedec,lpddr5 bindings
      dt-bindings: memory: Add jedec,lpddrX-channel binding

Kartik (3):
      soc/tegra: fuse: Use SoC specific nvmem cells
      soc/tegra: fuse: Add nvmem keepout list
      soc/tegra: fuse: Use platform info with SoC revision

Konrad Dybcio (3):
      dt-bindings: soc: qcom: qcom,smd-rpm: Add a compatible for SM6375
      soc: qcom: smd-rpm: Add SM6375 compatible
      dt-bindings: firmware: document Qualcomm SM6375 SCM

Krzysztof Kozlowski (5):
      dt-bindings: arm: qcom: document qcom,msm-id and qcom,board-id
      soc: qcom: socinfo: create soc_id table from bindings
      dt-bindings: soc: qcom: smd-rpm: add PMIC regulators nodes
      dt-bindings: soc: qcom: smd-rpm: add qcom,glink-channels
      dt-bindings: soc: qcom: apr: document generic qcom,apr compatible

Lad Prabhakar (1):
      soc: renesas: Kconfig: Explicitly select GPIOLIB and PINCTRL confi=
g under SOC_RENESAS

Li Jun (1):
      soc: imx: gpcv2: add GENPD_FLAG_ACTIVE_WAKEUP flag for usb of imx8=
mm/n

Lina Iyer (1):
      soc: qcom: rpmh-rsc: Attach RSC to cluster PM domain

Linus Walleij (1):
      soc: fsl: qe: Avoid using gpio_to_desc()

Liu Shixin (9):
      memory: tegra20-emc: use DEFINE_SHOW_ATTRIBUTE to simplify code
      memory: tegra30-emc: use DEFINE_SHOW_ATTRIBUTE to simplify code
      memory: tegra210-emc: use DEFINE_SHOW_ATTRIBUTE to simplify code
      memory: tegra186-emc: use DEFINE_SHOW_ATTRIBUTE to simplify code
      soc/tegra: cbb: Use DEFINE_SHOW_ATTRIBUTE to simplify tegra_cbb_err
      memory: tegra20-emc: Use DEFINE_SHOW_ATTRIBUTE to simplify code
      memory: tegra30-emc: Use DEFINE_SHOW_ATTRIBUTE to simplify code
      memory: tegra210-emc: Use DEFINE_SHOW_ATTRIBUTE to simplify code
      memory: tegra186-emc: Use DEFINE_SHOW_ATTRIBUTE to simplify code

Luca Weiss (4):
      soc: qcom: spmi-pmic: convert hex numbers to lowercase
      soc: qcom: spmi-pmic: add more PMIC SUBTYPE IDs
      dt-bindings: soc: qcom: aoss: Add sc8280xp compatible
      soc: qcom: llcc: make irq truly optional

Lukas Bulwahn (1):
      MAINTAINERS: arm,pl353-smc: correct dt-binding path

Manikanta Pubbisetty (1):
      dt-bindings: qcom: smp2p: Add WPSS node names to pattern property

Manish Bhardwaj (1):
      firmware: tegra: include IVC header file only once

Manivannan Sadhasivam (2):
      soc: qcom: Select REMAP_MMIO for LLCC driver
      soc: qcom: Select REMAP_MMIO for ICC_BWMON driver

Marek Vasut (2):
      dt-bindings: memory-controller: st,stm32: Fix st,fmc2_ebi-cs-write=
-address-setup-ns
      dt-bindings: memory-controller: st,stm32: Split off MC properties

Matthias Brugger (1):
      soc: mediatek: Add deprecated compatible to mmsys

Maulik Shah (4):
      dt-bindings: soc: qcom: Update devicetree binding document for rpm=
h-rsc
      PM: domains: Store the next hrtimer wakeup in genpd
      soc: qcom: rpmh-rsc: Save base address of drv
      soc: qcom: rpmh-rsc: Write CONTROL_TCS with next timer wakeup

Melody Olvera (4):
      dt-bindings: power: rpmpd: Add QDU1000/QRU1000 to rpmpd binding
      soc: qcom: rpmhpd: Add QDU1000/QRU1000 power domains
      dt-bindings: arm: qcom,ids: Add SoC IDs for QDU1000/QRU1000
      soc: qcom: socinfo: Add QDU1000/QRU1000 SoC IDs to the soc_id table

Mikko Perttunen (1):
      dt-bindings: Add headers for NVDEC on Tegra234

Peter De Schrijver (2):
      firmware: tegra: Update BPMP ABI
      clk: tegra: Support BPMP-FW ABI deny flags

Peter Ujfalusi (1):
      soc: ti: k3-ringacc: Allow the driver to be built as module

Petlozu Pravareshwar (4):
      soc/tegra: pmc: Select IRQ_DOMAIN_HIERARCHY
      soc/tegra: pmc: Add I/O pad table for Tegra234
      soc/tegra: pmc: Fix dual edge triggered wakes
      soc/tegra: pmc: Process wake events during resume

Phil Edworthy (1):
      soc: renesas: Identify RZ/V2M SoC

Rafa=C5=82 Mi=C5=82ecki (1):
      firmware/nvram: bcm47xx: support init from IO memory

Richard Acayan (3):
      dt-bindings: power: rpmpd: add sdm670 power domains
      soc: qcom: rpmhpd: add sdm670 power domains
      dt-bindings: firmware: scm: add sdm670 compatible

Rob Herring (1):
      dt-bindings: memory-controllers: arm,pl353-smc: Extend to support =
'arm,pl354' SMC

Shang XiaoJing (1):
      soc/tegra: cbb: Remove redundant dev_err call

Stephen Boyd (2):
      soc: qcom: cmd-db: Mark device as having no PM support
      soc: qcom: stats: Mark device as having no PM support

Sumit Gupta (4):
      soc/tegra: cbb: Use correct master_id mask for CBB NOC in Tegra194
      soc/tegra: cbb: Update slave maps for Tegra234
      soc/tegra: cbb: Add checks for potential out of bound errors
      soc/tegra: cbb: Check firewall before enabling error reporting

Sven Peter (2):
      soc: apple: sart: Stop casting function pointer signatures
      soc: apple: rtkit: Stop casting function pointer signatures

Thierry Reding (5):
      firmware: tegra: bpmp: Prefer u32 over uint32_t
      firmware: tegra: bpmp: Use iosys-map helpers
      firmware: tegra: bpmp: Do not support big-endian
      Merge branch 'for-6.2/firmware' into for-6.2/clk
      Merge branch for-6.2/dt-bindings into for-6.2/memory

Vignesh Raghavendra (1):
      soc: ti: k3-socinfo: Add AM62Ax JTAG ID

Vincent Knecht (2):
      dt-bindings: soc: qcom: spm: Add MSM8939 CPU compatible
      soc: qcom: spm: Add MSM8939 SPM register data

Wolfram Sang (1):
      soc: qcom: move from strlcpy with unused retval to strscpy

Xinlei Lee (1):
      soc: mediatek: Add all settings to mtk_mmsys_ddp_dpi_fmt_config fu=
nc

Xiu Jianfeng (1):
      optee: Add __init/__exit annotations to module init/exit funcs

Yang Li (1):
      firmware: tegra: Remove surplus dev_err() when using platform_get_=
irq_byname()

Yang Yingliang (3):
      soc: sifive: ccache: fix missing iounmap() in error path in sifive=
_ccache_init()
      soc: sifive: ccache: fix missing free_irq() in error path in sifiv=
e_ccache_init()
      soc: sifive: ccache: fix missing of_node_put() in sifive_ccache_in=
it()

Yinbo Zhu (2):
      soc: loongson: add GUTS driver for loongson-2 platforms
      dt-bindings: soc: add loongson-2 chipid

Yuan Can (1):
      firmware: raspberrypi: Use dev_err_probe() to simplify code

Zhang Qilong (2):
      soc: ti: knav_qmss_queue: Fix PM disable depth imbalance in knav_q=
ueue_probe
      soc: ti: smartreflex: Fix PM disable depth imbalance in omap_sr_pr=
obe

zhang songyi (1):
      pxa: Remove dev_err() after platform_get_irq()

 .../bindings/arm/mediatek/mediatek,mmsys.yaml      |   14 +-
 .../devicetree/bindings/arm/msm/qcom,llcc.yaml     |    1 +
 Documentation/devicetree/bindings/arm/qcom.yaml    |  120 ++
 .../devicetree/bindings/firmware/qcom,scm.yaml     |    3 +
 .../bindings/hwinfo/loongson,ls2k-chipid.yaml      |   38 +
 .../{arm,pl353-smc.yaml =3D> arm,pl35x-smc.yaml}     |   80 +-
 .../ddr/jedec,lpddr-channel.yaml                   |  146 ++
 .../memory-controllers/ddr/jedec,lpddr-props.yaml  |   74 +
 .../memory-controllers/ddr/jedec,lpddr2.yaml       |   48 +-
 .../memory-controllers/ddr/jedec,lpddr3.yaml       |   44 +-
 .../memory-controllers/ddr/jedec,lpddr4.yaml       |   35 +
 .../memory-controllers/ddr/jedec,lpddr5.yaml       |   46 +
 .../memory-controllers/mc-peripheral-props.yaml    |   38 +
 .../memory-controllers/renesas,rpc-if.yaml         |    5 +
 .../st,stm32-fmc2-ebi-props.yaml                   |  144 ++
 .../memory-controllers/st,stm32-fmc2-ebi.yaml      |  138 +-
 .../bindings/memory-controllers/ti,gpmc-child.yaml |    7 +
 .../devicetree/bindings/net/micrel,ks8851.yaml     |    1 +
 .../devicetree/bindings/power/qcom,rpmpd.yaml      |    4 +
 .../devicetree/bindings/soc/mediatek/pwrap.txt     |    3 +
 .../bindings/soc/qcom/qcom,aoss-qmp.yaml           |    2 +
 .../devicetree/bindings/soc/qcom/qcom,apr.yaml     |    1 +
 .../bindings/soc/qcom/qcom,rpmh-rsc.yaml           |    5 +
 .../devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml |   28 +-
 .../devicetree/bindings/soc/qcom/qcom,smp2p.yaml   |    2 +-
 .../devicetree/bindings/soc/qcom/qcom,spm.yaml     |    3 +
 MAINTAINERS                                        |    9 +-
 arch/arm/mach-mmp/time.c                           |   11 +-
 drivers/base/power/domain.c                        |   26 +
 drivers/base/power/domain_governor.c               |    3 +
 drivers/clk/tegra/clk-bpmp.c                       |   37 +-
 drivers/firmware/broadcom/bcm47xx_nvram.c          |   18 +
 drivers/firmware/imx/scu-pd.c                      |    1 +
 drivers/firmware/raspberrypi.c                     |    9 +-
 drivers/firmware/tegra/Kconfig                     |    1 +
 drivers/firmware/tegra/bpmp-debugfs.c              |   62 +-
 drivers/firmware/tegra/bpmp-tegra186.c             |   36 +-
 drivers/firmware/tegra/bpmp-tegra210.c             |   15 +-
 drivers/firmware/tegra/bpmp.c                      |   33 +-
 drivers/firmware/tegra/ivc.c                       |  150 +-
 drivers/firmware/ti_sci.c                          |   24 +-
 drivers/memory/omap-gpmc.c                         |  122 +-
 drivers/memory/renesas-rpc-if.c                    |   22 +-
 drivers/memory/tegra/tegra186-emc.c                |   15 +-
 drivers/memory/tegra/tegra20-emc.c                 |   15 +-
 drivers/memory/tegra/tegra210-emc-core.c           |   15 +-
 drivers/memory/tegra/tegra234.c                    |  160 ++
 drivers/memory/tegra/tegra30-emc.c                 |   15 +-
 drivers/nvmem/brcm_nvram.c                         |    3 +
 drivers/soc/Kconfig                                |    1 +
 drivers/soc/Makefile                               |    1 +
 drivers/soc/apple/rtkit.c                          |    7 +-
 drivers/soc/apple/sart.c                           |    7 +-
 drivers/soc/fsl/qe/gpio.c                          |   77 +-
 drivers/soc/imx/gpcv2.c                            |    3 +
 drivers/soc/imx/imx8m-blk-ctrl.c                   |   11 +-
 drivers/soc/loongson/Kconfig                       |   18 +
 drivers/soc/loongson/Makefile                      |    6 +
 drivers/soc/loongson/loongson2_guts.c              |  192 +++
 drivers/soc/mediatek/mt8186-mmsys.h                |    8 +-
 drivers/soc/mediatek/mtk-mmsys.c                   |  176 +-
 drivers/soc/mediatek/mtk-mmsys.h                   |    6 -
 drivers/soc/mediatek/mtk-pmic-wrap.c               |  114 +-
 drivers/soc/pxa/ssp.c                              |    4 +-
 drivers/soc/qcom/Kconfig                           |    2 +
 drivers/soc/qcom/apr.c                             |   15 +-
 drivers/soc/qcom/cmd-db.c                          |    2 +
 drivers/soc/qcom/llcc-qcom.c                       |  168 +-
 drivers/soc/qcom/pdr_internal.h                    |   20 +-
 drivers/soc/qcom/qcom_stats.c                      |    2 +
 drivers/soc/qcom/rpmh-internal.h                   |   20 +-
 drivers/soc/qcom/rpmh-rsc.c                        |  321 +++-
 drivers/soc/qcom/rpmh.c                            |   14 +-
 drivers/soc/qcom/rpmhpd.c                          |   95 +-
 drivers/soc/qcom/rpmpd.c                           |   18 +
 drivers/soc/qcom/smd-rpm.c                         |    3 +-
 drivers/soc/qcom/smp2p.c                           |    2 +-
 drivers/soc/qcom/socinfo.c                         |  280 +--
 drivers/soc/qcom/spm.c                             |   46 +
 drivers/soc/qcom/trace-rpmh.h                      |   11 +-
 drivers/soc/renesas/Kconfig                        |    2 +
 drivers/soc/renesas/renesas-soc.c                  |   22 +
 drivers/soc/sifive/sifive_ccache.c                 |   33 +-
 drivers/soc/tegra/Kconfig                          |    1 +
 drivers/soc/tegra/cbb/tegra-cbb.c                  |   13 +-
 drivers/soc/tegra/cbb/tegra194-cbb.c               |   18 +-
 drivers/soc/tegra/cbb/tegra234-cbb.c               |  170 +-
 drivers/soc/tegra/fuse/fuse-tegra.c                |  134 +-
 drivers/soc/tegra/fuse/fuse-tegra30.c              |  278 ++-
 drivers/soc/tegra/fuse/fuse.h                      |    4 +
 drivers/soc/tegra/fuse/tegra-apbmisc.c             |    1 +
 drivers/soc/tegra/pmc.c                            |  878 +++++++---
 drivers/soc/ti/Kconfig                             |    2 +-
 drivers/soc/ti/k3-ringacc.c                        |   28 +-
 drivers/soc/ti/k3-socinfo.c                        |    1 +
 drivers/soc/ti/knav_qmss_queue.c                   |    3 +-
 drivers/soc/ti/smartreflex.c                       |    1 +
 drivers/tee/optee/core.c                           |    4 +-
 drivers/thermal/tegra/tegra-bpmp-thermal.c         |   15 +-
 drivers/usb/host/fhci-hcd.c                        |    2 +-
 include/dt-bindings/arm/qcom,ids.h                 |  170 ++
 include/dt-bindings/clock/tegra234-clock.h         |  639 ++++++-
 include/dt-bindings/memory/tegra234-mc.h           |  440 ++++-
 include/dt-bindings/power/qcom-rpmpd.h             |   42 +
 include/dt-bindings/power/tegra234-powergate.h     |   15 +
 include/dt-bindings/reset/tegra234-reset.h         |  111 +-
 include/linux/bcm47xx_nvram.h                      |    6 +
 include/linux/platform_data/gpmc-omap.h            |    8 +
 include/linux/pm_domain.h                          |    7 +
 include/linux/soc/mediatek/mtk-mmsys.h             |    7 +
 include/linux/soc/qcom/llcc-qcom.h                 |   12 +
 include/memory/renesas-rpc-if.h                    |    1 +
 include/soc/fsl/qe/qe.h                            |    5 +-
 include/soc/qcom/qcom-spmi-pmic.h                  |   17 +-
 include/soc/tegra/bpmp-abi.h                       | 1802 +++++++++++++=
++-----
 include/soc/tegra/bpmp.h                           |   17 +-
 include/soc/tegra/fuse.h                           |   15 +
 include/soc/tegra/ivc.h                            |   12 +-
 include/soc/tegra/pmc.h                            |    6 +-
 119 files changed, 6545 insertions(+), 1879 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/hwinfo/loongson,ls=
2k-chipid.yaml
 rename Documentation/devicetree/bindings/memory-controllers/{arm,pl353-=
smc.yaml =3D> arm,pl35x-smc.yaml} (65%)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers=
/ddr/jedec,lpddr-channel.yaml
 create mode 100644 Documentation/devicetree/bindings/memory-controllers=
/ddr/jedec,lpddr-props.yaml
 create mode 100644 Documentation/devicetree/bindings/memory-controllers=
/ddr/jedec,lpddr4.yaml
 create mode 100644 Documentation/devicetree/bindings/memory-controllers=
/ddr/jedec,lpddr5.yaml
 create mode 100644 Documentation/devicetree/bindings/memory-controllers=
/mc-peripheral-props.yaml
 create mode 100644 Documentation/devicetree/bindings/memory-controllers=
/st,stm32-fmc2-ebi-props.yaml
 create mode 100644 drivers/soc/loongson/Kconfig
 create mode 100644 drivers/soc/loongson/Makefile
 create mode 100644 drivers/soc/loongson/loongson2_guts.c
 create mode 100644 include/dt-bindings/arm/qcom,ids.h
