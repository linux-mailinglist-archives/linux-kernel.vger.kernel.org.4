Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 081BE70311A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 17:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242221AbjEOPJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 11:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242105AbjEOPJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 11:09:28 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88E29D9;
        Mon, 15 May 2023 08:09:24 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34FEgXlQ028607;
        Mon, 15 May 2023 15:08:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=UFfvbucbmkWXKyT0DDx2Sbol/717J1HY00ehIICcShU=;
 b=TtISEzwbN9H0448kMwnRpBbXkZygIAIqOOvlcfnLOlHUQUjQeTfHRdoiVB3EeoiOUaUD
 yTEG9sPVRbY5UwVC0vjGoEjLY1UKejHV6OCAQqkUHpMVk12vkq3mIfpONn8R5y9/9Fep
 qrmDRU36nFWU7Wt7WANGnSdcXu8CKZ6sci3qucyui+N1MkbrsumDD+sdnAmg+B6tS6+x
 g/w2bRZDiKxyJ/0JErL69Xr0x4Ep4R7px8qWLodw7byrGypRIj8QHXhLdeG+LyRz3fRU
 Ha1fHdPl7RvUB28fiIcCA3Ddh/Rl8Ybn/uqWWnPM2/GfiNEdnT5d11GXTyYHzEEq0pQd LQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qj257v8n4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 May 2023 15:08:18 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34FF8HBn010741
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 May 2023 15:08:17 GMT
Received: from anusha-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Mon, 15 May 2023 08:08:09 -0700
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
Subject: [PATCH V2 1/4] dt-bindings: clock: Add crypto clock and reset definitions
Date:   Mon, 15 May 2023 20:37:19 +0530
Message-ID: <20230515150722.12196-2-quic_anusha@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230515150722.12196-1-quic_anusha@quicinc.com>
References: <20230515150722.12196-1-quic_anusha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: q6v4s_C7DkTyzdYawNwMIkSyOMsRNRdU
X-Proofpoint-GUID: q6v4s_C7DkTyzdYawNwMIkSyOMsRNRdU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-15_11,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 impostorscore=0 mlxlogscore=997 lowpriorityscore=0 clxscore=1015
 spamscore=0 mlxscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305150124
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add crypto clock and reset ID definitions for ipq9574.

Signed-off-by: Anusha Rao <quic_anusha@quicinc.com>
---
 Changes in V2:
	- Separated out the clock/reset binding changes to a new patch.

 include/dt-bindings/clock/qcom,ipq9574-gcc.h | 4 ++++
 include/dt-bindings/reset/qcom,ipq9574-gcc.h | 1 +
 2 files changed, 5 insertions(+)

diff --git a/include/dt-bindings/clock/qcom,ipq9574-gcc.h b/include/dt-bindings/clock/qcom,ipq9574-gcc.h
index 5a2961bfe893..86790efa10f0 100644
--- a/include/dt-bindings/clock/qcom,ipq9574-gcc.h
+++ b/include/dt-bindings/clock/qcom,ipq9574-gcc.h
@@ -210,4 +210,8 @@
 #define GCC_SNOC_PCIE1_1LANE_S_CLK			201
 #define GCC_SNOC_PCIE2_2LANE_S_CLK			202
 #define GCC_SNOC_PCIE3_2LANE_S_CLK			203
+#define CRYPTO_CLK_SRC					204
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

