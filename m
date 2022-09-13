Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22D2C5B759F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 17:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233075AbiIMPwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 11:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235199AbiIMPwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 11:52:02 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB8E8E0EB;
        Tue, 13 Sep 2022 07:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1663080833; x=1694616833;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IcWix8PrS5Ed8DitL5XQ67+u4xTS2w2OUz1DDsM7z54=;
  b=TBF+Q+7E5Px+rif3hudCVpAhEz0NU91eeZDxye6mb/8PAtXH/pWQIO8n
   hNLzij9QExzRuVPs8RbISLZkrzERa2w83WfRET67bqGgKU0yAUqUNaPi2
   5azZNYMkny88DNNNRYMvvtYtqIB2SpJd10sOBan5AgXPzKxQt871h0tGL
   ibT0iidxJ2T1EB83vEpm0lyAm0yZAct4xQ31bmGACfh0+Tap+0igQEH8H
   4GcLCvQjLFCEoIyg6RcPZxuhpC3zC2YQ6eb3eCTlIb+ps+UIe2LyhpAb2
   Ch7TSyMbrWVi74kV2k1CaV4Wf6NlXCzyWdd8oK7c7cTScWJFcrtQyBMDK
   A==;
X-IronPort-AV: E=Sophos;i="5.93,313,1654585200"; 
   d="scan'208";a="190643899"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Sep 2022 07:25:00 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 13 Sep 2022 07:25:00 -0700
Received: from ROB-ULT-M68701.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Tue, 13 Sep 2022 07:24:55 -0700
From:   Sergiu Moga <sergiu.moga@microchip.com>
To:     <lee@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <claudiu.beznea@microchip.com>,
        <radu_nicolae.pirea@upb.ro>, <richard.genoud@gmail.com>,
        <gregkh@linuxfoundation.org>, <broonie@kernel.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <jirislaby@kernel.org>, <sergiu.moga@microchip.com>,
        <admin@hifiphile.com>, <kavyasree.kotagiri@microchip.com>,
        <tudor.ambarus@microchip.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-serial@vger.kernel.org>, <linux-clk@vger.kernel.org>
Subject: [PATCH v3 03/14] ARM: dts: at91: Add `atmel,usart-mode` required property to serial nodes
Date:   Tue, 13 Sep 2022 17:21:55 +0300
Message-ID: <20220913142205.162399-4-sergiu.moga@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220913142205.162399-1-sergiu.moga@microchip.com>
References: <20220913142205.162399-1-sergiu.moga@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the missing required DT property `atmel,usart-mode` to the serial
nodes of Atmel/Microchip DT files.

Signed-off-by: Sergiu Moga <sergiu.moga@microchip.com>
---


v1 -> v3:
- Nothing, this patch was not here before



 arch/arm/boot/dts/at91-sam9x60ek.dts     |  1 +
 arch/arm/boot/dts/at91rm9200.dtsi        |  6 ++++++
 arch/arm/boot/dts/at91sam9260.dtsi       |  8 ++++++++
 arch/arm/boot/dts/at91sam9261.dtsi       |  5 +++++
 arch/arm/boot/dts/at91sam9263.dtsi       |  5 +++++
 arch/arm/boot/dts/at91sam9g45.dtsi       |  6 ++++++
 arch/arm/boot/dts/at91sam9n12.dtsi       |  6 ++++++
 arch/arm/boot/dts/at91sam9rl.dtsi        |  6 ++++++
 arch/arm/boot/dts/at91sam9x5.dtsi        |  7 +++++++
 arch/arm/boot/dts/at91sam9x5_usart3.dtsi |  2 ++
 arch/arm/boot/dts/sam9x60.dtsi           |  2 ++
 arch/arm/boot/dts/sama5d2.dtsi           | 11 +++++++++++
 arch/arm/boot/dts/sama5d3.dtsi           |  7 +++++++
 arch/arm/boot/dts/sama5d3_uart.dtsi      |  3 +++
 arch/arm/boot/dts/sama5d4.dtsi           |  9 +++++++++
 arch/arm/boot/dts/sama7g5.dtsi           |  5 +++++
 16 files changed, 89 insertions(+)

diff --git a/arch/arm/boot/dts/at91-sam9x60ek.dts b/arch/arm/boot/dts/at91-sam9x60ek.dts
index 67bce8d60908..4ba52ba11dc6 100644
--- a/arch/arm/boot/dts/at91-sam9x60ek.dts
+++ b/arch/arm/boot/dts/at91-sam9x60ek.dts
@@ -260,6 +260,7 @@ &flx5 {
 	uart1: serial@200 {
 		compatible = "microchip,sam9x60-dbgu", "microchip,sam9x60-usart", "atmel,at91sam9260-dbgu", "atmel,at91sam9260-usart";
 		reg = <0x200 0x200>;
+		atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
 		interrupts = <14 IRQ_TYPE_LEVEL_HIGH 7>;
 		dmas = <&dma0
 			(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
diff --git a/arch/arm/boot/dts/at91rm9200.dtsi b/arch/arm/boot/dts/at91rm9200.dtsi
index d1181ead18e5..7a113325abb9 100644
--- a/arch/arm/boot/dts/at91rm9200.dtsi
+++ b/arch/arm/boot/dts/at91rm9200.dtsi
@@ -13,6 +13,7 @@
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/clock/at91.h>
+#include <dt-bindings/mfd/at91-usart.h>
 
 / {
 	#address-cells = <1>;
@@ -596,6 +597,7 @@ pioD: gpio@fffffa00 {
 			dbgu: serial@fffff200 {
 				compatible = "atmel,at91rm9200-dbgu", "atmel,at91rm9200-usart";
 				reg = <0xfffff200 0x200>;
+				atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
 				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_dbgu>;
@@ -607,6 +609,7 @@ dbgu: serial@fffff200 {
 			usart0: serial@fffc0000 {
 				compatible = "atmel,at91rm9200-usart";
 				reg = <0xfffc0000 0x200>;
+				atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
 				interrupts = <6 IRQ_TYPE_LEVEL_HIGH 5>;
 				atmel,use-dma-rx;
 				atmel,use-dma-tx;
@@ -620,6 +623,7 @@ usart0: serial@fffc0000 {
 			usart1: serial@fffc4000 {
 				compatible = "atmel,at91rm9200-usart";
 				reg = <0xfffc4000 0x200>;
+				atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
 				interrupts = <7 IRQ_TYPE_LEVEL_HIGH 5>;
 				atmel,use-dma-rx;
 				atmel,use-dma-tx;
@@ -633,6 +637,7 @@ usart1: serial@fffc4000 {
 			usart2: serial@fffc8000 {
 				compatible = "atmel,at91rm9200-usart";
 				reg = <0xfffc8000 0x200>;
+				atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
 				interrupts = <8 IRQ_TYPE_LEVEL_HIGH 5>;
 				atmel,use-dma-rx;
 				atmel,use-dma-tx;
@@ -646,6 +651,7 @@ usart2: serial@fffc8000 {
 			usart3: serial@fffcc000 {
 				compatible = "atmel,at91rm9200-usart";
 				reg = <0xfffcc000 0x200>;
+				atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
 				interrupts = <23 IRQ_TYPE_LEVEL_HIGH 5>;
 				atmel,use-dma-rx;
 				atmel,use-dma-tx;
diff --git a/arch/arm/boot/dts/at91sam9260.dtsi b/arch/arm/boot/dts/at91sam9260.dtsi
index 9d9820db9482..789fe356dbf6 100644
--- a/arch/arm/boot/dts/at91sam9260.dtsi
+++ b/arch/arm/boot/dts/at91sam9260.dtsi
@@ -11,6 +11,7 @@
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/clock/at91.h>
+#include <dt-bindings/mfd/at91-usart.h>
 
 / {
 	#address-cells = <1>;
@@ -532,6 +533,7 @@ pioC: gpio@fffff800 {
 			dbgu: serial@fffff200 {
 				compatible = "atmel,at91sam9260-dbgu", "atmel,at91sam9260-usart";
 				reg = <0xfffff200 0x200>;
+				atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
 				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_dbgu>;
@@ -543,6 +545,7 @@ dbgu: serial@fffff200 {
 			usart0: serial@fffb0000 {
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0xfffb0000 0x200>;
+				atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
 				interrupts = <6 IRQ_TYPE_LEVEL_HIGH 5>;
 				atmel,use-dma-rx;
 				atmel,use-dma-tx;
@@ -556,6 +559,7 @@ usart0: serial@fffb0000 {
 			usart1: serial@fffb4000 {
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0xfffb4000 0x200>;
+				atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
 				interrupts = <7 IRQ_TYPE_LEVEL_HIGH 5>;
 				atmel,use-dma-rx;
 				atmel,use-dma-tx;
@@ -569,6 +573,7 @@ usart1: serial@fffb4000 {
 			usart2: serial@fffb8000 {
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0xfffb8000 0x200>;
+				atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
 				interrupts = <8 IRQ_TYPE_LEVEL_HIGH 5>;
 				atmel,use-dma-rx;
 				atmel,use-dma-tx;
@@ -582,6 +587,7 @@ usart2: serial@fffb8000 {
 			usart3: serial@fffd0000 {
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0xfffd0000 0x200>;
+				atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
 				interrupts = <23 IRQ_TYPE_LEVEL_HIGH 5>;
 				atmel,use-dma-rx;
 				atmel,use-dma-tx;
@@ -595,6 +601,7 @@ usart3: serial@fffd0000 {
 			uart0: serial@fffd4000 {
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0xfffd4000 0x200>;
+				atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
 				interrupts = <24 IRQ_TYPE_LEVEL_HIGH 5>;
 				atmel,use-dma-rx;
 				atmel,use-dma-tx;
@@ -608,6 +615,7 @@ uart0: serial@fffd4000 {
 			uart1: serial@fffd8000 {
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0xfffd8000 0x200>;
+				atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
 				interrupts = <25 IRQ_TYPE_LEVEL_HIGH 5>;
 				atmel,use-dma-rx;
 				atmel,use-dma-tx;
diff --git a/arch/arm/boot/dts/at91sam9261.dtsi b/arch/arm/boot/dts/at91sam9261.dtsi
index 259aca565305..ee0bd1aceb3f 100644
--- a/arch/arm/boot/dts/at91sam9261.dtsi
+++ b/arch/arm/boot/dts/at91sam9261.dtsi
@@ -9,6 +9,7 @@
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/clock/at91.h>
+#include <dt-bindings/mfd/at91-usart.h>
 
 / {
 	#address-cells = <1>;
@@ -179,6 +180,7 @@ i2c0: i2c@fffac000 {
 			usart0: serial@fffb0000 {
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0xfffb0000 0x200>;
+				atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
 				interrupts = <6 IRQ_TYPE_LEVEL_HIGH 5>;
 				atmel,use-dma-rx;
 				atmel,use-dma-tx;
@@ -192,6 +194,7 @@ usart0: serial@fffb0000 {
 			usart1: serial@fffb4000 {
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0xfffb4000 0x200>;
+				atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
 				interrupts = <7 IRQ_TYPE_LEVEL_HIGH 5>;
 				atmel,use-dma-rx;
 				atmel,use-dma-tx;
@@ -205,6 +208,7 @@ usart1: serial@fffb4000 {
 			usart2: serial@fffb8000{
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0xfffb8000 0x200>;
+				atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
 				interrupts = <8 IRQ_TYPE_LEVEL_HIGH 5>;
 				atmel,use-dma-rx;
 				atmel,use-dma-tx;
@@ -301,6 +305,7 @@ aic: interrupt-controller@fffff000 {
 			dbgu: serial@fffff200 {
 				compatible = "atmel,at91sam9260-dbgu", "atmel,at91sam9260-usart";
 				reg = <0xfffff200 0x200>;
+				atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
 				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_dbgu>;
diff --git a/arch/arm/boot/dts/at91sam9263.dtsi b/arch/arm/boot/dts/at91sam9263.dtsi
index c080df8c2312..3ce9ea987312 100644
--- a/arch/arm/boot/dts/at91sam9263.dtsi
+++ b/arch/arm/boot/dts/at91sam9263.dtsi
@@ -9,6 +9,7 @@
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/clock/at91.h>
+#include <dt-bindings/mfd/at91-usart.h>
 
 / {
 	#address-cells = <1>;
@@ -540,6 +541,7 @@ pioE: gpio@fffffa00 {
 			dbgu: serial@ffffee00 {
 				compatible = "atmel,at91sam9260-dbgu", "atmel,at91sam9260-usart";
 				reg = <0xffffee00 0x200>;
+				atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
 				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_dbgu>;
@@ -551,6 +553,7 @@ dbgu: serial@ffffee00 {
 			usart0: serial@fff8c000 {
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0xfff8c000 0x200>;
+				atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
 				interrupts = <7 IRQ_TYPE_LEVEL_HIGH 5>;
 				atmel,use-dma-rx;
 				atmel,use-dma-tx;
@@ -564,6 +567,7 @@ usart0: serial@fff8c000 {
 			usart1: serial@fff90000 {
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0xfff90000 0x200>;
+				atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
 				interrupts = <8 IRQ_TYPE_LEVEL_HIGH 5>;
 				atmel,use-dma-rx;
 				atmel,use-dma-tx;
@@ -577,6 +581,7 @@ usart1: serial@fff90000 {
 			usart2: serial@fff94000 {
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0xfff94000 0x200>;
+				atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
 				interrupts = <9 IRQ_TYPE_LEVEL_HIGH 5>;
 				atmel,use-dma-rx;
 				atmel,use-dma-tx;
diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
index 09794561c7ce..95f5d76234db 100644
--- a/arch/arm/boot/dts/at91sam9g45.dtsi
+++ b/arch/arm/boot/dts/at91sam9g45.dtsi
@@ -13,6 +13,7 @@
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/clock/at91.h>
+#include <dt-bindings/mfd/at91-usart.h>
 
 / {
 	#address-cells = <1>;
@@ -675,6 +676,7 @@ pioE: gpio@fffffa00 {
 
 			dbgu: serial@ffffee00 {
 				compatible = "atmel,at91sam9260-dbgu", "atmel,at91sam9260-usart";
+				atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
 				reg = <0xffffee00 0x200>;
 				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
 				pinctrl-names = "default";
@@ -687,6 +689,7 @@ dbgu: serial@ffffee00 {
 			usart0: serial@fff8c000 {
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0xfff8c000 0x200>;
+				atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
 				interrupts = <7 IRQ_TYPE_LEVEL_HIGH 5>;
 				atmel,use-dma-rx;
 				atmel,use-dma-tx;
@@ -700,6 +703,7 @@ usart0: serial@fff8c000 {
 			usart1: serial@fff90000 {
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0xfff90000 0x200>;
+				atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
 				interrupts = <8 IRQ_TYPE_LEVEL_HIGH 5>;
 				atmel,use-dma-rx;
 				atmel,use-dma-tx;
@@ -713,6 +717,7 @@ usart1: serial@fff90000 {
 			usart2: serial@fff94000 {
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0xfff94000 0x200>;
+				atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
 				interrupts = <9 IRQ_TYPE_LEVEL_HIGH 5>;
 				atmel,use-dma-rx;
 				atmel,use-dma-tx;
@@ -726,6 +731,7 @@ usart2: serial@fff94000 {
 			usart3: serial@fff98000 {
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0xfff98000 0x200>;
+				atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
 				interrupts = <10 IRQ_TYPE_LEVEL_HIGH 5>;
 				atmel,use-dma-rx;
 				atmel,use-dma-tx;
diff --git a/arch/arm/boot/dts/at91sam9n12.dtsi b/arch/arm/boot/dts/at91sam9n12.dtsi
index 556f35ce49e3..83114d26f10d 100644
--- a/arch/arm/boot/dts/at91sam9n12.dtsi
+++ b/arch/arm/boot/dts/at91sam9n12.dtsi
@@ -11,6 +11,7 @@
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/clock/at91.h>
+#include <dt-bindings/mfd/at91-usart.h>
 
 / {
 	#address-cells = <1>;
@@ -593,6 +594,7 @@ pioD: gpio@fffffa00 {
 			dbgu: serial@fffff200 {
 				compatible = "atmel,at91sam9260-dbgu", "atmel,at91sam9260-usart";
 				reg = <0xfffff200 0x200>;
+				atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
 				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_dbgu>;
@@ -618,6 +620,7 @@ ssc0: ssc@f0010000 {
 			usart0: serial@f801c000 {
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0xf801c000 0x4000>;
+				atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
 				interrupts = <5 IRQ_TYPE_LEVEL_HIGH 5>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_usart0>;
@@ -629,6 +632,7 @@ usart0: serial@f801c000 {
 			usart1: serial@f8020000 {
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0xf8020000 0x4000>;
+				atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
 				interrupts = <6 IRQ_TYPE_LEVEL_HIGH 5>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_usart1>;
@@ -640,6 +644,7 @@ usart1: serial@f8020000 {
 			usart2: serial@f8024000 {
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0xf8024000 0x4000>;
+				atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
 				interrupts = <7 IRQ_TYPE_LEVEL_HIGH 5>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_usart2>;
@@ -651,6 +656,7 @@ usart2: serial@f8024000 {
 			usart3: serial@f8028000 {
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0xf8028000 0x4000>;
+				atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
 				interrupts = <8 IRQ_TYPE_LEVEL_HIGH 5>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_usart3>;
diff --git a/arch/arm/boot/dts/at91sam9rl.dtsi b/arch/arm/boot/dts/at91sam9rl.dtsi
index 12c634811820..364a2ff0a763 100644
--- a/arch/arm/boot/dts/at91sam9rl.dtsi
+++ b/arch/arm/boot/dts/at91sam9rl.dtsi
@@ -11,6 +11,7 @@
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/pwm/pwm.h>
+#include <dt-bindings/mfd/at91-usart.h>
 
 / {
 	#address-cells = <1>;
@@ -175,6 +176,7 @@ i2c1: i2c@fffac000 {
 			usart0: serial@fffb0000 {
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0xfffb0000 0x200>;
+				atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
 				interrupts = <6 IRQ_TYPE_LEVEL_HIGH 5>;
 				atmel,use-dma-rx;
 				atmel,use-dma-tx;
@@ -188,6 +190,7 @@ usart0: serial@fffb0000 {
 			usart1: serial@fffb4000 {
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0xfffb4000 0x200>;
+				atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
 				interrupts = <7 IRQ_TYPE_LEVEL_HIGH 5>;
 				atmel,use-dma-rx;
 				atmel,use-dma-tx;
@@ -201,6 +204,7 @@ usart1: serial@fffb4000 {
 			usart2: serial@fffb8000 {
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0xfffb8000 0x200>;
+				atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
 				interrupts = <8 IRQ_TYPE_LEVEL_HIGH 5>;
 				atmel,use-dma-rx;
 				atmel,use-dma-tx;
@@ -214,6 +218,7 @@ usart2: serial@fffb8000 {
 			usart3: serial@fffbc000 {
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0xfffbc000 0x200>;
+				atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
 				interrupts = <9 IRQ_TYPE_LEVEL_HIGH 5>;
 				atmel,use-dma-rx;
 				atmel,use-dma-tx;
@@ -322,6 +327,7 @@ aic: interrupt-controller@fffff000 {
 			dbgu: serial@fffff200 {
 				compatible = "atmel,at91sam9260-dbgu", "atmel,at91sam9260-usart";
 				reg = <0xfffff200 0x200>;
+				atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
 				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_dbgu>;
diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
index ea3b11336c79..0c26c925761b 100644
--- a/arch/arm/boot/dts/at91sam9x5.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5.dtsi
@@ -13,6 +13,7 @@
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/clock/at91.h>
+#include <dt-bindings/mfd/at91-usart.h>
 
 / {
 	#address-cells = <1>;
@@ -674,6 +675,7 @@ mmc1: mmc@f000c000 {
 			dbgu: serial@fffff200 {
 				compatible = "atmel,at91sam9260-dbgu", "atmel,at91sam9260-usart";
 				reg = <0xfffff200 0x200>;
+				atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
 				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_dbgu>;
@@ -688,6 +690,7 @@ dbgu: serial@fffff200 {
 			usart0: serial@f801c000 {
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0xf801c000 0x200>;
+				atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
 				interrupts = <5 IRQ_TYPE_LEVEL_HIGH 5>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_usart0>;
@@ -702,6 +705,7 @@ usart0: serial@f801c000 {
 			usart1: serial@f8020000 {
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0xf8020000 0x200>;
+				atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
 				interrupts = <6 IRQ_TYPE_LEVEL_HIGH 5>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_usart1>;
@@ -716,6 +720,7 @@ usart1: serial@f8020000 {
 			usart2: serial@f8024000 {
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0xf8024000 0x200>;
+				atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
 				interrupts = <7 IRQ_TYPE_LEVEL_HIGH 5>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_usart2>;
@@ -775,6 +780,7 @@ i2c2: i2c@f8018000 {
 			uart0: serial@f8040000 {
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0xf8040000 0x200>;
+				atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
 				interrupts = <15 IRQ_TYPE_LEVEL_HIGH 5>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_uart0>;
@@ -786,6 +792,7 @@ uart0: serial@f8040000 {
 			uart1: serial@f8044000 {
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0xf8044000 0x200>;
+				atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
 				interrupts = <16 IRQ_TYPE_LEVEL_HIGH 5>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_uart1>;
diff --git a/arch/arm/boot/dts/at91sam9x5_usart3.dtsi b/arch/arm/boot/dts/at91sam9x5_usart3.dtsi
index 098d3fef5c37..a47c765e1b20 100644
--- a/arch/arm/boot/dts/at91sam9x5_usart3.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5_usart3.dtsi
@@ -8,6 +8,7 @@
 
 #include <dt-bindings/pinctrl/at91.h>
 #include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/mfd/at91-usart.h>
 
 / {
 	aliases {
@@ -44,6 +45,7 @@ pinctrl_usart3_sck: usart3_sck-0 {
 			usart3: serial@f8028000 {
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0xf8028000 0x200>;
+				atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
 				interrupts = <8 IRQ_TYPE_LEVEL_HIGH 5>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_usart3>;
diff --git a/arch/arm/boot/dts/sam9x60.dtsi b/arch/arm/boot/dts/sam9x60.dtsi
index d3f60f6a456d..8f5477e307dd 100644
--- a/arch/arm/boot/dts/sam9x60.dtsi
+++ b/arch/arm/boot/dts/sam9x60.dtsi
@@ -12,6 +12,7 @@
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/clock/at91.h>
+#include <dt-bindings/mfd/at91-usart.h>
 #include <dt-bindings/mfd/atmel-flexcom.h>
 
 / {
@@ -583,6 +584,7 @@ aic: interrupt-controller@fffff100 {
 			dbgu: serial@fffff200 {
 				compatible = "microchip,sam9x60-dbgu", "microchip,sam9x60-usart", "atmel,at91sam9260-dbgu", "atmel,at91sam9260-usart";
 				reg = <0xfffff200 0x200>;
+				atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
 				interrupts = <47 IRQ_TYPE_LEVEL_HIGH 7>;
 				dmas = <&dma0
 					(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
index 2c50a021aa76..14c35c12a115 100644
--- a/arch/arm/boot/dts/sama5d2.dtsi
+++ b/arch/arm/boot/dts/sama5d2.dtsi
@@ -9,6 +9,7 @@
 #include <dt-bindings/dma/at91.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/clock/at91.h>
+#include <dt-bindings/mfd/at91-usart.h>
 #include <dt-bindings/iio/adc/at91-sama5d2_adc.h>
 
 / {
@@ -441,6 +442,7 @@ pdmic: pdmic@f8018000 {
 			uart0: serial@f801c000 {
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0xf801c000 0x100>;
+				atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
 				interrupts = <24 IRQ_TYPE_LEVEL_HIGH 7>;
 				dmas = <&dma0
 					(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
@@ -457,6 +459,7 @@ AT91_XDMAC_DT_PERID(35))>,
 			uart1: serial@f8020000 {
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0xf8020000 0x100>;
+				atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
 				interrupts = <25 IRQ_TYPE_LEVEL_HIGH 7>;
 				dmas = <&dma0
 					(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
@@ -473,6 +476,7 @@ AT91_XDMAC_DT_PERID(37))>,
 			uart2: serial@f8024000 {
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0xf8024000 0x100>;
+				atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
 				interrupts = <26 IRQ_TYPE_LEVEL_HIGH 7>;
 				dmas = <&dma0
 					(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
@@ -530,6 +534,7 @@ flx0: flexcom@f8034000 {
 				uart5: serial@200 {
 					compatible = "atmel,at91sam9260-usart";
 					reg = <0x200 0x200>;
+					atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
 					interrupts = <19 IRQ_TYPE_LEVEL_HIGH 7>;
 					clocks = <&pmc PMC_TYPE_PERIPHERAL 19>;
 					clock-names = "usart";
@@ -600,6 +605,7 @@ flx1: flexcom@f8038000 {
 				uart6: serial@200 {
 					compatible = "atmel,at91sam9260-usart";
 					reg = <0x200 0x200>;
+					atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
 					interrupts = <20 IRQ_TYPE_LEVEL_HIGH 7>;
 					clocks = <&pmc PMC_TYPE_PERIPHERAL 20>;
 					clock-names = "usart";
@@ -769,6 +775,7 @@ AT91_XDMAC_DT_PERID(8))>,
 			uart3: serial@fc008000 {
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0xfc008000 0x100>;
+				atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
 				interrupts = <27 IRQ_TYPE_LEVEL_HIGH 7>;
 				dmas = <&dma1
 					(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
@@ -785,6 +792,7 @@ AT91_XDMAC_DT_PERID(41))>,
 			uart4: serial@fc00c000 {
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0xfc00c000 0x100>;
+				atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
 				dmas = <&dma0
 					(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
 					 AT91_XDMAC_DT_PERID(43))>,
@@ -810,6 +818,7 @@ flx2: flexcom@fc010000 {
 				uart7: serial@200 {
 					compatible = "atmel,at91sam9260-usart";
 					reg = <0x200 0x200>;
+					atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
 					interrupts = <21 IRQ_TYPE_LEVEL_HIGH 7>;
 					clocks = <&pmc PMC_TYPE_PERIPHERAL 21>;
 					clock-names = "usart";
@@ -880,6 +889,7 @@ flx3: flexcom@fc014000 {
 				uart8: serial@200 {
 					compatible = "atmel,at91sam9260-usart";
 					reg = <0x200 0x200>;
+					atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
 					interrupts = <22 IRQ_TYPE_LEVEL_HIGH 7>;
 					clocks = <&pmc PMC_TYPE_PERIPHERAL 22>;
 					clock-names = "usart";
@@ -951,6 +961,7 @@ flx4: flexcom@fc018000 {
 				uart9: serial@200 {
 					compatible = "atmel,at91sam9260-usart";
 					reg = <0x200 0x200>;
+					atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
 					interrupts = <23 IRQ_TYPE_LEVEL_HIGH 7>;
 					clocks = <&pmc PMC_TYPE_PERIPHERAL 23>;
 					clock-names = "usart";
diff --git a/arch/arm/boot/dts/sama5d3.dtsi b/arch/arm/boot/dts/sama5d3.dtsi
index 2d0935ad2225..bde8e92d60bb 100644
--- a/arch/arm/boot/dts/sama5d3.dtsi
+++ b/arch/arm/boot/dts/sama5d3.dtsi
@@ -12,6 +12,7 @@
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/clock/at91.h>
+#include <dt-bindings/mfd/at91-usart.h>
 
 / {
 	#address-cells = <1>;
@@ -194,6 +195,7 @@ i2c1: i2c@f0018000 {
 			usart0: serial@f001c000 {
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0xf001c000 0x100>;
+				atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
 				interrupts = <12 IRQ_TYPE_LEVEL_HIGH 5>;
 				dmas = <&dma0 2 AT91_DMA_CFG_PER_ID(3)>,
 				       <&dma0 2 (AT91_DMA_CFG_PER_ID(4) | AT91_DMA_CFG_FIFOCFG_ASAP)>;
@@ -208,6 +210,7 @@ usart0: serial@f001c000 {
 			usart1: serial@f0020000 {
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0xf0020000 0x100>;
+				atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
 				interrupts = <13 IRQ_TYPE_LEVEL_HIGH 5>;
 				dmas = <&dma0 2 AT91_DMA_CFG_PER_ID(5)>,
 				       <&dma0 2 (AT91_DMA_CFG_PER_ID(6) | AT91_DMA_CFG_FIFOCFG_ASAP)>;
@@ -222,6 +225,7 @@ usart1: serial@f0020000 {
 			uart0: serial@f0024000 {
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0xf0024000 0x100>;
+				atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
 				interrupts = <16 IRQ_TYPE_LEVEL_HIGH 5>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_uart0>;
@@ -356,6 +360,7 @@ i2c2: i2c@f801c000 {
 			usart2: serial@f8020000 {
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0xf8020000 0x100>;
+				atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
 				interrupts = <14 IRQ_TYPE_LEVEL_HIGH 5>;
 				dmas = <&dma1 2 AT91_DMA_CFG_PER_ID(7)>,
 				       <&dma1 2 (AT91_DMA_CFG_PER_ID(8) | AT91_DMA_CFG_FIFOCFG_ASAP)>;
@@ -370,6 +375,7 @@ usart2: serial@f8020000 {
 			usart3: serial@f8024000 {
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0xf8024000 0x100>;
+				atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
 				interrupts = <15 IRQ_TYPE_LEVEL_HIGH 5>;
 				dmas = <&dma1 2 AT91_DMA_CFG_PER_ID(9)>,
 				       <&dma1 2 (AT91_DMA_CFG_PER_ID(10) | AT91_DMA_CFG_FIFOCFG_ASAP)>;
@@ -464,6 +470,7 @@ ramc0: ramc@ffffea00 {
 			dbgu: serial@ffffee00 {
 				compatible = "atmel,at91sam9260-dbgu", "atmel,at91sam9260-usart";
 				reg = <0xffffee00 0x200>;
+				atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
 				interrupts = <2 IRQ_TYPE_LEVEL_HIGH 7>;
 				dmas = <&dma1 2 AT91_DMA_CFG_PER_ID(13)>,
 				       <&dma1 2 (AT91_DMA_CFG_PER_ID(14) | AT91_DMA_CFG_FIFOCFG_ASAP)>;
diff --git a/arch/arm/boot/dts/sama5d3_uart.dtsi b/arch/arm/boot/dts/sama5d3_uart.dtsi
index a3eaba995cf4..44d1173f2ffb 100644
--- a/arch/arm/boot/dts/sama5d3_uart.dtsi
+++ b/arch/arm/boot/dts/sama5d3_uart.dtsi
@@ -9,6 +9,7 @@
 #include <dt-bindings/pinctrl/at91.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/clock/at91.h>
+#include <dt-bindings/mfd/at91-usart.h>
 
 / {
 	aliases {
@@ -39,6 +40,7 @@ pinctrl_uart1: uart1-0 {
 			uart0: serial@f0024000 {
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0xf0024000 0x100>;
+				atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
 				interrupts = <16 IRQ_TYPE_LEVEL_HIGH 5>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_uart0>;
@@ -50,6 +52,7 @@ uart0: serial@f0024000 {
 			uart1: serial@f8028000 {
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0xf8028000 0x100>;
+				atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
 				interrupts = <17 IRQ_TYPE_LEVEL_HIGH 5>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_uart1>;
diff --git a/arch/arm/boot/dts/sama5d4.dtsi b/arch/arm/boot/dts/sama5d4.dtsi
index 1e5c01898ccf..af62157ae214 100644
--- a/arch/arm/boot/dts/sama5d4.dtsi
+++ b/arch/arm/boot/dts/sama5d4.dtsi
@@ -8,6 +8,7 @@
 
 #include <dt-bindings/clock/at91.h>
 #include <dt-bindings/dma/at91.h>
+#include <dt-bindings/mfd/at91-usart.h>
 #include <dt-bindings/pinctrl/at91.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/gpio/gpio.h>
@@ -278,6 +279,7 @@ mmc0: mmc@f8000000 {
 			uart0: serial@f8004000 {
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0xf8004000 0x100>;
+				atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
 				interrupts = <27 IRQ_TYPE_LEVEL_HIGH 5>;
 				dmas = <&dma0
 					(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1)
@@ -437,6 +439,7 @@ sfr: sfr@f8028000 {
 			usart0: serial@f802c000 {
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0xf802c000 0x100>;
+				atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
 				interrupts = <6 IRQ_TYPE_LEVEL_HIGH 5>;
 				dmas = <&dma0
 					(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1)
@@ -455,6 +458,7 @@ usart0: serial@f802c000 {
 			usart1: serial@f8030000 {
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0xf8030000 0x100>;
+				atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
 				interrupts = <7 IRQ_TYPE_LEVEL_HIGH 5>;
 				dmas = <&dma0
 					(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1)
@@ -490,6 +494,7 @@ mmc1: mmc@fc000000 {
 			uart1: serial@fc004000 {
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0xfc004000 0x100>;
+				atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
 				interrupts = <28 IRQ_TYPE_LEVEL_HIGH 5>;
 				dmas = <&dma0
 					(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1)
@@ -508,6 +513,7 @@ uart1: serial@fc004000 {
 			usart2: serial@fc008000 {
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0xfc008000 0x100>;
+				atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
 				interrupts = <29 IRQ_TYPE_LEVEL_HIGH 5>;
 				dmas = <&dma1
 					(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1)
@@ -526,6 +532,7 @@ usart2: serial@fc008000 {
 			usart3: serial@fc00c000 {
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0xfc00c000 0x100>;
+				atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
 				interrupts = <30 IRQ_TYPE_LEVEL_HIGH 5>;
 				dmas = <&dma1
 					(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1)
@@ -544,6 +551,7 @@ usart3: serial@fc00c000 {
 			usart4: serial@fc010000 {
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0xfc010000 0x100>;
+				atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
 				interrupts = <31 IRQ_TYPE_LEVEL_HIGH 5>;
 				dmas = <&dma1
 					(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1)
@@ -770,6 +778,7 @@ rtc@fc0686b0 {
 			dbgu: serial@fc069000 {
 				compatible = "atmel,at91sam9260-dbgu", "atmel,at91sam9260-usart";
 				reg = <0xfc069000 0x200>;
+				atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
 				interrupts = <45 IRQ_TYPE_LEVEL_HIGH 7>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_dbgu>;
diff --git a/arch/arm/boot/dts/sama7g5.dtsi b/arch/arm/boot/dts/sama7g5.dtsi
index 249f9c640b6c..7bd8ae8e8d38 100644
--- a/arch/arm/boot/dts/sama7g5.dtsi
+++ b/arch/arm/boot/dts/sama7g5.dtsi
@@ -14,6 +14,7 @@
 #include <dt-bindings/clock/at91.h>
 #include <dt-bindings/dma/at91.h>
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/mfd/at91-usart.h>
 
 / {
 	model = "Microchip SAMA7G5 family SoC";
@@ -603,6 +604,7 @@ flx0: flexcom@e1818000 {
 			uart0: serial@200 {
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0x200 0x200>;
+				atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
 				interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&pmc PMC_TYPE_PERIPHERAL 38>;
 				clock-names = "usart";
@@ -651,6 +653,7 @@ flx3: flexcom@e1824000 {
 			uart3: serial@200 {
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0x200 0x200>;
+				atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
 				interrupts = <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&pmc PMC_TYPE_PERIPHERAL 41>;
 				clock-names = "usart";
@@ -694,6 +697,7 @@ flx4: flexcom@e2018000 {
 			uart4: serial@200 {
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0x200 0x200>;
+				atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
 				interrupts = <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&pmc PMC_TYPE_PERIPHERAL 42>;
 				clock-names = "usart";
@@ -719,6 +723,7 @@ flx7: flexcom@e2024000 {
 			uart7: serial@200 {
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0x200 0x200>;
+				atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
 				interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&pmc PMC_TYPE_PERIPHERAL 45>;
 				clock-names = "usart";
-- 
2.34.1

