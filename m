Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B2F761937A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 10:29:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbiKDJ3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 05:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231417AbiKDJ2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 05:28:53 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60A1F26553;
        Fri,  4 Nov 2022 02:28:51 -0700 (PDT)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2A48rX1V000718;
        Fri, 4 Nov 2022 05:28:42 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3kmpm9k8vw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Nov 2022 05:28:42 -0400
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 2A49SeTS062017
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 4 Nov 2022 05:28:40 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Fri, 4 Nov 2022
 05:28:39 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 4 Nov 2022 05:28:39 -0400
Received: from amiclaus-VirtualBox.ad.analog.com ([10.65.47.228])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 2A49SOqZ016780;
        Fri, 4 Nov 2022 05:28:34 -0400
From:   Antoniu Miclaus <antoniu.miclaus@analog.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH 1/4] dt-bindings: iio: frequency: add adf4377 doc
Date:   Fri, 4 Nov 2022 11:27:59 +0200
Message-ID: <20221104092802.90725-2-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221104092802.90725-1-antoniu.miclaus@analog.com>
References: <20221104092802.90725-1-antoniu.miclaus@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: nS6Z-hc9bR087arYN9cewJgJF4igo8gF
X-Proofpoint-GUID: nS6Z-hc9bR087arYN9cewJgJF4igo8gF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-04_06,2022-11-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1011
 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 priorityscore=1501
 phishscore=0 spamscore=0 mlxscore=0 adultscore=0 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211040061
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree bindings for the ADF4377 driver.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 .../bindings/iio/frequency/adi,adf4377.yaml   | 78 +++++++++++++++++++
 1 file changed, 78 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/frequency/adi,adf4377.yaml

diff --git a/Documentation/devicetree/bindings/iio/frequency/adi,adf4377.yaml b/Documentation/devicetree/bindings/iio/frequency/adi,adf4377.yaml
new file mode 100644
index 000000000000..3f5c83e03bb9
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/frequency/adi,adf4377.yaml
@@ -0,0 +1,78 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/frequency/adi,adf4377.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ADF4377 Microwave Wideband Synthesizer with Integrated VCO
+
+maintainers:
+  - Antoniu Miclaus <antoniu.miclaus@analog.com>
+  - Dragos Bogdan <dragos.bogdan@analog.com>
+
+description: |
+   The ADF4377 is a high performance, ultralow jitter, dual output integer-N
+   phased locked loop (PLL) with integrated voltage controlled oscillator (VCO)
+   ideally suited for data converter and mixed signal front end (MxFE) clock
+   applications.
+
+   https://www.analog.com/en/products/adf4377.html
+
+properties:
+  compatible:
+    enum:
+      - adi,adf4377
+      - adi,adf4378
+
+  reg:
+    maxItems: 1
+
+  spi-max-frequency:
+    maximum: 10000000
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    description:
+      External clock that provides reference input frequency.
+    items:
+      - const: ref_in
+
+  ce-en-gpios:
+    description:
+      Gpio that controls the Chip Enable Pin.
+    maxItems: 1
+
+  enclk1-gpios:
+    description:
+      Gpio that controls the Enable Clock 1 Output Buffer Pin.
+    maxItems: 1
+
+  enclk2-gpios:
+    description:
+      Gpio that controls the Enable Clock 2 Output Buffer Pin.
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        frequency@0 {
+            compatible = "adi,adf4377";
+            reg = <0>;
+            spi-max-frequency = <10000000>;
+            clocks = <&adf4377_ref_in>;
+            clock-names = "ref_in";
+        };
+    };
+...
-- 
2.38.1

