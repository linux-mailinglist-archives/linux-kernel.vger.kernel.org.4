Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABA8F6E0A41
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 11:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbjDMJ3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 05:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbjDMJ3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 05:29:00 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE4683C1;
        Thu, 13 Apr 2023 02:28:59 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33D8RTke002131;
        Thu, 13 Apr 2023 09:28:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=O67QoG1hp0SUoJhVSij6T4ikMWym8/XfXIXVcd4MYEA=;
 b=WdfbI49S9BaMJMcqK3UWBKtt72C3F9bM82ISzkPi9EEsbevC/fsg67JAsKH+vubwegn2
 ++c4JsZ4cXfnpApn1DLhI2w6K7diGZ4aCm/MW2pKokX7E6bbZ7iZGaznAs4Njiu1BcYI
 +jmlrAcpCIoQDweNO9mpfCJtYCOwIV9wIofeR1KiLk864nvbvBIvYJ5K78Gmft9cLBq7
 pIRHTXx3/bTjAn3SvpY3/Zrh5nhkBVgEufZ059/uv2hGUZfhy/096robB3xy3gESVF2g
 pdEVpBLKYd9X5YbEjabmCOmEfzwPWLMG0YSFyZgoQnbHKEDp//Xp8X9Dp3YmqOm98bsn gA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pwqnq31vh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Apr 2023 09:28:50 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33D9SnA4031466
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Apr 2023 09:28:49 GMT
Received: from blr-ubuntu-525.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 13 Apr 2023 02:28:44 -0700
From:   Souradeep Chowdhury <quic_schowdhu@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Souradeep Chowdhury <quic_schowdhu@quicinc.com>
Subject: [PATCH V3 1/3] dt-bindings: sram: qcom,imem: Add Boot Stat region within IMEM
Date:   Thu, 13 Apr 2023 14:58:16 +0530
Message-ID: <0e48ef5a9558c0bab5c2918af3c15ed4425b07be.1681375949.git.quic_schowdhu@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1681375949.git.quic_schowdhu@quicinc.com>
References: <cover.1681375949.git.quic_schowdhu@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: tnul9fZq8v2lYKcG03v_F2GaWCVLSHO3
X-Proofpoint-GUID: tnul9fZq8v2lYKcG03v_F2GaWCVLSHO3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-13_05,2023-04-12_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 suspectscore=0 bulkscore=0 priorityscore=1501 mlxscore=0
 phishscore=0 clxscore=1015 spamscore=0 adultscore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304130085
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All Qualcomm bootloaders log useful timestamp information related
to bootloader stats in the IMEM region. Add the child node within
IMEM for the boot stat region containing register address and
compatible string.

Signed-off-by: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
---
 .../devicetree/bindings/sram/qcom,imem.yaml        | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/Documentation/devicetree/bindings/sram/qcom,imem.yaml b/Documentation/devicetree/bindings/sram/qcom,imem.yaml
index ba694ce..c1e1e9b 100644
--- a/Documentation/devicetree/bindings/sram/qcom,imem.yaml
+++ b/Documentation/devicetree/bindings/sram/qcom,imem.yaml
@@ -49,6 +49,28 @@ patternProperties:
     $ref: /schemas/remoteproc/qcom,pil-info.yaml#
     description: Peripheral image loader relocation region
 
+  "^stats@[0-9a-f]+$":
+    type: object
+    description:
+      Imem region dedicated for storing timestamps related
+      information regarding bootstats.
+
+    properties:
+      compatible:
+        items:
+          - enum:
+              - qcom,sm8450-bootstats
+          - const: qcom,imem-bootstats
+
+      reg:
+        maxItems: 1
+
+    required:
+      - compatible
+      - reg
+
+    additionalProperties: false
+
 required:
   - compatible
   - reg
-- 
2.7.4

