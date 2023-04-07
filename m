Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA5A6DAE93
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 16:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240136AbjDGOG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 10:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233982AbjDGOGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 10:06:52 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 909E4AF3F;
        Fri,  7 Apr 2023 07:06:48 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3379BYYb021562;
        Fri, 7 Apr 2023 14:06:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=pJhBOZwjfFN3H2w0yxFRU+GX1a5B/BNLnWlVtGU7Ctg=;
 b=k8LhxF6MGeduu0DH10hmNODRYs29bmm7ynwYQOcYIInlEdSQsm3SRoDv9XRDaddlsy52
 Uac/8w2R/+iMxOFHxZZrsn7ivy1IEBxM1Gjy5CgrtrNlhBbjF0l/xH+enfkA+RRnTzpq
 lxzmCTMRHRDlKW8TGkzCu+YtON+ft72pWA6mxsBYlYFNHHrx942rIU/fmlkq2nHEL+3R
 +q35xOwBHzHiYuVz/6pwURb78+lQ8vQ8awW08tQrSM+Xd/TgBspDgmWrhOx/yWpMwnxP
 fqbFFFtMWMlF9QE9PzKAZvckRNuHV82r7PdMq5gWUox2/NTSkKkNuL/WWkoeh9kL7oK9 Gg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pt5s9snhw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Apr 2023 14:06:40 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 337E6aWB005831
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 7 Apr 2023 14:06:36 GMT
Received: from blr-ubuntu-525.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 7 Apr 2023 07:06:32 -0700
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
Subject: [PATCH V2 1/3] dt-bindings: sram: qcom,imem: Add Boot Stat region within IMEM
Date:   Fri, 7 Apr 2023 19:34:35 +0530
Message-ID: <96601c1f9e433ef8fbc608d5ca09365b9c0d8132.1680874520.git.quic_schowdhu@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1680874520.git.quic_schowdhu@quicinc.com>
References: <cover.1680874520.git.quic_schowdhu@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 3HN21Rrd-uNzM1aC5FRhf7Qgv79uDN8N
X-Proofpoint-ORIG-GUID: 3HN21Rrd-uNzM1aC5FRhf7Qgv79uDN8N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-07_08,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 mlxlogscore=924 priorityscore=1501 clxscore=1015 spamscore=0
 malwarescore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304070129
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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
 .../devicetree/bindings/sram/qcom,imem.yaml         | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/Documentation/devicetree/bindings/sram/qcom,imem.yaml b/Documentation/devicetree/bindings/sram/qcom,imem.yaml
index 665c06e..9998d65 100644
--- a/Documentation/devicetree/bindings/sram/qcom,imem.yaml
+++ b/Documentation/devicetree/bindings/sram/qcom,imem.yaml
@@ -26,6 +26,7 @@ properties:
           - qcom,sdm845-imem
           - qcom,sdx55-imem
           - qcom,sdx65-imem
+          - qcom,sm8450-imem
       - const: syscon
       - const: simple-mfd
 
@@ -48,6 +49,26 @@ patternProperties:
     $ref: /schemas/remoteproc/qcom,pil-info.yaml#
     description: Peripheral image loader relocation region
 
+  "^boot-stat@[0-9a-f]+$":
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
 required:
   - compatible
   - reg
-- 
2.7.4

