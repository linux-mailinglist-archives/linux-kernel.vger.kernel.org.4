Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFA1F65684D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 09:16:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbiL0IQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 03:16:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbiL0IQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 03:16:37 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19270616B;
        Tue, 27 Dec 2022 00:16:36 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BR87f8l018107;
        Tue, 27 Dec 2022 08:16:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=aMykm1529RSRKYLy5BBR1klB9BxD6Lr0yPQ+hOsFZKY=;
 b=j1ca0oQq9lQKTjUig35WCaGwAkGDgjTg02mX6qvsWoX9/E5Mj0ye83kwi5bnyoRfdCzF
 zgEeDYgMhNRliRAoW5V+mesLIYz1SMzIquPn7hcRYYVvA9aGVmMKG0rCHvZjRCgX2QFt
 g/t7FdF8gGoOemFEyVfehGMGGcYWwqErEvok/Il5mG9A2klEwr2CL8/41riP4UOCcM15
 1SJrtQxuxVUuj2HBK6/fX1OjMZIH2LDPhP9nFIiscinFIuzvc7QbJEKnhpQyoi6D2piQ
 kD9IY9bsAX2QQlRJpU/4a4BODPZqH3ZPtybptiJs01DVjqh3Ah1h6DklCtQFF8UFZw62 oQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mnpsvmuvs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Dec 2022 08:16:21 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BR8GK85001739
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Dec 2022 08:16:20 GMT
Received: from fenglinw2-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 27 Dec 2022 00:16:17 -0800
From:   Fenglin Wu <quic_fenglinw@quicinc.com>
To:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <pavel@ucw.cz>, <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Fenglin Wu <quic_fenglinw@quicinc.com>,
        <linux-leds@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <quic_collinsd@quicinc.com>, <quic_subbaram@quicinc.com>
Subject: [RESEND PATCH v5 2/2] dt-bindings: leds: add QCOM flash LED controller
Date:   Tue, 27 Dec 2022 16:15:23 +0800
Message-ID: <20221227081523.2277797-3-quic_fenglinw@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221227081523.2277797-1-quic_fenglinw@quicinc.com>
References: <20221227081523.2277797-1-quic_fenglinw@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 7cn_WluZIynlpXv1C5ZXpOJG9tyrtB-Z
X-Proofpoint-ORIG-GUID: 7cn_WluZIynlpXv1C5ZXpOJG9tyrtB-Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-27_04,2022-12-23_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=999 phishscore=0 priorityscore=1501 mlxscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1011 bulkscore=0 adultscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212270067
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding document for flash LED module inside Qualcomm Technologies,
Inc. PMICs.

Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/leds/qcom,spmi-flash-led.yaml    | 116 ++++++++++++++++++
 1 file changed, 116 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/qcom,spmi-flash-led.yaml

diff --git a/Documentation/devicetree/bindings/leds/qcom,spmi-flash-led.yaml b/Documentation/devicetree/bindings/leds/qcom,spmi-flash-led.yaml
new file mode 100644
index 000000000000..1b273aecaaec
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/qcom,spmi-flash-led.yaml
@@ -0,0 +1,116 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/leds/qcom,spmi-flash-led.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Flash LED device inside Qualcomm Technologies, Inc. PMICs
+
+maintainers:
+  - Fenglin Wu <quic_fenglinw@quicinc.com>
+
+description: |
+  Flash LED controller is present inside some Qualcomm Technologies, Inc. PMICs.
+  The flash LED module can have different number of LED channels supported
+  e.g. 3 or 4. There are some different registers between them but they can
+  both support maximum current up to 1.5 A per channel and they can also support
+  ganging 2 channels together to supply maximum current up to 2 A. The current
+  will be split symmetrically on each channel and they will be enabled and
+  disabled at the same time.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - qcom,pm8150c-flash-led
+          - qcom,pm8150l-flash-led
+          - qcom,pm8350c-flash-led
+      - const: qcom,spmi-flash-led
+
+  reg:
+    maxItems: 1
+
+patternProperties:
+  "^led-[0-3]$":
+    type: object
+    $ref: common.yaml#
+    unevaluatedProperties: false
+    description:
+      Represents the physical LED components which are connected to the
+      flash LED channels' output.
+
+    properties:
+      led-sources:
+        description:
+          The HW indices of the flash LED channels that connect to the
+          physical LED
+        allOf:
+          - minItems: 1
+            maxItems: 2
+            items:
+              enum: [1, 2, 3, 4]
+
+      led-max-microamp:
+        anyOf:
+          - minimum: 5000
+            maximum: 500000
+            multipleOf: 5000
+          - minimum: 10000
+            maximum: 1000000
+            multipleOf: 10000
+
+      flash-max-microamp:
+        anyOf:
+          - minimum: 12500
+            maximum: 1500000
+            multipleOf: 12500
+          - minimum: 25000
+            maximum: 2000000
+            multipleOf: 25000
+
+      flash-max-timeout-us:
+        minimum: 10000
+        maximum: 1280000
+        multipleOf: 10000
+
+    required:
+      - led-sources
+      - led-max-microamp
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/leds/common.h>
+    spmi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        led-controller@ee00 {
+            compatible = "qcom,pm8350c-flash-led", "qcom,spmi-flash-led";
+            reg = <0xee00>;
+
+            led-0 {
+                function = LED_FUNCTION_FLASH;
+                color = <LED_COLOR_ID_WHITE>;
+                led-sources = <1>, <4>;
+                led-max-microamp = <300000>;
+                flash-max-microamp = <2000000>;
+                flash-max-timeout-us = <1280000>;
+                function-enumerator = <0>;
+            };
+
+            led-1 {
+                function = LED_FUNCTION_FLASH;
+                color = <LED_COLOR_ID_YELLOW>;
+                led-sources = <2>, <3>;
+                led-max-microamp = <300000>;
+                flash-max-microamp = <2000000>;
+                flash-max-timeout-us = <1280000>;
+                function-enumerator = <1>;
+            };
+        };
+    };
-- 
2.25.1

