Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1950B6B8B01
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 07:14:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbjCNGO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 02:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjCNGOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 02:14:23 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAB9128841;
        Mon, 13 Mar 2023 23:14:21 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32E3WF1P025210;
        Tue, 14 Mar 2023 06:14:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=dNH7Tn4QpweHKCZnNuB71Cho6CGOdCxqkYgJsy8FUqc=;
 b=ViIaSvryzOcHKp1txP5LjS1LYqK0GcAcGLc9qff4SYm5ROYZ/YXCL8kFZHCGwra0jeC2
 vhqeohZXltodngLN2gX779CMoln3//1k0/qRZ8cvrZm2xngo8Jms3kt4doeVspAq0hm+
 ZeS/1e7duTbuuZfQGr+lmTiTs+Vil8EfK0qwEfUj8ocYBSIsXVYBkVlQoAYtgGbSJhUy
 Z3jbQmS6d6EuSa3ZzOH1FeLSYyeYjCRjFMDijp5rtqLl3S+hG39Sx4SyL9uWEGTMtvLE
 ZowAppWrQT1qV7sgwlOqU4urUj9//BmImO65Kiil3Me8+OZzY9sHuh/NxhVavj/6KLNU AA== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3paay397fa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Mar 2023 06:14:18 +0000
Received: from nasanex01a.na.qualcomm.com ([10.52.223.231])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32E6EHVP002310
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Mar 2023 06:14:17 GMT
Received: from varda-linux.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 13 Mar 2023 23:14:14 -0700
From:   Varadarajan Narayanan <quic_varada@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <devicetree@vger.kernel.org>, <konrad.dybcio@linaro.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <robh+dt@kernel.org>
CC:     Varadarajan Narayanan <quic_varada@quicinc.com>
Subject: [PATCH 1/2] dt-bindings: arm: qcom,ids: Add IDs for IPQ9574 and its variants
Date:   Tue, 14 Mar 2023 11:43:33 +0530
Message-ID: <1678774414-14414-2-git-send-email-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1678774414-14414-1-git-send-email-quic_varada@quicinc.com>
References: <1678774414-14414-1-git-send-email-quic_varada@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: HiDQS-m_QB_1ER769t5dH0aYt9fESLig
X-Proofpoint-GUID: HiDQS-m_QB_1ER769t5dH0aYt9fESLig
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-13_13,2023-03-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 mlxlogscore=722 malwarescore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 phishscore=0 spamscore=0 impostorscore=0 priorityscore=1501 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303140054
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SOC ID for Qualcomm IPQ9574, IPQ9570, IPQ9554, IPQ9550,
IPQ9514 and IPQ9510

Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
 include/dt-bindings/arm/qcom,ids.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/dt-bindings/arm/qcom,ids.h b/include/dt-bindings/arm/qcom,ids.h
index aa95439..a919c45 100644
--- a/include/dt-bindings/arm/qcom,ids.h
+++ b/include/dt-bindings/arm/qcom,ids.h
@@ -228,7 +228,13 @@
 #define QCOM_ID_SC7280			487
 #define QCOM_ID_SC7180P			495
 #define QCOM_ID_SM6375			507
+#define QCOM_ID_IPQ9514			510
+#define QCOM_ID_IPQ9550			511
+#define QCOM_ID_IPQ9554			512
+#define QCOM_ID_IPQ9570			513
+#define QCOM_ID_IPQ9574			514
 #define QCOM_ID_SM8550			519
+#define QCOM_ID_IPQ9510			521
 #define QCOM_ID_QRU1000			539
 #define QCOM_ID_QDU1000			545
 #define QCOM_ID_QDU1010			587
-- 
2.7.4

