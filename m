Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41B317083AE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 16:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231689AbjEROMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 10:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231365AbjEROM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 10:12:27 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97A1710EF;
        Thu, 18 May 2023 07:12:19 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34IBlhPe030578;
        Thu, 18 May 2023 14:12:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=Ut8u9ZoCNMHxI8qdNpewT+tUFHiAxopR43zWy6qRIk0=;
 b=O3C5GMD9wlGyhmvmDF+AJ22uFQvrKZB+67hocPXqWGiDVD4XOtxEjH6y6jw6Bxu3NDP4
 wpXiFDVS7x2d8aQHVXNs596HzIbftUrgcuNXk5lF+J9hmxaLS10lA24rUCR8rLTDl6Sb
 aP2XZQOEfg0J8y0lAm5g+nRYDwZZiyQG1QCTVQv/kCGmV4HUeb/eUvmScN3ZoYvQE4Ku
 xQ5dLpV1ZKMn52D8N2ysvgX+53wSoQtJJdT8X1B3f2n7HxE0D03rnHT4bSMwQ8YWKryG
 dJsYzoJTxBxpSiZuqrGxz8A4Fq21BnrO+yLZOZ3TlYPB0wLTP3e9GzwtXc/ayo8ZXtAC pg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qn73uspk0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 May 2023 14:12:10 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34IEC9jF025676
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 May 2023 14:12:09 GMT
Received: from anusha-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 18 May 2023 07:12:02 -0700
From:   Anusha Rao <quic_anusha@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <thara.gopinath@gmail.com>,
        <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <p.zabel@pengutronix.de>,
        <bhupesh.sharma@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-crypto@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_gokulsri@quicinc.com>,
        <quic_sjaganat@quicinc.com>, <quic_kathirav@quicinc.com>,
        <quic_arajkuma@quicinc.com>, <quic_poovendh@quicinc.com>
Subject: [PATCH V3 1/4] dt-bindings: clock: Add crypto clock and reset definitions
Date:   Thu, 18 May 2023 19:41:02 +0530
Message-ID: <20230518141105.24741-2-quic_anusha@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230518141105.24741-1-quic_anusha@quicinc.com>
References: <20230518141105.24741-1-quic_anusha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: T0bi_-K8qwj9nZl2Gulgo6aJ7rorvsJ_
X-Proofpoint-GUID: T0bi_-K8qwj9nZl2Gulgo6aJ7rorvsJ_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-18_11,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 mlxlogscore=999 malwarescore=0
 impostorscore=0 bulkscore=0 mlxscore=0 clxscore=1015 adultscore=0
 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305180113
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add crypto clock and reset ID definitions for ipq9574.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Anusha Rao <quic_anusha@quicinc.com>
---
 Changes in V3:
	- Added GCC prefix to CRYPTO_CLK_SRC.
	- Picked up Acked-by tag.

 include/dt-bindings/clock/qcom,ipq9574-gcc.h | 4 ++++
 include/dt-bindings/reset/qcom,ipq9574-gcc.h | 1 +
 2 files changed, 5 insertions(+)

diff --git a/include/dt-bindings/clock/qcom,ipq9574-gcc.h b/include/dt-bindings/clock/qcom,ipq9574-gcc.h
index 5a2961bfe893..b32a7aa65349 100644
--- a/include/dt-bindings/clock/qcom,ipq9574-gcc.h
+++ b/include/dt-bindings/clock/qcom,ipq9574-gcc.h
@@ -210,4 +210,8 @@
 #define GCC_SNOC_PCIE1_1LANE_S_CLK			201
 #define GCC_SNOC_PCIE2_2LANE_S_CLK			202
 #define GCC_SNOC_PCIE3_2LANE_S_CLK			203
+#define GCC_CRYPTO_CLK_SRC				204
+#define GCC_CRYPTO_CLK					205
+#define GCC_CRYPTO_AXI_CLK				206
+#define GCC_CRYPTO_AHB_CLK				207
 #endif
diff --git a/include/dt-bindings/reset/qcom,ipq9574-gcc.h b/include/dt-bindings/reset/qcom,ipq9574-gcc.h
index d01dc6a24cf1..c709d103673d 100644
--- a/include/dt-bindings/reset/qcom,ipq9574-gcc.h
+++ b/include/dt-bindings/reset/qcom,ipq9574-gcc.h
@@ -160,5 +160,6 @@
 #define GCC_WCSS_Q6_BCR						151
 #define GCC_WCSS_Q6_TBU_BCR					152
 #define GCC_TCSR_BCR						153
+#define GCC_CRYPTO_BCR						154
 
 #endif
-- 
2.17.1

