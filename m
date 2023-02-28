Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC49E6A570F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 11:48:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbjB1KsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 05:48:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbjB1Kr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 05:47:56 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFA5B423F;
        Tue, 28 Feb 2023 02:47:54 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C902D6602FDD;
        Tue, 28 Feb 2023 10:47:52 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1677581273;
        bh=7nrUbCRYVnwYMTUi2s51QYeV3DhvJQJoBM8PfyrS3Ok=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AdrM3BuVZzfiKKrYYkFPomdI7sp+7R98ThxfEuzos9BLkOXV4Y202LwUlimO5rp5g
         1yxBPpnu07eB1MuQhc9/fqvuLWPiwyhtkwe/6r+JSectev19ZNrmaQNemuMTc5+GRB
         pELshWUNgV4trouIlEFAmLeOz4IE5nw/cPU3cMwBT4bCPZndvKcUnaXQsvfjtpDmCu
         45nULDczz1ts90NEc0e1Lm9qXRgyyCwJZEgs9GxaKtw1JouNAHW3U/PU3XtdBTajO5
         n2Prbgj13wA4R6LphJuDRTUwYYkOeu68I2W9t/x+zlm8R+4hX5MIE+TXwa6oRw95C5
         z/CIDWEtXTyLg==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        angelogioacchino.delregno@collabora.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, wenst@chromium.org
Subject: [PATCH v3 06/18] arm64: dts: mediatek: mt8183: Use mediatek,mt8183b-mali as GPU compatible
Date:   Tue, 28 Feb 2023 11:47:29 +0100
Message-Id: <20230228104741.717819-7-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230228104741.717819-1-angelogioacchino.delregno@collabora.com>
References: <20230228104741.717819-1-angelogioacchino.delregno@collabora.com>
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
Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
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

