Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D59A695867
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 06:17:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231761AbjBNFRB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 00:17:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231833AbjBNFQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 00:16:31 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19EF61A4B8;
        Mon, 13 Feb 2023 21:15:32 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31E08UZr000827;
        Tue, 14 Feb 2023 05:15:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=1urUc6LVnMUow/5UoO46s9iID+j38tHr7itx4ohlZhc=;
 b=T3IA+TDKMGJ4Q1EwHkbcq/ez7EyEXV6+4UkH5OSM+7Jsza59l3FjwpLuOhPw7nVyyfvM
 /96CVHQFVawxVbnTGvycivzMiJG6BPDwuyrZR1tssDDs/Ipn0cQ0HId06VJWJavQQo5j
 n/1lIvofir/06Di0Lf5PZLkhZD85YfI5VdGQckJ50Q5XxfAzkaej5aXcu+/ISElsHjWv
 kJluS+8dPT/kmV/KAEw1UbaNAs9EAhB1FzpvHoP6Cc0xf83fS5eaD7Vt1kYeqeZ+Btgn
 Q51qmDcQqilIww/tAFG4QhJywS1aMs/6DQI4/7wovt0oy2qJMQs9whTf2YzH065a5FGD cQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nqtsus4xf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Feb 2023 05:15:12 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31E5FAZi009412
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Feb 2023 05:15:11 GMT
Received: from poovendh-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 13 Feb 2023 21:14:59 -0800
From:   Poovendhan Selvaraj <quic_poovendh@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <lee@kernel.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <jassisinghbrar@gmail.com>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <shawnguo@kernel.org>, <arnd@arndb.de>,
        <marcel.ziswiler@toradex.com>, <robimarko@gmail.com>,
        <dmitry.baryshkov@linaro.org>, <nfraprado@collabora.com>,
        <broonie@kernel.org>, <quic_gurus@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <quic_srichara@quicinc.com>, <quic_gokulsri@quicinc.com>,
        <quic_sjaganat@quicinc.com>, <quic_kathirav@quicinc.com>,
        <quic_arajkuma@quicinc.com>, <quic_anusha@quicinc.com>,
        <quic_devipriy@quicinc.com>
Subject: [PATCH V4 3/5] arm64: dts: qcom: ipq9574: Enable the download mode support
Date:   Tue, 14 Feb 2023 10:44:12 +0530
Message-ID: <20230214051414.10740-4-quic_poovendh@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230214051414.10740-1-quic_poovendh@quicinc.com>
References: <20230214051414.10740-1-quic_poovendh@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: wgp-zeQ7y0g6djpG-tnqnnSZvMRTzS44
X-Proofpoint-ORIG-GUID: wgp-zeQ7y0g6djpG-tnqnnSZvMRTzS44
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-14_03,2023-02-13_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 malwarescore=0 mlxlogscore=860 phishscore=0
 lowpriorityscore=0 bulkscore=0 mlxscore=0 adultscore=0 impostorscore=0
 suspectscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2302140042
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the support for download mode to collect the crashdumps if
system crashes, to debug crashes extensively.

Signed-off-by: Poovendhan Selvaraj <quic_poovendh@quicinc.com>
---
 Changes in V4:
	- Dropped smem related nodes from this patch
        - Mapped the entire TCSR_REGS region and updated the offset in
	  qcom,dload-mode property
	- updated the commit message

 Changes in V3:
	- No changes

 arch/arm64/boot/dts/qcom/ipq9574.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
index 2b86ba17bb32..898d7ce3f28d 100644
--- a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
@@ -81,6 +81,13 @@
 		reg = <0x0 0x40000000 0x0 0x0>;
 	};
 
+	firmware {
+		scm {
+			compatible = "qcom,scm-ipq9574", "qcom,scm";
+			qcom,dload-mode = <&tcsr 0x6100>;
+		};
+	};
+
 	pmu {
 		compatible = "arm,cortex-a73-pmu";
 		interrupts = <GIC_PPI 7 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
@@ -150,6 +157,11 @@
 			#power-domain-cells = <1>;
 		};
 
+		tcsr: syscon@1937000 {
+			compatible = "qcom,tcsr-ipq9574", "syscon";
+			reg = <0x01937000 0x21000>;
+		};
+
 		sdhc_1: mmc@7804000 {
 			compatible = "qcom,ipq9574-sdhci", "qcom,sdhci-msm-v5";
 			reg = <0x07804000 0x1000>, <0x07805000 0x1000>;
-- 
2.17.1

