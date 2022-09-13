Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6096E5B75B3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 17:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233751AbiIMPx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 11:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234688AbiIMPxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 11:53:04 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECB3DD5A;
        Tue, 13 Sep 2022 07:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1663080870; x=1694616870;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HJ21i8WyvavSW1Rex/vM3PxZNjMJUVVOLwpNbp1oD2g=;
  b=D/TpzObeehMyiEvzn+m90SnhRQEgr496q2p1e0TlBA6lm6wrWmPW5Lsh
   Ou7IdAawt06H3ZoGY9wWiWBlmvr7tKi/bsvlAqk7RwYfu56fhPeBMTGiP
   XKhdJQNZQKvF4XehKqW02ICkvjM4qkWIXbmw3UgOSOSke8ESKoEU2o7Ia
   lVW5QRJUtLhnZ5WTEBgQ97xjXbrQh9xgRl4ejbDvaIW62IqqO16N0Vik8
   mKJmhseEOjQcNjwGGsh5ouQ/eAW49cpyagqJkSVfi9FiuJ8RSp7LETNBu
   KBmlqn7cjSw06ai4xe+cq7+5+Yz08TQpoBppVmx8X++4zboJByLQq/IEP
   w==;
X-IronPort-AV: E=Sophos;i="5.93,313,1654585200"; 
   d="scan'208";a="190644072"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Sep 2022 07:25:28 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 13 Sep 2022 07:25:27 -0700
Received: from ROB-ULT-M68701.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Tue, 13 Sep 2022 07:25:22 -0700
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
Subject: [PATCH v3 08/14] dt-bindings: mfd: atmel,sama5d2-flexcom: Add USART child node ref binding
Date:   Tue, 13 Sep 2022 17:22:00 +0300
Message-ID: <20220913142205.162399-9-sergiu.moga@microchip.com>
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

FLEXCOM, among other functionalities, has the ability to offer the USART
serial communication protocol. To have the FLEXCOM binding properly
validate its USART children nodes, we must reference the correct binding.
To differentiate between the SPI of FLEXCOM and the SPI of USART in SPI
mode, use the compatible string.

Signed-off-by: Sergiu Moga <sergiu.moga@microchip.com>
---


v1 -> v2:
- Nothing


v2 -> v3:
- Previously [PATCH 7]
- Compare devices based on the compatible instead of the clock



 .../bindings/mfd/atmel,sama5d2-flexcom.yaml      | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/atmel,sama5d2-flexcom.yaml b/Documentation/devicetree/bindings/mfd/atmel,sama5d2-flexcom.yaml
index 0db0f2728b65..0467dfcf7db5 100644
--- a/Documentation/devicetree/bindings/mfd/atmel,sama5d2-flexcom.yaml
+++ b/Documentation/devicetree/bindings/mfd/atmel,sama5d2-flexcom.yaml
@@ -72,13 +72,21 @@ properties:
 
 patternProperties:
   "^serial@[0-9a-f]+$":
-    type: object
+    $ref: /schemas/serial/atmel,at91-usart.yaml
     description:
-      Child node describing USART. See atmel-usart.txt for details
-      of USART bindings.
+      Child node describing USART.
 
   "^spi@[0-9a-f]+$":
-    $ref: /schemas/spi/atmel,at91rm9200-spi.yaml
+    allOf:
+      - if:
+          properties:
+            compatible:
+              contains:
+                const: atmel,at91sam9260-usart
+        then:
+          $ref: /schemas/serial/atmel,at91-usart.yaml
+        else:
+          $ref: /schemas/spi/atmel,at91rm9200-spi.yaml
     description:
       Child node describing SPI.
 
-- 
2.34.1

