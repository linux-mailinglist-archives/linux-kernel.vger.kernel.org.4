Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE02637CD8
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 16:22:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbiKXPWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 10:22:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbiKXPWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 10:22:10 -0500
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6275150D71
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 07:22:09 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 3CA5B32009C5;
        Thu, 24 Nov 2022 10:22:06 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Thu, 24 Nov 2022 10:22:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1669303325; x=1669389725; bh=tj7E/5iQGxxXpvFEgoh1bYiQCmbIbkJiYJB
        ntXn1jDA=; b=lomoKuD6b138fDZ+1BT8Y/wJUM2lmHvRnKR9ZMjmDUrM4OvZdFq
        ZVWrAEMjixTEqy//UgnANNfXYKVQPMOWo1rnoC59nBMOo2CjdYiMx/YSql/J+S6n
        1D13+VGBcL2JSUthFEQDbU1c/ojpmYra9A6hvNtGtfbV5EmETKEyPPDsYInCAU+Q
        px9DBvdej1GmYvREGTsOArq8laAv4m8zLQTu/HA8FXLDH6AXJKf4mvdrpNOTYCPN
        G+rZhz/9aOBDE9QdUxeFRaeCuBou0j0Ew8gYtgIFrPSOYFc80uJsLyH2+WgK8rpV
        lI0dyi0cdGbbX+zcf8Aj/PKVqjJJbSvSmbw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:message-id:mime-version
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1669303325; x=
        1669389725; bh=tj7E/5iQGxxXpvFEgoh1bYiQCmbIbkJiYJBntXn1jDA=; b=C
        zOYzIcfNDGlkcjOMvePtTJ5R/EDxWtrh2o7VHozMEV+ajfLJydCdTtMXU+6s+j45
        d4s9xSKGgd7Y3+ery27l40WJu4Rdn2+QmHPmuz8Emu8eoj0NfzBAdUosyAiyT+8D
        toTK2nFKwL7/ZY4wTTcUQ/LVcpf97axw1SZ7hXI+wR1Iw8M6fbVr5wyRvgCiLt5R
        DhOkdoX6n+gqxizX3ftvrc5TwZOWr6Emhak3/hzrRYj6DHcscJZRasH68Ejc2EiZ
        0HBmYCsQ3hU1TYWThsUD2nzHLiGGm3eE2CWXsyHUp246o0jot1kwJ9cOX2Q7Xg5i
        KkN1K56U3XIhKXy6WDFTw==
X-ME-Sender: <xms:HYx_Ywl8TV0Z1MSnp9FnRaMxc4PxBu_iGkUFX3KnktUYY3S3BBdM6w>
    <xme:HYx_Y_0BsMVB_UX89VwqQWarzwAg6dLeaSIq6mj9-iOXEUCYVTr8TDCjBlCrN9uhc
    cn67-DIySXUierAkgk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrieefgdejiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpedtlefhkedvvdethfeuteekheettddvveeltdffhfejudffheelieelheevjeejkeen
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhlihhnrghrohdrohhrghenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgu
    sgdruggv
X-ME-Proxy: <xmx:HYx_Y-p-VoBECX6KWJa30cVlgw3tlL0ILVh-rs5ktNsVy6uw49SWvQ>
    <xmx:HYx_Y8mxdYtwV62OkXZVo1tnyhuqhd1_83H9qksaIxYAcFVt8Gz5DQ>
    <xmx:HYx_Y-0MZ46ndEK5HgXRVoF5psSM7muE0_EbVvDICdjZG8coC6CGCQ>
    <xmx:HYx_Y8DqWyqg4q1GfYGmQSnM3mzNgD1G0eS5mBoRS0cAvD8TwEzFdQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 78A3FB60086; Thu, 24 Nov 2022 10:22:05 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1115-g8b801eadce-fm-20221102.001-g8b801ead
Mime-Version: 1.0
Message-Id: <27634f1b-1092-4d83-b0f1-af19e41c7027@app.fastmail.com>
Date:   Thu, 24 Nov 2022 16:21:43 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Linus Torvalds" <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        soc@kernel.org, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Subject: [GIT PULL] ARM: SoC fixes for 6.1, part 4
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit eb7081409f94a9a8608593d0fb63a1aa3d6f95d8:

  Linux 6.1-rc6 (2022-11-20 16:02:16 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-fixes-6.1-4

for you to fetch changes up to b10dbd6fbd7d097afa1ffa5f94a74b355a4e4743:

  Merge tag 'v6.2-rockchip-dts32-1' of git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip into arm/fixes (2022-11-24 15:36:13 +0100)

----------------------------------------------------------------
ARM: SoC fixes for 6.1, part 4

There are a bunch of late fixes that just came in, in particular
a longer series for Rockchips devicetree files, but most of those
just address cosmetic errors that were found during the binding
validation.

There are a couple of code changes:

 - A regression fix to the IXP42x PCI bus

 - A fix for a memory leak on optee, and another one for mach-mxs

 - Two fixes for the sunxi rsb bus driver, to address
   problems with the shutdown logic

The rest are small but important devicetree fixes for a number of
individual boards, addressing issues across all platforms:

 - arm global timer on older rockchip SoCs is unstable and
   needs to be disabled in favor of a more reliable clocksource

 - Corrections to fix bluetooth, mmc, and networking on
   a few Rockchip boards

 - at91/sam9g20ek UDC needs a pin controller config change

 - an omap board runs into mmc probe errors because of regulator
   nodes in the wrong place

 - imx8mp-evk has a minor inaccuracy with its pin config,
   but without user visible impact

 - The Allwinner H6 Hantro G2 video decoder needs an IOMMU
   reference to prevent the driver from crashing

----------------------------------------------------------------
Arnd Bergmann (7):
      Merge tag 'optee-fix-for-6.1' of https://git.linaro.org/people/jens.wiklander/linux-tee into arm/fixes
      Merge tag 'at91-fixes-6.1-2' of https://git.kernel.org/pub/scm/linux/kernel/git/at91/linux into arm/fixes
      Merge tag 'sunxi-fixes-for-6.1-1' of https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux into arm/fixes
      Merge tag 'imx-fixes-6.1-3' of git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux into arm/fixes
      Merge tag 'am335x-pcm-953-regulators' of git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap into arm/fixes
      Merge tag 'v6.1-rockchip-dtsfixes1' of git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip into arm/fixes
      Merge tag 'v6.2-rockchip-dts32-1' of git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip into arm/fixes

Brian Norris (1):
      arm64: dts: rockchip: Drop RK3399-Scarlet's repeated ec_ap_int_l definition

Chen-Yu Tsai (3):
      arm64: dts: rockchip: Fix Pine64 Quartz4-B PMIC interrupt
      media: dt-bindings: allwinner: h6-vpu-g2: Add IOMMU reference property
      arm64: dts: allwinner: h6: Add IOMMU reference to Hantro G2

Dominik Haller (1):
      ARM: dts: am335x-pcm-953: Define fixed regulators in root node

FUKAUMI Naoki (1):
      arm64: dts: rockchip: keep I2S1 disabled for GPIO function on ROCK Pi 4 series

Fabio Estevam (1):
      ARM: dts: imx6q-prti6q: Fix ref/tcxo-clock-frequency properties

Furkan Kardame (3):
      arm64: dts: rockchip: Fix gmac failure of rgmii-id from rk3566-roc-pc
      arm64: dts: rockchip: Fix i2c3 pinctrl on rk3566-roc-pc
      arm64: dts: rockchip: remove i2c5 from rk3566-roc-pc

Jakob Unterwurzacher (1):
      arm64: dts: rockchip: lower rk3399-puma-haikou SD controller clock frequency

Jensen Huang (1):
      arm64: dts: rockchip: add enable-strobe-pulldown to emmc phy on nanopi4

Johan Jonker (6):
      ARM: dts: rockchip: fix adc-keys sub node names
      arm64: dts: rockchip: fix adc-keys sub node names
      ARM: dts: rockchip: fix ir-receiver node names
      arm64: dts: rockchip: fix ir-receiver node names
      ARM: dts: rockchip: rk3188: fix lcdc1-rgb24 node name
      ARM: dts: rockchip: disable arm_global_timer on rk3066 and rk3188

Lev Popov (1):
      arm64: dts: rockchip: fix quartz64-a bluetooth configuration

Linus Walleij (1):
      bus: ixp4xx: Don't touch bit 7 on IXP42x

Michael Grzeschik (1):
      ARM: dts: at91: sam9g20ek: enable udc vbus gpio pinctrl

Peng Fan (1):
      arm64: dts: imx8mp-evk: correct pcie pad settings

Samuel Holland (2):
      bus: sunxi-rsb: Remove the shutdown callback
      bus: sunxi-rsb: Support atomic transfers

Sebastian Reichel (4):
      arm64: dts: rockchip: fix node name for hym8563 rtc
      arm64: dts: rockchip: remove clock-frequency from rtc
      arm: dts: rockchip: fix node name for hym8563 rtc
      arm: dts: rockchip: remove clock-frequency from rtc

Yang Yingliang (1):
      tee: optee: fix possible memory leak in optee_register_device()

Zheng Yongjun (1):
      ARM: mxs: fix memory leak in mxs_machine_init()

 .../bindings/media/allwinner,sun50i-h6-vpu-g2.yaml |  5 +++
 arch/arm/boot/dts/am335x-pcm-953.dtsi              | 28 ++++++++--------
 arch/arm/boot/dts/at91sam9g20ek_common.dtsi        |  9 +++++
 arch/arm/boot/dts/imx6q-prti6q.dts                 |  4 +--
 arch/arm/boot/dts/rk3036-evb.dts                   |  3 +-
 arch/arm/boot/dts/rk3066a-mk808.dts                |  2 +-
 arch/arm/boot/dts/rk3188-radxarock.dts             |  2 +-
 arch/arm/boot/dts/rk3188.dtsi                      |  3 +-
 arch/arm/boot/dts/rk3288-evb-act8846.dts           |  2 +-
 arch/arm/boot/dts/rk3288-evb.dtsi                  |  6 ++--
 arch/arm/boot/dts/rk3288-firefly.dtsi              |  3 +-
 arch/arm/boot/dts/rk3288-miqi.dts                  |  3 +-
 arch/arm/boot/dts/rk3288-rock2-square.dts          |  3 +-
 arch/arm/boot/dts/rk3288-vmarc-som.dtsi            |  1 -
 arch/arm/boot/dts/rk3xxx.dtsi                      |  7 ++++
 arch/arm/mach-mxs/mach-mxs.c                       |  4 ++-
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi       |  1 +
 arch/arm64/boot/dts/freescale/imx8mp-evk.dts       |  6 ++--
 arch/arm64/boot/dts/rockchip/px30-evb.dts          | 10 +++---
 arch/arm64/boot/dts/rockchip/rk3308-evb.dts        | 12 +++----
 arch/arm64/boot/dts/rockchip/rk3308-roc-cc.dts     |  2 +-
 arch/arm64/boot/dts/rockchip/rk3318-a95x-z2.dts    |  2 +-
 .../boot/dts/rockchip/rk3368-orion-r68-meta.dts    |  3 +-
 arch/arm64/boot/dts/rockchip/rk3368-r88.dts        |  3 +-
 .../boot/dts/rockchip/rk3399-gru-scarlet.dtsi      |  4 ---
 .../boot/dts/rockchip/rk3399-khadas-edge.dtsi      |  2 +-
 arch/arm64/boot/dts/rockchip/rk3399-nanopc-t4.dts  |  2 +-
 arch/arm64/boot/dts/rockchip/rk3399-nanopi-m4b.dts |  2 +-
 arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi   |  1 +
 arch/arm64/boot/dts/rockchip/rk3399-orangepi.dts   |  4 +--
 .../arm64/boot/dts/rockchip/rk3399-puma-haikou.dts |  2 +-
 .../arm64/boot/dts/rockchip/rk3399-roc-pc-plus.dts |  3 +-
 arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi    |  2 +-
 arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi |  1 -
 .../dts/rockchip/rk3399-sapphire-excavator.dts     |  4 +--
 .../boot/dts/rockchip/rk3399pro-vmarc-som.dtsi     |  3 +-
 arch/arm64/boot/dts/rockchip/rk3566-pinenote.dtsi  |  2 +-
 arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts |  7 ++--
 arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts |  2 +-
 arch/arm64/boot/dts/rockchip/rk3566-roc-pc.dts     |  8 ++---
 arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts |  1 -
 arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts    |  1 -
 drivers/bus/intel-ixp4xx-eb.c                      |  9 ++---
 drivers/bus/sunxi-rsb.c                            | 38 ++++++++++++----------
 drivers/tee/optee/device.c                         |  2 +-
 45 files changed, 114 insertions(+), 110 deletions(-)
