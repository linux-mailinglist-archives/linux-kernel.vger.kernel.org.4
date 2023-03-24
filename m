Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EAE96C8793
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 22:43:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231904AbjCXVnJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 17:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjCXVnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 17:43:08 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34EE5A266
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 14:43:06 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 81FFA3200952;
        Fri, 24 Mar 2023 17:43:02 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Fri, 24 Mar 2023 17:43:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm1; t=1679694182; x=1679780582; bh=okSJCCN1OzLHGs5rzBuQ7AzMs
        ikHX0VfQuuARxIDmsY=; b=TVz9cka1c/Dq5lAf8g68n3rWNBcQk8vMkf+z7W+//
        cFoan7lrR/lvS5kx/kju2ORCOuRjkLQD3dJBQ6fLyZxzewt1LGI7gWo7qKqRYTDY
        twcF3OAZCMmFLkAziRkjs34y1YJCcExK4KWtBIN/Gu7cV7aZg8VDDQ3EakwUyzyb
        JceIms6duTd0+bi/Lis4DL9wsRfQTPoieFGKmrq5NhzmyTWLRdYgrRJDje4SvrCI
        HjQhThiNlMLBf6pvdGVYJBbHXaU3g7NAiKEyEiPv2VmhwrdZPsMnryL7xW4siNFJ
        OOqqD6pLsrAzBGwFewwmQNDOqk+LAlQ7taCjVy6zAJzqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1679694182; x=1679780582; bh=okSJCCN1OzLHGs5rzBuQ7AzMsikHX0VfQuu
        ARxIDmsY=; b=BzN7wawEimg6hSAnlS3t/gGVQ4n07jUSOBCChmN9fk2xIqiQDUo
        aM4soniJarXSmoJb5uBY2xQQtVLujVxlfvuwx15EvSQVveqY73JO/n+vkDHKnbQx
        lNpDjRbsxwMz/5Xv1A7z/kLI+iUxTAXJxRWGRTbYbxFI8H/foaVlQPxmoAFfIiZ9
        qK4OG8IrwWSf6irZl0pw6zwxir7xa6MGJoiv2x8srg3vEEOX3BgjuOK8ZRCIMU+b
        BEM01WzUG1h8N2B5ujn2rORxktHS6yfHqjTJK6aTpf0LYRtOTANk/2vjZU/+kl4p
        YIUKlBxzDIYPP7l7tE+LGbsfEnyPA1y2ebw==
X-ME-Sender: <xms:ZRkeZN5WKiZuXe--QTxmQNoDbWI-15PgSkEZSWNKTaxj1K5GbMpysQ>
    <xme:ZRkeZK6MsCotH9YGwqgTBMJFq4Yt4f4ArVQwpFgD-xfNgQIhcYpocFUTlVLnL4K4t
    9umYX8eVK5fAwWZNVk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdegiedgudehfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpedtlefhkedvvdethfeuteekheettddvveeltdffhfejudffheelieelheevjeej
    keenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhlihhnrghrohdrohhrghenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghr
    nhgusgdruggv
X-ME-Proxy: <xmx:ZRkeZEeSWFdKUBS7ZyTs_xdKAYmMMJx1JC5rN-h2kK5kWUfL5g5ljw>
    <xmx:ZRkeZGJ-eXQJdt_YCQa7K21Db-f9z_Xr3omCPvIs7WMTNVzLFqUtEQ>
    <xmx:ZRkeZBKg4nlwPExLtqOybhhkaUDH37lPTqf_f86DsxvG-KymI8-H3A>
    <xmx:ZhkeZPgzqbYjanYY6xX-sG-1h029Y5Fvn8LncyGrM1yOB5OoYWJcqQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id CFE99B60086; Fri, 24 Mar 2023 17:43:01 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-236-g06c0f70e43-fm-20230313.001-g06c0f70e
Mime-Version: 1.0
Message-Id: <e6a9ec59-7227-48e1-8636-e020f3489788@app.fastmail.com>
Date:   Fri, 24 Mar 2023 22:40:06 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Linus Torvalds" <torvalds@linux-foundation.org>
Cc:     soc@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL] ARM: SoC fixes for 6.3, part 2
Content-Type: text/plain
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit fe15c26ee26efa11741a7b632e9f23b01aca4cc6:

  Linux 6.3-rc1 (2023-03-05 14:52:03 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/arm-fixes-6.3-2

for you to fetch changes up to ec7d8bd7d40f14b03da2d9cc3c6c8c845d62fb0f:

  Merge tag 'qcom-driver-fixes-for-6.3' of https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux into soc/fixes (2023-03-24 18:06:29 +0100)

----------------------------------------------------------------
ARM: SoC fixes for 6.3, part 2

As usual, most of the bug fixes address issues in the devicetree files,
and out of these, most are for the Qualcomm and NXP platforms, including:

 - A missing "reserved-memory" property on LG G Watch R that
   is needed to prevent clashing with firmware

 - Annotations for cache coherency on multiple machines

 - Corrections for pinctrl, regulator, clock, iommu and power domain
   properties for i.MX and Qualcomm to correctly reflect the
   hardware settings

 - Firmware file names on multiple machines
   SA8540P Ride board

 - An incompatible change to the qcom vadc driver requires adding
   individual labels

 - Fix EQoS PHY reset GPIO by dropping the deprecated/wrong property
   and switch to the new bindings.

 - A fix for PCI bus address translation Tegra194 and Tegra234.

There are also a couple of device driver fixes, addressing

 - A race condition in the amdtee driver

 - A performance regression in the Qualcomm 'llcc' driver

 - An unitialized variable use NXP i.MX "weim" driver

 - Error handling issues in Qualcomm "rmtfs", and "scm"
   drivers and the Arm scmi firmware driver

----------------------------------------------------------------
Abel Vesa (2):
      arm64: dts: qcom: sm8550: Add bias pull up value to tlmm i2c data clk states
      soc: qcom: llcc: Fix slice configuration values for SC8280XP

Alexander Stein (3):
      arm64: dts: freescale: imx8-ss-lsio: Fix flexspi clock order
      arm64: dts: imx93: Fix eqos properties
      arm64: dts: imx93: add missing #address-cells and #size-cells to i2c nodes

Andrew Halaney (1):
      arm64: dts: imx8dxl-evk: Fix eqos phy reset gpio

Arnd Bergmann (7):
      Merge tag 'amdtee-fix-for-v6.3' of https://git.linaro.org/people/jens.wiklander/linux-tee into soc-fixes
      Merge tag 'tegra-for-6.3-arm64-dt-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux into soc-fixes
      Merge tag 'imx-fixes-6.3' of git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux into soc-fixes
      Merge tag 'scmi-fixes-6.3' of git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux into soc/fixes
      Merge tag 'qcom-arm64-fixes-for-6.3' of https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux into soc/fixes
      Merge tag 'qcom-dts-fixes-for-6.3' of https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux into soc/fixes
      Merge tag 'qcom-driver-fixes-for-6.3' of https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux into soc/fixes

Brian Masney (1):
      arm64: dts: qcom: sa8540p-ride: correct name of remoteproc_nsp0 firmware

Christophe JAILLET (1):
      firmware: arm_scmi: Use the bitmap API to allocate bitmaps

Cristian Marussi (2):
      firmware: arm_scmi: Fix raw coexistence mode behaviour on failure path
      firmware: arm_scmi: Fix device node validation for mailbox transport

Dan Carpenter (2):
      firmware: arm_scmi: Clean up a return statement in scmi_probe
      firmware: arm_scmi: Return a literal instead of a variable

Ivan Bornyakov (1):
      bus: imx-weim: fix branch condition evaluates to a garbage value

Jianhua Lu (1):
      arm64: dts: qcom: sm8250-xiaomi-elish: Correct venus firmware path

Johan Hovold (5):
      firmware: qcom: scm: fix bogus irq error at probe
      arm64: dts: qcom: sc8280xp-x13s: mark s11b regulator as always-on
      arm64: dts: qcom: sc8280xp-x13s: mark s10b regulator as always-on
      arm64: dts: qcom: sc8280xp-x13s: mark s12b regulator as always-on
      arm64: dts: qcom: sc8280xp-x13s: mark bob regulator as always-on

Konrad Dybcio (3):
      arm64: dts: qcom: sm6115: Un-enable SPI5 by default
      arm64: dts: qcom: sm6375: Add missing power-domain-named to CDSP
      arm64: dts: qcom: sm8550: Use correct CPU compatibles

Krishna chaitanya chundru (1):
      arm64: dts: qcom: sc7280: Mark PCIe controller as cache coherent

Krzysztof Kozlowski (3):
      arm64: dts: qcom: sm8450: correct WSA2 assigned clocks
      arm64: dts: qcom: sm8550: fix LPASS pinctrl slew base address
      arm64: dts: imx8mm-nitrogen-r2: fix WM8960 clock name

Luca Weiss (3):
      soc: qcom: rmtfs: fix error handling reading qcom,vmid
      soc: qcom: rmtfs: handle optional qcom,vmid correctly
      ARM: dts: qcom: apq8026-lg-lenok: add missing reserved memory

Manivannan Sadhasivam (5):
      arm64: dts: qcom: sm8150: Fix the iommu mask used for PCIe controllers
      arm64: dts: qcom: sc8280xp: Add label property to vadc channel nodes
      arm64: dts: qcom: sm8350: Mark UFS controller as cache coherent
      arm64: dts: qcom: sm8450: Mark UFS controller as cache coherent
      arm64: dts: qcom: sm8550: Mark UFS controller as cache coherent

Marek Vasut (2):
      arm64: dts: imx8mp: Fix LCDIF2 node clock order
      arm64: dts: imx8mn: specify #sound-dai-cells for SAI nodes

Michael Walle (1):
      Revert "arm64: dts: ls1028a: sl28: get MAC addresses from VPD"

Peng Fan (3):
      ARM: dts: imx6sll: e70k02: fix usbotg1 pinctrl
      ARM: dts: imx6sll: e60k02: fix usbotg1 pinctrl
      ARM: dts: imx6sl: tolino-shine2hd: fix usbotg1 pinctrl

Rijo Thomas (1):
      tee: amdtee: fix race condition in amdtee_open_session

Srinivas Kandagatla (4):
      arm64: dts: qcom: sc8280xp: fix rx frame shapping info
      arm64: dts: qcom: sc8280xp: fix lpass tx macro clocks
      arm64: dts: qcom: sc8280xp-x13s: fix dmic sample rate
      arm64: dts: qcom: sc8280xp-x13s: fix va dmic dai links and routing

Thierry Reding (1):
      arm64: tegra: Bump CBB ranges property on Tegra194 and Tegra234

Yang Xiwen (1):
      arm64: dts: qcom: msm8916-ufi: Fix sim card selection pinctrl

Ye Xingchen (1):
      firmware: arm_scmi: Remove duplicate include header inclusion

 arch/arm/boot/dts/e60k02.dtsi                      |  1 +
 arch/arm/boot/dts/e70k02.dtsi                      |  1 +
 arch/arm/boot/dts/imx6sl-tolino-shine2hd.dts       |  1 +
 arch/arm/boot/dts/qcom-apq8026-lg-lenok.dts        | 10 +++++
 .../fsl-ls1028a-kontron-kbox-a-230-ls.dts          | 12 ------
 .../freescale/fsl-ls1028a-kontron-sl28-var1.dts    |  2 -
 .../freescale/fsl-ls1028a-kontron-sl28-var2.dts    |  8 ----
 .../freescale/fsl-ls1028a-kontron-sl28-var4.dts    |  2 -
 .../dts/freescale/fsl-ls1028a-kontron-sl28.dts     | 17 --------
 arch/arm64/boot/dts/freescale/imx8-ss-lsio.dtsi    |  2 +-
 arch/arm64/boot/dts/freescale/imx8dxl-evk.dts      |  5 ++-
 .../boot/dts/freescale/imx8mm-nitrogen-r2.dts      |  2 +-
 arch/arm64/boot/dts/freescale/imx8mn.dtsi          |  5 +++
 arch/arm64/boot/dts/freescale/imx8mp.dtsi          |  4 +-
 arch/arm64/boot/dts/freescale/imx93.dtsi           | 24 +++++++++--
 arch/arm64/boot/dts/nvidia/tegra194.dtsi           |  2 +-
 arch/arm64/boot/dts/nvidia/tegra234.dtsi           |  2 +-
 arch/arm64/boot/dts/qcom/msm8916-thwc-uf896.dts    |  4 --
 arch/arm64/boot/dts/qcom/msm8916-thwc-ufi001c.dts  | 28 ++++++++++++-
 arch/arm64/boot/dts/qcom/msm8916-ufi.dtsi          | 10 -----
 arch/arm64/boot/dts/qcom/sa8540p-ride.dts          |  2 +-
 arch/arm64/boot/dts/qcom/sc7280.dtsi               |  2 +
 .../dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts     | 27 +++++++++---
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi             | 18 ++++----
 arch/arm64/boot/dts/qcom/sm6115.dtsi               |  1 +
 arch/arm64/boot/dts/qcom/sm6375.dtsi               |  1 +
 arch/arm64/boot/dts/qcom/sm8150.dtsi               |  4 +-
 arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish.dts   |  2 +-
 arch/arm64/boot/dts/qcom/sm8350.dtsi               |  1 +
 arch/arm64/boot/dts/qcom/sm8450.dtsi               |  5 ++-
 arch/arm64/boot/dts/qcom/sm8550.dtsi               | 49 +++++++++++-----------
 drivers/bus/imx-weim.c                             |  2 +-
 drivers/firmware/arm_scmi/bus.c                    |  3 +-
 drivers/firmware/arm_scmi/driver.c                 | 14 +++----
 drivers/firmware/arm_scmi/mailbox.c                | 37 ++++++++++++++++
 drivers/firmware/qcom_scm.c                        |  2 +-
 drivers/soc/qcom/llcc-qcom.c                       |  6 +--
 drivers/soc/qcom/rmtfs_mem.c                       | 10 +++--
 drivers/tee/amdtee/core.c                          | 29 +++++++------
 39 files changed, 212 insertions(+), 145 deletions(-)
