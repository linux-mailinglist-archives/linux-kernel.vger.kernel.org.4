Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 049116296C4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 12:07:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238352AbiKOLH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 06:07:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238364AbiKOLGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 06:06:17 -0500
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 484CC2937D;
        Tue, 15 Nov 2022 03:04:10 -0800 (PST)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AF9neGA027553;
        Tue, 15 Nov 2022 06:04:04 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3kuvksvatp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Nov 2022 06:04:04 -0500
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 2AFB432Z051258
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 15 Nov 2022 06:04:03 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Tue, 15 Nov
 2022 06:04:02 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 15 Nov 2022 06:04:02 -0500
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.115])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 2AFB3nvC028138;
        Tue, 15 Nov 2022 06:03:51 -0500
From:   Antoniu Miclaus <antoniu.miclaus@analog.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 1/2] dt-bindings: iio: frequency: add adf4377 doc
Date:   Tue, 15 Nov 2022 13:00:40 +0200
Message-ID: <20221115110041.71495-1-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: xcdkmuVVxcewMkmbkWTTUHV4p93p9Gpy
X-Proofpoint-ORIG-GUID: xcdkmuVVxcewMkmbkWTTUHV4p93p9Gpy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-15_06,2022-11-15_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 lowpriorityscore=0 spamscore=0 mlxscore=0 malwarescore=0 bulkscore=0
 priorityscore=1501 adultscore=0 clxscore=1011 phishscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211150075
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
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
no changes in v3.
 .../bindings/iio/frequency/adi,adf4377.yaml   | 92 +++++++++++++++++++
 MAINTAINERS                                   |  8 ++
 2 files changed, 100 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/frequency/adi,adf4377.yaml

diff --git a/Documentation/devicetree/bindings/iio/frequency/adi,adf4377.yaml b/Documentation/devicetree/bindings/iio/frequency/adi,adf4377.yaml
new file mode 100644
index 000000000000..aa6a3193b4e0
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/frequency/adi,adf4377.yaml
@@ -0,0 +1,92 @@
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
+  chip-enable-gpios:
+    description:
+      GPIO that controls the Chip Enable Pin.
+    maxItems: 1
+
+  clk1-enable-gpios:
+    description:
+      GPIO that controls the Enable Clock 1 Output Buffer Pin.
+    maxItems: 1
+
+  clk2-enable-gpios:
+    description:
+      GPIO that controls the Enable Clock 2 Output Buffer Pin.
+    maxItems: 1
+
+  adi,muxout-select:
+    description:
+      On chip multiplexer output selection.
+      high_z - MUXOUT Pin set to high-Z.
+      lock_detect - MUXOUT Pin set to lock detector output.
+      muxout_low - MUXOUT Pin set to low.
+      f_div_rclk_2 - MUXOUT Pin set to fDIV_RCLK/2.
+      f_div_nclk_2 - MUXOUT Pin set to fDIV_NCLK/2.
+      muxout_high - MUXOUT Pin set to high.
+    enum: [high_z, lock_detect, muxout_low, f_div_rclk_2, f_div_nclk_2, muxout_high]
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
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
+        frequency@0 {
+            compatible = "adi,adf4377";
+            reg = <0>;
+            spi-max-frequency = <10000000>;
+            clocks = <&adf4377_ref_in>;
+            clock-names = "ref_in";
+        };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index e1bc31a6624b..19a2f689e43e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1189,6 +1189,14 @@ W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/amplifiers/adi,ada4250.yaml
 F:	drivers/iio/amplifiers/ada4250.c
 
+ANALOG DEVICES INC ADF4377 DRIVER
+M:	Antoniu Miclaus <antoniu.miclaus@analog.com>
+L:	linux-iio@vger.kernel.org
+S:	Supported
+W:	https://ez.analog.com/linux-software-drivers
+F:	Documentation/devicetree/bindings/iio/frequency/adi,adf4377.yaml
+F:	drivers/iio/frequency/adf4377.c
+
 ANALOG DEVICES INC ADGS1408 DRIVER
 M:	Mircea Caprioru <mircea.caprioru@analog.com>
 S:	Supported
-- 
2.38.1

