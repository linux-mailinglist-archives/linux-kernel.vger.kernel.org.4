Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D921E747C92
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 07:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbjGEFks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 01:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbjGEFko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 01:40:44 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08CFAE7B;
        Tue,  4 Jul 2023 22:40:43 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3655MGHT020214;
        Wed, 5 Jul 2023 05:40:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=DBUCHIImMscDsnUUCsVgxa65R40ZGDgdgGftaFAsJPs=;
 b=JPoTSUM+A7uJp1qsh6NFjBdSEmWLT+M1pbBrVA9/BX2CIRS5OnlJWxaKXHhCdVBTTFgo
 hFI+D8gYx4lqByBTEk+xs7gJ6qR7fN4IeTNgfQLMJrQrbYCBFZGDCFwrCV0sgpnYYZDV
 B4wmT57uv8fyQE+Tfz7bAiJ+FC6afDAWGP2w4nF5sfkxU3UJsPGxMRGS+7pAmavVjJe3
 sqfqsK1WjQ32ZcwSkeMkt6MkDVAzGfhuE8oEYaFxmJspuR/1yvObevvwpHXE2/vms4qO
 1T448pKIOLcMOXZWNsbw/2TSxTvg+JCdl+1lrU03ucVlgiCEWskJm7XKjZZ1Ng3yEbY6 Jw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rn152g4df-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Jul 2023 05:40:40 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3655ed9m024790
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 5 Jul 2023 05:40:39 GMT
Received: from hu-kbajaj-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.7; Tue, 4 Jul 2023 22:40:36 -0700
From:   Komal Bajaj <quic_kbajaj@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Komal Bajaj <quic_kbajaj@quicinc.com>
Subject: [PATCH 2/2] arm64: dts: qcom: qru1000-idp: Update reserved memory region
Date:   Wed, 5 Jul 2023 11:09:14 +0530
Message-ID: <20230705053914.9759-3-quic_kbajaj@quicinc.com>
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
X-Proofpoint-GUID: LJ0OS_9esvq-GzxiXnMGYJqQoIqgp7bW
X-Proofpoint-ORIG-GUID: LJ0OS_9esvq-GzxiXnMGYJqQoIqgp7bW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-04_16,2023-07-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 phishscore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 mlxscore=0 malwarescore=0 clxscore=1015 mlxlogscore=669
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307050051
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing reserved regions as described in QRU1000 memory map.

Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
---
 arch/arm64/boot/dts/qcom/qru1000-idp.dts | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qru1000-idp.dts b/arch/arm64/boot/dts/qcom/qru1000-idp.dts
index 2cc893ae4d10..836804020946 100644
--- a/arch/arm64/boot/dts/qcom/qru1000-idp.dts
+++ b/arch/arm64/boot/dts/qcom/qru1000-idp.dts
@@ -448,6 +448,22 @@ &qupv3_id_0 {
 	status = "okay";
 };

+&reserved_memory {
+	#address-cells = <2>;
+	#size-cells = <2>;
+	ranges;
+
+	ecc_meta_data_reserved_mem: ecc_meta_data_reserved_region@f0000000 {
+		no-map;
+		reg = <0x0 0xf0000000 0x0 0x10000000>;
+	};
+
+	tenx_sp_mem: tenx_sp_region@800000000 {
+		no-map;
+		reg = <0x8 0x0 0x0 0x80000000>;
+	};
+};
+
 &uart7 {
 	status = "okay";
 };
--
2.40.1

