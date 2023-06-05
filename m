Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95738722C8F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 18:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234448AbjFEQaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 12:30:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233019AbjFEQ3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 12:29:44 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC6A9CD;
        Mon,  5 Jun 2023 09:29:42 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 355FaUlM008059;
        Mon, 5 Jun 2023 16:29:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=fbI1okh9KYF4nrY99AMh+JC6AtxUZsIwJM+wl68Enio=;
 b=bJ7C8gLbHdMLvlqzjySTf9BaDja85GC64/QGi7qEPCynK6wKuKHQBq2sZgA5iqEutw1s
 R8VjCicPaJx6vzZa5ToMS6GudqO/DpwrSYnQopyGUR//roOskmi8d9rjMxtxjivOiqeU
 TxXQH2reWYRNmGFsCF1J+44oAgth/DJoXoJZVToDuYBvOixWO1QShNzpTPDV1etzFvq/
 WAIzBuA9uatnMeORiMaH8n8KeegDb+eg2GB7np529wMIgbHbs82dV34KW0XS01pG9uSa
 Z+C1T9ZCfYHvOUDqd1taC3yFvdRE4EhoCPRZYFA7vLhUWIL4wc+pvaXFYavRexagmF09 oA== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r1jg3g4p3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Jun 2023 16:29:24 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 355GTKej030366;
        Mon, 5 Jun 2023 16:29:20 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3qyxkkq42b-1;
        Mon, 05 Jun 2023 16:29:20 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 355GTJSJ030342;
        Mon, 5 Jun 2023 16:29:20 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-rohiagar-hyd.qualcomm.com [10.213.106.138])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 355GTJDe030326;
        Mon, 05 Jun 2023 16:29:20 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
        id 9C6245F20; Mon,  5 Jun 2023 21:59:19 +0530 (+0530)
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, rafael@kernel.org, viresh.kumar@linaro.org,
        tglx@linutronix.de, maz@kernel.org, will@kernel.org,
        robin.murphy@arm.com, joro@8bytes.org, mani@kernel.org,
        robimarko@gmail.com
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH v2 06/10] arm64: dts: qcom: Add SDX75 platform and IDP board support
Date:   Mon,  5 Jun 2023 21:59:13 +0530
Message-Id: <1685982557-28326-7-git-send-email-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1685982557-28326-1-git-send-email-quic_rohiagar@quicinc.com>
References: <1685982557-28326-1-git-send-email-quic_rohiagar@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: LeFePHfOq5E8DM9dCDiMtf6xXFxD6Adq
X-Proofpoint-ORIG-GUID: LeFePHfOq5E8DM9dCDiMtf6xXFxD6Adq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-05_31,2023-06-02_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 malwarescore=0 impostorscore=0 spamscore=0 bulkscore=0
 suspectscore=0 lowpriorityscore=0 adultscore=0 phishscore=0
 mlxlogscore=941 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306050142
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add basic devicetree support for SDX75 platform and IDP board from
Qualcomm. The SDX75 platform features an ARM Cortex A55 CPU which forms
the Application Processor Sub System (APSS) along with standard Qualcomm
peripherals like GCC, TLMM, UART, QPIC, and BAM etc... Also, there
exists the networking parts such as IPA, MHI, PCIE-EP, EMAC, and Modem
etc..

This commit adds basic devicetree support.

Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
---
 arch/arm64/boot/dts/qcom/Makefile      |   1 +
 arch/arm64/boot/dts/qcom/sdx75-idp.dts |  18 ++
 arch/arm64/boot/dts/qcom/sdx75.dtsi    | 533 +++++++++++++++++++++++++++++++++
 3 files changed, 552 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/sdx75-idp.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sdx75.dtsi

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index d42c595..4fd5a18 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -173,6 +173,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-xiaomi-polaris.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-shift-axolotl.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm850-lenovo-yoga-c630.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm850-samsung-w737.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= sdx75-idp.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm4250-oneplus-billie2.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm6115p-lenovo-j606f.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm6125-sony-xperia-seine-pdx201.dtb
diff --git a/arch/arm64/boot/dts/qcom/sdx75-idp.dts b/arch/arm64/boot/dts/qcom/sdx75-idp.dts
new file mode 100644
index 0000000..1e08f25
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sdx75-idp.dts
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+/dts-v1/;
+
+#include "sdx75.dtsi"
+
+/ {
+	model = "Qualcomm Technologies, Inc. SDX75 IDP";
+	compatible = "qcom,sdx75-idp", "qcom,sdx75";
+
+};
+
+&tlmm {
+	gpio-reserved-ranges = <110 6>;
+};
diff --git a/arch/arm64/boot/dts/qcom/sdx75.dtsi b/arch/arm64/boot/dts/qcom/sdx75.dtsi
new file mode 100644
index 0000000..3d1646b
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sdx75.dtsi
@@ -0,0 +1,533 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * SDX75 SoC device tree source
+ *
+ * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ *
+ */
+
+#include <dt-bindings/clock/qcom,rpmh.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/soc/qcom,rpmh-rsc.h>
+
+/ {
+	#address-cells = <2>;
+	#size-cells = <2>;
+	interrupt-parent = <&intc>;
+
+	chosen: chosen { };
+
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0 0x80000000 0 0>;
+	};
+
+	clocks { };
+
+	cpus {
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		CPU0: cpu@0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a55";
+			reg = <0x0 0x0>;
+			enable-method = "psci";
+			power-domains = <&CPU_PD0>;
+			power-domain-names = "psci";
+			next-level-cache = <&L2_0>;
+			L2_0: l2-cache {
+				compatible = "cache";
+				next-level-cache = <&L3_0>;
+				L3_0: l3-cache {
+					compatible = "cache";
+				};
+			};
+		};
+
+		CPU1: cpu@100 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a55";
+			reg = <0x0 0x100>;
+			enable-method = "psci";
+			power-domains = <&CPU_PD1>;
+			power-domain-names = "psci";
+			next-level-cache = <&L2_100>;
+			L2_100: l2-cache {
+				compatible = "cache";
+				next-level-cache = <&L3_0>;
+			};
+		};
+
+		CPU2: cpu@200 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a55";
+			reg = <0x0 0x200>;
+			enable-method = "psci";
+			power-domains = <&CPU_PD2>;
+			power-domain-names = "psci";
+			next-level-cache = <&L2_200>;
+			L2_200: l2-cache {
+				compatible = "cache";
+				next-level-cache = <&L3_0>;
+			};
+		};
+
+		CPU3: cpu@300 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a55";
+			reg = <0x0 0x300>;
+			enable-method = "psci";
+			power-domains = <&CPU_PD3>;
+			power-domain-names = "psci";
+			next-level-cache = <&L2_300>;
+			L2_300: l2-cache {
+				compatible = "cache";
+				next-level-cache = <&L3_0>;
+			};
+		};
+
+		cpu-map {
+			cluster0 {
+				core0 {
+					cpu = <&CPU0>;
+				};
+
+				core1 {
+					cpu = <&CPU1>;
+				};
+
+				core2 {
+					cpu = <&CPU2>;
+				};
+
+				core3 {
+					cpu = <&CPU3>;
+				};
+			};
+		};
+	};
+
+	idle-states {
+		entry-method = "psci";
+
+		CPU_OFF: cpu-sleep-0 {
+			compatible = "arm,idle-state";
+			entry-latency-us = <235>;
+			exit-latency-us = <428>;
+			min-residency-us = <1774>;
+			arm,psci-suspend-param = <0x40000003>;
+			local-timer-stop;
+		};
+
+		CPU_RAIL_OFF: cpu-rail-sleep-1 {
+			compatible = "arm,idle-state";
+			entry-latency-us = <800>;
+			exit-latency-us = <750>;
+			min-residency-us = <4090>;
+			arm,psci-suspend-param = <0x40000004>;
+			local-timer-stop;
+		};
+
+	};
+
+	domain-idle-states {
+		CLUSTER_SLEEP_0: cluster-sleep-0 {
+			compatible = "domain-idle-state";
+			arm,psci-suspend-param = <0x41000044>;
+			entry-latency-us = <1050>;
+			exit-latency-us = <2500>;
+			min-residency-us = <5309>;
+		};
+
+		CLUSTER_SLEEP_1: cluster-sleep-1 {
+			compatible = "domain-idle-state";
+			arm,psci-suspend-param = <0x4100b344>;
+			entry-latency-us = <2793>;
+			exit-latency-us = <4023>;
+			min-residency-us = <9826>;
+		};
+
+		CX_RET: cx-ret {
+			compatible = "domain-idle-state";
+			arm,psci-suspend-param = <0x41001344>;
+			entry-latency-us = <2761>;
+			exit-latency-us = <3964>;
+			min-residency-us = <8467>;
+		};
+	};
+
+	psci {
+		compatible = "arm,psci-1.0";
+		method = "smc";
+
+		CPU_PD0: power-domain-cpu0 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER_PD>;
+			domain-idle-states = <&CPU_OFF &CPU_RAIL_OFF>;
+		};
+
+		CPU_PD1: power-domain-cpu1 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER_PD>;
+			domain-idle-states = <&CPU_OFF &CPU_RAIL_OFF>;
+		};
+
+		CPU_PD2: power-domain-cpu2 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER_PD>;
+			domain-idle-states = <&CPU_OFF &CPU_RAIL_OFF>;
+		};
+
+		CPU_PD3: power-domain-cpu3 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER_PD>;
+			domain-idle-states = <&CPU_OFF &CPU_RAIL_OFF>;
+		};
+
+		CLUSTER_PD: power-domain-cpu-cluster0 {
+			#power-domain-cells = <0>;
+			domain-idle-states = <&CLUSTER_SLEEP_0 &CX_RET &CLUSTER_SLEEP_1>;
+		};
+	};
+
+	firmware {
+		scm: scm {
+			compatible = "qcom,scm-sdx75", "qcom,scm";
+		};
+	};
+
+	pmu {
+		compatible = "arm,armv8-pmuv3";
+		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		gunyah_hyp_mem: gunyah-hyp@80000000 {
+			reg = <0x0 0x80000000 0x0 0x800000>;
+			no-map;
+		};
+
+		hyp_elf_package_mem: hyp-elf-package@80800000 {
+			reg = <0x0 0x80800000 0x0 0x200000>;
+			no-map;
+		};
+
+		access_control_db_mem: access-control-db@81380000 {
+			reg = <0x0 0x81380000 0x0 0x80000>;
+			no-map;
+		};
+
+		qteetz_mem: qteetz@814e0000 {
+			reg = <0x0 0x814e0000 0x0 0x2a0000>;
+			no-map;
+		};
+
+		trusted_apps_mem: trusted-apps@81780000 {
+			reg = <0x0 0x81780000 0x0 0xa00000>;
+			no-map;
+		};
+
+		xbl_ramdump_mem: xbl-ramdump@87a00000 {
+			reg = <0x0 0x87a00000 0x0 0x1c0000>;
+			no-map;
+		};
+
+		cpucp_fw_mem: cpucp-fw@87c00000 {
+			reg = <0x0 0x87c00000 0x0 0x100000>;
+			no-map;
+		};
+
+		xbl_dtlog_mem: xbl-dtlog@87d00000 {
+			reg = <0x0 0x87d00000 0x0 0x40000>;
+			no-map;
+		};
+
+		xbl_sc_mem: xbl-sc@87d40000 {
+			reg = <0x0 0x87d40000 0x0 0x40000>;
+			no-map;
+		};
+
+		modem_efs_shared_mem: modem-efs-shared@87d80000 {
+			reg = <0x0 0x87d80000 0x0 0x10000>;
+			no-map;
+		};
+
+		aop_image_mem: aop-image@87e00000 {
+			reg = <0x0 0x87e00000 0x0 0x20000>;
+			no-map;
+		};
+
+		smem_mem: smem@87e20000 {
+			reg = <0x0 0x87e20000 0x0 0xc0000>;
+			no-map;
+		};
+
+		aop_cmd_db_mem: aop-cmd-db@87ee0000 {
+			compatible = "qcom,cmd-db";
+			reg = <0x0 0x87ee0000 0x0 0x20000>;
+			no-map;
+		};
+
+		aop_config_mem: aop-config@87f00000 {
+			reg = <0x0 0x87f00000 0x0 0x20000>;
+			no-map;
+		};
+
+		ipa_fw_mem: ipa-fw@87f20000 {
+			reg = <0x0 0x87f20000 0x0 0x10000>;
+			no-map;
+		};
+
+		secdata_mem: secdata@87f30000 {
+			reg = <0x0 0x87f30000 0x0 0x1000>;
+			no-map;
+		};
+
+		tme_crashdump_mem: tme-crashdump@87f31000 {
+			reg = <0x0 0x87f31000 0x0 0x40000>;
+			no-map;
+		};
+
+		tme_log_mem: tme-log@87f71000 {
+			reg = <0x0 0x87f71000 0x0 0x4000>;
+			no-map;
+		};
+
+		uefi_log_mem: uefi-log@87f75000 {
+			reg = <0x0 0x87f75000 0x0 0x10000>;
+			no-map;
+		};
+
+		qdss_mem: qdss@88800000 {
+			reg = <0x0 0x88800000 0x0 0x300000>;
+			no-map;
+		};
+
+		audio_heap_mem: audio-heap@88b00000 {
+			compatible = "shared-dma-pool";
+			reg = <0x0 0x88b00000 0x0 0x400000>;
+			no-map;
+		};
+
+		mpss_dsmharq_mem: mpss-dsmharq@88f00000 {
+			reg = <0x0 0x88f00000 0x0 0x5080000>;
+			no-map;
+		};
+
+		q6_mpss_dtb_mem: q6-mpss-dtb@8df80000 {
+			reg = <0x0 0x8df80000 0x0 0x80000>;
+			no-map;
+		};
+
+		mpssadsp_mem: mpssadsp@8e000000 {
+			reg = <0x0 0x8e000000 0x0 0xf400000>;
+			no-map;
+		};
+
+		gunyah_trace_buffer_mem: gunyah-trace-buffer@bdb00000 {
+			reg = <0x0 0xbdb00000 0x0 0x2000000>;
+			no-map;
+		};
+
+		smmu_debug_buf_mem: smmu-debug-buf@bfb00000 {
+			reg = <0x0 0xbfb00000 0x0 0x100000>;
+			no-map;
+		};
+
+		hyp_smmu_s2_pt_mem: hyp-smmu-s2-pt@bfc00000 {
+			reg = <0x0 0xbfc00000 0x0 0x400000>;
+			no-map;
+		};
+	};
+
+	smem: qcom,smem {
+		compatible = "qcom,smem";
+		memory-region = <&smem_mem>;
+		hwlocks = <&tcsr_mutex 3>;
+	};
+
+	soc: soc {
+		compatible = "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges = <0 0 0 0 0x10 0>;
+		dma-ranges = <0 0 0 0 0x10 0>;
+
+		tcsr_mutex: hwlock@1f40000 {
+			compatible = "qcom,tcsr-mutex";
+			reg = <0x0 0x01f40000 0x0 0x40000>;
+			#hwlock-cells = <1>;
+		};
+
+		pdc: interrupt-controller@b220000 {
+			compatible = "qcom,sdx75-pdc", "qcom,pdc";
+			reg = <0x0 0xb220000 0x0 0x30000>,
+			      <0x0 0x174000f0 0x0 0x64>;
+			qcom,pdc-ranges = <0 147 52>,
+					  <52 266 32>,
+					  <84 500 59>;
+			#interrupt-cells = <2>;
+			interrupt-parent = <&intc>;
+			interrupt-controller;
+		};
+
+		tlmm: pinctrl@f000000 {
+			compatible = "qcom,sdx75-tlmm";
+			reg = <0x0 0x0f000000 0x0 0x400000>;
+			interrupts = <GIC_SPI 212 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&tlmm 0 0 133>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			wakeup-parent = <&pdc>;
+		};
+
+		apps_smmu: iommu@15000000 {
+			compatible = "qcom,sdx75-smmu-500", "arm,mmu-500";
+			reg = <0x0 0x15000000 0x0 0x40000>;
+			#iommu-cells = <2>;
+			#global-interrupts = <2>;
+			dma-coherent;
+			interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 298 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 299 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 300 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 301 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 302 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 303 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 304 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 305 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 306 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		intc: interrupt-controller@17200000 {
+			compatible = "arm,gic-v3";
+			#interrupt-cells = <3>;
+			interrupt-controller;
+			#redistributor-regions = <1>;
+			redistributor-stride = <0x0 0x20000>;
+			reg = <0x0 0x17200000 0x0 0x10000>,
+			      <0x0 0x17260000 0x0 0x80000>;
+			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		timer@17420000 {
+			compatible = "arm,armv7-timer-mem";
+			reg = <0x0 0x17420000 0x0 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0 0 0x20000000>;
+
+			frame@17421000 {
+				reg = <0x17421000 0x1000>,
+				      <0x17422000 0x1000>;
+				frame-number = <0>;
+				interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
+			};
+
+			frame@17423000 {
+				reg = <0x17423000 0x1000>;
+				frame-number = <1>;
+				interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
+				status = "disabled";
+			};
+
+			frame@17425000 {
+				reg = <0x17425000 0x1000>;
+				frame-number = <2>;
+				interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
+				status = "disabled";
+			};
+
+			frame@17427000 {
+				reg = <0x17427000 0x1000>;
+				frame-number = <3>;
+				interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
+				status = "disabled";
+			};
+
+			frame@17429000 {
+				reg = <0x17429000 0x1000>;
+				frame-number = <4>;
+				interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
+				status = "disabled";
+			};
+
+			frame@1742b000 {
+				reg = <0x1742b000 0x1000>;
+				frame-number = <5>;
+				interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
+				status = "disabled";
+			};
+
+			frame@1742d000 {
+				reg = <0x1742d000 0x1000>;
+				frame-number = <6>;
+				interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
+				status = "disabled";
+			};
+		};
+
+		apps_rsc: rsc@17a00000 {
+			label = "apps_rsc";
+			compatible = "qcom,rpmh-rsc";
+			reg = <0x0 0x17a00000 0x0 0x10000>,
+			      <0x0 0x17a10000 0x0 0x10000>,
+			      <0x0 0x17a20000 0x0 0x10000>;
+			reg-names = "drv-0", "drv-1", "drv-2";
+			interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
+
+			power-domains = <&CLUSTER_PD>;
+			qcom,tcs-offset = <0xd00>;
+			qcom,drv-id = <2>;
+			qcom,tcs-config = <ACTIVE_TCS    3>,
+					  <SLEEP_TCS     2>,
+					  <WAKE_TCS      2>,
+					  <CONTROL_TCS   0>;
+
+			apps_bcm_voter: bcm_voter {
+				compatible = "qcom,bcm-voter";
+			};
+		};
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 12 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>;
+	};
+};
-- 
2.7.4

