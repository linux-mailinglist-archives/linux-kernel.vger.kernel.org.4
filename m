Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B6157226F2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 15:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233486AbjFENJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 09:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233517AbjFENJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 09:09:25 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 161F6D2;
        Mon,  5 Jun 2023 06:09:23 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 355D6rL2025508;
        Mon, 5 Jun 2023 09:09:08 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3r02e4a3v0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Jun 2023 09:08:42 -0400
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 355D8dWI022871
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 5 Jun 2023 09:08:39 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Mon, 5 Jun 2023
 09:08:38 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 5 Jun 2023 09:08:38 -0400
Received: from kimedia-VirtualBox.ad.analog.com (KPALLER2-L02.ad.analog.com [10.116.242.24])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 355D8IfU010470;
        Mon, 5 Jun 2023 09:08:29 -0400
From:   Kim Seer Paller <kimseer.paller@analog.com>
To:     <jic23@kernel.org>, <lars@metafoo.de>,
        <krzysztof.kozlowski@linaro.org>
CC:     <broonie@kernel.org>, <lgirdwood@gmail.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kimseer.paller@analog.com>
Subject: [PATCH v2 1/2] dt-bindings:iio:adc: add max14001
Date:   Mon, 5 Jun 2023 21:07:54 +0800
Message-ID: <20230605130755.92642-2-kimseer.paller@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230605130755.92642-1-kimseer.paller@analog.com>
References: <20230605130755.92642-1-kimseer.paller@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: EIG6Z0D3ZdDlRR-YkeQzw1gnpWL1bOc5
X-Proofpoint-GUID: EIG6Z0D3ZdDlRR-YkeQzw1gnpWL1bOc5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-03_08,2023-06-02_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 adultscore=0 impostorscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306050115
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MAX14001 is configurable, isolated 10-bit ADCs for multi-range
binary inputs.

Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
---
 .../bindings/iio/adc/adi,max14001.yaml        | 55 +++++++++++++++++++
 MAINTAINERS                                   |  7 +++
 2 files changed, 62 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,max14001.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,max14001.yaml b/Documentation/devicetree/bindings/iio/adc/adi,max14001.yaml
new file mode 100644
index 000000000..1b17f5dc0
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,max14001.yaml
@@ -0,0 +1,55 @@
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
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        status = "okay";
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
index 0e64787aa..766847ad2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12573,6 +12573,13 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/sound/max9860.txt
 F:	sound/soc/codecs/max9860.*
 
+MAX14001 IIO ADC DRIVER
+M:	Kim Seer Paller <kimseer.paller@analog.com>
+L:	linux-iio@vger.kernel.org
+S:	Supported
+W:	https://ez.analog.com/linux-software-drivers
+F:	Documentation/devicetree/bindings/iio/dac/adi,max14001.yaml
+
 MAXBOTIX ULTRASONIC RANGER IIO DRIVER
 M:	Andreas Klinger <ak@it-klinger.de>
 L:	linux-iio@vger.kernel.org
-- 
2.34.1

