Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4334F6FB3B8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 17:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234498AbjEHP03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 11:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234494AbjEHP0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 11:26:13 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40EB78A42;
        Mon,  8 May 2023 08:26:11 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 348CS2sI029817;
        Mon, 8 May 2023 15:26:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=owVw3QFxGOSlkS1JbISLKvDha9vh4axKFs24JM+xCaY=;
 b=IQHAEUwOtsSz0hkWpPKUAEzidIXhzHfCa2EoRG2QFYAOTbc1xhOo5XssC2Ert2BorIBE
 kFD0cD8G4zdT0tzUYRMocOgBhzUnCUBcUBu0yY5koN5NsG9FdSTyGV5tyBrDK3v+a+ZN
 zaHxahpnDasQJpyB+2JDAsKG4O8MfCfyPLBkW/NgTjiKkr1QWkdYGXj7l5+d7RROZ/dq
 355g9arDC29XgkslF4wQPH5iWPRIPXkFAAsbRlDY3esE5wuypYFfShfaiKNXYYXs+nxB
 AVBLpRidPNpLiFRluT68ih5/uDD6KnEb/l2CqYVcBeNQzGUr1EKswQZRX/BiNx1VPihO Hg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qf0vk0f76-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 May 2023 15:26:08 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 348FQ7JS001467
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 8 May 2023 15:26:07 GMT
Received: from kathirav-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Mon, 8 May 2023 08:26:01 -0700
From:   Kathiravan T <quic_kathirav@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     Kathiravan T <quic_kathirav@quicinc.com>
Subject: [PATCH 1/2] dt-bindings: arm: qcom,ids: add SoC ID for IPQ5312 and IPQ5302
Date:   Mon, 8 May 2023 20:55:42 +0530
Message-ID: <20230508152543.14969-2-quic_kathirav@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230508152543.14969-1-quic_kathirav@quicinc.com>
References: <20230508152543.14969-1-quic_kathirav@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: SypFquBzW2z2P4hmnAE1ZoCk-Rswbul1
X-Proofpoint-ORIG-GUID: SypFquBzW2z2P4hmnAE1ZoCk-Rswbul1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-08_11,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 mlxlogscore=763 bulkscore=0
 malwarescore=0 adultscore=0 spamscore=0 mlxscore=0 clxscore=1015
 impostorscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2305080102
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the SoC ID for IPQ5312 and IPQ5302, which are belongs to the family
of IPQ5332 SoC.

Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
---
 include/dt-bindings/arm/qcom,ids.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/dt-bindings/arm/qcom,ids.h b/include/dt-bindings/arm/qcom,ids.h
index 802495b20276..bd5b3f50ba14 100644
--- a/include/dt-bindings/arm/qcom,ids.h
+++ b/include/dt-bindings/arm/qcom,ids.h
@@ -248,6 +248,8 @@
 #define QCOM_ID_QRU1062			590
 #define QCOM_ID_IPQ5332			592
 #define QCOM_ID_IPQ5322			593
+#define QCOM_ID_IPQ5312			594
+#define QCOM_ID_IPQ5302			595
 
 /*
  * The board type and revision information, used by Qualcomm bootloaders and
-- 
2.17.1

