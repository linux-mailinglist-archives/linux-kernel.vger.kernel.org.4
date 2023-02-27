Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF4606A4765
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 17:57:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbjB0Q5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 11:57:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjB0Q5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 11:57:31 -0500
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A45416ADC
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 08:57:19 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 5F5DA32002FB;
        Mon, 27 Feb 2023 11:57:18 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Mon, 27 Feb 2023 11:57:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1677517037; x=1677603437; bh=MNs1U7afNx
        12k6nIyMzzxsgiph/OGstNMM2IjWEFD94=; b=OqCinnghlu7ktExI979tKz5HTy
        367auNLoJHvL46H83nMdERn/1CpHc1o0Gg2/Vo9y/ywJzSTV2vqniDpKYpStQeyA
        0nnULxPk2s3oX2Auz9wXDgJI4+aCxRPbQxjv2LYHYKLxH5XrqLE17qAWWldiQHpn
        TUoeRVhWA1yGkw/R+6meCy6+QeDCMgdmodPMowl1YKPcvJA9czpSG8h2GFVOFN6U
        rpP8P75lfPQLrNmNaTQ1qMFsEzKw14khd/sJqm34EyrCQIVLVmNju6gPN0qypa9O
        C6it9Xo/DQjjT1duX2Ut0vNRODgZSdpjsnNLB5miJ2TbZGnssHBAcyQ9RsmA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1677517037; x=1677603437; bh=MNs1U7afNx12k6nIyMzzxsgiph/O
        GstNMM2IjWEFD94=; b=rzeLFM3QISIYZYP+GL3NRyNUB8PlPZTxpJxWMEJKAopD
        s0gXb4zy8DlM3VRzLr2YRPcZYHskER6POROZUjcraqnnHuajo7oN3gfrCSd3YTtV
        ZOs7xA4su9wLAe/fa11Zx3ib9z4/tFQLRCKhR1WTMUUZg/GNYnXPIfyiCua2aQMY
        eV10XVYoRpGJ3HCRaqArC4qOXlivLvds3S+hi4q+i9rzDTx2bNXbORJ/0ESqJy2L
        /xJz3WFyBcXpcdkwLRzR1v/PdIQgaWOk7i5uJv3ts6ApWs7gQ0lDbkPCMK99/KF9
        rwf0Vtjt5lz5UbmF7H8QCPtwjecYrN2bLZ2WMYR2Iw==
X-ME-Sender: <xms:7eD8YxYS1_JTxTtNY-mvHIa07j5SKd4kXH1h5ZEFFwRWjAZ29oBUtQ>
    <xme:7eD8Y4aTEKjN8OpFt8a3oInT7I_afxDekogxofbv_X-O_SCZYESSnSlcs3Pp-2mv7
    7DaZIOkWbSf9X5_Sx8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudeltddgledtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepvefhffeltdegheeffffhtdegvdehjedtgfekueevgfduffettedtkeekueef
    hedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:7eD8Yz-MgZ5NAISQWDcpLT324ud5limJSXfoHa09CL6jfH6WcSlL1w>
    <xmx:7eD8Y_q8IBIb0pT660iuPxAOqSDzg-j0njRSggH-055KMpGBOcA0vA>
    <xmx:7eD8Y8rWdGCBUEYt0qW8YQDRrCsccUtvXTQKtbmm-b4PcB4GfFqGxg>
    <xmx:7eD8Y5CtEF37hz5N2CXcIpTRUllWez3lWwm79zCZ0XTgn3oml7hUwQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id CA92AB60086; Mon, 27 Feb 2023 11:57:17 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-183-gbf7d00f500-fm-20230220.001-gbf7d00f5
Mime-Version: 1.0
Message-Id: <413dd8bd-32d3-40a3-93b3-a3c9e3d8e621@app.fastmail.com>
In-Reply-To: <99657e61-81b7-4f03-b81d-fd2a49e67eef@app.fastmail.com>
References: <99657e61-81b7-4f03-b81d-fd2a49e67eef@app.fastmail.com>
Date:   Mon, 27 Feb 2023 17:56:57 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Linus Torvalds" <torvalds@linux-foundation.org>
Cc:     soc@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL 2/2] ARM: SoC fixes for 6.3, part 1
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit ceaa837f96adb69c0df0397937cd74991d5d821a:

  Linux 6.2-rc8 (2023-02-12 14:10:17 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/arm-fixes-6.3-1

for you to fetch changes up to 9f79762ef8d90a6fab85e4ac0d153bdd8b4868ca:

  Merge tag 'samsung-dt-fixes-6.3' of https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux into arm/fixes (2023-02-27 14:47:00 +0100)

----------------------------------------------------------------
ARM: SoC fixes for 6.3, part 1

A few bugfixes already came up during the merge window. Samsung, ASpeed,
Spear have minor DT changes, in case of Samsung this fixes a regression
compared to earlier versions.

Bartosz takes over as the primary maintainer for the TI DaVinci platform,
and we get a few last minute defconfig changes.

----------------------------------------------------------------
Arnd Bergmann (2):
      Merge tag 'davinci-fixes-for-v6.2' of git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux into arm/fixes
      Merge tag 'samsung-dt-fixes-6.3' of https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux into arm/fixes

Bartosz Golaszewski (1):
      MAINTAINERS: make me the maintainer of DaVinci platforms

Eddie James (1):
      ARM: dts: aspeed: p10bmc: Update battery node name

Krzysztof Kozlowski (7):
      ARM: dts: exynos: correct TMU phandle in Exynos4
      ARM: dts: exynos: correct TMU phandle in Exynos4210
      ARM: dts: exynos: correct TMU phandle in Exynos5250
      ARM: dts: exynos: correct TMU phandle in Odroid XU
      ARM: dts: exynos: correct TMU phandle in Odroid HC1
      ARM: dts: exynos: correct TMU phandle in Odroid XU3 family
      ARM: dts: spear320-hmi: correct STMPE GPIO compatible

Linus Walleij (1):
      arm64: defconfig: Add IOSCHED_BFQ to the default configs

Mark Brown (1):
      arm64: defconfig: Fix unintentional disablement of PCI on i.MX

 MAINTAINERS                                        |  7 +++----
 arch/arm/boot/dts/aspeed-bmc-ibm-bonnell.dts       |  2 +-
 arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts       |  2 +-
 arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts       |  2 +-
 arch/arm/boot/dts/exynos4-cpu-thermal.dtsi         |  2 +-
 arch/arm/boot/dts/exynos4210.dtsi                  |  1 -
 arch/arm/boot/dts/exynos5250.dtsi                  |  2 +-
 arch/arm/boot/dts/exynos5410-odroidxu.dts          |  1 -
 arch/arm/boot/dts/exynos5422-odroidhc1.dts         | 10 +++++-----
 arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi | 10 +++++-----
 arch/arm/boot/dts/spear320-hmi.dts                 |  2 +-
 arch/arm64/configs/defconfig                       |  3 ++-
 12 files changed, 21 insertions(+), 23 deletions(-)
