Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA506D5B8B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 11:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234305AbjDDJIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 05:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234299AbjDDJIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 05:08:09 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9FD610FE;
        Tue,  4 Apr 2023 02:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1680599275;
  x=1712135275;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=fNrxb0gre3K1/rCpJnrO6aVwVZ4lDyijajG5g1A/1Ao=;
  b=QtrIrDzawQcSqZhbeqj94cJa+/Bp+tb45QSnvUzXLd4vVVtbOYkW5LzL
   c4munYKvoGqwtWEJdJJRXDXVQlmPGFQg2O1sf08YkuodrwS0aDgRXjJJx
   h1kP2Za+YfmXmxVIVDBIIhWyFh4E/OVXz85hlPY9zGQp10LqTELy3m12Y
   EBxtJiZmV3x1wqYyM4gyiA83CJp1NecmnU+wJHBeQHX/Pig0tJfl3Ve/z
   /gif9mHaO+iEAuw7xFzgw6a0xiSumiXGNM6378hK4SRuYwL30fVlOhk4F
   3PGg5O1/VxwatBenpE0Pt0ssuDBjKkIOhwrm78g5nN2hMo0Tt+xTQ7bhB
   w==;
From:   Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>
Date:   Tue, 4 Apr 2023 11:07:42 +0200
Subject: [PATCH 1/2] dt-bindings: Document TI OPT4001 light sensor bindings
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230323-add-opt4001-driver-v1-1-1451dcc1bc8a@axis.com>
References: <20230323-add-opt4001-driver-v1-0-1451dcc1bc8a@axis.com>
In-Reply-To: <20230323-add-opt4001-driver-v1-0-1451dcc1bc8a@axis.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
        <kernel@axis.com>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree bindings for opt4001 ambient light sensor.

Signed-off-by: Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>
---
 .../devicetree/bindings/iio/light/ti,opt4001.yaml  | 42 ++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/light/ti,opt4001.yaml b/Documentation/devicetree/bindings/iio/light/ti,opt4001.yaml
new file mode 100644
index 000000000000..cfd6b8b92c17
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/light/ti,opt4001.yaml
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/light/ti,opt4001.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments OPT4001 Ambient Light Sensor
+
+maintainers:
+  - Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>
+
+description: |
+  Ambient light sensor with an i2c interface.
+  https://www.ti.com/lit/gpn/opt4001
+
+properties:
+  compatible:
+    enum:
+      - ti,opt4001-picostar
+      - ti,opt4001-sot-5x3
+
+  reg:
+    maxItems: 1
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        light-sensor@44 {
+            compatible = "ti,opt4001-picostar";
+            reg = <0x44>;
+        };
+    };
+...

-- 
2.30.2

