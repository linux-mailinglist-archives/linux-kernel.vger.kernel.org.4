Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 998E6633E78
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 15:07:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233621AbiKVOHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 09:07:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234045AbiKVOH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 09:07:27 -0500
Received: from mx1.emlix.com (mx1.emlix.com [136.243.223.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4704E6A769;
        Tue, 22 Nov 2022 06:05:49 -0800 (PST)
Received: from mailer.emlix.com (unknown [81.20.119.6])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.emlix.com (Postfix) with ESMTPS id 6BB3C5F890;
        Tue, 22 Nov 2022 15:05:47 +0100 (CET)
From:   Edmund Berenson <edmund.berenson@emlix.com>
Cc:     Edmund Berenson <edmund.berenson@emlix.com>,
        Lukasz Zemla <Lukasz.Zemla@woodward.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4] dt-bindings: iio: adc: ad7923: adjust documentation
Date:   Tue, 22 Nov 2022 15:05:43 +0100
Message-Id: <20221122140543.11230-1-edmund.berenson@emlix.com>
X-Mailer: git-send-email 2.37.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- The ad7927 is fully compatible with ad7928 driver, add
documentation for device.
- ad7923 and ad7924 are treated the same in the driver, show
the relationship in the documentation.

Suggested-by: Lukasz Zemla <Lukasz.Zemla@woodward.com>
Signed-off-by: Edmund Berenson <edmund.berenson@emlix.com>
---
 .../bindings/iio/adc/adi,ad7923.yaml          | 25 ++++++++++++-------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7923.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7923.yaml
index 07f9d1c09c7d..b6e2f1b41739 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7923.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7923.yaml
@@ -11,7 +11,7 @@ maintainers:
 
 description: |
   Analog Devices AD7904, AD7914, AD7923, AD7924 4 Channel ADCs, and AD7908,
-   AD7918, AD7928 8 Channels ADCs.
+   AD7918, AD7927, AD7928 8 Channels ADCs.
 
   Specifications about the part can be found at:
     https://www.analog.com/media/en/technical-documentation/data-sheets/AD7923.pdf
@@ -20,14 +20,21 @@ description: |
 
 properties:
   compatible:
-    enum:
-      - adi,ad7904
-      - adi,ad7914
-      - adi,ad7923
-      - adi,ad7924
-      - adi,ad7908
-      - adi,ad7918
-      - adi,ad7928
+    oneOf:
+      - const: adi,ad7904
+      - const: adi,ad7908
+      - const: adi,ad7914
+      - const: adi,ad7918
+      - const: adi,ad7923
+      - const: adi,ad7924
+        deprecated: true
+      - const: adi,ad7928
+      - items:
+          - const: adi,ad7924
+          - const: adi,ad7923
+      - items:
+          - const: adi,ad7927
+          - const: adi,ad7928
 
   reg:
     maxItems: 1
-- 
2.37.4

