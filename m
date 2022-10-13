Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39D595FDD16
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 17:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbiJMPWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 11:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbiJMPW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 11:22:29 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49FA0127905;
        Thu, 13 Oct 2022 08:22:27 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id EA99A6602370;
        Thu, 13 Oct 2022 16:22:24 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1665674545;
        bh=OIVvm9eZZnDpMulbdkAjAXAZiIM5QtEjlxZKqlbUhN4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KnNC2aRr1CuewZByFW/jeStIoRR+cQKvdAc1e4Nr2itAlV18cP5mtMa9/jxqaXSCk
         sgucXlPqmUQ47m2fAIT7AQdgdzJBYjEhSb6x2GSRHfIAT8lqfkvfvOWpWWnqNbOX5R
         HLnmKQp34796JcP+uEprJMy9hi1xfJ7XAxHvejEe38Azb+Dy3I337s0zFX+7Cx7bQ5
         Vjoa+sBjwjdt3ceInjCKF7zVfYwrKY4sokMPBiWCfs10FIMwfxtOX3P/wTsQNaa1ou
         hx84eKrCmDIiZq4AiXSoZGCiEsU/VhmpBDvsJpqFuIQGLm/DnMboJA9tC+valF/VmF
         7Y+up0VvDk0rg==
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
Subject: [PATCH 6/8] arm64: dts: mt2712-evb: Fix usb vbus regulators unit names
Date:   Thu, 13 Oct 2022 17:22:10 +0200
Message-Id: <20221013152212.416661-7-angelogioacchino.delregno@collabora.com>
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

Update the names to regulator-usb-p{0-3}-vbus to fix unit_address_vs_reg
warnings for those.

Fixes: 1724f4cc5133 ("arm64: dts: Add USB3 related nodes for MT2712")
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt2712-evb.dts | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt2712-evb.dts b/arch/arm64/boot/dts/mediatek/mt2712-evb.dts
index 638908773706..d31a194124c9 100644
--- a/arch/arm64/boot/dts/mediatek/mt2712-evb.dts
+++ b/arch/arm64/boot/dts/mediatek/mt2712-evb.dts
@@ -50,7 +50,7 @@ extcon_usb1: extcon_iddig1 {
 		id-gpio = <&pio 14 GPIO_ACTIVE_HIGH>;
 	};
 
-	usb_p0_vbus: regulator@2 {
+	usb_p0_vbus: regulator-usb-p0-vbus {
 		compatible = "regulator-fixed";
 		regulator-name = "p0_vbus";
 		regulator-min-microvolt = <5000000>;
@@ -59,7 +59,7 @@ usb_p0_vbus: regulator@2 {
 		enable-active-high;
 	};
 
-	usb_p1_vbus: regulator@3 {
+	usb_p1_vbus: regulator-usb-p1-vbus {
 		compatible = "regulator-fixed";
 		regulator-name = "p1_vbus";
 		regulator-min-microvolt = <5000000>;
@@ -68,7 +68,7 @@ usb_p1_vbus: regulator@3 {
 		enable-active-high;
 	};
 
-	usb_p2_vbus: regulator@4 {
+	usb_p2_vbus: regulator-usb-p2-vbus {
 		compatible = "regulator-fixed";
 		regulator-name = "p2_vbus";
 		regulator-min-microvolt = <5000000>;
@@ -77,7 +77,7 @@ usb_p2_vbus: regulator@4 {
 		enable-active-high;
 	};
 
-	usb_p3_vbus: regulator@5 {
+	usb_p3_vbus: regulator-usb-p3-vbus {
 		compatible = "regulator-fixed";
 		regulator-name = "p3_vbus";
 		regulator-min-microvolt = <5000000>;
-- 
2.37.2

