Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA4B473762C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 22:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbjFTUj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 16:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjFTUj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 16:39:26 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F02310F8;
        Tue, 20 Jun 2023 13:39:25 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35KKOOZ9029442;
        Tue, 20 Jun 2023 20:39:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=vjEUtfRMYEzg6ZBkM91Ygp6f+3k9ctL2YixmyIx8ZO4=;
 b=SLMi6kTuD1a8gHOKi7bXFFre3GB34l9LVN6g/mAydctz7q2G1Yr7jUbIWEJ69bPi04I2
 +giAw9Q7AYPrARsSae9oeWptiqZ5L+i/KtNBAv/O0pUg01E40uaTeiL3Jp7xYuIudFl6
 i7hKeZ2PZBKbkEyQcYiU4uTG6BNFaz8mowJN+8xM5bJunr/K8Vs5g2Y5Xfd3QnkBSoBm
 O8KSYtKS2j1TdSNhL+/mvW38BLzSfKarFJ29U4XFcmkl9T7Ln5OMFDmea+IOJ+ei9y7m
 xbO55SHWkVMDpD6eof6tv+/rkESXV5UzZ8bqOe46C/w3ykX4EgW/qqW/8WXDA2BoyHxz Iw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rb7susxxp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Jun 2023 20:39:21 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35KKdLCw019893
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Jun 2023 20:39:21 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Tue, 20 Jun 2023 13:39:20 -0700
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] arm64: dts: qcom: sc8280xp-crd: Fix naming of regulators
Date:   Tue, 20 Jun 2023 13:39:15 -0700
Message-ID: <20230620203915.141337-2-quic_bjorande@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230620203915.141337-1-quic_bjorande@quicinc.com>
References: <20230620203915.141337-1-quic_bjorande@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: -zaMcbFB0ndLlTJVhl3nv28ztf6gw4z5
X-Proofpoint-ORIG-GUID: -zaMcbFB0ndLlTJVhl3nv28ztf6gw4z5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-20_16,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 mlxscore=0 adultscore=0
 clxscore=1015 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2305260000 definitions=main-2306200187
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The external regulators in the CRD seems to have inherited their names
from the X13s DeviceTree, correct them.

Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sc8280xp-crd.dts | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
index b21b41a066b6..678cdf253f2e 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
@@ -133,7 +133,7 @@ vreg_edp_3p3: regulator-edp-3p3 {
 	vreg_edp_bl: regulator-edp-bl {
 		compatible = "regulator-fixed";
 
-		regulator-name = "VBL9";
+		regulator-name = "VREG_EDP_BL";
 		regulator-min-microvolt = <3600000>;
 		regulator-max-microvolt = <3600000>;
 
@@ -149,7 +149,7 @@ vreg_edp_bl: regulator-edp-bl {
 	vreg_nvme: regulator-nvme {
 		compatible = "regulator-fixed";
 
-		regulator-name = "VCC3_SSD";
+		regulator-name = "VREG_NVME_3P3";
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
 
@@ -163,7 +163,7 @@ vreg_nvme: regulator-nvme {
 	vreg_misc_3p3: regulator-misc-3p3 {
 		compatible = "regulator-fixed";
 
-		regulator-name = "VCC3B";
+		regulator-name = "VREG_MISC_3P3";
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
 
@@ -180,7 +180,7 @@ vreg_misc_3p3: regulator-misc-3p3 {
 	vreg_wlan: regulator-wlan {
 		compatible = "regulator-fixed";
 
-		regulator-name = "VCC_WLAN_3R9";
+		regulator-name = "VPH_PWR_WLAN";
 		regulator-min-microvolt = <3900000>;
 		regulator-max-microvolt = <3900000>;
 
@@ -196,7 +196,7 @@ vreg_wlan: regulator-wlan {
 	vreg_wwan: regulator-wwan {
 		compatible = "regulator-fixed";
 
-		regulator-name = "VCC3B_WAN";
+		regulator-name = "SDX_VPH_PWR";
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
 
-- 
2.25.1

