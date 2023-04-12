Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B01316DF3AC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 13:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231495AbjDLLaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 07:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231570AbjDLL3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 07:29:12 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28485185;
        Wed, 12 Apr 2023 04:28:22 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 04496660328E;
        Wed, 12 Apr 2023 12:28:17 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1681298899;
        bh=VzMpC2ylIvPbeGRaM8hTndNXA0jJmN7L511Odi3RhPk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NXvDtQJ37lxvR/koYZz67/GC+4r1u9X0Qh/yvf8gDT6BI9s/W+l4B0js3i6aGEQpb
         4U+O5sQJBxuWwmFqisqL4TrC3Eghy10zEK0IzMV73BsVJcphsVZTBHBt1JrHgerCrA
         55LDUQ9x6w9zIbc5nbZaDtp50KHbE/tXfA/heWMSShd8dHZIaKDziqcYCMcxAFxakU
         9QdIQoLtXP0CYrbZlFWhPD4vgrrUteqwW+cZyjKBBfZfNwV8aWqtnJeDLfZjGrz10a
         JQoruXQ0qNStVKMPgLuVft6us1VVthVll1SqrStJpmjY8mb1Lm51Y7c2NZRgPWwh/z
         sZdyM2NTdjcew==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        jassisinghbrar@gmail.com, chunfeng.yun@mediatek.com,
        vkoul@kernel.org, kishon@kernel.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, chunkuang.hu@kernel.org,
        angelogioacchino.delregno@collabora.com, ck.hu@mediatek.com,
        jitao.shi@mediatek.com, xinlei.lee@mediatek.com,
        houlong.wei@mediatek.com, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org, linux-pwm@vger.kernel.org,
        kernel@collabora.com, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: [PATCH 24/27] arm64: dts: mediatek: mt6795-xperia-m5: Add MT6331 Combo PMIC
Date:   Wed, 12 Apr 2023 13:27:36 +0200
Message-Id: <20230412112739.160376-25-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230412112739.160376-1-angelogioacchino.delregno@collabora.com>
References: <20230412112739.160376-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This smartphone uses the Helio X10 standard MT6331+MT6332 combo PMICs:
include the mt6331 devicetree and add the required interrupt.

Note that despite there being two interrupts, one for MT6331 and one
for MT6332, in configurations using the companion PMIC, the interrupt
of the latter fires for both events on MT6331 and for ones on MT6332,
while the interrupt for the main PMIC fires only for events of the
main PMIC.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt6795-sony-xperia-m5.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt6795-sony-xperia-m5.dts b/arch/arm64/boot/dts/mediatek/mt6795-sony-xperia-m5.dts
index a0e01a756f03..debe0f2553d9 100644
--- a/arch/arm64/boot/dts/mediatek/mt6795-sony-xperia-m5.dts
+++ b/arch/arm64/boot/dts/mediatek/mt6795-sony-xperia-m5.dts
@@ -7,6 +7,7 @@
 /dts-v1/;
 #include <dt-bindings/gpio/gpio.h>
 #include "mt6795.dtsi"
+#include "mt6331.dtsi"
 
 / {
 	model = "Sony Xperia M5";
@@ -219,6 +220,15 @@ pins-tx {
 	};
 };
 
+&pmic {
+	/*
+	 * Smartphones, including the Xperia M5, are equipped with a companion
+	 * MT6332 PMIC: when this is present, the main MT6331 PMIC will fire
+	 * an interrupt on the companion, so we use the MT6332 IRQ GPIO.
+	 */
+	interrupts = <GIC_SPI 160 IRQ_TYPE_LEVEL_HIGH>;
+};
+
 &uart0 {
 	status = "okay";
 
-- 
2.40.0

