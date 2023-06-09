Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B9F672989B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 13:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239241AbjFILvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 07:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238764AbjFILva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 07:51:30 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7580F3AA6;
        Fri,  9 Jun 2023 04:50:54 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 359Ax9s3025077;
        Fri, 9 Jun 2023 11:50:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=0EB/2bm6n63XmQQ27jSNwrVyH2tn76g7ixF/gd2TUcY=;
 b=HViQctsHmCgxX0SFjP2wxlEW4zJsCOrCXGHqDo8AcU+v1dsI87JqhcjKF6OM47IBRz5J
 I73LrsW3b9QMfOK3KyFoamS5Aar/RhJhc4BBsJM7w6Ixr4cLb2K4qfP8WHX5SuDOCjo1
 XHxh6zZPuxqikk3hpv8TQA+ZFxZdgThdszfj0y/wySh1qoc4s7btvpJ9r439VT3Fkb6z
 /layCONYx36yjcIqi16QK9lCk9fiW7SZ80f3Ubq0AmQRF48D7bK1lVfKn4Jpc8RnzjCO
 WZMkrX9XMppl3SWoDrBkcG5sZWFrKZzzmEf/rgzX7FksvhhfGwBlPd66WoHc4yEmeLtq kw== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r3xyx8hen-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Jun 2023 11:50:45 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 359Boed4019489;
        Fri, 9 Jun 2023 11:50:40 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 3r2g35rh4x-1;
        Fri, 09 Jun 2023 11:50:40 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 359BoeOK019477;
        Fri, 9 Jun 2023 11:50:40 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-rohiagar-hyd.qualcomm.com [10.213.106.138])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 359BoeTi019473;
        Fri, 09 Jun 2023 11:50:40 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
        id 916D05F37; Fri,  9 Jun 2023 17:20:39 +0530 (+0530)
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, rafael@kernel.org, viresh.kumar@linaro.org,
        tglx@linutronix.de, maz@kernel.org, mani@kernel.org,
        robimarko@gmail.com
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH v4 1/5] dt-bindings: arm: qcom: Document SDX75 platform and boards
Date:   Fri,  9 Jun 2023 17:20:34 +0530
Message-Id: <1686311438-24177-2-git-send-email-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1686311438-24177-1-git-send-email-quic_rohiagar@quicinc.com>
References: <1686311438-24177-1-git-send-email-quic_rohiagar@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: G9wD1vYr6Tbje79tERHYDF2bwJhVMfmI
X-Proofpoint-GUID: G9wD1vYr6Tbje79tERHYDF2bwJhVMfmI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-09_08,2023-06-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 spamscore=0 bulkscore=0
 clxscore=1015 mlxscore=0 lowpriorityscore=0 mlxlogscore=863 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306090100
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the SDX75 platform binding and also the boards using it.

Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index d9dd256..772f145 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -69,6 +69,7 @@ description: |
         sdm845
         sdx55
         sdx65
+        sdx75
         sm4250
         sm6115
         sm6115p
@@ -821,6 +822,11 @@ properties:
 
       - items:
           - enum:
+              - qcom,sdx75-idp
+          - const: qcom,sdx75
+
+      - items:
+          - enum:
               - qcom,ipq6018-cp01
               - qcom,ipq6018-cp01-c1
           - const: qcom,ipq6018
@@ -1042,6 +1048,7 @@ allOf:
               - qcom,sdm845
               - qcom,sdx55
               - qcom,sdx65
+              - qcom,sdx75
               - qcom,sm4250
               - qcom,sm6115
               - qcom,sm6125
-- 
2.7.4

