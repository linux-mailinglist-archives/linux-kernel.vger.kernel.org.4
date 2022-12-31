Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7E2765A814
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Jan 2023 00:14:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbiLaXOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 18:14:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235846AbiLaXOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 18:14:36 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBBE9C3E;
        Sat, 31 Dec 2022 15:14:35 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 36F815C00B7;
        Sat, 31 Dec 2022 18:14:35 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sat, 31 Dec 2022 18:14:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1672528475; x=1672614875; bh=My
        wK8XQVIROQv4XXNUdTIm5OEV55VdZpoN7GvL5f8u8=; b=rfWxAa4pgbnCWGg3Kh
        LAEhDLeOaDs7WO86AkDHFoo5aqSh8OVOU/nF8pEdmYiptvIjKBGAFQAbQSJAktlH
        iaga7IK56L+ZPoWFZsz2CNt6iJF1djWok711wW4QTIvjYfLXPhMMlIRf/ykagTQf
        Aw2E5vaUgZfHtKIDNvu69XEAARG69l4bQ/UHlm/Wwlzk0rI+3B4uRcYjk6ACmjp1
        Y9r2Q9iQxuPHXcQ1FdGwCd12A1b01JYNvNQMEpQBUCKulca1dvXrj7HK7tmVTjna
        Xpde936a/zgvB+lHZGOP+q9aZQ1+FmeZOi30IMQ4UEQp0IXOFs9vmb/df8UEsXok
        GrrA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1672528475; x=1672614875; bh=MywK8XQVIROQv
        4XXNUdTIm5OEV55VdZpoN7GvL5f8u8=; b=lEjKy1DT/GdvL+ysODVlLU4xIh9OD
        /oOF72PSUKvXEVLg3PIn0t8yAdvP+UDwSLeH6pF+c0X2RGRtRve4sfROMZ2AEWn8
        RzOu0bFwHrzFk3Rwx4zKNSTsEw2AmfOGP6OGbsJsH86T7jpPWps5i030FdmSmZCZ
        dRt6i2iBEol194HlazU7MFj34hPB2l9az5kyMkFYCQ+4+d9YgsslZcZBSMcminss
        3HTtUA2my1GjoojhC7PQCPc6V79mn5KVyazQMuGuDv3C6lAyCVbthxHUOW8+JBC2
        NH51uNffONqMydL/sLE81nQQDuvwU0ymWokISkiOljaerbstQTbQjnskw==
X-ME-Sender: <xms:WsKwYwZcjSqTuMtiOGxQGKXtKMacDKgNgN_xojfiI7q73o4mUNaNWA>
    <xme:WsKwY7auW3C3VEJRjS-gSHL6GGs1ajRatd6RSsoAd7ZC8s0aXJ67BGDSD3h2sN07L
    e-ZVVEVu-gMp-TM3Q>
X-ME-Received: <xmr:WsKwY68_KRHNXoZVpdL_noomz0xMbImjOQVaF50BHbrBS1gaIJ64J745s1Y0h3mn_9S_tkR8dkDNHWUyubGUIqxRnMKQIIvKZ4ghsK9VgKsJv9VkCBb0asELfYWiWnqCfFfU1g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrieelgddtlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpedukeetueduhedtleetvefguddvvdejhfefudelgfduveeggeehgfdu
    feeitdevteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:WsKwY6rD_hnUmCSN4LGNtKi6beVmzJ-mkHmuntjX4Giqt-TaE_uRLw>
    <xmx:WsKwY7rPP_5d-Vsz3Ydn-vOlyhzCKFF_0JLL2AO-Z3mwrGdUYvJV0A>
    <xmx:WsKwY4QqK-IAC0NFXh2B26rdBslXjGiXIO70bIjHp0bXKgaNwuT5AA>
    <xmx:W8KwYxaEg_Z29y6qZ2ThOqD6AQkLhQElO3pqK_aItnb3yYeRhBefRg>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 31 Dec 2022 18:14:33 -0500 (EST)
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
        linux-sunxi@lists.linux.dev,
        Andre Przywara <andre.przywara@arm.com>
Subject: [PATCH v2 3/6] clk: sunxi-ng: d1: Allow building for R528/T113
Date:   Sat, 31 Dec 2022 17:14:26 -0600
Message-Id: <20221231231429.18357-4-samuel@sholland.org>
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

Allwinner released some 32-bit ARM (sun8i) SoCs which use the same CCU
as D1. Allow them to reuse the driver.

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
Reviewed-by: Andre Przywara <andre.przywara@arm.com>
Signed-off-by: Samuel Holland <samuel@sholland.org>
---

(no changes since v1)

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

