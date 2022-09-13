Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66F0F5B75AB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 17:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233526AbiIMPxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 11:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233801AbiIMPwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 11:52:30 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FEAA8E0C7;
        Tue, 13 Sep 2022 07:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1663080857; x=1694616857;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WNbs0BD4//B5dmJrvVsk63o1u0EvWn2eKGzA9ecgmj0=;
  b=eUVmLRC/j2Qz5ZEBD0WeQqYrmZiS1xd1jvSQXu393TAiLSuN0TWsYQHE
   6bQ0ROnCWdQ8YkH1l/Imd1ys3CMoONhYSTzgd/8KjMrhRoOaXX/ize+Sy
   SeLkvaCfXLNPf/WubHxOX0BHlWT5cYwJUOoZMSfIGvYLXyYM621mWVTqC
   r5yv1F+jfdJDayXF6NRhX54AURkVI2s4D+dm5iilm28pkWCHB/+3wcpxr
   Qt0o2xj2q69L9ApJ8GYhwKQ6e8omSnqaCvIpqabuW79D8zpFiEqZx6dMZ
   n4iFgxZTDuixB9rbMSzLlAdX+oKE2jPSLHgrUT+UWB+8gPUxqbHQC9zfp
   g==;
X-IronPort-AV: E=Sophos;i="5.93,313,1654585200"; 
   d="scan'208";a="190644049"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Sep 2022 07:25:20 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 13 Sep 2022 07:25:11 -0700
Received: from ROB-ULT-M68701.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Tue, 13 Sep 2022 07:25:06 -0700
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
        <linux-serial@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 05/14] dt-bindings: mfd: atmel,sama5d2-flexcom: Add SPI child node ref binding
Date:   Tue, 13 Sep 2022 17:21:57 +0300
Message-ID: <20220913142205.162399-6-sergiu.moga@microchip.com>
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


 .../devicetree/bindings/mfd/atmel,sama5d2-flexcom.yaml       | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/atmel,sama5d2-flexcom.yaml b/Documentation/devicetree/bindings/mfd/atmel,sama5d2-flexcom.yaml
index 568da7cb630c..0db0f2728b65 100644
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
     $ref: ../i2c/atmel,at91sam-i2c.yaml
-- 
2.34.1

