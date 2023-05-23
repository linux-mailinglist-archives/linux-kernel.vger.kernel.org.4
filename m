Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E08170D3C4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 08:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235125AbjEWGPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 02:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235079AbjEWGPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 02:15:37 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D181119;
        Mon, 22 May 2023 23:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1684822535; x=1716358535;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gzSWfAKPB5qBX1sE5pYvWf6PLtnvJPojqONIqDbzLR4=;
  b=lzyN5dVPw4tp2vdKeILHfhL+gzEzbMucG21RvuRxGEmf250jCH82wBo+
   eRieDDpKxT85lqcMVKQUX8kXytaewonfb9mFZ1ZR+oJP8ALYXPe/kl7B4
   jMjyJ2VNQEomKA98FsvKf75PPh0M8RabhrjQKTcfZ2Z9wy5jg4fX8RGnp
   Sm630V/3yYGyc/UZBBv4p96KMTnbehidmmbk3cv0e71VcYrp7LLFOivs/
   8TDRqFsfzIYNroeIoHbWc7Y6SlD/5m7VmjVFnRZN9CaB15M74FDABhzvS
   PLgdsAbaRGKUKNCYzzasYIde4pjsQfP/2aNvY7piH1Oz0UVZLPn5WNdnF
   w==;
X-IronPort-AV: E=Sophos;i="6.00,185,1681196400"; 
   d="scan'208";a="153433852"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 May 2023 23:15:34 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 22 May 2023 23:15:30 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Mon, 22 May 2023 23:15:27 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor.dooley@microchip.com>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <sre@kernel.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 1/4] ARM: dts: at91: use generic name for shutdown controller
Date:   Tue, 23 May 2023 09:15:09 +0300
Message-ID: <20230523061512.195271-2-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230523061512.195271-1-claudiu.beznea@microchip.com>
References: <20230523061512.195271-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use poweroff generic name for shdwc node to cope with device tree
specifications.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/boot/dts/at91-qil_a9260.dts        | 2 +-
 arch/arm/boot/dts/at91-sama5d27_som1_ek.dts | 2 +-
 arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts   | 2 +-
 arch/arm/boot/dts/at91-sama5d2_xplained.dts | 2 +-
 arch/arm/boot/dts/at91sam9260.dtsi          | 2 +-
 arch/arm/boot/dts/at91sam9260ek.dts         | 2 +-
 arch/arm/boot/dts/at91sam9261.dtsi          | 2 +-
 arch/arm/boot/dts/at91sam9263.dtsi          | 2 +-
 arch/arm/boot/dts/at91sam9g20ek_common.dtsi | 2 +-
 arch/arm/boot/dts/at91sam9g45.dtsi          | 2 +-
 arch/arm/boot/dts/at91sam9n12.dtsi          | 2 +-
 arch/arm/boot/dts/at91sam9rl.dtsi           | 2 +-
 arch/arm/boot/dts/at91sam9x5.dtsi           | 2 +-
 arch/arm/boot/dts/sam9x60.dtsi              | 2 +-
 arch/arm/boot/dts/sama5d2.dtsi              | 2 +-
 arch/arm/boot/dts/sama5d3.dtsi              | 2 +-
 arch/arm/boot/dts/sama5d4.dtsi              | 2 +-
 arch/arm/boot/dts/sama7g5.dtsi              | 2 +-
 arch/arm/boot/dts/usb_a9260.dts             | 2 +-
 arch/arm/boot/dts/usb_a9263.dts             | 2 +-
 20 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/arch/arm/boot/dts/at91-qil_a9260.dts b/arch/arm/boot/dts/at91-qil_a9260.dts
index 9d26f9996348..5ccb3c139592 100644
--- a/arch/arm/boot/dts/at91-qil_a9260.dts
+++ b/arch/arm/boot/dts/at91-qil_a9260.dts
@@ -108,7 +108,7 @@ dbgu: serial@fffff200 {
 				status = "okay";
 			};
 
-			shdwc@fffffd10 {
+			shdwc: poweroff@fffffd10 {
 				atmel,wakeup-counter = <10>;
 				atmel,wakeup-rtt-timer;
 			};
diff --git a/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts b/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts
index 0dc6ca377b0c..cb6243cfe182 100644
--- a/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts
+++ b/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts
@@ -139,7 +139,7 @@ i2c3: i2c@600 {
 				};
 			};
 
-			shdwc@f8048010 {
+			poweroff@f8048010 {
 				debounce-delay-us = <976>;
 				atmel,wakeup-rtc-timer;
 
diff --git a/arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts b/arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts
index 76a711b167b0..86b860d80726 100644
--- a/arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts
+++ b/arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts
@@ -204,7 +204,7 @@ i2c2: i2c@600 {
 				};
 			};
 
-			shdwc@f8048010 {
+			poweroff@f8048010 {
 				debounce-delay-us = <976>;
 
 				input@0 {
diff --git a/arch/arm/boot/dts/at91-sama5d2_xplained.dts b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
index 85949c24b687..024a553842a9 100644
--- a/arch/arm/boot/dts/at91-sama5d2_xplained.dts
+++ b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
@@ -348,7 +348,7 @@ i2c2: i2c@600 {
 				};
 			};
 
-			shdwc@f8048010 {
+			poweroff@f8048010 {
 				debounce-delay-us = <976>;
 				atmel,wakeup-rtc-timer;
 
diff --git a/arch/arm/boot/dts/at91sam9260.dtsi b/arch/arm/boot/dts/at91sam9260.dtsi
index 16e3b24b4ddd..35a007365b6a 100644
--- a/arch/arm/boot/dts/at91sam9260.dtsi
+++ b/arch/arm/boot/dts/at91sam9260.dtsi
@@ -130,7 +130,7 @@ reset-controller@fffffd00 {
 				clocks = <&pmc PMC_TYPE_CORE PMC_SLOW>;
 			};
 
-			shdwc@fffffd10 {
+			shdwc: poweroff@fffffd10 {
 				compatible = "atmel,at91sam9260-shdwc";
 				reg = <0xfffffd10 0x10>;
 				clocks = <&pmc PMC_TYPE_CORE PMC_SLOW>;
diff --git a/arch/arm/boot/dts/at91sam9260ek.dts b/arch/arm/boot/dts/at91sam9260ek.dts
index bb72f050a4fe..720c15472c4a 100644
--- a/arch/arm/boot/dts/at91sam9260ek.dts
+++ b/arch/arm/boot/dts/at91sam9260ek.dts
@@ -112,7 +112,7 @@ pinctrl_board_mmc0_slot1: mmc0_slot1-board {
 				};
 			};
 
-			shdwc@fffffd10 {
+			shdwc: poweroff@fffffd10 {
 				atmel,wakeup-counter = <10>;
 				atmel,wakeup-rtt-timer;
 			};
diff --git a/arch/arm/boot/dts/at91sam9261.dtsi b/arch/arm/boot/dts/at91sam9261.dtsi
index fe9ead867e2a..528ffc6f6f96 100644
--- a/arch/arm/boot/dts/at91sam9261.dtsi
+++ b/arch/arm/boot/dts/at91sam9261.dtsi
@@ -614,7 +614,7 @@ reset-controller@fffffd00 {
 				clocks = <&slow_xtal>;
 			};
 
-			shdwc@fffffd10 {
+			poweroff@fffffd10 {
 				compatible = "atmel,at91sam9260-shdwc";
 				reg = <0xfffffd10 0x10>;
 				clocks = <&slow_xtal>;
diff --git a/arch/arm/boot/dts/at91sam9263.dtsi b/arch/arm/boot/dts/at91sam9263.dtsi
index ee5e6ed44dd4..75d8ff2d12c8 100644
--- a/arch/arm/boot/dts/at91sam9263.dtsi
+++ b/arch/arm/boot/dts/at91sam9263.dtsi
@@ -158,7 +158,7 @@ reset-controller@fffffd00 {
 				clocks = <&slow_xtal>;
 			};
 
-			shdwc@fffffd10 {
+			poweroff@fffffd10 {
 				compatible = "atmel,at91sam9260-shdwc";
 				reg = <0xfffffd10 0x10>;
 				clocks = <&slow_xtal>;
diff --git a/arch/arm/boot/dts/at91sam9g20ek_common.dtsi b/arch/arm/boot/dts/at91sam9g20ek_common.dtsi
index 024af2db638e..565b99e79c52 100644
--- a/arch/arm/boot/dts/at91sam9g20ek_common.dtsi
+++ b/arch/arm/boot/dts/at91sam9g20ek_common.dtsi
@@ -126,7 +126,7 @@ flash@1 {
 				};
 			};
 
-			shdwc@fffffd10 {
+			shdwc: poweroff@fffffd10 {
 				atmel,wakeup-counter = <10>;
 				atmel,wakeup-rtt-timer;
 			};
diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
index 498cb92b29f9..7cccc606e36c 100644
--- a/arch/arm/boot/dts/at91sam9g45.dtsi
+++ b/arch/arm/boot/dts/at91sam9g45.dtsi
@@ -152,7 +152,7 @@ pit: timer@fffffd30 {
 			};
 
 
-			shdwc@fffffd10 {
+			poweroff@fffffd10 {
 				compatible = "atmel,at91sam9rl-shdwc";
 				reg = <0xfffffd10 0x10>;
 				clocks = <&clk32k>;
diff --git a/arch/arm/boot/dts/at91sam9n12.dtsi b/arch/arm/boot/dts/at91sam9n12.dtsi
index 0e28101b26bf..8dc04e9031a6 100644
--- a/arch/arm/boot/dts/at91sam9n12.dtsi
+++ b/arch/arm/boot/dts/at91sam9n12.dtsi
@@ -140,7 +140,7 @@ pit: timer@fffffe30 {
 				clocks = <&pmc PMC_TYPE_CORE PMC_MCK>;
 			};
 
-			shdwc@fffffe10 {
+			poweroff@fffffe10 {
 				compatible = "atmel,at91sam9x5-shdwc";
 				reg = <0xfffffe10 0x10>;
 				clocks = <&clk32k>;
diff --git a/arch/arm/boot/dts/at91sam9rl.dtsi b/arch/arm/boot/dts/at91sam9rl.dtsi
index d7e8a115c916..3d089ffbe162 100644
--- a/arch/arm/boot/dts/at91sam9rl.dtsi
+++ b/arch/arm/boot/dts/at91sam9rl.dtsi
@@ -778,7 +778,7 @@ reset-controller@fffffd00 {
 				clocks = <&clk32k>;
 			};
 
-			shdwc@fffffd10 {
+			poweroff@fffffd10 {
 				compatible = "atmel,at91sam9260-shdwc";
 				reg = <0xfffffd10 0x10>;
 				clocks = <&clk32k>;
diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
index 0123ee47151c..a1fed912f2ee 100644
--- a/arch/arm/boot/dts/at91sam9x5.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5.dtsi
@@ -141,7 +141,7 @@ reset_controller: reset-controller@fffffe00 {
 				clocks = <&clk32k>;
 			};
 
-			shutdown_controller: shdwc@fffffe10 {
+			shutdown_controller: poweroff@fffffe10 {
 				compatible = "atmel,at91sam9x5-shdwc";
 				reg = <0xfffffe10 0x10>;
 				clocks = <&clk32k>;
diff --git a/arch/arm/boot/dts/sam9x60.dtsi b/arch/arm/boot/dts/sam9x60.dtsi
index 933d73505a8b..47c4f267a45c 100644
--- a/arch/arm/boot/dts/sam9x60.dtsi
+++ b/arch/arm/boot/dts/sam9x60.dtsi
@@ -675,7 +675,7 @@ reset_controller: reset-controller@fffffe00 {
 				clocks = <&clk32k 0>;
 			};
 
-			shutdown_controller: shdwc@fffffe10 {
+			shutdown_controller: poweroff@fffffe10 {
 				compatible = "microchip,sam9x60-shdwc";
 				reg = <0xfffffe10 0x10>;
 				clocks = <&clk32k 0>;
diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
index 7b6471655dee..daeeb24e5f4d 100644
--- a/arch/arm/boot/dts/sama5d2.dtsi
+++ b/arch/arm/boot/dts/sama5d2.dtsi
@@ -680,7 +680,7 @@ reset_controller: reset-controller@f8048000 {
 				clocks = <&clk32k>;
 			};
 
-			shutdown_controller: shdwc@f8048010 {
+			shutdown_controller: poweroff@f8048010 {
 				compatible = "atmel,sama5d2-shdwc";
 				reg = <0xf8048010 0x10>;
 				clocks = <&clk32k>;
diff --git a/arch/arm/boot/dts/sama5d3.dtsi b/arch/arm/boot/dts/sama5d3.dtsi
index 0eebf6c760b3..d9e66700d1c2 100644
--- a/arch/arm/boot/dts/sama5d3.dtsi
+++ b/arch/arm/boot/dts/sama5d3.dtsi
@@ -1016,7 +1016,7 @@ reset_controller: reset-controller@fffffe00 {
 				clocks = <&clk32k>;
 			};
 
-			shutdown_controller: shutdown-controller@fffffe10 {
+			shutdown_controller: poweroff@fffffe10 {
 				compatible = "atmel,at91sam9x5-shdwc";
 				reg = <0xfffffe10 0x10>;
 				clocks = <&clk32k>;
diff --git a/arch/arm/boot/dts/sama5d4.dtsi b/arch/arm/boot/dts/sama5d4.dtsi
index de6c82969232..41284e013f53 100644
--- a/arch/arm/boot/dts/sama5d4.dtsi
+++ b/arch/arm/boot/dts/sama5d4.dtsi
@@ -740,7 +740,7 @@ reset_controller: reset-controller@fc068600 {
 				clocks = <&clk32k>;
 			};
 
-			shutdown_controller: shdwc@fc068610 {
+			shutdown_controller: poweroff@fc068610 {
 				compatible = "atmel,at91sam9x5-shdwc";
 				reg = <0xfc068610 0x10>;
 				clocks = <&clk32k>;
diff --git a/arch/arm/boot/dts/sama7g5.dtsi b/arch/arm/boot/dts/sama7g5.dtsi
index f0478a43edc2..886b6209a71e 100644
--- a/arch/arm/boot/dts/sama7g5.dtsi
+++ b/arch/arm/boot/dts/sama7g5.dtsi
@@ -257,7 +257,7 @@ reset_controller: reset-controller@e001d000 {
 			clocks = <&clk32k 0>;
 		};
 
-		shdwc: shdwc@e001d010 {
+		shdwc: poweroff@e001d010 {
 			compatible = "microchip,sama7g5-shdwc", "syscon";
 			reg = <0xe001d010 0x10>;
 			clocks = <&clk32k 0>;
diff --git a/arch/arm/boot/dts/usb_a9260.dts b/arch/arm/boot/dts/usb_a9260.dts
index 6cfa83921ac2..66f8da89007d 100644
--- a/arch/arm/boot/dts/usb_a9260.dts
+++ b/arch/arm/boot/dts/usb_a9260.dts
@@ -22,7 +22,7 @@ memory@20000000 {
 
 	ahb {
 		apb {
-			shdwc@fffffd10 {
+			shdwc: poweroff@fffffd10 {
 				atmel,wakeup-counter = <10>;
 				atmel,wakeup-rtt-timer;
 			};
diff --git a/arch/arm/boot/dts/usb_a9263.dts b/arch/arm/boot/dts/usb_a9263.dts
index b6cb9cdf8197..45745915b2e1 100644
--- a/arch/arm/boot/dts/usb_a9263.dts
+++ b/arch/arm/boot/dts/usb_a9263.dts
@@ -67,7 +67,7 @@ flash@0 {
 				};
 			};
 
-			shdwc@fffffd10 {
+			poweroff@fffffd10 {
 				atmel,wakeup-counter = <10>;
 				atmel,wakeup-rtt-timer;
 			};
-- 
2.34.1

