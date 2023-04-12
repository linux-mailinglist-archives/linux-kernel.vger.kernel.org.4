Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA4C6DF39D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 13:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231527AbjDLL33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 07:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231526AbjDLL2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 07:28:51 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2DA98A78;
        Wed, 12 Apr 2023 04:28:14 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 65634660322C;
        Wed, 12 Apr 2023 12:28:12 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1681298893;
        bh=FBEtOJ4WIs2BY9QNkotVKZUvt7CQzM53jFa4FvLuaOU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DoAp7wTIj1oqZn671PpiSDWzBbaVQ4ovQGo02MLSH9jh2QhQzCG/mpRMzm0xRzhrr
         v9+b7inz9dkg+vX6tWhbS93utWRW+io95SFdVmlDy/JZ1Oypsn7EF3Zo9KxnWrqQN5
         Ih9qxPG5xZ6/xcjq+KpEWcpHf5SRXFI7GTDfCuKthurFADfPnKBEyLjEV/794Ui4fB
         FFxpuexeNlO4cpeYi+AsEGgPtSGgsrGJ97cHLaOVhv73lN9BStPj/13Tju1jXh/NMr
         ehMlB9AcJcIqYo0loEHD9jY9AOOK9/NgAh41AsuP5iYysfQWtfB3kaz3PffcnP9a9E
         zYnotGletuYNA==
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
Subject: [PATCH 20/27] arm64: dts: mediatek: mt6795: Add tertiary PWM node
Date:   Wed, 12 Apr 2023 13:27:32 +0200
Message-Id: <20230412112739.160376-21-angelogioacchino.delregno@collabora.com>
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

The PWM at 0x11006000 is the tertiary PWM; unlike PWM0, PWM1, this is
not display specific and can be used as a generic PWM controller.

This node is left disabled as usage is board-specific.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt6795.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt6795.dtsi b/arch/arm64/boot/dts/mediatek/mt6795.dtsi
index cf45cb4ad3d2..50d9276d18c6 100644
--- a/arch/arm64/boot/dts/mediatek/mt6795.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt6795.dtsi
@@ -583,6 +583,25 @@ uart3: serial@11005000 {
 			status = "disabled";
 		};
 
+		pwm2: pwm@11006000 {
+			compatible = "mediatek,mt6795-pwm";
+			reg = <0 0x11006000 0 0x1000>;
+			#pwm-cells = <2>;
+			interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_LOW>;
+			clocks = <&topckgen CLK_TOP_PWM_SEL>,
+				 <&pericfg CLK_PERI_PWM>,
+				 <&pericfg CLK_PERI_PWM1>,
+				 <&pericfg CLK_PERI_PWM2>,
+				 <&pericfg CLK_PERI_PWM3>,
+				 <&pericfg CLK_PERI_PWM4>,
+				 <&pericfg CLK_PERI_PWM5>,
+				 <&pericfg CLK_PERI_PWM6>,
+				 <&pericfg CLK_PERI_PWM7>;
+			clock-names = "top", "main", "pwm1", "pwm2", "pwm3",
+				      "pwm4", "pwm5", "pwm6", "pwm7";
+			status = "disabled";
+		};
+
 		i2c0: i2c@11007000 {
 			compatible = "mediatek,mt6795-i2c", "mediatek,mt8173-i2c";
 			reg = <0 0x11007000 0 0x70>, <0 0x11000100 0 0x80>;
-- 
2.40.0

