Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B523B6F6CCC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 15:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbjEDNSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 09:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbjEDNSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 09:18:01 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A49B176B8;
        Thu,  4 May 2023 06:17:59 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 344C5bJw016070;
        Thu, 4 May 2023 09:17:43 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3qc40yumdb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 May 2023 09:17:43 -0400
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 344DHgHd000947
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 4 May 2023 09:17:42 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 4 May 2023 09:17:41 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 4 May 2023 09:17:41 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 4 May 2023 09:17:41 -0400
Received: from daniel-Precision-5530.ad.analog.com ([10.48.65.214])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 344DHKoR020836;
        Thu, 4 May 2023 09:17:35 -0400
From:   Daniel Matyas <daniel.matyas@analog.com>
CC:     Daniel Matyas <daniel.matyas@analog.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        <linux-hwmon@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: [PATCH v5 1/2] dt-bindings: hwmon: add MAX31827
Date:   Thu, 4 May 2023 19:17:10 +0300
Message-ID: <20230504161714.6281-2-daniel.matyas@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230504161714.6281-1-daniel.matyas@analog.com>
References: <20230504161714.6281-1-daniel.matyas@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: -t89IhYpP0-srTGBq6sm-E1Tmq0iIADa
X-Proofpoint-GUID: -t89IhYpP0-srTGBq6sm-E1Tmq0iIADa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-04_08,2023-05-04_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 malwarescore=0 adultscore=0 clxscore=1011 suspectscore=0 spamscore=0
 phishscore=0 mlxlogscore=999 impostorscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305040107
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MAX31827 is a low-power temperature switch with I2C interface.

The device is a ±1°C accuracy from -40°C to +125°C
(12 bits) local temperature switch and sensor with I2C/SM-
Bus interface. The combination of small 6-bump wafer-lev-
el package (WLP) and high accuracy makes this temper-
ature sensor/switch ideal for a wide range of applications.

Signed-off-by: Daniel Matyas <daniel.matyas@analog.com>
---
 .../bindings/hwmon/adi,max31827.yaml          | 54 +++++++++++++++++++
 MAINTAINERS                                   |  7 +++
 2 files changed, 61 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/adi,max31827.yaml

diff --git a/Documentation/devicetree/bindings/hwmon/adi,max31827.yaml b/Documentation/devicetree/bindings/hwmon/adi,max31827.yaml
new file mode 100644
index 000000000000..2dc8b07b4d3b
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/adi,max31827.yaml
@@ -0,0 +1,54 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/hwmon/adi,max31827.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices MAX31827, MAX31828, MAX31829 Low-Power Temperature Switch
+
+maintainers:
+  - Daniel Matyas <daniel.matyas@analog.com>
+
+description: |
+  Analog Devices MAX31827, MAX31828, MAX31829 Low-Power Temperature Switch with
+  I2C Interface
+  https://www.analog.com/media/en/technical-documentation/data-sheets/MAX31827-MAX31829.pdf
+
+properties:
+  compatible:
+    oneOf:
+      - const: adi,max31827
+      - items:
+          - enum:
+              - adi,max31828
+              - adi,max31829
+          - const: adi,max31827
+
+  reg:
+    maxItems: 1
+
+  vref-supply:
+    description:
+      Must have values in the interval (1.6V; 3.6V) in order for the device to
+      function correctly.
+
+required:
+  - compatible
+  - reg
+  - vref-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        temperature-sensor@42 {
+            compatible = "adi,max31827";
+            reg = <0x42>;
+            vref-supply = <&reg_vdd>;
+        };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index c6545eb54104..0997a0490c97 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12535,6 +12535,13 @@ F:	Documentation/userspace-api/media/drivers/max2175.rst
 F:	drivers/media/i2c/max2175*
 F:	include/uapi/linux/max2175.h
 
+MAX31827 TEMPERATURE SWITCH DRIVER
+M:	Daniel Matyas <daniel.matyas@analog.com>
+L:	linux-hwmon@vger.kernel.org
+S:	Supported
+W:	http://ez.analog.com/community/linux-device-drivers
+F:	Documentation/devicetree/bindings/hwmon/adi,max31827.yaml
+
 MAX6650 HARDWARE MONITOR AND FAN CONTROLLER DRIVER
 L:	linux-hwmon@vger.kernel.org
 S:	Orphan
-- 
2.34.1

