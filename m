Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C29A85F2D1B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 11:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbiJCJZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 05:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbiJCJZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 05:25:42 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 450512FFCB;
        Mon,  3 Oct 2022 02:25:41 -0700 (PDT)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2939OT2L005490;
        Mon, 3 Oct 2022 05:25:38 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3jxfd6u3mh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Oct 2022 05:25:38 -0400
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 2939PbFJ007865
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 3 Oct 2022 05:25:37 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 3 Oct 2022 05:25:36 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 3 Oct 2022 05:25:36 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 3 Oct 2022 05:25:36 -0400
Received: from IST-LT-39247.ad.analog.com (IST-LT-39247.ad.analog.com [10.25.16.10])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 2939PFdZ012843;
        Mon, 3 Oct 2022 05:25:26 -0400
From:   Ibrahim Tilki <Ibrahim.Tilki@analog.com>
To:     <jic23@kernel.org>
CC:     Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        <linux-iio@vger.kernel.org>, <Nuno.Sa@analog.com>,
        <Nurettin.Bolucu@analog.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v7 2/3] dt-bindings: iio: adc: add adi,max11410.yaml
Date:   Mon, 3 Oct 2022 12:24:59 +0300
Message-ID: <20221003092500.296-3-Ibrahim.Tilki@analog.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221003092500.296-1-Ibrahim.Tilki@analog.com>
References: <20221003092500.296-1-Ibrahim.Tilki@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: ZBZ5BW7ZLRDhUhWD8YwiTaecyu_lMqhB
X-Proofpoint-ORIG-GUID: ZBZ5BW7ZLRDhUhWD8YwiTaecyu_lMqhB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-03_02,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 mlxscore=0 mlxlogscore=999 clxscore=1015 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210030056
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding devicetree binding documentation for max11410 adc.

Signed-off-by: Ibrahim Tilki <Ibrahim.Tilki@analog.com>
---
 .../bindings/iio/adc/adi,max11410.yaml        | 176 ++++++++++++++++++
 1 file changed, 176 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,max11410.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,max11410.yaml b/Documentation/devicetree/bindings/iio/adc/adi,max11410.yaml
new file mode 100644
index 0000000000..821776629e
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,max11410.yaml
@@ -0,0 +1,176 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright 2022 Analog Devices Inc.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/adi,max11410.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices MAX11410 ADC device driver
+
+maintainers:
+  - Ibrahim Tilki <Ibrahim.Tilki@analog.com>
+
+description: |
+  Bindings for the Analog Devices MAX11410 ADC device. Datasheet can be
+  found here:
+    https://datasheets.maximintegrated.com/en/ds/MAX11410.pdf
+
+properties:
+  compatible:
+    enum:
+      - adi,max11410
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    minItems: 1
+    maxItems: 2
+
+  interrupt-names:
+    description: Name of the gpio pin of max11410 used for IRQ
+    minItems: 1
+    items:
+      - enum: [gpio0, gpio1]
+      - const: gpio1
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+  avdd-supply:
+    description: Optional avdd supply. Used as reference when no explicit reference supplied.
+
+  vref0p-supply:
+    description: vref0p supply can be used as reference for conversion.
+
+  vref1p-supply:
+    description: vref1p supply can be used as reference for conversion.
+
+  vref2p-supply:
+    description: vref2p supply can be used as reference for conversion.
+
+  vref0n-supply:
+    description: vref0n supply can be used as reference for conversion.
+
+  vref1n-supply:
+    description: vref1n supply can be used as reference for conversion.
+
+  vref2n-supply:
+    description: vref2n supply can be used as reference for conversion.
+
+  spi-max-frequency:
+    maximum: 8000000
+
+patternProperties:
+  "^channel(@[0-9])?$":
+    $ref: "adc.yaml"
+    type: object
+    description: Represents the external channels which are connected to the ADC.
+
+    properties:
+      reg:
+        description: The channel number in single-ended mode.
+        minimum: 0
+        maximum: 9
+
+      adi,reference:
+        description: |
+          Select the reference source to use when converting on
+          the specific channel. Valid values are:
+          0: VREF0P/VREF0N
+          1: VREF1P/VREF1N
+          2: VREF2P/VREF2N
+          3: AVDD/AGND
+          4: VREF0P/AGND
+          5: VREF1P/AGND
+          6: VREF2P/AGND
+          If this field is left empty, AVDD/AGND is selected.
+        $ref: /schemas/types.yaml#/definitions/uint32
+        enum: [0, 1, 2, 3, 4, 5, 6]
+        default: 3
+
+      adi,input-mode:
+        description: |
+          Select signal path of input channels. Valid values are:
+          0: Buffered, low-power, unity-gain path (default)
+          1: Bypass path
+          2: PGA path
+        $ref: /schemas/types.yaml#/definitions/uint32
+        enum: [0, 1, 2]
+        default: 0
+
+      diff-channels: true
+
+      bipolar: true
+
+      settling-time-us: true
+
+      adi,buffered-vrefp:
+        description: Enable buffered mode for positive reference.
+        type: boolean
+
+      adi,buffered-vrefn:
+        description: Enable buffered mode for negative reference.
+        type: boolean
+
+    required:
+      - reg
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - reg
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        adc@0 {
+            reg = <0>;
+            compatible = "adi,max11410";
+            spi-max-frequency = <8000000>;
+
+            interrupt-parent = <&gpio>;
+            interrupts = <25 2>;
+            interrupt-names = "gpio1";
+
+            avdd-supply = <&adc_avdd>;
+
+            vref1p-supply = <&adc_vref1p>;
+            vref1n-supply = <&adc_vref1n>;
+
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            channel@0 {
+                reg = <0>;
+            };
+
+            channel@1 {
+                reg = <1>;
+                diff-channels = <2 3>;
+                adi,reference = <1>;
+                bipolar;
+                settling-time-us = <100000>;
+            };
+
+            channel@2 {
+                reg = <2>;
+                diff-channels = <7 9>;
+                adi,reference = <5>;
+                adi,input-mode = <2>;
+                settling-time-us = <50000>;
+            };
+        };
+    };
-- 
2.25.1

