Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C24E2661CEC
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 04:50:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236181AbjAIDuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 22:50:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236289AbjAIDub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 22:50:31 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 868D9BC18;
        Sun,  8 Jan 2023 19:50:30 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3093lIrv008870;
        Mon, 9 Jan 2023 03:50:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=Ssk2zGqyZuUY6GLeC/z8yyt6ITzNNw+rHP/o1GQE0Y4=;
 b=kVBk4G3CkX1vqjBnlrqw+RvonQ0H5OWRPySlgpNzzWNAZImsY3JAP4qSFLFwWHFgew49
 Ha2Vtwn0ZCyYoOsEwIJGukDLVHo1i4bJINK/zs/S9CUs6LXZbGzl0Ml5f12xZrsBfixF
 zVkZW3rkJLWELyy+dkr96Y242aAs/uD6vlPD/iFffZ3RK3FxH9Gkzs0rzhNcNlY+vzsd
 jU9ZQXd8JDK5hl+YdQoMdLo2fbGh94DNXR1FoPDnb5vl85NUDYC0DrqPtRtz9y3hOijX
 MaakwFdYfd77q15Ln1R40cdrVXdLbqB83ElUSy9fPQ9v6DLOXG9c8X6/xKxcWD07MPPf 5w== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3my14ft6qe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Jan 2023 03:50:16 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3093oFTa030128
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 9 Jan 2023 03:50:15 GMT
Received: from blr-ubuntu-87.ap.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Sun, 8 Jan 2023 19:50:11 -0800
From:   Sibi Sankar <quic_sibis@quicinc.com>
To:     <andersson@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <robh+dt@kernel.org>, <manivannan.sadhasivam@linaro.org>,
        <robin.murphy@arm.com>
CC:     <agross@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <konrad.dybcio@somainline.org>, <amit.pundir@linaro.org>,
        <regressions@leemhuis.info>, <sumit.semwal@linaro.org>,
        <will@kernel.org>, <catalin.marinas@arm.com>,
        Sibi Sankar <quic_sibis@quicinc.com>
Subject: [PATCH V2 02/11] dt-bindings: remoteproc: qcom,msm8996-mss-pil: Update memory region
Date:   Mon, 9 Jan 2023 09:18:34 +0530
Message-ID: <20230109034843.23759-3-quic_sibis@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230109034843.23759-1-quic_sibis@quicinc.com>
References: <20230109034843.23759-1-quic_sibis@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 0_I3AqAdlJWt8y4pyCqNwZ90uvagpztB
X-Proofpoint-ORIG-GUID: 0_I3AqAdlJWt8y4pyCqNwZ90uvagpztB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-08_19,2023-01-06_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 spamscore=0 impostorscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 phishscore=0 clxscore=1015 suspectscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301090025
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dynamic memory region used for metadata authentication would still
be a part of the kernel mapping and any access to this region  by the
application processor after assigning it to the remote Q6 will result
in a XPU violation. This is fixed by using a no-map carveout instead.
Update the bindings to reflect the addition of the new modem metadata
carveout on MSM8996 (and similar) SoCs.

Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
---
 .../bindings/remoteproc/qcom,msm8996-mss-pil.yaml  | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,msm8996-mss-pil.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,msm8996-mss-pil.yaml
index d3d3fb2fe91d..ad1a51c23949 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,msm8996-mss-pil.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,msm8996-mss-pil.yaml
@@ -123,6 +123,7 @@ properties:
     items:
       - description: MBA reserved region
       - description: Modem reserved region
+      - description: Metadata reserved region
 
   firmware-name:
     $ref: /schemas/types.yaml#/definitions/string-array
@@ -165,6 +166,16 @@ properties:
       - memory-region
     deprecated: true
 
+  metadata:
+    type: object
+    description:
+      Metadata reserved region
+    properties:
+      memory-region: true
+    required:
+      - memory-region
+    deprecated: true
+
 required:
   - compatible
   - reg
@@ -306,6 +317,7 @@ allOf:
       - required:
           - mba
           - mpss
+          - metadata
 
 additionalProperties: false
 
@@ -348,7 +360,7 @@ examples:
                         <&rpmhpd SDM845_MSS>;
         power-domain-names = "cx", "mx", "mss";
 
-        memory-region = <&mba_mem>, <&mpss_mem>;
+        memory-region = <&mba_mem>, <&mpss_mem>, <&mdata_mem>;
 
         resets = <&aoss_reset AOSS_CC_MSS_RESTART>,
                  <&pdc_reset PDC_MODEM_SYNC_RESET>;
-- 
2.17.1

