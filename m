Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 970C56658D5
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 11:19:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235651AbjAKKTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 05:19:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232154AbjAKKSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 05:18:00 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0AB31038;
        Wed, 11 Jan 2023 02:17:59 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30B51xQk017194;
        Wed, 11 Jan 2023 10:17:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=+YgbCYAPSVK90SB97LphXVYIY5ZBmjOJkMcTj+4RzHo=;
 b=J2TOtTd0umFveEHJYpfrbdwvXDgMt/9FNUEuN8VTi4PrMWzkpkFZ9x4/bKIJ6tb/94xZ
 3mp3oK/9M4l72zDuwlMhhEhJniPTS8wM8XCdVYFBF4PtISpxLtJMzjqeo0HlLq6dlY2P
 Ypo/UuzBvteKSUWdsE4eeRo68jAfs170XlYPq3jOONAM0jCi6R+sYiAlTIfTSGu6Vyra
 TnqXm/w4y2Mv0aM5ZCG/ltVvYuM7uEoOwzdDAhuG2SHs9RnfK8iN3YNSMnXh79J0OQB3
 oWnspqX70vW7Bw798TGWH0JZH16KIZo0URM/kDsLGEIBMPswtt1/AvPQGS3YQ0Om1CRl DA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n1k6a0xkn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Jan 2023 10:17:53 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30BAHqJp020598
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Jan 2023 10:17:52 GMT
Received: from blr-ubuntu-87.ap.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 11 Jan 2023 02:17:48 -0800
From:   Sibi Sankar <quic_sibis@quicinc.com>
To:     <andersson@kernel.org>, <srinivas.kandagatla@linaro.org>
CC:     <agross@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>,
        <konrad.dybcio@somainline.org>, <robimarko@gmail.com>,
        <quic_gurus@quicinc.com>, Sibi Sankar <quic_sibis@quicinc.com>
Subject: [PATCH V8 1/2] dt-bindings: firmware: qcom,scm: Add optional interrupt
Date:   Wed, 11 Jan 2023 15:47:17 +0530
Message-ID: <20230111101718.9225-2-quic_sibis@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230111101718.9225-1-quic_sibis@quicinc.com>
References: <20230111101718.9225-1-quic_sibis@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: q8Io6auYhCx4p0vFzIELQCL1GS0rhq-5
X-Proofpoint-GUID: q8Io6auYhCx4p0vFzIELQCL1GS0rhq-5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-11_04,2023-01-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 clxscore=1015
 malwarescore=0 mlxscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301110078
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guru Das Srinagesh <quic_gurus@quicinc.com>

Add an interrupt specification to the bindings to support the wait-queue
feature on SM8450 SoCs.

Signed-off-by: Guru Das Srinagesh <quic_gurus@quicinc.com>
Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---

The interrupt property for scm firmware from a binding perspective is
completely optional i.e. not all tz fw running in the wild on sm8450
devices support this feature. The bootloader does the interrupt property
addition on sm8450 devices with wait-queue support.

v7
- Pick up R-b.

v6:
- Fix subject of bindings [Krzysztof]
- Update commit message to include the SoC supporting the feature [Krzysztof]
- Make the interrupt property valid on SM8450 SoC [Krzysztof]
- Rebased on Krzysztof's narrow clocks and interconnect series.
- Drop R-b

v5:
- Pick up R-b

v4:
- Qualify bindings [Krzysztoff]

 .../devicetree/bindings/firmware/qcom,scm.yaml | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
index 8e6e9ebb343d..01c861f36983 100644
--- a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
+++ b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
@@ -73,6 +73,12 @@ properties:
   '#reset-cells':
     const: 1
 
+  interrupts:
+    description:
+      The wait-queue interrupt that firmware raises as part of handshake
+      protocol to handle sleeping SCM calls.
+    maxItems: 1
+
   qcom,dload-mode:
     $ref: /schemas/types.yaml#/definitions/phandle-array
     items:
@@ -162,6 +168,18 @@ allOf:
       properties:
         interconnects: false
 
+  # Interrupts
+  - if:
+      not:
+        properties:
+          compatible:
+            contains:
+              enum:
+                - qcom,scm-sm8450
+    then:
+      properties:
+        interrupts: false
+
 required:
   - compatible
 
-- 
2.17.1

