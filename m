Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE8366BD8F5
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 20:22:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbjCPTWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 15:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbjCPTWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 15:22:33 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65F609AA10;
        Thu, 16 Mar 2023 12:22:11 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32GDtLoE003569;
        Thu, 16 Mar 2023 19:22:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=aJB7dYNSxtgdCQtWa6/q24cp7ISzXfS7RLzG+WKN1BM=;
 b=nXBkdhRwwlrfiubmqs229PvZjMPJrN8J58h6fcx7FvMp0OvdW1VNzJB0HQh0BhYEd6ux
 Mg/AFOt/QPmvH+HxmsrttMuqcwU2m9vEQ2uybZq/oLVEyJbumvoXJsR4iHrPU1hZMFWG
 EIrRV5UlwRmVfsSPMEn+teT4sYYa+E832h1t+dvfuFiQVDSJVjidSqyg2XKmXT6UuI6J
 drN6SGNMI9LWG6ZHxRDDaXPzl1biRSBsnm3vPTg4tlL7i9EurE2kgDMWb0Sy5SoURpAZ
 2l1q4QnK6SVLqzE0n65ABxnC/YVllBXySYC825uFTYM52HnNHsca0dpTltgObbrbRQZv PQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pbpxju00y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Mar 2023 19:22:06 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32GJM6mJ022444
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Mar 2023 19:22:06 GMT
Received: from hu-amelende-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Thu, 16 Mar 2023 12:22:05 -0700
From:   Anjelique Melendez <quic_amelende@quicinc.com>
To:     <pavel@ucw.cz>, <lee@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <andersson@kernel.org>
CC:     <linux-leds@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_c_skakit@quicinc.com>,
        "Anjelique Melendez" <quic_amelende@quicinc.com>
Subject: [PATCH 1/3] dt-bindings: leds-qcom-lpg: Add qcom,pmk8550-pwm compatible string
Date:   Thu, 16 Mar 2023 12:21:32 -0700
Message-ID: <20230316192134.26436-2-quic_amelende@quicinc.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230316192134.26436-1-quic_amelende@quicinc.com>
References: <20230316192134.26436-1-quic_amelende@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: HL7f_Zya9oS1OrwjMz92-JyW4Vyi-r1-
X-Proofpoint-ORIG-GUID: HL7f_Zya9oS1OrwjMz92-JyW4Vyi-r1-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-16_12,2023-03-16_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 mlxscore=0 bulkscore=0 clxscore=1015
 mlxlogscore=661 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303150002 definitions=main-2303160146
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add qcom,pmk8550-pwm compatible string for the Qualcomm Technologies, Inc.
PMK8550 PMIC which has two high resolution PWM channels.

Signed-off-by: Anjelique Melendez <quic_amelende@quicinc.com>
---
 Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml b/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml
index 1df837798249..6295c91f43e8 100644
--- a/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml
+++ b/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml
@@ -27,6 +27,7 @@ properties:
       - qcom,pmc8180c-lpg
       - qcom,pmi8994-lpg
       - qcom,pmi8998-lpg
+      - qcom,pmk8550-pwm
 
   "#pwm-cells":
     const: 2
-- 
2.39.0

