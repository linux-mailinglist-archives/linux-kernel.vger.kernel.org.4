Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA79732F42
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 12:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345591AbjFPK5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 06:57:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345385AbjFPK5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 06:57:36 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4B135583;
        Fri, 16 Jun 2023 03:50:25 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35G9l7bi011896;
        Fri, 16 Jun 2023 10:50:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=25RZna5ZNyxfew4SK+nqRn7dDf3Lqj2R+RQunJiq25k=;
 b=CiR3eWRppd1uAvrYFjHUdI+s2tsjJLM5eai0NlWgXLVa58OEYUBP1tpU8a8pwpU4/+c9
 yHJiXCR1si1ND2vD6CVWgXJ+C3B+WCAduL0aRBi4BWYtko574u6WLnSm41nh2KnMHEbb
 aLmElNhqn03GGP1chkWua2yl2to6ILF4rxVQ3z3lXhBKyKycOuA6vcrw8QX5SB+zDfmH
 h9xLthHX8jh5F1kNMbEHhHbrtGgZlTWEBF8xQI6slxcrgJ8oxao7xWalRhZq9K0m9qRF
 iFaXGVGYhh7xS1nD3cy6V0QHOT3qpjciTz8JlXkbHHuBH2l2F3g/GVIUib1yvrg3Dv7L nw== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r8n09g5qw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Jun 2023 10:50:22 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35GAoLPI029367
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Jun 2023 10:50:21 GMT
Received: from hu-imrashai-hyd.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 16 Jun 2023 03:50:16 -0700
From:   Imran Shaik <quic_imrashai@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     Melody Olvera <quic_molvera@quicinc.com>,
        Taniya Das <quic_tdas@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jagadeesh Kona <quic_jkona@quicinc.com>,
        Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
        Ajit Pandey <quic_ajipan@quicinc.com>
Subject: [PATCH 1/2] dt-bindings: clock: Update GCC clocks for QDU1000 and QRU1000 SoCs
Date:   Fri, 16 Jun 2023 16:19:40 +0530
Message-ID: <20230616104941.921555-2-quic_imrashai@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230616104941.921555-1-quic_imrashai@quicinc.com>
References: <20230616104941.921555-1-quic_imrashai@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: sq9-U4597ZEAgl5wV9WvKQ91lPewt3Ti
X-Proofpoint-ORIG-GUID: sq9-U4597ZEAgl5wV9WvKQ91lPewt3Ti
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-16_07,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 spamscore=0 priorityscore=1501 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306160097
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the qcom GCC clock bindings and add v2 compatible string for QDU1000
and QRU1000 SoCs.

Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
Signed-off-by: Imran Shaik <quic_imrashai@quicinc.com>
---
 .../devicetree/bindings/clock/qcom,qdu1000-gcc.yaml         | 6 +++++-
 include/dt-bindings/clock/qcom,qdu1000-gcc.h                | 4 +++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/qcom,qdu1000-gcc.yaml b/Documentation/devicetree/bindings/clock/qcom,qdu1000-gcc.yaml
index 767a9d03aa32..030953d258c1 100644
--- a/Documentation/devicetree/bindings/clock/qcom,qdu1000-gcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,qdu1000-gcc.yaml
@@ -8,6 +8,8 @@ title: Qualcomm Global Clock & Reset Controller for QDU1000 and QRU1000
 
 maintainers:
   - Melody Olvera <quic_molvera@quicinc.com>
+  - Taniya Das <quic_tdas@quicinc.com>
+  - Imran Shaik <quic_imrashai@quicinc.com>
 
 description: |
   Qualcomm global clock control module which supports the clocks, resets and
@@ -17,7 +19,9 @@ description: |
 
 properties:
   compatible:
-    const: qcom,qdu1000-gcc
+    enum:
+      - qcom,qdu1000-gcc
+      - qcom,qdu1000-gcc-v2
 
   clocks:
     items:
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

