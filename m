Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18E6D699FB8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 23:25:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbjBPWZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 17:25:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbjBPWZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 17:25:22 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA8D2558A;
        Thu, 16 Feb 2023 14:25:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1676586321; x=1708122321;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MY99QrfOBLMmoR5qfOBBHic4fkNzKFK/inr8InHiPlo=;
  b=BzN0k7gn72inAs2uKFv6lYLyR2/Nl4pUcLLijd2UcGMaBIQh40xF1x1M
   A2Gz4anC8vBkHabhrjLJTUWZbOy3KLuZlb2wsOvkWpvxd/7+vPZgv44U3
   Zu8/FREvMNyLwOYKfWw2Sff3Rx8M3lqMZd5SBxnq8KaGs9fSpOkugHbPD
   QaAnAhE10FkAjbZPBHFtiSwAs58/Z+tfCkYwJYyMKgn62awfg0tiAcw36
   HZ7hUEhH9QHpLQi4SP/vritMRO5iG4LvxApoTGsjVfUCoz2hG3DmYKYoX
   PQ/aLmsTsPOqySs7kEdztT0THDSctWJnDIVU+zbiaNHsN8ytcuSF+YoSI
   Q==;
X-IronPort-AV: E=Sophos;i="5.97,304,1669100400"; 
   d="scan'208";a="201366783"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Feb 2023 15:25:17 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 16 Feb 2023 15:25:16 -0700
Received: from ryan-Precision-3630-Tower.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.16 via Frontend Transport; Thu, 16 Feb 2023 15:25:16 -0700
From:   <Ryan.Wanner@microchip.com>
To:     <linus.walleij@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <claudiu.beznea@microchip.com>,
        <ludovic.desroches@microchip.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Ryan Wanner <Ryan.Wanner@microchip.com>
Subject: [PATCH v2 2/2] ARM: at91: dt: adding new macros
Date:   Thu, 16 Feb 2023 15:25:24 -0700
Message-ID: <20230216222524.3107759-3-Ryan.Wanner@microchip.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230216222524.3107759-1-Ryan.Wanner@microchip.com>
References: <20230216222524.3107759-1-Ryan.Wanner@microchip.com>
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

From: Ryan Wanner <Ryan.Wanner@microchip.com>

Adding macros for sama7g drive strength.

Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
---
changes from v1:
- Fix ABI break.
- Add some small comments to describe drive strength macros.

 include/dt-bindings/pinctrl/at91.h | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/include/dt-bindings/pinctrl/at91.h b/include/dt-bindings/pinctrl/at91.h
index e8e117306b1b..12f3edf2a9c4 100644
--- a/include/dt-bindings/pinctrl/at91.h
+++ b/include/dt-bindings/pinctrl/at91.h
@@ -42,8 +42,16 @@
 #define AT91_PERIPH_C		3
 #define AT91_PERIPH_D		4
 
-#define ATMEL_PIO_DRVSTR_LO	1
+/*These macros are for all other at91 pinctrl drivers*/
+#define ATMEL_PIO_DRVSTR_LO	0
+#define ATMEL_PIO_DRVSTR_LO_1	1
 #define ATMEL_PIO_DRVSTR_ME	2
 #define ATMEL_PIO_DRVSTR_HI	3
 
+/* These macros are for the sama7g5 pinctrl driver*/
+#define ATMEL_PIO_DRVSTR_LO_D 0
+#define ATMEL_PIO_DRVSTR_HI_A 1
+#define ATMEL_PIO_DRVSTR_LO_C 2
+#define ATMEL_PIO_DRVSTR_LO_B 3
+
 #endif /* __DT_BINDINGS_AT91_PINCTRL_H__ */
-- 
2.37.2

