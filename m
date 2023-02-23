Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E74C6A0AF1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 14:44:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234634AbjBWNob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 08:44:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234395AbjBWNoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 08:44:05 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED3FD567BD;
        Thu, 23 Feb 2023 05:44:02 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4ABBB660220B;
        Thu, 23 Feb 2023 13:44:01 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1677159841;
        bh=ycGpdrBlx/uJtZOtOoxWkcwFaJ2ZAw9Ng7FysdL11fE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oKlgofuEaQjFberftOuu7Q5HzbsWGzBvcdjx4/kF2VantqiM6m7AWmJDxmIEQ7+dh
         HZrVOTVh2mDBTRdpCG7NQF1dMH2GAVdgTzCj+nZgha/Rln9mDVpYpoy32kplF5EPoh
         Sl2prOVV2wSD15wkyoN8LcHbbDZ3rWNzSu5CI6YLFFBhUAD1pdpixr+lm35heMUgND
         xA8PVu3HlKOmuddBwcH/EL5qd0ueAXpJGSgVw7ehMXt3Eby+G5Y109UnNefg60IfFQ
         tV1uCJngaZWfLZDoZ5YERtpCKak6tynbe8p6GMTsApogr316YfZiNQ2KEWbXSGVthT
         +qCQoFCFhyKmQ==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        angelogioacchino.delregno@collabora.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, wenst@chromium.org,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
Subject: [PATCH v2 09/16] arm64: dts: mediatek: mt8192-asurada: Add MFG0 domain supply
Date:   Thu, 23 Feb 2023 14:43:38 +0100
Message-Id: <20230223134345.82625-10-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230223134345.82625-1-angelogioacchino.delregno@collabora.com>
References: <20230223134345.82625-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nícolas F. R. A. Prado <nfraprado@collabora.com>

The mfg0 power domain encompasses the whole GPU and its surrounding
glue logic. This power domain has a separate power rail.

Add its power supply for Asurada.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
[wenst@chromium.org: fix subject prefix and add commit message]
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
[Angelo: Reordered commits to address DVFS stability issues]
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi | 4 ++++
 arch/arm64/boot/dts/mediatek/mt8192.dtsi         | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
index 9f12257ab4e7..ec013d5ef157 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
@@ -380,6 +380,10 @@ &i2c7 {
 	pinctrl-0 = <&i2c7_pins>;
 };
 
+&mfg0 {
+	domain-supply = <&mt6315_7_vbuck1>;
+};
+
 &mipi_tx0 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
index 018d48f7d3c6..d536fe5f33a0 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
@@ -497,7 +497,7 @@ power-domain@MT8192_POWER_DOMAIN_CONN {
 					#power-domain-cells = <0>;
 				};
 
-				power-domain@MT8192_POWER_DOMAIN_MFG0 {
+				mfg0: power-domain@MT8192_POWER_DOMAIN_MFG0 {
 					reg = <MT8192_POWER_DOMAIN_MFG0>;
 					clocks = <&topckgen CLK_TOP_MFG_PLL_SEL>,
 						 <&topckgen CLK_TOP_MFG_REF_SEL>;
-- 
2.39.2

