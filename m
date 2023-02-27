Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB36C6A4947
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 19:08:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbjB0SI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 13:08:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230362AbjB0SIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 13:08:23 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D735C162;
        Mon, 27 Feb 2023 10:08:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1677521287; x=1709057287;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uGfudpPPBewHcSdcBwT5jvm880EuRGAkt0xWNtVELqo=;
  b=uuYrWn0UppalZyxTc5eRcHt7Df3VHpF1N1dz7GskoKTutqCONNEWdpy+
   AdO+3vXEN9n4w73pQYLeqSAYmyPs3bugxO25ZK9IVzFxJeZHKpWVEuV7r
   cKeUAxa3OXIkA/4qoLRBrfDNXa2COZ/RYHGqThTNWpv48SavJzsS6ejRZ
   LzHxx2TEkLaCg7bfCqny3U1GTG1ZP6xyDW6FGND5l7K1F7fuGioOgcbi5
   vB58cXclgDPAKnveJ1VviFBEngCgXlz+6s/jlpsbi9rnjkhWUyfLLHpS0
   7sCaTThs4QRHOq/RrM7ISYBT8cNJ2UPS1qt3dOiKUDElwWk9+rI1seTVF
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,219,1673938800"; 
   d="scan'208";a="202436835"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 27 Feb 2023 11:07:27 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 27 Feb 2023 11:07:20 -0700
Received: from ryan-Precision-3630-Tower.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.16 via Frontend Transport; Mon, 27 Feb 2023 11:07:20 -0700
From:   <Ryan.Wanner@microchip.com>
To:     <ludovic.desroches@microchip.com>, <linus.walleij@linaro.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <claudiu.beznea@microchip.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Ryan Wanner <Ryan.Wanner@microchip.com>
Subject: [PATCH v3 2/2] dt-bindings:pinctrl:at91:Adding macros for sama7g5
Date:   Mon, 27 Feb 2023 11:07:28 -0700
Message-ID: <936fd3060662becd5485e32d5947286fcf0a3502.1677520830.git.Ryan.Wanner@microchip.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1677520830.git.Ryan.Wanner@microchip.com>
References: <cover.1677520830.git.Ryan.Wanner@microchip.com>
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
changes since v1:
- Fix ABI break.
- Add explanation for drive strength macros.

changes since v2:
-Fix subject prefix to match subsystem.
-Add more in-depth discription of sama7g5 define values.
-Fix formatting issues.

 include/dt-bindings/pinctrl/at91.h | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/include/dt-bindings/pinctrl/at91.h b/include/dt-bindings/pinctrl/at91.h
index e8e117306b1b..a02bee76b1fb 100644
--- a/include/dt-bindings/pinctrl/at91.h
+++ b/include/dt-bindings/pinctrl/at91.h
@@ -42,8 +42,21 @@
 #define AT91_PERIPH_C		3
 #define AT91_PERIPH_D		4
 
-#define ATMEL_PIO_DRVSTR_LO	1
+/*These macros are for all other at91 pinctrl drivers*/
+#define ATMEL_PIO_DRVSTR_LO	0
+#define ATMEL_PIO_DRVSTR_LO_1	1
 #define ATMEL_PIO_DRVSTR_ME	2
 #define ATMEL_PIO_DRVSTR_HI	3
 
+/* These macros are for the sama7g5 pinctrl driver
+ * Low D is low drive for GPIO mode or any non high-speed peripheral else Type D output impedance
+ * Hi A is high drive for GPIO mode or any non high-speed peripheral else Type A output impedance
+ * Low C is low drive for GPIO mode or any non high-speed peripheral else Type C output impedance
+ * Low B is low drive for GPIO mode or any non high-speed peripheral else Type B output impedance
+*/
+#define ATMEL_PIO_DRVSTR_LO_D	0
+#define ATMEL_PIO_DRVSTR_HI_A	1
+#define ATMEL_PIO_DRVSTR_LO_C	2
+#define ATMEL_PIO_DRVSTR_LO_B	3
+
 #endif /* __DT_BINDINGS_AT91_PINCTRL_H__ */
-- 
2.37.2

