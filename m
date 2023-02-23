Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DCB76A0AEF
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 14:44:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234653AbjBWNoW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 08:44:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233157AbjBWNoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 08:44:01 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E38A55190B;
        Thu, 23 Feb 2023 05:44:00 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4182B660220D;
        Thu, 23 Feb 2023 13:43:59 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1677159839;
        bh=xAp8H2hVhd7urTj86UlUSbK9LB5eP77m4/nFArJQr+s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BXpHl2GJD8EjzIABLdfe2cxa8PVrmn5m/9ru9rR2XZoZODWb6nA3ZXAKqGJjUj7nC
         2QGK97fbrcZKjxH58Ga9BfTOUwoC7nyNIHeAxGb5PGZGf5ERzlXuaCNuDP5VtEhhJp
         gSqilcMZrkwT8UiWt16tTFcyrQla0DgtBx5Qrqn6OodDRadOZBgMDeUesPM/qbOmy/
         Wy3NnOdRf00hpwaaiZ49dtAzvQZYALx27n+Fpu7//NGJ/X9Vw3i1ejC+99Ak9ujsIy
         WXUk1euFgHXIoztqm6G5Ym7sKIUqPuwNDj89poW7JyLRZVEO6jrNdLcYqiYJLKleFf
         t4vluZ/JK87Fw==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        angelogioacchino.delregno@collabora.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, wenst@chromium.org
Subject: [PATCH v2 06/16] arm64: dts: mediatek: mt8183: Use mediatek,mt8183b-mali as GPU compatible
Date:   Thu, 23 Feb 2023 14:43:35 +0100
Message-Id: <20230223134345.82625-7-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230223134345.82625-1-angelogioacchino.delregno@collabora.com>
References: <20230223134345.82625-1-angelogioacchino.delregno@collabora.com>
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
2.39.2

