Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A359D64BFB3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 23:57:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236704AbiLMW4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 17:56:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235771AbiLMW4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 17:56:45 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 585A72036B;
        Tue, 13 Dec 2022 14:56:44 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BDLNKak018733;
        Tue, 13 Dec 2022 22:56:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=h94kDyc/sjsy4hylXHIzVUHaf53tbZxG47UNUzIC/gI=;
 b=c9QPPYAJWjwjS+ESNXILQC5yW14HZoAtch/SJWne4crsrYeVNzYyJPq15z13JZvPFDC1
 x0o2w1BER5DgihhXmVdtBsNk2ixeFMJSvQhEteUlW7uAbbsoztWoRoZselKYqkhDw48u
 tEio208HjTbi85HomD0yy9ohknD2QaVRm/L/+Ad/cKz4ZDyaI61n9T5J8txz642l8Kqu
 uN/3kG0dfwQxsKY6KA8NrCl5SFBH8AnOY9zl6Ky6xh1z/2SbRkSufqTMuMrUD/wKgrOe
 URnoUZ3iqLgoVxYoYMyPlmx7EbbzppQB0JZlDKlERaQdQgE+rS1ODPHyEpaFTA+k3gj5 Sg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3meyf7rg23-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Dec 2022 22:56:36 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BDMua2Y032726
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Dec 2022 22:56:36 GMT
Received: from khsieh-linux1.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 13 Dec 2022 14:56:35 -0800
From:   Kuogee Hsieh <quic_khsieh@quicinc.com>
To:     <dri-devel@lists.freedesktop.org>, <robdclark@gmail.com>,
        <sean@poorly.run>, <swboyd@chromium.org>, <dianders@chromium.org>,
        <vkoul@kernel.org>, <daniel@ffwll.ch>, <agross@kernel.org>,
        <dmitry.baryshkov@linaro.org>, <andersson@kernel.org>,
        <konrad.dybcio@somainline.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <devicetree@vger.kernel.org>,
        <airlied@gmail.com>
CC:     Kuogee Hsieh <quic_khsieh@quicinc.com>,
        <quic_abhinavk@quicinc.com>, <quic_sbillaka@quicinc.com>,
        <freedreno@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v13 1/5] arm64: dts: qcom: add data-lanes and link-freuencies into dp_out endpoint
Date:   Tue, 13 Dec 2022 14:56:17 -0800
Message-ID: <1670972181-4961-2-git-send-email-quic_khsieh@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1670972181-4961-1-git-send-email-quic_khsieh@quicinc.com>
References: <1670972181-4961-1-git-send-email-quic_khsieh@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: GYUo8lz6WM2CxI-znktgg7mt4zEWafvt
X-Proofpoint-ORIG-GUID: GYUo8lz6WM2CxI-znktgg7mt4zEWafvt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-13_03,2022-12-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 phishscore=0 mlxlogscore=999 impostorscore=0 suspectscore=0
 mlxscore=0 bulkscore=0 spamscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212130199
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move data-lanes property from mdss_dp node to dp_out endpoint. Also
add link-frequencies property into dp_out endpoint as well. The last
frequency specified at link-frequencies will be the max link rate
supported by DP.

Changes in v5:
-- revert changes at sc7180.dtsi and sc7280.dtsi
-- add &dp_out to sc7180-trogdor.dtsi and sc7280-herobrine.dtsi

Changes in v6:
-- add data-lanes and link-frequencies to yaml

Changes in v7:
-- change 160000000 to 1620000000
-- separate yaml to different patch

Changes in v8:
-- correct Bjorn mail address to kernel.org

Changes in v9:
-- use symbol rate (hz) for link-frequencies at dp_out at sc7180_trogdor.dtsi

Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi   | 6 +++++-
 arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi | 6 +++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
index eae22e6..93b0cde 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
@@ -814,7 +814,11 @@ hp_i2c: &i2c9 {
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&dp_hot_plug_det>;
-	data-lanes = <0 1>;
+};
+
+&dp_out {
+    data-lanes = <0  1>;
+    link-frequencies = /bits/ 64 <1620000000 2700000000 5400000000>;
 };
 
 &pm6150_adc {
diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
index c11e371..3c7a9d8 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
@@ -442,7 +442,11 @@ ap_i2c_tpm: &i2c14 {
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&dp_hot_plug_det>;
-	data-lanes = <0 1>;
+};
+
+&dp_out {
+	data-lanes = <0  1>;
+	link-frequencies = /bits/ 64 <1620000000 2700000000 5400000000 8100000000>;
 };
 
 &mdss_mdp {
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

