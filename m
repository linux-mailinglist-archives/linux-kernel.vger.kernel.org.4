Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F333712A56
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 18:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244258AbjEZQM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 12:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243699AbjEZQMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 12:12:19 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A1779C;
        Fri, 26 May 2023 09:12:17 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34QBnhxJ004221;
        Fri, 26 May 2023 16:12:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=ViN+TpIVYQck34lVIxwucyPK83MbsN1vkG8X8Y7ni8M=;
 b=K2C5rAi+oWIKI/GeYwIP4AM+aG1Eu2oMmh3wOv7mhpIQUXLqxf2ZX2PVGZ0PK5KMOd57
 Hq8oksJxlsCLoDzFAF6+xCuTlJ8PzMkXU60f3qxDi9RRmRFqU/DvIWCeTd2Jy0fPoHp3
 0xSEbFKeUS6NFjHeV/J3ZIwDuQQTVZ/LSy8QqpI3jJPZG5oOgFpYQHKFJdxy0dN2mMqt
 EyFRj/ogz8eiUZLD07XTpOrjXkXEkjCjwaJndAvqwJCz+KKIx+lZy8OkQFpI7shMycJw
 ajIdniTcqG0IX+NFzecIMo44ykws5+xSoF6Ir74NG39Fa0sNYlBuNSoMEr03DaRHystz nw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qtkxwhnpm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 May 2023 16:12:08 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34QGC1CE000446
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 May 2023 16:12:01 GMT
Received: from anusha-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 26 May 2023 09:11:54 -0700
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
Subject: [PATCH V4 1/4] dt-bindings: clock: Add crypto clock and reset definitions
Date:   Fri, 26 May 2023 21:41:26 +0530
Message-ID: <20230526161129.1454-2-quic_anusha@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230526161129.1454-1-quic_anusha@quicinc.com>
References: <20230526161129.1454-1-quic_anusha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: djz9uN0lQhSTZ8yVJ5aHyRMtCzxzrMYr
X-Proofpoint-ORIG-GUID: djz9uN0lQhSTZ8yVJ5aHyRMtCzxzrMYr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-26_06,2023-05-25_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=0 phishscore=0 mlxscore=0 malwarescore=0 bulkscore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 clxscore=1015
 spamscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305260137
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add crypto clock and reset ID definitions for ipq9574.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
Signed-off-by: Anusha Rao <quic_anusha@quicinc.com>
---
 Changes in V4:
	- Picked up Reviewed-by tag.

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

