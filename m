Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 474A5668ED3
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 08:06:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241098AbjAMHGG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 02:06:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240475AbjAMHF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 02:05:29 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2D226EC86;
        Thu, 12 Jan 2023 22:54:12 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30D5daJ7030531;
        Fri, 13 Jan 2023 06:54:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=+YgbCYAPSVK90SB97LphXVYIY5ZBmjOJkMcTj+4RzHo=;
 b=giyiksnYA3ZKaVf2eOnxmC/tRjN4KINl6SbiCS0VO7/PObMLIvxL3TN8K+rFxWxOMXgE
 OF1GZkTWO5VovHZh23pKh949kR/2t1YnORvdBzdnt99VczyQnstkKJwui2A4+0AI5Epi
 Bwf/kDcBVKbg7X0ubc16PHtiXtSOdS9w1sktuAoRxskif999oS5pn4XhZ9a6t2ezwBe+
 A+amEv7i/af3r/NlfOP0DNAMwkxcI5Xj1SqFFnTX/asXflVxXJP13BklMQd23Rd34xKJ
 YUYxj6vrvpEHq7NZgP2523FJwvLPx4UfajA09D0dSMAZV5WOPiTpOXgKAqCyCY4cipIr Bw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n1ky4nyjk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Jan 2023 06:54:07 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30D6s6uG004838
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Jan 2023 06:54:06 GMT
Received: from blr-ubuntu-87.ap.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Thu, 12 Jan 2023 22:54:02 -0800
From:   Sibi Sankar <quic_sibis@quicinc.com>
To:     <andersson@kernel.org>, <srinivas.kandagatla@linaro.org>
CC:     <agross@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>,
        <konrad.dybcio@somainline.org>, <robimarko@gmail.com>,
        <quic_gurus@quicinc.com>, Sibi Sankar <quic_sibis@quicinc.com>
Subject: [PATCH V9 1/2] dt-bindings: firmware: qcom,scm: Add optional interrupt
Date:   Fri, 13 Jan 2023 12:23:01 +0530
Message-ID: <20230113065303.17727-2-quic_sibis@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230113065303.17727-1-quic_sibis@quicinc.com>
References: <20230113065303.17727-1-quic_sibis@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: JQnIEjAmKCbTR7CZssSfD0DsJr2SbZPX
X-Proofpoint-GUID: JQnIEjAmKCbTR7CZssSfD0DsJr2SbZPX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-13_02,2023-01-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 bulkscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 mlxscore=0 mlxlogscore=999 adultscore=0 phishscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301130047
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

