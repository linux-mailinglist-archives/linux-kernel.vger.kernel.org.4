Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C23D25E6183
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 13:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231663AbiIVLn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 07:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231607AbiIVLnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 07:43:03 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B51CE9B84B;
        Thu, 22 Sep 2022 04:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1663846963; x=1695382963;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CDmfB3LXHlTY7cYfzI1AY48LKvPYcljTNoK8CbnBZSU=;
  b=RZMyvFiRMg61io61NtC+Jtxbx2v4I71/RMZUMnduy8ISnUGlyWOxIMR7
   x8pDzz5bUGnxbChTzba1xEFOD1B8BY5j3O7CsGvQTsYixaHqZ1F4dFo6L
   Ht9BXDGK4+LnxKLyydwBN37Mgw06oBGXdiZFiZ9dYpB+Ae4D5t8CiOB5F
   +Mo0pO/wc7jRNjYJMQacouWaiFtthg12lP41NJm7QwwAMbq9Dqpat4+Sd
   a1QoYpqZ5r7HEjs4pKfPZw2qqXT1JFzoEDwuUkFYXxfgjDP82BeXAbO3i
   35Bws9dJNFcWwbHsajSnMhthlBrYTgxN0BE5/Uc0CqNvjTo+lmUgYvWKG
   g==;
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="178390512"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 Sep 2022 04:42:42 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 22 Sep 2022 04:42:42 -0700
Received: from ROB-ULT-M68701.amer.actel.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Thu, 22 Sep 2022 04:42:36 -0700
From:   Sergiu Moga <sergiu.moga@microchip.com>
To:     <lee@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <claudiu.beznea@microchip.com>,
        <radu_nicolae.pirea@upb.ro>, <richard.genoud@gmail.com>,
        <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <kavyasree.kotagiri@microchip.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-serial@vger.kernel.org>,
        Sergiu Moga <sergiu.moga@microchip.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v5 4/9] dt-bindings: mfd: atmel,sama5d2-flexcom: Add USART child node ref binding
Date:   Thu, 22 Sep 2022 14:33:42 +0300
Message-ID: <20220922113347.144383-5-sergiu.moga@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220922113347.144383-1-sergiu.moga@microchip.com>
References: <20220922113347.144383-1-sergiu.moga@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---


v1 -> v2:
- Nothing


v2 -> v3:
- Previously [PATCH 7]
- Compare devices based on the compatible instead of the clock


v3 -> v4:
- add A-b tag, this was previously [PATCH 8]



v4 -> v5:
- Nothing



 .../bindings/mfd/atmel,sama5d2-flexcom.yaml      | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/atmel,sama5d2-flexcom.yaml b/Documentation/devicetree/bindings/mfd/atmel,sama5d2-flexcom.yaml
index f283cfd84b2d..0ebe624c2d32 100644
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

