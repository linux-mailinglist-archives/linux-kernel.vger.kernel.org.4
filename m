Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06D655EC002
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 12:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231527AbiI0KnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 06:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbiI0KnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 06:43:08 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A168BFDFA1;
        Tue, 27 Sep 2022 03:43:06 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28RAK197019512;
        Tue, 27 Sep 2022 10:42:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=shKyUC3iyr8VzV/Jg6O7VgI+jnUySbJVIawvxw7r18Y=;
 b=F3HL6Q9W0mEBBwMa2jeUfMOZr1UFSUXeBZKyNMIBCJm/GPPkuHjkt556aySDm/9x47NK
 j6iAITnoLM/+QlvFxLw2yzmBW3fEM87yyAUP1NjTgDXNsKV4BVkYkS9I/KYsUY8so1PJ
 l8QPRsJ4lAZ9PH52boLrZT/Q7HgIENX498zz5sKx7dt2Xzuy3qVsjJaWMCrXJhmef6rD
 PtFq8tgoZU5HrML+z/cXnbr4FtvYftprgGmXqRjpUWqeqFAROe5AODSXnKzjr9VwJGZ6
 iPr3Om6xNtliEzD0xvXPlmui2rY59TRxJghba1NncIYrkfzMGh3rUnw9GbkZo0fJH28o gA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3juq77h4sc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Sep 2022 10:42:53 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28RAgqvI028711
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Sep 2022 10:42:52 GMT
Received: from blr-ubuntu-173.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Tue, 27 Sep 2022 03:42:49 -0700
From:   Rajendra Nayak <quic_rjendra@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@somainline.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>
Subject: [PATCH] arm64: dts: qcom: sc7280: Add required-opps for i2c
Date:   Tue, 27 Sep 2022 16:12:33 +0530
Message-ID: <20220927104233.29376-1-quic_rjendra@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: UOG--l7TV3RR3qIiKjj1AnSaf_ztxWOc
X-Proofpoint-GUID: UOG--l7TV3RR3qIiKjj1AnSaf_ztxWOc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-27_02,2022-09-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 clxscore=1011 lowpriorityscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 mlxscore=0 impostorscore=0 mlxlogscore=905 phishscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209270063
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

qup-i2c devices on sc7280 are clocked with a fixed clock (19.2 MHz)
Though qup-i2c does not support DVFS, it still needs to vote for a
performance state on 'CX' to satisfy the 19.2 Mhz clock frequency
requirement.

Use 'required-opps' to pass this information from
device tree, and also add the power-domains property to specify
the CX power-domain.

Signed-off-by: Rajendra Nayak <quic_rjendra@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sc7280.dtsi | 32 ++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 212580316d3e..c7c14bbc0023 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -967,6 +967,8 @@
 						<&aggre1_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI1 0>;
 				interconnect-names = "qup-core", "qup-config",
 							"qup-memory";
+				power-domains = <&rpmhpd SC7280_CX>;
+				required-opps = <&rpmhpd_opp_low_svs>;
 				dmas = <&gpi_dma0 0 0 QCOM_GPI_I2C>,
 				       <&gpi_dma0 1 0 QCOM_GPI_I2C>;
 				dma-names = "tx", "rx";
@@ -1025,6 +1027,8 @@
 						<&aggre1_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI1 0>;
 				interconnect-names = "qup-core", "qup-config",
 							"qup-memory";
+				power-domains = <&rpmhpd SC7280_CX>;
+				required-opps = <&rpmhpd_opp_low_svs>;
 				dmas = <&gpi_dma0 0 1 QCOM_GPI_I2C>,
 				       <&gpi_dma0 1 1 QCOM_GPI_I2C>;
 				dma-names = "tx", "rx";
@@ -1083,6 +1087,8 @@
 						<&aggre1_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI1 0>;
 				interconnect-names = "qup-core", "qup-config",
 							"qup-memory";
+				power-domains = <&rpmhpd SC7280_CX>;
+				required-opps = <&rpmhpd_opp_low_svs>;
 				dmas = <&gpi_dma0 0 2 QCOM_GPI_I2C>,
 				       <&gpi_dma0 1 2 QCOM_GPI_I2C>;
 				dma-names = "tx", "rx";
@@ -1141,6 +1147,8 @@
 						<&aggre1_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI1 0>;
 				interconnect-names = "qup-core", "qup-config",
 							"qup-memory";
+				power-domains = <&rpmhpd SC7280_CX>;
+				required-opps = <&rpmhpd_opp_low_svs>;
 				dmas = <&gpi_dma0 0 3 QCOM_GPI_I2C>,
 				       <&gpi_dma0 1 3 QCOM_GPI_I2C>;
 				dma-names = "tx", "rx";
@@ -1199,6 +1207,8 @@
 						<&aggre1_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI1 0>;
 				interconnect-names = "qup-core", "qup-config",
 							"qup-memory";
+				power-domains = <&rpmhpd SC7280_CX>;
+				required-opps = <&rpmhpd_opp_low_svs>;
 				dmas = <&gpi_dma0 0 4 QCOM_GPI_I2C>,
 				       <&gpi_dma0 1 4 QCOM_GPI_I2C>;
 				dma-names = "tx", "rx";
@@ -1257,6 +1267,8 @@
 						<&aggre1_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI1 0>;
 				interconnect-names = "qup-core", "qup-config",
 							"qup-memory";
+				power-domains = <&rpmhpd SC7280_CX>;
+				required-opps = <&rpmhpd_opp_low_svs>;
 				dmas = <&gpi_dma0 0 5 QCOM_GPI_I2C>,
 				       <&gpi_dma0 1 5 QCOM_GPI_I2C>;
 				dma-names = "tx", "rx";
@@ -1315,6 +1327,8 @@
 						<&aggre1_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI1 0>;
 				interconnect-names = "qup-core", "qup-config",
 							"qup-memory";
+				power-domains = <&rpmhpd SC7280_CX>;
+				required-opps = <&rpmhpd_opp_low_svs>;
 				dmas = <&gpi_dma0 0 6 QCOM_GPI_I2C>,
 				       <&gpi_dma0 1 6 QCOM_GPI_I2C>;
 				dma-names = "tx", "rx";
@@ -1373,6 +1387,8 @@
 						<&aggre1_noc MASTER_QUP_0 0 &mc_virt SLAVE_EBI1 0>;
 				interconnect-names = "qup-core", "qup-config",
 							"qup-memory";
+				power-domains = <&rpmhpd SC7280_CX>;
+				required-opps = <&rpmhpd_opp_low_svs>;
 				dmas = <&gpi_dma0 0 7 QCOM_GPI_I2C>,
 				       <&gpi_dma0 1 7 QCOM_GPI_I2C>;
 				dma-names = "tx", "rx";
@@ -1466,6 +1482,8 @@
 						<&aggre2_noc MASTER_QUP_1 0 &mc_virt SLAVE_EBI1 0>;
 				interconnect-names = "qup-core", "qup-config",
 							"qup-memory";
+				power-domains = <&rpmhpd SC7280_CX>;
+				required-opps = <&rpmhpd_opp_low_svs>;
 				dmas = <&gpi_dma1 0 0 QCOM_GPI_I2C>,
 				       <&gpi_dma1 1 0 QCOM_GPI_I2C>;
 				dma-names = "tx", "rx";
@@ -1524,6 +1542,8 @@
 						<&aggre2_noc MASTER_QUP_1 0 &mc_virt SLAVE_EBI1 0>;
 				interconnect-names = "qup-core", "qup-config",
 							"qup-memory";
+				power-domains = <&rpmhpd SC7280_CX>;
+				required-opps = <&rpmhpd_opp_low_svs>;
 				dmas = <&gpi_dma1 0 1 QCOM_GPI_I2C>,
 				       <&gpi_dma1 1 1 QCOM_GPI_I2C>;
 				dma-names = "tx", "rx";
@@ -1582,6 +1602,8 @@
 						<&aggre2_noc MASTER_QUP_1 0 &mc_virt SLAVE_EBI1 0>;
 				interconnect-names = "qup-core", "qup-config",
 							"qup-memory";
+				power-domains = <&rpmhpd SC7280_CX>;
+				required-opps = <&rpmhpd_opp_low_svs>;
 				dmas = <&gpi_dma1 0 2 QCOM_GPI_I2C>,
 				       <&gpi_dma1 1 2 QCOM_GPI_I2C>;
 				dma-names = "tx", "rx";
@@ -1640,6 +1662,8 @@
 						<&aggre2_noc MASTER_QUP_1 0 &mc_virt SLAVE_EBI1 0>;
 				interconnect-names = "qup-core", "qup-config",
 							"qup-memory";
+				power-domains = <&rpmhpd SC7280_CX>;
+				required-opps = <&rpmhpd_opp_low_svs>;
 				dmas = <&gpi_dma1 0 3 QCOM_GPI_I2C>,
 				       <&gpi_dma1 1 3 QCOM_GPI_I2C>;
 				dma-names = "tx", "rx";
@@ -1698,6 +1722,8 @@
 						<&aggre2_noc MASTER_QUP_1 0 &mc_virt SLAVE_EBI1 0>;
 				interconnect-names = "qup-core", "qup-config",
 							"qup-memory";
+				power-domains = <&rpmhpd SC7280_CX>;
+				required-opps = <&rpmhpd_opp_low_svs>;
 				dmas = <&gpi_dma1 0 4 QCOM_GPI_I2C>,
 				       <&gpi_dma1 1 4 QCOM_GPI_I2C>;
 				dma-names = "tx", "rx";
@@ -1756,6 +1782,8 @@
 						<&aggre2_noc MASTER_QUP_1 0 &mc_virt SLAVE_EBI1 0>;
 				interconnect-names = "qup-core", "qup-config",
 							"qup-memory";
+				power-domains = <&rpmhpd SC7280_CX>;
+				required-opps = <&rpmhpd_opp_low_svs>;
 				dmas = <&gpi_dma1 0 5 QCOM_GPI_I2C>,
 				       <&gpi_dma1 1 5 QCOM_GPI_I2C>;
 				dma-names = "tx", "rx";
@@ -1814,6 +1842,8 @@
 						<&aggre2_noc MASTER_QUP_1 0 &mc_virt SLAVE_EBI1 0>;
 				interconnect-names = "qup-core", "qup-config",
 							"qup-memory";
+				power-domains = <&rpmhpd SC7280_CX>;
+				required-opps = <&rpmhpd_opp_low_svs>;
 				dmas = <&gpi_dma1 0 6 QCOM_GPI_I2C>,
 				       <&gpi_dma1 1 6 QCOM_GPI_I2C>;
 				dma-names = "tx", "rx";
@@ -1872,6 +1902,8 @@
 						<&aggre2_noc MASTER_QUP_1 0 &mc_virt SLAVE_EBI1 0>;
 				interconnect-names = "qup-core", "qup-config",
 							"qup-memory";
+				power-domains = <&rpmhpd SC7280_CX>;
+				required-opps = <&rpmhpd_opp_low_svs>;
 				dmas = <&gpi_dma1 0 7 QCOM_GPI_I2C>,
 				       <&gpi_dma1 1 7 QCOM_GPI_I2C>;
 				dma-names = "tx", "rx";
-- 
2.17.1

