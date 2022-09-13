Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D69795B759A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 17:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232508AbiIMPwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 11:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234356AbiIMPvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 11:51:50 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 409D08E0E2;
        Tue, 13 Sep 2022 07:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1663080830; x=1694616830;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pLJ8priI7RmY67VypJNLPFkfcfxWAxaQ7nFJHrNbVhI=;
  b=neolalmZlbeg0Cd8OmeZQeOnG7uEwFZyCMvomSBD5w15HJAPJteumXOU
   +P/h8/TjVldCi8NOYeEkYmZ8KlbaIdTd33EhmwDfrBYYCJ2aUf8xXKdDC
   aMcXqXjBCuFx7ntVH94TqY0k3ryLCX6sursai79XeQYOXeWfATUVVLYo6
   Km5auT4V1i9fB3gtyoFwrZOMc2gue0T0Qq1IUBXcxsp3ooV9oG927Rgog
   cyzBjpgRRJ4Uc+vKYDZ2IxWx4AhSU4X4Qz6o7rcQekwTQf5h1jHdlaXxD
   Nvspvsl03zKeLVsGm4rxzhv34QgbXbJuyg6LQio0SAt3Vbz0LMo4S46S4
   w==;
X-IronPort-AV: E=Sophos;i="5.93,313,1654585200"; 
   d="scan'208";a="190643859"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Sep 2022 07:24:55 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 13 Sep 2022 07:24:55 -0700
Received: from ROB-ULT-M68701.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Tue, 13 Sep 2022 07:24:50 -0700
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
Subject: [PATCH v3 02/14] ARM: dts: at91: sam9x60ek: Add DBGU compatibles to uart1
Date:   Tue, 13 Sep 2022 17:21:54 +0300
Message-ID: <20220913142205.162399-3-sergiu.moga@microchip.com>
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

Maintain consistency among the compatibles of the serial nodes of
sam9x60ek and highlight the incremental characteristic of its serial
IP's by making sure that all serial nodes contain both the sam9x60
and sam9260 usart/dbgu compatibles.

Signed-off-by: Sergiu Moga <sergiu.moga@microchip.com>
---


v1 -> v2:
- Nothing, this patch was not here before


v2 -> v3:
- Nothing, previously this was [PATCH 4]



 arch/arm/boot/dts/at91-sam9x60ek.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/at91-sam9x60ek.dts b/arch/arm/boot/dts/at91-sam9x60ek.dts
index 7ade9979e1c6..67bce8d60908 100644
--- a/arch/arm/boot/dts/at91-sam9x60ek.dts
+++ b/arch/arm/boot/dts/at91-sam9x60ek.dts
@@ -258,7 +258,7 @@ &flx5 {
 	status = "okay";
 
 	uart1: serial@200 {
-		compatible = "microchip,sam9x60-usart", "atmel,at91sam9260-usart";
+		compatible = "microchip,sam9x60-dbgu", "microchip,sam9x60-usart", "atmel,at91sam9260-dbgu", "atmel,at91sam9260-usart";
 		reg = <0x200 0x200>;
 		interrupts = <14 IRQ_TYPE_LEVEL_HIGH 7>;
 		dmas = <&dma0
-- 
2.34.1

