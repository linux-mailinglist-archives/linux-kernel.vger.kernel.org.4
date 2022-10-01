Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD215F1941
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 05:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233030AbiJADJw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 23:09:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232341AbiJADHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 23:07:42 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ACCCCEE8F;
        Fri, 30 Sep 2022 20:06:59 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2912pqlN030970;
        Sat, 1 Oct 2022 03:06:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=TXst7s4lWUw9+ZO/VIL16A/hiKO0cFeHCtxxymc41Y0=;
 b=VkB8deSsW2oLvB9JkjQ40itdtMrXBGD99M8liU6ORa67kdeLZC+kkPy2Z1RzAJHMWP8F
 Q/tWUYxNZjVCO/hkHihd34OEjonglo0KfxeqfhVB7X5iYNypNZSDwGJP7Ty/ok89dfAZ
 teUshlIOt+NnjngKr//2br43hYDhVFHhHgqKHwEQzxlfPzL0iqgf2nmUC3ga3fXH64L4
 oCKriVJx86MXyo45eOvhyqbCY+THAnVuTR93ebxC+vOKAR8kcvmxwVnMXamT08h0Tj51
 YsUtf3Ny4IsG3NTDkkPITi5zLrFWS+qelQxtnaG+Jc/g+3OJEILb5xprHi1LPVO6o3b7 dg== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jxcjf81ey-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 01 Oct 2022 03:06:56 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29136tJa009293
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 1 Oct 2022 03:06:55 GMT
Received: from hu-molvera-sd.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Fri, 30 Sep 2022 20:06:54 -0700
From:   Melody Olvera <quic_molvera@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
CC:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Melody Olvera <quic_molvera@quicinc.com>
Subject: [PATCH 2/5] dt-bindings: arm: qcom: Document QDU1000/QRU1000 SoCs and boards
Date:   Fri, 30 Sep 2022 20:06:38 -0700
Message-ID: <20221001030641.29354-3-quic_molvera@quicinc.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221001030641.29354-1-quic_molvera@quicinc.com>
References: <20221001030641.29354-1-quic_molvera@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: noqXnTxE3IwlgLhU3A4lfLjerJMGf460
X-Proofpoint-ORIG-GUID: noqXnTxE3IwlgLhU3A4lfLjerJMGf460
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-01_02,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=973
 mlxscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 impostorscore=0
 spamscore=0 phishscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210010016
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the QDU1000 and QRU1000 SoC bindings and the boards that use
them.

Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index fb1d00bcc847..1cfd92f4ab5d 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -61,6 +61,8 @@ description: |
         sm8250
         sm8350
         sm8450
+        qdu1000
+        qru1000
 
   The 'board' element must be one of the following strings:
 
@@ -76,6 +78,7 @@ description: |
         mtp
         qrd
         sbc
+        x100
 
   The 'soc_version' and 'board_version' elements take the form of v<Major>.<Minor>
   where the minor number may be omitted when it's zero, i.e.  v1.0 is the same
@@ -718,6 +721,19 @@ properties:
               - qcom,sm8450-qrd
           - const: qcom,sm8450
 
+      - description: Qualcomm Technologies, Inc. Distributed Unit 1000 platform
+          - items:
+              - enum:
+                  - qcom,qdu1000-idp
+                  - qcom,qdu1000-x100
+              - const: qcom,qdu1000
+
+      - description: Qualcomm Technologies, Inc. Radio Unit 1000 platform
+          - items:
+              - enum:
+                  -qcom,qru1000-idp
+              - const: qcom,qru1000
+
 additionalProperties: true
 
 ...
-- 
2.37.3

