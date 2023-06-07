Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3981C725C89
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 13:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240296AbjFGLAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 07:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240500AbjFGLAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 07:00:11 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB1261FDC;
        Wed,  7 Jun 2023 03:58:52 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 357AiK99005199;
        Wed, 7 Jun 2023 10:56:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=smG/5RqUV9r3lpf7t81s/TdasSHKd4QEHKnq4m3+YA4=;
 b=UrI/hj5xlLXoImFsG7kRS5nFmkBNM5BJyMWjgq7wH6YDkTv6UO/QTTrCjNNy11bs/kGO
 GzdOrnOs/zLxaD1pGUbjeHtccQ7RvncCiSPwj6vvnSAmQfe4o9IF/W8v6By0qU1i8ViP
 Dobt2ICpbplSqUgDlsyXO5wi85VjbMGyKqAc2iXJuywyUtGExhnyt+0wEO30mlgvNyDd
 YuKsf0tH5KMwyahrHUclFjDqFtezPRALBIfnxikSlnlW0I7ANhdzjHYVTcdfEPbPJwmH
 HmoObkcIYXTVPIkRvkEoX2VCh9GXoSg9hu/u6xMS2SG8KiJY/W+cUCU63C8Lg057TKk6 Sw== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r2a9thkfm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Jun 2023 10:56:48 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 357AulKC025487
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 7 Jun 2023 10:56:47 GMT
Received: from varda-linux.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 7 Jun 2023 03:56:38 -0700
From:   Varadarajan Narayanan <quic_varada@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <gregkh@linuxfoundation.org>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <p.zabel@pengutronix.de>, <arnd@arndb.de>,
        <geert+renesas@glider.be>, <neil.armstrong@linaro.org>,
        <nfraprado@collabora.com>, <broonie@kernel.org>,
        <rafal@milecki.pl>, <quic_srichara@quicinc.com>,
        <quic_varada@quicinc.org>, <quic_wcheng@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-clk@vger.kernel.org>
CC:     Varadarajan Narayanan <quic_varada@quicinc.com>
Subject: [PATCH 2/9] dt-bindings: phy: qcom,m31: Document qcom,m31 USB phy
Date:   Wed, 7 Jun 2023 16:26:06 +0530
Message-ID: <14f60578e2935c0844537eab162af3afa52ffe39.1686126439.git.quic_varada@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1686126439.git.quic_varada@quicinc.com>
References: <cover.1686126439.git.quic_varada@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: LbTCSfTXNxpfeTxjqiBTijUyAv80Q3I7
X-Proofpoint-ORIG-GUID: LbTCSfTXNxpfeTxjqiBTijUyAv80Q3I7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-07_06,2023-06-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0
 impostorscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 phishscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306070089
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the M31 USB2 phy present in IPQ5332

Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
 .../devicetree/bindings/phy/qcom,m31.yaml          | 69 ++++++++++++++++++++++
 1 file changed, 69 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/qcom,m31.yaml

diff --git a/Documentation/devicetree/bindings/phy/qcom,m31.yaml b/Documentation/devicetree/bindings/phy/qcom,m31.yaml
new file mode 100644
index 0000000..8ad4ba4
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/qcom,m31.yaml
@@ -0,0 +1,69 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/qcom,m31.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm M31 USB PHY
+
+maintainers:
+  - Sricharan Ramabadhran <quic_srichara@quicinc.com>
+  - Varadarajan Narayanan <quic_varada@quicinc.org>
+
+description:
+  This file contains documentation for the USB M31 PHY found in Qualcomm
+  IPQ5018, IPQ5332 SoCs.
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - qcom,m31-usb-hsphy
+              - qcom,ipq5332-m31-usb-hsphy
+
+  reg:
+    description:
+      Offset and length of the M31 PHY register set
+    maxItems: 2
+
+  reg-names:
+    items:
+      - const: m31usb_phy_base
+      - const: qscratch_base
+
+  phy_type:
+    oneOf:
+      - items:
+          - enum:
+              - utmi
+              - ulpi
+
+  resets:
+    maxItems: 1
+    description:
+      List of phandles and reset pairs, one for each entry in reset-names.
+
+  reset-names:
+    items:
+      - const:
+          usb2_phy_reset
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,ipq5332-gcc.h>
+    hs_m31phy_0: hs_m31phy@5b00 {
+        compatible = "qcom,m31-usb-hsphy";
+        reg = <0x5b000 0x3000>,
+            <0x08af8800 0x400>;
+        reg-names = "m31usb_phy_base",
+                "qscratch_base";
+        phy_type = "utmi";
+        resets = <&gcc GCC_QUSB2_0_PHY_BCR>;
+        reset-names = "usb2_phy_reset";
+
+        status = "ok";
+    };
-- 
2.7.4

