Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB0AF5EF514
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 14:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234950AbiI2MRT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 08:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233332AbiI2MRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 08:17:13 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F15E912969D;
        Thu, 29 Sep 2022 05:17:12 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28TC6a0N011217;
        Thu, 29 Sep 2022 12:16:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=Ig3jvnmNG9tfXnK/SbLfElPIPtLnqMM2dqS2NOO1tDQ=;
 b=lwgvxAA6Q92JgvBXmWQsVlaAsf5ThMP6KbguE5i4ChRdpjRV13g88YqOH19x8OTIQB8n
 qa1u8HZYfD/f6u3ZwquzlDxyuWtpH/64sHfduoTqfeQ39YqEi/0N6QfSEco6JejjRtc3
 Fq4d2kf8pfi0jKg+gqwlrgt6Xhc9/xt1D2VvJP2cYwNL5OtnNuoXHcmiFzaY/lzlctVq
 fIGxFl889yv2q8+NlQVvjB6jzS1JUtwPAKAtnQ/m6Hsqwn9pL3ziNuAfw4yeopei5RKa
 J6Woa+hV9+gbYXg6izvD7woaGNM3os2AVRqQzuaRqY1xNyCwcHN9ZT+rFyMVNyfNv6Kh cw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jvbf0maes-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Sep 2022 12:16:40 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28TCGdBC029902
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Sep 2022 12:16:39 GMT
Received: from fenglinw2-gv.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Thu, 29 Sep 2022 05:16:36 -0700
From:   Fenglin Wu <quic_fenglinw@quicinc.com>
To:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <krzysztof.kozlowski@linaro.org>, Andy Gross <agross@kernel.org>,
        "Bjorn Andersson" <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Fenglin Wu <quic_fenglinw@quicinc.com>,
        <linux-leds@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <collinsd@codeaurora.org>, <subbaram@codeaurora.org>
Subject: [PATCH v2 2/2] dt-bindings: add bindings for QCOM flash LED
Date:   Thu, 29 Sep 2022 20:15:44 +0800
Message-ID: <20220929121544.1064279-3-quic_fenglinw@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220929121544.1064279-1-quic_fenglinw@quicinc.com>
References: <20220929121544.1064279-1-quic_fenglinw@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: JISlVWSgcyyNyMVBp3EUsS3Ezr6JXz18
X-Proofpoint-ORIG-GUID: JISlVWSgcyyNyMVBp3EUsS3Ezr6JXz18
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-29_06,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 mlxscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 lowpriorityscore=0 mlxlogscore=999 adultscore=0 clxscore=1015 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209290076
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding document for flash LED module inside Qualcomm Technologies,
Inc. PMICs.

Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>
---
 .../bindings/leds/qcom,spmi-flash-led.yaml    | 120 ++++++++++++++++++
 1 file changed, 120 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/qcom,spmi-flash-led.yaml

diff --git a/Documentation/devicetree/bindings/leds/qcom,spmi-flash-led.yaml b/Documentation/devicetree/bindings/leds/qcom,spmi-flash-led.yaml
new file mode 100644
index 000000000000..3ab1113a7b28
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/qcom,spmi-flash-led.yaml
@@ -0,0 +1,120 @@
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
+  reg:
+    description: address offset of the flash LED controller
+    maxItems: 1
+
+patternProperties:
+  "^led[0-3]$":
+    type: object
+    $ref: common.yaml#
+    unevaluatedProperties: false
+    description: |
+      Represents the physical LED components which are connected to the
+      flash LED channels' output.
+
+    properties:
+      led-sources:
+        description: |
+          The HW indices of the flash LED channels that connect to the
+          physical LED
+        allOf:
+          - minItems: 1
+            maxItems: 2
+            items:
+              enum: [1, 2, 3, 4]
+
+      led-max-microamp:
+        description: |
+          The maximum current value when LED is not operating in flash mode (i.e. torch mode)
+          Valid values when an LED is connected to one flash LED channel:
+            5000 - 500000, step by 5000
+          Valid values when an LED is connected to two flash LED channels:
+            10000 - 1000000, step by 10000
+        minimum: 5000
+        maximum: 1000000
+
+      flash-max-microamp:
+        description: |
+          The maximum current value when LED is operating in flash mode.
+          Valid values when an LED is connected to one flash LED channel:
+            12500 - 1500000, step by 12500
+          Valid values when an LED is connected to two flash LED channels:
+            25000 - 2000000, step by 12500
+        minimum: 12500
+        maximum: 2000000
+
+      flash-max-timeout-us:
+        description: |
+          The maximum timeout value when LED is operating in flash mode.
+          Valid values: 10000 - 1280000, step by 10000
+        minimum: 10000
+        maximum: 1280000
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
+    spmi_bus {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        led-controller@ee00 {
+            compatible = "qcom,pm8350c-flash-led", "qcom,spmi-flash-led";
+            reg = <0xee00>;
+
+            led0 {
+                function = LED_FUNCTION_FLASH;
+                color = <LED_COLOR_ID_WHITE>;
+                led-sources = <1>, <4>;
+                led-max-microamp = <300000>;
+                flash-max-microamp = <2000000>;
+                flash-max-timeout-us = <1280000>;
+                function-enumerator = <0>;
+            };
+
+            led1 {
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

