Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50CFA747C91
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 07:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbjGEFkp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 01:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjGEFkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 01:40:43 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F407134;
        Tue,  4 Jul 2023 22:40:42 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3654sTMU024093;
        Wed, 5 Jul 2023 05:40:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=FzqulshdNgSmcpqlgDmtEO55P9Ahcv6wigFia9ZAxFo=;
 b=FzztOhAFuLdU09Yc0yttMzqdf/qLCbxoG6mK8/pyf8iszQT5Xfj7/Bg5J/RtCCHPOM/m
 pkb7PuNf0K+OU0mXy1/eWT7CViuavALsHM03n0cDqDGqdD6P54H5ZWP9A2UN3T4ZLfwA
 +TH6bHBgKhmTQSigQstLsEGR2fiaeg7Ca07lwNsy66YyNy3QZRLzeLZOQmWFGT4Zt6wF
 yE0wnMQaSLH8dLNgP0f5iwcvr3ibwsHsMQxIULBAqftpO3z0vBeCTO5PnH+0mpnZMJHF
 jRd5gzyD2Z4lTdUhQUGgNsV/6d1in5dRvl/QHRqUsQMk5kMHsjZ5HhUUH2/gACGhxiYM lw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rm8v9jy3j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Jul 2023 05:40:35 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3655eXov008496
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 5 Jul 2023 05:40:33 GMT
Received: from hu-kbajaj-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.7; Tue, 4 Jul 2023 22:40:30 -0700
From:   Komal Bajaj <quic_kbajaj@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Komal Bajaj <quic_kbajaj@quicinc.com>
Subject: [PATCH 1/2] arm64: dts: qcom: qdu1000-idp: Update reserved memory region
Date:   Wed, 5 Jul 2023 11:09:13 +0530
Message-ID: <20230705053914.9759-2-quic_kbajaj@quicinc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230705053914.9759-1-quic_kbajaj@quicinc.com>
References: <20230705053914.9759-1-quic_kbajaj@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: RGYdrlXV52_8-G9oWk0V9zsQdRGjcEfU
X-Proofpoint-GUID: RGYdrlXV52_8-G9oWk0V9zsQdRGjcEfU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-04_16,2023-07-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 mlxlogscore=759 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0
 spamscore=0 lowpriorityscore=0 mlxscore=0 priorityscore=1501 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307050051
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing reserved regions as described in QDU1000 memory map.

Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
---
 arch/arm64/boot/dts/qcom/qdu1000-idp.dts | 26 ++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qdu1000-idp.dts b/arch/arm64/boot/dts/qcom/qdu1000-idp.dts
index 1d22f87fd238..3f5512ec0a90 100644
--- a/arch/arm64/boot/dts/qcom/qdu1000-idp.dts
+++ b/arch/arm64/boot/dts/qcom/qdu1000-idp.dts
@@ -448,6 +448,32 @@ &qupv3_id_0 {
 	status = "okay";
 };

+&reserved_memory{
+	#address-cells = <2>;
+	#size-cells = <2>;
+	ranges;
+
+	ecc_meta_data_reserved_mem:ecc_meta_data_reserved_region@e0000000{
+		no-map;
+		reg = <0x0 0xe0000000 0x0 0x20000000>;
+	};
+
+	harq_buffer_mem:harq_buffer_region@800000000{
+		no-map;
+		reg = <0x8 0x0 0x0 0x80000000>;
+	};
+
+	tenx_sp_buffer_mem:tenx_sp_buffer_region@880000000{
+		no-map;
+		reg = <0x8 0x80000000 0x0 0x50000000>;
+	};
+
+	fapi_buffer_mem:fapi_buffer_region@8d0000000{
+		no-map;
+		reg = <0x8 0xd0000000 0x0 0x20000000>;
+	};
+};
+
 &sdhc {
 	pinctrl-0 = <&sdc_on_state>;
 	pinctrl-1 = <&sdc_off_state>;
--
2.40.1

