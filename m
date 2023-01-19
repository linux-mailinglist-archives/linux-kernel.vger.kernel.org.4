Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96A8F674596
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 23:12:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbjASWL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 17:11:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbjASWLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 17:11:06 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1903DB792;
        Thu, 19 Jan 2023 13:48:05 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30JKpuxk009329;
        Thu, 19 Jan 2023 21:47:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=yIOZfy4VWsUhlTa3vEv8YxnNHLpzxL4zqV3VNj42y0k=;
 b=Gy1ve9f9jXqwo5HKLdXkjWoKiJiXqsSs3DFdozu7ur7e0VluWd2Bz5nrRhZTNtcxIxfY
 JK+m40xrTbrPX687sOiwHTS6fW19envAOS4BHm48rst9IqpVfLqUzaX2ySPgd0syqvIs
 jAzPgR8o1SpTssE2pW94OBwY5nnuhIf5JXa/5XTCKOV7+XmExPtiEsUV/eXt0giQrNdF
 oNppQywTeexZsyccG1yf2F1g7DQEVziha8T/CM3LTSlVUJgG1O0T7fo0yYTzS02gFSpk
 Od2hkhqAvcrzcW3N5FtU7IoNHND665wo4x0YPQ4X+X7NBIu5wIqEyvpPniBZ9fmUcFvu Ug== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n7c28ga28-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Jan 2023 21:47:56 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30JLlt6L012606
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Jan 2023 21:47:55 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Thu, 19 Jan 2023 13:47:54 -0800
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>
Subject: [PATCH 1/4] dt-bindings: regulator: Describe Maxim MAX20411
Date:   Thu, 19 Jan 2023 13:47:46 -0800
Message-ID: <20230119214749.4048933-2-quic_bjorande@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230119214749.4048933-1-quic_bjorande@quicinc.com>
References: <20230119214749.4048933-1-quic_bjorande@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: tqx9Wg_ciZ-vTdFRdKn4F14ZUCp78_6o
X-Proofpoint-ORIG-GUID: tqx9Wg_ciZ-vTdFRdKn4F14ZUCp78_6o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-19_14,2023-01-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 mlxlogscore=999
 clxscore=1015 mlxscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301190183
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding for the Maxim MAX20411 step-down DC-DC converter.

Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
 .../bindings/regulator/maxim,max20411.yaml    | 59 +++++++++++++++++++
 1 file changed, 59 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/maxim,max20411.yaml

diff --git a/Documentation/devicetree/bindings/regulator/maxim,max20411.yaml b/Documentation/devicetree/bindings/regulator/maxim,max20411.yaml
new file mode 100644
index 000000000000..3d1ba6139370
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/maxim,max20411.yaml
@@ -0,0 +1,59 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/maxim,max20411.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Maxim Integrated MAX20411 Step-Down DC-DC Converter
+
+maintainers:
+  - Bjorn Andersson <andersson@kernel.org>
+
+description:
+  The MAX20411 is a high-efficiency, DC-DC step-down converter. It provides
+  configurable output voltage in the range of 0.5V to 1.275V, configurable over
+  I2C.
+
+allOf:
+  - $ref: regulator.yaml#
+
+properties:
+  compatible:
+    const: maxim,max20411
+
+  reg:
+    maxItems: 1
+
+  enable-gpios:
+    maxItems: 1
+    description: GPIO connected to the EN pin, active high
+
+  vdd-supply:
+    description: Input supply for the device (VDD pin, 3.0V to 5.5V)
+
+required:
+  - compatible
+  - reg
+  - enable-gpios
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        regulator@39 {
+            compatible = "maxim,max20411";
+            reg = <0x39>;
+
+            enable-gpios = <&gpio 2 GPIO_ACTIVE_HIGH>;
+
+            regulator-min-microvolt = <800000>;
+            regulator-max-microvolt = <1000000>;
+        };
+    };
+...
-- 
2.37.3

