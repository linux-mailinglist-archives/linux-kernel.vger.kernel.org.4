Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD72740235
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 19:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231488AbjF0Rce (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 13:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbjF0Rcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 13:32:31 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C68268C;
        Tue, 27 Jun 2023 10:32:29 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35RF10sI015289;
        Tue, 27 Jun 2023 17:32:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=UiViJumGApJFh81PcIIDOOz8kBzQJ9Evdvrpr9fbFFU=;
 b=Ee8xyHoulhPpV0EIld8yJjD8JE6ffUvcWqabs7kCDgxvIAB4UDlY8C/pZHYayZXs7Tuu
 y1OLFS4+dfyJ7NsEveM3W1pT/WCeQAHaWD750INbTR3nI/egz/LGC0d0jVP8zPtLQqbu
 rXiP9fkU0ppv87yh2K/Z9lsXuB95zsB41Q/o2fS77g4Qj3Mf0I+AzKQAEBn+CDdJRnsH
 3cFCnTyRAYrkOD7XRhnoc8sXT60OvvZtISYvLuz30o1vdQYzMSfs7T8M/PzFy3rpAWdU
 CGLOp2pdVwbNruQswwczSUL6Oio+y5zHz9IneWhN5y/DjjN1eefPRttj767/qoFSgdqL xw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rg21t8dvx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Jun 2023 17:32:24 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35RHWNbf018968
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Jun 2023 17:32:23 GMT
Received: from hu-tdas-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Tue, 27 Jun 2023 10:32:20 -0700
From:   Taniya Das <quic_tdas@quicinc.com>
To:     <quic_tdas@quicinc.com>
CC:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <mturquette@baylibre.com>, <robh+dt@kernel.org>, <sboyd@kernel.org>
Subject: [PATCH] dt-bindings: clock: qcom: Update my email address
Date:   Tue, 27 Jun 2023 23:01:23 +0530
Message-ID: <20230627173123.9221-1-quic_tdas@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Z14I358E1hc0BZ_DsvXhY6B3pahRFt5v
X-Proofpoint-GUID: Z14I358E1hc0BZ_DsvXhY6B3pahRFt5v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-27_11,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=962 phishscore=0
 adultscore=0 suspectscore=0 clxscore=1011 priorityscore=1501 mlxscore=0
 bulkscore=0 malwarescore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306270158
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update my email address from the defunct codeaurora.org domain to the
current quicinc.com domain.

Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
---
 Documentation/devicetree/bindings/clock/qcom,gcc-apq8064.yaml   | 2 +-
 Documentation/devicetree/bindings/clock/qcom,gcc-ipq4019.yaml   | 2 +-
 Documentation/devicetree/bindings/clock/qcom,gcc-ipq8074.yaml   | 2 +-
 Documentation/devicetree/bindings/clock/qcom,gcc-msm8976.yaml   | 2 +-
 Documentation/devicetree/bindings/clock/qcom,gcc-msm8996.yaml   | 2 +-
 Documentation/devicetree/bindings/clock/qcom,gcc-msm8998.yaml   | 2 +-
 Documentation/devicetree/bindings/clock/qcom,gcc-other.yaml     | 2 +-
 Documentation/devicetree/bindings/clock/qcom,gcc-qcs404.yaml    | 2 +-
 Documentation/devicetree/bindings/clock/qcom,gcc-sc7180.yaml    | 2 +-
 Documentation/devicetree/bindings/clock/qcom,gcc-sc7280.yaml    | 2 +-
 Documentation/devicetree/bindings/clock/qcom,gcc-sdm845.yaml    | 2 +-
 Documentation/devicetree/bindings/clock/qcom,gcc-sm8150.yaml    | 2 +-
 Documentation/devicetree/bindings/clock/qcom,gcc-sm8250.yaml    | 2 +-
 Documentation/devicetree/bindings/clock/qcom,gcc.yaml           | 2 +-
 Documentation/devicetree/bindings/clock/qcom,gpucc.yaml         | 2 +-
 Documentation/devicetree/bindings/clock/qcom,mmcc.yaml          | 2 +-
 Documentation/devicetree/bindings/clock/qcom,msm8998-gpucc.yaml | 2 +-
 Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml        | 2 +-
 Documentation/devicetree/bindings/clock/qcom,sc7180-camcc.yaml  | 2 +-
 Documentation/devicetree/bindings/clock/qcom,sc7180-dispcc.yaml | 2 +-
 .../devicetree/bindings/clock/qcom,sc7180-lpasscorecc.yaml      | 2 +-
 Documentation/devicetree/bindings/clock/qcom,sc7180-mss.yaml    | 2 +-
 Documentation/devicetree/bindings/clock/qcom,sc7280-camcc.yaml  | 2 +-
 Documentation/devicetree/bindings/clock/qcom,sc7280-dispcc.yaml | 2 +-
 .../devicetree/bindings/clock/qcom,sc7280-lpasscc.yaml          | 2 +-
 .../devicetree/bindings/clock/qcom,sc7280-lpasscorecc.yaml      | 2 +-
 Documentation/devicetree/bindings/clock/qcom,sdm845-dispcc.yaml | 2 +-
 Documentation/devicetree/bindings/clock/qcom,videocc.yaml       | 2 +-
 28 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-apq8064.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-apq8064.yaml
index 09cd7a786871..19211176ee0b 100644
--- a/Documentation/devicetree/bindings/clock/qcom,gcc-apq8064.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,gcc-apq8064.yaml
@@ -8,7 +8,7 @@ title: Qualcomm Global Clock & Reset Controller on APQ8064/MSM8960

 maintainers:
   - Stephen Boyd <sboyd@kernel.org>
-  - Taniya Das <tdas@codeaurora.org>
+  - Taniya Das <quic_tdas@quicinc.com>

 description: |
   Qualcomm global clock control module provides the clocks, resets and power
diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-ipq4019.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-ipq4019.yaml
index 6ebaef2288fa..fb3957d485f9 100644
--- a/Documentation/devicetree/bindings/clock/qcom,gcc-ipq4019.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,gcc-ipq4019.yaml
@@ -8,7 +8,7 @@ title: Qualcomm Global Clock & Reset Controller on IPQ4019

 maintainers:
   - Stephen Boyd <sboyd@kernel.org>
-  - Taniya Das <tdas@codeaurora.org>
+  - Taniya Das <quic_tdas@quicinc.com>
   - Robert Marko <robert.markoo@sartura.hr>

 description: |
diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-ipq8074.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-ipq8074.yaml
index deef398a9872..52e7831a8d6d 100644
--- a/Documentation/devicetree/bindings/clock/qcom,gcc-ipq8074.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,gcc-ipq8074.yaml
@@ -8,7 +8,7 @@ title: Qualcomm Global Clock & Reset Controller on IPQ8074

 maintainers:
   - Stephen Boyd <sboyd@kernel.org>
-  - Taniya Das <tdas@codeaurora.org>
+  - Taniya Das <quic_tdas@quicinc.com>

 description: |
   Qualcomm global clock control module provides the clocks, resets and power
diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-msm8976.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-msm8976.yaml
index d2186e25f55f..62d6f1fe1228 100644
--- a/Documentation/devicetree/bindings/clock/qcom,gcc-msm8976.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,gcc-msm8976.yaml
@@ -8,7 +8,7 @@ title: Qualcomm Global Clock & Reset Controller on MSM8976

 maintainers:
   - Stephen Boyd <sboyd@kernel.org>
-  - Taniya Das <tdas@codeaurora.org>
+  - Taniya Das <quic_tdas@quicinc.com>

 description: |
   Qualcomm global clock control module provides the clocks, resets and power
diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-msm8996.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-msm8996.yaml
index f77036ace31b..97523cc1ecfb 100644
--- a/Documentation/devicetree/bindings/clock/qcom,gcc-msm8996.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,gcc-msm8996.yaml
@@ -8,7 +8,7 @@ title: Qualcomm Global Clock & Reset Controller on MSM8996

 maintainers:
   - Stephen Boyd <sboyd@kernel.org>
-  - Taniya Das <tdas@codeaurora.org>
+  - Taniya Das <quic_tdas@quicinc.com>

 description: |
   Qualcomm global clock control module which provides the clocks, resets and
diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-msm8998.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-msm8998.yaml
index 3c9729050d6f..58f7fb22c5c4 100644
--- a/Documentation/devicetree/bindings/clock/qcom,gcc-msm8998.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,gcc-msm8998.yaml
@@ -8,7 +8,7 @@ title: Qualcomm Global Clock & Reset Controller on MSM8998

 maintainers:
   - Stephen Boyd <sboyd@kernel.org>
-  - Taniya Das <tdas@codeaurora.org>
+  - Taniya Das <quic_tdas@quicinc.com>

 description: |
   Qualcomm global clock control module provides the clocks, resets and power
diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-other.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-other.yaml
index ae01e7749534..f65fdd72f4d8 100644
--- a/Documentation/devicetree/bindings/clock/qcom,gcc-other.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,gcc-other.yaml
@@ -8,7 +8,7 @@ title: Qualcomm Global Clock & Reset Controller

 maintainers:
   - Stephen Boyd <sboyd@kernel.org>
-  - Taniya Das <tdas@codeaurora.org>
+  - Taniya Das <quic_tdas@quicinc.com>

 description: |
   Qualcomm global clock control module provides the clocks, resets and power
diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-qcs404.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-qcs404.yaml
index b2256f81b265..7bc6c57e4d11 100644
--- a/Documentation/devicetree/bindings/clock/qcom,gcc-qcs404.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,gcc-qcs404.yaml
@@ -8,7 +8,7 @@ title: Qualcomm Global Clock & Reset Controller on QCS404

 maintainers:
   - Stephen Boyd <sboyd@kernel.org>
-  - Taniya Das <tdas@codeaurora.org>
+  - Taniya Das <quic_tdas@quicinc.com>

 description: |
   Qualcomm global clock control module provides the clocks, resets and power
diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-sc7180.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-sc7180.yaml
index 06dce0c6b7d0..24c7aa215cbb 100644
--- a/Documentation/devicetree/bindings/clock/qcom,gcc-sc7180.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,gcc-sc7180.yaml
@@ -8,7 +8,7 @@ title: Qualcomm Global Clock & Reset Controller on SC7180

 maintainers:
   - Stephen Boyd <sboyd@kernel.org>
-  - Taniya Das <tdas@codeaurora.org>
+  - Taniya Das <quic_tdas@quicinc.com>

 description: |
   Qualcomm global clock control module provides the clocks, resets and power
diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-sc7280.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-sc7280.yaml
index 947b47168cec..26150d5ca659 100644
--- a/Documentation/devicetree/bindings/clock/qcom,gcc-sc7280.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,gcc-sc7280.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Qualcomm Global Clock & Reset Controller on SC7280

 maintainers:
-  - Taniya Das <tdas@codeaurora.org>
+  - Taniya Das <quic_tdas@quicinc.com>

 description: |
   Qualcomm global clock control module provides the clocks, resets and power
diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-sdm845.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-sdm845.yaml
index 68e1b7822fe0..0595da0e8a42 100644
--- a/Documentation/devicetree/bindings/clock/qcom,gcc-sdm845.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,gcc-sdm845.yaml
@@ -8,7 +8,7 @@ title: Qualcomm Global Clock & Reset Controller on SDM670 and SDM845

 maintainers:
   - Stephen Boyd <sboyd@kernel.org>
-  - Taniya Das <tdas@codeaurora.org>
+  - Taniya Das <quic_tdas@quicinc.com>

 description: |
   Qualcomm global clock control module provides the clocks, resets and power
diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-sm8150.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-sm8150.yaml
index 3ea0ff37a4cb..58ccb7df847c 100644
--- a/Documentation/devicetree/bindings/clock/qcom,gcc-sm8150.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,gcc-sm8150.yaml
@@ -8,7 +8,7 @@ title: Qualcomm Global Clock & Reset Controller on SM8150

 maintainers:
   - Stephen Boyd <sboyd@kernel.org>
-  - Taniya Das <tdas@codeaurora.org>
+  - Taniya Das <quic_tdas@quicinc.com>

 description: |
   Qualcomm global clock control module provides the clocks, resets and power
diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-sm8250.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-sm8250.yaml
index b752542ee20c..27e60e50e791 100644
--- a/Documentation/devicetree/bindings/clock/qcom,gcc-sm8250.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,gcc-sm8250.yaml
@@ -8,7 +8,7 @@ title: Qualcomm Global Clock & Reset Controller on SM8250

 maintainers:
   - Stephen Boyd <sboyd@kernel.org>
-  - Taniya Das <tdas@codeaurora.org>
+  - Taniya Das <quic_tdas@quicinc.com>

 description: |
   Qualcomm global clock control module provides the clocks, resets and power
diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc.yaml
index 7129fbcf2b6c..788825105f24 100644
--- a/Documentation/devicetree/bindings/clock/qcom,gcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,gcc.yaml
@@ -8,7 +8,7 @@ title: Qualcomm Global Clock & Reset Controller Common Properties

 maintainers:
   - Stephen Boyd <sboyd@kernel.org>
-  - Taniya Das <tdas@codeaurora.org>
+  - Taniya Das <quic_tdas@quicinc.com>

 description: |
   Common bindings for Qualcomm global clock control module providing the
diff --git a/Documentation/devicetree/bindings/clock/qcom,gpucc.yaml b/Documentation/devicetree/bindings/clock/qcom,gpucc.yaml
index 1e3dc9deded9..e0af5f014d09 100644
--- a/Documentation/devicetree/bindings/clock/qcom,gpucc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,gpucc.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Qualcomm Graphics Clock & Reset Controller

 maintainers:
-  - Taniya Das <tdas@codeaurora.org>
+  - Taniya Das <quic_tdas@quicinc.com>

 description: |
   Qualcomm graphics clock control module provides the clocks, resets and power
diff --git a/Documentation/devicetree/bindings/clock/qcom,mmcc.yaml b/Documentation/devicetree/bindings/clock/qcom,mmcc.yaml
index acf0c923c24f..d2ae73be64ed 100644
--- a/Documentation/devicetree/bindings/clock/qcom,mmcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,mmcc.yaml
@@ -8,7 +8,7 @@ title: Qualcomm Multimedia Clock & Reset Controller

 maintainers:
   - Jeffrey Hugo <quic_jhugo@quicinc.com>
-  - Taniya Das <tdas@codeaurora.org>
+  - Taniya Das <quic_tdas@quicinc.com>

 description: |
   Qualcomm multimedia clock control module provides the clocks, resets and
diff --git a/Documentation/devicetree/bindings/clock/qcom,msm8998-gpucc.yaml b/Documentation/devicetree/bindings/clock/qcom,msm8998-gpucc.yaml
index 2d8897991663..7b271ae210a3 100644
--- a/Documentation/devicetree/bindings/clock/qcom,msm8998-gpucc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,msm8998-gpucc.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Qualcomm Graphics Clock & Reset Controller on MSM8998

 maintainers:
-  - Taniya Das <tdas@codeaurora.org>
+  - Taniya Das <quic_tdas@quicinc.com>

 description: |
   Qualcomm graphics clock control module provides the clocks, resets and power
diff --git a/Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml b/Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml
index d5a250b7c2af..26ce005dcadf 100644
--- a/Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Qualcomm Technologies, Inc. RPMh Clocks

 maintainers:
-  - Taniya Das <tdas@codeaurora.org>
+  - Taniya Das <quic_tdas@quicinc.com>

 description: |
   Resource Power Manager Hardened (RPMh) manages shared resources on
diff --git a/Documentation/devicetree/bindings/clock/qcom,sc7180-camcc.yaml b/Documentation/devicetree/bindings/clock/qcom,sc7180-camcc.yaml
index 098c8acf4bad..2dfc2a4f1918 100644
--- a/Documentation/devicetree/bindings/clock/qcom,sc7180-camcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,sc7180-camcc.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Qualcomm Camera Clock & Reset Controller on SC7180

 maintainers:
-  - Taniya Das <tdas@codeaurora.org>
+  - Taniya Das <quic_tdas@quicinc.com>

 description: |
   Qualcomm camera clock control module provides the clocks, resets and power
diff --git a/Documentation/devicetree/bindings/clock/qcom,sc7180-dispcc.yaml b/Documentation/devicetree/bindings/clock/qcom,sc7180-dispcc.yaml
index 95ad16d0abc3..1c9ce300a435 100644
--- a/Documentation/devicetree/bindings/clock/qcom,sc7180-dispcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,sc7180-dispcc.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Qualcomm Display Clock & Reset Controller on SC7180

 maintainers:
-  - Taniya Das <tdas@codeaurora.org>
+  - Taniya Das <quic_tdas@quicinc.com>

 description: |
   Qualcomm display clock control module provides the clocks, resets and power
diff --git a/Documentation/devicetree/bindings/clock/qcom,sc7180-lpasscorecc.yaml b/Documentation/devicetree/bindings/clock/qcom,sc7180-lpasscorecc.yaml
index f297694ef8b8..fdfb389083c1 100644
--- a/Documentation/devicetree/bindings/clock/qcom,sc7180-lpasscorecc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,sc7180-lpasscorecc.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Qualcomm LPASS Core Clock Controller on SC7180

 maintainers:
-  - Taniya Das <tdas@codeaurora.org>
+  - Taniya Das <quic_tdas@quicinc.com>

 description: |
   Qualcomm LPASS core clock control module provides the clocks and power
diff --git a/Documentation/devicetree/bindings/clock/qcom,sc7180-mss.yaml b/Documentation/devicetree/bindings/clock/qcom,sc7180-mss.yaml
index 1e856a8a996e..873a2f918bac 100644
--- a/Documentation/devicetree/bindings/clock/qcom,sc7180-mss.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,sc7180-mss.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Qualcomm Modem Clock Controller on SC7180

 maintainers:
-  - Taniya Das <tdas@codeaurora.org>
+  - Taniya Das <quic_tdas@quicinc.com>

 description: |
   Qualcomm modem clock control module provides the clocks on SC7180.
diff --git a/Documentation/devicetree/bindings/clock/qcom,sc7280-camcc.yaml b/Documentation/devicetree/bindings/clock/qcom,sc7280-camcc.yaml
index b60adbad4590..01feef1cab0a 100644
--- a/Documentation/devicetree/bindings/clock/qcom,sc7280-camcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,sc7280-camcc.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Qualcomm Camera Clock & Reset Controller on SC7280

 maintainers:
-  - Taniya Das <tdas@codeaurora.org>
+  - Taniya Das <quic_tdas@quicinc.com>

 description: |
   Qualcomm camera clock control module provides the clocks, resets and
diff --git a/Documentation/devicetree/bindings/clock/qcom,sc7280-dispcc.yaml b/Documentation/devicetree/bindings/clock/qcom,sc7280-dispcc.yaml
index cfe6594a0a6b..c42b0ef61385 100644
--- a/Documentation/devicetree/bindings/clock/qcom,sc7280-dispcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,sc7280-dispcc.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Qualcomm Display Clock & Reset Controller on SC7280

 maintainers:
-  - Taniya Das <tdas@codeaurora.org>
+  - Taniya Das <quic_tdas@quicinc.com>

 description: |
   Qualcomm display clock control module provides the clocks, resets and power
diff --git a/Documentation/devicetree/bindings/clock/qcom,sc7280-lpasscc.yaml b/Documentation/devicetree/bindings/clock/qcom,sc7280-lpasscc.yaml
index 97c6bd96e0cb..f44c5c130d2d 100644
--- a/Documentation/devicetree/bindings/clock/qcom,sc7280-lpasscc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,sc7280-lpasscc.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Qualcomm LPASS Core Clock Controller on SC7280

 maintainers:
-  - Taniya Das <tdas@codeaurora.org>
+  - Taniya Das <quic_tdas@quicinc.com>

 description: |
   Qualcomm LPASS core clock control module provides the clocks and power
diff --git a/Documentation/devicetree/bindings/clock/qcom,sc7280-lpasscorecc.yaml b/Documentation/devicetree/bindings/clock/qcom,sc7280-lpasscorecc.yaml
index 447cdc447a0c..deee5423d66e 100644
--- a/Documentation/devicetree/bindings/clock/qcom,sc7280-lpasscorecc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,sc7280-lpasscorecc.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Qualcomm LPASS Core & Audio Clock Controller on SC7280

 maintainers:
-  - Taniya Das <tdas@codeaurora.org>
+  - Taniya Das <quic_tdas@quicinc.com>

 description: |
   Qualcomm LPASS core and audio clock control module provides the clocks and
diff --git a/Documentation/devicetree/bindings/clock/qcom,sdm845-dispcc.yaml b/Documentation/devicetree/bindings/clock/qcom,sdm845-dispcc.yaml
index 76b53ce64e40..719844d7ea11 100644
--- a/Documentation/devicetree/bindings/clock/qcom,sdm845-dispcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,sdm845-dispcc.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Qualcomm Display Clock & Reset Controller on SDM845

 maintainers:
-  - Taniya Das <tdas@codeaurora.org>
+  - Taniya Das <quic_tdas@quicinc.com>

 description: |
   Qualcomm display clock control module provides the clocks, resets and power
diff --git a/Documentation/devicetree/bindings/clock/qcom,videocc.yaml b/Documentation/devicetree/bindings/clock/qcom,videocc.yaml
index 2b07146161b4..2dfea9558733 100644
--- a/Documentation/devicetree/bindings/clock/qcom,videocc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,videocc.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Qualcomm Video Clock & Reset Controller

 maintainers:
-  - Taniya Das <tdas@codeaurora.org>
+  - Taniya Das <quic_tdas@quicinc.com>

 description: |
   Qualcomm video clock control module provides the clocks, resets and power
--
2.17.1

