Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29C19749CB6
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 14:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232479AbjGFMwk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 08:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232290AbjGFMwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 08:52:37 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 559A81FE7;
        Thu,  6 Jul 2023 05:52:14 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 366BXia5003080;
        Thu, 6 Jul 2023 12:52:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=VBXJg+Ogv1lZ3IYs8c3HbOcVfc/GcXOHPo71Sc/Z3BE=;
 b=itMGt7j7be8WJwJpYNg3X/tfroQMlWSfuSiHUugBTSqX9Cks2Ubop6nkmQZNSBYj2wBn
 kbpKTJdDwxJZuRHpLozTAfXH2dbg4Z39GWsUNixPRbdatnkZX3NVZX2usU2YDRVAHejN
 RWA86sTckZR+dUgH70EBaIS8w8gscFwpYs9JVw7IU1fdisq22mSkBW5EUDkH/Vt2m9I1
 8KX1IiAEKBipOXXBYw2MZh8OSqdjxEYUdHPaL+olDqw8ylicL/YawfpkN7eU4yaiLMbo
 zjGt9aVWhhwBgC+9WHkP5e/MZpoBky8mkPqDWv5CTQWfFiepZ3yHGyzKC/OWxjoaaI6P Sw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rnsu70f5k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Jul 2023 12:52:03 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 366Cq2g0022423
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 6 Jul 2023 12:52:02 GMT
Received: from hu-kbajaj-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 6 Jul 2023 05:51:58 -0700
From:   Komal Bajaj <quic_kbajaj@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Komal Bajaj <quic_kbajaj@quicinc.com>
Subject: [PATCH v3 1/2] arm64: dts: qcom: qdu1000-idp: Update reserved memory region
Date:   Thu, 6 Jul 2023 18:21:28 +0530
Message-ID: <20230706125129.20969-2-quic_kbajaj@quicinc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230706125129.20969-1-quic_kbajaj@quicinc.com>
References: <20230706125129.20969-1-quic_kbajaj@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: lAuTdgNdBPwhnzvoxKRUGpGuRlG__bZi
X-Proofpoint-ORIG-GUID: lAuTdgNdBPwhnzvoxKRUGpGuRlG__bZi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-06_09,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=715
 adultscore=0 bulkscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 spamscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307060115
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing reserved regions as described in QDU1000 memory map.

Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
---
 arch/arm64/boot/dts/qcom/qdu1000-idp.dts | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qdu1000-idp.dts b/arch/arm64/boot/dts/qcom/qdu1000-idp.dts
index 1d22f87fd238..8446eb438a34 100644
--- a/arch/arm64/boot/dts/qcom/qdu1000-idp.dts
+++ b/arch/arm64/boot/dts/qcom/qdu1000-idp.dts
@@ -448,6 +448,28 @@ &qupv3_id_0 {
 	status = "okay";
 };

+&reserved_memory {
+	ecc_meta_data_mem: ecc-meta-data@e0000000 {
+		reg = <0x0 0xe0000000 0x0 0x20000000>;
+		no-map;
+	};
+
+	harq_buffer_mem: harq-buffer@800000000 {
+		reg = <0x8 0x0 0x0 0x80000000>;
+		no-map;
+	};
+
+	tenx_sp_buffer_mem: tenx-sp-buffer@880000000 {
+		reg = <0x8 0x80000000 0x0 0x50000000>;
+		no-map;
+	};
+
+	fapi_buffer_mem: fapi-buffer@8d0000000 {
+		reg = <0x8 0xd0000000 0x0 0x20000000>;
+		no-map;
+	};
+};
+
 &sdhc {
 	pinctrl-0 = <&sdc_on_state>;
 	pinctrl-1 = <&sdc_off_state>;
--
2.40.1

