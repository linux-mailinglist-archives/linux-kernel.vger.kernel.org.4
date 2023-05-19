Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A409D70922A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 10:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbjESIv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 04:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230522AbjESIvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 04:51:38 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9088A10C6;
        Fri, 19 May 2023 01:51:36 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34J7Xm30007878;
        Fri, 19 May 2023 08:51:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=MPMKBOD0OrwkPcn5CLby2+DRpmMppG1j/5iGcNWKj2E=;
 b=PEYtvvBup/GHFMWLYzETuXcOiz/2Eo+qWUpJtqeuZh9o5RmwgjFp0ckm+ClkJaW7bkBu
 VGtCIodEzcAN045GX2gsSG+okyCCV8I6F/WmoJpWX1pOGFUEyms8M2ZrQjfXI/wzrzaV
 xaLm04/9z9+/CV6Vm1b0uaTrksUH3a8noYeaIDHK363zR+POcgX2TRk6Jd55J1WtBJ0M
 GlIWZvI+YQus+aNWh6yqNCjpgckq5SwNURplDbLYCJOwlqo4RbYE9wmtQMlv9uxZO6kb
 uDWtDdyOkYczNhZS/iBMZAWk/H6sdDwMWpnry1SfqW6RRj+1yntxRyiU3pYHtdm2vPEs Hw== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qnfpw30gw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 May 2023 08:51:32 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 34J8pTfS012777;
        Fri, 19 May 2023 08:51:29 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 3qj3mkd0q8-1;
        Fri, 19 May 2023 08:51:29 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34J8pTS7012770;
        Fri, 19 May 2023 08:51:29 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-kbajaj-hyd.qualcomm.com [10.147.247.189])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 34J8pT0P012769;
        Fri, 19 May 2023 08:51:29 +0000
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 2340697)
        id B8F93529754; Fri, 19 May 2023 14:21:28 +0530 (+0530)
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
Subject: [PATCH 3/4] arm64: dts: qcom: qdu1000: Add SDHCI1 pin configuration to DTSI
Date:   Fri, 19 May 2023 14:21:21 +0530
Message-Id: <20230519085122.15758-4-quic_kbajaj@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230519085122.15758-1-quic_kbajaj@quicinc.com>
References: <20230519085122.15758-1-quic_kbajaj@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: r5T1zmvVKk6BwunwGQxYdT15WtEU29a1
X-Proofpoint-GUID: r5T1zmvVKk6BwunwGQxYdT15WtEU29a1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-19_05,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 mlxscore=0 suspectscore=0 clxscore=1015 bulkscore=0
 adultscore=0 phishscore=0 mlxlogscore=647 impostorscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305190074
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add required pins for SDHCI1, so that the interface can work reliably.

Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
---
 arch/arm64/boot/dts/qcom/qdu1000.dtsi | 50 +++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qdu1000.dtsi b/arch/arm64/boot/dts/qcom/qdu1000.dtsi
index 6113def66a08..556942bfca5d 100644
--- a/arch/arm64/boot/dts/qcom/qdu1000.dtsi
+++ b/arch/arm64/boot/dts/qcom/qdu1000.dtsi
@@ -1160,6 +1160,56 @@
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

