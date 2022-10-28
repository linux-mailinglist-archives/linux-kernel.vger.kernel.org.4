Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1727E6108FB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 05:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236340AbiJ1Dmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 23:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236040AbiJ1DmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 23:42:17 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B42D9D18C3;
        Thu, 27 Oct 2022 20:42:16 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29S2Y8k3018103;
        Fri, 28 Oct 2022 03:42:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=H3IiDcxNcmeVkbj/gkkfb82ZpzTE2PRvGEsi7tXavzM=;
 b=SHzQ8VwjR//xsgcb1oiW1Vzr3BmVENSA/Mjh3wlBdpyPBZB+LsZxS1bqJs39FsQWJUag
 GohiuILP2Szy2y0WBWZd2gRE8hGQn91kXMjrDP8SkHGd12S3U8d6KlB2bTQ2fTzJQuKE
 2kzHg4pXI+YxsSp6WJQMm/La0LUqy3z9kdRVQvMH9gmk0ynf4JYzoUjflcPYRm3S2AMf
 b/L1DsUHIMkcQT6wvMpMFpeUKzYGqnVtlh14a7ltFceZCmKjibwQEj9Ym5owcaXiMo2W
 asJIRO8xgoLlkLaoKzwHefCN2T5p1lc0/pPO7odoKKVFhR0Iiy1JxDhQix5yPuxIVxe/ KA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kfaj1bwfm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Oct 2022 03:42:05 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29S3g4Sw009930
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Oct 2022 03:42:04 GMT
Received: from th-lint-050.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Thu, 27 Oct 2022 20:42:04 -0700
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
Subject: [PATCH 06/10] arm64: dts: qcom: Align with generic osm-l3/epss-l3
Date:   Thu, 27 Oct 2022 20:41:51 -0700
Message-ID: <20221028034155.5580-7-quic_bjorande@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221028034155.5580-1-quic_bjorande@quicinc.com>
References: <20221028034155.5580-1-quic_bjorande@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: aWwSxdAIgR6zcX5lsRP6uXick-EMUyLY
X-Proofpoint-ORIG-GUID: aWwSxdAIgR6zcX5lsRP6uXick-EMUyLY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-27_07,2022-10-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 suspectscore=0 adultscore=0 bulkscore=0 mlxlogscore=845 lowpriorityscore=0
 phishscore=0 clxscore=1015 malwarescore=0 impostorscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2210280022
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update all references to OSM or EPSS L3 compatibles, to include the
generic compatible, as defined by the updated binding.

Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sc7180.dtsi | 2 +-
 arch/arm64/boot/dts/qcom/sc7280.dtsi | 2 +-
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 2 +-
 arch/arm64/boot/dts/qcom/sm8150.dtsi | 2 +-
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index f1482675610a..a6542b4d5bf5 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -3525,7 +3525,7 @@ apps_bcm_voter: bcm-voter {
 		};
 
 		osm_l3: interconnect@18321000 {
-			compatible = "qcom,sc7180-osm-l3";
+			compatible = "qcom,sc7180-osm-l3", "qcom,osm-l3";
 			reg = <0 0x18321000 0 0x1400>;
 
 			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GPLL0>;
diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 748eef6f5281..43da98f1ad98 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -5348,7 +5348,7 @@ rpmhcc: clock-controller {
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
@@ -5302,7 +5302,7 @@ frame@17d10000 {
 		};
 
 		osm_l3: interconnect@17d41000 {
-			compatible = "qcom,sdm845-osm-l3";
+			compatible = "qcom,sdm845-osm-l3", "qcom,osm-l3";
 			reg = <0 0x17d41000 0 0x1400>;
 
 			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GPLL0>;
diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index 5fa575e4425a..fe1abf9cb0ff 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -3958,7 +3958,7 @@ apps_bcm_voter: bcm-voter {
 		};
 
 		osm_l3: interconnect@18321000 {
-			compatible = "qcom,sm8150-osm-l3";
+			compatible = "qcom,sm8150-osm-l3", "qcom,osm-l3";
 			reg = <0 0x18321000 0 0x1400>;
 
 			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GPLL0>;
diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index eb5a10cbcd71..1b88da7be921 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -4885,7 +4885,7 @@ apps_bcm_voter: bcm-voter {
 		};
 
 		epss_l3: interconnect@18590000 {
-			compatible = "qcom,sm8250-epss-l3";
+			compatible = "qcom,sm8250-epss-l3", "qcom,epss-l3";
 			reg = <0 0x18590000 0 0x1000>;
 
 			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GPLL0>;
-- 
2.37.3

