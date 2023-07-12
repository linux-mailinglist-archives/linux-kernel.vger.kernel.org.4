Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD49875040A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 12:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232260AbjGLKB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 06:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232989AbjGLKA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 06:00:57 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22A5D1712;
        Wed, 12 Jul 2023 03:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1689156056; x=1720692056;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ghNugLqQAvBbZy9Tk0TttINi11WxlS1QwI84imFrjHY=;
  b=FwCOhJSTQS4XMTaPd/0JkAUKqGHqOs1MvE1UbZzPrvjP7vDkWfOJMOke
   VD4M4G9aUEQoAw9FHjnMbkGdEUkBTzt65UYjiNNya0JT9S0/51ypNvojp
   EuqsDEX9fxTsApLXX5YyQBEKTMoUJtPFVEvngjh7lPYS2Idwka+FhJeZE
   5abofuOduAyoVGNlwye9z2wFSG4YEOEHLhsLIRJV8vDm1Uv2uTWqp7g4u
   WILSsm3pRZqz67a8vnOMkujOY4FLZg4Ojhpnbx1ljNSa2EwoIahJLKAfB
   3Cn6O1mZZXUtagx2cCXmxCDA8bsGdgclYOxOigtsuact+b9XoZa1IxiLG
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,199,1684825200"; 
   d="scan'208";a="223325195"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 Jul 2023 03:00:55 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 12 Jul 2023 03:00:55 -0700
Received: from che-lt-i66125lx.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Wed, 12 Jul 2023 03:00:44 -0700
From:   Durai Manickam KR <durai.manickamkr@microchip.com>
To:     <Hari.PrasathGE@microchip.com>,
        <balamanikandan.gunasundar@microchip.com>,
        <manikandan.m@microchip.com>, <varshini.rajendran@microchip.com>,
        <dharma.b@microchip.com>, <nayabbasha.sayed@microchip.com>,
        <balakrishnan.s@microchip.com>, <cristian.birsan@microchip.com>,
        <nicolas.ferre@microchip.com>, <krzysztof.kozlowski@linaro.org>,
        <alexandre.belloni@bootlin.com>, <davem@davemloft.net>,
        <arnd@arndb.de>, <olof@lixom.net>, <soc@kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Kavyasree.Kotagiri@microchip.com>,
        <Horatiu.Vultur@microchip.com>, <robh+dt@kernel.org>,
        <andrew@lunn.ch>, <michael@walle.cc>, <jerry.ray@microchip.com>,
        <conor+dt@kernel.org>, <jesper.nilsson@axis.com>,
        <sergiu.moga@microchip.com>, <andre.przywara@arm.com>,
        <ada@thorsis.com>
CC:     Durai Manickam KR <durai.manickamkr@microchip.com>
Subject: [PATCH] ARM: dts: at91: sam9x60: fix the SOC detection
Date:   Wed, 12 Jul 2023 15:30:42 +0530
Message-ID: <20230712100042.317856-1-durai.manickamkr@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the dbgu compatible strings in the UART submodule of the
flexcom for the proper SOC detection.

Fixes: 99c808335877 (ARM: dts: at91: sam9x60: Add missing flexcom definitions)
Signed-off-by: Durai Manickam KR <durai.manickamkr@microchip.com>
---
 arch/arm/boot/dts/microchip/sam9x60.dtsi | 26 ++++++++++++------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/arm/boot/dts/microchip/sam9x60.dtsi b/arch/arm/boot/dts/microchip/sam9x60.dtsi
index 8b53997675e7..73d570a17269 100644
--- a/arch/arm/boot/dts/microchip/sam9x60.dtsi
+++ b/arch/arm/boot/dts/microchip/sam9x60.dtsi
@@ -172,7 +172,7 @@ flx4: flexcom@f0000000 {
 				status = "disabled";
 
 				uart4: serial@200 {
-					compatible = "microchip,sam9x60-dbgu", "microchip,sam9x60-usart", "atmel,at91sam9260-dbgu", "atmel,at91sam9260-usart";
+					compatible = "microchip,sam9x60-usart", "atmel,at91sam9260-usart";
 					reg = <0x200 0x200>;
 					interrupts = <13 IRQ_TYPE_LEVEL_HIGH 7>;
 					dmas = <&dma0
@@ -240,7 +240,7 @@ flx5: flexcom@f0004000 {
 				status = "disabled";
 
 				uart5: serial@200 {
-					compatible = "microchip,sam9x60-dbgu", "microchip,sam9x60-usart", "atmel,at91sam9260-dbgu", "atmel,at91sam9260-usart";
+					compatible = "microchip,sam9x60-usart", "atmel,at91sam9260-usart";
 					reg = <0x200 0x200>;
 					atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
 					interrupts = <14 IRQ_TYPE_LEVEL_HIGH 7>;
@@ -370,7 +370,7 @@ flx11: flexcom@f0020000 {
 				status = "disabled";
 
 				uart11: serial@200 {
-					compatible = "microchip,sam9x60-dbgu", "microchip,sam9x60-usart", "atmel,at91sam9260-dbgu", "atmel,at91sam9260-usart";
+					compatible = "microchip,sam9x60-usart", "atmel,at91sam9260-usart";
 					reg = <0x200 0x200>;
 					interrupts = <32 IRQ_TYPE_LEVEL_HIGH 7>;
 					dmas = <&dma0
@@ -419,7 +419,7 @@ flx12: flexcom@f0024000 {
 				status = "disabled";
 
 				uart12: serial@200 {
-					compatible = "microchip,sam9x60-dbgu", "microchip,sam9x60-usart", "atmel,at91sam9260-dbgu", "atmel,at91sam9260-usart";
+					compatible = "microchip,sam9x60-usart", "atmel,at91sam9260-usart";
 					reg = <0x200 0x200>;
 					interrupts = <33 IRQ_TYPE_LEVEL_HIGH 7>;
 					dmas = <&dma0
@@ -576,7 +576,7 @@ flx6: flexcom@f8010000 {
 				status = "disabled";
 
 				uart6: serial@200 {
-					compatible = "microchip,sam9x60-dbgu", "microchip,sam9x60-usart", "atmel,at91sam9260-dbgu", "atmel,at91sam9260-usart";
+					compatible = "microchip,sam9x60-usart", "atmel,at91sam9260-usart";
 					reg = <0x200 0x200>;
 					interrupts = <9 IRQ_TYPE_LEVEL_HIGH 7>;
 					dmas = <&dma0
@@ -625,7 +625,7 @@ flx7: flexcom@f8014000 {
 				status = "disabled";
 
 				uart7: serial@200 {
-					compatible = "microchip,sam9x60-dbgu", "microchip,sam9x60-usart", "atmel,at91sam9260-dbgu", "atmel,at91sam9260-usart";
+					compatible = "microchip,sam9x60-usart", "atmel,at91sam9260-usart";
 					reg = <0x200 0x200>;
 					interrupts = <10 IRQ_TYPE_LEVEL_HIGH 7>;
 					dmas = <&dma0
@@ -674,7 +674,7 @@ flx8: flexcom@f8018000 {
 				status = "disabled";
 
 				uart8: serial@200 {
-					compatible = "microchip,sam9x60-dbgu", "microchip,sam9x60-usart", "atmel,at91sam9260-dbgu", "atmel,at91sam9260-usart";
+					compatible = "microchip,sam9x60-usart", "atmel,at91sam9260-usart";
 					reg = <0x200 0x200>;
 					interrupts = <11 IRQ_TYPE_LEVEL_HIGH 7>;
 					dmas = <&dma0
@@ -723,7 +723,7 @@ flx0: flexcom@f801c000 {
 				status = "disabled";
 
 				uart0: serial@200 {
-					compatible = "microchip,sam9x60-dbgu", "microchip,sam9x60-usart", "atmel,at91sam9260-dbgu", "atmel,at91sam9260-usart";
+					compatible = "microchip,sam9x60-usart", "atmel,at91sam9260-usart";
 					reg = <0x200 0x200>;
 					interrupts = <5 IRQ_TYPE_LEVEL_HIGH 7>;
 					dmas = <&dma0
@@ -791,7 +791,7 @@ flx1: flexcom@f8020000 {
 				status = "disabled";
 
 				uart1: serial@200 {
-					compatible = "microchip,sam9x60-dbgu", "microchip,sam9x60-usart", "atmel,at91sam9260-dbgu", "atmel,at91sam9260-usart";
+					compatible = "microchip,sam9x60-usart", "atmel,at91sam9260-usart";
 					reg = <0x200 0x200>;
 					interrupts = <6 IRQ_TYPE_LEVEL_HIGH 7>;
 					dmas = <&dma0
@@ -859,7 +859,7 @@ flx2: flexcom@f8024000 {
 				status = "disabled";
 
 				uart2: serial@200 {
-					compatible = "microchip,sam9x60-dbgu", "microchip,sam9x60-usart", "atmel,at91sam9260-dbgu", "atmel,at91sam9260-usart";
+					compatible = "microchip,sam9x60-usart", "atmel,at91sam9260-usart";
 					reg = <0x200 0x200>;
 					interrupts = <7 IRQ_TYPE_LEVEL_HIGH 7>;
 					dmas = <&dma0
@@ -927,7 +927,7 @@ flx3: flexcom@f8028000 {
 				status = "disabled";
 
 				uart3: serial@200 {
-					compatible = "microchip,sam9x60-dbgu", "microchip,sam9x60-usart", "atmel,at91sam9260-dbgu", "atmel,at91sam9260-usart";
+					compatible = "microchip,sam9x60-usart", "atmel,at91sam9260-usart";
 					reg = <0x200 0x200>;
 					interrupts = <8 IRQ_TYPE_LEVEL_HIGH 7>;
 					dmas = <&dma0
@@ -1050,7 +1050,7 @@ flx9: flexcom@f8040000 {
 				status = "disabled";
 
 				uart9: serial@200 {
-					compatible = "microchip,sam9x60-dbgu", "microchip,sam9x60-usart", "atmel,at91sam9260-dbgu", "atmel,at91sam9260-usart";
+					compatible = "microchip,sam9x60-usart", "atmel,at91sam9260-usart";
 					reg = <0x200 0x200>;
 					interrupts = <15 IRQ_TYPE_LEVEL_HIGH 7>;
 					dmas = <&dma0
@@ -1099,7 +1099,7 @@ flx10: flexcom@f8044000 {
 				status = "disabled";
 
 				uart10: serial@200 {
-					compatible = "microchip,sam9x60-dbgu", "microchip,sam9x60-usart", "atmel,at91sam9260-dbgu", "atmel,at91sam9260-usart";
+					compatible = "microchip,sam9x60-usart", "atmel,at91sam9260-usart";
 					reg = <0x200 0x200>;
 					interrupts = <16 IRQ_TYPE_LEVEL_HIGH 7>;
 					dmas = <&dma0
-- 
2.25.1

