Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE710639811
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 20:13:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbiKZTN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 14:13:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbiKZTN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 14:13:26 -0500
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57623270C;
        Sat, 26 Nov 2022 11:13:24 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id E758E5C009D;
        Sat, 26 Nov 2022 14:13:22 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Sat, 26 Nov 2022 14:13:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1669490002; x=1669576402; bh=WB
        ZnL6dt+cJ0K4wgFwwV3Z/VQP7SY23Z7IY/5H+lKxk=; b=ljW3OeFw/MLqRU3xx+
        6FGOIzEjJ2ixL+dVvwQBa9CoRBxN/CReCx5UBZqQrShaonkRrPKBpN0KTckwb/0o
        PANH2jueQ5OMHdAqoOJhq1/ly3qU8+n1foYOdfAJ3zrUNgaxRr9/9JuJuhhu9aqS
        +Dq12pCN+bn5HhHzAnP0rK7ptl3V2WnGn6RxNZNKYCaAeO8SxyB4Pwg1bFO4UP7L
        2UILN1vHHbzA5BiuKI69bFJkYNSxop1QKxMSzrRmcw27UbLGrjyDW0bSTujAqDgG
        x/8DyZChge/na084AREirveBBw6wqkbyhERCghI1J8/JMkGZBmkOfxiaesrYNvwn
        MGKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1669490002; x=1669576402; bh=WBZnL6dt+cJ0K
        4wgFwwV3Z/VQP7SY23Z7IY/5H+lKxk=; b=KEB+L2vXsob+UbdaPAoZ2LONvoCMN
        QRp1f9b6sPfUWxgJPj2WJzWvNzYe5pagxy/VdQwVzv1i15+vcatz1gHpRJXC/X4a
        WI6JUbiWLpzMDYrCNMqqjJxmobyRxYB3dXtut3JVmouiNEOnNqV8pdSU6mKTVQtg
        hVGmPyrsp1zR/S9dfeDx/0rShjlXKsyN/V4HWy9W1dOrzd87qNxky4+gzPVzgvkj
        yDiz6a5E6ipa7pogX/XCVXYXyUGxtKrajDeAXj4jkXOB4NLJJ1/7/dcAH1LngNxP
        GAhlin7xxFemLdhArUC6Bmeo7MlarT464H6ufe/3uhafarfKwHSjCLAwA==
X-ME-Sender: <xms:UmWCYyZFw0B2Vx801SoZyKZG4oKrSvV_yUf84cteq-VqgeKTm_ZX-Q>
    <xme:UmWCY1axQv6JREig_j4EoSICBSp2Lj9Bv6Dq7P1yWuocLZk9U-OTBma51rLkiC6f9
    77KED_ifw0FQpl9-g>
X-ME-Received: <xmr:UmWCY88dYTS5lF3WLmZIZUrgKctV9dHb8DtVsGTx6QK8S6PCGQJ0OcZIQD-VlOnG8qSmLDIz7wjCN8MEYZXZmhh24Pqk_qhtKW1L4B172wBCpY8PVyMWq__EJoCxxCdSzFLJtw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrieejgdduvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepudekteeuudehtdelteevgfduvddvjefhfedulefgudevgeeghefg
    udefiedtveetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:UmWCY0oX2c_VF5lJpxhDJM4vlN6gMS5ahf86NkDQIyaw4tsrKzdkrg>
    <xmx:UmWCY9oq12pLzXJ_T4baV-xP27t-RV4IgXXrdMsWRT91WTeEpXCZ0A>
    <xmx:UmWCYyS3-9tGbhxUCC6V6KNM4gLE8aB-CzBAgSKhRtd1ihXqXaSetg>
    <xmx:UmWCY-TaPY1c9afrrTHxIGB_MZVE3Rvl1FSDeyrmAvuRsbocrxelaQ>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 26 Nov 2022 14:13:22 -0500 (EST)
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
Subject: [PATCH 1/5] clk: sunxi-ng: Remove duplicate ARCH_SUNXI dependencies
Date:   Sat, 26 Nov 2022 13:13:15 -0600
Message-Id: <20221126191319.6404-2-samuel@sholland.org>
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

SUNXI_CCU already depends on ARCH_SUNXI, so adding the dependency to
individual SoC drivers is redundant.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 drivers/clk/sunxi-ng/Kconfig | 43 ++++++++++++++++++------------------
 1 file changed, 21 insertions(+), 22 deletions(-)

diff --git a/drivers/clk/sunxi-ng/Kconfig b/drivers/clk/sunxi-ng/Kconfig
index 461537679c04..64cfa022e320 100644
--- a/drivers/clk/sunxi-ng/Kconfig
+++ b/drivers/clk/sunxi-ng/Kconfig
@@ -14,43 +14,43 @@ config SUNIV_F1C100S_CCU
 
 config SUN20I_D1_CCU
 	tristate "Support for the Allwinner D1 CCU"
-	default RISCV && ARCH_SUNXI
-	depends on (RISCV && ARCH_SUNXI) || COMPILE_TEST
+	default RISCV
+	depends on RISCV || COMPILE_TEST
 
 config SUN20I_D1_R_CCU
 	tristate "Support for the Allwinner D1 PRCM CCU"
-	default RISCV && ARCH_SUNXI
-	depends on (RISCV && ARCH_SUNXI) || COMPILE_TEST
+	default RISCV
+	depends on RISCV || COMPILE_TEST
 
 config SUN50I_A64_CCU
 	tristate "Support for the Allwinner A64 CCU"
-	default ARM64 && ARCH_SUNXI
-	depends on (ARM64 && ARCH_SUNXI) || COMPILE_TEST
+	default ARM64
+	depends on ARM64 || COMPILE_TEST
 
 config SUN50I_A100_CCU
 	tristate "Support for the Allwinner A100 CCU"
-	default ARM64 && ARCH_SUNXI
-	depends on (ARM64 && ARCH_SUNXI) || COMPILE_TEST
+	default ARM64
+	depends on ARM64 || COMPILE_TEST
 
 config SUN50I_A100_R_CCU
 	tristate "Support for the Allwinner A100 PRCM CCU"
-	default ARM64 && ARCH_SUNXI
-	depends on (ARM64 && ARCH_SUNXI) || COMPILE_TEST
+	default ARM64
+	depends on ARM64 || COMPILE_TEST
 
 config SUN50I_H6_CCU
 	tristate "Support for the Allwinner H6 CCU"
-	default ARM64 && ARCH_SUNXI
-	depends on (ARM64 && ARCH_SUNXI) || COMPILE_TEST
+	default ARM64
+	depends on ARM64 || COMPILE_TEST
 
 config SUN50I_H616_CCU
 	tristate "Support for the Allwinner H616 CCU"
-	default ARM64 && ARCH_SUNXI
-	depends on (ARM64 && ARCH_SUNXI) || COMPILE_TEST
+	default ARM64
+	depends on ARM64 || COMPILE_TEST
 
 config SUN50I_H6_R_CCU
 	tristate "Support for the Allwinner H6 and H616 PRCM CCU"
-	default ARM64 && ARCH_SUNXI
-	depends on (ARM64 && ARCH_SUNXI) || COMPILE_TEST
+	default ARM64
+	depends on ARM64 || COMPILE_TEST
 
 config SUN4I_A10_CCU
 	tristate "Support for the Allwinner A10/A20 CCU"
@@ -71,8 +71,7 @@ config SUN6I_A31_CCU
 
 config SUN6I_RTC_CCU
 	tristate "Support for the Allwinner H616/R329 RTC CCU"
-	default ARCH_SUNXI
-	depends on ARCH_SUNXI || COMPILE_TEST
+	default y
 
 config SUN8I_A23_CCU
 	tristate "Support for the Allwinner A23 CCU"
@@ -91,8 +90,8 @@ config SUN8I_A83T_CCU
 
 config SUN8I_H3_CCU
 	tristate "Support for the Allwinner H3 CCU"
-	default MACH_SUN8I || (ARM64 && ARCH_SUNXI)
-	depends on MACH_SUN8I || (ARM64 && ARCH_SUNXI) || COMPILE_TEST
+	default MACH_SUN8I || ARM64
+	depends on MACH_SUN8I || ARM64 || COMPILE_TEST
 
 config SUN8I_V3S_CCU
 	tristate "Support for the Allwinner V3s CCU"
@@ -101,7 +100,7 @@ config SUN8I_V3S_CCU
 
 config SUN8I_DE2_CCU
 	tristate "Support for the Allwinner SoCs DE2 CCU"
-	default MACH_SUN8I || (ARM64 && ARCH_SUNXI)
+	default MACH_SUN8I || ARM64
 
 config SUN8I_R40_CCU
 	tristate "Support for the Allwinner R40 CCU"
@@ -115,6 +114,6 @@ config SUN9I_A80_CCU
 
 config SUN8I_R_CCU
 	tristate "Support for Allwinner SoCs' PRCM CCUs"
-	default MACH_SUN8I || (ARCH_SUNXI && ARM64)
+	default MACH_SUN8I || ARM64
 
 endif
-- 
2.37.4

