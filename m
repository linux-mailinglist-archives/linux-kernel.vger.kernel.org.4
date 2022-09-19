Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EBA55BD028
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 17:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbiISPOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 11:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbiISPNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 11:13:53 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15DDC3057E;
        Mon, 19 Sep 2022 08:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1663600429; x=1695136429;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PEAr6TVpDp2c/6ZQZm9V8R/nrF0G8eQ7kqrLgzUvUe8=;
  b=BDog0Chh/rBWVP/ynWEjshO2o7xY+i8jhSrNM/snGfl3vQ5b2L4JtYzX
   WC2dLh2vKhnUfpMg47y/WcalvZutTV3/viMLKMv54cdD7PDkJnGOSl1N6
   Y80Nl4sCv+L54D3i+fGM5hkT3T/dgKMdjlzYbgrN5I3WLK0xgS82yz0AB
   aMTSPMSNd5hZSnMlPfDQBf1xSuEa16IStBUuds+0hXlXmxoqLkkJVl2Wg
   /fyrhN+FMmkFLWm2RAxfH3uSZaCmwswRWFdd1yBVO3DzSoNcND0jAdgu0
   yac6D6zGZS8zE8sRJAiweDjLU0Ixjqw2tSE2WYkN6gPpWXpR4dND7+FsF
   A==;
X-IronPort-AV: E=Sophos;i="5.93,328,1654585200"; 
   d="scan'208";a="181106628"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 Sep 2022 08:13:49 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Mon, 19 Sep 2022 08:13:43 -0700
Received: from ROB-ULT-M68701.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Mon, 19 Sep 2022 08:13:39 -0700
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
Subject: [PATCH v4 1/9] dt-bindings: mfd: atmel,sama5d2-flexcom: Add SPI child node ref binding
Date:   Mon, 19 Sep 2022 18:08:39 +0300
Message-ID: <20220919150846.1148783-2-sergiu.moga@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220919150846.1148783-1-sergiu.moga@microchip.com>
References: <20220919150846.1148783-1-sergiu.moga@microchip.com>
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

