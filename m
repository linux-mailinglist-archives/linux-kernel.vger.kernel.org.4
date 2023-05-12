Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05243700796
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 14:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240770AbjELMV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 08:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240338AbjELMVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 08:21:54 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FD5F49C0;
        Fri, 12 May 2023 05:21:53 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34CB6qJP006138;
        Fri, 12 May 2023 12:21:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=9Vtvs1JWI9CpOzCswjfVnNlHyj8mCePBW8JfsjPO7yU=;
 b=YOAiwtJBsrGxsG8sjHDtigy0CfCgoEHlgcknMSGnOO3sPqlAbPsJkPsTflyBgWvyNL1F
 snZEIbR3NKmbFcOcy8GV3moWQCQA8/lGpM7inYOgFRHxVFaCVdwsWHLwnEdv48ucUQs5
 KDLnttIyJyRM+hlAXyKWtRoOzsAIGog7HPlIHIgwHbj/0Zf3oBiVwmAa2sCM92mOuDHO
 2CQQrkHCfa/yrKqdRvsOufEmWqjKEGxgA6aBzuoR48UeBH2eEenuF9VZMNWolW22I/8W
 jcnQPnjTWREJxFcBe/P+WiCAKisLXorLRFHZBDLw3GDfBHTBV/NUt/hYq9jmT8qD1VkJ OQ== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qhdf412hg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 May 2023 12:21:50 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 34CCLl6T029029;
        Fri, 12 May 2023 12:21:47 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3qdy59u1uy-1;
        Fri, 12 May 2023 12:21:47 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34CCLlHo029024;
        Fri, 12 May 2023 12:21:47 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-kbajaj-hyd.qualcomm.com [10.147.247.189])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 34CCLk4F029023;
        Fri, 12 May 2023 12:21:47 +0000
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 2340697)
        id 639B952974D; Fri, 12 May 2023 17:51:46 +0530 (+0530)
From:   Komal Bajaj <quic_kbajaj@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Komal Bajaj <quic_kbajaj@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v3 03/10] arm64: dts: qcom: qdu1000: Add properties to qfprom for multi channel DDR
Date:   Fri, 12 May 2023 17:51:27 +0530
Message-Id: <20230512122134.24339-4-quic_kbajaj@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230512122134.24339-1-quic_kbajaj@quicinc.com>
References: <20230512122134.24339-1-quic_kbajaj@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Jq40bhMuGOrGWc-jsovkaWkGtPiqjsWp
X-Proofpoint-ORIG-GUID: Jq40bhMuGOrGWc-jsovkaWkGtPiqjsWp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-12_08,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=569
 clxscore=1015 bulkscore=0 spamscore=0 suspectscore=0 phishscore=0
 malwarescore=0 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305120103
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add properties to the qfprom node for multi channel DDR.

Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
---
 arch/arm64/boot/dts/qcom/qdu1000.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qdu1000.dtsi b/arch/arm64/boot/dts/qcom/qdu1000.dtsi
index 734438113bba..418644f396bc 100644
--- a/arch/arm64/boot/dts/qcom/qdu1000.dtsi
+++ b/arch/arm64/boot/dts/qcom/qdu1000.dtsi
@@ -1333,6 +1333,18 @@
 			interrupts = <GIC_SPI 266 IRQ_TYPE_LEVEL_HIGH>;
 			multi-ch-bit-off = <24 2>;
 		};
+
+		qfprom: efuse@221c8000 {
+			compatible = "qcom,qdu1000-qfprom", "qcom,qfprom";
+			reg = <0 0x221c8000 0 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			multi_chan_ddr: multi_chan_ddr@12b {
+				reg = <0x12b 0x1>;
+				bits = <0 2>;
+			};
+		};
 	};

 	timer {
--
2.17.1

