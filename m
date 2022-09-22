Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07D825E6170
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 13:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231575AbiIVLma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 07:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231487AbiIVLmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 07:42:24 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6058D9B84A;
        Thu, 22 Sep 2022 04:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1663846944; x=1695382944;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GT9IwBJNAC4XTrhQE8Doddu3ihNUQQzQwQ2tBRH1Eqc=;
  b=KA4Xi/Eiiws1bXfUbzDlfFY2nccZQkgm/tmnRdzdKFf9044zsQb8nHYs
   YkVzCSz7X746Jqb08bC4TCFDCQAiXD42sjuLvYm+w2+lICnbw+kh7igNk
   ObmbKXxjE0yYQxGNR53W88foIzmtSQG+r3G9k6zuEBMETKj8XQ5FmuEsB
   JqMMM+nlkp+UT4ypwkSnw81AjpxttVo4UivgWn54qcam1ZJS7L3cvlbrl
   HSDJrE8TLk1e0ldtZFF0vV8yK1878WRkuBmWHxkcRRao6CMgoMqMJ+MJB
   96Cl6bLsljvRVzKymab7E/minQ8XA58Ox9WgDwMWX0ONvQLYVACeHpUIM
   w==;
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="175078983"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 Sep 2022 04:42:23 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 22 Sep 2022 04:42:20 -0700
Received: from ROB-ULT-M68701.amer.actel.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Thu, 22 Sep 2022 04:42:14 -0700
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
Subject: [PATCH v5 1/9] dt-bindings: mfd: atmel,sama5d2-flexcom: Add SPI child node ref binding
Date:   Thu, 22 Sep 2022 14:33:39 +0300
Message-ID: <20220922113347.144383-2-sergiu.moga@microchip.com>
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

Another functionality of FLEXCOM is that of SPI. In order for
the proper validation of the SPI children nodes through the binding
to occur, the proper binding for SPI must be referenced.

Signed-off-by: Sergiu Moga <sergiu.moga@microchip.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---


v1 -> v2:
- use full schema paths


v2 -> v3:
- Added Reviewed-by tag, previously this was [PATCH 3]


v3 -> v4:
- Nothing, previously this was [PATCH 5]


v4 -> v5:
- Nothing



 .../devicetree/bindings/mfd/atmel,sama5d2-flexcom.yaml       | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/atmel,sama5d2-flexcom.yaml b/Documentation/devicetree/bindings/mfd/atmel,sama5d2-flexcom.yaml
index 0c80f4e98c54..f283cfd84b2d 100644
--- a/Documentation/devicetree/bindings/mfd/atmel,sama5d2-flexcom.yaml
+++ b/Documentation/devicetree/bindings/mfd/atmel,sama5d2-flexcom.yaml
@@ -78,10 +78,9 @@ patternProperties:
       of USART bindings.
 
   "^spi@[0-9a-f]+$":
-    type: object
+    $ref: /schemas/spi/atmel,at91rm9200-spi.yaml
     description:
-      Child node describing SPI. See ../spi/spi_atmel.txt for details
-      of SPI bindings.
+      Child node describing SPI.
 
   "^i2c@[0-9a-f]+$":
     $ref: /schemas/i2c/atmel,at91sam-i2c.yaml
-- 
2.34.1

