Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9BC173C199
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 22:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231523AbjFWU6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 16:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjFWU54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 16:57:56 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 335D32130
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 13:57:55 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 89B7E320091B;
        Fri, 23 Jun 2023 16:57:52 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Fri, 23 Jun 2023 16:57:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm1; t=1687553872; x=1687640272; bh=tRa6faL8nedd+6K1urdZanKhA
        GDHKhkp0FltEiRxjrc=; b=TwF0ATiRxsyGdeqS4T3aGJ64+692dHb8irSLjG1EN
        iBWecmSb3AydJcCs1Pi0PVJ8QzHEK7454gF4HJb2tipNpB+AQGa0SYrYZGs+z0mj
        19wzNbVny4JBDpbg/kffWJMerVhoEX2DlbT/8gIG2K1hJ8WQONyVIixQmkrnnR/a
        U9GBZmuyATWIVa/cl2+T9+d1KlKlDYRfvm1llz2HuJ7zHe4mQ49Eh6WQl3uQ4FSI
        OnPyaTiSNmE81zu5qlAsbkVEWdCdY9GoBlBPlgz4lxzV6kC/7bQ6qDgG7fQo0xGr
        pTNDFUmz6pZolgrne0MY4DNH6bpJG/2WeV/aPhp9Z1QKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1687553872; x=1687640272; bh=tRa6faL8nedd+6K1urdZanKhAGDHKhkp0Fl
        tEiRxjrc=; b=Q85cYncPivm20vbdgI6SSmRAaYOsOGU0iDyA8JNZ3NMfdp9A6ir
        QRTDpRCkwmbAUgPu2RJ1AAJ3hKO9EGBM5Mb6V7EQQ7VYFaOu4zHqGUSChMoOzeVq
        FekFTMjd2gaGrQJgjpDyUzWLLq0WTfKWrAfDgB1dAZ1976/pICjIT+8WiS1xFaqD
        oKamPThot9Rag2fc1M4TpfI8Zj1G1+93i0yeqWEmP6S419QIgI4HP0VEjTANI7aQ
        jScubguDNBLsoyvnm2m+y08EKGqFkXjtWG4lpltiYGf/LHrgzZPCT9gyyiHhU8AT
        8a8mBk4svt5JlXMvxV7SDTKzJSRlkIJscaA==
X-ME-Sender: <xms:TweWZLDoxwtYY_a4kNu3kwHC0kHkHFHFUXGGrqgpszeo8DgmMfQtQQ>
    <xme:TweWZBhPYglexVYfV3uv6qmPZLTNriAxlqmQw1-b_OwAm7EfE__8nP0G6rTkrhxQK
    2TM8zVFQlwXHtz57Qc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeeggedgudehgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeeffeeuhfekjeevtddvtdelledttddtjeegvdfhtdduvdfhueekudeihfejtefg
    ieenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:TweWZGmVawOoX0ciW3xasRRliJYjyag0gE5tQjaRNC-pc8z3C2TiIg>
    <xmx:TweWZNxfuiwghS0sO8ByLdbOFkDXeda16iXgDMF-xvhTLnWpKAGO3A>
    <xmx:TweWZAQ9juBrlkXZBzzYyTaPH6MZ8P3QlBlcvuu1z7R0b9G5L8dARA>
    <xmx:UAeWZGNY94__nHjRUBGix6tB2_92CYEt0vtgew1XyqmAfMzvKd8KEA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 861C1B60086; Fri, 23 Jun 2023 16:57:51 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-499-gf27bbf33e2-fm-20230619.001-gf27bbf33
Mime-Version: 1.0
Message-Id: <fac1e7b7-4ba6-4334-a550-9d8a78037bf6@app.fastmail.com>
Date:   Fri, 23 Jun 2023 22:57:31 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Linus Torvalds" <torvalds@linux-foundation.org>
Cc:     soc@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        "Bjorn Andersson" <andersson@kernel.org>,
        "Doug Anderson" <dianders@chromium.org>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Subject: [GIT PULL] ARM: SoC fixes for 6.4, part 3
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 858fd168a95c5b9669aac8db6c14a9aeab446375:

  Linux 6.4-rc6 (2023-06-11 14:35:30 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/arm-fixes-6.4-3

for you to fetch changes up to ed8ff046eddd916627e1e9a549eacd9c043fde7d:

  Merge tag 'qcom-arm64-fixes-for-6.4-2' of https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux into arm/fixes (2023-06-23 22:13:27 +0200)

----------------------------------------------------------------
ARM: SoC fixes for 6.4, part 3

The final bug fixes for Qualcomm and Rockchips came in, all of them
for devicetree files:

 - Devices on Qualcomm SC7180/SC7280 that are cache coherent are now
   marked so correctly to fix a regression after a change in kernel behavior.

 - Rockchips has a few minor changes for correctness of regulator and cache
   properties, as well as fixes for incorrect behavior of the RK3568 PCI
   controller and reset pins on two boards.

----------------------------------------------------------------
Andrew Powers-Holmes (1):
      arm64: dts: rockchip: Fix rk356x PCIe register and range mappings

Arnd Bergmann (2):
      Merge tag 'v6.4-rockchip-dtsfixes1' of git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip into arm/fixes
      Merge tag 'qcom-arm64-fixes-for-6.4-2' of https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux into arm/fixes

Douglas Anderson (4):
      dt-bindings: firmware: qcom,scm: Document that SCM can be dma-coherent
      arm64: dts: qcom: sc7180: Mark SCM as dma-coherent for IDP
      arm64: dts: qcom: sc7180: Mark SCM as dma-coherent for trogdor
      arm64: dts: qcom: sc7280: Mark SCM as dma-coherent for chrome devices

Krzysztof Kozlowski (1):
      arm64: dts: rockchip: add missing cache properties

Lorenz Brun (1):
      arm64: dts: rockchip: fix USB regulator on ROCK64

Nicolas Frattaroli (1):
      arm64: dts: rockchip: fix nEXTRST on SOQuartz

Tianling Shen (1):
      arm64: dts: rockchip: fix button reset pin for nanopi r5c

 .../devicetree/bindings/firmware/qcom,scm.yaml     |  2 ++
 arch/arm64/boot/dts/qcom/sc7180-idp.dts            |  5 ++++
 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi       |  5 ++++
 arch/arm64/boot/dts/qcom/sc7180.dtsi               |  2 +-
 arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi |  5 ++++
 arch/arm64/boot/dts/qcom/sc7280.dtsi               |  2 +-
 arch/arm64/boot/dts/rockchip/rk3308.dtsi           |  1 +
 arch/arm64/boot/dts/rockchip/rk3328-rock64.dts     | 14 ++---------
 arch/arm64/boot/dts/rockchip/rk3328.dtsi           |  1 +
 .../boot/dts/rockchip/rk3566-soquartz-cm4.dts      | 18 ++++++++------
 arch/arm64/boot/dts/rockchip/rk3566-soquartz.dtsi  | 29 ++++++++++------------
 arch/arm64/boot/dts/rockchip/rk3568-nanopi-r5c.dts |  2 +-
 arch/arm64/boot/dts/rockchip/rk3568-nanopi-r5s.dts |  1 -
 arch/arm64/boot/dts/rockchip/rk3568.dtsi           | 14 ++++++-----
 arch/arm64/boot/dts/rockchip/rk356x.dtsi           |  7 +++---
 arch/arm64/boot/dts/rockchip/rk3588s.dtsi          |  9 +++++++
 16 files changed, 69 insertions(+), 48 deletions(-)
