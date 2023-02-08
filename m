Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22CD668ED48
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 11:46:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbjBHKqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 05:46:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbjBHKqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 05:46:06 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ADE3A247;
        Wed,  8 Feb 2023 02:45:52 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1DBC3660209D;
        Wed,  8 Feb 2023 10:45:39 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1675853139;
        bh=Kyw2J37yTMs+/IFvIgq6RScB8xGutn0waYPGo+ad3gc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mdMKI0XCYWOhNvof5hBIFwXJUvk9MzRLZC/RzM0UbxJPth8f1ceEu1P/rrMv08dvj
         QTLnGz61+Am649UnQQRL3z1vgKDccBjKXs7LAAp4w1d4Ce2tcuVGhR020aOrnxrtQG
         v4d1qeAH+K6Vb/5nva8X3T2cKgac829z6pm5exAcnpAMdf0D1Ew7Hi+WRxe2T3nVGj
         SBvnyJLqFK57rRmYDIOCVOCsiJXxtdFQwjJJdL2hjja8hjFvalj+vXzEkG9HMc1jzA
         0YC+E0QBzQvRFqts1r6QTnLR2hGBXSp6bFt6NGzlKFuY3QICLo2YtMe95bs09Hwphc
         Xj6yRdkExi5oQ==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        angelogioacchino.delregno@collabora.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, wenst@chromium.org
Subject: [PATCH 06/16] arm64: dts: mediatek: mt8183: Use mediatek,mt8183b-mali as GPU compatible
Date:   Wed,  8 Feb 2023 11:45:17 +0100
Message-Id: <20230208104527.118929-7-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230208104527.118929-1-angelogioacchino.delregno@collabora.com>
References: <20230208104527.118929-1-angelogioacchino.delregno@collabora.com>
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

Use the new GPU related compatible to finally enable GPU DVFS on
the MT8183 SoC.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt8183.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
index e01b96adef02..5169779d01df 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
@@ -1752,7 +1752,7 @@ mfgcfg: syscon@13000000 {
 		};
 
 		gpu: gpu@13040000 {
-			compatible = "mediatek,mt8183-mali", "arm,mali-bifrost";
+			compatible = "mediatek,mt8183b-mali", "arm,mali-bifrost";
 			reg = <0 0x13040000 0 0x4000>;
 			interrupts =
 				<GIC_SPI 280 IRQ_TYPE_LEVEL_LOW>,
-- 
2.39.1

