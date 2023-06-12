Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 653CD72D423
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 00:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238700AbjFLWHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 18:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238695AbjFLWHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 18:07:52 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D09E1;
        Mon, 12 Jun 2023 15:07:49 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35CM7kOH023457;
        Mon, 12 Jun 2023 22:07:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=mY5Z1R+ihDJ1EUKQDtJ6kfoM3Poq9FSIVUXa0+sgZsI=;
 b=MsEv+qTTnsd5tfoOdxzFIWJCOPDplAVOdApmZTKsV+6JEr7G2HWvKKldACu3DfX3EgIC
 7N3Ay0klDRYsK7AMnyoxrHbx05giLdbCN73++ziJmJ9jnJQHjhTuDRVIwzs77UugBIVV
 JQ/qt+iqwdnPgeJE3jMITLXU/9OAZUyAGh9HDkXxvBKUlI4ixuZ3unBC7upAJNBpt7fW
 X2BvsUscohiLswsPMvhEKfQBGsaGv1XD00ajgzPszTL2w3PnFNn1kB8FOw5UrWgppAbf
 85mMSGBPOPw6XZLj5/b4ZAKlZS1hID3g8J0WqXzyQnFWWyN8Bq1gTbzzcOkx6L0vajvY sg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r690q08v9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Jun 2023 22:07:46 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35CM7jW1009924
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Jun 2023 22:07:45 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Mon, 12 Jun 2023 15:07:44 -0700
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] arm64: dts: qcom: sc8180x: Move DisplayPort for MMCX
Date:   Mon, 12 Jun 2023 15:07:39 -0700
Message-ID: <20230612220739.1886155-1-quic_bjorande@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: dl10Il--uvBP_JB21t7GCvPeGWqGvsIw
X-Proofpoint-GUID: dl10Il--uvBP_JB21t7GCvPeGWqGvsIw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-12_16,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=999 priorityscore=1501 spamscore=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 bulkscore=0 adultscore=0 phishscore=0
 malwarescore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306120190
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DisplayPort blocks are powered by MMCX and should be described as
such to ensure that power votes are done on the right resource.

This also solves the problem that sync_state is unaware of the DP
controllers needing MMCX to be kept alive during boot. As such this
change also fixes occasionally seen crashes during boot due to
undervoltage of MMCX.

Fixes: 494dec9b6f54 ("arm64: dts: qcom: sc8180x: Add display and gpu nodes")
Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sc8180x.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8180x.dtsi b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
index 3de62e26d56a..a7668f9e68d6 100644
--- a/arch/arm64/boot/dts/qcom/sc8180x.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
@@ -2969,7 +2969,7 @@ mdss_dp0: displayport-controller@ae90000 {
 				#sound-dai-cells = <0>;
 
 				operating-points-v2 = <&dp0_opp_table>;
-				power-domains = <&rpmhpd SC8180X_CX>;
+				power-domains = <&rpmhpd SC8180X_MMCX>;
 
 				status = "disabled";
 
@@ -3043,7 +3043,7 @@ mdss_dp1: displayport-controller@ae98000 {
 				#sound-dai-cells = <0>;
 
 				operating-points-v2 = <&dp0_opp_table>;
-				power-domains = <&rpmhpd SC8180X_CX>;
+				power-domains = <&rpmhpd SC8180X_MMCX>;
 
 				status = "disabled";
 
@@ -3117,7 +3117,7 @@ mdss_edp: displayport-controller@ae9a000 {
 				#sound-dai-cells = <0>;
 
 				operating-points-v2 = <&edp_opp_table>;
-				power-domains = <&rpmhpd SC8180X_CX>;
+				power-domains = <&rpmhpd SC8180X_MMCX>;
 
 				status = "disabled";
 
-- 
2.25.1

