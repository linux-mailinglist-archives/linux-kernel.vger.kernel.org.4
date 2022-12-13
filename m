Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8FA764B6D9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 15:08:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234581AbiLMOIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 09:08:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235685AbiLMOIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 09:08:16 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86A371C111;
        Tue, 13 Dec 2022 06:08:10 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BDCJQbA008062;
        Tue, 13 Dec 2022 14:07:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=xE0HfprrM/JQQvr7foPEndXyyQyOs4Ygvb7r5ElxHZo=;
 b=De/zBE4I+DTt7LjnTIQNJEzwnp+ELvmxPFhpFLXbN4X4yqZncSaoUptgTQWfFFaI0TUt
 O7H+8eMCY5Lnvtap304mDGCgtraVUEWGGip8yIxWSQvJnpJPCL4z7qiq+MZFMM0bKqFG
 3RLU3h4w6c8bHyq/9ajx8IzkQhFwyKwHe4+SK/RzL8jiN3imDVMy1nmfQVrl0808ChhT
 ewOIS84iG4KtV2c4jkZKua9TIsGQfmM1Ziv+5QFi9SjuXjVNuzLvnw90LVG2Q1JWComU
 02FX4dUnvtHZHUAaP7DZYcQ9T5f2TCV7d6LQYjZ7aPCTF2srUVfTe0loJ78eydeCiuLW VA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mehje1hfc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Dec 2022 14:07:58 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BDE7vUO011884
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Dec 2022 14:07:57 GMT
Received: from blr-ubuntu-87.ap.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 13 Dec 2022 06:07:52 -0800
From:   Sibi Sankar <quic_sibis@quicinc.com>
To:     <andersson@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <robh+dt@kernel.org>, <manivannan.sadhasivam@linaro.org>
CC:     <agross@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <konrad.dybcio@somainline.org>, <amit.pundir@linaro.org>,
        <regressions@leemhuis.info>, <sumit.semwal@linaro.org>,
        <will@kernel.org>, <catalin.marinas@arm.com>,
        <robin.murphy@arm.com>, Sibi Sankar <quic_sibis@quicinc.com>
Subject: [PATCH 2/4] dt-bindings: remoteproc: qcom: sc7180: Update memory-region requirements
Date:   Tue, 13 Dec 2022 19:37:22 +0530
Message-ID: <20221213140724.8612-3-quic_sibis@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221213140724.8612-1-quic_sibis@quicinc.com>
References: <20221213140724.8612-1-quic_sibis@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: tKHQpmJKstrO2o9Z8auWm_fv-uEfPVDc
X-Proofpoint-ORIG-GUID: tKHQpmJKstrO2o9Z8auWm_fv-uEfPVDc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-13_03,2022-12-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 mlxscore=0 mlxlogscore=978
 bulkscore=0 clxscore=1015 malwarescore=0 priorityscore=1501 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212130126
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the bindings to reflect the addition of the new modem metadata
carveout reference to the memory-region property.

Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
---
 .../devicetree/bindings/remoteproc/qcom,sc7180-mss-pil.yaml    | 3 ++-
 .../devicetree/bindings/remoteproc/qcom,sc7280-mss-pil.yaml    | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sc7180-mss-pil.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sc7180-mss-pil.yaml
index e4a7da8020f4..b1402bef0ebe 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,sc7180-mss-pil.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,sc7180-mss-pil.yaml
@@ -95,6 +95,7 @@ properties:
     items:
       - description: MBA reserved region
       - description: modem reserved region
+      - description: metadata reserved region
 
   firmware-name:
     $ref: /schemas/types.yaml#/definitions/string-array
@@ -223,7 +224,7 @@ examples:
                         <&rpmhpd SC7180_MSS>;
         power-domain-names = "cx", "mx", "mss";
 
-        memory-region = <&mba_mem>, <&mpss_mem>;
+        memory-region = <&mba_mem>, <&mpss_mem>, <&mdata_mem>;
 
         qcom,qmp = <&aoss_qmp>;
 
diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sc7280-mss-pil.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sc7280-mss-pil.yaml
index b4de0521a89d..005cb21732af 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,sc7280-mss-pil.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,sc7280-mss-pil.yaml
@@ -95,6 +95,7 @@ properties:
     items:
       - description: MBA reserved region
       - description: modem reserved region
+      - description: metadata reserved region
 
   firmware-name:
     $ref: /schemas/types.yaml#/definitions/string-array
@@ -240,7 +241,7 @@ examples:
                         <&rpmhpd SC7280_MSS>;
         power-domain-names = "cx", "mss";
 
-        memory-region = <&mba_mem>, <&mpss_mem>;
+        memory-region = <&mba_mem>, <&mpss_mem>, <&mdata_mem>;
 
         qcom,qmp = <&aoss_qmp>;
 
-- 
2.17.1

