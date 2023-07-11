Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B06C574E896
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 10:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231694AbjGKIAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 04:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbjGKIAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 04:00:33 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A65111A8;
        Tue, 11 Jul 2023 01:00:32 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36B6tlIu012370;
        Tue, 11 Jul 2023 08:00:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=OKMsuLGA6LVA++Yh8iBspZ5EHDsz+3wJuIbVQAHkViY=;
 b=ZJGHmTWkX6dTTD4a4Mtis5StPojbNjrvIaYPQuJuGihceqtZy/fDrHcNrUUHWWBz4FYu
 7wOrTyiqWAXYWHAr48z1+dzsFATGlkweRD7C66fbA7I2t01R9/NxyxJDosWqz8CCT24i
 fc489bTDX1KSJs5NWTWjIX4QDk5BIHwRvrkY+/t1IkXSzv8box0aP1pztJIuaVJ6cMYM
 tLzmVJtNNC1YkG3D8OW8pHKMAccHgpYi1Mw/OSVqlOyA9LvxPvJa1Uoa8lIzb3rYIDeW
 DObilAjFUQJmtaapATcbAaKuOnDr/0khzAYNHjY7hHe74izz57lkllCgo/OXV+Ee0twX oQ== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rs279r3rn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Jul 2023 08:00:26 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 36B80Nep006416;
        Tue, 11 Jul 2023 08:00:23 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3rq0vm2xkw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 11 Jul 2023 08:00:23 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36B80Maf006353;
        Tue, 11 Jul 2023 08:00:23 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-rohiagar-hyd.qualcomm.com [10.213.106.138])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 36B80MZQ006345;
        Tue, 11 Jul 2023 08:00:22 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
        id 26E755050; Tue, 11 Jul 2023 13:30:22 +0530 (+0530)
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH v3 2/3] regulator: dt-bindings: qcom,rpmh: Add PMX75 compatible
Date:   Tue, 11 Jul 2023 13:30:13 +0530
Message-Id: <1689062414-3654-3-git-send-email-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1689062414-3654-1-git-send-email-quic_rohiagar@quicinc.com>
References: <1689062414-3654-1-git-send-email-quic_rohiagar@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: qvQP8TVIWfVAXJeen7mowFii8v8sppah
X-Proofpoint-GUID: qvQP8TVIWfVAXJeen7mowFii8v8sppah
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-11_04,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 bulkscore=0 priorityscore=1501 adultscore=0 clxscore=1015 mlxlogscore=925
 malwarescore=0 phishscore=0 lowpriorityscore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307110070
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add PMX75 compatibles for PMIC found in SDX75 platform.

Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
---
 .../bindings/regulator/qcom,rpmh-regulator.yaml      | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml b/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml
index 12a1e0c..72b533c 100644
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
@@ -428,6 +430,24 @@ allOf:
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

