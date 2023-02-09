Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67DBC690D7E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 16:47:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbjBIPrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 10:47:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231230AbjBIPrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 10:47:15 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7DB9658D1;
        Thu,  9 Feb 2023 07:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1675957603; x=1707493603;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cRZrnanpYDkbJPYdwlxFjU/jZt2cfSVpf0RQ5VKig+c=;
  b=iDUemL93Q4KHdXG7inlZouW4qZLktiUe/WGT5cTij6V3Axg7K8026Wrs
   rwaCsj/7KJAFlMSWP27Lt5k7AifK/4gSHwG/3DhCXw5GT3t38E6USdGt9
   1MKr82vHyti/IV43ZJlqGE0GExm1uxmczhnB0+ghpsSQl39r/+Cgb4uFz
   gL0sjyP/iAZmMWON8uy6C8uavhKd36DLPgRl8SCyKf0bMaB6WV0IP5sdd
   f1PvUpnfEINJVzva2Zp41TzcfbDZxgWCLGeUwrQAVhLiZ5FAChpxd7w1R
   fJIWa/ktzNQTuyPKs6xhbzEFHVikcVDYBbqcdENfoTYasbAcsj2Ja/APE
   Q==;
X-IronPort-AV: E=Sophos;i="5.97,284,1669100400"; 
   d="scan'208";a="211286114"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Feb 2023 08:45:37 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 9 Feb 2023 08:45:35 -0700
Received: from ryan-Precision-3630-Tower.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.16 via Frontend Transport; Thu, 9 Feb 2023 08:45:35 -0700
From:   <Ryan.Wanner@microchip.com>
To:     <ludovic.desroches@microchip.com>, <linus.walleij@linaro.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <claudiu.beznea@microchip.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-gpio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <manikandan.M@microchip.com>,
        Ryan Wanner <Ryan.Wanner@microchip.com>
Subject: [PATCH 2/2] pinctrl: at91: adding new macros
Date:   Thu, 9 Feb 2023 08:45:44 -0700
Message-ID: <20230209154544.535136-3-Ryan.Wanner@microchip.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230209154544.535136-1-Ryan.Wanner@microchip.com>
References: <20230209154544.535136-1-Ryan.Wanner@microchip.com>
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
 include/dt-bindings/pinctrl/at91.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/dt-bindings/pinctrl/at91.h b/include/dt-bindings/pinctrl/at91.h
index e8e117306b1b..fd0a389b2a0f 100644
--- a/include/dt-bindings/pinctrl/at91.h
+++ b/include/dt-bindings/pinctrl/at91.h
@@ -42,8 +42,14 @@
 #define AT91_PERIPH_C		3
 #define AT91_PERIPH_D		4
 
-#define ATMEL_PIO_DRVSTR_LO	1
+#define ATMEL_PIO_DRVSTR_LO_0	0
+#define ATMEL_PIO_DRVSTR_LO_1	1
 #define ATMEL_PIO_DRVSTR_ME	2
 #define ATMEL_PIO_DRVSTR_HI	3
 
+#define ATMEL_PIO_DRVSTR_LO_D 0
+#define ATMEL_PIO_DRVSTR_HI_A 1
+#define ATMEL_PIO_DRVSTR_LO_C 2
+#define ATMEL_PIO_DRVSTR_LO_B 3
+
 #endif /* __DT_BINDINGS_AT91_PINCTRL_H__ */
-- 
2.37.2

