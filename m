Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC29716E77
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 22:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233245AbjE3UNr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 16:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233070AbjE3UNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 16:13:38 -0400
Received: from mxout3.routing.net (mxout3.routing.net [IPv6:2a03:2900:1:a::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94377102;
        Tue, 30 May 2023 13:13:36 -0700 (PDT)
Received: from mxbox1.masterlogin.de (unknown [192.168.10.88])
        by mxout3.routing.net (Postfix) with ESMTP id 9817F62611;
        Tue, 30 May 2023 20:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1685477614;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lb8VvV6rbPTiUgU7OuTn7VUuQ6DRjIHw3Ydrif+cqic=;
        b=QPdF6+618BLtjAckInZuH0K205JSHVMjF/8xOWGDJqBq05tZIPKqgLeKo5ALXw5B852ujk
        TLTFgm9z6WQa569u+85//3Je6ayK4rypiji14uhkv6FPuzDDL7Y1cft+5c6Sr96J1ycNpo
        zZR/W/wvopcjfcobKUEC2JGfjI5fbUw=
Received: from frank-G5.. (fttx-pool-217.61.157.145.bambit.de [217.61.157.145])
        by mxbox1.masterlogin.de (Postfix) with ESMTPSA id 7BB2A402C6;
        Tue, 30 May 2023 20:13:33 +0000 (UTC)
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
Subject: [PATCH v3 3/4] arm64: dts: mt7986: add thermal-zones
Date:   Tue, 30 May 2023 22:12:34 +0200
Message-Id: <20230530201235.22330-4-linux@fw-web.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230530201235.22330-1-linux@fw-web.de>
References: <20230530201235.22330-1-linux@fw-web.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: e1463851-b6ea-46c5-aebe-f5df515957ed
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

Add thermal-zones to mt7986 devicetree.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
changes in v2:
- drop top 2 thermal trips as suggested by matthias
---
 arch/arm64/boot/dts/mediatek/mt7986a.dtsi | 28 +++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt7986a.dtsi b/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
index ad4fd77b65a7..68539ea788df 100644
--- a/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
@@ -602,4 +602,32 @@ wifi: wifi@18000000 {
 			memory-region = <&wmcpu_emi>;
 		};
 	};
+
+	thermal-zones {
+		cpu_thermal: cpu-thermal {
+			polling-delay-passive = <1000>;
+			polling-delay = <1000>;
+			thermal-sensors = <&thermal 0>;
+
+			trips {
+				cpu_trip_active_high: active-high {
+					temperature = <115000>;
+					hysteresis = <2000>;
+					type = "active";
+				};
+
+				cpu_trip_active_low: active-low {
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "active";
+				};
+
+				cpu_trip_passive: passive {
+					temperature = <40000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+			};
+		};
+	};
 };
-- 
2.34.1

