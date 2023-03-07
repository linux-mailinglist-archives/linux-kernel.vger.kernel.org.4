Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 273E06AD75E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 07:24:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbjCGGY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 01:24:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230497AbjCGGYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 01:24:50 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B84E3515CF;
        Mon,  6 Mar 2023 22:24:12 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3276EsT8008210;
        Tue, 7 Mar 2023 06:23:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=xOoTjEMC9lJkfsiQEqiu16XiKDFbmTxNx2zP2p7wxok=;
 b=f+FYhG8uouQ5GNHIbTbcs5XWDxj457Hmj4vdZs9YPvJGUEyZr/PCMAbJbpERiKe61Vsy
 JGhBcw3cmTXJB4QP5j9IsJoFKk6IfTtUdXnHtlA0XOvPWjJaMlWmQKFqdMBKPriAZ4RG
 a4MfrduDZjOerXJXO/weY6hP1sJNjRS2I5Dt+SJ14dQHtfAl4vHSeYXaQTuLb2crl+wj
 mqg8u1HykS+BxkosFGZ85pvzevAJalmPn6Mjx9xveIAvbLCqzgbPQdl5+lKO7ROLkZtP
 UbEPh6hGBlyMv7Rg/b1tmqMEISzkdyftUeA/TExbkFKJuSKYGmQB6lb1awtmXBTzvU4m Ew== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p419d724s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Mar 2023 06:23:38 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3276NbXY023295
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 7 Mar 2023 06:23:38 GMT
Received: from kathirav-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 6 Mar 2023 22:23:31 -0800
From:   Kathiravan T <quic_kathirav@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <catalin.marinas@arm.com>, <will@kernel.org>,
        <arnd@arndb.de>, <dmitry.baryshkov@linaro.org>,
        <geert+renesas@glider.be>, <nfraprado@collabora.com>,
        <broonie@kernel.org>, <rafal@milecki.pl>, <robimarko@gmail.com>,
        <quic_gurus@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC:     Kathiravan T <quic_kathirav@quicinc.com>
Subject: [PATCH V6 6/9] dt-bindings: qcom: add ipq5332 boards
Date:   Tue, 7 Mar 2023 11:52:29 +0530
Message-ID: <20230307062232.4889-7-quic_kathirav@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230307062232.4889-1-quic_kathirav@quicinc.com>
References: <20230307062232.4889-1-quic_kathirav@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: BwS9bkhWzDte1SfqdZnnf01CCzKd5ixv
X-Proofpoint-GUID: BwS9bkhWzDte1SfqdZnnf01CCzKd5ixv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-07_01,2023-03-06_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 impostorscore=0 priorityscore=1501
 clxscore=1015 suspectscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303070056
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the new ipq5332 SoC/board device tree bindings

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
---
Changes in V6:
	- No changes

Changes in V5:
	- No changes

Changes in V4:
	- Pick up R-b tag

Changes in V3:
	- Sorted the board name

Changes in V2:
	- No changes

 Documentation/devicetree/bindings/arm/qcom.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 1bb24d46e4ee..465bb98cb91d 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -30,6 +30,7 @@ description: |
         apq8084
         apq8096
         ipq4018
+        ipq5332
         ipq6018
         ipq8074
         mdm9615
@@ -80,6 +81,7 @@ description: |
   The 'board' element must be one of the following strings:
 
         adp
+        ap-mi01.2
         cdp
         cp01-c1
         dragonboard
@@ -320,6 +322,11 @@ properties:
               - qcom,ipq4019-dk04.1-c1
           - const: qcom,ipq4019
 
+      - items:
+          - enum:
+              - qcom,ipq5332-ap-mi01.2
+          - const: qcom,ipq5332
+
       - items:
           - enum:
               - mikrotik,rb3011
-- 
2.17.1

