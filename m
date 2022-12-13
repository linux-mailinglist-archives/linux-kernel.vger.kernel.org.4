Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E637F64B6DB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 15:09:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235485AbiLMOId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 09:08:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235824AbiLMOIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 09:08:19 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBD4120BE6;
        Tue, 13 Dec 2022 06:08:16 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BD66EYR025182;
        Tue, 13 Dec 2022 14:08:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=d9vC3/6r4RbGZMDzSejEODqDGqHxVnirnnqfAfUdkTw=;
 b=OucyUW0FBjIHIbrvhYOXk1YNvfNYpYjNKLWnfDaFtPx/8wwF0Q5B44XYlQM2cVHbv2/R
 FgQUYMUgbsyKAkao6lFEuwam2S178XRUsQNjvUpEO1tyL+vUNcGakCee0PKoIsZ5AMEB
 XRN3++iUFylzGU04CkUXvkgLsM4x6/D3tu2tW8Fd2rc/fu09AC3aIWkDyK1SODarnSsR
 AYXTvmxcqXQzg8kSlQBjEgcgpxwvIB2v+lyY2QKMLFQMwCwCcIuoK0nGRIe60e/i453G
 d6p8O3NdumNfkFAQFj+3c3uiYsH4XUcen+k9Mz6KaDjBUBiO3EogEtrKDrxnMsl8PagD pg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3medypa8ka-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Dec 2022 14:08:03 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BDE82ZB000651
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Dec 2022 14:08:02 GMT
Received: from blr-ubuntu-87.ap.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 13 Dec 2022 06:07:57 -0800
From:   Sibi Sankar <quic_sibis@quicinc.com>
To:     <andersson@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <robh+dt@kernel.org>, <manivannan.sadhasivam@linaro.org>
CC:     <agross@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <konrad.dybcio@somainline.org>, <amit.pundir@linaro.org>,
        <regressions@leemhuis.info>, <sumit.semwal@linaro.org>,
        <will@kernel.org>, <catalin.marinas@arm.com>,
        <robin.murphy@arm.com>, Sibi Sankar <quic_sibis@quicinc.com>
Subject: [PATCH 3/4] dt-bindings: remoteproc: qcom: q6v5: Update memory region requirements
Date:   Tue, 13 Dec 2022 19:37:23 +0530
Message-ID: <20221213140724.8612-4-quic_sibis@quicinc.com>
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
X-Proofpoint-ORIG-GUID: L5zoXTJmYHZ2McYZWBL4usgADxG9MPkM
X-Proofpoint-GUID: L5zoXTJmYHZ2McYZWBL4usgADxG9MPkM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-13_03,2022-12-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=999
 bulkscore=0 mlxscore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 impostorscore=0 spamscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2212130126
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the bindings to reflect the addition of the new modem metadata
carveout on SoCs that use memory protection before transferring control
to the remote Q6.

Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
---

https://lore.kernel.org/all/20220511161602.117772-7-sireeshkodali1@gmail.com/
Sireesh had started the conversion to yaml a while back. I'll take over
the conversion from v2.

 .../bindings/remoteproc/qcom,q6v5.txt         | 29 +++++++++++++++++--
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt b/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
index d0ebd16ee0e1..89772d026363 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt
@@ -104,8 +104,24 @@ on the Qualcomm Hexagon core.
 		    must be "mss_restart", "pdc_reset" for the modem
 		    sub-system on SDM845 SoCs
 
-For devices where the mba and mpss sub-nodes are not specified, mba/mpss region
-should be referenced as follows:
+For devices with the compatible strings below and where the mba, mpss and
+metadata sub-nodes are not specified, mba/mpss/mdata region should be
+referenced as follows:
+  "qcom,msm8996-mss-pil"
+  "qcom,msm8998-mss-pil"
+  "qcom,sdm845-mss-pil"
+- memory-region:
+	Usage: required
+	Value type: <phandle>
+	Definition: reference to mba, mpss and metadata reserved-memory regions.
+
+For devices with the compatible strings below and where the mba and mpss
+sub-nodes are not specified, mba/mpss region should be referenced as follows:
+  "qcom,q6v5-pil",
+  "qcom,ipq8074-wcss-pil"
+  "qcom,qcs404-wcss-pil"
+  "qcom,msm8916-mss-pil",
+  "qcom,msm8974-mss-pil"
 - memory-region:
 	Usage: required
 	Value type: <phandle>
@@ -198,7 +214,14 @@ on platforms which do not have TrustZone.
 
 = SUBNODES:
 The Hexagon node must contain two subnodes, named "mba" and "mpss" representing
-the memory regions used by the Hexagon firmware. Each sub-node must contain:
+the memory regions used by the Hexagon firmware. For devices with the compatible
+string below, an additional third subnode named "metadata" representing the modem
+metadata memory region should also be present.
+  "qcom,msm8996-mss-pil"
+  "qcom,msm8998-mss-pil"
+  "qcom,sdm845-mss-pil"
+
+Each sub-node must contain:
 
 - memory-region:
 	Usage: required
-- 
2.17.1

