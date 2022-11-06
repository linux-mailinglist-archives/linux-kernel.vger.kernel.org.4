Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0084F61E0FC
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 09:50:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbiKFIur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 03:50:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbiKFIun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 03:50:43 -0500
Received: from mxout3.routing.net (mxout3.routing.net [IPv6:2a03:2900:1:a::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36B91A1B2;
        Sun,  6 Nov 2022 01:50:42 -0700 (PDT)
Received: from mxbox3.masterlogin.de (unknown [192.168.10.78])
        by mxout3.routing.net (Postfix) with ESMTP id 6FF40604C6;
        Sun,  6 Nov 2022 08:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1667724640;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZKbPVnyr8O2+t+13Wepki/7PMD1kuq2RmBNc/cbSHGc=;
        b=IJbg5xEgCzrab16iug8pqByeH3gZJT8cwZXG0eBpoix3n5poiDja0n/TO/Liz9etyHM4UM
        0CVtVzzaHxRiDHc2NDp4ZYxyqFG8TXFVZ9FL4IVT+3a3pEFTGrZggPZMhxPl/f7ZSzhTc6
        DwuvF6dQAXdo65l4PJujrT4BuaYSTkc=
Received: from frank-G5.. (fttx-pool-80.245.79.199.bambit.de [80.245.79.199])
        by mxbox3.masterlogin.de (Postfix) with ESMTPSA id B096736054A;
        Sun,  6 Nov 2022 08:50:39 +0000 (UTC)
From:   Frank Wunderlich <linux@fw-web.de>
To:     linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sam Shih <sam.shih@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [RFC v3 01/11] arm64: dts: mt7986: harmonize device node order
Date:   Sun,  6 Nov 2022 09:50:24 +0100
Message-Id: <20221106085034.12582-2-linux@fw-web.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221106085034.12582-1-linux@fw-web.de>
References: <20221106085034.12582-1-linux@fw-web.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: 3acff14d-38c2-423d-ac39-9364fb9b5d36
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sam Shih <sam.shih@mediatek.com>

This arrange device tree nodes in alphabetical order.

Signed-off-by: Sam Shih <sam.shih@mediatek.com>
Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
i modified sams patch

https://patchwork.kernel.org/project/linux-mediatek/patch/20220427124741.18245-2-sam.shih@mediatek.com/

by moving pio-node up instead of moving uarts down to ensure alphabetical
order for switch-/wifi-node.

And moved uart0 and wifi in mt7986b-rfb too.
---
 arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts | 94 ++++++++++----------
 arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts | 22 ++---
 2 files changed, 58 insertions(+), 58 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts b/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts
index afe37b702eef..6189436fe31d 100644
--- a/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts
@@ -54,6 +54,53 @@ switch: switch@0 {
 	};
 };
 
+&pio {
+	uart1_pins: uart1-pins {
+		mux {
+			function = "uart";
+			groups = "uart1";
+		};
+	};
+
+	uart2_pins: uart2-pins {
+		mux {
+			function = "uart";
+			groups = "uart2";
+		};
+	};
+
+	wf_2g_5g_pins: wf-2g-5g-pins {
+		mux {
+			function = "wifi";
+			groups = "wf_2g", "wf_5g";
+		};
+		conf {
+			pins = "WF0_HB1", "WF0_HB2", "WF0_HB3", "WF0_HB4",
+			       "WF0_HB0", "WF0_HB0_B", "WF0_HB5", "WF0_HB6",
+			       "WF0_HB7", "WF0_HB8", "WF0_HB9", "WF0_HB10",
+			       "WF0_TOP_CLK", "WF0_TOP_DATA", "WF1_HB1",
+			       "WF1_HB2", "WF1_HB3", "WF1_HB4", "WF1_HB0",
+			       "WF1_HB5", "WF1_HB6", "WF1_HB7", "WF1_HB8",
+			       "WF1_TOP_CLK", "WF1_TOP_DATA";
+			drive-strength = <4>;
+		};
+	};
+
+	wf_dbdc_pins: wf-dbdc-pins {
+		mux {
+			function = "wifi";
+			groups = "wf_dbdc";
+		};
+		conf {
+			pins = "WF0_HB1", "WF0_HB2", "WF0_HB3", "WF0_HB4",
+			       "WF0_HB0", "WF0_HB0_B", "WF0_HB5", "WF0_HB6",
+			       "WF0_HB7", "WF0_HB8", "WF0_HB9", "WF0_HB10",
+			       "WF0_TOP_CLK", "WF0_TOP_DATA";
+			drive-strength = <4>;
+		};
+	};
+};
+
 &switch {
 	ports {
 		#address-cells = <1>;
@@ -121,50 +168,3 @@ &wifi {
 	pinctrl-0 = <&wf_2g_5g_pins>;
 	pinctrl-1 = <&wf_dbdc_pins>;
 };
-
-&pio {
-	uart1_pins: uart1-pins {
-		mux {
-			function = "uart";
-			groups = "uart1";
-		};
-	};
-
-	uart2_pins: uart2-pins {
-		mux {
-			function = "uart";
-			groups = "uart2";
-		};
-	};
-
-	wf_2g_5g_pins: wf-2g-5g-pins {
-		mux {
-			function = "wifi";
-			groups = "wf_2g", "wf_5g";
-		};
-		conf {
-			pins = "WF0_HB1", "WF0_HB2", "WF0_HB3", "WF0_HB4",
-			       "WF0_HB0", "WF0_HB0_B", "WF0_HB5", "WF0_HB6",
-			       "WF0_HB7", "WF0_HB8", "WF0_HB9", "WF0_HB10",
-			       "WF0_TOP_CLK", "WF0_TOP_DATA", "WF1_HB1",
-			       "WF1_HB2", "WF1_HB3", "WF1_HB4", "WF1_HB0",
-			       "WF1_HB5", "WF1_HB6", "WF1_HB7", "WF1_HB8",
-			       "WF1_TOP_CLK", "WF1_TOP_DATA";
-			drive-strength = <4>;
-		};
-	};
-
-	wf_dbdc_pins: wf-dbdc-pins {
-		mux {
-			function = "wifi";
-			groups = "wf_dbdc";
-		};
-		conf {
-			pins = "WF0_HB1", "WF0_HB2", "WF0_HB3", "WF0_HB4",
-			       "WF0_HB0", "WF0_HB0_B", "WF0_HB5", "WF0_HB6",
-			       "WF0_HB7", "WF0_HB8", "WF0_HB9", "WF0_HB10",
-			       "WF0_TOP_CLK", "WF0_TOP_DATA";
-			drive-strength = <4>;
-		};
-	};
-};
diff --git a/arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts b/arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts
index 3443013b5971..7459ddb6b6f0 100644
--- a/arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts
@@ -25,10 +25,6 @@ memory@40000000 {
 	};
 };
 
-&uart0 {
-	status = "okay";
-};
-
 &eth {
 	status = "okay";
 
@@ -99,13 +95,6 @@ fixed-link {
 	};
 };
 
-&wifi {
-	status = "okay";
-	pinctrl-names = "default", "dbdc";
-	pinctrl-0 = <&wf_2g_5g_pins>;
-	pinctrl-1 = <&wf_dbdc_pins>;
-};
-
 &pio {
 	wf_2g_5g_pins: wf-2g-5g-pins {
 		mux {
@@ -138,3 +127,14 @@ conf {
 		};
 	};
 };
+
+&uart0 {
+	status = "okay";
+};
+
+&wifi {
+	status = "okay";
+	pinctrl-names = "default", "dbdc";
+	pinctrl-0 = <&wf_2g_5g_pins>;
+	pinctrl-1 = <&wf_dbdc_pins>;
+};
-- 
2.34.1

