Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF6D70B18E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 00:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbjEUWaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 18:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbjEUWaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 18:30:10 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77AA01A7;
        Sun, 21 May 2023 15:29:51 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34LMMXoU005232;
        Sun, 21 May 2023 22:29:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=1YCZ/5wb97tOLkbFCh5KgOXccZ7Df9knHccpxVjxQUg=;
 b=B7mq9Gys1KcXx3qZ7Q37m+Pl6veQNX6YeGc10Xb82Y7j64ghObvbzJI1Q68bmHP/c6zS
 iC/2bwgo4hSrFbGyBastLQmouc2/+hTtalG4NNguvipeA/4Omk4lwL44K+bkZqVaE/Ev
 Rx3ao5inG3oPtFY7CKt/oT3iTtKtNThRCCqOHwSDylvReyOES8Wqbq45n+E9w681WS8M
 surtnOXArXzV6f8FFL6WfUJm/Olq8YnUm11wtz0KnxMDW31c5bEa6iVwXh8EyMdOceBx
 Fa/B/GDPML1vgkZGIALKZbXUSLZasSPib0Z7FltlhzIZd59eBQZ5ogHIWPzEPkz91dnj Bg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qpqctt5uc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 21 May 2023 22:29:46 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34LMTjNt012022
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 21 May 2023 22:29:45 GMT
Received: from mmanikan-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Sun, 21 May 2023 15:29:38 -0700
From:   Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <jassisinghbrar@gmail.com>, <mathieu.poirier@linaro.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <quic_eberman@quicinc.com>, <quic_mojha@quicinc.com>,
        <kvalo@kernel.org>, <quic_mmanikan@quicinc.com>,
        <loic.poulain@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-clk@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_sjaganat@quicinc.com>,
        <quic_kathirav@quicinc.com>, <quic_anusha@quicinc.com>,
        <quic_poovendh@quicinc.com>, <quic_varada@quicinc.com>,
        <quic_devipriy@quicinc.com>
Subject: [PATCH V2 04/13] dt-bindings: clock: qcom: gcc-ipq5018: remove q6 clocks macros
Date:   Mon, 22 May 2023 03:58:43 +0530
Message-ID: <20230521222852.5740-5-quic_mmanikan@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230521222852.5740-1-quic_mmanikan@quicinc.com>
References: <20230521222852.5740-1-quic_mmanikan@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: SYTOSjVrT9cO1ripsdvKpxxAUVgbfqBO
X-Proofpoint-GUID: SYTOSjVrT9cO1ripsdvKpxxAUVgbfqBO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-21_17,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 suspectscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 mlxlogscore=999 clxscore=1015 lowpriorityscore=0 phishscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305210203
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since Q6 firmware takes care of bring up clocks in multipd
model, remove bring up clock macros.

Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
---
 include/dt-bindings/clock/qcom,gcc-ipq5018.h | 21 --------------------
 1 file changed, 21 deletions(-)

diff --git a/include/dt-bindings/clock/qcom,gcc-ipq5018.h b/include/dt-bindings/clock/qcom,gcc-ipq5018.h
index f3de2fdfeea1..89d81fa1a758 100644
--- a/include/dt-bindings/clock/qcom,gcc-ipq5018.h
+++ b/include/dt-bindings/clock/qcom,gcc-ipq5018.h
@@ -74,15 +74,8 @@
 #define GCC_PCIE1_AXI_S_CLK				65
 #define GCC_PCIE1_PIPE_CLK				66
 #define GCC_PRNG_AHB_CLK				67
-#define GCC_Q6_AXIM_CLK					68
-#define GCC_Q6_AXIM2_CLK				69
-#define GCC_Q6_AXIS_CLK					70
-#define GCC_Q6_AHB_CLK					71
-#define GCC_Q6_AHB_S_CLK				72
 #define GCC_Q6_TSCTR_1TO2_CLK				73
 #define GCC_Q6SS_ATBM_CLK				74
-#define GCC_Q6SS_PCLKDBG_CLK				75
-#define GCC_Q6SS_TRIG_CLK				76
 #define GCC_QDSS_AT_CLK					77
 #define GCC_QDSS_CFG_AHB_CLK				78
 #define GCC_QDSS_DAP_AHB_CLK				79
@@ -109,7 +102,6 @@
 #define GCC_SYS_NOC_PCIE1_AXI_CLK			100
 #define GCC_SYS_NOC_QDSS_STM_AXI_CLK			101
 #define GCC_SYS_NOC_USB0_AXI_CLK			102
-#define GCC_SYS_NOC_WCSS_AHB_CLK			103
 #define GCC_UBI0_AXI_CLK				104
 #define GCC_UBI0_CFG_CLK				105
 #define GCC_UBI0_CORE_CLK				106
@@ -127,19 +119,6 @@
 #define GCC_USB0_MOCK_UTMI_CLK				118
 #define GCC_USB0_PHY_CFG_AHB_CLK			119
 #define GCC_USB0_SLEEP_CLK				120
-#define GCC_WCSS_ACMT_CLK				121
-#define GCC_WCSS_AHB_S_CLK				122
-#define GCC_WCSS_AXI_M_CLK				123
-#define GCC_WCSS_AXI_S_CLK				124
-#define GCC_WCSS_DBG_IFC_APB_BDG_CLK			125
-#define GCC_WCSS_DBG_IFC_APB_CLK			126
-#define GCC_WCSS_DBG_IFC_ATB_BDG_CLK			127
-#define GCC_WCSS_DBG_IFC_ATB_CLK			128
-#define GCC_WCSS_DBG_IFC_DAPBUS_BDG_CLK			129
-#define GCC_WCSS_DBG_IFC_DAPBUS_CLK			130
-#define GCC_WCSS_DBG_IFC_NTS_BDG_CLK			131
-#define GCC_WCSS_DBG_IFC_NTS_CLK			132
-#define GCC_WCSS_ECAHB_CLK				133
 #define GCC_XO_CLK					134
 #define GCC_XO_CLK_SRC					135
 #define GMAC0_RX_CLK_SRC				136
--
2.17.1

