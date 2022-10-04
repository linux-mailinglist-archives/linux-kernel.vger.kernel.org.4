Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7D765F3D28
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 09:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbiJDHVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 03:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiJDHVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 03:21:18 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 047791F9E4;
        Tue,  4 Oct 2022 00:21:17 -0700 (PDT)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2946mkgP005542;
        Tue, 4 Oct 2022 03:21:06 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3jxfd71k9b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Oct 2022 03:21:05 -0400
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 2947L4tx022089
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 4 Oct 2022 03:21:04 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 4 Oct 2022 03:21:03 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 4 Oct 2022 03:21:03 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 4 Oct 2022 03:21:03 -0400
Received: from debian.ad.analog.com ([10.48.65.127])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 2947Ke1R031613;
        Tue, 4 Oct 2022 03:20:54 -0400
From:   Ciprian Regus <ciprian.regus@analog.com>
To:     <jic23@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <robh+dt@kernel.org>, <andriy.shevchenko@linux.intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     Ciprian Regus <ciprian.regus@analog.com>
Subject: [PATCH 1/2] dt-bindings: iio: dac: add adi,ad5754.yaml
Date:   Tue, 4 Oct 2022 10:18:24 +0300
Message-ID: <20221004071825.791307-2-ciprian.regus@analog.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221004071825.791307-1-ciprian.regus@analog.com>
References: <20221004071825.791307-1-ciprian.regus@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: jdK6VapHAyI6_ZK-TRo0fmFLT5BaCdRW
X-Proofpoint-ORIG-GUID: jdK6VapHAyI6_ZK-TRo0fmFLT5BaCdRW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-04_02,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 mlxscore=0 mlxlogscore=999 clxscore=1015 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210040046
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree bindings documentation for the AD5754 DAC driver.

Signed-off-by: Ciprian Regus <ciprian.regus@analog.com>
---
 .../bindings/iio/dac/adi,ad5754.yaml          | 173 ++++++++++++++++++
 1 file changed, 173 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ad5754.yaml

diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5754.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5754.yaml
new file mode 100644
index 000000000000..e96112bc15d0
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5754.yaml
@@ -0,0 +1,173 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/dac/adi,ad5754.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices AD5754 DAC device driver
+
+maintainers:
+  - Ciprian Regus <ciprian.regus@analog.com>
+
+description: |
+  Bindings for the AD5754 and other chip variants digital-to-analog
+  converters.
+
+  https://www.analog.com/media/en/technical-documentation/data-sheets/AD5724_5734_5754.pdf
+  https://www.analog.com/media/en/technical-documentation/data-sheets/ad5722_5732_5752.pdf
+  https://www.analog.com/media/en/technical-documentation/data-sheets/ad5724r_5734r_5754r.pdf
+  https://www.analog.com/media/en/technical-documentation/data-sheets/AD5722R_5732R_5752R.pdf
+
+properties:
+  compatible:
+    enum:
+      - adi,ad5722
+      - adi,ad5732
+      - adi,ad5752
+      - adi,ad5724
+      - adi,ad5734
+      - adi,ad5754
+      - adi,ad5722r
+      - adi,ad5732r
+      - adi,ad5752r
+      - adi,ad5724r
+      - adi,ad5734r
+      - adi,ad5754r
+
+  reg:
+    maxItems: 1
+
+  spi-max-frequency:
+    maximum: 30000000
+
+  spi-cpol: true
+
+  vref-supply:
+    description:
+      The regulator to use as an external reference. If this is not provided,
+      the internal reference will be used for chips that have this feature.
+      The external reference must be 2.5V.
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+patternProperties:
+  "^channel@([0-3])$":
+    type: object
+    description: Configurations for the DAC channels
+
+    properties:
+      reg:
+        description: Channel number
+        maxItems: 1
+
+      output-range-microvolt:
+        description: |
+          Voltage range of a channel as <minimum, maximum>.
+        oneOf:
+          - items:
+              - const: 0
+              - enum: [5000000, 10000000, 10800000]
+          - items:
+              - const: -5000000
+              - const: 5000000
+          - items:
+              - const: -10000000
+              - const: 10000000
+          - items:
+              - const: -10800000
+              - const: 10800000
+
+    required:
+      - reg
+      - output-range-microvolt
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - adi,ad5722
+              - adi,ad5732
+              - adi,ad5752
+              - adi,ad5722r
+              - adi,ad5732r
+              - adi,ad5752r
+    then:
+      patternProperties:
+        "^channel@([0-3])$":
+          type: object
+          properties:
+            reg:
+              description: Channel number
+              enum: [0, 1]
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - adi,ad5724
+              - adi,ad5734
+              - adi,ad5754
+              - adi,ad5724r
+              - adi,ad5734r
+              - adi,ad5754r
+    then:
+      patternProperties:
+        "^channel@([0-3])$":
+          type: object
+          properties:
+            reg:
+              description: Channel number
+              enum: [0, 1, 2, 3]
+
+required:
+  - compatible
+  - reg
+  - spi-max-frequency
+  - spi-cpol
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    spi {
+          status = "okay";
+
+          #address-cells = <1>;
+          #size-cells = <0>;
+
+          dac@0 {
+              compatible = "adi,ad5754r";
+              reg = <0>;
+              spi-max-frequency = <1000000>;
+              spi-cpol;
+
+              #address-cells = <1>;
+              #size-cells = <0>;
+
+              channel@0 {
+                  reg = <0>;
+                  output-range-microvolt = <0 5000000>;
+              };
+              channel@1 {
+                  reg = <1>;
+                  output-range-microvolt = <0 5000000>;
+              };
+              channel@2 {
+                  reg = <2>;
+                  output-range-microvolt = <0 5000000>;
+              };
+              channel@3 {
+                  reg = <3>;
+                  output-range-microvolt = <0 5000000>;
+              };
+          };
+      };
-- 
2.30.2

