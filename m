Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 974AB685E50
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 05:19:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbjBAETL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 23:19:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbjBAETF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 23:19:05 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C75B9402F7;
        Tue, 31 Jan 2023 20:19:04 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3113PDQk031113;
        Wed, 1 Feb 2023 04:19:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=PQt3fQopKUNxXskBOhMqwr8e4wI+me9M7xC10H3pHa8=;
 b=Xy6+L65DY0FpIu52lPvlqijj5zL1B7SL8St/TDzohXOHTHUilMkLGect6zddwN+NZPEU
 5q4kuUuQrBGLxhBzJ/wmsZgdwqH5OJvAhTJ2eWUSve3q7ZFcDJLatq9meyWc/BxxfPIh
 FXT2yxjLOBXD/XWy0y5y9fnRehCRLS6XKrI/557RGg864CECceDZ1/b6kA3tBbxjyo1s
 +NsfRt5OuBvH2+IEx7fI/yl4AgsPTQiN4z5Qus3DM6/Va3oqB5z/MIGV4FGlRXP1iGYR
 VH5neS8ub0iSdTXEk9q3yT1WBLm8/Lj2r0chRf7Erf/10MS64+Qv5UJqCj/dvQURRSJq RQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3neua9b4p2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Feb 2023 04:19:00 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3114IxUa009898
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 1 Feb 2023 04:18:59 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 31 Jan 2023 20:18:59 -0800
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sebastian Reichel <sre@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        "Subbaraman Narayanamurthy" <quic_subbaram@quicinc.com>,
        Johan Hovold <johan@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v4 1/4] dt-bindings: soc: qcom: Introduce PMIC GLINK binding
Date:   Tue, 31 Jan 2023 20:18:50 -0800
Message-ID: <20230201041853.1934355-2-quic_bjorande@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230201041853.1934355-1-quic_bjorande@quicinc.com>
References: <20230201041853.1934355-1-quic_bjorande@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: YbTn68O2dTx1PqzV7z5KpU9Izvi_elb5
X-Proofpoint-ORIG-GUID: YbTn68O2dTx1PqzV7z5KpU9Izvi_elb5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-01_01,2023-01-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 mlxscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 phishscore=0 priorityscore=1501 clxscore=1015 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302010035
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Andersson <bjorn.andersson@linaro.org>

The PMIC GLINK service, running on a coprocessor on some modern Qualcomm
platforms and implement USB Type-C handling and battery management.
This binding describes the component in the OS used to communicate with
the firmware and connect it's resources to those described in the
Devicetree, particularly the USB Type-C controllers relationship with
USB and DisplayPort components.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Tested-by: Konrad Dybcio <konrad.dybcio@linaro.org> # SM8350 PDX215
Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---

Changes since v3:
- Dropped the additional endpoint from port@1 after discussions with
  Rob.

 .../bindings/soc/qcom/qcom,pmic-glink.yaml    | 95 +++++++++++++++++++
 1 file changed, 95 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml
new file mode 100644
index 000000000000..cf863683c21a
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml
@@ -0,0 +1,95 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/qcom/qcom,pmic-glink.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm PMIC GLINK firmware interface for battery management, USB
+  Type-C and other things.
+
+maintainers:
+  - Bjorn Andersson <andersson@kernel.org>
+
+description:
+  The PMIC GLINK service, running on a coprocessor on some modern Qualcomm
+  platforms and implement USB Type-C handling and battery management. This
+  binding describes the component in the OS used to communicate with the
+  firmware and connect it's resources to those described in the Devicetree,
+  particularly the USB Type-C controllers relationship with USB and DisplayPort
+  components.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - qcom,sc8180x-pmic-glink
+          - qcom,sc8280xp-pmic-glink
+          - qcom,sm8350-pmic-glink
+      - const: qcom,pmic-glink
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+patternProperties:
+  '^connector@\d$':
+    $ref: /schemas/connector/usb-connector.yaml#
+
+    properties:
+      reg: true
+
+    required:
+      - reg
+
+    unevaluatedProperties: false
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |+
+    pmic-glink {
+        compatible = "qcom,sc8280xp-pmic-glink", "qcom,pmic-glink";
+
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        connector@0 {
+            compatible = "usb-c-connector";
+            reg = <0>;
+            power-role = "dual";
+            data-role = "dual";
+
+            ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                port@0 {
+                    reg = <0>;
+                    endpoint {
+                        remote-endpoint = <&usb_role>;
+                    };
+                };
+
+                port@1 {
+                    reg = <1>;
+                    endpoint {
+                        remote-endpoint = <&ss_phy_out>;
+                    };
+                };
+
+                port@2 {
+                    reg = <2>;
+                    endpoint {
+                        remote-endpoint = <&sbu_mux>;
+                    };
+                };
+            };
+        };
+    };
+...
+
-- 
2.25.1

