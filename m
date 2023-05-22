Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 878C770B926
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 11:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232380AbjEVJgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 05:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232287AbjEVJgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 05:36:37 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F061F1;
        Mon, 22 May 2023 02:36:34 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34M8oZ3Q002978;
        Mon, 22 May 2023 09:36:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=gEwGfdC6GIJLK6EnvuW9A5pfwslprQxmb8rvX+0/nrY=;
 b=bu8e4E7Amtz+pqguHZXo9SnukkFCY4DcrQiAR+fllGQoUp98e8EoFHevdwzEz0DL81dV
 mUXruStFuBE7A9dkiGnfOBDaffpJ+hXoDsTVWFN9l4Z7V0EXgLY4wbkcvw3D3WFEKJAx
 FUhowRn4pbGQ8aUo6CyVagACTyuhC/UKgTBY5fPT8HZ6HsIJ0Pll6Cl5T/l3NCunIANB
 kHI5aqxsegoKj0GIDCJVPmJ84eK78tkuiRjSOFQ+vDRMtL2pjTaEcTknFuoFLNIBwfPO
 /VqYwclgoQSXo6AomyQEkFvVVDdVHfhCaU3Fcthl3RpBHown4tFOC3Fw7ml8WKtcq/dc UQ== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qr53w836g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 May 2023 09:36:31 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 34M9aR17026272;
        Mon, 22 May 2023 09:36:27 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 3qpq9kn8fr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 22 May 2023 09:36:27 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34M9aR50026263;
        Mon, 22 May 2023 09:36:27 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-kbajaj-hyd.qualcomm.com [10.147.247.189])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 34M9aRtx026262;
        Mon, 22 May 2023 09:36:27 +0000
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 2340697)
        id A6EF35001C2; Mon, 22 May 2023 15:06:26 +0530 (+0530)
From:   Komal Bajaj <quic_kbajaj@quicinc.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     Komal Bajaj <quic_kbajaj@quicinc.com>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v2 3/4] arm64: dts: qcom: qdu1000: Add SDHCI1 pin configuration to DTSI
Date:   Mon, 22 May 2023 15:06:19 +0530
Message-Id: <20230522093620.3568-4-quic_kbajaj@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230522093620.3568-1-quic_kbajaj@quicinc.com>
References: <20230522093620.3568-1-quic_kbajaj@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ulX11pzPYyCkL_SW_AJJZUlhYKW7G6HP
X-Proofpoint-ORIG-GUID: ulX11pzPYyCkL_SW_AJJZUlhYKW7G6HP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-22_06,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 mlxlogscore=670
 spamscore=0 bulkscore=0 malwarescore=0 adultscore=0 clxscore=1015
 mlxscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305220081
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add required pins for SDHCI1, so that the interface can work reliably.

Reviewed-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>wq
Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
---
 arch/arm64/boot/dts/qcom/qdu1000.dtsi | 50 +++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qdu1000.dtsi b/arch/arm64/boot/dts/qcom/qdu1000.dtsi
index 38ee7115a35f..6f23cbfc024c 100644
--- a/arch/arm64/boot/dts/qcom/qdu1000.dtsi
+++ b/arch/arm64/boot/dts/qcom/qdu1000.dtsi
@@ -1151,6 +1151,56 @@
 				pins = "gpio31";
 				function = "gpio";
 			};
+
+			sdc1_on_state: sdc1-on-state {
+				clk-pins {
+					pins = "sdc1_clk";
+					drive-strength = <16>;
+					bias-disable;
+				};
+
+				cmd-pins {
+					pins = "sdc1_cmd";
+					drive-strength = <10>;
+					bias-pull-up;
+				};
+
+				data-pins {
+					pins = "sdc1_data";
+					drive-strength = <10>;
+					bias-pull-up;
+				};
+
+				rclk-pins {
+					pins = "sdc1_rclk";
+					bias-pull-down;
+				};
+			};
+
+			sdc1_off_state: sdc1-off-state {
+				clk-pins {
+					pins = "sdc1_clk";
+					drive-strength = <2>;
+					bias-disable;
+				};
+
+				cmd-pins {
+					pins = "sdc1_cmd";
+					drive-strength = <2>;
+					bias-pull-up;
+				};
+
+				data-pins {
+					pins = "sdc1_data";
+					drive-strength = <2>;
+					bias-pull-up;
+				};
+
+				rclk-pins {
+					pins = "sdc1_rclk";
+					bias-pull-down;
+				};
+			};
 		};
 
 		apps_smmu: iommu@15000000 {
-- 
2.17.1

