Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D35D95FDD10
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 17:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbiJMPWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 11:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiJMPWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 11:22:25 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C452210F8BF;
        Thu, 13 Oct 2022 08:22:23 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B4422660236B;
        Thu, 13 Oct 2022 16:22:21 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1665674542;
        bh=Q47jzu6AFAqzuRbrbtB0DzD1vaAnfZtqPNh3CnQRK0E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X3vVsCOxxpri1Kk51lnYaqJ5Ny2Ppv16aGMzUVCFACJQmR/yIH1UeZFATRZyf4bII
         OLQ6P5hZhEhvZmqy8bKK/dcjM0OAv+3X155aZxJBl6NmomQXTqMXMm+O8/IwT++DNV
         nkc5uNQqq535MPugTQS4pdazze5TMnm8eYFgXEDverkgRBCoYZkQVPMMwUeR26hBYd
         5mT8mZOPOAgfn61itpTXK3ZJv/FtoXcYky90EdgIK6f/bBnvmHjKvBUebWbeNhRivf
         wsCXZ2jqwyD/DOJCzkVkle66mbQ71cDz499JjeeJ9uLWQ1q0+axMfm9SAvoEQ27bvF
         azevhRmfcku5A==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        sam.shih@mediatek.com, hanks.chen@mediatek.com,
        weiyi.lu@mediatek.com, zhiyong.tao@mediatek.com,
        andrew-sh.cheng@mediatek.com, viresh.kumar@linaro.org,
        chunfeng.yun@mediatek.com, fparent@baylibre.com,
        mars.cheng@mediatek.com, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH 3/8] arm64: dts: mt2712e: Fix unit_address_vs_reg warning for oscillators
Date:   Thu, 13 Oct 2022 17:22:07 +0200
Message-Id: <20221013152212.416661-4-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221013152212.416661-1-angelogioacchino.delregno@collabora.com>
References: <20221013152212.416661-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the fixed-clock oscillators to remove the unit address.

This solves unit_address_vs_reg warnings.

Fixes: 5d4839709c8e ("arm64: dts: mt2712: Add clock controller device nodes")
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt2712e.dtsi | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt2712e.dtsi b/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
index e6d7453e56e0..ff6b26cdda81 100644
--- a/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
@@ -160,70 +160,70 @@ sys_clk: dummyclk {
 		#clock-cells = <0>;
 	};
 
-	clk26m: oscillator@0 {
+	clk26m: oscillator-26m {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <26000000>;
 		clock-output-names = "clk26m";
 	};
 
-	clk32k: oscillator@1 {
+	clk32k: oscillator-32k {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <32768>;
 		clock-output-names = "clk32k";
 	};
 
-	clkfpc: oscillator@2 {
+	clkfpc: oscillator-50m {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <50000000>;
 		clock-output-names = "clkfpc";
 	};
 
-	clkaud_ext_i_0: oscillator@3 {
+	clkaud_ext_i_0: oscillator-aud0 {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <6500000>;
 		clock-output-names = "clkaud_ext_i_0";
 	};
 
-	clkaud_ext_i_1: oscillator@4 {
+	clkaud_ext_i_1: oscillator-aud1 {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <196608000>;
 		clock-output-names = "clkaud_ext_i_1";
 	};
 
-	clkaud_ext_i_2: oscillator@5 {
+	clkaud_ext_i_2: oscillator-aud2 {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <180633600>;
 		clock-output-names = "clkaud_ext_i_2";
 	};
 
-	clki2si0_mck_i: oscillator@6 {
+	clki2si0_mck_i: oscillator-i2s0 {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <30000000>;
 		clock-output-names = "clki2si0_mck_i";
 	};
 
-	clki2si1_mck_i: oscillator@7 {
+	clki2si1_mck_i: oscillator-i2s1 {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <30000000>;
 		clock-output-names = "clki2si1_mck_i";
 	};
 
-	clki2si2_mck_i: oscillator@8 {
+	clki2si2_mck_i: oscillator-i2s2 {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <30000000>;
 		clock-output-names = "clki2si2_mck_i";
 	};
 
-	clktdmin_mclk_i: oscillator@9 {
+	clktdmin_mclk_i: oscillator-mclk {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <30000000>;
-- 
2.37.2

