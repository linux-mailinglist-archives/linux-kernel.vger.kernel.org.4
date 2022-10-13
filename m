Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8B6C5FDD15
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 17:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbiJMPWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 11:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbiJMPWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 11:22:30 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA664120EE4;
        Thu, 13 Oct 2022 08:22:28 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 06D6E660236E;
        Thu, 13 Oct 2022 16:22:25 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1665674546;
        bh=CSkWVd8BmDjVpIlk/S9C3R40X1S6a2cABTC54a3Nrtg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j9tomOInvoFd2WsL9FZDBnDFc3BYU56eyEK4M5E5t9tjLdXIZ5/fLkUpb7HzuT7Tr
         BEg7S4g854qW+WBohgIan9syw55r9hTvROfgbHeOQY0kQJvQzMe5nD/q38W+eRmLg+
         2NtqMOs/qO4fzLEWj9IF619rsrsiZbwdem6dT/L71MgkIyVtMnr3jT07xqDtonD+HQ
         wpJqnpuwL/dExzYTaqh8bYWmoAlTN1+JreemC5pwNmmzyW2BE660cAYcgqVPBu5+W3
         FO7/PrdnBOi+OHQKj2CNlj+AzI4ZPkivflEBdw4o4FOgjcq8rHNmLBQRDK8h0q+I4a
         BxGLneEMUMZ3g==
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
Subject: [PATCH 7/8] arm64: dts: mediatek: pumpkin-common: Fix devicetree warnings
Date:   Thu, 13 Oct 2022 17:22:11 +0200
Message-Id: <20221013152212.416661-8-angelogioacchino.delregno@collabora.com>
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

Fix the pinctrl submodes and optee node to remove unneeded unit address,
fixing all unit_address_vs_reg warnings.

Fixes: 9983822c8cf9 ("arm64: dts: mediatek: add pumpkin board dts")
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi b/arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi
index 8ee1529683a3..ec8dfb3d1c6d 100644
--- a/arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi
+++ b/arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi
@@ -17,7 +17,7 @@ chosen {
 	};
 
 	firmware {
-		optee: optee@4fd00000 {
+		optee: optee {
 			compatible = "linaro,optee-tz";
 			method = "smc";
 		};
@@ -209,7 +209,7 @@ pins_cmd_dat {
 		};
 	};
 
-	i2c0_pins_a: i2c0@0 {
+	i2c0_pins_a: i2c0 {
 		pins1 {
 			pinmux = <MT8516_PIN_58_SDA0__FUNC_SDA0_0>,
 				 <MT8516_PIN_59_SCL0__FUNC_SCL0_0>;
@@ -217,7 +217,7 @@ pins1 {
 		};
 	};
 
-	i2c2_pins_a: i2c2@0 {
+	i2c2_pins_a: i2c2 {
 		pins1 {
 			pinmux = <MT8516_PIN_60_SDA2__FUNC_SDA2_0>,
 				 <MT8516_PIN_61_SCL2__FUNC_SCL2_0>;
-- 
2.37.2

