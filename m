Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE5F6FDBDB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 12:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236410AbjEJKo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 06:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjEJKo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 06:44:26 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0040465B9;
        Wed, 10 May 2023 03:44:25 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34AAVimi021809;
        Wed, 10 May 2023 10:44:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=0cMlH8TXEGzkEWXR8TDe70gjwVNp8b1RANmixgN5YaU=;
 b=AqAu8+FccC8vAv2xkVufyBYHrW2t1he9cO4wXLnsDE+jZcldkC+2Sqy7z3yD0+SZsq/E
 XoVV1A/7WRW/CK7AyD6T2VqPrVAtVzuDjJFOyYkmRjYjl1F+IfBbz6RoCx362YJ+opZc
 xFfCog+lOfhcDOqO9+LQ8P9Vm3tp2jMeF3Sr2Sgn04v67eTVq2/PgmhAzrfNXlUAbXue
 yL5dWkRasm7ycMLBS4UhkMKspFj1QEPanMv0nDUh7jygdgELnXw/xmx6b1teU48bafo8
 ERhIMSyGjCGuATxY2CNfZUPfMoeuN00Qk5x0/jT+qLxcHN7eQ6jnhCxrCU/bsCneF2wh rg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qg5mprfuv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 May 2023 10:44:23 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34AAiMiV000518
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 May 2023 10:44:22 GMT
Received: from devipriy-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 10 May 2023 03:44:18 -0700
From:   Devi Priya <quic_devipriy@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_sjaganat@quicinc.com>,
        <quic_kathirav@quicinc.com>, <quic_arajkuma@quicinc.com>,
        <quic_anusha@quicinc.com>, <quic_poovendh@quicinc.com>
Subject: [PATCH 1/2] dt-bindings: arm: qcom: document AL02-C2 board based on IPQ9574 family
Date:   Wed, 10 May 2023 16:13:58 +0530
Message-ID: <20230510104359.16678-2-quic_devipriy@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230510104359.16678-1-quic_devipriy@quicinc.com>
References: <20230510104359.16678-1-quic_devipriy@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: iRHS1hN-9UcFhR9MWSgll9qanBmE41Zw
X-Proofpoint-GUID: iRHS1hN-9UcFhR9MWSgll9qanBmE41Zw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-10_04,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=999 clxscore=1015
 suspectscore=0 malwarescore=0 mlxscore=0 adultscore=0 lowpriorityscore=0
 impostorscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2304280000 definitions=main-2305100085
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document AL02-C2 (Reference Design Platform 418) board based on IPQ9574
family of SoCs.

Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index d9dd25695c3d..7e6a128fe1db 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -85,6 +85,7 @@ description: |
   The 'board' element must be one of the following strings:
 
         adp
+        ap-al02-c2
         ap-al02-c7
         ap-mi01.2
         ap-mi01.6
@@ -351,6 +352,7 @@ properties:
 
       - items:
           - enum:
+              - qcom,ipq9574-ap-al02-c2
               - qcom,ipq9574-ap-al02-c7
           - const: qcom,ipq9574
 
-- 
2.17.1

