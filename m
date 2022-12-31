Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A863365A80A
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Jan 2023 00:14:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235854AbiLaXOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 18:14:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232148AbiLaXOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 18:14:35 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D7E8C3E;
        Sat, 31 Dec 2022 15:14:33 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 563015C00B6;
        Sat, 31 Dec 2022 18:14:32 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sat, 31 Dec 2022 18:14:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1672528472; x=1672614872; bh=Oc
        Gtkt9Bv14YYpUDrmReERXmRLK8ON2avWRPl23IvSg=; b=biHwDqWNILuLJNtQYg
        3j1fb0k21jDb4Ko5o6IDmurbl2UjIiIOuvZUYy+vO2OPeI6vWObUOog46/W0ULOp
        Yr/25fV5oSosLtv73BrYbqEEjnz8rsYK4aqvih8fnfNudCCgriRteLtVU71avP23
        Y4CDPhiK/EOtq2IPySjRHtl3l1otd4tefxiaQawVQB3IwTA7OQ3ihtjmCSpDB/DQ
        AAlwACYwp9A+XTv2+Ep8qWvqk5OhFV1WIM9YqBUEyOhGLzwX8vF8sCYGJQGsivg9
        AaeS6OIAvObrYzLsRCeC3U6qe85FK4XmrpoXfagCvsAgQ0FoxYgsMAgMrGZofRCq
        Naiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1672528472; x=1672614872; bh=OcGtkt9Bv14YY
        pUDrmReERXmRLK8ON2avWRPl23IvSg=; b=r2DkBNYttsQ7FkZcACYJmfYfh2hlg
        /R55ReEj+mldF4kcsUqYiLfQzwkJ+IpoBgrZubXT3vud+5reWx2PiUpi9oly+LJI
        VkZOaohaiitzwzMz+P/Kg1bO4415JEO81KYDGNBI/HYL9AqHCFkdmPdPtg5So53h
        JGCagO23gh23MHylSbp8Lp2q++l3TbXlatSUG3ymz8JH6z6xFmIXudNtTbBZ0qF3
        kh3o7/GLuEvGMAu99K8ekfK+ZD29Hzm5i+cwKofMMf7s6zya9nTONDtZK9ABsEze
        CBiZ/OAiKTVDIJ/qmK3WwJ8RnjMLI1e8y3J8OhmBQ2M39NTZuvJtPDyCg==
X-ME-Sender: <xms:WMKwY-RNRV1nJ17aPOjEv-D_ChyaI5Olg-W977LtlmFYYNfx5I04ag>
    <xme:WMKwYzweo8g6dUCnDuahU23lb8CG3zHke6kfO7KOln0XHjoDdhmJ5NZ5xvLz_7XWI
    WUIcabpk6t0E6xlqg>
X-ME-Received: <xmr:WMKwY70fTtlISru6XN466V015zQaze06J08Zwr38key68vk1vg1IjPUdM4jESXtFmCPJlmnagklHFrx3ujaFHP0ZGE5IXA4o6x8_D9bpwWF2W4gjqP6XwauvlR6o-TJ_fFsBkA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrieelgddtlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpedukeetueduhedtleetvefguddvvdejhfefudelgfduveeggeehgfdu
    feeitdevteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:WMKwY6C95iMYnz4kv-zxQSvuKHc6yhWuLJEZguQyeB5nkDUcgCG8Eg>
    <xmx:WMKwY3hBYGOmdzIsox-HGBR6Tpl7JT8Y3t37vhQuMFu8IkI2jlcLgQ>
    <xmx:WMKwY2pMVLbU4fVsktzt76wHMFeFILX5JDn2dMiRhvIGQTk5W8x0KA>
    <xmx:WMKwY3wyiB7SCGNT93bnZPrMt0oATMKZUIk3E3z_zvxogjgGdhdR3A>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 31 Dec 2022 18:14:31 -0500 (EST)
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
Subject: [PATCH v2 1/6] clk: sunxi-ng: Remove duplicate ARCH_SUNXI dependencies
Date:   Sat, 31 Dec 2022 17:14:24 -0600
Message-Id: <20221231231429.18357-2-samuel@sholland.org>
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

SUNXI_CCU already depends on ARCH_SUNXI, so adding the dependency to
individual SoC drivers is redundant. Drivers stay disabled under
COMPILE_TEST because of the `default ARCH_SUNXI` applied to SUNXI_CCU.

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
Signed-off-by: Samuel Holland <samuel@sholland.org>
---

(no changes since v1)

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

