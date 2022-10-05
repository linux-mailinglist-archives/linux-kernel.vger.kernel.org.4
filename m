Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD2BB5F5599
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 15:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbiJENhK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 09:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbiJENhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 09:37:03 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D20A7AC27;
        Wed,  5 Oct 2022 06:37:00 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 295CmvHZ012965;
        Wed, 5 Oct 2022 15:36:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=TWtwkhpFfFIsRQnbF1+FDZ/TyYsZdJ0xXvFMnYZtWh4=;
 b=Gv74z7qGPT5rqGvRe1duDoO4QK78+/IRywANIbSMqA3pEY57fqEE3unXruSUN9HVKdVz
 jmaJT2qeA9jfegzMVaoT69JqhU1k/IJHpHCxkQSd/q+6FG+XiOaC2G1yNsD6WPAIXLIX
 nzLC/uBm5uZd5stjejGLqRsrLxIFlW7LVzEiM0kIW0Fzamupw9nQQ2g/+mnOgEmXKpvv
 jdbGGrq6j0K/BpJdhIbJ80BdA30DmFwDLC79spOoBJQ11PsSCBh9QDAmCztRqFtITFBr
 gpOx09nkz/klrJF6zTUsjSas4z2Jo84VlOWtV5t2JPXJlnJUIRoR0If+w6pU8TQwlY2c Vg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3jxcw27hwq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Oct 2022 15:36:11 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4BA34100038;
        Wed,  5 Oct 2022 15:36:05 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 4210722A6C2;
        Wed,  5 Oct 2022 15:36:05 +0200 (CEST)
Received: from localhost (10.75.127.119) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2375.31; Wed, 5 Oct
 2022 15:36:04 +0200
From:   Olivier Moysan <olivier.moysan@foss.st.com>
To:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        <nuno.sa@analog.com>, Olivier Moysan <olivier.moysan@foss.st.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Wan Jiabing <wanjiabing@vivo.com>,
        Yannick Brosseau <yannick.brosseau@gmail.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH v2 2/8] dt-bindings: iio: adc: stm32-adc: add stm32mp13 compatibles
Date:   Wed, 5 Oct 2022 15:31:14 +0200
Message-ID: <20221005133120.50483-3-olivier.moysan@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221005133120.50483-1-olivier.moysan@foss.st.com>
References: <20221005133120.50483-1-olivier.moysan@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.119]
X-ClientProxiedBy: GPXDAG2NODE4.st.com (10.75.127.68) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-05_03,2022-10-05_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add st,stm32mp13-adc-core and st,stm32mp13-adc compatibles
to support STM32MPU13 SoC.

On STM32MP13x, each ADC peripheral has a single ADC block.
These ADC peripherals, ADC1 and ADC2, are fully independent.

Main characteristics of STM32MP13x ADC:
- One interrupt line per ADC
- 6 to 12 bits resolution
- 19 channels

ADC2 instance supports two extra internal channels VDDCPU and VDDQ_DDR.
Add "vddcpu" and "vddq_ddr" internal channels names to the reserved
labels list.

Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
---
 .../bindings/iio/adc/st,stm32-adc.yaml        | 68 ++++++++++++++++++-
 1 file changed, 65 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.yaml b/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.yaml
index fa8da42cb1e6..05265f381fde 100644
--- a/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.yaml
@@ -27,6 +27,7 @@ properties:
       - st,stm32f4-adc-core
       - st,stm32h7-adc-core
       - st,stm32mp1-adc-core
+      - st,stm32mp13-adc-core
 
   reg:
     maxItems: 1
@@ -37,6 +38,7 @@ properties:
         - stm32f4 and stm32h7 share a common ADC interrupt line.
         - stm32mp1 has two separate interrupt lines, one for each ADC within
           ADC block.
+        - stm32mp13 has an interrupt line per ADC block.
     minItems: 1
     maxItems: 2
 
@@ -180,6 +182,33 @@ allOf:
           maximum: 36000000
           default: 36000000
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: st,stm32mp13-adc-core
+
+    then:
+      properties:
+        clocks:
+          minItems: 1
+          maxItems: 2
+
+        clock-names:
+          items:
+            - const: bus
+            - const: adc
+          minItems: 1
+
+        interrupts:
+          items:
+            - description: ADC interrupt line
+
+        st,max-clk-rate-hz:
+          minimum: 150000
+          maximum: 75000000
+          default: 75000000
+
 additionalProperties: false
 
 required:
@@ -208,6 +237,7 @@ patternProperties:
           - st,stm32f4-adc
           - st,stm32h7-adc
           - st,stm32mp1-adc
+          - st,stm32mp13-adc
 
       reg:
         description: |
@@ -229,7 +259,7 @@ patternProperties:
       interrupts:
         description: |
           IRQ Line for the ADC instance. Valid values are:
-            - 0 for adc@0
+            - 0 for adc@0 (single adc for stm32mp13)
             - 1 for adc@100
             - 2 for adc@200 (stm32f4 only)
         maxItems: 1
@@ -250,13 +280,14 @@ patternProperties:
       assigned-resolution-bits:
         description: |
           Resolution (bits) to use for conversions:
-            - can be 6, 8, 10 or 12 on stm32f4
+            - can be 6, 8, 10 or 12 on stm32f4 and stm32mp13
             - can be 8, 10, 12, 14 or 16 on stm32h7 and stm32mp1
 
       st,adc-channels:
         description: |
           List of single-ended channels muxed for this ADC. It can have up to:
             - 16 channels, numbered from 0 to 15 (for in0..in15) on stm32f4
+            - 19 channels, numbered from 0 to 18 (for in0..in18) on stm32mp13.
             - 20 channels, numbered from 0 to 19 (for in0..in19) on stm32h7 and
               stm32mp1.
         $ref: /schemas/types.yaml#/definitions/uint32-array
@@ -322,7 +353,7 @@ patternProperties:
           label:
             description: |
               Unique name to identify which channel this is.
-              Reserved label names "vddcore", "vrefint" and "vbat"
+              Reserved label names "vddcore", "vddcpu", "vddq_ddr", "vrefint" and "vbat"
               are used to identify internal channels with matching names.
 
           diff-channels:
@@ -419,6 +450,37 @@ patternProperties:
               items:
                 minimum: 40
 
+
+      - if:
+          properties:
+            compatible:
+              contains:
+                const: st,stm32mp13-adc
+
+        then:
+          properties:
+            reg:
+              const: 0x0
+
+            interrupts:
+              const: 0
+
+            assigned-resolution-bits:
+              enum: [6, 8, 10, 12]
+              default: 12
+
+            st,adc-channels:
+              minItems: 1
+              maxItems: 19
+              items:
+                minimum: 0
+                maximum: 18
+
+            st,min-sample-time-nsecs:
+              minItems: 1
+              maxItems: 19
+              items:
+                minimum: 40
     additionalProperties: false
 
     required:
-- 
2.25.1

