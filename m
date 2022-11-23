Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 185BB636B7C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 21:48:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236378AbiKWUqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 15:46:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232341AbiKWUqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 15:46:52 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A6711474;
        Wed, 23 Nov 2022 12:46:50 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ANJjNDx012820;
        Wed, 23 Nov 2022 20:46:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=/yYHKEOnTVo/9NazI4ur/F+aMhMvwbkjMDbSaC6kYco=;
 b=XbLfibbQege3t7fnMQTSHj1hIdEAzmH/E/MwLkRLu2bavALLHPwd0tfu9ihptg18p4NX
 swZvfrZVnU123RVpz7qiEqFfo522BIfCGp/zDTAQX4oxvhlyvmJGgL8GlDLECZCCRAOJ
 0Q1liOHs8QIHqsu0FRKRxeFxieyqfrZ7VluDziT3nbzOY0V1ogh+NRIHFgQ5yKe9tGsj
 9yVUFbcghRmw7OFR/tdRoVEW4AFb1P6eqEkeSJUCOga/CmehFbJwJ02MnNCiPZmHDbY1
 en7PpO7rkvjuZhOrbTePcr5kP7RRVvZ174ZfLvS4G/zgqKHQIVnHp5A6mv8TXhHx93a5 DQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3m1favjmp0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Nov 2022 20:46:43 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2ANKkgk0022330
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Nov 2022 20:46:42 GMT
Received: from blr-ubuntu-87.ap.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 23 Nov 2022 12:46:38 -0800
From:   Sibi Sankar <quic_sibis@quicinc.com>
To:     <andersson@kernel.org>
CC:     <agross@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>,
        <konrad.dybcio@somainline.org>, <robimarko@gmail.com>,
        <quic_gurus@quicinc.com>, <quic_rjendra@quicinc.com>,
        Sibi Sankar <quic_sibis@quicinc.com>
Subject: [PATCH V5 1/2] dt-bindings: firmware: qcom-scm: Add optional interrupt
Date:   Thu, 24 Nov 2022 02:16:14 +0530
Message-ID: <20221123204615.25358-2-quic_sibis@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221123204615.25358-1-quic_sibis@quicinc.com>
References: <20221123204615.25358-1-quic_sibis@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: owDaDJZv-x8FOzgVhj6dmQ46OBWW4f9Y
X-Proofpoint-GUID: owDaDJZv-x8FOzgVhj6dmQ46OBWW4f9Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-23_11,2022-11-23_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 clxscore=1015 mlxscore=0 phishscore=0
 impostorscore=0 priorityscore=1501 bulkscore=0 spamscore=0 mlxlogscore=802
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211230153
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guru Das Srinagesh <quic_gurus@quicinc.com>

Add an interrupt specification to the bindings to support the wait-queue
feature.

Signed-off-by: Guru Das Srinagesh <quic_gurus@quicinc.com>
Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---

v5:
- Pick up R-b

v4:
- Qualify bindings [Krzysztoff]

 Documentation/devicetree/bindings/firmware/qcom,scm.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
index 25688571ee7c..aea6e0c86a89 100644
--- a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
+++ b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
@@ -73,6 +73,12 @@ properties:
   '#reset-cells':
     const: 1
 
+  interrupts:
+    description:
+      The wait-queue interrupt that firmware raises as part of handshake
+      protocol to handle sleeping SCM calls.
+    maxItems: 1
+
   qcom,dload-mode:
     $ref: /schemas/types.yaml#/definitions/phandle-array
     items:
-- 
2.17.1

