Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27D576A6A3A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 10:56:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbjCAJ4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 04:56:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbjCAJzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 04:55:38 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 106EF1A95E;
        Wed,  1 Mar 2023 01:55:37 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C16D566020E0;
        Wed,  1 Mar 2023 09:55:34 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1677664535;
        bh=/37a11W4Djj29RkQI1F06mX5BvaAyxmllH1tjzesJsU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T7hJnrRxggsAGfxiujww0LUFHX5pGFVS4hmjQnSH/tVaz8Qh7qZ7s95kwI+W9q+z0
         4rfqlSt9wJVMmkfjW6hap4fdiNZifTi7JnE1FQ+eSSJ8xfnSJciqOR/athpali235A
         vWd3XzYyWCmPXV9aT9RvGZp0pKVIvkX5ENsaoMXu8HWfxaL1fOVvIANheRLL/ceHBw
         Qi8b3ndnG3iWTrR/m3T6492/ACaed+E1dao1dRucN44ec6YUkCVJ+OeUMzSiBUrPul
         Y47EzxMxoS44gkONhhb4Pc7iX0DtHX0DPsvgRFWwUkeTp4+etuApG+/mo72qdz2dau
         aWTGfa/hz5Q6w==
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
Subject: [PATCH v4 09/19] arm64: dts: mediatek: mt8192-asurada: Add MFG0 domain supply
Date:   Wed,  1 Mar 2023 10:55:13 +0100
Message-Id: <20230301095523.428461-10-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230301095523.428461-1-angelogioacchino.delregno@collabora.com>
References: <20230301095523.428461-1-angelogioacchino.delregno@collabora.com>
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
Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
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
index a29cdff8a095..f19d4a8ef3f6 100644
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

