Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C58085B400F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 21:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbiIITpn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 15:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231995AbiIITpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 15:45:16 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D53C036842;
        Fri,  9 Sep 2022 12:42:06 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 289JZP56011876;
        Fri, 9 Sep 2022 19:41:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=pZZkm6nFnBhWHVX4NFaTFlgGc9eWj348TIm/31RpPsU=;
 b=Q+NvGl2aSoUo49tfJPFp8pe/sEecNOiSLcHpFXXCzhERS2unlVT+A5+Id5CTeKsw3S7U
 maOegQL2idp+PfnPgEqU0ob7JaG3GnijmR9DavKKvcYYHoigY/ytT7oB5pkrD0l3sqmP
 bP8K8VPHXwHFmexhQQC5RN+Z7xiMZADtqFOEfbpPVbjnOsKijORDzwCjZWAe8fdUFz2y
 pyJvKLSrztiiUH3OHnqpGiy4YdNqYVjW55njKSH3LblgcXrNpJwYMFpQYe0wAXoDNcCL
 R32ZUSea+VqHNV2iUkHRTlXdrdDrUNcDejXFOJ40LlaFgYVG76ZBWMDIYwRpDhKhcRNy bw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jg33ka0ej-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Sep 2022 19:41:03 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 289Jf2Tk019173
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 9 Sep 2022 19:41:03 GMT
Received: from hu-amelende-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Fri, 9 Sep 2022 12:41:02 -0700
From:   Anjelique Melendez <quic_amelende@quicinc.com>
To:     <corbet@lwn.net>, <sre@kernel.org>, <robh+dt@kernel.org>,
        <agross@kernel.org>, <andersson@kernel.org>
CC:     <krzysztof.kozlowski+dt@linaro.org>, <vkoul@kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        David Collins <quic_collinsd@quicinc.com>,
        Anjelique Melendez <quic_amelende@quicinc.com>
Subject: [PATCH v5 1/2] dt-bindings: power: reset: qcom-pon: Add new compatible "qcom,pmk8350-pon"
Date:   Fri, 9 Sep 2022 12:40:37 -0700
Message-ID: <20220909194038.20515-1-quic_amelende@quicinc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: i51QK-ikW3pghoWTFxbCLdWdc22WmtAG
X-Proofpoint-ORIG-GUID: i51QK-ikW3pghoWTFxbCLdWdc22WmtAG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-09_09,2022-09-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 priorityscore=1501 adultscore=0 spamscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 clxscore=1015 mlxscore=0 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209090069
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Collins <quic_collinsd@quicinc.com>

Add a new compatible string "qcom,pmk8350-pon" for GEN3 PMIC PON
peripherals and update "reg" property.
Also, Add an optional "reg-names" property to differentiate between
GEN1/GEN2 and GEN3 peripherals. GEN1/GEN2 peripherals only need one
register address to be specified (e.g. "pon") whereas GEN3 peripherals
can have two register addresses specified ("hlos", "pbs").

Signed-off-by: David Collins <quic_collinsd@quicinc.com>
Signed-off-by: Anjelique Melendez <quic_amelende@quicinc.com>
---
 bindings/power/reset/qcom,pon.yaml | 50 +++++++++++++++++++++++++++---
 1 file changed, 46 insertions(+), 4 deletions(-)

diff --git a/bindings/power/reset/qcom,pon.yaml b/bindings/power/reset/qcom,pon.yaml
index 353f155d..d7b6b875 100644
--- a/bindings/power/reset/qcom,pon.yaml
+++ b/bindings/power/reset/qcom,pon.yaml
@@ -15,18 +15,27 @@ description: |
 
   This DT node has pwrkey and resin as sub nodes.
 
-allOf:
-  - $ref: reboot-mode.yaml#
-
 properties:
   compatible:
     enum:
       - qcom,pm8916-pon
       - qcom,pms405-pon
       - qcom,pm8998-pon
+      - qcom,pmk8350-pon
 
   reg:
-    maxItems: 1
+    description: |
+      Specifies the SPMI base address for the PON (power-on) peripheral.  For
+      PMICs that have the PON peripheral (GEN3) split into PON_HLOS and PON_PBS
+      (e.g. PMK8350), this can hold addresses of both PON_HLOS and PON_PBS
+      peripherals.  In that case, the PON_PBS address needs to be specified to
+      facilitate software debouncing on some PMIC.
+    minItems: 1
+    maxItems: 2
+
+  reg-names:
+    minItems: 1
+    maxItems: 2
 
   pwrkey:
     type: object
@@ -42,6 +51,39 @@ required:
 
 unevaluatedProperties: false
 
+allOf:
+  - $ref: reboot-mode.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,pm8916-pon
+              - qcom,pms405-pon
+              - qcom,pm8998-pon
+    then:
+      properties:
+        reg:
+          maxItems: 1
+        reg-names:
+          items:
+            - const: pon
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: qcom,pmk8350-pon
+    then:
+      properties:
+        reg:
+          minItems: 1
+          maxItems: 2
+        reg-names:
+          minItems: 1
+          items:
+            - const: hlos
+            - const: pbs
+
 examples:
   - |
    #include <dt-bindings/interrupt-controller/irq.h>
-- 
2.35.1

