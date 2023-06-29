Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA9A742944
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 17:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232517AbjF2PQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 11:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232488AbjF2PQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 11:16:40 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18CF61BD1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 08:16:36 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 4E7D03200985;
        Thu, 29 Jun 2023 11:16:35 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 29 Jun 2023 11:16:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1688051794; x=1688138194; bh=Z6ftGMWllNLipVc2qEbSYnvZ5XOYM9X/8a5
        E2G2eAic=; b=Fxnto1EVEOgq9x9eRFwQu5ZIcuKbtcZSd6OSLDeKxBU440l0WRm
        miO1C44dIIWheM3LMNKaMMuKlbvAUuZh/Jq2g4fBEGquw8XmjOGfQp/6EXXPhLY2
        J+2IhpX5PmeE89S8nRerdPOJvun7D2t88sDOEewUip5mPJpl54PMXqDMZyRbZ3+2
        7UcZ6lUIatjhK0PvN3qI0sq9d/usoLF6EImTOObNTJ9WDAVCWvDLdlaCeL7UE+c4
        0CHRCX/6ySxiwBZb9sefjijBd+DCiTxoOHqqxZLzbo5cFlvQOKxKdZmc+oAKs+LZ
        7n1yjdbsHy/l2QXIGnuMFoGHyG3q2nYsFpA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1688051794; x=1688138194; bh=Z6ftGMWllNLipVc2qEbSYnvZ5XOYM9X/8a5
        E2G2eAic=; b=iGo2eUBk2ELklSsLSUdnWSviKrXwlF7ZfrM3ty/JkKAjaVtlm6c
        Ceblz9joYWawde3e9xB0GLPFpujZyv0YHV7Dn6r9bRXgCRuxueu5NgD6D7HAy8y4
        yAV6DS4HTHgLcFviorsV960TR6Pa+loOSR2Tq9w+omKOx4gRU/Zpw/gL4e7SP8bu
        9Q0j8dPF3ncbO9KILnbZUdr3C1wNv57FLm7+uPWY6HnTK8ibLTR3Cmxl+mgoSczf
        WDHfIxpd5BXKbx4RH6COabLf/nqdSJ9zrAnJLv9naugH1VQUKXO2aGbvs1m5J+kz
        uUFsWl1hs75uD4fnjONwDYJgEMxQYP114HA==
X-ME-Sender: <xms:UqCdZFK0rDrMFztuSHgXaKsDImUXE82zl8yBW52AwdGcNiQfE73osg>
    <xme:UqCdZBKPGMXLjnhmxGt3IYLskd8QKTKAg2ZKKlgTnVrA_knMFcAYA7kA0fkgqI1Nw
    DNOGGSiLbiq6fUKKuU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrtdeggdekjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepgfekhfehtedvtefhjeekiefghedtffeiveeffeetffetjeffheelhfdtueev
    jeeunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpghhithhhuhgsrdgtohhmnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegr
    rhhnuggsrdguvg
X-ME-Proxy: <xmx:UqCdZNtu93N3Zlz-RsErfDwo5tTy79NqzGdYWUexjHgiKK36xNN3OA>
    <xmx:UqCdZGZhug46c6tdH6Gc_asDF7aJNKOyKMYAgYFMxO_W-3NNvG_kXg>
    <xmx:UqCdZMbgKDP__XdppmASkNSqVBZnVK5jJbTfFpQ52qV0odbwnMEcPQ>
    <xmx:UqCdZHzzmTGjsmyzJ-9gGo7UWI861rgdxC3sxQVvPrMnagiBDua2Jg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 7C4F0B60086; Thu, 29 Jun 2023 11:16:34 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-499-gf27bbf33e2-fm-20230619.001-gf27bbf33
Mime-Version: 1.0
Message-Id: <4915b230-2555-4085-8c39-e4bcad5b3949@app.fastmail.com>
In-Reply-To: <80fba92e-3836-4d27-8be6-1e5f7b5b2f53@app.fastmail.com>
References: <80fba92e-3836-4d27-8be6-1e5f7b5b2f53@app.fastmail.com>
Date:   Thu, 29 Jun 2023 17:16:13 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Linus Torvalds" <torvalds@linux-foundation.org>
Cc:     soc@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL 1/5] ARM: SoC devicetree updates for 6.5
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
t-6.5

for you to fetch changes up to 46448b36ff8c807194d5884a6efce00891e4bd02:

  ARM: mvebu: fix unit address on armada-390-db flash (2023-06-22 10:38:=
50 +0200)

----------------------------------------------------------------
ARM: SoC devicetree updates for 6.5

The biggest change this time is for the 32-bit devicetree files, which
are all moved to a new location, using separate subdirectories for each
SoC vendor, following the same scheme that is used on arm64, mips and
riscv. This has been discussed for many years, but so far we never did
this as there was a plan to move the files out of the kernel entirely,
which has never happened.

The impact of this will be that all external patches no longer apply,
and anything depending on the location of the dtb files in the build
directory will have to change. The installed files after 'make
dtbs_install' keep the current location.

There are six added SoCs here that are largely variants of previously
added chips. Two other chips are added in a separate branch along
with their device drivers.

* The Samsung Exynos 4212 makes its return after the Samsung Galaxy
  Express phone is addded at last. The SoC support was originally
  added in 2012 but removed again in 2017 as it was unused at the time.

* Amlogic C3 is a Cortex-A35 based smart IP camera chip

* Qualcomm MSM8939 (Snapdragon 615) is a more featureful variant of
  the still common MSM8916 (Snapdragon 410) phone chip that has been
  supported for a long time.

* Qualcomm SC8180x (Snapdragon 8cx) is one of their earlier high-end
  laptop chips, used in the Lenovo Flex 5G, which is added along with
  the reference board.

* Qualcomm SDX75 is the latest generation modem chip that is used
  as a peripherial in phones but can also run a standalone Linux.  Unlike
  the prior 32-bit SDX65 and SDX55, this now has a 64-bit Cortex-A55.

* Alibaba T-Head TH1520 is a quad-core RISC-V chip based on the Xuantie
  C910 core, a step up from all previously added rv64 chips.

All of the above come with reference board implementations, those includ=
ed
there are 39 new board files, but only five more 32-bit this time, proba=
bly
a new low:

* Marantec Maveo board based on dhcor imx6ull module

* Endian 4i Edge 200, based on the armv5 Marvell Kirkwood chip

* Epson Moverio BT-200 AR glasses based on TI OMAP4

* PHYTEC STM32MP1-3 Dev board based on STM32MP15 PHYTEC SOM

* ICnova ADB4006 board based on Allwinner A20

On the 64-bit side, there are also fewer addded machines than
we had in the recent releases:

* Three boards based on NXP i.MX8: Emtop SoM & Baseboard,
  NXP i.MX8MM EVKB board and i.MX8MP based Gateworks Venice
  gw7905-2x device.

* NVIDIA IGX Orin and Jetson Orin Nano boards, both based on
  tegra234

* Qualcomm gains support for 6 reference boards on various members
  of their IPQ networking SoC series, as well as the Sony Xperia M4
  Aqua phone, the Acer Aspire 1 laptop, and the Fxtec Pro1X board
  on top of the various reference platforms for their new chips.

* Rockchips support for several newer boards: Indiedroid Nova (rk3588),
  Edgeble Neural Compute Module 6B (rk3588), FriendlyARM NanoPi R2C
  Plus (rk3328), Anbernic RG353PS (rk3566), Lunzn Fastrhino R66S/R68S
  (rk3568)

* TI K3/AM625 based PHYTEC phyBOARD-Lyra-AM625 board and Toradex Verdin
  family with AM62 COM, carrier and dev boards

Other changes to existing boards contain the usual minor improvements
along with

* continued updates to clean up dts files based on dtc warnings and
  binding checks, in particular cache properties and node names

* support for devicetree overlays on at91, bcm283x

* significant additions to existing SoC support on mediatek, qualcomm,
  ti k3 family, starfive jh71xx, NXP i.MX6 and i.MX8, ST STM32MP1

As usual, a lot more detail is available in the individual merge
commits.

----------------------------------------------------------------
Abel Vesa (7):
      arm64: dts: qcom: sm8150: Use 2 interconnect cells
      arm64: dts: qcom: sm8150: Add missing interconnect paths to USB HCs
      arm64: dts: qcom: sm8250: Use 2 interconnect cells
      arm64: dts: qcom: sm8250: Add missing interconnect paths to USB HCs
      arm64: dts: qcom: sm8350: Add missing interconnect paths to USB HCs
      arm64: dts: qcom: sm8450: Add missing interconnect paths to USB HC
      arm64: dts: qcom: sm8550: Add missing interconnect path to USB HC

Adam Ford (4):
      arm64: dts: imx8mn: Add CSI and ISI Nodes
      arm64: dts: imx8mn-beacon: Add support for OV5640 Camera
      arm64: dts: imx8mp-beacon-kit: Enable WM8962 Audio CODEC
      arm64: dts: imx8mn-beacon: Migrate sound card to simple-audio-card

Alain Volmat (1):
      ARM: dts: stm32: add required supplies of ov5640 in stm32mp157c-ev1

Alexander Shiyan (1):
      ARM: dts: am335x-myirtech: Add missing NAND wait pin definition

Alexander Stein (10):
      ARM: dts: mba6ulx: add missing vcc supplies to i2c devices
      ARM: dts: imx6qdl-mba6: add mac address for USB ethernet controller
      arm64: dts: imx8mp: move noc node to correct position
      arm64: dts: imx8mp: Add analog audio output on i.MX8MP TQMa8MPxL/M=
Ba8MPxL
      ARM: dts: imx6qdl: Add HDMI to TQMa6x/MBa6
      arm64: dts: tqma8mqml: Add vcc supply to i2c eeproms
      arm64: dts: imx8mq: Fix lcdif compatible
      arm64: dts: imx8mq: Fix lcdif clocks
      arm64: dts: imx8mq: Add missing pci property
      arm64: dts: imx8mq-tqma8mq-mba8mx: Remove invalid properties

Alexandre Mergnat (7):
      arm64: dts: mediatek: add watchdog support for mt8365 SoC
      arm64: dts: mediatek: add mt6357 PMIC support for mt8365-evk
      arm64: dts: mediatek: add mmc support for mt8365-evk
      arm64: dts: mediatek: add usb controller support for mt8365-evk
      arm64: dts: mediatek: add ethernet support for mt8365-evk
      arm64: dts: mediatek: add OPP support for mt8365 SoC
      arm64: dts: mediatek: add cpufreq support for mt8365-evk

Allen-KH Cheng (7):
      arm64: dts: mediatek: mt8186: Add MTU3 nodes
      arm64: dts: mediatek: mt8186: Add SPMI node
      arm64: dts: mediatek: mt8186: Add ADSP node
      arm64: dts: mediatek: mt8186: Add GCE node
      arm64: dts: mediatek: mt8186: Add display nodes
      arm64: dts: mediatek: Add cpufreq nodes for MT8192
      arm64: dts: mt8192: Add video-codec nodes

Amit Kumar Mahapatra (2):
      arm64: zynqmp: Add mtd partition for secure OS storage area
      arm64: zynqmp: Set qspi tx-buswidth to 4

Amjad Ouled-Ameur (1):
      arm64: dts: mediatek: Add CPU Idle support

Andreas Kemnade (1):
      ARM: dts: omap4: add initial support for Epson Moverio BT-200

Andrew Davis (10):
      ARM: dts: keystone: Fix EEPROM node names
      ARM: dts: keystone: Remove ti,keystone from soc node compatible
      ARM: dts: keystone: Do not capitalize hex digits
      arm64: dts: ti: k3-j721e-beagleboneai64: Fix mailbox node status
      arm64: dts: ti: k3-j721e: Remove PCIe endpoint nodes
      arm64: dts: ti: k3-j721e: Enable PCIe nodes at the board level
      arm64: dts: ti: k3-am64: Enable Mailbox nodes at the board level
      arm64: dts: ti: k3-j721e: Enable MDIO nodes at the board level
      arm64: dts: ti: k3-am64: Only set UART baud for used ports
      arm64: dts: ti: k3-am64: Use phandle to stdout UART node

Andrew Halaney (7):
      arm64: dts: qcom: sc8280xp: Add ethernet nodes
      arm64: dts: qcom: sa8540p-ride: Add ethernet nodes
      arm64: dts: qcom: sa8155p-adp: Make compatible the first property
      arm64: dts: qcom: Make -cells decimal
      arm64: dts: qcom: sa8155p-adp: Remove unneeded rgmii_phy informati=
on
      arm64: dts: qcom: sa8155p-adp: Move mtl nodes into ethernet node
      arm64: dts: qcom: sa8540p-ride: Specify ethernet phy OUI

Andrew Lunn (4):
      ARM: dts: imx51: ZII: Add missing phy-mode
      ARM: dts: imx6qdl: Add missing phy-mode and fixed links
      arm64: dts: freescale: ZII: Add missing phy-mode
      ARM: dts: vf610: ZII: Add missing phy-mode and fixed links

Andr=C3=A9 Apitzsch (1):
      arm64: dts: qcom: msm8916-longcheer-l8910: Add front flash LED

AngeloGioacchino Del Regno (10):
      arm64: dts: mediatek: mt6795: Add support for the CMDQ/GCE mailbox
      arm64: dts: mediatek: mt6795: Add MMSYS node for multimedia clocks
      arm64: dts: mediatek: mt6795: Add support for IOMMU and LARBs
      arm64: dts: mediatek: mt6795: Add PMIC Wrapper node
      arm64: dts: mediatek: Add MT6331 PMIC devicetree
      arm64: dts: mediatek: mt6795-xperia-m5: Add MT6331 Combo PMIC
      arm64: dts: mediatek: mt6795-xperia-m5: Add eMMC, MicroSD slot, SD=
IO
      arm64: dts: mediatek: mt8195: Assign dp-intf aliases
      arm64: dts: mediatek: cherry: Enable PCI-Express ports for WiFi
      arm64: mediatek: Propagate chassis-type where possible

Anusha Rao (3):
      arm64: dts: qcom: ipq9574: add few more reserved memory region
      dt-bindings: clock: Add crypto clock and reset definitions
      arm64: dts: qcom: ipq9574: Enable crypto nodes

Apurva Nandan (2):
      arm64: dts: ti: k3-j784s4-mcu-wakeup: Add FSS OSPI0 and FSS OSPI1
      arm64: dts: ti: k3-j784s4-evm: Add support for OSPI and QSPI flash=
es

Arnaud Pouliquen (2):
      ARM: dts: stm32: Update Cortex-M4 reset declarations on stm32mp15
      ARM: dts: stm32: fix m4_rproc references to use SCMI for stm32mp15

Arnaud Vrac (1):
      arm64: dts: qcom: msm8998: add blsp spi nodes

Arnd Bergmann (41):
      Merge tag 'dt64-cleanup-6.5' of https://git.kernel.org/pub/scm/lin=
ux/kernel/git/krzk/linux-dt into soc/dt
      Merge tag 'dt-cleanup-6.5' of https://git.kernel.org/pub/scm/linux=
/kernel/git/krzk/linux-dt into soc/dt
      Merge tag 'renesas-dts-for-v6.5-tag1' of git://git.kernel.org/pub/=
scm/linux/kernel/git/geert/renesas-devel into soc/dt
      Merge tag 's32g2-dt-6.5' of https://github.com/chesterlintw/linux-=
s32g into soc/dt
      Merge tag 'ux500-dts-for-v6.5' of git://git.kernel.org/pub/scm/lin=
ux/kernel/git/linusw/linux-nomadik into soc/dt
      Merge tag 'at91-dt-6.5' of https://git.kernel.org/pub/scm/linux/ke=
rnel/git/at91/linux into soc/dt
      Merge tag 'samsung-dt-6.5' of https://git.kernel.org/pub/scm/linux=
/kernel/git/krzk/linux into soc/dt
      Merge tag 'omap-for-v6.5/dt-signed' of git://git.kernel.org/pub/sc=
m/linux/kernel/git/tmlind/linux-omap into soc/dt
      Merge tag 'omap-for-v6.5/dt-pin-nodes-signed' of git://git.kernel.=
org/pub/scm/linux/kernel/git/tmlind/linux-omap into soc/dt
      Merge tag 'zynq-dt-for-v6.5' of https://github.com/Xilinx/linux-xl=
nx into soc/dt
      Merge tag 'hisi-arm32-dt-for-6.5' of https://github.com/hisilicon/=
linux-hisi into soc/dt
      Merge tag 'hisi-arm64-dt-for-6.5' of https://github.com/hisilicon/=
linux-hisi into soc/dt
      Merge tag 'amlogic-arm-dt-for-v6.5' of https://git.kernel.org/pub/=
scm/linux/kernel/git/amlogic/linux into soc/dt
      Merge tag 'amlogic-arm64-dt-for-v6.5' of https://git.kernel.org/pu=
b/scm/linux/kernel/git/amlogic/linux into soc/dt
      Merge tag 'renesas-dts-for-v6.5-tag2' of git://git.kernel.org/pub/=
scm/linux/kernel/git/geert/renesas-devel into soc/dt
      Merge tag 'stm32-dt-for-v6.5-1' of git://git.kernel.org/pub/scm/li=
nux/kernel/git/atorgue/stm32 into soc/dt
      Merge tag 'tegra-for-6.5-dt-bindings' of git://git.kernel.org/pub/=
scm/linux/kernel/git/tegra/linux into soc/dt
      Merge tag 'tegra-for-6.5-arm64-dt' of git://git.kernel.org/pub/scm=
/linux/kernel/git/tegra/linux into soc/dt
      Merge tag 'sunxi-dt-for-6.5-1' of https://git.kernel.org/pub/scm/l=
inux/kernel/git/sunxi/linux into soc/dt
      Merge tag 'imx-bindings-6.5' of git://git.kernel.org/pub/scm/linux=
/kernel/git/shawnguo/linux into soc/dt
      Merge tag 'imx-dt-6.5' of git://git.kernel.org/pub/scm/linux/kerne=
l/git/shawnguo/linux into soc/dt
      Merge tag 'imx-dt64-6.5' of git://git.kernel.org/pub/scm/linux/ker=
nel/git/shawnguo/linux into soc/dt
      Merge tag 'qcom-arm64-for-6.5' of https://git.kernel.org/pub/scm/l=
inux/kernel/git/qcom/linux into soc/dt
      Merge tag 'qcom-dts-for-6.5' of https://git.kernel.org/pub/scm/lin=
ux/kernel/git/qcom/linux into soc/dt
      Merge tag 'v6.5-rockchip-dts64-1' of git://git.kernel.org/pub/scm/=
linux/kernel/git/mmind/linux-rockchip into soc/dt
      Merge tag 'riscv-dt-for-v6.5' of https://git.kernel.org/pub/scm/li=
nux/kernel/git/conor/linux into soc/dt
      Merge tag 'zynqmp-dt-for-v6.5' of https://github.com/Xilinx/linux-=
xlnx into soc/dt
      Merge tag 'ti-k3-dt-for-v6.5' of https://git.kernel.org/pub/scm/li=
nux/kernel/git/ti/linux into soc/dt
      Merge tag 'qcom-arm64-for-6.5-2' of https://git.kernel.org/pub/scm=
/linux/kernel/git/qcom/linux into soc/dt
      Merge tag 'v6.4-next-dts32' of https://git.kernel.org/pub/scm/linu=
x/kernel/git/matthias.bgg/linux into soc/dt
      Merge tag 'qcom-dts-for-6.5-2' of https://git.kernel.org/pub/scm/l=
inux/kernel/git/qcom/linux into soc/dt
      Merge tag 'ti-keystone-dt-for-v6.5' of https://git.kernel.org/pub/=
scm/linux/kernel/git/ti/linux into soc/dt
      Merge tag 'v6.4-next-dts64' of https://git.kernel.org/pub/scm/linu=
x/kernel/git/matthias.bgg/linux into soc/dt
      Merge tag 'mvebu-dt-6.5-1' of git://git.kernel.org/pub/scm/linux/k=
ernel/git/gclement/mvebu into soc/dt
      Merge tag 'mvebu-dt64-6.5-1' of git://git.kernel.org/pub/scm/linux=
/kernel/git/gclement/mvebu into soc/dt
      Merge tag 'arm-soc/for-6.5/devicetree' of https://github.com/Broad=
com/stblinux into soc/dt
      Merge tag 'arm-soc/for-6.5/devicetree-arm64' of https://github.com=
/Broadcom/stblinux into soc/dt
      Merge tag 'riscv-dt-for-v6.5-pt2' of https://git.kernel.org/pub/sc=
m/linux/kernel/git/conor/linux into soc/dt
      Merge tag 'at91-dt-6.5-2' of https://git.kernel.org/pub/scm/linux/=
kernel/git/at91/linux into soc/dt
      Merge tag 'arm-dts-mv-for-6.5' of git://git.kernel.org/pub/scm/lin=
ux/kernel/git/robh/linux into soc/dt
      ARM: mvebu: fix unit address on armada-390-db flash

Artur Weber (8):
      ARM: dts: exynos: Move common Exynos4x12 definitions to exynos4x12=
.dtsi
      ARM: dts: exynos: Re-introduce Exynos4212 DTSI
      dt-bindings: arm: samsung: Add Samsung Galaxy Tab3 family boards
      ARM: dts: exynos: Fix some typos in comments
      ARM: dts: s3c64xx: Fix some typos in comments
      ARM: dts: s5pv210: Fix typo in comments, fix pinctrl header
      arm64: dts: adapt to LP855X bindings changes
      ARM: dts: qcom: adapt to LP855X bindings changes

Ar=C4=B1n=C3=A7 =C3=9CNAL (5):
      arm: dts: mt7623: add gmacs to mt7623.dtsi
      arm: dts: mt7623: add mt7530 switch to mt7623a.dtsi
      arm: dts: mt7623: change mt7530 switch address
      arm: dts: mt7623: enable flow control on port@6
      arm: dts: mt7623: add port@5 as CPU port

Ashok Reddy Soma (1):
      arm64: zynqmp: Fix usb node drive strength and slew rate

Aswath Govindraju (7):
      arm64: dts: ti: k3-j721s2-main: Add support for USB
      arm64: dts: ti: k3-j721s2-mcu-wakeup: Add support of OSPI
      arm64: dts: ti: k3-j721s2-common-proc-board: Enable SERDES0
      arm64: dts: ti: k3-j721s2-common-proc-board: Add USB support
      arm64: dts: ti: k3-j721s2: Add support for OSPI Flashes
      arm64: dts: ti: k3-j721s2-main: Add PCIe device tree node
      arm64: dts: ti: k3-j721s2-common-proc-board: Enable PCIe

Aurelien Jarno (2):
      arm64: dts: broadcom: Enable device-tree overlay support for RPi d=
evices
      arm: dts: bcm: Enable device-tree overlay support for RPi devices

Balsam CHIHI (1):
      arm64: dts: mediatek: mt8195: Add AP domain thermal zones

Bartosz Golaszewski (9):
      arm64: dts: qcom: sa8775p: add the PMU node
      arm64: dts: qcom: sa8775p: add UFS nodes
      arm64: dts: qcom: sa8775p-ride: enable UFS
      arm64: dts: qcom: sa8775p: add the pcie smmu node
      arm64: dts: qcom: sa8775p: add the GPU clock controller node
      arm64: dts: qcom: sa8775p: add the GPU IOMMU node
      arm64: dts: qcom: sa8775p: add the watchdog node
      arm64: dts: qcom: sa8775p: enable AOSS
      arm64: dts: qcom: sa8775p: mark the UFS controller as dma-coherent

Ben Schneider (1):
      arm64: dts: marvell: Fix espressobin-ultra boot failure and wifi

Bhavya Kapoor (4):
      arm64: dts: ti: k3-j721e-main: Update delay select values for MMC =
subsystems
      arm64: dts: ti: k3-j784s4-mcu-wakeup: Add support for ADC nodes
      arm64: dts: ti: k3-j784s4-evm: Add pinmux information for ADC
      arm64: dts: ti: k3-j784s4-main: Enable support for high speed modes

Bhupesh Sharma (13):
      arm64: dts: qcom: qrb4210-rb2: Add SD pinctrl states
      arm64: dts: qcom: qrb4210-rb2: Fix CD gpio for SDHC2
      arm64: dts: qcom: qrb4210-rb2: Enable aDSP and cDSP remoteproc nod=
es
      arm64: dts: qcom: sc7280: Fix EUD dt node syntax
      arm64: dts: qcom: sm6115: Add CPU idle-states
      arm64: dts: qcom: sdm8550: Fix the BAM DMA engine compatible string
      arm64: dts: qcom: sdm845: Fix the slimbam DMA engine compatible st=
ring
      arm64: dts: qcom: sm6115: Add Crypto Engine support
      arm64: dts: qcom: sm8150: Add Crypto Engine support
      arm64: dts: qcom: sm8250: Add Crypto Engine support
      arm64: dts: qcom: sm8350: Add Crypto Engine support
      arm64: dts: qcom: sm6115: Add USB SS qmp phy node
      arm64: dts: qcom: qrb4210-rb2: Enable USB node

Biju Das (10):
      arm64: dts: renesas: r9a07g044: Add fcpvd node
      arm64: dts: renesas: r9a07g054: Add fcpvd node
      arm64: dts: renesas: r9a07g044: Add vspd node
      arm64: dts: renesas: r9a07g054: Add vspd node
      arm64: dts: renesas: r9a07g044: Add DSI node
      arm64: dts: renesas: r9a07g054: Add DSI node
      arm64: dts: renesas: rzg2l-smarc: Link DSI with ADV7535
      arm64: dts: renesas: rzg2lc-smarc: Link DSI with ADV7535
      arm64: dts: renesas: r9a07g044: Add MTU3a node
      arm64: dts: renesas: r9a07g054: Add MTU3a node

Bjorn Andersson (17):
      arm64: dts: qcom: sc8280xp-crd: Add QMP to SuperSpeed graph
      arm64: dts: qcom: sc8280xp-x13s: Add QMP to SuperSpeed graph
      arm64: dts: qcom: sc8280xp: Add SDC2 and enable on CRD
      Merge branch '20230524140656.7076-2-quic_tdas@quicinc.com' into HE=
AD
      Merge branch 'sm8450-sm8550-gpucc-binding' into arm64-for-6.5
      arm64: dts: qcom: Introduce the SC8180x platform
      arm64: dts: qcom: sc8180x: Introduce Primus
      arm64: dts: qcom: sc8180x: Introduce Lenovo Flex 5G
      arm64: dts: qcom: sc8180x-primus: dispcc is already okay
      arm64: dts: qcom: sc8180x: Fix adreno smmu compatible
      arm64: dts: qcom: sc8180x: Move DisplayPort for MMCX
      Merge branch '20230512122347.1219-3-quic_tdas@quicinc.com' into ar=
m64-for-6.5
      Merge branch '20230608125315.11454-2-srinivas.kandagatla@linaro.or=
g' into arm64-for-6.5
      Merge branch '20230526161129.1454-2-quic_anusha@quicinc.com' into =
arm64-for-6.5
      arm64: dts: qcom: sc8280xp: Add GPU related nodes
      arm64: dts: qcom: sc8280xp: Enable GPU related nodes
      Revert "arm64: dts: adapt to LP855X bindings changes"

Bryan Brattlof (3):
      arm64: dts: ti: k3-am64-main: add VTM node
      arm64: dts: ti: k3-am62-wakeup: add VTM node
      arm64: dts: ti: k3-am62a-wakeup: add VTM node

Bryan O'Donoghue (4):
      dt-bindings: vendor-prefixes: Add Square
      arm64: dts: qcom: Add msm8939 SoC
      arm64: dts: qcom: Add Square apq8039-t2 board
      arm64: dts: qcom: Add msm8939 Sony Xperia M4 Aqua

Caleb Connolly (4):
      arm64: dts: qcom: pmi8998: enable rradc by default
      arm64: dts: qcom: pmi8998: add charger node
      arm64: dts: qcom: sdm845-oneplus: enable pmi8998 charger
      arm64: dts: qcom: sdm845-shift-axolotl: enable pmi8998 charger

Chen-Yu Tsai (5):
      arm64: dts: mediatek: mt8192-asurada-hayato: Enable Bluetooth
      arm64: dts: mediatek: mt8186: Add CCI node and CCI OPP table
      arm64: dts: mediatek: mt8186: Wire up CPU frequency/voltage scaling
      arm64: dts: mediatek: mt8186: Add GPU speed bin NVMEM cells
      arm64: dts: mediatek: mt8186: Wire up GPU voltage/frequency scaling

Chirag Parekh (1):
      ARM: zynq: dts: Add SCL & SDA GPIO entries for recovery

Chris Morgan (9):
      dt-bindings: arm: rockchip: add Anbernic RG353PS
      arm64: dts: rockchip: add Anbernic RG353PS
      arm64: dts: rockchip: Update leds for Anbernic RGxx3 Series
      arm64: dts: rockchip: add default pinctrl for rk3588 emmc
      arm64: dts: rockchip: Add sdio node to rk3588
      dt-bindings: vendor-prefixes: add Indiedroid
      dt-bindings: arm: rockchip: Add Indiedroid Nova
      arm64: dts: rockchip: Add Indiedroid Nova board
      arm64: dts: rockchip: Fix compatible for Bluetooth on rk3566-anber=
nic

Chris Packham (1):
      ARM: dts: mvebu: align MTD partition nodes to dtschema

Christian Lamparter (3):
      ARM: dts: BCM5301X: MR26: MR32: remove bogus nand-ecc-algo property
      ARM: dts: BCM5301X: MR32: remove partition index numbers
      ARM: dts: BCM5301X: fix duplex-full =3D> full-duplex

Christoph Niedermaier (3):
      dt-bindings: arm: fsl: Add Marantec maveo box as a DHCOR i.MX6ULL =
SoM based board
      ARM: dts: imx6ull-dhcor: Remove mmc aliases from DHCOR SoM
      ARM: dts: imx6ull-dhcor: Add Marantec maveo box

Claudiu Beznea (5):
      ARM: dts: at91: use clock-controller name for PMC nodes
      ARM: dts: at91: at91sam9n12: witch sckc to new clock bindings
      ARM: dts: at91: use clock-controller name for sckc nodes
      ARM: dts: at91: sama5d2: remove extra line
      ARM: dts: at91: use generic name for shutdown controller

Conor Dooley (3):
      MAINTAINERS: exclude maintained subdirs in RISC-V misc DT entry
      Merge patch series "Add Sipeed Lichee Pi 4A RISC-V board support"
      riscv: dts: sort makefile entries by directory

Cristian Birsan (2):
      arm: dts: Enable device-tree overlay support for AT91 boards
      ARM: dts: at91: Enable device-tree overlay support for AT91 boards

Cristian Ciocaltea (3):
      arm64: dts: rockchip: Add rk3588 timer
      arm64: dts: rockchip: Add rk3588 OTP node
      arm64: dts: rockchip: Assign ES8316 MCLK rate on rk3588-rock-5b

Dang Huynh (2):
      dt-bindings: arm: qcom: Add Fxtec Pro1X
      arm64: dts: qcom: Add Fxtec Pro1X (QX1050) DTS

Daniel Golle (7):
      arm64: dts: mt7622: declare SPI-NAND present on BPI-R64
      arm64: dts: mt7622: handle interrupts from MT7531 switch on BPI-R64
      arm64: dts: mt7986: add PWM
      arm64: dts: mt7986: add thermal and efuse
      arm64: dts: mt7986: add thermal-zones
      arm64: dts: mt7986: add pwm-fan and cooling-maps to BPI-R3 dts
      arm64: dts: mt7986: increase bl2 partition on NAND of Bananapi R3

Dario Binacchi (1):
      ARM: dts: stm32: use RCC macro for CRC node on stm32f746

Dasnavis Sabiya (2):
      arm64: dts: ti: k3-am69-sk: Add eMMC mmc0 support
      arm64: dts: ti: k3-am69-sk: Add pinmux for RPi Header

David Jander (1):
      ARM: dts: imx6dl: prtvt7: Remove touchscreen inversion

Devi Priya (13):
      arm64: dts: qcom: ipq9574: Update the size of GICC & GICV regions
      arm64: dts: qcom: ipq9574: Drop bias_pll_ubi_nc_clk input
      arm64: dts: qcom: ipq9574: rename al02-c7 dts to rdp433
      arm64: dts: qcom: ipq9574: Add support for APSS clock controller
      arm64: dts: qcom: ipq9574: Add RPM related nodes
      arm64: dts: qcom: ipq9574: Add SMPA1 regulator node
      arm64: dts: qcom: ipq9574: Add cpufreq support
      dt-bindings: arm: qcom: document AL02-C2 board based on IPQ9574 fa=
mily
      arm64: dts: qcom: ipq9574: add support for RDP418 variant
      dt-bindings: arm: qcom: document AL02-C6 board based on IPQ9574 fa=
mily
      arm64: dts: qcom: ipq9574: add support for RDP449 variant
      dt-bindings: arm: qcom: document AL02-C8 board based on IPQ9574 fa=
mily
      arm64: dts: qcom: ipq9574: add support for RDP453 variant

Diogo Ivo (2):
      arm64: tegra: Add GPU power rail regulator on Smaug
      arm64: tegra: Enable GPU on Smaug

Dmitry Baryshkov (21):
      arm64: dts: qcom: enable dual ("bonded") DSI mode for DB845c
      arm64: dts: qcom: pm8998: don't use GIC_SPI for SPMI interrupts
      ARM: dts: qcom: apq8074-dragonboard: Set DMA as remotely controlled
      ARM: dts: qcom: apq8074-dragonboard: enable adsp and MSS
      ARM: dts: qcom: apq8074-dragonboard: enable DSI panel
      ARM: dts: qcom: apq8074-dragonboard: add onboard leds
      ARM: dts: qcom: apq8074-dragonboard: add gpio keys
      arm64: dts: qcom: sc7280: Don't disable MDP explicitly
      arm64: dts: qcom: sm8350-hdk: remove useless enablement of mdss_mdp
      arm64: dts: qcom: sm8450-hdk: remove useless enablement of mdss_mdp
      arm64: dts: qcom: qrb5165-rb5: remove useless enablement of mdss_m=
dp
      arm64: dts: qcom: msm8953: rename labels for DSI nodes
      arm64: dts: qcom: msm8996: rename labels for DSI nodes
      arm64: dts: qcom: sc7180: rename labels for DSI nodes
      arm64: dts: qcom: sc7280: rename labels for DSI nodes
      arm64: dts: qcom: sc8180x: rename labels for DSI nodes
      arm64: dts: qcom: sdm630: rename labels for DSI nodes
      arm64: dts: qcom: sdm845: rename labels for DSI nodes
      arm64: dts: qcom: sm8250: rename labels for DSI nodes
      arm64: dts: qcom: msm8996: rename labels for HDMI nodes
      ARM: dts: qcom: msm8974: rename labels for DSI nodes

Douglas Anderson (3):
      arm64: dts: mediatek: mt8183: Add mediatek,broken-save-restore-fw =
to kukui
      arm64: dts: mediatek: mt8192: Add mediatek,broken-save-restore-fw =
to asurada
      arm64: dts: mediatek: mt8195: Add mediatek,broken-save-restore-fw =
to cherry

Dylan Van Assche (2):
      arm64: dts: qcom: pmi8998: add flash LED controller
      arm64: dts: qcom: sdm845-shift-axolotl: enable flash LEDs

Fabio Estevam (28):
      ARM: dts: imx7d-sdb: Replace deprecated spi-gpio properties
      ARM: dts: imx6ul-14x14-evk: Replace deprecated spi-gpio properties
      ARM: dts: imx51-zii-rdu1: Replace deprecated spi-gpio properties
      ARM: dts: vf610-zii-dev-rev-b: Replace deprecated spi-gpio propert=
ies
      ARM: dts: imx6ul-tx6ul: Replace deprecated spi-gpio properties
      ARM: dts: imx28-tx28: Replace deprecated spi-gpio properties
      ARM: dts: imx28-cfa: Replace deprecated spi-gpio properties
      ARM: dts: armada-xp: Replace deprecated spi-gpio properties
      ARM: dts: imx6sx: Add LDB support
      ARM: dts: imx7d-smegw01: Remove unneeded #address-cells/#size-cells
      ARM: dts: imx7d-smegw01: Pass 'gpr' to the pinctrl groups
      ARM: dts: imx7d-smegw01: Use pinctrl-0 for pinctrl_rfkill
      ARM: dts: imx7d-smegw01: Pass Ethernet aliases
      ARM: dts: imx6ull-phytec-tauri: Remove invalid property
      ARM: dts: imx7d-flex-concentrator: Remove invalid ecspi property
      ARM: dts: imx35: Remove invalid wdog property
      ARM: dts: vfxxx: Remove invalid wdog property
      ARM: dts: imx6qdl-icore-rqs: Use the 'vmmc-supply' property
      ARM: dts: imx7d-sdb: Describe the SD card regulator
      ARM: dts: imx7d-sdb: Allow UHS modes
      ARM: dts: imx6: Use the mux- prefix
      ARM: dts: imx: Use 'pmic' as node name
      ARM: dts: imx6ul-ccimx6ulsom: Fix the "coin" regulator name
      ARM: dts: imx: Use 'eeprom' as node name
      arm64: dts: imx8mm-evk: Add HDMI support
      arm64: dts: imx8mm-phg: Add display support
      arm64: dts: imx8mq: Use 'dsi' as node name
      arm64: dts: imx8mq: Pass address-cells/size-cells to mipi_dsi

Francesco Dolcini (4):
      dt-bindings: arm: ti: add toradex,verdin-am62 et al.
      arm64: dts: ti: add verdin am62
      arm64: dts: ti: add verdin am62 dahlia
      arm64: dts: ti: add verdin am62 yavia

Frank Li (1):
      arm64: dts: imx8mp: Add coresight trace components

Frank Wunderlich (3):
      arm64: dts: mt7986: add PWM to BPI-R3
      arm64: dts: mt7986: set Wifi Leds low-active for BPI-R3
      arm64: dts: mt7986: use size of reserved partition for bl2

Geert Uytterhoeven (4):
      dt-bindings: timer: sifive,clint: Clean up compatible value section
      dt-bindings: interrupt-controller: sifive,plic: Sort compatible va=
lues
      ARM: dts: iwg20d-q7-common: Fix backlight pwm specifier
      arm64: dts: marvell: Fix pca954x i2c-mux node names

Haibo Chen (2):
      ARM: dts: imx6sll-evk: add eMMC node support
      ARM: dts: imx6sll-evk: avoid underscores in node name

Hari Nagalla (3):
      arm64: dts: ti: k3-j784s4-main: Add R5F cluster nodes
      arm64: dts: ti: k3-j784s4-main: Add C71x DSP nodes
      arm64: dts: ti: k3-j784s4-evm: Reserve memory for remote proc IPC

Himanshu Bhavani (3):
      dt-bindings: arm: fsl: Add Emtop SoM & Baseboard
      dt-bindings: vendor-prefixes: Add Emtop
      arm64: dts: Add support for Emtop SoM & Baseboard

Horatiu Vultur (1):
      ARM: dts: lan966x: Add support for SMA connectors

Hsin-Yi Wang (1):
      arm64: dts: mediatek: mt8183: kukui: Add scp firmware-name

Hugo Villeneuve (3):
      arm64: dts: imx8mn-var-som: add SOM EEPROM
      arm64: dts: imx8mn-var-som: add 20ms delay to ethernet regulator e=
nable
      arm64: dts: imx8mn-var-som-symphony: adapt FEC pinctrl for SOMs wi=
th onboard PHY

Icenowy Zheng (1):
      arm64: dts: mediatek: mt8173-elm: remove panel model number in DT

Imran Shaik (1):
      dt-bindings: clock: qcom: Add GCC clocks for SDX75

Jagadeesh Kona (3):
      arm64: dts: qcom: sm8550: Add video clock controller
      dt-bindings: clock: qcom: Add SM8550 graphics clock controller
      arm64: dts: qcom: sm8550: Add graphics clock controller

Jagan Teki (4):
      dt-bindings: arm: rockchip: Add Edgeble Neural Compute Module 6B
      arm64: dts: rockchip: Add Rockchip RK3588J
      arm64: dts: rockchip: Add rk3588 Edgeble Neu6 Model B SoM
      arm64: dts: rockchip: Add rk3588 Edgeble Neu6 Model B IO

Jianhua Lu (1):
      arm64: dts: qcom: sm8250-xiaomi-elish: remove redundant empty line

Jisheng Zhang (8):
      dt-bindings: interrupt-controller: Add T-HEAD's TH1520 PLIC
      dt-bindings: timer: Add T-HEAD TH1520 clint
      dt-bindings: riscv: Add T-HEAD TH1520 board compatibles
      riscv: Add the T-HEAD SoC family Kconfig option
      riscv: dts: add initial T-HEAD TH1520 SoC device tree
      riscv: dts: thead: add sipeed Lichee Pi 4A board device tree
      MAINTAINERS: add entry for T-HEAD RISC-V SoC
      riscv: defconfig: enable T-HEAD SoC

Joel Selvaraj (1):
      arm64: dts: qcom: sdm845-xiaomi-beryllium: enable pmi8998 charger

Johannes Schneider (2):
      dt-bindings: arm: fsl: Add i.MX8MM-EVKB
      arm64: dts: add NXP i.MX8MM-EVKB support

Jon Hunter (3):
      arm64: tegra: Fix PCIe regulator for Orin Jetson AGX
      arm64: tegra: Enable USB device for Jetson AGX Orin
      arm64: tegra: Update USB phy-name for Jetson Orin NX

Jonathan McDowell (3):
      ARM: dts: sun5i: chip: Enable bluetooth
      ARM: dts: sun5i: Add port E pinmux settings for mmc2
      ARM: dts: axp209: Add iio-hwmon node for internal temperature

Jyri Sarha (1):
      arm64: dts: ti: am65x: Add Rocktech OLDI panel DT overlay

Kathiravan T (12):
      arm64: dts: qcom: ipq9574: add few device nodes
      dt-bindings: nvmem: qfprom: add compatible for few IPQ SoCs
      arm64: dts: qcom: ipq5332: add QFPROM node
      arm64: dts: qcom: ipq6018: add QFPROM node
      arm64: dts: qcom: ipq9574: add QFPROM node
      dt-bindings: arm: qcom: document MI01.3 board based on IPQ5332 fam=
ily
      arm64: dts: qcom: ipq5332: add support for the RDP442 variant
      dt-bindings: arm: qcom: document MI01.9 board based on IPQ5332 fam=
ily
      arm64: dts: qcom: ipq5332: add support for the RDP474 variant
      arm64: dts: qcom: ipq5332: rename mi01.2 dts to rdp441
      arm64: dts: qcom: ipq5332: define UART1
      arm64: dts: qcom: ipq5332: add few more reserved memory region

Keerthy (5):
      arm64: dts: ti: k3-j7200: Fix physical address of pin
      arm64: dts: ti: j784s4: Add VTM node
      arm64: dts: ti: j721e: Add VTM node
      arm64: dts: ti: j7200: Add VTM node
      arm64: dts: ti: j721s2: Add VTM node

Kelvin Zhang (1):
      dt-bindings: arm: amlogic: add C3 bindings

Komal Bajaj (3):
      arm64: dts: qcom: qdu1000: Add IMEM and PIL info region
      arm64: dts: qcom: qdu1000: Add SDHCI node
      arm64: dts: qcom: qdu1000-idp: add SDHCI for emmc

Konrad Dybcio (26):
      dt-bindings: power: qcom,rpmpd: add missing RPMH levels
      dt-bindings: power: qcom,rpmpd: Format RPMh levels better
      arm64: dts: qcom: sm8550: Add missing RPMhPD OPP levels
      arm64: dts: qcom: qrb4210-rb2: Describe fixed regulators
      arm64: dts: qcom: qrb4210-rb2: Enable display out
      arm64: dts: qcom: qrb4210-rb2: Add GPIO LEDs
      arm64: dts: qcom: qrb4210-rb2: Enable load setting on SDHCI VQMMC
      arm64: dts: qcom: qrb4210-rb2: Enable CAN bus controller
      arm64: dts: qcom: sm8150-kumano: Add GPIO line names for PMIC GPIOs
      arm64: dts: qcom: sm8150-kumano: Add GPIO line names for TLMM
      arm64: dts: qcom: sm8150-kumano: Set up camera fixed regulators
      arm64: dts: qcom: sm8150-kumano: Enable SDHCI2
      arm64: dts: qcom: sm8250-edo: Enable Venus
      arm64: dts: qcom: msm8996-tone: Enable LPG LEDs
      arm64: dts: qcom: sm8450: Add missing RPMhPD OPP levels
      dt-bindings: clock: Add Qcom SM8450 GPUCC
      arm64: dts: qcom: sm6350: Add PSCI idle states
      arm64: dts: qcom: qdu1000: Flush RSC sleep & wake votes
      arm64: dts: qcom: sc8180x: Flush RSC sleep & wake votes
      arm64: dts: qcom: sdm670: Flush RSC sleep & wake votes
      arm64: dts: qcom: sdm845: Flush RSC sleep & wake votes
      arm64: dts: qcom: sm6350: Flush RSC sleep & wake votes
      arm64: dts: qcom: sm8550: Flush RSC sleep & wake votes
      arm64: dts: qcom: qcm2290: Add CPU idle states
      arm64: dts: qcom: sm6375: Add GPUCC and Adreno SMMU
      arm64: dts: qcom: qrb4210-rb2: Enable on-board buttons

Krishna chaitanya chundru (1):
      arm: dts: qcom: sdx55: Add interconnect path

Krzysztof Kozlowski (99):
      arm64: dts: ti: add missing cache properties
      ARM: dts: exynos: drop simple-bus from FIMC in Exynos4
      ARM: dts: s5pv210: drop simple-bus from FIMC
      ARM: dts: exynos: Remove empty camera pinctrl configuration in Tra=
ts
      ARM: dts: exynos: Remove empty camera pinctrl configuration in Uni=
versal C210
      ARM: dts: exynos: Remove empty camera pinctrl configuration in Odr=
oid X/U3
      ARM: dts: s5pv210: align pin configuration nodes with bindings
      ARM: dts: s5pv210: align USB node name with bindings
      ARM: dts: s5pv210: re-order MFC clock names to match Exynos and bi=
ndings
      ARM: dts: s5pv210: add dummy 5V regulator for backlight on SMDKv210
      ARM: dts: s5pv210: remove empty camera pinctrl configuration
      arm64: dts: broadcom: add missing cache properties
      ARM: dts: broadcom: add missing cache properties
      arm64: dts: amlogic: add missing cache properties
      ARM: dts: ste: align UART node name with bindings
      arm64: dts: mba6ulx: correct GPIO keys wakeup
      arm64: dts: s32: add missing cache properties
      arm64: dts: imx8mq-mnt-reform2: drop invalid simple-panel compatib=
le
      arm64: dts: imx: add missing cache properties
      arm64: dts: freescale: add missing cache properties
      ARM: dts: imx7ulp: add address/size-cells to OCOTP
      arm64: dts: qcom: sm8150: drop incorrect serial properties
      arm64: dts: qcom: sm8150: add missing qcom,smmu-500 fallback
      arm64: dts: qcom: sm8150: drop snps,dw-pcie fallback compatible
      arm64: dts: qcom: sc8280xp: correct GIC child node name
      ARM: dts: en7523: add missing cache properties
      arm64: dts: apm: add missing cache properties
      arm64: dts: amazon: add missing cache properties
      arm64: dts: hisilicon: add missing cache properties
      arm64: dts: realtek: add missing cache properties
      arm64: dts: synaptics: add missing cache properties
      arm64: dts: allwinner: a64: add missing cache properties
      arm64: dts: marvell: add missing cache properties
      arm64: dts: microchip: add missing cache properties
      arm64: dts: qcom: sm8550-qrd: add PCIe0
      arm64: dts: qcom: sm8550-qrd: add USB OTG
      ARM: dts: qcom: msm8974: do not use underscore in node name (again)
      arm64: dts: qcom: ipq6018: correct qrng unit address
      arm64: dts: qcom: msm8916: correct camss unit address
      arm64: dts: qcom: msm8916: correct MMC unit address
      arm64: dts: qcom: msm8916: correct WCNSS unit address
      arm64: dts: qcom: msm8953: correct IOMMU unit address
      arm64: dts: qcom: msm8953: correct WCNSS unit address
      arm64: dts: qcom: msm8976: correct MMC unit address
      arm64: dts: qcom: msm8994: correct SPMI unit address
      arm64: dts: qcom: msm8996: correct camss unit address
      arm64: dts: qcom: sdm630: correct camss unit address
      arm64: dts: qcom: sdm845: correct camss unit address
      arm64: dts: qcom: sm6115: correct thermal-sensor unit address
      arm64: dts: qcom: sm8350: correct DMA controller unit address
      arm64: dts: qcom: sm8350: correct PCI phy unit address
      arm64: dts: qcom: sm8350: correct USB phy unit address
      arm64: dts: qcom: sm8550: correct crypto unit address
      arm64: dts: qcom: sm8550: correct pinctrl unit address
      arm64: dts: qcom: sdm845-polaris: add missing touchscreen child no=
de reg
      arm64: dts: qcom: ipq6018: add unit address to soc node
      arm64: dts: qcom: ipq8074: add unit address to soc node
      arm64: dts: qcom: msm8994: add unit address to soc node
      arm64: dts: qcom: msm8996: add unit address to soc node
      arm64: dts: qcom: msm8998: add unit address to soc node
      arm64: dts: qcom: sdm630: add unit address to soc node
      arm64: dts: qcom: sm6125: add unit address to soc node
      arm64: dts: qcom: sm8550-qrd: add WCD9385 audio-codec
      arm64: dts: qcom: sm8550-mtp: add WCD9385 audio-codec
      arm64: dts: qcom: pm8550: add flash LED controller
      arm64: dts: qcom: sm8550-qrd: add flash LEDs
      arm64: dts: qcom: sm8550: enable DISPCC by default
      arm64: dts: qcom: sm8550-mtp: drop redundant MDP status
      arm64: dts: qcom: sm8550-qrd: add display and panel
      arm64: dts: qcom: ipq6018: drop incorrect SPI bus spi-max-frequency
      arm64: dts: qcom: ipq8074: drop incorrect SPI bus spi-max-frequency
      arm64: dts: qcom: qdu1000: add missing qcom,smmu-500 fallback
      arm64: dts: qcom: sm8250: add missing qcom,smmu-500 fallback
      arm64: dts: qcom: sm8550-qrd: add missing PCIE1 PHY AUX clock freq=
uency
      arm64: dts: qcom: sm6125-sprout: align ADC channel node names with=
 bindings
      arm64: dts: qcom: sdm630-nile: correct duplicated reserved memory =
node
      arm64: dts: qcom: msm8996: correct /soc/bus ranges
      arm64: dts: qcom: msm8916: correct LPASS CPU clocks order
      arm64: dts: qcom: msm8996: correct MMCC clocks order
      arm64: dts: qcom: apq8096: fix fixed regulator name property
      arm64: dts: mediatek: add missing cache properties
      ARM: dts: qcom: msm8974: drop unit addresses from USB phys
      ARM: dts: qcom: ipq4019: fix broken NAND controller properties ove=
rride
      ARM: dts: qcom: ipq4019: correct syscon unit-address
      ARM: dts: qcom: sdx55: correct rsc unit-address
      ARM: dts: qcom: msm8974: correct pronto unit-address
      ARM: dts: qcom: ipq8064: drop leading 0 from unit-address
      ARM: dts: qcom: ipq8064: drop invalid GCC thermal-sensor unit-addr=
ess
      ARM: dts: qcom: ipq8064: correct LED node names
      ARM: dts: qcom: ipq8064: align USB node names with bindings
      ARM: dts: qcom: apq8060-dragonboard: move regulators out of simple=
-bus
      ARM: dts: qcom: msm8960-cdp: move regulator out of simple-bus
      ARM: dts: qcom: apq8084: correct thermal sensor unit-address
      ARM: dts: qcom: msm8974: align WCNSS Bluetooth node name with bind=
ings
      arm64: tegra: Add missing cache properties on Tegra210
      arm64: dts: qcom: sm8550-qrd: add WSA8845 speakers
      arm64: dts: qcom: sm8550-mtp: add WSA8845 speakers
      arm64: dts: qcom: sm8550-qrd: add sound card
      arm64: dts: qcom: sm8550-mtp: add sound card

Lad Prabhakar (3):
      arm64: dts: renesas: r9a07g054: Add CSI and CRU nodes
      arm64: dts: renesas: rzv2l-smarc: Enable CRU, CSI support
      arm64: dts: renesas: rzg2lc-smarc: Enable CRU, CSI support

Laurent Pinchart (2):
      arm64: dts: imx8mp: Add CSIS DT nodes
      arm64: dts: imx8mp: Add ISI DT node

Linus Walleij (4):
      ARM: dts: ux500: Disable charging on HREF boards
      ARM: dts: ux500: Fix STMPE device nodes
      ARM: dts: ux500: Add eSRAM nodes
      ARM: dts: qcom: msm8660: Fix regulator node names

Luca Ceresoli (1):
      arm64: dts: imx8mp-msc-sm2s: Add sound card

Luca Weiss (12):
      ARM: dts: qcom: msm8974-hammerhead: Add vibrator
      arm64: dts: qcom: pm8953: add GPIOs
      arm64: dts: qcom: msm8953: Add BLSP DMAs for I2C
      arm64: dts: qcom: sm6350: Move wifi node to correct place
      arm64: dts: qcom: Add PMI632 PMIC
      arm64: dts: qcom: sdm632-fairphone-fp3: Add notification LED
      arm64: dts: qcom: pm7250b: add missing spmi-vadc include
      ARM: dts: qcom: apq8026-huawei-sturgeon: Add vibrator
      ARM: dts: qcom: msm8226: Use XO from rpmcc where possible
      ARM: dts: qcom: msm8226: Provide clocks to mmcc node
      arm64: dts: qcom: sm6350: add uart1 node
      arm64: dts: qcom: sm7225-fairphone-fp4: Add Bluetooth

Lucas Stach (1):
      arm64: dts: imx8mp: don't initialize audio clocks from CCM node

Lucas Tanure (1):
      arm64: dts: rockchip: Add SD card support to rock-5b

Ludwig Kormann (2):
      dt-bindings: arm: sunxi: add ICnova A20 ADB4006 binding
      arm: dts: sunxi: Add ICnova A20 ADB4006 board

Maksim Kiselev (1):
      riscv: dts: allwinner: d1: Add SPI controllers node

Marek Vasut (13):
      arm64: dts: imx8mp: Add SAI, SDMA, AudioMIX
      arm64: dts: imx8mp: Add analog audio output on i.MX8MP EVK
      ARM: dts: stm32: Replace deprecated st,hw-flow-ctrl with uart-has-=
rtscts
      ARM: dts: stm32: Move ethernet MAC EEPROM from SoM to carrier boar=
ds
      arm64: dts: imx8mp: Describe PCIe clock generator on DH electronic=
s i.MX8M Plus DHCOM on PDK3
      arm64: dts: imx8mp: Sort AIPS4 nodes
      arm64: dts: imx8mp: Add DeWarp Engine DT node
      dt-bindings: arm: fsl: Fix syntax error
      arm64: dts: imx8mp: Add TC9595 bridge on DH electronics i.MX8M Plu=
s DHCOM
      arm64: dts: imx8mp: Enable SAI audio on MX8MP DHCOM PDK2 and PDK3
      ARM: dts: stm32: Shorten the AV96 HDMI sound card name
      ARM: dts: stm32: Update to generic ADC channel binding on DHSOM sy=
stems
      ARM: dts: stm32: Fix audio routing on STM32MP15xx DHCOM PDK2

Marijn Suijten (1):
      arm64: dts: qcom: sm8250-edo: Panel framebuffer is 2.5k instead of=
 4k

Martin Blumenstingl (1):
      ARM: dts: meson8: correct uart_B and uart_C clock references

Mason Huo (2):
      riscv: dts: starfive: Enable axp15060 pmic for cpufreq
      riscv: dts: starfive: Add cpu scaling for JH7110 SoC

Matt Ranostay (1):
      arm64: dts: ti: k3-j721s2-main: Add SERDES and WIZ device tree node

Matti Lehtim=C3=A4ki (9):
      ARM: dts: qcom: msm8226: Add PMU node
      ARM: dts: qcom: msm8226: Add rpm-stats device node
      ARM: dts: qcom: msm8226: Add IMEM node
      ARM: dts: qcom: pm8226: Add thermal sensor and thermal zone config
      ARM: dts: qcom: pm8841: Add thermal zone config
      ARM: dts: qcom: pm8941: Add thermal zone config
      ARM: dts: qcom: msm8226: Add qfprom node
      ARM: dts: qcom: msm8226: Add tsens node and related nvmem cells
      ARM: dts: qcom: msm8226: Add thermal zones node

Michael Tretter (2):
      media: dt-bindings: media: rockchip-rga: add rockchip,rk3568-rga
      arm64: dts: rockchip: Add RGA2 support to rk356x

Michael Walle (4):
      arm64: dts: sparx5: rename pinctrl nodes
      ARM: dts: lan966x: kontron-d10: fix board reset
      ARM: dts: lan966x: kontron-d10: fix SPI CS
      ARM: dts: lan966x: kontron-d10: add PHY interrupts

Michal Simek (24):
      dt-bindings: arm: xilinx: Change zc1275 board name to zcu1275
      arm64: zynqmp: Change zc1275 board name to zcu1275
      Revert "arm64: dts: zynqmp: Add address-cells property to interrup=
t controllers"
      arm64: zynqmp: Rename ams_ps/pl node names
      arm64: zynqmp: Sync node name address with reg (mailbox)
      arm64: zynqmp: Fix usb reset over bootmode pins on zcu100
      arm64: zynqmp: Add dmas, dp, rtc, watchdogs and opp nodes for SOM
      arm64: zynqmp: Use assigned-clock-rates for setting up SD clock in=
 SOM
      arm64: zynqmp: Add gpio labels for modepin gpio
      arm64: zynqmp: Add pinctrl emmc description to SM-K26
      arm64: zynqmp: Switch to ethernet-phy-id in kv260
      arm64: zynqmp: Setup clock for DP and DPDMA
      arm64: zynqmp: Enable DP driver for SOMs
      arm64: zynqmp: Enable AMS on SOM and other zcu10x boards
      arm64: zynqmp: Describe bus-width for SD card on KV260
      arm64: zynqmp: Add phase tags marking
      arm64: xilinx: Use zynqmp prefix for SOM dt overlays
      dt-bindings: xilinx: Switch xilinx.com emails to amd.com
      arm64: zynqmp: Convert kv260-revA overlay to ASCII text
      arm64: zynqmp: Switch to amd.com emails
      arm64: zynqmp: Describe TI phy as ethernet-phy-id
      arm64: zynqmp: Used fixed-partitions for QSPI in k26
      dt-bindings: xilinx: Remove Rajan, Jolly and Manish
      dt-bindings: usb: xilinx: Replace Manish by Piyush

Neha Malcom Francis (4):
      arm64: dts: ti: k3-j721s2: Change CPTS clock parent
      dt-bindings: misc: esm: Add ESM support for TI K3 devices
      arm64: dts: ti: k3-j721e: Add ESM support
      arm64: dts: ti: k3-j7200: Add ESM support

Neil Armstrong (13):
      arm64: dts: qcom: sm8350: add ports subnodes in usb1 qmpphy node
      arm64: dts: qcom: sm8450: add ports subnodes in usb1 qmpphy node
      arm64: dts: qcom: sm8350-hdk: Add QMP & DP to SuperSpeed graph
      arm64: dts: qcom: sm8450-hdk: Add QMP & DP to SuperSpeed graph
      arm64: dts: qcom: pmk8350: add reboot-mode node using sdam_2 nvmem
      arm64: dts: qcom: pmk8550: add reboot-mode node using sdam_2 nvmem
      arm64: dts: qcom: sm8450: add crypto nodes
      arm64: dts: qcom: sm8550: fix low_svs RPMhPD labels
      arm64: dts: qcom: sm8550: add display port nodes
      arm64: dts: qcom: pm8550: add PWM controller
      arm64: dts: qcom: sm8550-qrd: add notification RGB LED
      arm64: dts: qcom: pmk8550: always enable RTC PMIC device
      arm64: dts: qcom: sm8550-qrd: enable PMIC Volume and Power buttons

Nicolas Cavallari (1):
      arm64: dts: imx8mm-venice: Fix GSC vdd_bat data size.

Nikita Travkin (4):
      arm64: dts: qcom: sc7180: Don't enable lpass clocks by default
      arm64: dts: qcom: sc7180: Drop redundant disable in mdp
      dt-bindings: arm: qcom: Add Acer Aspire 1
      arm64: dts: qcom: Add Acer Aspire 1

Nishanth Menon (84):
      arm64: dts: ti: k3-am64: Add general purpose timers
      arm64: dts: ti: k3-am642-sk: Fix mmc1 pinmux
      arm64: dts: ti: k3-am642-sk: Enable main_i2c0 and eeprom
      arm64: dts: ti: k3-am642-sk: Describe main_uart1 pins
      arm64: dts: ti: k3-am642-sk: Rename regulator node name
      arm64: dts: ti: k3-am642-evm: Enable main_i2c0 and eeprom
      arm64: dts: ti: k3-am642-evm: Describe main_uart1 pins
      arm64: dts: ti: k3-am642-evm: Rename regulator node name
      arm64: dts: ti: k3-am642-evm: Add VTT GPIO regulator for DDR
      arm64: dts: ti: k3-am642-sk|evm: Drop bootargs, add aliases
      arm64: dts: ti: k3-am62x-sk-common: Drop bootargs
      arm64: dts: ti: k3-am65*: Drop bootargs
      arm64: dts: ti: k3-j721e-*: Drop bootargs
      arm64: dts: ti: k3-j7200-common-proc-board: Drop bootargs
      arm64: dts: ti: k3-j721s2-common-proc-board: Drop bootargs
      arm64: dts: ti: k3-am62a: Add general purpose timers
      arm64: dts: ti: k3-am62a: Add watchdog nodes
      arm64: dts: ti: k3-am654-base-board: Add missing pinmux wkup_uart,=
 mcu_uart and mcu_i2c
      arm64: dts: ti: k3-am654-base-board: Rename regulator node name
      arm64: dts: ti: k3-am654-base-board: Add VTT GPIO regulator for DDR
      arm64: dts: ti: k3-am654-base-board: Add missing PMIC
      arm64: dts: ti: k3-am654-base-board: Add board detect eeprom
      arm64: dts: ti: k3-am654-base-board: Add aliases
      arm64: dts: ti: k3-am65: Drop aliases
      arm64: dts: ti: k3-am65-main: Remove "syscon" nodes added for pcie=
X_ctrl
      arm64: dts: ti: k3-am62a7-sk: Describe main_uart1 and wkup_uart
      arm64: dts: ti: k3: j721s2/j784s4: Switch to https links
      arm64: dts: ti: k3-am62x-sk-common: Drop extra EoL
      arm64: dts: ti: k3-am62x-sk-common: Describe main_uart1 and wkup_u=
art
      arm64: dts: ti: k3-am62x-sk-common: Add eeprom
      arm64: dts: ti: k3-am62x-sk-common: Improve documentation of mcasp=
1_pins
      arm64: dts: ti: k3-am65-main: Fix mcan node name
      arm64: dts: ti: k3-am65-main: Drop deprecated ti,otap-del-sel prop=
erty
      arm64: dts: ti: k3-am65-iot2050-common: Rename rtc8564 nodename
      arm64: dts: ti: k3-am62a-main: Add sa3_secproxy
      arm64: dts: ti: k3-am65-mcu: Add mcu_secproxy
      arm64: dts: ti: k3-j7200-mcu: Add mcu_secproxy
      arm64: dts: ti: k3-j721e-mcu: Add mcu_secproxy
      arm64: dts: ti: k3-j721s2-mcu-wakeup: Add sa3_secproxy and mcu_sec=
_proxy
      arm64: dts: ti: k3-j784s4-mcu-wakeup: Add sa3_secproxy and mcu_sec=
_proxy
      arm64: dts: ti: k3-j721e: Add general purpose timers
      arm64: dts: ti: k3-j721e: Configure pinctrl for timer IO
      arm64: dts: ti: k3-j721s2: Add general purpose timers
      arm64: dts: ti: k3-j721s2: Configure pinctrl for timer IO
      arm64: dts: ti: k3-j784s4: Add general purpose timers
      arm64: dts: ti: k3-j784s4: Configure pinctrl for timer IO
      arm64: dts: ti: k3-j721e-sk: Fixup reference to phandles array
      arm64: dts: ti: k3-j721e-som-p0/common-proc-board: Fixup reference=
 to phandles array
      arm64: dts: ti: k3-j721e-beagleboneai64: Move camera gpio pinctrl =
to gpio node
      arm64: dts: ti: k3-j721e-beagleboneai64: Move eeprom WP gpio pinct=
rl to eeprom node
      arm64: dts: ti: k3-j721e-beagleboneai64: Fixup reference to phandl=
es array
      arm64: dts: ti: k3-am642-phyboard-electra-rdk: Fixup reference to =
phandles array
      arm64: dts: ti: k3-j7200-som/common-proc-board: Fixup reference to=
 phandles array
      arm64: dts: ti: k3-j721s2-common-proc-board: Fixup reference to ph=
andles array
      arm64: dts: ti: k3-am625-sk: Fixup reference to phandles array
      arm64: dts: ti: k3-am64-evm: Fixup reference to phandles array
      arm64: dts: ti: k3-am64-sk: Fixup reference to phandles array
      arm64: dts: ti: k3-am65-iot*: Fixup reference to phandles array
      arm64: dts: ti: k3-am654-base-board: Fixup reference to phandles a=
rray
      arm64: dts: ti: k3-am68-sk-base-board: Fixup reference to phandles=
 array
      arm64: dts: ti: k3-j784s4-evm: Fix main_i2c0 alias
      arm64: dts: ti: k3-j784s4-evm: Add mcu and wakeup uarts
      arm64: dts: ti: k3-j784s4-evm: Enable wakeup_i2c0 and eeprom
      arm64: dts: ti: k3-am69-sk: Fix main_i2c0 alias
      arm64: dts: ti: k3-am69-sk: Enable mcu network port
      arm64: dts: ti: k3-am69-sk: Add mcu and wakeup uarts
      arm64: dts: ti: k3-am69-sk: Enable wakeup_i2c0 and eeprom
      arm64: dts: ti: k3-j721e-sk: Add missing uart pinmuxes
      arm64: dts: ti: k3-j721e-sk: Enable wakeup_i2c0 and eeprom
      arm64: dts: ti: j721e-som/common-proc-board: Add product links
      arm64: dts: ti: j721e-common-proc-board: Add uart pinmux
      arm64: dts: ti: k3-j721e-som-p0: Enable wakeup_i2c0 and eeprom
      arm64: dts: ti: k3-j721e-beagleboneai64: Add wakeup_uart pinmux
      arm64: dts: ti: k3-j721e-sk: Define aliases at board level
      arm64: dts: ti: k3-j721e-common-proc-board: Define aliases at boar=
d level
      arm64: dts: ti: k3-j721e: Drop SoC level aliases
      arm64: dts: ti: k3-am68-sk-base-board: Add uart pinmux
      arm64: dts: ti: k3-am68-sk-som: Enable wakeup_i2c0 and eeprom
      arm64: dts: ti: k3-j721s2-common-proc-board: Add uart pinmux
      arm64: dts: ti: k3-j721s2-som-p0: Enable wakeup_i2c0 and eeprom
      arm64: dts: ti: k3-am62: Add ESM support
      arm64: dts: ti: k3-am64: Add ESM support
      arm64: dts: ti: k3-j721e-som-p0: Enable wakeup_i2c0 and eeprom
      arm64: dts: ti: k3-j7200-mcu-wakeup: Remove 0x unit address prefix=
 from nodename

Nitin Yadav (1):
      arm64: dts: ti: k3-am62-main: Add sa3_secproxy

N=C3=ADcolas F. R. A. Prado (2):
      arm64: dts: mediatek: mt8192: Add missing dma-ranges to soc node
      arm64: dts: mediatek: mt8192: Fix CPUs capacity-dmips-mhz

Oleksij Rempel (11):
      ARM: dts: imx6dl: lanmcu: Disable unused USB PHY nodes
      ARM: dts: imx6dl: lanmcu: Configure over-current polarity for USB =
OTG node
      ARM: dts: imx6dl: Add trip points to thermal zones on several devi=
ces
      ARM: dts: imx6dl: vicut1: Address USB related warnings
      ARM: dts: imx6dl: alti6p: fix different USB related warnings
      ARM: dts: imx6dl: prtmvt: fix different USB related warnings
      ARM: dts: imx6qp: prtwd3: Enable USB over current detection on USB=
 OTG port
      ARM: dts: imx6ul: prti6g: fix USB over-current detection on USB OT=
G port
      ARM: dts: imx6dl: plybas: fix USB over-current detection on USB OT=
G port
      ARM: dts: imx6dl: prtrvt, prtvt7, prti6q, prtwd2: fix USB related =
warnings
      ARM: dts: imx6qdl: vicut1: rename power to power-button

Olivier Moysan (9):
      ARM: dts: stm32: add adc internal channels to stm32mp15
      ARM: dts: stm32: add vrefint calibration on stm32mp15
      ARM: dts: stm32: add vrefint support to adc2 on stm32mp15
      ARM: dts: stm32: enable adc on stm32mp15xx-dkx boards
      ARM: dts: stm32: adopt generic iio bindings for adc channels on st=
m32mp157c-ed1
      ARM: dts: stm32: adopt generic iio bindings for adc channels on em=
stamp-argon
      ARM: dts: stm32: adopt generic iio bindings for adc channels on dh=
cor-drc
      ARM: dts: stm32: adopt generic iio bindings for adc channels on dh=
cor-testbench
      ARM: dts: stm32: fix i2s endpoint format property for stm32mp15xx-=
dkx

Parikshit Pareek (2):
      arm64: dts: qcom: sa8775p: pmic: remove the PON modes
      arm64: dts: qcom: sa8775p: pmic: add the sdam_0 node

Parth Gajjar (2):
      dt-bindings: gpu: mali-utgard: Add xlnx,zynqmp-mali compatible
      arm64: zynqmp: Add mali-400 gpu node for zynqmp

Patrick Delaunay (2):
      ARM: dts: stm32: add part number for STM32MP15x
      ARM: dts: stm32: remove extra space in stm32mp15xx-dkx.dtsi

Pawel Dembicki (1):
      ARM: dts: kirkwood: Add Endian 4i Edge 200 board

Peng Fan (5):
      arm64: dts: imx93: add watchdog node
      arm64: dts: imx93: add ocotp node
      arm64: dts: imx93: reorder device nodes
      arm64: dts: imx93: add cpuidle node
      arm64: dts: imx93-11x11-evk: enable wdog3

Peter Rosin (1):
      ARM: dts: at91: tse850: add properties for gpio-line-names

Phong Hoang (1):
      arm64: dts: renesas: r8a779a0: Add PWM nodes

Pin-yen Lin (1):
      arm64: dts: mt8173: Power on panel regulator on boot

Piyush Mehta (1):
      arm64: zynqmp: Disable USB3.0 for zc1751-xm016-dc2

Poovendhan Selvaraj (4):
      arm64: dts: qcom: ipq9574: Enable the download mode support
      arm64: dts: qcom: ipq9574: Add SMEM support
      dt-bindings: arm: qcom: document AL02-C9 board based on IPQ9574 fa=
mily
      arm64: dts: qcom: ipq9574: add support for RDP454 variant

Prathamesh Shete (2):
      dt-bindings: gpio: Remove FSI domain ports on Tegra234
      arm64: tegra: Add Tegra234 pin controllers

Radhey Shyam Pandey (1):
      arm64: zynqmp: Add pmu interrupt-affinity

Rafa=C5=82 Mi=C5=82ecki (18):
      ARM: dts: BCM5301X: Relicense Rafa=C5=82's code to the GPL 2.0+ / =
MIT
      ARM: dts: BCM5301X: Relicense Florian's code to the GPL 2.0+ / MIT
      ARM: dts: BCM5301X: Drop "clock-names" from the SPI node
      ARM: dts: BCM5301X: Relicense Hauke's code to the GPL 2.0+ / MIT
      ARM: dts: BCM5301X: Relicense AXI interrupts code to the GPL 2.0+ =
/ MIT
      ARM: dts: BCM5301X: Specify MAC addresses on Luxul devices
      dt-bindings: arm: bcm: unify version notation of Northstar devices
      ARM: dts: BCM5301X: Use updated device "compatible" strings
      ARM: dts: BCM5301X: Use updated "spi-gpio" binding properties
      dt-bindings: arm: bcm: Add bindings for Buffalo WZR-1166DHP(2)
      ARM: dts: BCM5301X: Drop invalid #usb-cells
      ARM: dts: BCM5301X: Drop invalid properties from Meraki MR32 keys
      ARM: dts: BCM5301X: Relicense Christian's code to the GPL 2.0+ / M=
IT
      ARM: dts: BCM5301X: Describe switch ports in the main DTS
      dt-bindings: net: wireless: brcm,bcm4329-fmac: add BCM4366 binding
      dt-bindings: net: wireless: brcm,bcm4329-fmac: allow generic prope=
rties
      ARM: dts: BCM5301X: Add Netgear R8000 WiFi regulator mappings
      ARM: dts: BCM5301X: Add cells sizes to PCIe nodes

Raphael Gallais-Pou (4):
      ARM: dts: stm32: fix warnings on stm32f469-disco board
      dt-bindings: display: st,stm32-dsi: Remove unnecessary fields
      ARM: dts: stm32: fix dsi warnings on stm32mp15 boards
      ARM: dts: stm32: fix ltdc warnings in stm32mp15 boards

Rob Herring (4):
      ARM: dts: allwinner: Use quoted #include
      ARM: dts: Add .dts files missing from the build
      kbuild: Support flat DTBs install
      ARM: dts: Move .dts files to vendor sub-directories

Robert Marko (4):
      arm64: dts: microchip: sparx5: do not use PSCI on reference boards
      arm64: dts: microchip: sparx5: correct CPU address-cells
      arm64: dts: qcom: ipq8074: Add QUP5 SPI node
      arm64: dts: qcom: ipq8074: add critical thermal trips

Robin van der Gracht (3):
      ARM: dts: imx6qdl: vicut1: The sgtl5000 uses i2s not ac97
      ARM: dts: imx6dl: prtvt7: Adjust default backlight brightness to 65
      ARM: dts: imx6q: prtwd2: Correct iomux configuration for ENET MDIO=
 and MDC

Roger Quadros (1):
      arm64: dts: ti: k3-am625: Enable Type-C port for USB0

Rohit Agarwal (6):
      ARM: dts: qcom: sdx65: Add support for PCIe PHY
      ARM: dts: qcom: sdx65: Add support for PCIe EP
      ARM: dts: qcom: sdx65-mtp: Enable PCIe PHY
      ARM: dts: qcom: sdx65-mtp: Enable PCIe EP
      dt-bindings: arm: qcom: Document SDX75 platform and boards
      arm64: dts: qcom: Add SDX75 platform and IDP board support

Roman Beranek (1):
      ARM: dts: sunxi: rename tcon's clock output

Rudraksha Gupta (4):
      dt-bindings: arm: qcom: Add missing msm8960
      dt-bindings: arm: qcom: Add Samsung Galaxy Express
      ARM: dts: qcom: msm8960: Add USB node
      ARM: dts: qcom: Add Samsung Galaxy Express support

Russell King (1):
      ARM: dts: armada388-clearfog: add missing phy-modes

Ryan Wanner (1):
      ARM: dts: at91: Return to boolean properties

Sai Krishna Potthuri (1):
      arm64: zynqmp: Add resets property to sdhci nodes

Sam Protsenko (1):
      arm64: dts: exynos: Remove clock from Exynos850 pmu_system_control=
ler

Sebastian Reichel (3):
      arm64: dts: rockchip: add GIC ITS support to rk3588
      arm64: dts: rockchip: add PMIC to rk3588-evb1
      arm64: dts: rockchip: add PMIC to rock-5b

Shazad Hussain (7):
      arm64: dts: qcom: sa8775p: add USB nodes
      arm64: dts: qcom: sa8775p-ride: enable USB nodes
      arm64: dts: qcom: sa8775p: add the QUPv3 #0 and #3 node
      arm64: dts: qcom: sa8775p: add missing i2c nodes
      arm64: dts: qcom: sa8775p: add missing spi nodes
      arm64: dts: qcom: sa8775p: add uart5 and uart9 nodes
      arm64: dts: qcom: sa8775p-ride: enable i2c11

Shreeya Patel (2):
      arm64: dts: rockchip: Add DT node for ADC support in RK3588
      arm64: dts: rockchip: Add saradc node to rock5b

Shubhi Garg (2):
      dt-bindings: tegra: Document compatible for IGX
      arm64: tegra: Add support for IGX Orin

Sinthu Raja (2):
      arm64: dts: ti: k3-j721s2: Fix wkup pinmux range
      arm64: dts: ti: k3-am68-sk-base-board: Add pinmux for RPi Header

Srinivas Kandagatla (3):
      dt-bindings: clock: Add LPASSCC and reset controller for SC8280XP
      dt-bindings: clock: Add LPASS AUDIOCC and reset controller for SC8=
280XP
      arm64: dts: qcom: sc8280xp: add resets for soundwire controllers

Srinivas Neeli (1):
      arm64: zynqmp: Add linux,code for gpio button

Stanislav Jakubek (10):
      ARM: dts: bcm23550: Add SoC-specific I2C compatible
      ARM: dts: bcm-mobile: align SDHCI node name with bindings
      dt-bindings: soc: bcm: add missing dt-binding document for bcm2355=
0-cdc
      ARM: dts: bcm-mobile: change "" includes to <> where applicable
      ARM: dts: bcm21664/23550: use CCU compatibles directly
      ARM: dts: bcm-mobile: move status properties to the end of nodes
      ARM: dts: bcm11351/21664: add UART, I2C node labels
      ARM: dts: bcm21664-garnet: use node labels
      dt-bindings: power: reset: bcm21664-resetmgr: convert to YAML
      dt-bindings: firmware: brcm,kona-smc: convert to YAML

Stefan Wahren (2):
      ARM: dts: imx: Adjust dma-apbh node name
      ARM: dts: imx6ul: Add clock and PGC node to GPC

Steffen Trumtrar (10):
      ARM: dts: stm32: Add alternate pinmux for ethernet for stm32mp15
      ARM: dts: stm32: Add alternate pinmux for sai2b on stm32mp15
      ARM: dts: stm32: Add new pinmux for sdmmc1_b4 on stm32mp15
      ARM: dts: stm32: Add new pinmux for sdmmc2_d47 on stm32mp15
      ARM: dts: stm32: Add pinmux for USART1 pins on stm32mp15
      ARM: dts: stm32: Add idle/sleep pinmux for USART3 on stm32mp15
      ARM: dts: stm32: Add sleep pinmux for SPI1 pins_a on stm32mp15
      dt-bindings: arm: stm32: Add Phytec STM32MP1 board
      ARM: dts: stm32: add STM32MP1-based Phytec SoM
      ARM: dts: stm32: add STM32MP1-based Phytec board

Stephan Gerhold (29):
      arm64: dts: qcom: apq8016-sbc: Fix regulator constraints
      arm64: dts: qcom: apq8016-sbc: Fix 1.8V power rail on LS expansion
      arm64: dts: qcom: msm8916: Fix regulator constraints
      arm64: dts: qcom: msm8916: Disable audio codecs by default
      arm64: dts: qcom: pm8916: Move default regulator "-supply"s
      arm64: dts: qcom: msm8916-pm8916: Clarify purpose
      arm64: dts: qcom: msm8916: Define regulator constraints next to us=
age
      arm64: dts: qcom: msm8916-pm8916: Mark always-on regulators
      arm64: dts: qcom: Add msm8939-pm8916.dtsi include
      arm64: dts: qcom: msm8916: Rename &msmgpio -> &tlmm
      arm64: dts: qcom: msm8916/39: Rename &blsp1_uartN -> &blsp_uartN
      arm64: dts: qcom: msm8916/39: Use consistent name for I2C/SPI pinc=
trl
      arm64: dts: qcom: msm8916/39: Clean up MDSS labels
      arm64: dts: qcom: pm8916: Rename &wcd_codec -> &pm8916_codec
      arm64: dts: qcom: msm8916: Move aliases to boards
      arm64: dts: qcom: msm8916/39: Fix SD card detect pinctrl
      arm64: dts: qcom: msm8916/39: Consolidate SDC pinctrl
      arm64: dts: qcom: apq8016-sbc: Drop unneeded MCLK pinctrl
      arm64: dts: qcom: msm8916/39: Cleanup audio pinctrl
      arm64: dts: qcom: msm8916/39: Rename wcnss pinctrl
      arm64: dts: qcom: msm8916: Drop msm8916-pins.dtsi
      arm64: dts: qcom: msm8939-pm8916: Add missing pm8916_codec supplies
      arm64: dts: qcom: msm8939: Disable lpass_codec by default
      arm64: dts: qcom: msm8939-sony-tulip: Fix l10-l12 regulator voltag=
es
      arm64: dts: qcom: msm8939-sony-tulip: Allow disabling pm8916_l6
      arm64: dts: qcom: msm8939: Fix regulator constraints
      arm64: dts: qcom: msm8939-pm8916: Clarify purpose
      arm64: dts: qcom: msm8939: Define regulator constraints next to us=
age
      arm64: dts: qcom: msm8939-pm8916: Mark always-on regulators

Sumit Gupta (2):
      dt-bindings: tegra: Add ICC IDs for dummy memory clients
      arm64: tegra: Add CPU OPP tables and interconnects property

Taniya Das (2):
      dt-bindings: clock: qcom: Add SM8450 video clock controller
      arm64: dts: qcom: sm8450: Add video clock controller

Thejasvi Konduru (1):
      arm64: dts: ti: k3-j784s4: Fix wakeup pinmux range and pinctrl nod=
e offsets

Thierry Reding (11):
      Merge branch 'for-6.5/dt-bindings' into for-6.5/arm64/dt
      dt-bindings: usb: tegra-xudc: Remove extraneous PHYs
      dt-bindings: tegra: Document Jetson Orin Nano
      dt-bindings: tegra: Document Jetson Orin Nano Developer Kit
      arm64: tegra: Support Jetson Orin Nano Developer Kit
      arm64: tegra: Sort properties more logically
      arm64: tegra: Add a few blank lines for better readability
      arm64: tegra: Add Tegra234 thermal support
      arm64: tegra: Enable thermal support on Jetson AGX Orin
      arm64: tegra: Enable thermal support on Jetson Orin NX
      arm64: tegra: Enable thermal support on Jetson Orin Nano

Tianling Shen (5):
      dt-bindings: Add doc for Fastrhino R66S / R68S
      arm64: dts: rockchip: Add Lunzn Fastrhino R66S
      arm64: dts: rockchip: Add Lunzn Fastrhino R68S
      dt-bindings: arm: rockchip: add FriendlyARM NanoPi R2C Plus
      arm64: dts: rockchip: Add FriendlyARM NanoPi R2C Plus

Tim Harvey (6):
      dt-bindings: arm: Add Gateworks i.MX8M GW7905-2x board
      arm64: dts: freescale: Add imx8mp-venice-gw7905-2x
      ARM: dts: imx6qdl-gw54xx: remove invalid nodes from fan-controller
      ARM: dts: imx6qdl-gw5912: remove invalid nodes from fan-controller
      arm64: dts: imx8mm-venice-gw700x: remove invalid props from fan-co=
ntroller
      arm64: dts: imx8mp-venice-gw702x: fix GSC vdd_bat data size

Tony Lindgren (14):
      ARM: dts: gta04: Move model property out of pinctrl node
      ARM: dts: Unify pinctrl-single pin group nodes for omap3
      ARM: dts: Unify pinctrl-single pin group nodes for omap2
      ARM: dts: Unify pinctrl-single pin group nodes for omap4
      ARM: dts: Unify pinctrl-single pin group nodes for omap5
      ARM: dts: Unify pinctrl-single pin group nodes for ti81xx
      ARM: dts: Unify pinctrl-single pin group nodes for am33xx
      ARM: dts: Unify pinctrl-single pin group nodes for am4
      ARM: dts: Unify pinctrl-single pin group nodes for dra7
      arm64: dts: broadcom: Unify pinctrl-single pin group nodes for sti=
ngray
      ARM: dts: hisilicon: Unify pinctrl-single pin group nodes
      arm64: dts: hisilicon: Unify pinctrl-single pin group nodes
      ARM: dts: Unify pinctrl-single pin group nodes for keystone
      arm64: dts: ti: Unify pin group node names for make dtbs checks

Udit Kumar (7):
      arm64: dts: ti: k3-j7200-som: Enable I2C
      arm64: dts: ti: k3-j7200: Add general purpose timers
      arm64: dts: ti: k3-j7200: Configure pinctrl for timer IO pads
      arm64: dts: ti: k3-j7200-common-proc-board: remove duplicate main_=
i2c0 pin mux
      arm64: dts: ti: k3-j7200-common-proc-board: Add uart pinmux
      arm64: dts: ti: k3-j7200-common-proc-board: Define aliases at boar=
d level
      arm64: dts: ti: k3-j7200: Drop SoC level aliases

Vadym Kochan (1):
      arm64: dts: marvell: cp11x: Fix nand_controller node name accordin=
g to YAML

Vaishnav Achath (9):
      arm64: dts: ti: k3-j721e-mcu-wakeup: Add HyperBus node
      arm64: dts: ti: k3-j721e-som-p0: Add HyperFlash node
      arm64: dts: ti: k3-j7200-common-proc-board: Add OSPI/Hyperflash se=
lect pinmux
      arm64: dts: ti: k3-j721e-common-proc-board: Add OSPI/Hyperflash se=
lect pinmux
      arm64: dts: ti: k3-j721e: Describe OSPI and QSPI flash partition i=
nfo
      arm64: dts: ti: k3-j721e-sk: Describe OSPI flash partition info
      arm64: dts: ti: k3-j7200-som: Describe OSPI and Hyperflash partiti=
on info
      arm64: dts: ti: k3-am654-baseboard: Describe OSPI flash partition =
info
      arm64: dts: ti: k3-am642-sk/evm: Describe OSPI flash partition info

Varadarajan Narayanan (2):
      arm64: dts: qcom: ipq9574: add tsens node
      arm64: dts: qcom: ipq9574: add thermal zone nodes

Varalaxmi Bingi (1):
      ARM: zynq: dts: Setting default i2c clock frequency to 400kHz

Vignesh Viswanathan (2):
      arm64: dts: qcom: enable the download mode support
      arm64: dts: qcom: add few more reserved memory region

Vijaya Krishna Nivarthi (3):
      arm64: dts: qcom: sc7180: Add stream-id of qspi to iommus
      arm64: dts: qcom: sc7280: Add stream-id of qspi to iommus
      arm64: dts: qcom: sdm845: Add stream-id of qspi to iommus

Vinod Koul (7):
      arm64: dts: qcom: sc8180x: Add interconnects and lmh
      arm64: dts: qcom: sc8180x: Add thermal zones
      arm64: dts: qcom: sc8180x: Add QUPs
      arm64: dts: qcom: sc8180x: Add PCIe instances
      arm64: dts: qcom: sc8180x: Add remoteprocs, wifi and usb nodes
      arm64: dts: qcom: sc8180x: Add display and gpu nodes
      arm64: dts: qcom: sc8180x: Add pmics

Wadim Egorov (3):
      arm64: dts: ti: Add LED controller to phyBOARD-Electra
      dt-bindings: arm: ti: Add bindings for PHYTEC AM62x based hardware
      arm64: dts: ti: Add basic support for phyBOARD-Lyra-AM625

Walker Chen (1):
      riscv: dts: starfive: Add PMU controller node

Wei Fang (1):
      arm64: dts: imx93: add fsl,stop-mode property to support WOL

Wolfram Sang (2):
      arm64: dts: renesas: ulcb-kf: Remove flow control for SCIF1
      arm64: dts: renesas: ulcb-kf: Add HSCIF1 node

Xianwei Zhao (1):
      arm64: dts: add support for C3 based Amlogic AW409

Xingyu Wu (2):
      riscv: dts: starfive: jh7100: Add watchdog node
      riscv: dts: starfive: jh7110: Add watchdog node

Xu Yang (1):
      arm64: dts: imx93: add ddr performance monitor node

Yang Xiwen (1):
      arm64: dts: qcom: msm8916-ufi: make UDC dual mode

Yassine Oudjana (1):
      arm64: dts: qcom: msm8996pro: Add CBF scaling support

Yoshihiro Shimoda (1):
      arm64: dts: renesas: Add IOMMU related properties into PCIe host n=
odes

Yunfei Dong (1):
      arm64: dts: mt8195: Add video decoder node

hfdevel@gmx.net (1):
      ARM: dts: meson8b: correct uart_B and uart_C clock references

dirstat:
   0.0% Documentation/devicetree/bindings/arm/bcm/
   0.0% Documentation/devicetree/bindings/arm/samsung/
   0.0% Documentation/devicetree/bindings/arm/stm32/
   0.0% Documentation/devicetree/bindings/arm/ti/
   0.2% Documentation/devicetree/bindings/arm/
   0.0% Documentation/devicetree/bindings/ata/
   0.4% Documentation/devicetree/bindings/clock/
   0.0% Documentation/devicetree/bindings/crypto/
   0.0% Documentation/devicetree/bindings/display/
   0.0% Documentation/devicetree/bindings/firmware/xilinx/
   0.0% Documentation/devicetree/bindings/firmware/
   0.0% Documentation/devicetree/bindings/fpga/
   0.0% Documentation/devicetree/bindings/gpio/
   0.0% Documentation/devicetree/bindings/gpu/
   0.0% Documentation/devicetree/bindings/i2c/
   0.0% Documentation/devicetree/bindings/interrupt-controller/
   0.0% Documentation/devicetree/bindings/mailbox/
   0.0% Documentation/devicetree/bindings/media/xilinx/
   0.0% Documentation/devicetree/bindings/media/
   0.0% Documentation/devicetree/bindings/memory-controllers/
   0.1% Documentation/devicetree/bindings/misc/
   0.0% Documentation/devicetree/bindings/net/wireless/
   0.0% Documentation/devicetree/bindings/nvmem/
   0.0% Documentation/devicetree/bindings/pci/
   0.0% Documentation/devicetree/bindings/pinctrl/
   0.0% Documentation/devicetree/bindings/power/reset/
   0.0% Documentation/devicetree/bindings/riscv/
   0.0% Documentation/devicetree/bindings/rtc/
   0.0% Documentation/devicetree/bindings/serial/
   0.0% Documentation/devicetree/bindings/soc/bcm/
   0.0% Documentation/devicetree/bindings/spi/
   0.0% Documentation/devicetree/bindings/timer/
   0.0% Documentation/devicetree/bindings/usb/
   0.0% Documentation/devicetree/bindings/watchdog/
   0.0% Documentation/devicetree/bindings/
   0.0% arch/arm/boot/dts/actions/
   0.0% arch/arm/boot/dts/airoha/
   0.9% arch/arm/boot/dts/allwinner/
   0.0% arch/arm/boot/dts/alphascale/
   0.0% arch/arm/boot/dts/amazon/
   0.0% arch/arm/boot/dts/amlogic/
   0.0% arch/arm/boot/dts/arm/
   0.1% arch/arm/boot/dts/aspeed/
   0.0% arch/arm/boot/dts/axis/
   1.4% arch/arm/boot/dts/broadcom/
   0.0% arch/arm/boot/dts/calxeda/
   0.0% arch/arm/boot/dts/cirrus/
   0.0% arch/arm/boot/dts/cnxt/
   0.0% arch/arm/boot/dts/gemini/
   0.3% arch/arm/boot/dts/hisilicon/
   0.0% arch/arm/boot/dts/hpe/
   0.0% arch/arm/boot/dts/intel/axm/
   0.0% arch/arm/boot/dts/intel/ixp/
   0.0% arch/arm/boot/dts/intel/pxa/
   0.0% arch/arm/boot/dts/intel/socfpga/
   0.0% arch/arm/boot/dts/intel/
   0.5% arch/arm/boot/dts/marvell/
   0.4% arch/arm/boot/dts/mediatek/
   0.6% arch/arm/boot/dts/microchip/
   0.0% arch/arm/boot/dts/moxa/
   0.0% arch/arm/boot/dts/nspire/
   0.0% arch/arm/boot/dts/nuvoton/
   0.0% arch/arm/boot/dts/nvidia/
   2.2% arch/arm/boot/dts/nxp/imx/
   0.0% arch/arm/boot/dts/nxp/lpc/
   0.0% arch/arm/boot/dts/nxp/ls/
   0.1% arch/arm/boot/dts/nxp/mxs/
   0.1% arch/arm/boot/dts/nxp/vf/
   0.0% arch/arm/boot/dts/nxp/
   1.8% arch/arm/boot/dts/qcom/
   0.0% arch/arm/boot/dts/realtek/
   0.0% arch/arm/boot/dts/renesas/
   0.1% arch/arm/boot/dts/rockchip/
   1.1% arch/arm/boot/dts/samsung/
   0.0% arch/arm/boot/dts/sigmastar/
   0.0% arch/arm/boot/dts/socionext/
   2.2% arch/arm/boot/dts/st/
   0.0% arch/arm/boot/dts/sunplus/
   0.0% arch/arm/boot/dts/synaptics/
   0.0% arch/arm/boot/dts/ti/davinci/
   0.3% arch/arm/boot/dts/ti/keystone/
   6.1% arch/arm/boot/dts/ti/omap/
   0.0% arch/arm/boot/dts/ti/
   0.0% arch/arm/boot/dts/unisoc/
   0.0% arch/arm/boot/dts/vt8500/
   0.0% arch/arm/boot/dts/xen/
   0.0% arch/arm/boot/dts/xilinx/
   3.2% arch/arm/boot/dts/
   0.0% arch/arm/
   0.0% arch/arm64/boot/dts/allwinner/
   0.0% arch/arm64/boot/dts/amazon/
   0.1% arch/arm64/boot/dts/amlogic/
   0.0% arch/arm64/boot/dts/apm/
   0.0% arch/arm64/boot/dts/arm/
   0.0% arch/arm64/boot/dts/broadcom/bcmbca/
   0.0% arch/arm64/boot/dts/broadcom/northstar2/
   0.1% arch/arm64/boot/dts/broadcom/stingray/
   0.0% arch/arm64/boot/dts/broadcom/
   0.0% arch/arm64/boot/dts/exynos/
   4.4% arch/arm64/boot/dts/freescale/
   0.9% arch/arm64/boot/dts/hisilicon/
   0.0% arch/arm64/boot/dts/marvell/
   4.0% arch/arm64/boot/dts/mediatek/
   0.0% arch/arm64/boot/dts/microchip/
   1.3% arch/arm64/boot/dts/nvidia/
  35.5% arch/arm64/boot/dts/qcom/
   0.0% arch/arm64/boot/dts/realtek/
   1.4% arch/arm64/boot/dts/renesas/
   4.3% arch/arm64/boot/dts/rockchip/
   0.0% arch/arm64/boot/dts/socionext/
   0.0% arch/arm64/boot/dts/synaptics/
  18.7% arch/arm64/boot/dts/ti/
   1.3% arch/arm64/boot/dts/xilinx/
   0.0% arch/riscv/boot/dts/allwinner/
   0.1% arch/riscv/boot/dts/starfive/
   0.7% arch/riscv/boot/dts/thead/
   0.0% arch/riscv/boot/dts/
   0.0% arch/riscv/configs/
   0.0% arch/riscv/
   0.7% include/dt-bindings/clock/
   0.0% include/dt-bindings/gpio/
   0.0% include/dt-bindings/memory/
   0.1% include/dt-bindings/power/
   0.0% include/dt-bindings/reset/
   0.0% include/dt-bindings/thermal/
   0.0% scripts/
