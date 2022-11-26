Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0D0639817
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 20:13:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbiKZTNb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 14:13:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiKZTN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 14:13:26 -0500
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57B3865EF;
        Sat, 26 Nov 2022 11:13:24 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id C4CFE5C0086;
        Sat, 26 Nov 2022 14:13:21 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Sat, 26 Nov 2022 14:13:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1669490001; x=1669576401; bh=/Swga9/f3c
        a8n+exMSarTlOwmNA57DG0SPyW0U3UXv0=; b=x+KIdqiZjXSa79G21mU1hnRUT+
        YrrG2lbZ4GHT9ELvWGldRUw//oGWMKDE4NLJrLYiUucTVvo5/+IfCgMIwKW9j652
        4cRlAJk0ANbamiDqMoNQsUWiNEWFguO8oVpqFriFjpBxphg4+tdH4yCsQv8UeBdr
        m9+F7o2pwPM7i1mFgo3WYqJuzcSTBmD1o0yQ2gOEJRT7LdcPLVIPfwqYLkJMipmG
        BXU8RB9sx1VQIdnDfmPKZrC4X+HtSSe7Ycdk+kqimMZM5f99TNkXrenfLSXZX/gh
        jKUoP8Y0Cx5IvmQj/9opewFF7mtP8jp+rbf41tx7a3vzyAo/BRj3EcONFPUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1669490001; x=1669576401; bh=/Swga9/f3ca8n
        +exMSarTlOwmNA57DG0SPyW0U3UXv0=; b=BreZv9tq4FtRXs5oxq0RCabkeWdFf
        Hqd6ISPB8GiX4UQMy3OJs1pWjgSTtX2FT8v6ZdRdXrAiK/icwhxF9xHE8lZI3O1s
        mhfpmtlfslUOIachTSgG+Ab/JsOMrRM/SgVp3+GDm55jGeqqxvugN2zstl9s31FO
        i9Se3vsA0EkxGadY8k/+2yfwDgko3ez+42Yv/jASKB15fgHwxZOpRkZj39Ccuxwl
        joHIHlgFI9Vt7HJmgPiVgOzwkFLMYUwsTsezvfx7HNkFkta3wVGz5Y6NvNWv2PvE
        vAP3AO7sdeyn8m5zSRUQv1BwtJpyJZECiYoFAbT5VRpiQmE4vfZ0qMG/Q==
X-ME-Sender: <xms:UWWCYzWv5F9Lj0L4ksV5YKF3J65xYGIwLvRsedvuU9MaSyeWAZMa3g>
    <xme:UWWCY7lTmgxy4LtLSc5JmhbzxX44zInrohjpf7yxqLL9vgCb7i-egzr1mBpM38HmE
    9EPZfGmigsnyKEWUA>
X-ME-Received: <xmr:UWWCY_Yz2piKahY94zqFOPAQ9eR571VQPTyta84xFkF_oXatfBhSKrIV4APze2bokVhmXZPng81hHnbGW5YR-nl-ypcVWA07baTskPdVW9souy5tkcuksrnIRWTj0oXJ2tN1lw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrieejgdduvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofggtgfgsehtkeertdertdejnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeeuvefhveekieffveeileehtdduleffveehgfdugfdtkeehteffffel
    hfeftedvvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:UWWCY-WPQp-i_EvNzWEpTtgRyJrmhdTmrm1MKXFoOfITd0ub5sRTMw>
    <xmx:UWWCY9nG_hWRZCLiaXtAWWZdZPg2JhgwEk2gpf7Qi-McluVJ3almXA>
    <xmx:UWWCY7c8FEOkh_RgTTFcgNLDJLEp3K1ja-A5OCuDU3fe9cNMzV_R6w>
    <xmx:UWWCYzfrHpJ4TCmLU_hm3NnBi5O5oO5ZX6X01G2umAzCLbOFlaBhOA>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 26 Nov 2022 14:13:20 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Samuel Holland <samuel@sholland.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev
Subject: [PATCH 0/5] clk: sunxi-ng: Allwinner R528/T113 clock support
Date:   Sat, 26 Nov 2022 13:13:14 -0600
Message-Id: <20221126191319.6404-1-samuel@sholland.org>
X-Mailer: git-send-email 2.37.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

R528 and T113 are SoCs based on the same design as D1/D1s, but with ARM
CPUs instead of RISC-V. They use the same CCU implementation, meaning
the CCU has gates/resets for all peripherals present on any SoC in this
family. I verified the CAN bus bits are also present on D1/D1s.

Patches 1-2 clean up the Kconfig in preparation for patch 3, which
allows building the driver. Patches 4-5 add the missing driver bits.


András Szemző (1):
  clk: sunxi-ng: d1: Mark cpux clock as critical

Fabien Poussin (1):
  clk: sunxi-ng: d1: Add CAN bus gates and resets

Samuel Holland (3):
  clk: sunxi-ng: Remove duplicate ARCH_SUNXI dependencies
  clk: sunxi-ng: Move SoC driver conditions to dependencies
  clk: sunxi-ng: d1: Allow building for R528/T113

 drivers/clk/sunxi-ng/Kconfig              | 71 ++++++++++++-----------
 drivers/clk/sunxi-ng/ccu-sun20i-d1.c      | 13 ++++-
 drivers/clk/sunxi-ng/ccu-sun20i-d1.h      |  2 +-
 include/dt-bindings/clock/sun20i-d1-ccu.h |  2 +
 include/dt-bindings/reset/sun20i-d1-ccu.h |  2 +
 5 files changed, 53 insertions(+), 37 deletions(-)

-- 
2.37.4

