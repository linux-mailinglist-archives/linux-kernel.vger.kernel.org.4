Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45A5870F310
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 11:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjEXJhk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 05:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbjEXJhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 05:37:05 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A03A3184;
        Wed, 24 May 2023 02:37:04 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34O5gvEb032600;
        Wed, 24 May 2023 09:36:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=lTgEoLEClly75ZaPY/LxUJAjr1KveL9eAdClMXWG1iU=;
 b=KOafFjsFRgIMHx9DBNQfv28PbqKUYAHuaItWHzDBPjKzvrVzZU12jkW/GlZ8AwTuWb+f
 WOn6xC2zRQ7a5Nn5O9/en+QLEFzF8ehrtXMEvVETCYSVR2Pc3gUgqLs/HycA6Ef9aHWn
 3HEAhbCV5vIbneBQly5gYvvbR+Gu5tjhhPPmmmSoLlPVTfXa4/iSbZZZC0OZRdqjP0Xn
 r1gQ9SEo9MtK+i+oeChyzcojFpNo9f5DXrMXF+Y8hBu4anF1vVSQdsaFQ/jOgABkH5vl
 rkks6hCvKK1rxRXwDyGm8gAQrcKure2OQIcbV4j1dl2d6Ryzk1DquGt4goot7RJmSfKq PQ== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qs4df9c1b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 May 2023 09:36:29 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34O9aSUi002064
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 May 2023 09:36:28 GMT
Received: from varda-linux.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 24 May 2023 02:36:23 -0700
From:   Varadarajan Narayanan <quic_varada@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <amitk@kernel.org>,
        <thara.gopinath@gmail.com>, <rafael@kernel.org>,
        <daniel.lezcano@linaro.org>, <rui.zhang@intel.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Praveenkumar I <quic_ipkumar@quicinc.com>,
        Varadarajan Narayanan <quic_varada@quicinc.com>
Subject: [PATCH v4 1/3] dt-bindings: thermal: tsens: Add ipq9574 compatible
Date:   Wed, 24 May 2023 15:06:09 +0530
Message-ID: <cb26ad4a6550c18b1a70104c6b75c10946766944.1684920389.git.quic_varada@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1684920389.git.quic_varada@quicinc.com>
References: <cover.1684920389.git.quic_varada@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: dwiKsLY2MstIBf8KaXp76hAgLRfpbC7w
X-Proofpoint-ORIG-GUID: dwiKsLY2MstIBf8KaXp76hAgLRfpbC7w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-24_05,2023-05-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 impostorscore=0 phishscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305240081
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Praveenkumar I <quic_ipkumar@quicinc.com>

Qualcomm IPQ9574 has tsens v2.3.1 block, which is similar to IPQ8074 tsens.

Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
[v4]:
	Add description about IPQ9574 and remove unnecessary
	additions to the file
[v3]:
	Fix dt_binding_check & dtbs_check errors (Used
	Documentation/devicetree/bindings/display/allwinner,sun4i-a10-tcon.yaml
	as reference/example)

	Drop 'Acked-by: Rob Herring' as suggested in review

[v2]:
	Thanks to Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
	for the tip to make qcom,ipq8074-tsens as fallback.
---
 Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
index d1ec963..1a752e0 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
@@ -16,9 +16,14 @@ description: |
   The IP versions are named v0.1, v1 and v2 in the driver, where v0.1 captures
   everything before v1 when there was no versioning information.
 
+  Since IPQ9574 is similar to IPQ8074, mapping it to IPQ8074 without
+  introducing a new compatible.
+
 properties:
   compatible:
     oneOf:
+      - const: qcom,ipq8074-tsens
+
       - description: msm8960 TSENS based
         items:
           - enum:
@@ -64,8 +69,10 @@ properties:
           - const: qcom,tsens-v2
 
       - description: v2 of TSENS with combined interrupt
-        enum:
-          - qcom,ipq8074-tsens
+        items:
+          - enum:
+              - qcom,ipq9574-tsens
+          - const: qcom,ipq8074-tsens
 
   reg:
     items:
-- 
2.7.4

