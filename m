Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C3CA6008B6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 10:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbiJQIbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 04:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbiJQIbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 04:31:38 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B29FBC91;
        Mon, 17 Oct 2022 01:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1665995497; x=1697531497;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6Ba4r7Z2zK0pHmIj2H/qZpv6Aa24ieH3Lrajx9mOXQg=;
  b=MWcfOR9LEsdng6KDekXyA3YgZC/TMFUGNmTTWMENnVTXT6SJ8olPiOdY
   Z8uanYyVZxdgMVYNSTf6eKA2qTUWdwmlaVjZ/Fy9aXJPAGsNXb+sQiyqR
   fsBVIIHSxwiIDuwLS3fY6drAlRDKEf7Pb2dXDRwk1hq4DiJXyfLy2NisR
   V8NyMWfTzYVMCpxmPMWcEDEm2ux5RND50KoQCZ8rA3NHv0GZ4cAtrwmqw
   ANduqqT8W8I50gjHnFMZkoOgOxCDawIo3X7FpV1EIa7PFKJK30/VuGt3+
   6fPDy2/ZDuQA+Shsw/blVhrrCGQ7LqPjyLB3pWmgQ1SEVryxFsQBe2TR4
   g==;
X-IronPort-AV: E=Sophos;i="5.95,191,1661842800"; 
   d="scan'208";a="182474316"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Oct 2022 01:31:36 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Mon, 17 Oct 2022 01:31:35 -0700
Received: from virtualbox.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Mon, 17 Oct 2022 01:31:32 -0700
From:   Mihai Sain <mihai.sain@microchip.com>
To:     <robh+dt@kernel.org>, <eugen.hristev@microchip.com>,
        <claudiu.beznea@microchip.com>, <nicolas.ferre@microchip.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Mihai Sain <mihai.sain@microchip.com>
Subject: [PATCH] ARM: dts: at91: sama7g5: fix signal name of pin PB2
Date:   Mon, 17 Oct 2022 11:31:19 +0300
Message-ID: <20221017083119.1643-1-mihai.sain@microchip.com>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The signal name of pin PB2 with function F is FLEXCOM11_IO1
as it is defined in the datasheet.

Fixes: 7540629e2fc7 ("ARM: dts: at91: add sama7g5 SoC DT and sama7g5-ek")
Signed-off-by: Mihai Sain <mihai.sain@microchip.com>
---
 arch/arm/boot/dts/sama7g5-pinfunc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sama7g5-pinfunc.h b/arch/arm/boot/dts/sama7g5-pinfunc.h
index 4eb30445d205..6e87f0d4b8fc 100644
--- a/arch/arm/boot/dts/sama7g5-pinfunc.h
+++ b/arch/arm/boot/dts/sama7g5-pinfunc.h
@@ -261,7 +261,7 @@
 #define PIN_PB2__FLEXCOM6_IO0		PINMUX_PIN(PIN_PB2, 2, 1)
 #define PIN_PB2__ADTRG			PINMUX_PIN(PIN_PB2, 3, 1)
 #define PIN_PB2__A20			PINMUX_PIN(PIN_PB2, 4, 1)
-#define PIN_PB2__FLEXCOM11_IO0		PINMUX_PIN(PIN_PB2, 6, 3)
+#define PIN_PB2__FLEXCOM11_IO1		PINMUX_PIN(PIN_PB2, 6, 3)
 #define PIN_PB3				35
 #define PIN_PB3__GPIO			PINMUX_PIN(PIN_PB3, 0, 0)
 #define PIN_PB3__RF1			PINMUX_PIN(PIN_PB3, 1, 1)
-- 
2.38.0

