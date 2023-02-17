Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BBFF69A676
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 09:00:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbjBQIAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 03:00:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjBQIAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 03:00:41 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A224C5EC91;
        Fri, 17 Feb 2023 00:00:28 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31H63KRo014637;
        Fri, 17 Feb 2023 08:00:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=NSSXQ2SYj+fXYnSMuZz0lW6YvGxvH+AbaRaCGM7VrYU=;
 b=H4NlTODQoDQF6nmSFUB6six9dsAjUgldK3pHNdAOecEEGTi6O+TPR6ZhPBcbsP7nQ9dQ
 23iGT9xVyoRTPQgQXSN5/aotYQALB6iyO63SRaLQOAxfDfB0ExY+p63+U9ncEXBpVVEL
 wxNeLe5lg2Ui6MPnK61eIhrAN9/RX+9b65AZxr6xcPXXmX7N5E1Uwvdgh2/C6bZ1/H4V
 FMGrs72VxzihuEdDMIF259Vybbo7AeccR88x9sZAHOVfk7/w3aHM+WrKxXYuuqZ+NNQv
 vaxnB9BZzIGGXg/LLe6xV1N8uj3e19tNmsbUSF00XLqAodMOC2YaWEnV48j878YxbnWI kQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nt10u0qub-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Feb 2023 07:59:45 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31H7xYuV003216
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Feb 2023 07:59:34 GMT
Received: from kathirav-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Thu, 16 Feb 2023 23:59:26 -0800
From:   Kathiravan T <quic_kathirav@quicinc.com>
To:     <krzysztof.kozlowski@linaro.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <linus.walleij@linaro.org>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <shawnguo@kernel.org>, <arnd@arndb.de>,
        <dmitry.baryshkov@linaro.org>, <marcel.ziswiler@toradex.com>,
        <nfraprado@collabora.com>, <robimarko@gmail.com>,
        <quic_gurus@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <quic_varada@quicinc.com>, <quic_srichara@quicinc.com>,
        Kathiravan T <quic_kathirav@quicinc.com>
Subject: [PATCH V5 4/7] dt-bindings: qcom: add ipq5332 boards
Date:   Fri, 17 Feb 2023 13:28:32 +0530
Message-ID: <20230217075835.460-5-quic_kathirav@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230217075835.460-1-quic_kathirav@quicinc.com>
References: <20230217075835.460-1-quic_kathirav@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: qGA5U3kzMiKtu5_dYMqefcW7qFetPZtz
X-Proofpoint-GUID: qGA5U3kzMiKtu5_dYMqefcW7qFetPZtz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-17_03,2023-02-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 malwarescore=0 mlxscore=0 impostorscore=0
 adultscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 clxscore=1015
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302170072
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the new ipq5332 SoC/board device tree bindings

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
---
Changes in V5:
	- No changes

Changes in V4:
	- Pick up R-b tag

Changes in V3:
	- Sorted the board name

Changes in V2:
	- No changes

 Documentation/devicetree/bindings/arm/qcom.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 1bb24d46e4ee..465bb98cb91d 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -30,6 +30,7 @@ description: |
         apq8084
         apq8096
         ipq4018
+        ipq5332
         ipq6018
         ipq8074
         mdm9615
@@ -80,6 +81,7 @@ description: |
   The 'board' element must be one of the following strings:
 
         adp
+        ap-mi01.2
         cdp
         cp01-c1
         dragonboard
@@ -320,6 +322,11 @@ properties:
               - qcom,ipq4019-dk04.1-c1
           - const: qcom,ipq4019
 
+      - items:
+          - enum:
+              - qcom,ipq5332-ap-mi01.2
+          - const: qcom,ipq5332
+
       - items:
           - enum:
               - mikrotik,rb3011
-- 
2.17.1

