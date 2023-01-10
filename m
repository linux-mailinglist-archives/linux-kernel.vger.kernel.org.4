Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A51E66396E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 07:39:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231128AbjAJGiw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 01:38:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231373AbjAJGik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 01:38:40 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE4B165AF;
        Mon,  9 Jan 2023 22:38:39 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30A4lbVD029334;
        Tue, 10 Jan 2023 06:38:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=+YgbCYAPSVK90SB97LphXVYIY5ZBmjOJkMcTj+4RzHo=;
 b=Tfni+lfz1csv+aUZAXO2zNISZ6/k+NZJ+4jtN8qCQJKd3drI6pH9D4pCX62JhvLiyBAh
 PFZka88+9xduxPIckJ76Rv7tOZMXHb9EGd2RvhJjZojdsZfH/d8ssCth9exyOF2RISza
 kvjm0IgXL3XG3IOsvW/9iqscKewIny8q/0O2qQbUcF3P0p7d7QlXqQ14eWroxrr+zZW3
 3v0JnxItxWkfgmhHOAxa5cY8OMBnBc6bDL/7SJ2x54gume8t5Plm4tDhfd7S8XFvhk0D
 TsLJQxSF172YXREbsgV5QYEISqYEoTwczwZOzRagiXY7J/PQj0VaCaWUmS8OqV6klgZp Ow== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3my21fvwqs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Jan 2023 06:38:32 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30A6cWeE030417
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Jan 2023 06:38:32 GMT
Received: from blr-ubuntu-87.ap.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 9 Jan 2023 22:38:28 -0800
From:   Sibi Sankar <quic_sibis@quicinc.com>
To:     <andersson@kernel.org>
CC:     <agross@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>,
        <konrad.dybcio@somainline.org>, <robimarko@gmail.com>,
        <quic_gurus@quicinc.com>, Sibi Sankar <quic_sibis@quicinc.com>
Subject: [PATCH V7 1/2] dt-bindings: firmware: qcom,scm: Add optional interrupt
Date:   Tue, 10 Jan 2023 12:07:44 +0530
Message-ID: <20230110063745.16739-2-quic_sibis@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230110063745.16739-1-quic_sibis@quicinc.com>
References: <20230110063745.16739-1-quic_sibis@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: YFTruunmLwPLcywk55p0ZPnbDva4X82T
X-Proofpoint-GUID: YFTruunmLwPLcywk55p0ZPnbDva4X82T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-10_01,2023-01-09_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 impostorscore=0 bulkscore=0 malwarescore=0 mlxscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301100042
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
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

