Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF2F76DF3B5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 13:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbjDLLbS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 07:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231560AbjDLLa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 07:30:59 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D160A5EC;
        Wed, 12 Apr 2023 04:29:25 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3B916660324D;
        Wed, 12 Apr 2023 12:28:22 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1681298903;
        bh=FrZ0bhYSUc3f/6EFDPkgRvN3ofxA9mQ25dTr2lufmAQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H8J6WREJiSELQuQdZAUz06U2x3wIhPE+Q73DAEJDcHAcSc9VSJDn3cW93Gr96UhOP
         cDi5DV6unFsMDzilzcl3hZLFPCTwx3Pukl2mFwU71JHaBzJ2yyXe3Z7KA+s/JC7jho
         y4DZuZ/BblFZ2xonu/ZK+OUKSyeyZPQdRQHXyq87SORhUaosLkUSNPmhb/gnmvwnY/
         2di2KwWct0SxcrpIrPd9Bc6FCCLRBHerlNBBM84qKxMEIk+ZlJJhWcrxJJqhEtNGl+
         1tiwyeWlhwQkAdiHk8G+xC5NTgFQd86wKoDDajqup5ztiKjP/29yuHs9/1tB6gIyp3
         3SJCSlOfuWxBg==
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
Subject: [PATCH 27/27] arm64: dts: mediatek: mt6795-xperia-m5: Add Bosch BMM050 Magnetometer
Date:   Wed, 12 Apr 2023 13:27:39 +0200
Message-Id: <20230412112739.160376-28-angelogioacchino.delregno@collabora.com>
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

This smartphone features a Bosch BMM050 Magnetometer on I2C3: enable
it with the BMM150 binding, as that driver supports BMM050 as well.
For this sensor, there is no interrupt pin;
readings were validated in sysfs.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt6795-sony-xperia-m5.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt6795-sony-xperia-m5.dts b/arch/arm64/boot/dts/mediatek/mt6795-sony-xperia-m5.dts
index 0b0519f6b2f1..b5746e6d0b15 100644
--- a/arch/arm64/boot/dts/mediatek/mt6795-sony-xperia-m5.dts
+++ b/arch/arm64/boot/dts/mediatek/mt6795-sony-xperia-m5.dts
@@ -75,6 +75,11 @@ accelerometer@10 {
 		pinctrl-names = "default";
 		pinctrl-0 = <&accel_pins>;
 	};
+
+	magnetometer@12 {
+		compatible = "bosch,bmm150";
+		reg = <0x12>;
+	};
 };
 
 &i2c2 {
-- 
2.40.0

