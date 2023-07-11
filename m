Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12AAB74E679
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 07:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbjGKFrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 01:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjGKFrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 01:47:15 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F4FC1A2;
        Mon, 10 Jul 2023 22:47:14 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36B5gLeW021398;
        Tue, 11 Jul 2023 05:47:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=CYVsPJ2IUzXSmJMscyS1C+4DqCqc/mp3TJWoWR2EU/8=;
 b=Q/u/narhrUZrvbSRtrqYS9BIS3+5V3EyVX9INFguKxM9YmY2Q7qf2xCjsZDfP40rYNyi
 VYqfJpN4t87pX60+uvzdEV4ZJZcJTgigXz8EcpXDzBVHm3yiSSs10ZHvWk6walTiceFJ
 mgOm2jjWEjBZbaoWsF+15yyK1DWxgahm+R9DXbPUyDn1XDhjhjTg5uoRFeDa3xJjIrOE
 edwggHcDCgJ86n4b4PSw8A48AnlhuQ81sv5Zv/Cks/pQi6mzpVS+KY1oqbpoW3FckM5z
 o6+0DmAsHnhbZ8qQWSE34CnxASz2QcAB5K79rK33GcjVJlxWCBQC2tU9S2oTIMg8Frzd uw== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rs15nr083-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Jul 2023 05:47:09 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 36B5l5SY008332;
        Tue, 11 Jul 2023 05:47:05 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3rq0vm2hgs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 11 Jul 2023 05:47:05 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36B5gw9L004990;
        Tue, 11 Jul 2023 05:47:05 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-rohiagar-hyd.qualcomm.com [10.213.106.138])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 36B5l4lg008318;
        Tue, 11 Jul 2023 05:47:05 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
        id 596535040; Tue, 11 Jul 2023 11:17:04 +0530 (+0530)
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH v2 1/2] dt-bindings: regulator: Add PMX75 compatible
Date:   Tue, 11 Jul 2023 11:16:54 +0530
Message-Id: <1689054415-11281-2-git-send-email-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1689054415-11281-1-git-send-email-quic_rohiagar@quicinc.com>
References: <1689054415-11281-1-git-send-email-quic_rohiagar@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: mhoX75uMA9C10XoeIGFNz16bIi_Ph4im
X-Proofpoint-ORIG-GUID: mhoX75uMA9C10XoeIGFNz16bIi_Ph4im
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-11_02,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 phishscore=0 mlxlogscore=920 bulkscore=0
 impostorscore=0 mlxscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307110050
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add PMX75 compatibles for PMIC found in SDX75 platform.
While at it, update the entry for SDX65 as well.

Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
---
 .../bindings/regulator/qcom,rpmh-regulator.yaml    | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml b/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml
index b949850..72b533c 100644
--- a/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml
@@ -53,6 +53,7 @@ description: |
       For PMR735A, smps1 - smps3, ldo1 - ldo7
       For PMX55, smps1 - smps7, ldo1 - ldo16
       For PMX65, smps1 - smps8, ldo1 - ldo21
+      For PMX75, smps1 - smps10, ldo1 - ldo21
 
 properties:
   compatible:
@@ -84,6 +85,7 @@ properties:
       - qcom,pmr735a-rpmh-regulators
       - qcom,pmx55-rpmh-regulators
       - qcom,pmx65-rpmh-regulators
+      - qcom,pmx75-rpmh-regulators
 
   qcom,pmic-id:
     description: |
@@ -424,10 +426,28 @@ allOf:
         vdd-l11-l13-supply: true
       patternProperties:
         "^vdd-l[1347]-supply$": true
-        "^vdd-l1[0245789]-supply$": true
+        "^vdd-l1[024579]-supply$": true
         "^vdd-l2[01]-supply$": true
         "^vdd-s[1-8]-supply$": true
 
+  - if:
+      properties:
+        compatible:
+          enum:
+            - qcom,pmx75-rpmh-regulators
+    then:
+      properties:
+        vdd-l2-l18-supply: true
+        vdd-l4-l16-supply: true
+        vdd-l5-l6-supply: true
+        vdd-l8-l9-supply: true
+        vdd-l11-l13-supply: true
+        vdd-l20-l21-supply: true
+      patternProperties:
+        "^vdd-l[137]-supply$": true
+        "^vdd-l1[024579]-supply$": true
+        "^vdd-s([1-9]|10)-supply$": true
+
 unevaluatedProperties: false
 
 examples:
-- 
2.7.4

