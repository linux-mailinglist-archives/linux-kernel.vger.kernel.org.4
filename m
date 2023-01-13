Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B52D669AE9
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 15:51:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbjAMOvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 09:51:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjAMOvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 09:51:17 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DABF6A41D5;
        Fri, 13 Jan 2023 06:37:47 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30DCuEEq011963;
        Fri, 13 Jan 2023 14:37:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=emK3ivnMVpTbuaRO6S0ZBxspc1eopUyUDaOExihAF2U=;
 b=pw2FDgjT+0g9LHVZvC/pje/+uNoLnWdLuHiyuKRrAGRcB2BIisAzJgw54Vtl0IC8+nhP
 KPumiTM6hlYCWhc67XMJ5Ih+xUtA96XNHMSa+cjnCVcsk4RBKAlxf1P2cNHE0SINsh7R
 gj8SjRh8sGpZ2hG4I3lz4G9CYgNxNo5SsqS+wwBaMXzQH0WvLRoGLbgWhjtFC+9VfWk9
 iFsBSOJI/np27eqeBPzz6yZwWVkERylBThr+ZIVmy9a1VHlZjvesRaaATiPoHGVN4sSV
 p2r9vVnY5+JvSGDpJ3PQIjzS9t3u5ia9142wsPMhdkrglHMJ/6RS9+EzGPHF+02FqsmU zQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n2fwpuc1d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Jan 2023 14:37:21 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30DEbJSf030182
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Jan 2023 14:37:19 GMT
Received: from devipriy-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Fri, 13 Jan 2023 06:37:11 -0800
From:   devi priya <quic_devipriy@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <jassisinghbrar@gmail.com>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <shawnguo@kernel.org>, <arnd@arndb.de>,
        <marcel.ziswiler@toradex.com>, <dmitry.baryshkov@linaro.org>,
        <nfraprado@collabora.com>, <broonie@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <quic_srichara@quicinc.com>, <quic_gokulsri@quicinc.com>,
        <quic_sjaganat@quicinc.com>, <quic_kathirav@quicinc.com>,
        <quic_arajkuma@quicinc.com>, <quic_anusha@quicinc.com>,
        <quic_poovendh@quicinc.com>
Subject: [PATCH 1/6] dt-bindings: clock: Add YAML schemas for QCOM A73 PLL
Date:   Fri, 13 Jan 2023 20:06:42 +0530
Message-ID: <20230113143647.14961-2-quic_devipriy@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230113143647.14961-1-quic_devipriy@quicinc.com>
References: <20230113143647.14961-1-quic_devipriy@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: t14IYcrqzmyTHYHYFBpLx_d6RJSkHUcZ
X-Proofpoint-ORIG-GUID: t14IYcrqzmyTHYHYFBpLx_d6RJSkHUcZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-13_06,2023-01-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 spamscore=0 impostorscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 bulkscore=0 suspectscore=0
 adultscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301130096
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add schema for primary CPU PLL found on few Qualcomm platforms.

Co-developed-by: Praveenkumar I <quic_ipkumar@quicinc.com>
Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
Signed-off-by: devi priya <quic_devipriy@quicinc.com>
---
 .../bindings/clock/qcom,a73pll.yaml           | 52 +++++++++++++++++++
 1 file changed, 52 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,a73pll.yaml

diff --git a/Documentation/devicetree/bindings/clock/qcom,a73pll.yaml b/Documentation/devicetree/bindings/clock/qcom,a73pll.yaml
new file mode 100644
index 000000000000..a0e81094db8d
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qcom,a73pll.yaml
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/qcom,a73pll.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm A73 PLL clock
+
+maintainers:
+  - Bjorn Andersson <andersson@kernel.org>
+
+description:
+  The A73 PLL on few Qualcomm platforms is the main CPU PLL used for
+  frequencies above 1GHz.
+
+properties:
+  compatible:
+    enum:
+      - qcom,ipq9574-a73pll
+
+  reg:
+    maxItems: 1
+
+  '#clock-cells':
+    const: 0
+
+  clocks:
+    items:
+      - description: board XO clock
+
+  clock-names:
+    items:
+      - const: xo
+
+  operating-points-v2: true
+
+required:
+  - compatible
+  - reg
+  - '#clock-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    a73pll: clock@b116000 {
+            compatible = "qcom,ipq9574-a73pll";
+            reg = <0x0b116000 0x40>;
+            #clock-cells = <0>;
+            clocks = <&xo_board_clk>;
+            clock-names = "xo";
+    };
-- 
2.17.1

