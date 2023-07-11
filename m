Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C7FB74E96E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 10:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbjGKIwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 04:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbjGKIwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 04:52:38 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EFDFE4F;
        Tue, 11 Jul 2023 01:52:33 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36B6VlHp014648;
        Tue, 11 Jul 2023 08:52:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=+8b57zQ4pEjMUHDbw5SDvUkRPp3ZddnuAnUlZFYVFOM=;
 b=pTVoJgyBs0wnRF5h2ogCGcjYxzBY/3f5jdwNS8GQw7InzgAtnnk2o7tlCiWoVibvAedh
 K/vIGWM2mqQ6iW3l7hhMQLTly2PTC6pfnUBlIHZbQ9tFRpVGpptn8gSmA/iCXpf9Oakc
 0MJ+jO/hYhRo/cITwkCmIwPZs3PBu6JouR18xsUMZwNUIvzYhNtIopM64RXvjKvD4Nq0
 PdGJihEnw1qeOo8fguCb2Dbhi1NPHHjsnEkt7aSE7TRpt1haLl4ZEBlbrU0cFzBvgXLq
 sg2oSQt0sXRqR2tlyG99vCHO2qx6Rbw0zYbG/t+7OjrIPMKvoK4+5cB8I/iLwCnyomkA aQ== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rs1mnra5u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Jul 2023 08:52:08 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36B8q7Uk017497
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Jul 2023 08:52:07 GMT
Received: from varda-linux.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 11 Jul 2023 01:51:59 -0700
From:   Varadarajan Narayanan <quic_varada@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <gregkh@linuxfoundation.org>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <p.zabel@pengutronix.de>, <arnd@arndb.de>,
        <geert+renesas@glider.be>, <neil.armstrong@linaro.org>,
        <nfraprado@collabora.com>, <broonie@kernel.org>,
        <rafal@milecki.pl>, <quic_srichara@quicinc.com>,
        <quic_varada@quicinc.org>, <quic_wcheng@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC:     Varadarajan Narayanan <quic_varada@quicinc.com>
Subject: [PATCH v3 2/6] dt-bindings: phy: qcom,m31: Document qcom,m31 USB phy
Date:   Tue, 11 Jul 2023 14:21:08 +0530
Message-ID: <77fe66271044a18871e1dfb80bbb481617197d18.1689065318.git.quic_varada@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1689065318.git.quic_varada@quicinc.com>
References: <cover.1689065318.git.quic_varada@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: OpErZ2xAMTxhGd1g04IXjDs-bbZMLqVP
X-Proofpoint-GUID: OpErZ2xAMTxhGd1g04IXjDs-bbZMLqVP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-11_04,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 adultscore=0 spamscore=0 priorityscore=1501 mlxscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307110078
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the M31 USB2 phy present in IPQ5332.

Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
v3:
	Incorporate review comments. Will bring in ipq5018 compatible
	string while posting ipq5018 usb patchset.

v1:
	Rename qcom,m31.yaml -> qcom,ipq5332-usb-hsphy.yaml
	Drop default binding "m31,usb-hsphy"
	Add clock
	Remove 'oneOf' from compatible
	Remove 'qscratch' region from register space as it is not needed
	Remove reset-names
	Fix the example definition
---
 .../bindings/phy/qcom,ipq5332-usb-hsphy.yaml       | 49 ++++++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/qcom,ipq5332-usb-hsphy.yaml

diff --git a/Documentation/devicetree/bindings/phy/qcom,ipq5332-usb-hsphy.yaml b/Documentation/devicetree/bindings/phy/qcom,ipq5332-usb-hsphy.yaml
new file mode 100644
index 0000000..2cfdd73
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/qcom,ipq5332-usb-hsphy.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/qcom,ipq5332-usb-hsphy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: M31 (https://www.m31tech.com) USB PHY
+
+maintainers:
+  - Sricharan Ramabadhran <quic_srichara@quicinc.com>
+  - Varadarajan Narayanan <quic_varada@quicinc.org>
+
+description:
+  USB M31 PHY found in Qualcomm IPQ5018, IPQ5332 SoCs.
+
+properties:
+  compatible:
+    enum:
+      - qcom,ipq5332-usb-hsphy
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    maxItems: 1
+    contains:
+      items:
+        - const: cfg_ahb
+
+  resets:
+    maxItems: 1
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,ipq5332-gcc.h>
+    usbphy0: ipq5332-hsphy@7b000 {
+        compatible = "qcom,ipq5332-usb-hsphy";
+        reg = <0x0007b000 0x12c>;
+
+        clocks = <&gcc GCC_USB0_PHY_CFG_AHB_CLK>;
+        clock-names = "cfg_ahb";
+
+        resets = <&gcc GCC_QUSB2_0_PHY_BCR>;
+    };
-- 
2.7.4

