Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6129B639819
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 20:13:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbiKZTNg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 14:13:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiKZTN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 14:13:27 -0500
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17541B7EC;
        Sat, 26 Nov 2022 11:13:26 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 836435C00A2;
        Sat, 26 Nov 2022 14:13:25 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Sat, 26 Nov 2022 14:13:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1669490005; x=1669576405; bh=5+
        2cpxT9OMwkKRjZz9E1L3Vr/vQhE8GfSwdHcjXgklc=; b=HQakI9OjXZzrgnmI3R
        wqBkQBvTbY0Ij6NPV6gzKIuAZjCMku1ETpNhDI75cj0HMnq1xf3F1QY1OB9mgzeG
        p0iP8tsSCcLulMswkHbAsYDD+P014ITZSAjZc4f5vj142Z45hHNBOiJjKZt5UIbZ
        diMWWQYTFplqCZdh4yxK+Bcm0mcY+M0zIvvd88HXFTgxp695219wJI/hOdIsINQV
        OOULH+ucIKsdDtiXC0wxvlViM+IywOWHj6ZqmLtXVaMiMcm2d/dpjVkiOB6va8Zo
        MlvXlh8YmGPZPmdCHOOP30ly5rvNA4SkMbYEYDMNdf5wG7pMloNJWrd++I/fZ2qr
        GNZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1669490005; x=1669576405; bh=5+2cpxT9OMwkK
        RjZz9E1L3Vr/vQhE8GfSwdHcjXgklc=; b=GSS1+VttQdaaaavZB4rd3Xt8cLQ9Q
        uthYlnEaGxyPbYJcIinSoux1/KvZ80yzypFOxj+dOsLZ9GY7oIJg/rKLWHK4Re/E
        YA5tA3FYAwAdSrBSkefMXmRwFBLUapJebcZci97rJANXxwP+dvZAM9Hb14m9E9GP
        ylWfHGhzKHh0U4nZMhd34GVxetwHdNXAUH5FFCw+iwdwrWlF+jEwfDBcXnj1GdIF
        hGpt5YJfK/ji24wbfcCa0slUn4Ex39EeJrTmxXnNBHtRK6DtCS+Y9qIeZCi4Nz74
        RkN3i+1Ql5zSmtl2Guoq6/w2JKDRyLj4aL/VqJGQNj9wM4xbO3KMbwOEQ==
X-ME-Sender: <xms:VWWCY21F_9lu9zuLPoo35puCRzVIfiSa-XP_To22wsBTeoUArXT9lg>
    <xme:VWWCY5GZgvhvlmLll_QB4o1lde4Cb60g38_suuIaPM-yCcK-SVs0NuCWTLBfYwsFS
    k1VYxEsb9ntDfuKAg>
X-ME-Received: <xmr:VWWCY-4AoGxr9dt8Lkq69FPldMQ04VUpOyosdiTnZgK5UHthlH6m6eCLMHyqY4VxTFDdNfR8EQXTlY3iEdpmSQ5pcurkwTs0O10AhN5m4aXnc1mK3zau9lUZaPR-UQS2Qf6jMA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrieejgdduvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepudekteeuudehtdelteevgfduvddvjefhfedulefgudevgeeghefg
    udefiedtveetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:VWWCY32lQYUccLiNJ-knoN2T4j24R1EHfNgMvrGQl3mVsuUCobUqQw>
    <xmx:VWWCY5GIIeltr4nBPUkYB00KN3yWDuWmNnLG7MSbPEgpB4Jg42tipQ>
    <xmx:VWWCYw8IjIgKeQB7p-IwnXMaCT3dMMhNpy5F0yyzPIOzRjI9Lw4XMA>
    <xmx:VWWCY488AEktG_cTKyQ7EAhG-SxA6Aq7z1Vhz2KaudLJ-QYkRLektg>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 26 Nov 2022 14:13:24 -0500 (EST)
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
Subject: [PATCH 3/5] clk: sunxi-ng: d1: Allow building for R528/T113
Date:   Sat, 26 Nov 2022 13:13:17 -0600
Message-Id: <20221126191319.6404-4-samuel@sholland.org>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20221126191319.6404-1-samuel@sholland.org>
References: <20221126191319.6404-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allwinner released some 32-bit ARM (sun8i) SoCs which use the same CCU
as D1. Allow them to reuse the driver.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 drivers/clk/sunxi-ng/Kconfig | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/sunxi-ng/Kconfig b/drivers/clk/sunxi-ng/Kconfig
index 78deee2996ce..b547198a2c65 100644
--- a/drivers/clk/sunxi-ng/Kconfig
+++ b/drivers/clk/sunxi-ng/Kconfig
@@ -13,14 +13,14 @@ config SUNIV_F1C100S_CCU
 	depends on MACH_SUNIV || COMPILE_TEST
 
 config SUN20I_D1_CCU
-	tristate "Support for the Allwinner D1 CCU"
+	tristate "Support for the Allwinner D1/R528/T113 CCU"
 	default y
-	depends on RISCV || COMPILE_TEST
+	depends on MACH_SUN8I || RISCV || COMPILE_TEST
 
 config SUN20I_D1_R_CCU
-	tristate "Support for the Allwinner D1 PRCM CCU"
+	tristate "Support for the Allwinner D1/R528/T113 PRCM CCU"
 	default y
-	depends on RISCV || COMPILE_TEST
+	depends on MACH_SUN8I || RISCV || COMPILE_TEST
 
 config SUN50I_A64_CCU
 	tristate "Support for the Allwinner A64 CCU"
-- 
2.37.4

