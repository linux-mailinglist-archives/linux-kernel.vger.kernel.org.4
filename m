Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98D5A639818
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 20:13:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbiKZTNe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 14:13:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiKZTN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 14:13:26 -0500
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 579C26249;
        Sat, 26 Nov 2022 11:13:24 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 570B55C0092;
        Sat, 26 Nov 2022 14:13:24 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Sat, 26 Nov 2022 14:13:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1669490004; x=1669576404; bh=II
        QnEU1ApCpzmmFpwW0kJws1Kx0hjhSPmbG71lo6d3w=; b=tx86Rio4gV+A61C65Z
        hPIZdg99YSLfe5e5y7FabW/3+YpJ4IYtFctY7nrU8qe5qC1bTDG7M+SCWczRNM4+
        CEXYJWZge0kXXZBYxLRmMAZyj9nmvuortT3IplifFu+8gE2/Vni7s1H9M36dlVmM
        nEWUjqVN6iuDxHj8Bpql0Z86lWdYFcLzCBGjQIHTJ7vyxJ9emRv+l3T2gzsJFFcJ
        r5RkV5o+DMpq4i8lwxu6KSTIIJ+XKZcPlerGZn268sob/AZXqQN2RSfw6MK/WDXk
        Cb9rDx1lCOvBNY7YbDY/02pgd05pnQWyzHpe8FnKY8aUrsXyB4coMtsBvnBwkmTa
        Xliw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1669490004; x=1669576404; bh=IIQnEU1ApCpzm
        mFpwW0kJws1Kx0hjhSPmbG71lo6d3w=; b=riqM1hOcmGIrWu874dr1sy4wqBMQr
        yCH0/DUzwWL2IVFupFsCAxW644mrtUKOEiVhGROmPpKvqymJ3jKEJ+7LsW9hvkBF
        02exr/M6qr1uXFNp9ySBKfTM9yjGds7F4IV0O46llZ264SZl6ob9Tg4qXdmmL306
        XVwBt/heLwTkju8TU2GSN0lwBfqF/vskNq2ipPWGTu/G8C2x7Q050FRdEaKAqUa5
        3PFMD+wIrsm9lYTksCQcSRxN9YcoNn7viAH92NDhocTPLXquUlnbfc+hcBKWAMHJ
        f9dzUdBh/X0jq0zHKAMGNIjVzhkihTUEYvJlH26/jFc3/wukiRsYrio7w==
X-ME-Sender: <xms:U2WCY-sJWvh2l84tsSvqhiJ0e4bQXTSjko2xrEO5GQqKRfQ6BpZSWg>
    <xme:U2WCYzd32dkv28wfdsw4f0DNZhFrDxWWJY2gRWG2WXzUgHTThquAa1OwbL_9E1TJw
    L77av7ThP7ARo32iw>
X-ME-Received: <xmr:U2WCY5yEx7KzfgUiCtcTpfRJmue58yDZQl4SaG8CPg8vf-u8KEwZNqo0xvdVj3jonNiOvV_I-fly8BpWYqZIVyr4aH-lB2zIYR5RRqvewYCunxMExPYW6AylEHW--DP9HPk7Ww>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrieejgdduvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepudekteeuudehtdelteevgfduvddvjefhfedulefgudevgeeghefg
    udefiedtveetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:VGWCY5MKyyysNYF-GRV0IfsG09WeAObvVTAoU-tivUZUI-uh4IMKew>
    <xmx:VGWCY-9Wu_N0VDFL5JjUEUkcMSmjTXwK25jqRJh4ipeb5fG5C3OHBQ>
    <xmx:VGWCYxVaGf5HnR6W3UOZVW0rODpYUgkPc5BcGH0kqR5A74LiZhsu8g>
    <xmx:VGWCYxUcPqdamPq_UCX1Vx9SjDA2oundtHWvSnYX4tZfT98eyNGvVg>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 26 Nov 2022 14:13:23 -0500 (EST)
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
Subject: [PATCH 2/5] clk: sunxi-ng: Move SoC driver conditions to dependencies
Date:   Sat, 26 Nov 2022 13:13:16 -0600
Message-Id: <20221126191319.6404-3-samuel@sholland.org>
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

Do not duplicate the same expression on the `default` line, so the two
lines do not need to be kept in sync. Drivers stay disabled under
COMPILE_TEST because of the `default ARCH_SUNXI` applied to SUNXI_CCU.

Three drivers had no conditions.
 - SUN6I_RTC_CCU and SUN8I_DE2_CCU are used on current hardware
   regardless of CPU architecture.
 - SUN8I_R_CCU is only used on pre-H6 SoCs, which means no RISCV SoCs.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

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

