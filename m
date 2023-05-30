Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAFC1716E78
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 22:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232847AbjE3UNu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 16:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233103AbjE3UNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 16:13:38 -0400
Received: from mxout2.routing.net (mxout2.routing.net [IPv6:2a03:2900:1:a::b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E18810A;
        Tue, 30 May 2023 13:13:37 -0700 (PDT)
Received: from mxbox1.masterlogin.de (unknown [192.168.10.88])
        by mxout2.routing.net (Postfix) with ESMTP id 8E308615DB;
        Tue, 30 May 2023 20:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1685477615;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BFfAo9ifBuoYhXH6mSTzgnU8pbkgDeuCzxPB9AR/n9k=;
        b=xDavmHBlUzSpXgjrFHSaDgVB7cl4BE8IpATNpSGSlAQya7VaW7RfjZjdZwWrLbLMCkItgh
        TGN3fRYeyQdF2vaxUvFsh6P8G5Yzv4SrqQK5fD5vhagK1GMHlQDc69arQzjbLNI/1aMT3g
        L22x3g/9HrNSiu4u3YM7euUr97QBojc=
Received: from frank-G5.. (fttx-pool-217.61.157.145.bambit.de [217.61.157.145])
        by mxbox1.masterlogin.de (Postfix) with ESMTPSA id 7E12C4062D;
        Tue, 30 May 2023 20:13:34 +0000 (UTC)
From:   Frank Wunderlich <linux@fw-web.de>
To:     linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        "Hui.Liu" <hui.liu@mediatek.com>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Lala Lin <lala.lin@mediatek.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Daniel Golle <daniel@makrotopia.org>
Subject: [PATCH v3 4/4] arm64: dts: mt7986: add pwm-fan and cooling-maps to BPI-R3 dts
Date:   Tue, 30 May 2023 22:12:35 +0200
Message-Id: <20230530201235.22330-5-linux@fw-web.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230530201235.22330-1-linux@fw-web.de>
References: <20230530201235.22330-1-linux@fw-web.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: eb43ed84-52f3-4a28-89ff-cb5b0bbaf3e3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Golle <daniel@makrotopia.org>

Add pwm-fan and cooling-maps to BananaPi-R3 devicetree.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
this is based on Patch from openwrt. as my PWM-fan seems to need 5v pwm
signal and r3 only provides 3v3 on 3pin-socket it does not work for me.
---
 .../dts/mediatek/mt7986a-bananapi-bpi-r3.dts  | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dts b/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dts
index 782519429497..29c018bbf29d 100644
--- a/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dts
@@ -37,6 +37,15 @@ dcin: regulator-12vd {
 		regulator-always-on;
 	};
 
+	fan: pwm-fan {
+		compatible = "pwm-fan";
+		#cooling-cells = <2>;
+		/* cooling level (0, 1, 2) - pwm inverted */
+		cooling-levels = <255 96 0>;
+		pwms = <&pwm 0 10000 0>;
+		status = "okay";
+	};
+
 	gpio-keys {
 		compatible = "gpio-keys";
 
@@ -132,6 +141,28 @@ sfp2: sfp-2 {
 	};
 };
 
+&cpu_thermal {
+	cooling-maps {
+		cpu-active-high {
+			/* active: set fan to cooling level 2 */
+			cooling-device = <&fan 2 2>;
+			trip = <&cpu_trip_active_high>;
+		};
+
+		cpu-active-low {
+			/* active: set fan to cooling level 1 */
+			cooling-device = <&fan 1 1>;
+			trip = <&cpu_trip_active_low>;
+		};
+
+		cpu-passive {
+			/* passive: set fan to cooling level 0 */
+			cooling-device = <&fan 0 0>;
+			trip = <&cpu_trip_passive>;
+		};
+	};
+};
+
 &crypto {
 	status = "okay";
 };
-- 
2.34.1

