Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 562417150AE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 22:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbjE2Unw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 16:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjE2Unn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 16:43:43 -0400
Received: from mxout1.routing.net (mxout1.routing.net [134.0.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 964F9DB;
        Mon, 29 May 2023 13:43:38 -0700 (PDT)
Received: from mxbox2.masterlogin.de (unknown [192.168.10.89])
        by mxout1.routing.net (Postfix) with ESMTP id 695513FC7F;
        Mon, 29 May 2023 20:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1685393015;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NiNTNWADcq8Wf9sTDfcLcaA78qUAbBkS8piCK+YIth4=;
        b=X7uCk1A5RWowtoLg5C28QXGgBuPhnlgquA0AlaMFd43ibD+ZUiiExwvswPC2MKv8xwn93/
        lYdNhnN/6uXhuWKKJ1g57S9tFrJvZcprKeOWolnq3tU34kfnUUp1wV3Es+/nhVbwQv8nsJ
        lqZPUaqmWk5su9LXSJu66RUD+Zv4PZg=
Received: from frank-G5.. (fttx-pool-217.61.156.2.bambit.de [217.61.156.2])
        by mxbox2.masterlogin.de (Postfix) with ESMTPSA id 4483E1006D1;
        Mon, 29 May 2023 20:43:34 +0000 (UTC)
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
Subject: [PATCH v2 4/4] arm64: dts: mt7986: add pwm-fan and cooling-maps to BPI-R3 dts
Date:   Mon, 29 May 2023 22:42:58 +0200
Message-Id: <20230529204258.65238-5-linux@fw-web.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230529204258.65238-1-linux@fw-web.de>
References: <20230529204258.65238-1-linux@fw-web.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: b1d02627-873f-44dd-a92e-df7ed1a9bf87
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Golle <daniel@makrotopia.org>

Add pwm-fan and cooling-maps to BananaPi-R3 devicetree.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
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

