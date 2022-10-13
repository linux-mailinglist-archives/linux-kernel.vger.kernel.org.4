Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA4E85FDD0D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 17:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbiJMPW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 11:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiJMPWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 11:22:22 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA68010F8AB;
        Thu, 13 Oct 2022 08:22:21 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8F7166602369;
        Thu, 13 Oct 2022 16:22:19 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1665674540;
        bh=sHR9hQ308Hig3a4nvi1jX0nnafCsL5l6MhkjxYPM6T0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aEChSI6KoSB8QZHNDonu+dSB8IQ0hLxCm2DIwfgZ5L3Ky4DCOKM55iEJrR5ZzkoOU
         3BbpLh2OCNXI2k2zpRAOsFIV+RwEQgYj/LY/Ab35RaP1n5LRghU/AYRms6QdHsTy+H
         7IITjdUTC1Zd+psmICFBJ3jxzfPS8lWIL6MI2TLP+WLLwBuMShDx0il3yqv0LeYzmO
         meKAvP5+iijrS5krbVlLasd1rhNrit47EXjUVzbzzeHD+nUJCK+JjXhCf5x+EqrXTR
         4kC4/WxbfaHW2dL3X9ciQmO+0+AzvWeiu3aepWe8J3eKQFsJfyU2AhBuVFsDPTNXp4
         6uDOsmj8aXpNw==
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
Subject: [PATCH 1/8] arm64: dts: mt7896a: Fix unit_address_vs_reg warning for oscillator
Date:   Thu, 13 Oct 2022 17:22:05 +0200
Message-Id: <20221013152212.416661-2-angelogioacchino.delregno@collabora.com>
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

Rename the oscillator fixed-clock to oscillator-40m and remove
the unit address to fix warnings.

arch/arm64/boot/dts/mediatek/mt7986a.dtsi:17.23-22.4: Warning
(unit_address_vs_reg): /oscillator@0: node has a unit name,
but no reg or ranges property

Fixes: 1f9986b258c2 ("arm64: dts: mediatek: add clock support for mt7986a")
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt7986a.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt7986a.dtsi b/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
index 72e0d9722e07..599eb50c8a5b 100644
--- a/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
@@ -14,7 +14,7 @@ / {
 	#address-cells = <2>;
 	#size-cells = <2>;
 
-	clk40m: oscillator@0 {
+	clk40m: oscillator-40m {
 		compatible = "fixed-clock";
 		clock-frequency = <40000000>;
 		#clock-cells = <0>;
-- 
2.37.2

