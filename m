Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 862EB5F18EA
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 05:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232769AbiJADIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 23:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232660AbiJADHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 23:07:12 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B2C61BE7AC;
        Fri, 30 Sep 2022 20:06:18 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2912ac2b000871;
        Sat, 1 Oct 2022 03:06:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=k1SbDhDtgb8mZrDasywqUBcOG24Buqt7AKAQeoMFO3M=;
 b=kfWCqPR4igm3sk1+TOlT0RJGMtM62X2K4tsRKzgui/G+X0c3tXwDN+BhVJTxDzK6F4oh
 ngdRxoGVu0xzUiWg8y3yKQOqGYvh9LBmqOt2IZp+swXj5TGsfvEaOgNpdYdnUcgKCOxa
 /SmJx7JvTV1gmY9Te4QuXsi+SaK7aCwEd3Pfnmts3GN865DiQKCzaUsF+5GIsmZneg+X
 PI9fG0+fkOdHoYTvWCLt1Na+2Jl2qMDPe/5WjpmqxVQUSbQBBzyyqM7gjh9EiiYdTkbo
 ONVGPpkMLhlGgEaFWshfwQGSCnicm4rRPLccqphEaOLOA/gBj4ojnswASFi9e/kra1SR Uw== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jxb8n855s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 01 Oct 2022 03:06:15 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29136EUX009099
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 1 Oct 2022 03:06:14 GMT
Received: from hu-molvera-sd.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Fri, 30 Sep 2022 20:06:14 -0700
From:   Melody Olvera <quic_molvera@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Melody Olvera <quic_molvera@quicinc.com>
Subject: [PATCH 1/2] dt-bindings: interconnect: Add QDU1000/QRU1000 dt bindings
Date:   Fri, 30 Sep 2022 20:06:01 -0700
Message-ID: <20221001030602.28232-2-quic_molvera@quicinc.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221001030602.28232-1-quic_molvera@quicinc.com>
References: <20221001030602.28232-1-quic_molvera@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: _Rbg_QVj5Bxc74HZ6yWTzAHmi6kZ8O9C
X-Proofpoint-GUID: _Rbg_QVj5Bxc74HZ6yWTzAHmi6kZ8O9C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-01_02,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 spamscore=0 phishscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 suspectscore=0 impostorscore=0 mlxlogscore=999 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210010016
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add interconnect IDs for Qualcomm QDU1000 and QRU1000 platforms.

Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
---
 .../bindings/interconnect/qcom,rpmh.yaml      |  8 ++
 .../dt-bindings/interconnect/qcom,qdru1000.h  | 98 +++++++++++++++++++
 2 files changed, 106 insertions(+)
 create mode 100644 include/dt-bindings/interconnect/qcom,qdru1000.h

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
index a429a1ed1006..c524d92ee203 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
@@ -132,6 +132,14 @@ properties:
       - qcom,sm8450-nsp-noc
       - qcom,sm8450-pcie-anoc
       - qcom,sm8450-system-noc
+      - qcom,qdu1000-clk-virt
+      - qcom,qdu1000-gem-noc
+      - qcom,qdu1000-mc-virt
+      - qcom,qdu1000-system-noc
+      - qcom,qru1000-clk-virt
+      - qcom,qru1000-gem-noc
+      - qcom,qru1000-mc-virt
+      - qcom,qru1000-system-noc
 
   '#interconnect-cells': true
 
diff --git a/include/dt-bindings/interconnect/qcom,qdru1000.h b/include/dt-bindings/interconnect/qcom,qdru1000.h
new file mode 100644
index 000000000000..2bdfa0c15d2c
--- /dev/null
+++ b/include/dt-bindings/interconnect/qcom,qdru1000.h
@@ -0,0 +1,98 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2022, Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef __DT_BINDINGS_INTERCONNECT_QCOM_QDRU1000_H
+#define __DT_BINDINGS_INTERCONNECT_QCOM_QDRU1000_H
+
+#define MASTER_QUP_CORE_0			0
+#define MASTER_QUP_CORE_1			1
+#define SLAVE_QUP_CORE_0			2
+#define SLAVE_QUP_CORE_1			3
+
+#define MASTER_SYS_TCU				0
+#define MASTER_APPSS_PROC			1
+#define MASTER_GEMNOC_ECPRI_DMA			2
+#define MASTER_FEC_2_GEMNOC			3
+#define MASTER_ANOC_PCIE_GEM_NOC		4
+#define MASTER_SNOC_GC_MEM_NOC			5
+#define MASTER_SNOC_SF_MEM_NOC			6
+#define MASTER_MSS_PROC				7
+#define SLAVE_GEM_NOC_CNOC			8
+#define SLAVE_LLCC				9
+#define SLAVE_GEMNOC_MODEM_CNOC			10
+#define SLAVE_MEM_NOC_PCIE_SNOC			11
+
+#define MASTER_LLCC				0
+#define SLAVE_EBI1				1
+
+#define MASTER_GIC_AHB				0
+#define MASTER_QDSS_BAM				1
+#define MASTER_QPIC				2
+#define MASTER_QSPI_0				3
+#define MASTER_QUP_0				4
+#define MASTER_QUP_1				5
+#define MASTER_SNOC_CFG				6
+#define MASTER_ANOC_SNOC			7
+#define MASTER_ANOC_GSI				8
+#define MASTER_GEM_NOC_CNOC			9
+#define MASTER_GEMNOC_MODEM_CNOC		10
+#define MASTER_GEM_NOC_PCIE_SNOC		11
+#define MASTER_CRYPTO				12
+#define MASTER_ECPRI_GSI			13
+#define MASTER_PIMEM				14
+#define MASTER_SNOC_ECPRI_DMA			15
+#define MASTER_GIC				16
+#define MASTER_PCIE				17
+#define MASTER_QDSS_ETR				18
+#define MASTER_QDSS_ETR_1			19
+#define MASTER_SDCC_1				20
+#define MASTER_USB3				21
+#define SLAVE_AHB2PHY_SOUTH			22
+#define SLAVE_AHB2PHY_NORTH			23
+#define SLAVE_AHB2PHY_EAST			24
+#define SLAVE_AOSS				25
+#define SLAVE_CLK_CTL				26
+#define SLAVE_RBCPR_CX_CFG			27
+#define SLAVE_RBCPR_MX_CFG			28
+#define SLAVE_CRYPTO_0_CFG			29
+#define SLAVE_ECPRI_CFG				30
+#define SLAVE_IMEM_CFG				31
+#define SLAVE_IPC_ROUTER_CFG			32
+#define SLAVE_CNOC_MSS				33
+#define SLAVE_PCIE_CFG				34
+#define SLAVE_PDM				35
+#define SLAVE_PIMEM_CFG				36
+#define SLAVE_PRNG				37
+#define SLAVE_QDSS_CFG				38
+#define SLAVE_QPIC				40
+#define SLAVE_QSPI_0				41
+#define SLAVE_QUP_0				42
+#define SLAVE_QUP_1				43
+#define SLAVE_SDCC_2				44
+#define SLAVE_SMBUS_CFG				45
+#define SLAVE_SNOC_CFG				46
+#define SLAVE_TCSR				47
+#define SLAVE_TLMM				48
+#define SLAVE_TME_CFG				49
+#define SLAVE_TSC_CFG				50
+#define SLAVE_USB3_0				51
+#define SLAVE_VSENSE_CTRL_CFG			52
+#define SLAVE_A1NOC_SNOC			53
+#define SLAVE_ANOC_SNOC_GSI			54
+#define SLAVE_DDRSS_CFG				55
+#define SLAVE_ECPRI_GEMNOC			56
+#define SLAVE_SNOC_GEM_NOC_GC			57
+#define SLAVE_SNOC_GEM_NOC_SF			58
+#define SLAVE_MODEM_OFFLINE			59
+#define SLAVE_ANOC_PCIE_GEM_NOC			60
+#define SLAVE_IMEM				61
+#define SLAVE_PIMEM				62
+#define SLAVE_SERVICE_SNOC			63
+#define SLAVE_ETHERNET_SS			64
+#define SLAVE_PCIE_0				65
+#define SLAVE_QDSS_STM				66
+#define SLAVE_TCU				67
+
+#endif
-- 
2.37.3

