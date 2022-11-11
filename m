Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16A6F625180
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 04:25:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232771AbiKKDZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 22:25:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiKKDZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 22:25:36 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7159E5986C;
        Thu, 10 Nov 2022 19:25:35 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AB393i0016222;
        Fri, 11 Nov 2022 03:25:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=MexMrkaWeR7RAiApT1mAXj1kV44/EYUumrwGtULmquA=;
 b=LSvAXdCNBugu/IM2TS9rHAlglBvyejjD0t+6Fs3UIFC+mG5bQm1P42BYF8ugiuakZKbz
 hqdT1nA399GQNyUqujwMNcQ3DGkEutniINr1sNBvYyHGzqyUn4SjtjuyXJ+Zn+C4q040
 061YKX/HQ75k3/X3ob72qRlg68wsO3u6WAf0qUB+9nd5DnvfQWZI+6sDMqMtFOVkHeHm
 G35Vo5U3/m8VIBf/xqvszf+YH8aX5z3Mc4qWVx1mSSG+zDuXapm+p4/fi4MbVU/9G+0G
 R/oHUuBcQ6+gIUlG85wJ2dFHZxaWkiphNonRYDKj4JKpfPD7jT8P8zmp3Owk2wFlAWfF eg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ksah3rfq5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Nov 2022 03:25:24 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2AB3PNK2013434
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Nov 2022 03:25:23 GMT
Received: from th-lint-050.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Thu, 10 Nov 2022 19:25:23 -0800
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sibi Sankar <quic_sibis@quicinc.com>
CC:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Mike Tipton <quic_mdtipton@quicinc.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 05/10] dt-bindings: interconnect: Add sm8350, sc8280xp and generic OSM L3 compatibles
Date:   Thu, 10 Nov 2022 19:25:10 -0800
Message-ID: <20221111032515.3460-6-quic_bjorande@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221111032515.3460-1-quic_bjorande@quicinc.com>
References: <20221111032515.3460-1-quic_bjorande@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: jUVzIdoWGF6Bo4jXCnRodUhrgAxgm6TE
X-Proofpoint-ORIG-GUID: jUVzIdoWGF6Bo4jXCnRodUhrgAxgm6TE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-10_14,2022-11-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 suspectscore=0 impostorscore=0 priorityscore=1501 malwarescore=0
 adultscore=0 clxscore=1015 mlxscore=0 spamscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211110021
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add EPSS L3 compatibles for sm8350 and sc8280xp, but while at it also
introduce generic compatible for both qcom,osm-l3 and qcom,epss-l3.

Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
Tested-by: Steev Klimaszewski <steev@kali.org>
---

Changes since v1:
- Fixed oneOf to be valid schema
- Fixed example to follow schema

 .../bindings/interconnect/qcom,osm-l3.yaml    | 24 ++++++++++++-------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml b/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
index bf538c0c5a81..aadae4424ba9 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
@@ -16,13 +16,21 @@ description:
 
 properties:
   compatible:
-    enum:
-      - qcom,sc7180-osm-l3
-      - qcom,sc7280-epss-l3
-      - qcom,sc8180x-osm-l3
-      - qcom,sdm845-osm-l3
-      - qcom,sm8150-osm-l3
-      - qcom,sm8250-epss-l3
+    oneOf:
+      - items:
+          - enum:
+              - qcom,sc7180-osm-l3
+              - qcom,sc8180x-osm-l3
+              - qcom,sdm845-osm-l3
+              - qcom,sm8150-osm-l3
+          - const: qcom,osm-l3
+      - items:
+          - enum:
+              - qcom,sc7280-epss-l3
+              - qcom,sc8280xp-epss-l3
+              - qcom,sm8250-epss-l3
+              - qcom,sm8350-epss-l3
+          - const: qcom,epss-l3
 
   reg:
     maxItems: 1
@@ -56,7 +64,7 @@ examples:
     #define RPMH_CXO_CLK        0
 
     osm_l3: interconnect@17d41000 {
-      compatible = "qcom,sdm845-osm-l3";
+      compatible = "qcom,sdm845-osm-l3", "qcom,osm-l3";
       reg = <0x17d41000 0x1400>;
 
       clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GPLL0>;
-- 
2.17.1

