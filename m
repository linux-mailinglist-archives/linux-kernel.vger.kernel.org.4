Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28AA57097B8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 14:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231784AbjESMzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 08:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231450AbjESMzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 08:55:52 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28DAE1BD;
        Fri, 19 May 2023 05:55:36 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34JCVDnW027054;
        Fri, 19 May 2023 12:55:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=53X+AvKJl4nFfAK5pep/NFr54hwsl+Lj3Nx6BYrf8xk=;
 b=lBBlgJZXEsj+YBQooNF7FPT4vZvSoUyXAH/H1zz6i7j5jrkuwu/IONSUDE6d7vsqaoJm
 o9m05r1ak8C/xKz1nKxztSY3kgMG8JEHUcKkYJf5e9fGCYbDBE/4JwHzh2j/3QUHV/vE
 X0gaVG4fQ8VtcsyT2GDCMHkGmNLEdu1qqRVTWn08bhK8MYZkeiPsytMa0hi+tgbgKCvx
 FbD+EMoUKuof2E+qsjct8SCaxUB99aHIyJWw4tz1E7ccQaR7GTCYq/p3PrBfjYnRWyZF
 g0IWT1g3Zp1r5ogtNMO8uK3udOUv4iiSeUlLooFDyG74fDux4tZ8Cv0r5pZmDnKhw7JD Bw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qp95v01e1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 May 2023 12:55:17 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34JCtGUv012702
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 May 2023 12:55:17 GMT
Received: from win-platform-upstream01.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 19 May 2023 05:54:54 -0700
From:   Sricharan Ramabadhran <quic_srichara@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <ulf.hansson@linaro.org>,
        <linus.walleij@linaro.org>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <p.zabel@pengutronix.de>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <robimarko@gmail.com>,
        <andy.shevchenko@gmail.com>, <quic_srichara@quicinc.com>
Subject: [PATCH V7 5/8] dt-bindings: qcom: Add ipq5018 bindings
Date:   Fri, 19 May 2023 18:24:06 +0530
Message-ID: <20230519125409.497439-6-quic_srichara@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230519125409.497439-1-quic_srichara@quicinc.com>
References: <20230519125409.497439-1-quic_srichara@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: W0wT6oh1jn95Icd0tpeTR4H4hNH6T0nP
X-Proofpoint-GUID: W0wT6oh1jn95Icd0tpeTR4H4hNH6T0nP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-19_08,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 phishscore=0 bulkscore=0 adultscore=0
 mlxscore=0 mlxlogscore=999 malwarescore=0 clxscore=1015 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305190109
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the new ipq5018 SOC/board device tree bindings.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
---
 [v7] No change

 Documentation/devicetree/bindings/arm/qcom.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index d9dd25695c3d..9abeea553fc3 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -30,6 +30,7 @@ description: |
         apq8084
         apq8096
         ipq4018
+        ipq5018
         ipq5332
         ipq6018
         ipq8074
@@ -96,6 +97,7 @@ description: |
         hk10-c2
         idp
         liquid
+        rdp432-c2
         mtp
         qrd
         rb2
@@ -330,6 +332,11 @@ properties:
               - qcom,ipq4019-dk04.1-c1
           - const: qcom,ipq4019
 
+      - items:
+          - enum:
+              - qcom,ipq5018-rdp432-c2
+          - const: qcom,ipq5018
+
       - items:
           - enum:
               - qcom,ipq5332-ap-mi01.2
-- 
2.34.1

