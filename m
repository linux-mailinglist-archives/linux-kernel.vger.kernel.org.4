Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 190495F638C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 11:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231429AbiJFJXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 05:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbiJFJXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 05:23:34 -0400
Received: from new4-smtp.messagingengine.com (new4-smtp.messagingengine.com [66.111.4.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C0C09836B
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 02:23:33 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id D5E325809F7;
        Thu,  6 Oct 2022 05:23:32 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Thu, 06 Oct 2022 05:23:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1665048212; x=
        1665051812; bh=bS9GSfsqnBckfu2+xToKJg32bk9j3WbzABpIvpJCp+w=; b=O
        RGhg/YfTU5JGe6FQl2PX1ZMu2LxZQ6JQzS5yjTV+txKhmoRuvbMA0Tj9d1HPg+CZ
        DW1+/K7YoES5fHQGr7gnI/JWnFmMWnQcDG/w6S0ctlRomwte4MnbFjLQiUEUGrzS
        qGTxxVYVS41dSBNyjLv2sz5FAwN234k2btUAOmIZSErHhrNSsGH0QEL9WVnMOkWI
        tEYUyOhXxJzaC/KZkthhAsHmSjAtHR8CyZJfIeBEwJ3uF3wtfQUorP01IItzXhim
        XnYxJWY/RCIK0XrDN28basINZkpE078NT3kC066VjF7591KT0kCwKSd4B0M1grLv
        2tsuVFx/DEefGISdubEJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1665048212; x=
        1665051812; bh=bS9GSfsqnBckfu2+xToKJg32bk9j3WbzABpIvpJCp+w=; b=D
        ghVb76i6/zuhC9CfYW2iI3MqNTceb0rRL4rrv2jK+p3TS7nJgz8GvihYVssDW7n0
        p1Zw9f9LIzrfnygUV029HMo0c0YHs5EQzG6R+TdD0vO40H0NIxrDGO9NXfoG9DoU
        NMLaFbnIqbHcPsd6zhwTxHcpX6D766q+uVqimxgVZqLGP0M9o9MYijaPgwve4gag
        WvMYqBdN1H3JODAxVjeKcNTKV4hViK3wpbJ24qWrKotLo0HiWFl1qFSrIhyM3cRB
        G89Ac3d2yshTJzC6bxLjjqJNmKcrX6DoOUxfa2WsxjJX8qqM3UxfkU4lOxCUtbcM
        YfHllmg76Fqwas6VfDfMg==
X-ME-Sender: <xms:lJ4-Yw16wmJAncd7FGSfPQMErRVSh-bknAJxTXmTpgL2eOORm0q7tQ>
    <xme:lJ4-Y7HBZ9htLtnIvDS71gGMQM48ZGEbBBBQjIRTd3BHbOdM-9lmieIcBDGt1mKhw
    ib9rfe-iVyA-wBJg_g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeeihedgudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpefgkefhheetvdethfejkeeigfehtdffieevfeefteffteejffehlefhtdeu
    veejueenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhgihhthhhusgdrtghomhenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnuges
    rghrnhgusgdruggv
X-ME-Proxy: <xmx:lJ4-Y47WvmDb_6wRjcqaOdF0Hto8sxNFq4WQ4G56lupzoWQyyEZNZA>
    <xmx:lJ4-Y51a0Nmtg_B2eKKKsW_nJSKXTEGsfE0skXK3VIKiq2WhRl2SuQ>
    <xmx:lJ4-YzFnH9qI9-b8jXFZ1gqwMIYbli2M8ZvuoImDpZo3nt6dnmmKgg>
    <xmx:lJ4-Y5M8KzNY5EW0xHx_4MskhlFmCmxDpruESrqlVTjuRrmzoX9urQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 7628DB60089; Thu,  6 Oct 2022 05:23:32 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1015-gaf7d526680-fm-20220929.001-gaf7d5266
Mime-Version: 1.0
Message-Id: <eb58dfb5-294a-4e78-922a-412e388ef813@app.fastmail.com>
In-Reply-To: <70d8e5d8-6fa4-496d-88d6-2604d0c3e982@app.fastmail.com>
References: <70d8e5d8-6fa4-496d-88d6-2604d0c3e982@app.fastmail.com>
Date:   Thu, 06 Oct 2022 11:23:09 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Linus Torvalds" <torvalds@linux-foundation.org>
Cc:     soc@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL 1/4] ARM: defconfig updates for 6.1
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
efconfig-6.1

for you to fetch changes up to 25631f1fec2a1e1aa93811fe7af2b29d49d79874:

  Merge tag 'v6.1-rockchip-defconfig64-1' of git://git.kernel.org/pub/sc=
m/linux/kernel/git/mmind/linux-rockchip into arm/defconfig (2022-09-28 2=
2:35:15 +0200)

----------------------------------------------------------------
ARM: defconfig updates for 6.1

As usual, we enable newly added device drivers in the various
defconfig files. This time, there is also a larger cleanup
series that just reorders symbols according to what 'make
savedefconfig' outputs and then tracks down the most common
removed or renamed symbols on top.

----------------------------------------------------------------
Adriana Kobylak (1):
      ARM: configs: aspeed: Add support for USB flash drives

Akhil R (1):
      arm64: defconfig: Make TEGRA186_GPC_DMA built-in

Anand Moon (1):
      arm64: defconfig: Enable Synopsys DWC MSHC driver

Arnaud Pouliquen (2):
      arm: configs: Configs that had RPMSG_CHAR now get RPMSG_CTRL
      arm64: defconfig: Config that had RPMSG_CHAR now gets RPMSG_CTRL

Arnd Bergmann (19):
      ARM: defconfig: reorder defconfig files
      ARM: defconfig: clean up multi_v4t and multi_v5 configs
      ARM: defconfig: drop CONFIG_NET_VENDOR_ASIX=3Dy
      ARM: defconfig: drop CONFIG_SERIAL_OMAP references
      ARM: defconfig: drop CONFIG_DRM_RCAR_LVDS
      ARM: defconfig: drop CONFIG_PTP_1588_CLOCK=3Dy
      ARM: defconfig: drop CONFIG_SND_SOC_FSL_SAI
      ARM: defconfig: drop CONFIG_USB_FSL_USB2
      ARM: defconfig: drop CONFIG_MICROCHIP_PIT64B
      ARM: defconfig: fix CONFIG_SND_SOC_AC97_CODEC name
      Merge branch 'arm/defconfig-cleanup' into arm/defconfig
      Merge tag 'renesas-arm-defconfig-for-v6.1-tag1' of git://git.kerne=
l.org/pub/scm/linux/kernel/git/geert/renesas-devel into arm/defconfig
      Merge tag 'arm-soc/for-6.1/defconfig-arm64' of https://github.com/=
Broadcom/stblinux into arm/defconfig
      Merge tag 'tegra-for-6.1-arm64-defconfig' of git://git.kernel.org/=
pub/scm/linux/kernel/git/tegra/linux into arm/defconfig
      Merge tag 'sunxi-config-for-6.1-1' of https://git.kernel.org/pub/s=
cm/linux/kernel/git/sunxi/linux into arm/defconfig
      Merge tag 'qcom-arm64-defconfig-for-6.1' of https://git.kernel.org=
/pub/scm/linux/kernel/git/qcom/linux into arm/defconfig
      Merge tag 'qcom-defconfig-for-6.1' of https://git.kernel.org/pub/s=
cm/linux/kernel/git/qcom/linux into arm/defconfig
      Merge tag 'aspeed-6.1-defconfig' of git://git.kernel.org/pub/scm/l=
inux/kernel/git/joel/bmc into arm/defconfig
      Merge tag 'v6.1-rockchip-defconfig64-1' of git://git.kernel.org/pu=
b/scm/linux/kernel/git/mmind/linux-rockchip into arm/defconfig

Bhadram Varka (1):
      arm64: defconfig: Enable Tegra MGBE driver

Cl=C3=A9ment P=C3=A9ron (1):
      arm64: defconfig: Enable devfreq cooling device

Florian Fainelli (1):
      arm64: defconfig: enable ARCH_BCM

Geert Uytterhoeven (2):
      ARM: shmobile: defconfig: Refresh for v6.0-rc1
      arm64: defconfig: Enable additional support for Renesas platforms

Joel Stanley (10):
      ARM: configs: aspeed_g5: Add mp5023 driver
      ARM: configs: aspeed_g5: Add TPM TIS I2C driver
      ARM: configs: aspeed_g5: Add PL2303 USB serial driver
      ARM: configs: aspeed_g5: Enable MCTP stack
      ARM: configs: aspeed_g4: Enable OCC and NBD drivers
      ARM: configs: aspeed_g4: Enable IPV6 options
      ARM: config: aspeed: Enable namespaces
      ARM: configs: aspeed: Refresh defconfigs
      ARM: configs: aspeed_g4: Remove appended DTB and ATAG
      ARM: config: aspeed_g5: Enable PECI

Krishna Yarlagadda (1):
      arm64: tegra: Enable Tegra SPI & QSPI in deconfig

Krzysztof Kozlowski (5):
      arm64: defconfig: enable more Qualcomm drivers
      ARM: qcom_defconfig: enable more Qualcomm drivers
      ARM: multi_v7_defconfig: enable more Qualcomm drivers
      ARM: qcom: include defconfig in MAINTAINERS
      arm64: defconfig: enable newer Qualcomm SoC sound drivers

Linus Walleij (1):
      ARM: config: ixp4xx: Disable legacy EEPROM driver

Mark Brown (1):
      arm64: configs: Enable all PMUs provided by Arm

Michael Walle (1):
      arm64: defconfig: enable ARCH_NXP

Stefan Hansson (1):
      ARM: configs: replace CONFIG_NO_HZ=3Dy with CONFIG_NO_HZ_IDLE=3Dy

Sudeep Holla (1):
      arm64: defconfig: Drop ARM_CPUIDLE(generic idle driver) config

Vinod Koul (1):
      arm64: defconfig: Enabled SC8180x configs

William Zhang (1):
      arm64: defconfig: remove BCM4908

 MAINTAINERS                              |  1 +
 arch/arm/configs/aspeed_g4_defconfig     | 10 +++++++---
 arch/arm/configs/aspeed_g5_defconfig     | 20 +++++++++++++++++++-
 arch/arm/configs/at91_dt_defconfig       |  2 +-
 arch/arm/configs/bcm2835_defconfig       |  2 +-
 arch/arm/configs/cm_x300_defconfig       |  2 +-
 arch/arm/configs/davinci_all_defconfig   |  2 +-
 arch/arm/configs/dove_defconfig          |  4 ++--
 arch/arm/configs/exynos_defconfig        |  4 ++--
 arch/arm/configs/ezx_defconfig           |  2 +-
 arch/arm/configs/hisi_defconfig          |  2 +-
 arch/arm/configs/imx_v4_v5_defconfig     |  2 +-
 arch/arm/configs/imx_v6_v7_defconfig     |  4 ++--
 arch/arm/configs/integrator_defconfig    |  2 +-
 arch/arm/configs/ixp4xx_defconfig        |  2 +-
 arch/arm/configs/keystone_defconfig      |  7 +++----
 arch/arm/configs/lpc18xx_defconfig       |  2 +-
 arch/arm/configs/lpc32xx_defconfig       |  2 +-
 arch/arm/configs/magician_defconfig      |  2 +-
 arch/arm/configs/milbeaut_m10v_defconfig |  2 +-
 arch/arm/configs/mmp2_defconfig          |  2 +-
 arch/arm/configs/moxart_defconfig        |  2 +-
 arch/arm/configs/mps2_defconfig          |  2 +-
 arch/arm/configs/multi_v4t_defconfig     |  2 --
 arch/arm/configs/multi_v5_defconfig      |  5 ++---
 arch/arm/configs/multi_v7_defconfig      | 28 ++++++++++++-------------=
---
 arch/arm/configs/mv78xx0_defconfig       |  2 +-
 arch/arm/configs/mvebu_v5_defconfig      |  4 ++--
 arch/arm/configs/mxs_defconfig           |  6 +++---
 arch/arm/configs/omap1_defconfig         |  4 ++--
 arch/arm/configs/omap2plus_defconfig     |  9 +++------
 arch/arm/configs/orion5x_defconfig       |  4 ++--
 arch/arm/configs/oxnas_v6_defconfig      |  2 +-
 arch/arm/configs/pcm027_defconfig        |  2 +-
 arch/arm/configs/pxa168_defconfig        |  4 ++--
 arch/arm/configs/pxa910_defconfig        |  4 ++--
 arch/arm/configs/pxa_defconfig           |  4 ++--
 arch/arm/configs/qcom_defconfig          |  7 ++++++-
 arch/arm/configs/s3c6400_defconfig       |  2 +-
 arch/arm/configs/s5pv210_defconfig       |  4 ++--
 arch/arm/configs/sama5_defconfig         |  6 +++---
 arch/arm/configs/sama7_defconfig         |  4 ++--
 arch/arm/configs/shmobile_defconfig      | 10 ++++++++--
 arch/arm/configs/socfpga_defconfig       |  6 +++---
 arch/arm/configs/sp7021_defconfig        |  2 +-
 arch/arm/configs/spear13xx_defconfig     |  2 +-
 arch/arm/configs/spear3xx_defconfig      |  2 +-
 arch/arm/configs/spear6xx_defconfig      |  2 +-
 arch/arm/configs/stm32_defconfig         |  2 +-
 arch/arm/configs/sunxi_defconfig         |  4 ++--
 arch/arm/configs/tegra_defconfig         |  4 ++--
 arch/arm/configs/vexpress_defconfig      |  2 +-
 arch/arm/configs/vt8500_v6_v7_defconfig  |  2 +-
 arch/arm/configs/xcep_defconfig          |  2 +-
 arch/arm64/configs/defconfig             | 30 +++++++++++++++++++++++++=
++---
 55 files changed, 151 insertions(+), 104 deletions(-)
