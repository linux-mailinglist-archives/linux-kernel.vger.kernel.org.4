Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5957B66403F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 13:18:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238189AbjAJMSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 07:18:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238338AbjAJMRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 07:17:07 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 287C16583;
        Tue, 10 Jan 2023 04:15:46 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30A4Y2G7024368;
        Tue, 10 Jan 2023 12:14:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=kkZoWRDShwYxA3ad/aFybpgHWe8jJVKnvvaB5BGXxyg=;
 b=BSaofVzI5qCrNBtAmG5jIjL/y698mF7zdGiTz5P2LzePz5jhXw6IxCbUugAXeoAogiE7
 gA5+3Lw56K5V5yNvhg/LXTdjdU9suGAn6xSEwZw2pIYhyjXT+Zq0A6eIChHqv3c+YJ5C
 bPeJjBQS6wR/II8HZBd8Ux+UdfTPe9JI2+EC12v5AAynEBMz7mc3aIAF1UzwOw7ajnBN
 PP31YHFgVy6yxtk280YyFl/aDS+xc+VBr7pmLQ3ZWtC21OZZHcHKweJIBf5ADvXBPXwi
 +VSt8n3yoN+s+d/8KkKejEzDalqmXUxPNIaVAWKrxhb5tNNhg5rSbEe/BCmgIgtkywqL SA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n113p0w2h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Jan 2023 12:14:35 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30ACEXTf017692
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Jan 2023 12:14:34 GMT
Received: from devipriy-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 10 Jan 2023 04:14:25 -0800
From:   devi priya <quic_devipriy@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <linus.walleij@linaro.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <p.zabel@pengutronix.de>, <shawnguo@kernel.org>, <arnd@arndb.de>,
        <marcel.ziswiler@toradex.com>, <dmitry.baryshkov@linaro.org>,
        <nfraprado@collabora.com>, <broonie@kernel.org>,
        <tdas@codeaurora.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <quic_srichara@quicinc.com>, <quic_gokulsri@quicinc.com>,
        <quic_sjaganat@quicinc.com>, <quic_kathirav@quicinc.com>,
        <quic_arajkuma@quicinc.com>, <quic_anusha@quicinc.com>,
        <quic_poovendh@quicinc.com>
Subject: [PATCH 5/7] dt-bindings: qcom: Add ipq9574 bindings
Date:   Tue, 10 Jan 2023 17:43:14 +0530
Message-ID: <20230110121316.24892-6-quic_devipriy@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230110121316.24892-1-quic_devipriy@quicinc.com>
References: <20230110121316.24892-1-quic_devipriy@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: OMc-UYpBxCia5hsIanqstj_0enO-YUTa
X-Proofpoint-ORIG-GUID: OMc-UYpBxCia5hsIanqstj_0enO-YUTa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-10_03,2023-01-10_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 impostorscore=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 malwarescore=0 mlxscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301100074
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the new ipq9574 SOC/board device tree bindings

Co-developed-by: Anusha Rao <quic_anusha@quicinc.com>
Signed-off-by: Anusha Rao <quic_anusha@quicinc.com>
Signed-off-by: devi priya <quic_devipriy@quicinc.com>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 27063a045bd0..83102fe2d366 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -32,6 +32,7 @@ description: |
         ipq4018
         ipq6018
         ipq8074
+        ipq9574
         mdm9615
         msm8226
         msm8916
@@ -80,6 +81,7 @@ description: |
         hk01
         hk10-c1
         hk10-c2
+        ap-al02-c7
         idp
         liquid
         mtp
@@ -304,6 +306,11 @@ properties:
               - qcom,ipq8074-hk10-c2
           - const: qcom,ipq8074
 
+      - items:
+          - enum:
+              - qcom,ipq9574-ap-al02-c7
+          - const: qcom,ipq9574
+
       - description: Sierra Wireless MangOH Green with WP8548 Module
         items:
           - const: swir,mangoh-green-wp8548
-- 
2.17.1

