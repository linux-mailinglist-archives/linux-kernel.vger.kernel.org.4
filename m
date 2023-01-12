Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36E1366738F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 14:51:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbjALNvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 08:51:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232277AbjALNvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 08:51:12 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA8E48CE8;
        Thu, 12 Jan 2023 05:51:11 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30CBUk4S005946;
        Thu, 12 Jan 2023 13:51:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=GWcgX7wro4WH+QvKYlhCgbkIZhVUk8U7As6tF7aDP14=;
 b=K8Nl4+BKPuJiYd5HEmS8baG+8x4Je66RwRTiWvMK0nNy03S2g21VQPQpkd4qtYJJmfWs
 FjpPrBwx+QLH3HimNE7p85JWbPxcRUhn0VMSy0jsAqiJHYVF52YRkBaH7aTTU4yOxm6j
 f/l/WSGKY18AaCi0C4oBKOY9y5eTAcz7p1wYQzNsJvZ53KaT9VP9xldkVw/WZ8J2aGjB
 jdbwzSVnouA/EMMLYDhf/lTylP1KcP5WEiMkz7QMYAlPhfJAOSyTkA5qBiwvahZOaxGO
 tlyAoJVfJYg8kit9IFtK0qyyuPZos89n2HLv1EER+lV1rTKwW9VlSHde513rhmDhL+3W RA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n2edurrvs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Jan 2023 13:51:08 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30CDp1ZK009450
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Jan 2023 13:51:01 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Thu, 12 Jan 2023 05:51:01 -0800
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH] arm64: dts: qcom: sc8280xp: Use MMCX for all DP controllers
Date:   Thu, 12 Jan 2023 05:50:55 -0800
Message-ID: <20230112135055.3836555-1-quic_bjorande@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: IC-zvcfGofhwhHGTeEnz9xcAZw2vItMQ
X-Proofpoint-ORIG-GUID: IC-zvcfGofhwhHGTeEnz9xcAZw2vItMQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-12_08,2023-01-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 clxscore=1011 adultscore=0
 bulkscore=0 impostorscore=0 spamscore=0 suspectscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301120100
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While MDSS_GDSC is a subdomain of MMCX, Linux does not respect this
relationship and sometimes invokes sync_state on the rpmhpd (MMCX)
before the DisplayPort controller has had a chance to probe.

The result when this happens is that the power is lost to the multimedia
subsystem between the probe of msm_drv and the DisplayPort controller -
which results in an irrecoverable state.

While this is an implementation problem, this aligns the power domain
setting of the one DP instance with that of all the others.

Fixes: 57d6ef683a15 ("arm64: dts: qcom: sc8280xp: Define some of the display blocks")
Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index 4f4353f84cba..4511fd939c91 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -2533,7 +2533,7 @@ mdss0_dp3: displayport-controller@aea0000 {
 				interrupts = <15>;
 				phys = <&mdss0_dp3_phy>;
 				phy-names = "dp";
-				power-domains = <&dispcc0 MDSS_GDSC>;
+				power-domains = <&rpmhpd SC8280XP_MMCX>;
 
 				assigned-clocks = <&dispcc0 DISP_CC_MDSS_DPTX3_LINK_CLK_SRC>,
 						  <&dispcc0 DISP_CC_MDSS_DPTX3_PIXEL0_CLK_SRC>;
-- 
2.37.3

