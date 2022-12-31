Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF0F65A813
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Jan 2023 00:14:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235877AbiLaXOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 18:14:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232374AbiLaXOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 18:14:35 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41EAAD82;
        Sat, 31 Dec 2022 15:14:34 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id A1BE85C00B1;
        Sat, 31 Dec 2022 18:14:33 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Sat, 31 Dec 2022 18:14:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1672528473; x=1672614873; bh=Do
        u7u3aeb59O4P7EkROntoPwMutjzat+qW1iePMNlRs=; b=zj5vXL7t+Thnz/ljCB
        Imqe1QaXcHJRjPHBrJh0Lpe+dt9grVbQQfZpsK3VbfjXqgYFjYZtLHoeOu8ke1ID
        lTL9iT8ie6NUAQvMdDqkVxFH5l/r4lMI0s++z8UOlvrYMpYU6bnVEhWtWdEYhXQk
        sC8wayo+K18DoAaALwGegt7Yogp0eDaRXDWYEy0kumgF1Iitp6Yqb4jLsewW9xMi
        shj6pJ+xp1aPk33fNZaTV/b25qmXrd1ZWhpf0oeFenkpDHG7qlIphLcN/ilmLTSW
        1uFBczyGg81322qjz4tX2KA7l1k/UGagZZ7+YISF1IAx08B0k+2Aukxq/zIcxIiH
        X1Hw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1672528473; x=1672614873; bh=Dou7u3aeb59O4
        P7EkROntoPwMutjzat+qW1iePMNlRs=; b=gHSqze1qPTrPd40g1qJx1IdX7ZAhV
        yDYP7INxhyfqRMi+aGSowfwCjf3zmjHT/MBYKYW3w6DbpHMsntuCOpApGZoCkouu
        SCB8L/dAJ2z4Xfe+gfQeyVcRwq3LuZFlpdwXOGZ/98zBFs7NTXgr+T79/mWh8/dr
        xKYR3yLi6hDLDM8uu6iMMbgd677a38mGpu4rdVv3Rfbsi0BNKQBNc0AF4XkmAUnC
        UVRBIM7SY3Z95wDCw/5fNWLtxW/IsZenXGr4kH1b/66EUaEXkbZei9kVD4Syp+om
        +oQgJjCXtcXAREleKDr+Hiy9lTk0NT1JhT7PDElilIJK/l0ZkkD5BAcBQ==
X-ME-Sender: <xms:WcKwYzOTaDkpLyXQOUt22rV_luAN22j2qFzy5zUzLbcgs-8w9hL5IA>
    <xme:WcKwY9-awJrXsF596hnoQx3POoOasDYFHmNZ48dPlL1giFkaqJcPClnzYlFyXllt3
    BQ8y6LMavFkgT6vSg>
X-ME-Received: <xmr:WcKwYySjGg7uJ54-mb1wShVKmsaSe3oSn5tkIqNhpVBmnpPJV6FIk9dgJNL0Y9IJzli3XzSy5e0GjwHho5YPrsIzbhy_Ol8ChlqKcd7REV2tdAzTAb8xIeY3iTilnRKSFTtLdg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrieelgddtkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpedukeetueduhedtleetvefguddvvdejhfefudelgfduveeggeehgfdu
    feeitdevteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:WcKwY3s6_dEZkLjPUr-zW9O5jVgSVz_fGL6gREIQd6hK_pD5beyLoQ>
    <xmx:WcKwY7csBLsFeGkL6ygwjVjK37ru0sxSsSKzCQGhfJEQ1ntkgd69Yg>
    <xmx:WcKwYz0Qjsx0xd01lUmUno7pRorWpiwATyus5V9x5u3DH2bTvhqX2A>
    <xmx:WcKwYz8HmXpdZTMbsTRkZVIq50IkJ-Vv0V6iZ3aZnhHWcm1K6PK5wA>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 31 Dec 2022 18:14:32 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Samuel Holland <samuel@sholland.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-sunxi@lists.linux.dev
Subject: [PATCH v2 2/6] clk: sunxi-ng: Move SoC driver conditions to dependencies
Date:   Sat, 31 Dec 2022 17:14:25 -0600
Message-Id: <20221231231429.18357-3-samuel@sholland.org>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20221231231429.18357-1-samuel@sholland.org>
References: <20221231231429.18357-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not duplicate the same expression on the `default` line, so the two
lines do not need to be kept in sync. Drivers stay disabled under
COMPILE_TEST because of the `default ARCH_SUNXI` applied to SUNXI_CCU.

Three drivers had no conditions.
 - SUN6I_RTC_CCU and SUN8I_DE2_CCU are used on current hardware
   regardless of CPU architecture.
 - SUN8I_R_CCU is only used on pre-H6 SoCs, which means no RISCV SoCs.

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
Signed-off-by: Samuel Holland <samuel@sholland.org>
---

(no changes since v1)

 drivers/clk/sunxi-ng/Kconfig | 46 +++++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 22 deletions(-)

diff --git a/drivers/clk/sunxi-ng/Kconfig b/drivers/clk/sunxi-ng/Kconfig
index 64cfa022e320..78deee2996ce 100644
--- a/drivers/clk/sunxi-ng/Kconfig
+++ b/drivers/clk/sunxi-ng/Kconfig
@@ -9,111 +9,113 @@ if SUNXI_CCU
 
 config SUNIV_F1C100S_CCU
 	tristate "Support for the Allwinner newer F1C100s CCU"
-	default MACH_SUNIV
+	default y
 	depends on MACH_SUNIV || COMPILE_TEST
 
 config SUN20I_D1_CCU
 	tristate "Support for the Allwinner D1 CCU"
-	default RISCV
+	default y
 	depends on RISCV || COMPILE_TEST
 
 config SUN20I_D1_R_CCU
 	tristate "Support for the Allwinner D1 PRCM CCU"
-	default RISCV
+	default y
 	depends on RISCV || COMPILE_TEST
 
 config SUN50I_A64_CCU
 	tristate "Support for the Allwinner A64 CCU"
-	default ARM64
+	default y
 	depends on ARM64 || COMPILE_TEST
 
 config SUN50I_A100_CCU
 	tristate "Support for the Allwinner A100 CCU"
-	default ARM64
+	default y
 	depends on ARM64 || COMPILE_TEST
 
 config SUN50I_A100_R_CCU
 	tristate "Support for the Allwinner A100 PRCM CCU"
-	default ARM64
+	default y
 	depends on ARM64 || COMPILE_TEST
 
 config SUN50I_H6_CCU
 	tristate "Support for the Allwinner H6 CCU"
-	default ARM64
+	default y
 	depends on ARM64 || COMPILE_TEST
 
 config SUN50I_H616_CCU
 	tristate "Support for the Allwinner H616 CCU"
-	default ARM64
+	default y
 	depends on ARM64 || COMPILE_TEST
 
 config SUN50I_H6_R_CCU
 	tristate "Support for the Allwinner H6 and H616 PRCM CCU"
-	default ARM64
+	default y
 	depends on ARM64 || COMPILE_TEST
 
 config SUN4I_A10_CCU
 	tristate "Support for the Allwinner A10/A20 CCU"
-	default MACH_SUN4I
-	default MACH_SUN7I
+	default y
 	depends on MACH_SUN4I || MACH_SUN7I || COMPILE_TEST
 
 config SUN5I_CCU
 	bool "Support for the Allwinner sun5i family CCM"
-	default MACH_SUN5I
+	default y
 	depends on MACH_SUN5I || COMPILE_TEST
 	depends on SUNXI_CCU=y
 
 config SUN6I_A31_CCU
 	tristate "Support for the Allwinner A31/A31s CCU"
-	default MACH_SUN6I
+	default y
 	depends on MACH_SUN6I || COMPILE_TEST
 
 config SUN6I_RTC_CCU
 	tristate "Support for the Allwinner H616/R329 RTC CCU"
 	default y
+	depends on MACH_SUN8I || ARM64 || RISCV || COMPILE_TEST
 
 config SUN8I_A23_CCU
 	tristate "Support for the Allwinner A23 CCU"
-	default MACH_SUN8I
+	default y
 	depends on MACH_SUN8I || COMPILE_TEST
 
 config SUN8I_A33_CCU
 	tristate "Support for the Allwinner A33 CCU"
-	default MACH_SUN8I
+	default y
 	depends on MACH_SUN8I || COMPILE_TEST
 
 config SUN8I_A83T_CCU
 	tristate "Support for the Allwinner A83T CCU"
-	default MACH_SUN8I
+	default y
 	depends on MACH_SUN8I || COMPILE_TEST
 
 config SUN8I_H3_CCU
 	tristate "Support for the Allwinner H3 CCU"
-	default MACH_SUN8I || ARM64
+	default y
 	depends on MACH_SUN8I || ARM64 || COMPILE_TEST
 
 config SUN8I_V3S_CCU
 	tristate "Support for the Allwinner V3s CCU"
-	default MACH_SUN8I
+	default y
 	depends on MACH_SUN8I || COMPILE_TEST
 
 config SUN8I_DE2_CCU
 	tristate "Support for the Allwinner SoCs DE2 CCU"
-	default MACH_SUN8I || ARM64
+	default y
+	depends on MACH_SUN8I || ARM64 || RISCV || COMPILE_TEST
 
 config SUN8I_R40_CCU
 	tristate "Support for the Allwinner R40 CCU"
-	default MACH_SUN8I
+	default y
 	depends on MACH_SUN8I || COMPILE_TEST
 
 config SUN9I_A80_CCU
 	tristate "Support for the Allwinner A80 CCU"
-	default MACH_SUN9I
+	default y
 	depends on MACH_SUN9I || COMPILE_TEST
 
 config SUN8I_R_CCU
 	tristate "Support for Allwinner SoCs' PRCM CCUs"
-	default MACH_SUN8I || ARM64
+	default y
+	depends on MACH_SUN8I || ARM64 || COMPILE_TEST
 
 endif
-- 
2.37.4

