Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA686DF3B2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 13:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231649AbjDLLaq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 07:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231633AbjDLLa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 07:30:28 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C1BA25C;
        Wed, 12 Apr 2023 04:28:58 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id CB19C66032EB;
        Wed, 12 Apr 2023 12:28:20 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1681298902;
        bh=xUQYw0z/3eD48tbUC6FkC0FmT/7tvqDbRz8S5+ghVDQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UiDRoD/awykx1G8oFAEFQ1z3rHmX6u5CgvPp9Ttb5eVfOz2rGgXgHCyHyJPDPppAB
         Z9BZ+0ieRQczDcAEh7xhreHlVE8xq8tUQ4rmfBrKhruvRyXpIgMNJ2/wveG2HfzXv3
         xmfXU/jdBAoaLjMqDdLEIwx2mljisr8xT2QkGN0XiNE1WcR2ttFQ0rTbn7/POWQGaU
         1Q3uno27kmTpcLMA6VWSEq1yaZ00V/A2W297bWYJ4jTAZ9o4avL5bthLXTgWaNWw5h
         t7neth4CgeLeEKOGT8X/PRCvHjidg16w9ZBqySIAADjhpwuYEW6O8dtUvZYzbpznPA
         bJySENdAEub7g==
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
Subject: [PATCH 26/27] arm64: dts: mediatek: mt6795-xperia-m5: Add Bosch BMA255 Accelerometer
Date:   Wed, 12 Apr 2023 13:27:38 +0200
Message-Id: <20230412112739.160376-27-angelogioacchino.delregno@collabora.com>
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

Add the BMA255 Accelerometer on I2C3 and its pin definitions.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../boot/dts/mediatek/mt6795-sony-xperia-m5.dts   | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt6795-sony-xperia-m5.dts b/arch/arm64/boot/dts/mediatek/mt6795-sony-xperia-m5.dts
index 155a573eac4c..0b0519f6b2f1 100644
--- a/arch/arm64/boot/dts/mediatek/mt6795-sony-xperia-m5.dts
+++ b/arch/arm64/boot/dts/mediatek/mt6795-sony-xperia-m5.dts
@@ -68,6 +68,13 @@ &i2c1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c1_pins>;
 	status = "okay";
+
+	accelerometer@10 {
+		compatible = "bosch,bma255";
+		reg = <0x10>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&accel_pins>;
+	};
 };
 
 &i2c2 {
@@ -247,6 +254,14 @@ pins-irq {
 		};
 	};
 
+	accel_pins: accelerometer-pins {
+		pins-irq {
+			pinmux = <PINMUX_GPIO12__FUNC_GPIO12>;
+			bias-pull-up;
+			input-enable;
+		};
+	};
+
 	i2c0_pins: i2c0-pins {
 		pins-bus {
 			pinmux = <PINMUX_GPIO45__FUNC_SDA0>,
-- 
2.40.0

