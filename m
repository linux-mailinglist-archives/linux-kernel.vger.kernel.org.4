Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2B169B1BF
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 18:26:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbjBQR0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 12:26:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjBQR0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 12:26:36 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FA886EB9E
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 09:26:35 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id AE7F65C0075;
        Fri, 17 Feb 2023 12:26:34 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Fri, 17 Feb 2023 12:26:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1676654794; x=
        1676741194; bh=EstTb2HUiYCTi+gg74KuT9lsccAHiv5Fn7sRoHN6wvE=; b=F
        /T8IASftYYnMfohYZdoxbPqAM7RU6+NpT2s+1BtaQxyP1UUCK2a+tQMB8qswlrTq
        knnOjpupe0hsW3NYzQCgeb4iVxYx2B2lAxX23cpoQdWTWFHG54gAh1GGryQ4FrC6
        ImAAGEW/1/tCg6+i0dbttWd965cIuDQh4o+EN42lRfGWrXPXEox1ReEeSrp+XNkC
        OGfUYGIKhoJKgz4BtnFKHH6aRLCm7t+FombVfzfpvl73wFugIN2MFAlfCR7arYo2
        8PXkl7pNfBwrm8EbZbhPfSuZrwDZKfBiQAwapuHCbfCPCsI5BS/qdLnBnq45JGyh
        pGlppxC9a9EtNBzfwmiVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1676654794; x=
        1676741194; bh=EstTb2HUiYCTi+gg74KuT9lsccAHiv5Fn7sRoHN6wvE=; b=Z
        smn1aQwt8JkXCg361pO0FPXkr5hX0EKmdeq1rvSlk/1S5vQFo6d5qu2zE2A5CoDs
        tWKi5QRhfZmWlUHD6Zd+7CIUrfbFeJvHQ65vc9bn7xzB4HHtsB0WGXOjlolQRS+5
        NIVtZIZobIROeSBKsKnceZAd97BTK84pieQxlozhe0myRM18HqwtcLU8Ev1lo947
        nic0MDDZYfQM3zco7p6LtZkCP6bdGdoExdbDepnCGil+cPwJPD/EMEIAUmUN7oUf
        kcBC0zSSOh0o4JG7MATKrDu3S8YCNzK1azweVvoOX0rvYtAP6zfyyQJFb52DJzyt
        I5GiYRTlOnNzQoy4yKn+A==
X-ME-Sender: <xms:yrjvY2g6YlUKX0pCwfJL4P12JT6BOwhgbnC-edMMVeddTi7TvS6ecQ>
    <xme:yrjvY3BqIuu31tcVYHofjgQrP7iLNlvnlH1Y8iYMoE5LFWSA22wV3GuMROiVc-sKx
    vOzeJVcvL95NkSkSPY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudeiledgleejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpefgkefhheetvdethfejkeeigfehtdffieevfeefteffteejffehlefhtdeu
    veejueenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhgihhthhhusgdrtghomhenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnuges
    rghrnhgusgdruggv
X-ME-Proxy: <xmx:yrjvY-FJ6D-u2o4z1CyJ9x3YoCFq5Jlb1i4ubytbplBqeMW_aMjLVA>
    <xmx:yrjvY_QGl2bu7kgHchUltE-vxD1eKg45C2UgqoJhmHb68vOVHOKdHg>
    <xmx:yrjvYzzywJt953-Ntpv0A15HBC927hcgH5e06iuPS1Lp4d9To0YF5g>
    <xmx:yrjvY8p8ZK-yFNyhHsmQR180NhMn989lmemIFxw6tzLQvm-jeKtPmg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 770AEB60086; Fri, 17 Feb 2023 12:26:34 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-156-g081acc5ed5-fm-20230206.001-g081acc5e
Mime-Version: 1.0
Message-Id: <f2e84e19-e8ab-4b50-befa-6560512500a2@app.fastmail.com>
In-Reply-To: <99179367-0d59-4938-b44c-ca9408ad784e@app.fastmail.com>
References: <99179367-0d59-4938-b44c-ca9408ad784e@app.fastmail.com>
Date:   Fri, 17 Feb 2023 18:26:17 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Linus Torvalds" <torvalds@linux-foundation.org>
Cc:     soc@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL 3/4] ARM: defconfigs for 6.3
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

The following changes since commit b7bfaa761d760e72a969d116517eaa12e404c=
262:

  Linux 6.2-rc3 (2023-01-08 11:49:43 -0600)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-d=
efconfig-6.3

for you to fetch changes up to af16544d4abe283e4a1ead6563ae883b9bb35429:

  Merge tag 'qcom-arm64-defconfig-for-6.3-3' of https://git.kernel.org/p=
ub/scm/linux/kernel/git/qcom/linux into soc/defconfig (2023-02-15 15:05:=
53 +0100)

----------------------------------------------------------------
ARM: defconfigs for 6.3

As usual, this branch contains all the patches to enable options
for newly added device drivers in the 32-bit and 64-bit defconfig
files.

I have sorted the files according to the changes to Kconfig files,
to make it easier to check what has changed compared to the 'make
savedefconfig' output.

The most notable change this time is a series from Mark Brown
to add a 'virtconfig' target for arm64, which is for the moment
the same as the 'defconfig' target but disables all the top-level
SoC specific options in order to have a smaller and faster
kernel build.

----------------------------------------------------------------
Abel Vesa (1):
      arm64: defconfig: Enable GCC, TCSRCC, pinctrl and interconnect for=
 SM8550

Alexander Stein (1):
      ARM: multi_v7_defconfig: Add options to support TQMLS102xA series

Arnd Bergmann (9):
      Merge tag 'renesas-arm-defconfig-for-v6.3-tag1' of git://git.kerne=
l.org/pub/scm/linux/kernel/git/geert/renesas-devel into soc/defconfig
      Merge tag 'sunxi-config-for-6.3-1' of https://git.kernel.org/pub/s=
cm/linux/kernel/git/sunxi/linux into soc/defconfig
      Merge tag 'arm-soc/for-6.3/defconfig' of https://github.com/Broadc=
om/stblinux into soc/defconfig
      Merge tag 'imx-defconfig-6.3' of git://git.kernel.org/pub/scm/linu=
x/kernel/git/shawnguo/linux into soc/defconfig
      Merge tag 'v6.2-next-defconfig' of https://git.kernel.org/pub/scm/=
linux/kernel/git/matthias.bgg/linux into soc/defconfig
      arm64: reorder defconfig
      ARM: reorder defconfig files
      Merge tag 'qcom-arm64-defconfig-for-6.3-2' of https://git.kernel.o=
rg/pub/scm/linux/kernel/git/qcom/linux into soc/defconfig
      Merge tag 'qcom-arm64-defconfig-for-6.3-3' of https://git.kernel.o=
rg/pub/scm/linux/kernel/git/qcom/linux into soc/defconfig

Bartosz Golaszewski (2):
      arm64: defconfig: enable the clock driver for Qualcomm SA8775P pla=
tforms
      arm64: defconfig: enable drivers required by the Qualcomm SA8775P =
platform

Bhupesh Sharma (1):
      arm64: defconfig: Enable Qualcomm EUD

Biju Das (1):
      arm64: defconfig: Enable Renesas RZ/G2L MIPI DSI driver

Bjorn Andersson (2):
      arm64: defconfig: Enable SC8280XP Display Clock Controller
      arm64: defconfig: Enable DisplayPort on SC8280XP laptops

Brian Masney (1):
      arm64: defconfig: enable crypto userspace API

Dmitry Baryshkov (3):
      arm64: defconfig: build PINCTRL_SM8250_LPASS_LPI as module
      arm64: defconfig: enable camera on Thundercomm RB5 platform
      arm64: defconfig: build SDM_LPASSCC_845 as a module

Geert Uytterhoeven (2):
      ARM: shmobile: defconfig: Refresh for v6.1-rc5
      arm64: defconfig: Enable RZ/G2L MIPI CSI-2 and CRU support

Johan Hovold (2):
      arm64: defconfig: enable Qualcomm PCIe modem drivers
      arm64: defconfig: enable Qualcomm SDAM nvmem driver

Jonathan Neusch=C3=A4fer (1):
      ARM: Add wpcm450_defconfig for Nuvoton WPCM450

Linus Walleij (1):
      ARM: defconfig: Add IOSCHED_BFQ to the default configs

Mark Brown (6):
      ARM: multi_v7_defconfig: Enable wm896x audio CODECs
      ARM: multi_v5_defconfig: Enable I2C_GPIO
      ARM: imx_v6_v7_defconfig: Don't enable PROVE_LOCKING
      scripts: merge_config: Add option to suppress warning on overrides
      kbuild: Provide a version of merge_into_defconfig without override=
 warnings
      arm64: configs: Add virtconfig

Neil Armstrong (3):
      arm64: defconfig: enable SM8550 DISPCC clock driver
      arm64: defconfig: enable Visionox VTDR6130 DSI Panel driver
      arm64: defconfig: enable SM8450 DISPCC clock driver

Nick Hawkins (1):
      ARM: multi_v7_defconfig: Add GXP Fan and SPI support

Nicolas Saenz Julienne (2):
      kbuild: Add config fragment merge functionality
      ARM: add multi_v7_lpae_defconfig

N=C3=ADcolas F. R. A. Prado (2):
      arm64: defconfig: Enable missing configs for mt8192-asurada
      arm64: defconfig: Enable DMA_RESTRICTED_POOL

Patrick Delaunay (1):
      ARM: configs: multi_v7: enable NVMEM driver for STM32

Peng Fan (1):
      arm64: defconfig: select i.MX ICC and DEVFREQ

Samuel Holland (1):
      riscv: defconfig: Enable the Allwinner D1 platform and drivers

Stefan Wahren (2):
      ARM: bcm2835_defconfig: Enable the framebuffer
      ARM: bcm2835_defconfig: Switch to SimpleDRM

 MAINTAINERS                              |   1 +
 arch/arm/Makefile                        |   6 +
 arch/arm/configs/at91_dt_defconfig       |   2 +-
 arch/arm/configs/bcm2835_defconfig       |   3 +-
 arch/arm/configs/dove_defconfig          |   6 +-
 arch/arm/configs/exynos_defconfig        |  10 +-
 arch/arm/configs/gemini_defconfig        |   2 +-
 arch/arm/configs/imx_v6_v7_defconfig     |   3 +-
 arch/arm/configs/keystone_defconfig      |   2 +-
 arch/arm/configs/lpae.config             |   2 +
 arch/arm/configs/milbeaut_m10v_defconfig |  22 ++--
 arch/arm/configs/multi_v5_defconfig      |   2 +
 arch/arm/configs/multi_v7_defconfig      |  43 +++++--
 arch/arm/configs/mv78xx0_defconfig       |   2 +-
 arch/arm/configs/nhk8815_defconfig       |   2 +-
 arch/arm/configs/omap2plus_defconfig     |  14 +-
 arch/arm/configs/pxa_defconfig           |  26 ++--
 arch/arm/configs/qcom_defconfig          |   2 +-
 arch/arm/configs/sama5_defconfig         |   2 +-
 arch/arm/configs/shmobile_defconfig      |   1 +
 arch/arm/configs/spitz_defconfig         |  10 +-
 arch/arm/configs/wpcm450_defconfig       | 211 ++++++++++++++++++++++++=
+++++++
 arch/arm64/Makefile                      |   6 +
 arch/arm64/configs/defconfig             | 115 ++++++++++++-----
 arch/arm64/configs/virt.config           |  39 ++++++
 arch/powerpc/Makefile                    |  12 +-
 arch/riscv/configs/defconfig             |  22 +++-
 scripts/Makefile.defconf                 |  29 +++++
 scripts/kconfig/merge_config.sh          |  25 ++--
 29 files changed, 504 insertions(+), 118 deletions(-)
 create mode 100644 arch/arm/configs/lpae.config
 create mode 100644 arch/arm/configs/wpcm450_defconfig
 create mode 100644 arch/arm64/configs/virt.config
 create mode 100644 scripts/Makefile.defconf
