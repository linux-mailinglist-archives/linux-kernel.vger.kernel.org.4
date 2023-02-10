Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 209C769233B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 17:26:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232793AbjBJQ0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 11:26:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232047AbjBJQ0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 11:26:11 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7673F6A7D
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 08:26:06 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 2DC8C5C0238;
        Fri, 10 Feb 2023 11:26:03 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Fri, 10 Feb 2023 11:26:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1676046363; x=1676132763; bh=t01H0ZxMiLNGoPZFy2PSmF/8v+B8Ck0mxHf
        dS0i6frE=; b=GdHejhB2I82AGMNvYSArVx66SkXqfu4lqXDZIAgNzOy4d+SSFzj
        aMMBjInGWeMlQvD3mSbqJKKWH86q837fJ7/vWL0AyQPKFiLE42Kv+thrZoFzmmnn
        caUjD/5eT/FnZU7m2Bu8sdQXCNhXUCc7WAs9kfLeiRdzuT+s9pbBD0UPOAuzj0g5
        4GmA5Z2WzXVRtJC1ll1YTI6vvgK1JepgPMm0I4SpDhnIIVl2UMiTEv97yKeoQ8b8
        ntru4BFkRl+8ZKgEBC04fpDIhrHZjQq2a3XqVgIUfIowM+NSZNL9+VgqELExic21
        n8V7tKh73Ek/MpUETflsatnxS57F3RqVOIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:message-id:mime-version
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1676046363; x=
        1676132763; bh=t01H0ZxMiLNGoPZFy2PSmF/8v+B8Ck0mxHfdS0i6frE=; b=B
        0geuZAoeItSagcqnBrbl9aKRfIPlSM+6CvcvOOCBeKp/chYljF0ZgzMITlrCVeD0
        Uhbpuc308tcPSPyfIeICeHOqMHrtZX9FMeNpcRdvQoDESHX/02nDR17bBg5hgjgE
        DZ4eurn+kB6SB6S+G9ttKbH1m4uiWbFkyC14iJlQ34KCvX6Fxxn/bwmI50vhS5x9
        xcZw50ZO7TIG3y9L8qB9Fu37nAXVKz7gsIuM2LpjzL09Mi45JjoOL4iYkMM6tBy0
        vZBdt77hJ6bnY6ZJjWgByYM75C81y9V33kbfGXhcM0DGEIaa6OLikQGS1njZXfJ0
        RrxRYGbCdEaBc600f/StQ==
X-ME-Sender: <xms:GnDmY0Z6SVqQ0Ti1L2Y4pkWyA1eGMiR0VWyIpcn2Y2irm3ihZgcNSA>
    <xme:GnDmY_YPoinw9y0K_AuVTHkVKnhXxeApvz2-xhNl4PYY5UMBqCUl4B65MzOl2pcii
    kvNVabMR2qRTEv8b8k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudehhedgkeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkfffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhepfeefuefhkeejvedtvddtleeltddttdejgedvhfdtuddvhfeukeduiefhjeetgfei
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:GnDmY-8ngFbyg6B_34m8u6X5OLrJCY8J9Xq_dIERKdwzA6TnrI3gzA>
    <xmx:GnDmY-omqU_tHpV3lXT_KaahQRa9HTyg8DGkAF1sFJnL1paDO_CHKg>
    <xmx:GnDmY_qR9-uQhq7TRmTFAJcAw8M9XCpLAlBQ1CfE2sBzLkmxSlu-4Q>
    <xmx:G3DmY4BlImXSziEyNZulBOrsucJTZSXZUEvuzl1O-8HimW7vjp4-RA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id D7A24B60086; Fri, 10 Feb 2023 11:26:02 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-156-g081acc5ed5-fm-20230206.001-g081acc5e
Mime-Version: 1.0
Message-Id: <d3a3546d-cf8b-407b-bf8d-d8666e2b9c98@app.fastmail.com>
Date:   Fri, 10 Feb 2023 17:25:44 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Linus Torvalds" <torvalds@linux-foundation.org>
Cc:     soc@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL] ARM: SoC fixes for 6.2, part 4
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 6d796c50f84ca79f1722bb131799e5a5710c4700:

  Linux 6.2-rc6 (2023-01-29 13:59:43 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-fixes-6.2-4

for you to fetch changes up to bc6772bbab9af6034f918624a40ac5c962df2bac:

  Merge tag 'amlogic-fixes-v6.2-rc-take2' of https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux into arm/fixes (2023-02-10 11:31:25 +0100)

----------------------------------------------------------------
ARM: SoC fixes for 6.2, part 4

All the changes this time are minor devicetree corrections, the majority
being for 64-bit Rockchip SoC support. These are a couple of corrections
for properties that are in violation of the binding, some that put the
machine into safer operating points for the eMMC and thermal settings,
and missing properties that prevented rk356x PCIe and ethernet from
working correctly.

The changes for amlogic and mediatek address incorrect properties that
were preventing the display support on MT8195 and the MMC support
on various Meson SoCs from working correctly.

The stihxxx-b2120 change fixes the GPIO polarity for the DVB tuner
to allow this to be used correctly after a futre driver change,
though it has no effect on older kernels.

----------------------------------------------------------------
Andy Yan (1):
      arm64: dts: rockchip: add io domain setting to rk3566-box-demo

Arnaud Ferraris (1):
      arm64: dts: rockchip: fix input enable pinconf on rk3399

Arnd Bergmann (3):
      Merge tag 'v6.2-rockchip-dtsfixes1' of git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip into arm/fixes
      Merge tag 'sti-dt-for-6.3-round1' of git://git.kernel.org/pub/scm/linux/kernel/git/pchotard/sti into arm/fixes
      Merge tag 'amlogic-fixes-v6.2-rc-take2' of https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux into arm/fixes

Chen-Yu Tsai (1):
      arm64: dts: mediatek: mt8195: Fix vdosys* compatible strings

Chukun Pan (1):
      arm64: dts: rockchip: remove unsupported property from sdmmc2 for rock-3a

Corentin Labbe (1):
      arm64: dts: rockchip: use correct reset names for rk3399 crypto nodes

Dan Johansen (1):
      arm64: dts: rockchip: set sdmmc0 speed to sd-uhs-sdr50 on rock-3a

Dmitry Torokhov (1):
      ARM: dts: stihxxx-b2120: fix polarity of reset line of tsin0 port

Heiner Kallweit (3):
      arm64: dts: meson-axg: Make mmc host controller interrupts level-sensitive
      arm64: dts: meson-g12-common: Make mmc host controller interrupts level-sensitive
      arm64: dts: meson-gx: Make mmc host controller interrupts level-sensitive

Jarrah Gosbell (1):
      arm64: dts: rockchip: reduce thermal limits on rk3399-pinephone-pro

Jensen Huang (1):
      arm64: dts: rockchip: add missing #interrupt-cells to rk356x pcie2x1

Johan Jonker (1):
      ARM: dts: rockchip: add power-domains property to dp node on rk3288

Jonas Karlman (1):
      arm64: dts: rockchip: fix probe of analog sound card on rock-3a

Krzysztof Kozlowski (2):
      arm64: dts: rockchip: drop unused LED mode property from rk3328-roc-cc
      arm64: dts: rockchip: align rk3399 DMC OPP table with bindings

 arch/arm/boot/dts/rk3288.dtsi                         |  1 +
 arch/arm/boot/dts/stihxxx-b2120.dtsi                  |  2 +-
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi            |  4 ++--
 arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi     |  6 +++---
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi             |  6 +++---
 arch/arm64/boot/dts/mediatek/mt8195.dtsi              |  4 ++--
 arch/arm64/boot/dts/rockchip/rk3328-roc-cc.dts        |  2 --
 arch/arm64/boot/dts/rockchip/rk3399-op1-opp.dtsi      |  2 +-
 arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts |  7 +++++++
 arch/arm64/boot/dts/rockchip/rk3399.dtsi              |  6 ++----
 arch/arm64/boot/dts/rockchip/rk3566-box-demo.dts      | 11 +++++++++++
 arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts       |  5 +++--
 arch/arm64/boot/dts/rockchip/rk356x.dtsi              |  1 +
 13 files changed, 37 insertions(+), 20 deletions(-)
