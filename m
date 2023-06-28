Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C2A7740D24
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 11:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234976AbjF1Jde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 05:33:34 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131]:44630 "EHLO
        mx0a-0031df01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233560AbjF1J3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 05:29:15 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35S5doZt026585;
        Wed, 28 Jun 2023 09:29:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=v2cZsTAvCPhScEvOZH29Fq8G1gL8Ljy6VgqGRp9lvRE=;
 b=GOssDBGS1H8kGYMeMXBmKWySFfXJuvWJYTk9qHAI25yr4zmhMcykz0qRCuZKe8NL//J4
 P1i53iZFkcHVlCYdoOyqqVIkQz2KwKk8Qx+Dl7/d21f7wRSrrwTI1U/PTZlMebCkruzA
 2GOcQzGWdCNKGgRGVL+vKTUaT6C72SZgL3wx/kiw+AOIIgiXtJcvucNKsxTaGUVnzo/n
 niv2BZPr2t8ZWwX4DHH880DtvVAS0htXfOgh48DK50sY/d6UcsJ7khoadLxtRQ1L/95q
 lS9pPxEqMDLcy937DTwXdwPecQvY5UYYVjNKtJ/8FIP1qFXbBN0+BTd/72Z7mMV7cSMd yg== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rg21ta4cw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jun 2023 09:29:11 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35S9T9Rv025869
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jun 2023 09:29:09 GMT
Received: from hu-imrashai-hyd.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 28 Jun 2023 02:29:03 -0700
From:   Imran Shaik <quic_imrashai@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     Taniya Das <quic_tdas@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        Melody Olvera <quic_molvera@quicinc.com>,
        "Dmitry Baryshkov" <dmitry.baryshkov@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jagadeesh Kona <quic_jkona@quicinc.com>,
        Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
        Ajit Pandey <quic_ajipan@quicinc.com>
Subject: [PATCH V2 1/5] dt-bindings: clock: Update GCC clocks for QDU1000 and QRU1000 SoCs
Date:   Wed, 28 Jun 2023 14:58:33 +0530
Message-ID: <20230628092837.3090801-2-quic_imrashai@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230628092837.3090801-1-quic_imrashai@quicinc.com>
References: <20230628092837.3090801-1-quic_imrashai@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: UOqTxc3qbyqWNLyDFJ1RBhlcNaCxz1dZ
X-Proofpoint-GUID: UOqTxc3qbyqWNLyDFJ1RBhlcNaCxz1dZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-28_06,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 phishscore=0
 adultscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 mlxscore=0
 bulkscore=0 malwarescore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306280083
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the qcom GCC clock bindings for QDU1000 and QRU1000 SoCs.

Co-developed-by: Taniya Das <quic_tdas@quicinc.com>
Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
Signed-off-by: Imran Shaik <quic_imrashai@quicinc.com>
---
Chanes since v1:
 - Removed the v2 variant compatible string changes
 - Updated the maintainers list

 Documentation/devicetree/bindings/clock/qcom,qdu1000-gcc.yaml | 3 ++-
 include/dt-bindings/clock/qcom,qdu1000-gcc.h                  | 4 +++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/qcom,qdu1000-gcc.yaml b/Documentation/devicetree/bindings/clock/qcom,qdu1000-gcc.yaml
index 767a9d03aa32..d712b1a87e25 100644
--- a/Documentation/devicetree/bindings/clock/qcom,qdu1000-gcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,qdu1000-gcc.yaml
@@ -7,7 +7,8 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Qualcomm Global Clock & Reset Controller for QDU1000 and QRU1000
 
 maintainers:
-  - Melody Olvera <quic_molvera@quicinc.com>
+  - Taniya Das <quic_tdas@quicinc.com>
+  - Imran Shaik <quic_imrashai@quicinc.com>
 
 description: |
   Qualcomm global clock control module which supports the clocks, resets and
diff --git a/include/dt-bindings/clock/qcom,qdu1000-gcc.h b/include/dt-bindings/clock/qcom,qdu1000-gcc.h
index ddbc6b825e80..2fd36cbfddbb 100644
--- a/include/dt-bindings/clock/qcom,qdu1000-gcc.h
+++ b/include/dt-bindings/clock/qcom,qdu1000-gcc.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
 /*
- * Copyright (c) 2021-2022, Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2023, Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #ifndef _DT_BINDINGS_CLK_QCOM_GCC_QDU1000_H
@@ -138,6 +138,8 @@
 #define GCC_AGGRE_NOC_ECPRI_GSI_CLK			128
 #define GCC_PCIE_0_PIPE_CLK_SRC				129
 #define GCC_PCIE_0_PHY_AUX_CLK_SRC			130
+#define GCC_GPLL1_OUT_EVEN				131
+#define GCC_DDRSS_ECPRI_GSI_CLK				132
 
 /* GCC resets */
 #define GCC_ECPRI_CC_BCR				0
-- 
2.25.1

