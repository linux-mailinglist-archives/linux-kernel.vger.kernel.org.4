Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 897C75F1943
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 05:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232763AbiJADKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 23:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231261AbiJADHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 23:07:45 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D36F112756B;
        Fri, 30 Sep 2022 20:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1664593635; x=1696129635;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HGeHmBa6YcmbjD9Y00yOaHackZg+P1/x9KaKApAyEZo=;
  b=gWh6q09YlnxvwmfIuPbZOCTAj9E50wNwYLyZcmKurANS2LGLxyRtIAm0
   Eq5hIMXbpCJ1aglytfLBkPdz3YgwkQzrzTSESN4gop0MU31ow2SYcKUyi
   yA9sNg/yHHasVZq1UyaNYnnk5V+FCYxxRHHt3Z9Dzm2OjF7WCJrtM2IZF
   0=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 30 Sep 2022 20:07:12 -0700
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2022 20:07:12 -0700
Received: from hu-molvera-sd.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Fri, 30 Sep 2022 20:07:12 -0700
From:   Melody Olvera <quic_molvera@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Melody Olvera <quic_molvera@quicinc.com>
Subject: [PATCH 01/19] arm64: dts: qcom: Add base QDU1000/QRU1000 DTSIs
Date:   Fri, 30 Sep 2022 20:06:38 -0700
Message-ID: <20221001030656.29365-2-quic_molvera@quicinc.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221001030656.29365-1-quic_molvera@quicinc.com>
References: <20221001030656.29365-1-quic_molvera@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the base DTSI files for QDU1000 and QRU1000 SoCs, including base
descriptions of CPUs, GCC, RPMHCC, UART, and interrupt-controller to
boot to shell with console on these SoCs.

Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
---
 arch/arm64/boot/dts/qcom/qdru1000.dtsi | 370 +++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/qdu1000.dtsi  |  10 +
 arch/arm64/boot/dts/qcom/qru1000.dtsi  |  10 +
 3 files changed, 390 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/qdru1000.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/qdu1000.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/qru1000.dtsi

diff --git a/arch/arm64/boot/dts/qcom/qdru1000.dtsi b/arch/arm64/boot/dts/qcom/qdru1000.dtsi
new file mode 100644
index 000000000000..3610f94bef35
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/qdru1000.dtsi
@@ -0,0 +1,370 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+/*
+ * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/clock/qcom,gcc-qdru1000.h>
+#include <dt-bindings/clock/qcom,rpmh.h>
+#include <dt-bindings/soc/qcom,rpmh-rsc.h>
+
+/ {
+	interrupt-parent = <&intc>;
+
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	chosen: chosen { };
+
+
+	clocks {
+		xo_board: xo_board {
+			compatible = "fixed-clock";
+			clock-frequency = <19200000>;
+			clock-output-names = "xo_board";
+			#clock-cells = <0>;
+		};
+
+		sleep_clk: sleep_clk {
+			compatible = "fixed-clock";
+			clock-frequency = <32000>;
+			#clock-cells = <0>;
+		};
+	};
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
+			power-domain-names = "psci";
+			power-domains = <&CPU_PD0>;
+			next-level-cache = <&L2_0>;
+			L2_0: l2-cache {
+			      compatible = "cache";
+			      next-level-cache = <&L3_0>;
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
+			      compatible = "cache";
+			      next-level-cache = <&L3_0>;
+			};
+
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
+			      compatible = "cache";
+			      next-level-cache = <&L3_0>;
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
+			      compatible = "cache";
+			      next-level-cache = <&L3_0>;
+			};
+
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
+		SILVER_OFF: silver-c4 {  /* C4 */
+			compatible = "arm,idle-state";
+			idle-state-name = "rail-pc";
+			entry-latency-us = <274>;
+			exit-latency-us = <480>;
+			min-residency-us = <3934>;
+			arm,psci-suspend-param = <0x40000004>;
+			local-timer-stop;
+		};
+
+		CLUSTER_PWR_DN: cluster-d4 { /* D4 */
+			compatible = "domain-idle-state";
+			idle-state-name = "l3-off";
+			entry-latency-us = <584>;
+			exit-latency-us = <2332>;
+			min-residency-us = <6118>;
+			arm,psci-suspend-param = <0x41000044>;
+		};
+
+		APSS_OFF: cluster-e3 { /* E3 */
+			compatible = "domain-idle-state";
+			idle-state-name = "llcc-off";
+			entry-latency-us = <2893>;
+			exit-latency-us = <4023>;
+			min-residency-us = <9987>;
+			arm,psci-suspend-param = <0x41003344>;
+		};
+	};
+
+	firmware {
+		qcom_scm {
+			compatible = "qcom,scm-qdu100", "qcom.scm-qru1000", "qcom,scm";
+			#reset-cells = <1>;
+		};
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		/* We expect the bootloader to fill in the size */
+		reg = <0x0 0x80000000 0x0 0x0>;
+	};
+
+	pmu {
+		compatible = "arm,armv8-pmuv3";
+		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	psci {
+		compatible = "arm,psci-1.0";
+		method = "smc";
+
+		CPU_PD0: cpu-pd0 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER_PD>;
+			domain-idle-states = <&SILVER_OFF>;
+		};
+
+		CPU_PD1: cpu-pd1 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER_PD>;
+			domain-idle-states = <&SILVER_OFF>;
+		};
+
+		CPU_PD2: cpu-pd2 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER_PD>;
+			domain-idle-states = <&SILVER_OFF>;
+		};
+
+		CPU_PD3: cpu-pd3 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER_PD>;
+			domain-idle-states = <&SILVER_OFF>;
+		};
+
+		CLUSTER_PD: cluster-pd {
+			#power-domain-cells = <0>;
+			domain-idle-states = <&CLUSTER_PWR_DN &APSS_OFF>;
+		};
+	};
+
+	soc: soc@0 {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges = <0 0 0 0 0x10 0>;
+		dma-ranges = <0 0 0 0 0x10 0>;
+		compatible = "simple-bus";
+
+		gcc: clock-controller@80000 {
+			compatible = "qcom,gcc-qdu1000", "qcom,gcc-qru1000", "syscon";
+			reg = <0x0 0x80000 0x0 0x1f4200>;
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+			#power-domain-cells = <1>;
+			clocks = <&rpmhcc RPMH_CXO_CLK>, <&sleep_clk>;
+			clock-names = "bi_tcxo", "sleep_clk";
+		};
+
+		qupv3_id_0: geniqup@9c0000 {
+			compatible = "qcom,geni-se-qup";
+			reg = <0x0 0x9c0000 0x0 0x2000>;
+			clock-names = "m-ahb", "s-ahb";
+			clocks = <&gcc GCC_QUPV3_WRAP_0_M_AHB_CLK>,
+				<&gcc GCC_QUPV3_WRAP_0_S_AHB_CLK>;
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+			status = "disabled";
+
+			uart7: serial@99c000 {
+				compatible = "qcom,geni-debug-uart";
+				reg = <0x0 0x99c000 0x0 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP0_S7_CLK>;
+				interrupts = <GIC_SPI 608 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+		};
+
+		tcsr_mutex: hwlock@1f40000 {
+			compatible = "qcom,tcsr-mutex";
+			reg = <0x0 0x1f40000 0x0 0x20000>;
+			#hwlock-cells = <1>;
+		};
+
+		pdc: interrupt-controller@b220000 {
+			compatible = "qcom,pdc";
+			reg = <0x0 0xb220000 0x0 0x30000>, <0x0 0x174000f0 0x0 0x64>;
+			reg-names = "pdc-interrupt-base", "apss-shared-spi-cfg";
+			qcom,pdc-ranges = <0 480 12>, <14 494 24>, <40 520 54>,
+					  <94 609 31>, <125 63 1>;
+			#interrupt-cells = <2>;
+			interrupt-parent = <&intc>;
+			interrupt-controller;
+		};
+
+		intc: interrupt-controller@17200000 {
+			compatible = "arm,gic-v3";
+			#interrupt-cells = <3>;
+			interrupt-controller;
+			#redistributor-regions = <1>;
+			redistributor-stride = <0x0 0x20000>;
+			reg = <0x0 0x17200000 0x0 0x10000>,	/* GICD */
+			      <0x0 0x17260000 0x0 0x80000>;	/* GICR * 4 */
+			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_LOW>;
+		};
+
+		timer@17420000 {
+			compatible = "arm,armv7-timer-mem";
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+			reg = <0x0 0x17420000 0x0 0x1000>;
+			clock-frequency = <19200000>;
+
+			frame@17421000 {
+				frame-number = <0>;
+				interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
+				reg = <0x0 0x17421000 0x0 0x1000>,
+				      <0x0 0x17422000 0x0 0x1000>;
+			};
+
+			frame@17423000 {
+				frame-number = <1>;
+				interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
+				reg = <0x0 0x17423000 0x0 0x1000>;
+				status = "disabled";
+			};
+
+			frame@17425000 {
+				frame-number = <2>;
+				interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
+				reg = <0x0 0x17425000 0x0 0x1000>,
+				      <0x0 0x17426000 0x0 0x1000>;
+				status = "disabled";
+			};
+
+			frame@17427000 {
+				frame-number = <3>;
+				interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
+				reg = <0x0 0x17427000 0x0 0x1000>;
+				status = "disabled";
+			};
+
+			frame@17429000 {
+				frame-number = <4>;
+				interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
+				reg = <0x0 0x17429000 0x0 0x1000>;
+				status = "disabled";
+			};
+
+			frame@1742b000 {
+				frame-number = <5>;
+				interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
+				reg = <0x0 0x1742b000 0x0 0x1000>;
+				status = "disabled";
+			};
+
+			frame@1742d000 {
+				frame-number = <6>;
+				interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
+				reg = <0x0 0x1742d000 0x0 0x1000>;
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
+				     <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
+			qcom,tcs-offset = <0xd00>;
+			qcom,drv-id = <2>;
+			qcom,tcs-config = <ACTIVE_TCS    2>, <SLEEP_TCS     3>,
+					  <WAKE_TCS      3>, <CONTROL_TCS   0>;
+
+			apps_bcm_voter: bcm_voter {
+				compatible = "qcom,bcm-voter";
+			};
+
+			rpmhcc: clock-controller {
+				compatible = "qcom,qdu1000-rpmh-clk", "qcom,qru1000-rpmh-clk";
+				#clock-cells = <1>;
+				clock-names = "xo";
+				clocks = <&xo_board>;
+			};
+		};
+
+		arch_timer: timer {
+			compatible = "arm,armv8-timer";
+			interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
+				     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
+				     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
+				     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
+				     <GIC_PPI 12 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>;
+			clock-frequency = <19200000>;
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/qcom/qdu1000.dtsi b/arch/arm64/boot/dts/qcom/qdu1000.dtsi
new file mode 100644
index 000000000000..ba195e7ffc38
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/qdu1000.dtsi
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+/*
+ * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include "qdru1000.dtsi"
+
+/ {
+	qcom,msm-id = <545 0x10000>, <587 0x10000>;
+};
diff --git a/arch/arm64/boot/dts/qcom/qru1000.dtsi b/arch/arm64/boot/dts/qcom/qru1000.dtsi
new file mode 100644
index 000000000000..1639a4b3c1fb
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/qru1000.dtsi
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+/*
+ * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include "qdru1000.dtsi"
+
+/ {
+	qcom,msm-id = <539 0x10000>, <588 0x10000>, <589 0x10000>, <590 0x10000>;
+};
-- 
2.37.3

