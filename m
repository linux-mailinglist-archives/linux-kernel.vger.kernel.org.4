Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE0F72F124
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 02:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241556AbjFNAtw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 20:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231713AbjFNAtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 20:49:50 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87D8A118;
        Tue, 13 Jun 2023 17:49:49 -0700 (PDT)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35DN4SFh013496;
        Tue, 13 Jun 2023 20:49:28 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3r4k16d5fd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Jun 2023 20:49:28 -0400
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 35E0nQph039125
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 13 Jun 2023 20:49:26 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 13 Jun 2023 20:49:25 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 13 Jun 2023 20:49:25 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 13 Jun 2023 20:49:25 -0400
Received: from kimedia-VirtualBox.analog.com (KPALLER2-L02.ad.analog.com [10.116.184.245])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 35E0n4nn032055;
        Tue, 13 Jun 2023 20:49:11 -0400
From:   Kim Seer Paller <kimseer.paller@analog.com>
CC:     <jic23@kernel.org>, <lars@metafoo.de>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <Michael.Hennerich@analog.com>,
        <andy.shevchenko@gmail.com>, <robh@kernel.org>,
        <krzysztof.kozlowski@linaro.org>, <conor+dt@kernel.org>,
        <kimseer.paller@analog.com>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v6 1/2] dt-bindings: iio: adc: add max14001
Date:   Wed, 14 Jun 2023 08:48:56 +0800
Message-ID: <20230614004857.134980-1-kimseer.paller@analog.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: 3ruanz578-QCaLpXDfmIGegBNNBtGEBB
X-Proofpoint-ORIG-GUID: 3ruanz578-QCaLpXDfmIGegBNNBtGEBB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-13_24,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 phishscore=0 mlxlogscore=999 spamscore=0 mlxscore=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2305260000 definitions=main-2306140004
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MAX14001 is a configurable, isolated 10-bit ADC for multi-range
binary inputs.

Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
---
V5 -> V6: Removed tags.
V3 -> V5: Added spaces between prefixes in subject. Fixed MAINTAINERS reference.

 .../bindings/iio/adc/adi,max14001.yaml        | 54 +++++++++++++++++++
 MAINTAINERS                                   |  7 +++
 2 files changed, 61 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,max14001.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,max14001.yaml b/Documentation/devicetree/bindings/iio/adc/adi,max14001.yaml
new file mode 100644
index 000000000000..9d03c611fca3
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,max14001.yaml
@@ -0,0 +1,54 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright 2023 Analog Devices Inc.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/adi,max14001.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices MAX14001 ADC
+
+maintainers:
+  - Kim Seer Paller <kimseer.paller@analog.com>
+
+description: |
+    Single channel 10 bit ADC with SPI interface. Datasheet
+    can be found here:
+      https://www.analog.com/media/en/technical-documentation/data-sheets/MAX14001-MAX14002.pdf
+
+properties:
+  compatible:
+    enum:
+      - adi,max14001
+
+  reg:
+    maxItems: 1
+
+  spi-max-frequency:
+    maximum: 5000000
+
+  vref-supply:
+    description: Voltage reference to establish input scaling.
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
+            compatible = "adi,max14001";
+            reg = <0>;
+            spi-max-frequency = <5000000>;
+            vref-supply = <&vref_reg>;
+        };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index f794002a192e..dcea2c31f920 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12670,6 +12670,13 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/sound/max9860.txt
 F:	sound/soc/codecs/max9860.*
 
+MAX14001 IIO ADC DRIVER
+M:	Kim Seer Paller <kimseer.paller@analog.com>
+L:	linux-iio@vger.kernel.org
+S:	Supported
+W:	https://ez.analog.com/linux-software-drivers
+F:	Documentation/devicetree/bindings/iio/adc/adi,max14001.yaml
+
 MAXBOTIX ULTRASONIC RANGER IIO DRIVER
 M:	Andreas Klinger <ak@it-klinger.de>
 L:	linux-iio@vger.kernel.org

base-commit: 6f449d52b90fdd927fcf9df0388701de6d5381c6
-- 
2.34.1

