Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1380E723E94
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 11:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236731AbjFFJ6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 05:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232834AbjFFJ6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 05:58:16 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A69CE10E2;
        Tue,  6 Jun 2023 02:58:04 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3569Sfg8019153;
        Tue, 6 Jun 2023 09:58:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=VtXCxeL/gTEX0ZfLBqLgLsNVYLUNU94xST63rb6Sheo=;
 b=ARZwHe1ZG5Rm+cmHAFtgtQYU2j9wugS5tWF03q55I7kDRRd3Bfdv0MfY1+Yrcdk1D8NU
 V9ExX1kCzbrYKg8j7JheTax0BKj1FgumA12VL6D0HL73JkuYAC7tza+7DR4KC3fP0YLu
 yeLq0Jmwm1AnLFS/O6DwF6XWXGQ+GwGKReXjUdrl/EW9YvbKLrjIqhlFRIiYCQX2jPeV
 A3+Oij9iJ7oJWYXxvNfXkrfiCrh+KLO9dhyLqtLx9ytwl4ICgh5iG5NJWUla4VTscfaA
 5+wb79GBLZo2v97BOO0qKwitePqnOi5fSEAmsLmfvriJ/Gzw256OQKhiC4dPo668gTaS vg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r1m929js3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Jun 2023 09:58:01 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3569w0WV030066
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 6 Jun 2023 09:58:00 GMT
Received: from harihk-linux.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Tue, 6 Jun 2023 02:57:55 -0700
From:   Hariharan K <quic_harihk@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_sjaganat@quicinc.com>,
        <quic_kathirav@quicinc.com>, <quic_arajkuma@quicinc.com>,
        <quic_anusha@quicinc.com>
Subject: [PATCH 1/2] dt-bindings: arm: qcom: document MI04.1 board based on IPQ5332 family
Date:   Tue, 6 Jun 2023 15:27:31 +0530
Message-ID: <20230606095732.12884-2-quic_harihk@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230606095732.12884-1-quic_harihk@quicinc.com>
References: <20230606095732.12884-1-quic_harihk@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: hhgwMxVM8hlPNDaErehArnf6Rffc6Pft
X-Proofpoint-ORIG-GUID: hhgwMxVM8hlPNDaErehArnf6Rffc6Pft
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-06_06,2023-06-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 malwarescore=0 adultscore=0 spamscore=0
 mlxlogscore=962 impostorscore=0 lowpriorityscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306060084
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the MI04.1 (Reference Design Platform 446) board based on IPQ5332
family of SoCs.

Signed-off-by: Hariharan K <quic_harihk@quicinc.com>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 8302d1ee280d..165a815337f7 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -93,6 +93,7 @@ description: |
         ap-mi01.2
         ap-mi01.3
         ap-mi01.6
+        ap-mi04.1
         cdp
         cp01-c1
         dragonboard
@@ -340,6 +341,7 @@ properties:
               - qcom,ipq5332-ap-mi01.2
               - qcom,ipq5332-ap-mi01.3
               - qcom,ipq5332-ap-mi01.6
+              - qcom,ipq5332-ap-mi04.1
           - const: qcom,ipq5332
 
       - items:
-- 
2.17.1

