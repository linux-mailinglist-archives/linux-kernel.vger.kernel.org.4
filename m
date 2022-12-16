Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A4E564F4BD
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 00:10:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbiLPXKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 18:10:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbiLPXJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 18:09:30 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA6266F0F1;
        Fri, 16 Dec 2022 15:09:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1671232166; x=1702768166;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WyyTFkm1z38CPlnad9plEBisJJWGvrfH72pa5JBcSlo=;
  b=aiDtRVXCDDrkUBkjLARVazBfa8+GfCQC1EkXi3h24VpB3jd0yncsWUD/
   zhhk1PmXv8L2gbaphX2z5tfnvk3c9/XP1oq2EufgxYg8cMS5XHrEuAq7Z
   ShRFqTf1YQbXTUE+rW0O5GD7oO2sotvoJZF87z5ql3mlrZcZ6+q7WD6hj
   U=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 16 Dec 2022 15:09:25 -0800
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2022 15:09:25 -0800
Received: from hu-molvera-sd.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Fri, 16 Dec 2022 15:09:25 -0800
From:   Melody Olvera <quic_molvera@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Odelu Kukatla <quic_okukatla@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Melody Olvera <quic_molvera@quicinc.com>
Subject: [PATCH v5 1/2] dt-bindings: interconnect: Add QDU1000/QRU1000 devices
Date:   Fri, 16 Dec 2022 15:09:13 -0800
Message-ID: <20221216230914.21771-2-quic_molvera@quicinc.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221216230914.21771-1-quic_molvera@quicinc.com>
References: <20221216230914.21771-1-quic_molvera@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add separate schema for QDU1000 and QRU1000 interconnect devices
to document the different NoCs on these platforms.

Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
---
 .../interconnect/qcom,qdu1000-rpmh.yaml       | 70 +++++++++++++
 .../interconnect/qcom,qdu1000-rpmh.h          | 98 +++++++++++++++++++
 2 files changed, 168 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,qdu1000-rpmh.yaml
 create mode 100644 include/dt-bindings/interconnect/qcom,qdu1000-rpmh.h

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,qdu1000-rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,qdu1000-rpmh.yaml
new file mode 100644
index 000000000000..dad93b8e4895
--- /dev/null
+++ b/Documentation/devicetree/bindings/interconnect/qcom,qdu1000-rpmh.yaml
@@ -0,0 +1,70 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interconnect/qcom,qdu1000-rpmh.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm RPMh Network-On-Chip Interconnect on QDU1000
+
+maintainers:
+  - Georgi Djakov <djakov@kernel.org>
+  - Odelu Kukatla <quic_okukatla@quicinc.com>
+
+description: |
+   RPMh interconnect providers support system bandwidth requirements through
+   RPMh hardware accelerators known as Bus Clock Manager (BCM). The provider is
+   able to communicate with the BCM through the Resource State Coordinator (RSC)
+   associated with each execution environment. Provider nodes must point to at
+   least one RPMh device child node pertaining to their RSC and each provider
+   can map to multiple RPMh resources.
+
+properties:
+  compatible:
+    enum:
+      - qcom,qdu1000-clk-virt
+      - qcom,qdu1000-gem-noc
+      - qcom,qdu1000-mc-virt
+      - qcom,qdu1000-system-noc
+
+  '#interconnect-cells': true
+
+  reg:
+    maxItems: 1
+
+allOf:
+  - $ref: qcom,rpmh-common.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,qdu1000-clk-virt
+              - qcom,qdu1000-mc-virt
+    then:
+      properties:
+        reg: false
+    else:
+      required:
+        - reg
+
+required:
+  - compatible
+
+unevaluatedProperties: false
+
+examples:
+  - |
+      #include <dt-bindings/interconnect/qcom,qdu1000-rpmh.h>
+
+      system_noc: interconnect@1640000 {
+             compatible = "qcom,qdu1000-system-noc";
+             reg = <0x1640000 0x45080>;
+             #interconnect-cells = <2>;
+             qcom,bcm-voters = <&apps_bcm_voter>;
+      };
+
+      clk_virt: interconnect-0 {
+             compatible = "qcom,qdu1000-clk-virt";
+             #interconnect-cells = <2>;
+             qcom,bcm-voters = <&apps_bcm_voter>;
+      };
diff --git a/include/dt-bindings/interconnect/qcom,qdu1000-rpmh.h b/include/dt-bindings/interconnect/qcom,qdu1000-rpmh.h
new file mode 100644
index 000000000000..7f0ad1571128
--- /dev/null
+++ b/include/dt-bindings/interconnect/qcom,qdu1000-rpmh.h
@@ -0,0 +1,98 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
+/*
+ * Copyright (c) 2022, Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef __DT_BINDINGS_INTERCONNECT_QCOM_QDU1000_H
+#define __DT_BINDINGS_INTERCONNECT_QCOM_QDU1000_H
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
2.38.1

