Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B91685E672C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 17:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbiIVPdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 11:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiIVPdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 11:33:00 -0400
Received: from new4-smtp.messagingengine.com (new4-smtp.messagingengine.com [66.111.4.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 091FCFB301
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 08:32:55 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 7882D581EF9;
        Thu, 22 Sep 2022 11:32:53 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Thu, 22 Sep 2022 11:32:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1663860773; x=1663864373; bh=Cmt12H2YmSIkFH8d9QnRlpJrD+dJA1moRzc
        Mndtwpfs=; b=P3VP6fD/VBZCeNWgoA7vPsqLHtBut4W8aWLNAOE3/waecw4VGk9
        7BCii39wtshzMrGAmyEyjxO82KATpqyPQXIXGjet/RSt7v6R4V6IABXQRMlEX5YE
        yThVyoBjhJeBHqNrdw9DUTQRzS/0O0HPd8THraP93UEMR25tYeRB4FzRbN10Mzjs
        yspYOtfyWETpsVBE5usTEZElenzsSQPvfa0fB5Z6MYgI8QT5FleI4YPmnzVCJ/eU
        YYpG114JQTfeog0tooRPsBJj+OZXWSd+ESH0wznmDp4mcrs//gAAA4JC404l1x9O
        9SMvjiTUZowOsjMY/rqXED2d5UWbWKt8sJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:message-id:mime-version
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1663860773; x=
        1663864373; bh=Cmt12H2YmSIkFH8d9QnRlpJrD+dJA1moRzcMndtwpfs=; b=T
        vVSscOpvWjISbD+U+8J4sDOzwLbnqp1Xl43wDVa3nOromfrtzrTgxHvFqUDEvggU
        189t5luQERa/pQ2ZO+C5ANXebkH4bclFXbo8C34W0FSFanvjeDhrwYdlBuWszjoN
        KKtk2gvLv3lhGvACNQ8e9h9NwB1wqf3JxJJ1qrh5frskFETNn36Le7A1I/GQzdNV
        vyULcnj9f7+XVj8MbbScQTIMQF9WYGV+VdxF6rHm/7DtNDw0LqF2UlH9rbgsQWHi
        fWF+DfaBoHO9jMZHTLtmUYyJp0bej95tNE6rr4zCNF7PQ91Vsju4rTYyypAwrQLy
        m6v2vBKJkiUqLSx2tYayw==
X-ME-Sender: <xms:JIAsYxgc6Ob5iZ7Puh4IDZ5vpYmacrHdnz3IzyCwwc6FSF2Ug-EIoA>
    <xme:JIAsY2CiJ9iinWoByB3ZhhgAVR2agi0oguBo6Avm6NsUJFuLsYYV_j-nciWaRc3S5
    Ya3yN6U-3adzPmjswM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeefgedgfedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkfffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhepfeefuefhkeejvedtvddtleeltddttdejgedvhfdtuddvhfeukeduiefhjeetgfei
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:JIAsYxG7ooxLyqUGI6cEXIfNkZxuSTGoAqsl-1Wj1ElSgpHr7mJNjQ>
    <xmx:JIAsY2RY6otczEc0zkuaapdJk49Z9GNfciRDrAI3z_fbgrcd77LzjA>
    <xmx:JIAsY-w-pY6tuCYfFcvklBb41cu0QgX3h2KiqGKaQHjtXCuhL2qKhw>
    <xmx:JYAsYzqM5pN4zeI3tgDwviMWrQ_ExjPrs1sAM5mjBKYPEL0ePp_zqw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id DFE92B60086; Thu, 22 Sep 2022 11:32:52 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-935-ge4ccd4c47b-fm-20220914.001-ge4ccd4c4
Mime-Version: 1.0
Message-Id: <acdecda4-b11a-4e15-9ac9-6d2696218012@www.fastmail.com>
Date:   Thu, 22 Sep 2022 17:32:32 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Linus Torvalds" <torvalds@linux-foundation.org>
Cc:     soc@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] ARM: SoC fixes for 6.0-rc6
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 12f09234bde51810b3f7412b2b5c84af4c07cfb1:

  Merge tag 'renesas-fixes-for-v6.0-tag1' of git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-devel into arm/fixes (2022-09-02 12:05:28 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-fixes-6.0-rc6

for you to fetch changes up to aaa58141a5d7647b14d812dde92b8d680e0985db:

  Merge tag 'at91-fixes-6.0-2' of https://git.kernel.org/pub/scm/linux/kernel/git/at91/linux into arm/fixes (2022-09-15 21:54:07 +0200)

----------------------------------------------------------------
ARM: SoC fixes for 6.0-rc6

Another set of fixes for fixes for the soc tree:

 - A fix for the interrupt number on at91/lan966 ethernet PHYs

 - A second round of fixes for NXP i.MX series, including a couple
   of build issues, and board specific DT corrections on
   TQMa8MPQL, imx8mp-venice-gw74xx and imx8mm-verdin for reliability
   and partially broken functionality.

 - Several fixes for Rockchip SoCs, addressing a USB issue on BPI-R2-Pro,
   wakeup on Gru-Bob and reliability of high-speed SD cards, among
   other minor issues.

 - A fix for a long-running naming mistake that prevented the moxart mmc
   driver from working at all.

 - Multiple Arm SCMI firmware fixes for hardening some corner cases.

----------------------------------------------------------------
Alexander Stein (2):
      arm64: dts: tqma8mpxl-ba8mpxl: Fix button GPIOs
      arm64: dts: imx8mp-tqma8mpql-mba8mpxl: add missing pinctrl for RTC alarm

Arnd Bergmann (4):
      Merge tag 'scmi-fixes-6.0' of git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux into arm/fixes
      Merge tag 'v6.0-rockchip-dtsfixes1' of git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip into arm/fixes
      Merge tag 'imx-fixes-6.0-2' of git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux into arm/fixes
      Merge tag 'at91-fixes-6.0-2' of https://git.kernel.org/pub/scm/linux/kernel/git/at91/linux into arm/fixes

Brian Norris (1):
      arm64: dts: rockchip: Pull up wlan wake# on Gru-Bob

Cristian Marussi (7):
      firmware: arm_scmi: Fix missing kernel-doc in optee
      firmware: arm_scmi: Improve checks in the info_get operations
      firmware: arm_scmi: Harden accesses to the sensor domains
      firmware: arm_scmi: Harden accesses to the reset domains
      firmware: arm_scmi: Fix the asynchronous reset requests
      firmware: arm_scmi: Add SCMI PM driver remove routine
      firmware: arm_scmi: Harmonize SCMI tracing message format

Fabio Estevam (3):
      arm64: dts: rockchip: Remove 'enable-active-low' from rk3399-puma
      arm64: dts: rockchip: Remove 'enable-active-low' from rk3566-quartz64-a
      arm64: dts: tqma8mqml: Include phy-imx8-pcie.h header

Frank Wunderlich (1):
      arm64: dts: rockchip: fix upper usb port on BPI-R2-Pro

Horatiu Vultur (1):
      ARM: dts: lan966x: Fix the interrupt number for internal PHYs

Jagan Teki (1):
      arm64: dts: rockchip: Fix typo in lisense text for PX30.Core

Krzysztof Kozlowski (1):
      dt-bindings: memory-controllers: fsl,imx8m-ddrc: drop Leonard Crestez

Marco Felsch (1):
      arm64: dts: imx8mn: remove GPU power domain reset

Marek Vasut (1):
      arm64: dts: imx8mm: Reverse CPLD_Dn GPIO label mapping on MX8Menlo

Michael Riesch (2):
      arm64: dts: rockchip: fix property for usb2 phy supply on rock-3a
      arm64: dts: rockchip: fix property for usb2 phy supply on rk3568-evb1-v10

Michael Walle (1):
      arm64: defconfig: enable ARCH_NXP

Nicolas Frattaroli (1):
      arm64: dts: rockchip: Lower sd speed on quartz64-b

Peng Fan (1):
      arm64: dts: imx8ulp: add #reset-cells for pcc

Philippe Schenker (1):
      arm64: dts: imx8mm-verdin: extend pmic voltages

Sergei Antonov (1):
      ARM: dts: fix Moxa SDIO 'compatible', remove 'sdhci' misnomer

Tim Harvey (3):
      arm64: dts: imx8mp-venice-gw74xx: fix CAN STBY polarity
      arm64: dts: imx8mp-venice-gw74xx: fix ksz9477 cpu port
      arm64: dts: imx8mp-venice-gw74xx: fix port/phy validation

zain wang (1):
      arm64: dts: rockchip: Set RK3399-Gru PCLK_EDP to 24 MHz

 .../devicetree/bindings/dma/moxa,moxart-dma.txt    |  4 +--
 .../memory-controllers/fsl/imx8m-ddrc.yaml         |  2 +-
 arch/arm/boot/dts/lan966x.dtsi                     |  4 +--
 arch/arm/boot/dts/moxart-uc7112lx.dts              |  2 +-
 arch/arm/boot/dts/moxart.dtsi                      |  4 +--
 arch/arm64/boot/dts/freescale/imx8mm-mx8menlo.dts  | 10 ++++----
 .../boot/dts/freescale/imx8mm-tqma8mqml-mba8mx.dts |  1 -
 .../arm64/boot/dts/freescale/imx8mm-tqma8mqml.dtsi |  1 +
 arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi   | 10 ++++----
 arch/arm64/boot/dts/freescale/imx8mn.dtsi          |  1 -
 .../dts/freescale/imx8mp-tqma8mpql-mba8mpxl.dts    | 10 ++++++--
 .../boot/dts/freescale/imx8mp-venice-gw74xx.dts    | 12 ++++++---
 arch/arm64/boot/dts/freescale/imx8ulp.dtsi         |  3 +++
 .../boot/dts/rockchip/px30-engicam-px30-core.dtsi  |  4 +--
 arch/arm64/boot/dts/rockchip/rk3399-gru-bob.dts    |  5 ++++
 .../boot/dts/rockchip/rk3399-gru-chromebook.dtsi   |  9 +++++++
 arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi      |  1 -
 arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts |  1 -
 arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts |  2 +-
 arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts |  2 +-
 arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts   |  2 +-
 arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts    |  2 +-
 arch/arm64/configs/defconfig                       |  1 +
 drivers/firmware/arm_scmi/clock.c                  |  6 ++++-
 drivers/firmware/arm_scmi/optee.c                  |  1 +
 drivers/firmware/arm_scmi/reset.c                  | 10 +++++---
 drivers/firmware/arm_scmi/scmi_pm_domain.c         | 20 +++++++++++++++
 drivers/firmware/arm_scmi/sensors.c                | 25 +++++++++++++++---
 include/linux/scmi_protocol.h                      |  4 +--
 include/trace/events/scmi.h                        | 30 +++++++++++-----------
 30 files changed, 130 insertions(+), 59 deletions(-)
