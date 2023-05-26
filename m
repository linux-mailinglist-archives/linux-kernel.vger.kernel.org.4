Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 228AC71298A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 17:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243993AbjEZPc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 11:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242816AbjEZPcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 11:32:25 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C08F7;
        Fri, 26 May 2023 08:32:24 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34QAeTnd006774;
        Fri, 26 May 2023 15:32:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=GfWhQ3JgRTHFEzJvI5KbLyRzEnp4YVwJ/f2LwSxztpk=;
 b=MdOIVYh7i9JV8AcKCsiy/pHY4Lv9OZw9JVW/9sJTxrzhqfDW83yFJHgFkJnF601wtG4p
 i1y+Hi+PcYqF5AeVp6Vi/GaaPFD2nHNDWZPu5MxC1L4gmI6rkBOMlp0pAHe6Z//RX7WL
 VVfKpqN1KbQno0CfoRfsDMGJvA/4hcWRB3qtNuaicHleCBvZpToHj2k/ZHFPVzJV6zw8
 gd2fp/lcYW1KxuAg1RAywUeWy8V2wBYb8nJW2YxnEEUMngxZ2t0GVwNFZjL4B5zE7fs7
 UXl5TRqP1zkkAe5awMk6rFG+efYR9IeUWHKys8jis2xZ6lsw4yCKlY1gD6BbpyADm6OH 9g== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qtp4wha26-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 May 2023 15:32:21 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34QFWFR8006913
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 May 2023 15:32:15 GMT
Received: from devipriy-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 26 May 2023 08:32:10 -0700
From:   Devi Priya <quic_devipriy@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_sjaganat@quicinc.com>,
        <quic_kathirav@quicinc.com>, <quic_arajkuma@quicinc.com>,
        <quic_anusha@quicinc.com>
Subject: [PATCH 1/2] dt-bindings: arm: qcom: document AL02-C8 board based on IPQ9574 family
Date:   Fri, 26 May 2023 21:01:51 +0530
Message-ID: <20230526153152.777-2-quic_devipriy@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230526153152.777-1-quic_devipriy@quicinc.com>
References: <20230526153152.777-1-quic_devipriy@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ZIv1F7dooca0XiCFCtXEakPpAW7mzXLb
X-Proofpoint-ORIG-GUID: ZIv1F7dooca0XiCFCtXEakPpAW7mzXLb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-26_05,2023-05-25_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 phishscore=0 adultscore=0 clxscore=1015 suspectscore=0
 malwarescore=0 bulkscore=0 impostorscore=0 mlxlogscore=989
 lowpriorityscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2304280000 definitions=main-2305260131
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document AL02-C8 (Reference Design Platform 453) board based on IPQ9574
family of SoCs.

Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index fe7ed853e598..888cb8bfd0cd 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -88,6 +88,7 @@ description: |
         ap-al02-c2
         ap-al02-c6
         ap-al02-c7
+        ap-al02-c8
         ap-al02-c9
         ap-mi01.2
         ap-mi01.6
@@ -357,6 +358,7 @@ properties:
               - qcom,ipq9574-ap-al02-c2
               - qcom,ipq9574-ap-al02-c6
               - qcom,ipq9574-ap-al02-c7
+              - qcom,ipq9574-ap-al02-c8
               - qcom,ipq9574-ap-al02-c9
           - const: qcom,ipq9574
 
-- 
2.17.1

