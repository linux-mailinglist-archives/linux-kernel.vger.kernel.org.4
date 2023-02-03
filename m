Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03723688E2C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 04:49:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232050AbjBCDtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 22:49:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231277AbjBCDtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 22:49:04 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 976547B40F;
        Thu,  2 Feb 2023 19:49:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1675396141; x=1706932141;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1AkioPAmaGGCya2gZ7629DIo0jjKlLKAh9uNoP/tX6M=;
  b=kVzAg5Kzo4fQF4J0LPehpkVVadaTiuvKLt4SXywuPYlRllNI2DLLv90D
   dp9CC6gMplmrxR/TPiQBttZrZEYlkI6GynzW/AC9eLyvX+g31xiwNQWpW
   SL5l/3ihP7REXIL6+aGAVZkRhE9Z0ZZcBtZNzR6Wbht9h37Uv5TWbIsNF
   6g6BNNEaMWJECND7cd1PL+J6lqgFwk06sZ0+ZAyXsHGg7jOjfjKdm4NAy
   JqRruXGKYjl2HSCwmZNvveLy9RvehW2+t9OKbjO9HQMv4iYsxLpWJ5NYF
   5hxyFihEEsPhsdX+aIbYleFIJUTwMtl59BSFD3+7x7B9UK4/56TrOFf44
   Q==;
X-IronPort-AV: E=Sophos;i="5.97,269,1669100400"; 
   d="scan'208";a="210425618"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Feb 2023 20:49:00 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 2 Feb 2023 20:49:01 -0700
Received: from che-lt-i66125lx.amer.actel.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.16 via Frontend Transport; Thu, 2 Feb 2023 20:48:51 -0700
From:   Durai Manickam KR <durai.manickamkr@microchip.com>
To:     <Hari.PrasathGE@microchip.com>,
        <balamanikandan.gunasundar@microchip.com>,
        <manikandan.m@microchip.com>, <varshini.rajendran@microchip.com>,
        <dharma.b@microchip.com>, <nayabbasha.sayed@microchip.com>,
        <balakrishnan.s@microchip.com>, <claudiu.beznea@microchip.com>,
        <cristian.birsan@microchip.com>, <nicolas.ferre@microchip.com>,
        <krzysztof.kozlowski@linaro.org>, <alexandre.belloni@bootlin.com>,
        <davem@davemloft.net>, <arnd@arndb.de>, <olof@lixom.net>,
        <soc@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Kavyasree.Kotagiri@microchip.com>,
        <Horatiu.Vultur@microchip.com>, <robh+dt@kernel.org>,
        <andrew@lunn.ch>, <michael@walle.cc>, <jerry.ray@microchip.com>
CC:     Durai Manickam KR <durai.manickamkr@microchip.com>
Subject: [PATCH v5 1/8] ARM: dts: at91: sam9x60: Fix the label numbering for the flexcom functions
Date:   Fri, 3 Feb 2023 09:18:26 +0530
Message-ID: <20230203034833.451461-2-durai.manickamkr@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230203034833.451461-1-durai.manickamkr@microchip.com>
References: <20230203034833.451461-1-durai.manickamkr@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Manikandan Muralidharan <manikandan.m@microchip.com>

Fixed the label numbering of the flexcom functions so that all
13 flexcom functions of sam9x60 are in the following order when the missing
flexcom functions are added:

flx0: uart0, spi0, i2c0
flx1: uart1, spi1, i2c1
flx2: uart2, spi2, i2c2
flx3: uart3, spi3, i2c3
flx4: uart4, spi4, i2c4
flx5: uart5, spi5, i2c5
flx6: uart6, i2c6
flx7: uart7, i2c7
flx8: uart8, i2c8
flx9: uart9, i2c9
flx10: uart10, i2c10
flx11: uart11, i2c11
flx12: uart12, i2c12

Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
Signed-off-by: Durai Manickam KR <durai.manickamkr@microchip.com>
---
 arch/arm/boot/dts/at91-sam9x60ek.dts | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/at91-sam9x60ek.dts b/arch/arm/boot/dts/at91-sam9x60ek.dts
index d929c1ba5789..cf5d786531f2 100644
--- a/arch/arm/boot/dts/at91-sam9x60ek.dts
+++ b/arch/arm/boot/dts/at91-sam9x60ek.dts
@@ -16,8 +16,8 @@ / {
 
 	aliases {
 		i2c0 = &i2c0;
-		i2c1 = &i2c1;
-		serial1 = &uart1;
+		i2c1 = &i2c6;
+		serial1 = &uart5;
 	};
 
 	chosen {
@@ -234,7 +234,7 @@ &flx4 {
 	atmel,flexcom-mode = <ATMEL_FLEXCOM_MODE_SPI>;
 	status = "disabled";
 
-	spi0: spi@400 {
+	spi4: spi@400 {
 		compatible = "microchip,sam9x60-spi", "atmel,at91rm9200-spi";
 		reg = <0x400 0x200>;
 		interrupts = <13 IRQ_TYPE_LEVEL_HIGH 7>;
@@ -253,7 +253,7 @@ &flx5 {
 	atmel,flexcom-mode = <ATMEL_FLEXCOM_MODE_USART>;
 	status = "okay";
 
-	uart1: serial@200 {
+	uart5: serial@200 {
 		compatible = "microchip,sam9x60-dbgu", "microchip,sam9x60-usart", "atmel,at91sam9260-dbgu", "atmel,at91sam9260-usart";
 		reg = <0x200 0x200>;
 		atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
@@ -279,7 +279,7 @@ &flx6 {
 	atmel,flexcom-mode = <ATMEL_FLEXCOM_MODE_TWI>;
 	status = "okay";
 
-	i2c1: i2c@600 {
+	i2c6: i2c@600 {
 		compatible = "microchip,sam9x60-i2c";
 		reg = <0x600 0x200>;
 		interrupts = <9 IRQ_TYPE_LEVEL_HIGH 7>;
@@ -439,7 +439,7 @@ AT91_PIOA 13 AT91_PERIPH_A AT91_PINCTRL_NONE
 				 AT91_PIOA 14 AT91_PERIPH_A AT91_PINCTRL_NONE>;
 		};
 
-		pinctrl_flx5_default: flx_uart {
+		pinctrl_flx5_default: flx5_uart {
 			atmel,pins =
 				<AT91_PIOA 7 AT91_PERIPH_C AT91_PINCTRL_NONE
 				 AT91_PIOA 8 AT91_PERIPH_B AT91_PINCTRL_NONE
-- 
2.25.1

