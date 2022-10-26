Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73C5E60E0E7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 14:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233448AbiJZMj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 08:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233724AbiJZMjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 08:39:15 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C99C6EACAB;
        Wed, 26 Oct 2022 05:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1666787954; x=1698323954;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7Q2KAd71fow7wlc7aycbUt81QTVPZDQM+BUBUDvA8iY=;
  b=Ev9L7ibQVwTlHcKKcUzFyJcVWfovxwNXWYsRGsDVMSpx2wa6XNXP282S
   OzSATtu5rK4hfEl5nWpJkGniwh6Dj5B/OBFN4ZpB1DSvvydlqXazj0EAI
   Q87CluQhdeBIXCIEMeJfC10AGBHzMITe+zVq2wFLzvnXYeJnXakXMd2i0
   eFiECaMsJYd2HrCX7osiog+PF/FwdxXL8ka/xMztfey6lkrz8hcMjeJ92
   Q41CCZ569QQBsOjpP1nk4SzmHmTX1jWaIWe+Ivd4yntTn3lP3yiKkTlrB
   X3up9TVBlw1Og5CuEVTmhm3EwubP2LXoscBXnIw0kiOUjTJWagSV7XVRh
   A==;
X-IronPort-AV: E=Sophos;i="5.95,214,1661842800"; 
   d="scan'208";a="180590354"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Oct 2022 05:39:13 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 26 Oct 2022 05:39:10 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Wed, 26 Oct 2022 05:39:08 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <linux@armlinux.org.uk>, <arnd@arndb.de>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 03/11] ARM: dts: at91: sama7g5: add io-channel-cells to adc node
Date:   Wed, 26 Oct 2022 15:41:06 +0300
Message-ID: <20221026124114.985876-4-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20221026124114.985876-1-claudiu.beznea@microchip.com>
References: <20221026124114.985876-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add io-channel-cell to ADC node. It is necessary for DT users of ADC.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/boot/dts/sama7g5.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/sama7g5.dtsi b/arch/arm/boot/dts/sama7g5.dtsi
index ccba1ba5336d..1599b911c97e 100644
--- a/arch/arm/boot/dts/sama7g5.dtsi
+++ b/arch/arm/boot/dts/sama7g5.dtsi
@@ -421,6 +421,7 @@ adc: adc@e1000000 {
 			atmel,min-sample-rate-hz = <200000>;
 			atmel,max-sample-rate-hz = <20000000>;
 			atmel,startup-time-ms = <4>;
+			#io-channel-cells = <1>;
 			status = "disabled";
 		};
 
-- 
2.34.1

