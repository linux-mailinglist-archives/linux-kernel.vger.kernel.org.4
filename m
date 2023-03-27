Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B29036C9F79
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 11:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233297AbjC0Jb5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 05:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233242AbjC0Jbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 05:31:51 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E2FE524E;
        Mon, 27 Mar 2023 02:31:48 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32R7P2vf021095;
        Mon, 27 Mar 2023 09:31:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=cM2In5V2Jae4Du0Vf/WDXcgIB9igd8d/s33WbCbUg1s=;
 b=ax3BOMizj7nh6t3JnV/DK9LsndHkiVefovriXW/Ly/wUc/9ucFcHfzizVrYzCedv2hcA
 dgBHgZbAQRJ7Qyns+RJDPFsrc0LXLtdnH25CMo8wD931Eo1TM5Noqk/ydhvqtqMVRwCD
 o1z2fIHgfP5V/1ZaoUJAK0cbqdCkowd34vA6/8frCXjEYBPq9lrPNGfTrj8kLdAg9l3s
 YT0qQWpY3YjxZCW9qc6Yq3X9LR4gCUk2nCLbc5uppUZrY38f57FOaM63w+ZYtYCVR+XP
 wMsrZVtNhPBXwEiVVe3TiVl81VJ7qGO40xv7/qbY+m+DyZcw44NOS7PZUrRgFKgo2drf Ww== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3phsqqkyta-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Mar 2023 09:31:41 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32R9VecB014645
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Mar 2023 09:31:40 GMT
Received: from varda-linux.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 27 Mar 2023 02:31:34 -0700
From:   Varadarajan Narayanan <quic_varada@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <gregkh@linuxfoundation.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <quic_wcheng@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-clk@vger.kernel.org>
CC:     Varadarajan Narayanan <quic_varada@quicinc.com>
Subject: [PATCH v4 2/8] dt-bindings: phy: qcom,qmp-usb: Add IPQ9574 USB3 PHY
Date:   Mon, 27 Mar 2023 15:00:54 +0530
Message-ID: <4a21defe3320eb11d0e43bc7f02b3168ecefd458.1679909245.git.quic_varada@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1679909245.git.quic_varada@quicinc.com>
References: <cover.1679909245.git.quic_varada@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: lBU4wiz5M4cd89KlEanVHxl6FGJHph-4
X-Proofpoint-ORIG-GUID: lBU4wiz5M4cd89KlEanVHxl6FGJHph-4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-24_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 clxscore=1015 mlxscore=0
 spamscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303270077
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dt-bindings for USB3 PHY found on Qualcomm IPQ9574

Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
 Changes in v4:
	- Remove constraints not applicable to IPQ9574
 Changes in v3:
	- Update other mandatory fields to accomodate IPQ9574
 Changes in v2:
	- Updated sections missed in previous patch
---
 .../bindings/phy/qcom,msm8996-qmp-usb3-phy.yaml    | 25 ++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-usb3-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-usb3-phy.yaml
index e81a382..aa5b58c 100644
--- a/Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-usb3-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-usb3-phy.yaml
@@ -21,6 +21,7 @@ properties:
     enum:
       - qcom,ipq6018-qmp-usb3-phy
       - qcom,ipq8074-qmp-usb3-phy
+      - qcom,ipq9574-qmp-usb3-phy
       - qcom,msm8996-qmp-usb3-phy
       - qcom,msm8998-qmp-usb3-phy
       - qcom,qcm2290-qmp-usb3-phy
@@ -122,8 +123,6 @@ required:
   - clock-names
   - resets
   - reset-names
-  - vdda-phy-supply
-  - vdda-pll-supply
 
 additionalProperties: false
 
@@ -204,6 +203,28 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,ipq9574-qmp-usb3-phy
+    then:
+      properties:
+        clocks:
+          maxItems: 3
+        clock-names:
+          items:
+            - const: aux
+            - const: cfg_ahb
+            - const: pipe
+        resets:
+          maxItems: 2
+        reset-names:
+          items:
+            - const: phy
+            - const: common
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
               - qcom,sm8150-qmp-usb3-phy
               - qcom,sm8150-qmp-usb3-uni-phy
               - qcom,sm8250-qmp-usb3-uni-phy
-- 
2.7.4

