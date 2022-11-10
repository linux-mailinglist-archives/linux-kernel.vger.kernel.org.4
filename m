Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5FA2623C28
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 07:55:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232302AbiKJGzp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 01:55:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232378AbiKJGzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 01:55:38 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D3942F640;
        Wed,  9 Nov 2022 22:55:37 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AA6hpUl018212;
        Thu, 10 Nov 2022 06:55:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=aMykm1529RSRKYLy5BBR1klB9BxD6Lr0yPQ+hOsFZKY=;
 b=OzQMPQecy9g9bqotGWaaz6i1jlkz3Ya26sO0A9Z8yV8MJh24ejFiWNw1ygam8HYNYrhF
 rl9lCBA5op2M8I1/FKBYHDMra283ZVwDrBARmNgIc8FO0VQu/xUe606DilUefMoq111S
 dOJ7m4UMGMZWl9fzqqvza9J9XydJnx7OMm72h0ugGINibhLgvUkpA4yI9RXzywan59QP
 BiwoN+LS5pGaacmhv1Op9uY3ijOL9LgGSXiUTb7lTCPPojWi2ylEiRM7G3EDBjlGzy3S
 sk7UAFQrYahwLwt/EJ1+XX+bgIqTk0Hr7ZeB53R9Krut/hwMpFLsdoNe66Hm3hGZoIkN fg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3krv9980um-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Nov 2022 06:55:27 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2AA6tQrr032287
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Nov 2022 06:55:26 GMT
Received: from fenglinw2-gv.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Wed, 9 Nov 2022 22:55:22 -0800
From:   Fenglin Wu <quic_fenglinw@quicinc.com>
To:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <krzysztof.kozlowski@linaro.org>, Andy Gross <agross@kernel.org>,
        "Bjorn Andersson" <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Fenglin Wu <quic_fenglinw@quicinc.com>,
        <linux-leds@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <quic_collinsd@quicinc.com>, <quic_subbaram@quicinc.com>
Subject: [PATCH v5 2/2] dt-bindings: leds: add QCOM flash LED controller
Date:   Thu, 10 Nov 2022 14:54:19 +0800
Message-ID: <20221110065420.2451436-3-quic_fenglinw@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221110065420.2451436-1-quic_fenglinw@quicinc.com>
References: <20221110065420.2451436-1-quic_fenglinw@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 5fh3u2DdoJT71nJk2WkwdL7I5ho3PR5v
X-Proofpoint-ORIG-GUID: 5fh3u2DdoJT71nJk2WkwdL7I5ho3PR5v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-09_06,2022-11-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1011
 priorityscore=1501 mlxscore=0 malwarescore=0 spamscore=0 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211100051
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

