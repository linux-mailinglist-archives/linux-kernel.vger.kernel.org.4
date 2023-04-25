Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4A7F6EDE6D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 10:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233886AbjDYIpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 04:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233653AbjDYIog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 04:44:36 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD51913C20;
        Tue, 25 Apr 2023 01:42:28 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33P7eQt3001338;
        Tue, 25 Apr 2023 08:41:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=J5j8JAhXdtBBvEhQednQOiJuspjVH+cHG7OWzjTqa+Q=;
 b=Kx4/Szs0d2U+Hd82PNikXO3WmkNMybLGi/RwlVkSgFocufWgIDLRyHO0IKsOx33X58uY
 Nn45rwY4yoVdrC8uNAru+Xr05UMeO/Mw/lfCP8zwhcaRYyOdv9W5RWLAbcu/X8u8N/pJ
 zcIs/eaXPg7m7zhZSaBWrW2bAyeWwnnwoo5/F4LJWLnWFBWQHQ5HE8rVTTTqreJhYaZn
 iVyK/5vwDTVaaX8j7CL/ZKNA7HPx/ujUYit1Nx7HbZLj4Cylgw6lW3+eXj3CYiBvCVhS
 hPopVt3cczJEn1j9bvyAcS2WxeT3/FW3vNGi9zox1eqC1aTS409GgyQfj2h1xepb0Hkx jQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q5ndptxd4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Apr 2023 08:41:05 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33P8f4RC015695
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Apr 2023 08:41:04 GMT
Received: from devipriy-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Tue, 25 Apr 2023 01:40:57 -0700
From:   Devi Priya <quic_devipriy@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_sjaganat@quicinc.com>,
        <quic_kathirav@quicinc.com>, <quic_arajkuma@quicinc.com>,
        <quic_anusha@quicinc.com>, <quic_poovendh@quicinc.com>
Subject: [PATCH V3 5/6] arm64: dts: qcom: ipq9574: Drop bias_pll_ubi_nc_clk input
Date:   Tue, 25 Apr 2023 14:10:09 +0530
Message-ID: <20230425084010.15581-6-quic_devipriy@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230425084010.15581-1-quic_devipriy@quicinc.com>
References: <20230425084010.15581-1-quic_devipriy@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: PDFj2R8Oqhub-YvePjig4VHmGIphBDbx
X-Proofpoint-ORIG-GUID: PDFj2R8Oqhub-YvePjig4VHmGIphBDbx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-25_03,2023-04-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 adultscore=0 phishscore=0 impostorscore=0 spamscore=0 mlxlogscore=999
 mlxscore=0 bulkscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304250076
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop unused bias_pll_ubi_nc_clk input to the clock controller.

Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
---
 Changes in V3:
	- Added <0> entry in place of bias_pll_ubi_nc_clk as suggested by 
	  konrad to avoid ABI breakage.

 arch/arm64/boot/dts/qcom/ipq9574.dtsi | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
index 7e0a16d490f9..e2d934fe18c2 100644
--- a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
@@ -16,12 +16,6 @@
 	#size-cells = <2>;
 
 	clocks {
-		bias_pll_ubi_nc_clk: bias-pll-ubi-nc-clk {
-			compatible = "fixed-clock";
-			clock-frequency = <353000000>;
-			#clock-cells = <0>;
-		};
-
 		sleep_clk: sleep-clk {
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
@@ -131,7 +125,7 @@
 			reg = <0x01800000 0x80000>;
 			clocks = <&xo_board_clk>,
 				 <&sleep_clk>,
-				 <&bias_pll_ubi_nc_clk>,
+				 <0>,
 				 <0>,
 				 <0>,
 				 <0>,
-- 
2.17.1

