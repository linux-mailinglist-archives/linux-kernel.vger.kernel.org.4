Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A078C7173E6
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 04:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233907AbjEaCt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 22:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231417AbjEaCt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 22:49:56 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D9498E;
        Tue, 30 May 2023 19:49:55 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34V2PcGS013603;
        Wed, 31 May 2023 02:49:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=DrIz8g9inIqB+//ujGYX739blh73k61Xr2sN/fXVZVY=;
 b=GE8dzKX60xY0A9OBhibUScixE1D8EV47mF25Tptw0rfh0syvTCOhjSqPTLmXSKxaXTXh
 qSXIp+juCiSdpQrtz/71C3438QS5mvQI6ebwI+DxbzBBvMcqOSrGwZXAU4mVKWGNMk4X
 i1b3oS2M39Cru0SCjN5gkRPiuibO1lco4+Jh9lr2wucnHUAP92GXVgW5Bv/b32leCPbD
 FraF7vNXq3EYChvCaj9aCV5dIjGzo3lLOtB7/iKeq8BjrjRe6npT4iFkx9XWGkQeLnDu
 NsVYaERjq/jSM/sWnSowm36zAT8B2S3b08ko/UKYyPj4LRVyssflMG/4eWiYU7fm7iXT lQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qwnhf0wc8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 May 2023 02:49:51 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34V2no6p032194
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 May 2023 02:49:50 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Tue, 30 May 2023 19:49:49 -0700
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] arm64: dts: qcom: Drop undocumented "svid" property
Date:   Tue, 30 May 2023 19:49:44 -0700
Message-ID: <20230531024944.4105769-1-quic_bjorande@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 8Y4ayMeJuLNo7Aj92VP70A9badBj2Uky
X-Proofpoint-GUID: 8Y4ayMeJuLNo7Aj92VP70A9badBj2Uky
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-30_18,2023-05-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 malwarescore=0 mlxlogscore=650 mlxscore=0
 priorityscore=1501 bulkscore=0 adultscore=0 spamscore=0 clxscore=1015
 phishscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2304280000 definitions=main-2305310021
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Linux typec_mux implementation required that a property named "svid"
was present in the remote node of the of_graph for a match to be found.

With the introduction of commit '4aebc4f89f00 ("usb: typec: mux: Clean up
mux_fwnode_match()")', the implementation is aligned with the binding
and this property can be dropped - and the associated DeviceTree
validation warning resolved.

Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---

The referred to patch is present in usb-next.

 arch/arm64/boot/dts/qcom/sc8280xp-crd.dts                  | 2 --
 arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts | 2 --
 arch/arm64/boot/dts/qcom/sm8350-hdk.dts                    | 1 -
 arch/arm64/boot/dts/qcom/sm8450-hdk.dts                    | 1 -
 4 files changed, 6 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
index cd7e0097d8bc..4594ef4c1f38 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
@@ -229,7 +229,6 @@ usb0-sbu-mux {
 
 		mode-switch;
 		orientation-switch;
-		svid = /bits/ 16 <0xff01>;
 
 		port {
 			usb0_sbu_mux: endpoint {
@@ -249,7 +248,6 @@ usb1-sbu-mux {
 
 		mode-switch;
 		orientation-switch;
-		svid = /bits/ 16 <0xff01>;
 
 		port {
 			usb1_sbu_mux: endpoint {
diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
index 5ae057ad6438..a93170e57229 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
@@ -329,7 +329,6 @@ usb0-sbu-mux {
 
 		mode-switch;
 		orientation-switch;
-		svid = /bits/ 16 <0xff01>;
 
 		port {
 			usb0_sbu_mux: endpoint {
@@ -349,7 +348,6 @@ usb1-sbu-mux {
 
 		mode-switch;
 		orientation-switch;
-		svid = /bits/ 16 <0xff01>;
 
 		port {
 			usb1_sbu_mux: endpoint {
diff --git a/arch/arm64/boot/dts/qcom/sm8350-hdk.dts b/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
index d3788bd72ac3..0c4829e876f3 100644
--- a/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
+++ b/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
@@ -348,7 +348,6 @@ typec-mux@42 {
 		vcc-supply = <&vreg_bob>;
 		mode-switch;
 		orientation-switch;
-		svid = /bits/ 16 <0xff01>;
 
 		ports {
 			#address-cells = <1>;
diff --git a/arch/arm64/boot/dts/qcom/sm8450-hdk.dts b/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
index d5aeb7319776..c9676e7f2c69 100644
--- a/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
+++ b/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
@@ -517,7 +517,6 @@ typec-mux@42 {
 		vcc-supply = <&vreg_bob>;
 		mode-switch;
 		orientation-switch;
-		svid = /bits/ 16 <0xff01>;
 
 		ports {
 			#address-cells = <1>;
-- 
2.25.1

