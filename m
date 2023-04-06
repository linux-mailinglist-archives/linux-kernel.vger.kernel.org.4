Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3D26D9DC4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 18:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239705AbjDFQpp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 12:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239625AbjDFQpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 12:45:33 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB138559F;
        Thu,  6 Apr 2023 09:45:31 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 336E8vKY013196;
        Thu, 6 Apr 2023 12:45:06 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3psa9f7gxk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Apr 2023 12:45:06 -0400
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 336Gj4a2026199
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 6 Apr 2023 12:45:04 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Thu, 6 Apr 2023
 12:45:04 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 6 Apr 2023 12:45:03 -0400
Received: from daniel-Precision-5530.ad.analog.com ([10.48.65.214])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 336Gi7JV002852;
        Thu, 6 Apr 2023 12:44:54 -0400
From:   Daniel Matyas <daniel.matyas@analog.com>
CC:     Daniel Matyas <daniel.matyas@analog.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>, Marek Vasut <marex@denx.de>,
        Vincent Tremblay <vincent@vtremblay.dev>,
        "Greg.Schwendimann@infineon.com" <Greg.Schwendimann@infineon.com>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        <linux-hwmon@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] dt-bindings: hwmon: add MAX31827
Date:   Thu, 6 Apr 2023 19:43:26 +0300
Message-ID: <20230406164331.6557-2-daniel.matyas@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230406164331.6557-1-daniel.matyas@analog.com>
References: <20230406164331.6557-1-daniel.matyas@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: GCUrz-Ab2bp3GuKO0jawY1-7tkr378bY
X-Proofpoint-ORIG-GUID: GCUrz-Ab2bp3GuKO0jawY1-7tkr378bY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-06_10,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 phishscore=0 priorityscore=1501 bulkscore=0 impostorscore=0 adultscore=0
 mlxscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304060149
X-Spam-Status: No, score=-0.7 required=5.0 tests=RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
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
 .../bindings/hwmon/adi,max31827.yaml          | 48 +++++++++++++++++++
 .../devicetree/bindings/trivial-devices.yaml  |  2 +
 MAINTAINERS                                   |  7 +++
 3 files changed, 57 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/adi,max31827.yaml

diff --git a/Documentation/devicetree/bindings/hwmon/adi,max31827.yaml b/Documentation/devicetree/bindings/hwmon/adi,max31827.yaml
new file mode 100644
index 000000000000..b6ed2d46a35d
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/adi,max31827.yaml
@@ -0,0 +1,48 @@
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
+properties:
+  compatible:
+    enum:
+      - adi,max31827
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
+        status = "okay";
+        max31827: max31827@42 {
+            compatible = "adi,max31827";
+            reg = <0x42>;
+            vref-supply = <&reg_vdd>;
+        };
+    };
+...
\ No newline at end of file
diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 6f482a254a1d..7763610b97bc 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -43,6 +43,8 @@ properties:
           - adi,adp5589
             # Analog Devices LT7182S Dual Channel 6A, 20V PolyPhase Step-Down Silent Switcher
           - adi,lt7182s
+            # MAX31827 Low-Power Temperature Switch with I2C interface
+          - adi,max31827
             # AMS iAQ-Core VOC Sensor
           - ams,iaq-core
             # i2c serial eeprom (24cxx)
diff --git a/MAINTAINERS b/MAINTAINERS
index 90abe83c02f3..549cea6bc340 100644
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

