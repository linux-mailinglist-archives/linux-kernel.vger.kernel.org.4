Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 094C268E720
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 05:30:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbjBHEaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 23:30:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230417AbjBHE3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 23:29:55 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2E06410AF;
        Tue,  7 Feb 2023 20:29:32 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3183ocOU021420;
        Wed, 8 Feb 2023 04:29:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=YY7Uuo5lvoWbnJxMGS5LW804JAaG85t40oFPCRQVa8A=;
 b=RWrFD7dHuRmmYXPlq+P/EHxjcqwTH2GFMp1910+gu+W5yGQ/D8ljyb6ZOm5PKTn09kpH
 JUdRYpVGdAj2Z+FeDUAEjVjuLsYLtkmxZK9sUeWUjQ+WimlT1NlseLa1qqoIJelSHKj4
 NdomePvXC+EtKkfOkXkxhk/saNatx+BYT545ZtmPzPSQEBkYh85HtxzrQMW5jneJemku
 o9EYXb0IuE9fxDyebmYu/WfogMXesSQWfoftrAQZMAYv1mSqZp/WkgXMF2NYjc6+qhe7
 kj36MvitS1qxGitIxG6GCsdhKpTjI/iI1JZgd1EON0QPGYa2LrS3Nc+urKyZ1LsjAOCP qA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nkmnntaj1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Feb 2023 04:29:28 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3184TRcp005971
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 8 Feb 2023 04:29:27 GMT
Received: from kathirav-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 7 Feb 2023 20:29:22 -0800
From:   Kathiravan T <quic_kathirav@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <jassisinghbrar@gmail.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <quic_varada@quicinc.com>, <quic_srichara@quicinc.com>,
        Kathiravan T <quic_kathirav@quicinc.com>
Subject: [PATCH V2 4/5] dt-bindings: mailbox: qcom: add compatible for the IPQ5332 SoC
Date:   Wed, 8 Feb 2023 09:58:49 +0530
Message-ID: <20230208042850.1687-5-quic_kathirav@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230208042850.1687-1-quic_kathirav@quicinc.com>
References: <20230208042850.1687-1-quic_kathirav@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ld452Yd3M6J3LGeNJxeKlGMIf8ncXojc
X-Proofpoint-GUID: ld452Yd3M6J3LGeNJxeKlGMIf8ncXojc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-07_15,2023-02-06_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 mlxlogscore=999 phishscore=0 adultscore=0 clxscore=1015 malwarescore=0
 priorityscore=1501 suspectscore=0 spamscore=0 lowpriorityscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302080040
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the mailbox compatible for the IPQ5332 SoC.

Since the IPQ5332 mailbox is compatible with the IPQ6018, lets create the
fallback to ipq6018 compatible, so that we don't bloat the of_device_id
table in the driver.

Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
---
Changes in V2:
	- As suggested by Krzysztof, modified the binding to use the
	  fallback mechanism so that we don't keep adding the
	  compatibles with the same driver data in mailbox driver

 .../mailbox/qcom,apcs-kpss-global.yaml         | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml b/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
index 943f9472ae10..a65b61e5acb0 100644
--- a/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
+++ b/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
@@ -16,6 +16,10 @@ maintainers:
 properties:
   compatible:
     oneOf:
+      - items:
+          - enum:
+              - qcom,ipq5332-apcs-apps-global
+          - const: qcom,ipq6018-apcs-apps-global
       - items:
           - enum:
               - qcom,ipq6018-apcs-apps-global
@@ -110,9 +114,10 @@ allOf:
   - if:
       properties:
         compatible:
-          enum:
-            - qcom,ipq6018-apcs-apps-global
-            - qcom,ipq8074-apcs-apps-global
+          contains:
+            enum:
+              - qcom,ipq6018-apcs-apps-global
+              - qcom,ipq8074-apcs-apps-global
     then:
       properties:
         clocks:
@@ -126,9 +131,10 @@ allOf:
   - if:
       properties:
         compatible:
-          enum:
-            - qcom,ipq6018-apcs-apps-global
-            - qcom,ipq8074-apcs-apps-global
+          contains:
+            enum:
+              - qcom,ipq6018-apcs-apps-global
+              - qcom,ipq8074-apcs-apps-global
     then:
       properties:
         '#clock-cells':
-- 
2.17.1

