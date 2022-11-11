Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8467D6251A0
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 04:27:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232999AbiKKD0P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 22:26:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232431AbiKKDZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 22:25:37 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CACE85B5AD;
        Thu, 10 Nov 2022 19:25:35 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AB2skcL032608;
        Fri, 11 Nov 2022 03:25:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=z5frpm/ISY1/dDKvfQ5rmMpPUkbAUIx93wq2BLbBdl8=;
 b=Cfs/a7mbLyeN25ef54lKavp3Ox1FL/l24+bQ+PtogN0r2Ml3qazjrGm4ENSXsl2MCr8J
 B1EAzzlscvxihXftAdOhJA7ZlS37BPufRmYF5BgQN7sysURoWHoSyEhtLx5fLc7RgrYs
 ZZBlmcEvmmzJJmNJAj43N150e1wQG/oiw8mv/+CDQFqCm4MbTGYhpiXfi/Rq2ppwNQCK
 /KRMR3hp0GxMvFNxOpLsKoBLeTKMKx4XyRrnEq6DiQezGjrqCELamzSctfGjXkWM7EGO
 khhIsOnKs9qPrKax5EXdjWflxepDI7YtuXNGoTRdiruw9phv5ODMF5sRHeoxBEzfwt0B 0Q== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ksantrf0j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Nov 2022 03:25:24 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2AB3PO5d014391
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Nov 2022 03:25:24 GMT
Received: from th-lint-050.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Thu, 10 Nov 2022 19:25:23 -0800
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Sibi Sankar <quic_sibis@quicinc.com>
CC:     Georgi Djakov <djakov@kernel.org>,
        Mike Tipton <quic_mdtipton@quicinc.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 06/10] arm64: dts: qcom: Align with generic osm-l3/epss-l3
Date:   Thu, 10 Nov 2022 19:25:11 -0800
Message-ID: <20221111032515.3460-7-quic_bjorande@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221111032515.3460-1-quic_bjorande@quicinc.com>
References: <20221111032515.3460-1-quic_bjorande@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: pItXTgrdchAgqbcPUkENB_H18CgyHzRy
X-Proofpoint-ORIG-GUID: pItXTgrdchAgqbcPUkENB_H18CgyHzRy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-10_14,2022-11-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 spamscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 adultscore=0 clxscore=1015 mlxlogscore=848
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211110021
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update all references to OSM or EPSS L3 compatibles, to include the
generic compatible, as defined by the updated binding.

Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
Tested-by: Steev Klimaszewski <steev@kali.org>
---

Changes since v1:
- None

 arch/arm64/boot/dts/qcom/sc7180.dtsi | 2 +-
 arch/arm64/boot/dts/qcom/sc7280.dtsi | 2 +-
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 2 +-
 arch/arm64/boot/dts/qcom/sm8150.dtsi | 2 +-
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index ea886cf08b4d..f71cf21a8dd8 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -3558,7 +3558,7 @@
 		};
 
 		osm_l3: interconnect@18321000 {
-			compatible = "qcom,sc7180-osm-l3";
+			compatible = "qcom,sc7180-osm-l3", "qcom,osm-l3";
 			reg = <0 0x18321000 0 0x1400>;
 
 			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GPLL0>;
diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 07334e19be99..ad9c61768016 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -5359,7 +5359,7 @@
 		};
 
 		epss_l3: interconnect@18590000 {
-			compatible = "qcom,sc7280-epss-l3";
+			compatible = "qcom,sc7280-epss-l3", "qcom,epss-l3";
 			reg = <0 0x18590000 0 0x1000>;
 			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GCC_GPLL0>;
 			clock-names = "xo", "alternate";
diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 1a257f672887..9c7d484ce72f 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -5302,7 +5302,7 @@
 		};
 
 		osm_l3: interconnect@17d41000 {
-			compatible = "qcom,sdm845-osm-l3";
+			compatible = "qcom,sdm845-osm-l3", "qcom,osm-l3";
 			reg = <0 0x17d41000 0 0x1400>;
 
 			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GPLL0>;
diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index 18bf51ce8b13..8409fb5ea532 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -3958,7 +3958,7 @@
 		};
 
 		osm_l3: interconnect@18321000 {
-			compatible = "qcom,sm8150-osm-l3";
+			compatible = "qcom,sm8150-osm-l3", "qcom,osm-l3";
 			reg = <0 0x18321000 0 0x1400>;
 
 			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GPLL0>;
diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index 27b507f3632b..351c232b8dc6 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -4884,7 +4884,7 @@
 		};
 
 		epss_l3: interconnect@18590000 {
-			compatible = "qcom,sm8250-epss-l3";
+			compatible = "qcom,sm8250-epss-l3", "qcom,epss-l3";
 			reg = <0 0x18590000 0 0x1000>;
 
 			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GPLL0>;
-- 
2.17.1

