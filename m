Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 844DB625A27
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 13:03:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233755AbiKKMDJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 07:03:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233800AbiKKMCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 07:02:23 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ECD083BB1;
        Fri, 11 Nov 2022 04:02:18 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 866EF6602A70;
        Fri, 11 Nov 2022 12:02:15 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1668168136;
        bh=NPGEr8qvt6FoYxM6sNRz9AvLpzkroiDAMNHMiS+xFys=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PdybzW6hzgcmDMCACuI6M92HOaSj2W1FgcaiYaShJoZmve8pRD2NfijWYOS5SctUa
         kh7MF1Wx+okrTfo1E4DHDfOx8Tmis0nBm9xNPcedHpKWXMkJ/F5IgsZQl5kGwKC5OB
         NtJb4yG+dxVrgTD5deOkgVpMuFEgR/aNch0NMHoku56jcqG4KrbXuyyKmR2aJH8VFd
         wtMhobKR75zH4jiWF26BVrTSGARWlkSi3esnDRM+iq6KjW2cR7aiAyvz+BLdVZoAvS
         OIynJ5oBhzRfXtZKOrs7TyMBHQerq6BilJLCLozkpJJVeHIvSI9L1VBU+RISSI7Z5e
         5w/XjOb7+BNtQ==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     agross@kernel.org
Cc:     andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jassisinghbrar@gmail.com,
        srinivas.kandagatla@linaro.org, jic23@kernel.org, lars@metafoo.de,
        keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com,
        evgreen@chromium.org, gregkh@linuxfoundation.org,
        a39.skl@gmail.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-hardening@vger.kernel.org,
        marijn.suijten@somainline.org, kernel@collabora.com,
        luca@z3ntu.xyz,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: [PATCH v2 10/11] arm64: dts: qcom: Add DTS for MSM8976 and MSM8956 SoCs
Date:   Fri, 11 Nov 2022 13:01:55 +0100
Message-Id: <20221111120156.48040-11-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221111120156.48040-1-angelogioacchino.delregno@collabora.com>
References: <20221111120156.48040-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds device trees for MSM8956 and MSM8976 SoCs.
They are *almost* identical, with minor differences, such as
MSM8956 having two A72 cores less.

However, there is a bug in Sony Loire bootloader that requires presence
of all 8 cores in the cpu{} node, so these will not be deleted.

Co-developed-by: Konrad Dybcio <konrad.dybcio@somainline.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
Co-developed-by: Marijn Suijten <marijn.suijten@somainline.org>
Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/boot/dts/qcom/msm8956.dtsi |   18 +
 arch/arm64/boot/dts/qcom/msm8976.dtsi | 1198 +++++++++++++++++++++++++
 2 files changed, 1216 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/msm8956.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/msm8976.dtsi

diff --git a/arch/arm64/boot/dts/qcom/msm8956.dtsi b/arch/arm64/boot/dts/qcom/msm8956.dtsi
new file mode 100644
index 000000000000..e432512d8716
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/msm8956.dtsi
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2016-2022, AngeloGioacchino Del Regno
+ *                          <angelogioacchino.delregno@collabora.com>
+ * Copyright (c) 2022, Konrad Dybcio <konrad.dybcio@somainline.org>
+ * Copyright (c) 2022, Marijn Suijten <marijn.suijten@somainline.org>
+ */
+
+#include "msm8976.dtsi"
+
+&pmu {
+	interrupts = <GIC_PPI 7 (GIC_CPU_MASK_SIMPLE(6) | IRQ_TYPE_LEVEL_HIGH)>;
+};
+
+/*
+ * You might be wondering.. why is it so empty out there?
+ * Well, the SoCs are almost identical.
+ */
diff --git a/arch/arm64/boot/dts/qcom/msm8976.dtsi b/arch/arm64/boot/dts/qcom/msm8976.dtsi
new file mode 100644
index 000000000000..d621d3c9ab3b
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/msm8976.dtsi
@@ -0,0 +1,1198 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2016-2022, AngeloGioacchino Del Regno
+ *                          <angelogioacchino.delregno@collabora.com>
+ * Copyright (c) 2022, Konrad Dybcio <konrad.dybcio@somainline.org>
+ * Copyright (c) 2022, Marijn Suijten <marijn.suijten@somainline.org>
+ */
+
+#include <dt-bindings/clock/qcom,gcc-msm8976.h>
+#include <dt-bindings/clock/qcom,rpmcc.h>
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/power/qcom-rpmpd.h>
+
+/ {
+	interrupt-parent = <&intc>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	chosen { };
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		CPU0: cpu@0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			reg = <0x0>;
+			enable-method = "psci";
+			cpu-idle-states = <&little_cpu_sleep_0>;
+			capacity-dmips-mhz = <573>;
+			next-level-cache = <&l2_0>;
+			#cooling-cells = <2>;
+		};
+
+		CPU1: cpu@1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			reg = <0x1>;
+			enable-method = "psci";
+			cpu-idle-states = <&little_cpu_sleep_0>;
+			capacity-dmips-mhz = <573>;
+			next-level-cache = <&l2_0>;
+			#cooling-cells = <2>;
+		};
+
+		CPU2: cpu@2 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			reg = <0x2>;
+			enable-method = "psci";
+			cpu-idle-states = <&little_cpu_sleep_0>;
+			capacity-dmips-mhz = <573>;
+			next-level-cache = <&l2_0>;
+			#cooling-cells = <2>;
+		};
+
+		CPU3: cpu@3 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			reg = <0x3>;
+			enable-method = "psci";
+			cpu-idle-states = <&little_cpu_sleep_0>;
+			capacity-dmips-mhz = <573>;
+			next-level-cache = <&l2_0>;
+			#cooling-cells = <2>;
+		};
+
+		CPU4: cpu@100 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a72";
+			reg = <0x100>;
+			enable-method = "psci";
+			cpu-idle-states = <&big_cpu_sleep_0 &big_cpu_sleep_1>;
+			capacity-dmips-mhz = <1024>;
+			next-level-cache = <&l2_1>;
+			#cooling-cells = <2>;
+		};
+
+		CPU5: cpu@101 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a72";
+			reg = <0x101>;
+			enable-method = "psci";
+			cpu-idle-states = <&big_cpu_sleep_0 &big_cpu_sleep_1>;
+			capacity-dmips-mhz = <1024>;
+			next-level-cache = <&l2_1>;
+			#cooling-cells = <2>;
+		};
+
+		CPU6: cpu@102 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a72";
+			reg = <0x102>;
+			enable-method = "psci";
+			cpu-idle-states = <&big_cpu_sleep_0 &big_cpu_sleep_1>;
+			capacity-dmips-mhz = <1024>;
+			next-level-cache = <&l2_1>;
+			#cooling-cells = <2>;
+		};
+
+		CPU7: cpu@103 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a72";
+			reg = <0x103>;
+			enable-method = "psci";
+			cpu-idle-states = <&big_cpu_sleep_0 &big_cpu_sleep_1>;
+			capacity-dmips-mhz = <1024>;
+			next-level-cache = <&l2_1>;
+			#cooling-cells = <2>;
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
+
+			cluster1 {
+				core0 {
+					cpu = <&CPU4>;
+				};
+
+				core1 {
+					cpu = <&CPU5>;
+				};
+
+				core2 {
+					cpu = <&CPU6>;
+				};
+
+				core3 {
+					cpu = <&CPU7>;
+				};
+			};
+		};
+
+		idle-states {
+			entry-method = "psci";
+
+			little_cpu_sleep_0: cpu-sleep-0-0 {
+				compatible = "arm,idle-state";
+				idle-state-name = "little-power-collapse";
+				arm,psci-suspend-param = <0x40000003>;
+				entry-latency-us = <181>;
+				exit-latency-us = <149>;
+				min-residency-us = <703>;
+				local-timer-stop;
+			};
+
+			big_cpu_sleep_0: cpu-sleep-1-0 {
+				compatible = "arm,idle-state";
+				idle-state-name = "big-retention";
+				arm,psci-suspend-param = <0x00000002>;
+				entry-latency-us = <142>;
+				exit-latency-us = <99>;
+				min-residency-us = <242>;
+			};
+
+			big_cpu_sleep_1: cpu-sleep-1-1 {
+				compatible = "arm,idle-state";
+				idle-state-name = "big-power-collapse";
+				arm,psci-suspend-param = <0x40000003>;
+				entry-latency-us = <158>;
+				exit-latency-us = <144>;
+				min-residency-us = <863>;
+				local-timer-stop;
+			};
+		};
+
+		l2_0: l2-cache0 {
+			compatible = "cache";
+			cache-level = <2>;
+		};
+
+		l2_1: l2-cache1 {
+			compatible = "cache";
+			cache-level = <2>;
+		};
+	};
+
+	firmware {
+		scm: scm {
+			compatible = "qcom,scm-msm8976", "qcom,scm";
+			clocks = <&gcc GCC_CRYPTO_CLK>,
+				 <&gcc GCC_CRYPTO_AXI_CLK>,
+				 <&gcc GCC_CRYPTO_AHB_CLK>;
+			clock-names = "core", "bus", "iface";
+			#reset-cells = <1>;
+
+			qcom,dload-mode = <&tcsr 0x6100>;
+		};
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		/* We expect the bootloader to fill in the size */
+		reg = <0x0 0x80000000 0x0 0x0>;
+	};
+
+	pmu: pmu {
+		compatible = "arm,armv8-pmuv3";
+		interrupts = <GIC_PPI 7 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_HIGH)>;
+	};
+
+	psci {
+		compatible = "arm,psci-1.0";
+		method = "smc";
+	};
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		ext-region@85b00000 {
+			reg = <0x0 0x85b00000 0x0 0x500000>;
+			no-map;
+		};
+
+		smem@86300000 {
+			compatible = "qcom,smem";
+			reg = <0x0 0x86300000 0x0 0x100000>;
+			no-map;
+
+			hwlocks = <&tcsr_mutex 3>;
+			qcom,rpm-msg-ram = <&rpm_msg_ram>;
+		};
+
+		reserved@86400000 {
+			reg = <0x0 0x86400000 0x0 0x800000>;
+			no-map;
+		};
+
+		mpss_mem: mpss@86c00000 {
+			reg = <0x0 0x86c00000 0x0 0x5600000>;
+			no-map;
+		};
+
+		lpass_mem: lpass@8c200000 {
+			reg = <0x0 0x8c200000 0x0 0x1800000>;
+			no-map;
+		};
+
+		venus_mem: memory@8da00000 {
+			reg = <0x0 0x8da00000 0x0 0x2600000>;
+			no-map;
+		};
+
+		tz-apps@8dd00000 {
+			reg = <0x0 0x8dd00000 0x0 0x1400000>;
+			no-map;
+		};
+	};
+
+	smp2p-hexagon {
+		compatible = "qcom,smp2p";
+		interrupts = <GIC_SPI 291 IRQ_TYPE_EDGE_RISING>;
+		qcom,ipc = <&apcs 8 10>;
+
+		qcom,local-pid = <0>;
+		qcom,remote-pid = <2>;
+		qcom,smem = <443>, <429>;
+
+		adsp_smp2p_out: master-kernel {
+			qcom,entry-name = "master-kernel";
+
+			#qcom,smem-state-cells = <1>;
+		};
+
+		adsp_smp2p_in: slave-kernel {
+			qcom,entry-name = "slave-kernel";
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+
+	smp2p-modem {
+		compatible = "qcom,smp2p";
+		interrupts = <GIC_SPI 27 IRQ_TYPE_EDGE_RISING>;
+		qcom,ipc = <&apcs 8 13>;
+
+		qcom,local-pid = <0>;
+		qcom,remote-pid = <1>;
+		qcom,smem = <435>, <428>;
+
+		modem_smp2p_out: master-kernel {
+			qcom,entry-name = "master-kernel";
+
+			#qcom,smem-state-cells = <1>;
+		};
+
+		modem_smp2p_in: slave-kernel {
+			qcom,entry-name = "slave-kernel";
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+
+	smp2p-wcnss {
+		compatible = "qcom,smp2p";
+		interrupts = <GIC_SPI 143 IRQ_TYPE_EDGE_RISING>;
+		qcom,ipc = <&apcs 8 17>;
+
+		qcom,local-pid = <0>;
+		qcom,remote-pid = <4>;
+		qcom,smem = <451>, <431>;
+
+		wcnss_smp2p_out: master-kernel {
+			qcom,entry-name = "master-kernel";
+
+			#qcom,smem-state-cells = <1>;
+		};
+
+		wcnss_smp2p_in: slave-kernel {
+			qcom,entry-name = "slave-kernel";
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+
+	smd {
+		compatible = "qcom,smd";
+
+		rpm {
+			interrupts = <GIC_SPI 168 IRQ_TYPE_EDGE_RISING>;
+			qcom,ipc = <&apcs 8 0>;
+			qcom,smd-edge = <15>;
+
+			rpm_requests: rpm-requests {
+				compatible = "qcom,rpm-msm8976";
+				qcom,smd-channels = "rpm_requests";
+
+				rpmcc: clock-controller {
+					compatible = "qcom,rpmcc-msm8976", "qcom,rpmcc";
+					#clock-cells = <1>;
+				};
+
+				rpmpd: power-controller {
+					compatible = "qcom,msm8976-rpmpd";
+					#power-domain-cells = <1>;
+					operating-points-v2 = <&rpmpd_opp_table>;
+
+					rpmpd_opp_table: opp-table {
+						compatible = "operating-points-v2";
+
+						rpmpd_opp_ret: opp1 {
+							opp-level = <RPM_SMD_LEVEL_RETENTION>;
+						};
+
+						rpmpd_opp_ret_plus: opp2 {
+							opp-level = <RPM_SMD_LEVEL_RETENTION_PLUS>;
+						};
+
+						rpmpd_opp_min_svs: opp3 {
+							opp-level = <RPM_SMD_LEVEL_MIN_SVS>;
+						};
+
+						rpmpd_opp_low_svs: opp4 {
+							opp-level = <RPM_SMD_LEVEL_LOW_SVS>;
+						};
+
+						rpmpd_opp_svs: opp5 {
+							opp-level = <RPM_SMD_LEVEL_SVS>;
+						};
+
+						rpmpd_opp_svs_plus: opp6 {
+							opp-level = <RPM_SMD_LEVEL_SVS_PLUS>;
+						};
+
+						rpmpd_opp_nom: opp7 {
+							opp-level = <RPM_SMD_LEVEL_NOM>;
+						};
+
+						rpmpd_opp_nom_plus: opp8 {
+							opp-level = <RPM_SMD_LEVEL_NOM_PLUS>;
+						};
+
+						rpmpd_opp_turbo: opp9 {
+							opp-level = <RPM_SMD_LEVEL_TURBO>;
+						};
+
+						rpmpd_opp_turbo_no_cpr: opp10 {
+							opp-level = <RPM_SMD_LEVEL_TURBO_NO_CPR>;
+						};
+
+						rpmpd_opp_turbo_high: opp111 {
+							opp-level = <RPM_SMD_LEVEL_TURBO_HIGH>;
+						};
+					};
+				};
+			};
+		};
+	};
+
+	smsm {
+		compatible = "qcom,smsm";
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		qcom,ipc-1 = <&apcs 8 12>;
+		qcom,ipc-2 = <&apcs 8 9>;
+		qcom,ipc-3 = <&apcs 8 18>;
+
+		apps_smsm: apps@0 {
+			reg = <0>;
+			#qcom,smem-state-cells = <1>;
+		};
+
+		hexagon_smsm: hexagon@1 {
+			reg = <1>;
+			interrupts = <0 290 IRQ_TYPE_EDGE_RISING>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		wcnss_smsm: wcnss@6 {
+			reg = <6>;
+			interrupts = <GIC_SPI 144 IRQ_TYPE_EDGE_RISING>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+
+	soc: soc@0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0 0 0xffffffff>;
+		compatible = "simple-bus";
+
+		rng@22000 {
+			compatible = "qcom,prng";
+			reg = <0x00022000 0x140>;
+			clocks = <&gcc GCC_PRNG_AHB_CLK>;
+			clock-names = "core";
+		};
+
+		rpm_msg_ram: sram@60000 {
+			compatible = "qcom,rpm-msg-ram";
+			reg = <0x00060000 0x8000>;
+		};
+
+		usb_hs_phy: phy@6c000 {
+			compatible = "qcom,usb-hs-28nm-femtophy";
+			reg = <0x0006c000 0x200>;
+			#phy-cells = <0>;
+			clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>,
+				 <&gcc GCC_USB_HS_PHY_CFG_AHB_CLK>,
+				 <&gcc GCC_USB2A_PHY_SLEEP_CLK>;
+			clock-names = "ref", "ahb", "sleep";
+			resets = <&gcc RST_QUSB2_PHY_BCR>,
+				 <&gcc RST_USB2_HS_PHY_ONLY_BCR>;
+			reset-names = "phy", "por";
+			status = "disabled";
+		};
+
+		qfprom: qfprom@a4000 {
+			compatible = "qcom,msm8976-qfprom", "qcom,qfprom";
+			reg = <0x000a4000 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			tsens_caldata: caldata@218 {
+				reg = <0x218 0x18>;
+			};
+		};
+
+		tsens: thermal-sensor@4a9000 {
+			compatible = "qcom,msm8976-tsens", "qcom,tsens-v1";
+			reg = <0x004a9000 0x1000>, /* TM */
+			      <0x004a8000 0x1000>; /* SROT */
+			interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "uplow";
+			nvmem-cells = <&tsens_caldata>;
+			nvmem-cell-names = "calib";
+			#qcom,sensors = <11>;
+			#thermal-sensor-cells = <1>;
+		};
+
+		tlmm: pinctrl@1000000 {
+			compatible = "qcom,msm8976-pinctrl";
+			reg = <0x01000000 0x300000>;
+			interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
+			#gpio-cells = <2>;
+			gpio-controller;
+			gpio-ranges = <&tlmm 0 0 145>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+
+			spi1_default: spi0-default-state {
+				spi-pins {
+					pins = "gpio0", "gpio1", "gpio3";
+					function = "blsp_spi1";
+					drive-strength = <12>;
+					bias-disable;
+				};
+
+				cs-pins {
+					pins = "gpio2";
+					function = "blsp_spi1";
+					drive-strength = <2>;
+					bias-disable;
+				};
+			};
+
+			spi1_sleep: spi0-sleep-state {
+				spi-pins {
+					pins = "gpio0", "gpio1", "gpio3";
+					function = "gpio";
+					drive-strength = <2>;
+					bias-pull-down;
+				};
+
+				cs-pins {
+					pins = "gpio2";
+					function = "gpio";
+					drive-strength = <2>;
+					bias-disable;
+				};
+			};
+
+			blsp1_i2c2_default: blsp1-i2c2-default-state {
+				pins = "gpio6", "gpio7";
+				function = "blsp_i2c2";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
+			blsp1_i2c2_sleep: blsp1-i2c2-sleep-state {
+				pins = "gpio6", "gpio7";
+				function = "gpio";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
+			blsp1_i2c4_default: blsp1-i2c4-default-state {
+				pins = "gpio14", "gpio15";
+				function = "blsp_i2c4";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
+			blsp1_i2c4_sleep: blsp1-i2c4-sleep-state {
+				pins = "gpio14", "gpio15";
+				function = "gpio";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
+			blsp2_uart2_active: blsp2-uart2-active-state {
+				pins = "gpio20", "gpio21";
+				function = "blsp_uart6";
+				drive-strength = <4>;
+				bias-disable;
+			};
+
+			blsp2_uart2_sleep: blsp2-uart2-sleep-state {
+				pins = "gpio20", "gpio21";
+				function = "gpio";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
+			/* 4 (not 6!) interfaces per QUP, BLSP2 indexes are numbered (n)+4 */
+			blsp2_i2c2_default: blsp2-i2c2-default-state {
+				pins = "gpio22", "gpio23";
+				function = "blsp_i2c6";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
+			blsp2_i2c2_sleep: blsp2-i2c2-sleep-state {
+				pins = "gpio22", "gpio23";
+				function = "gpio";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
+			blsp2_i2c4_default: blsp2-i2c4-default-state {
+				pins = "gpio18", "gpio19";
+				function = "blsp_i2c8";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
+			blsp2_i2c4_sleep: blsp2-i2c4-sleep-state {
+				pins = "gpio18", "gpio19";
+				function = "gpio";
+				drive-strength = <2>;
+				bias-disable;
+			};
+		};
+
+		gcc: clock-controller@1800000 {
+			compatible = "qcom,gcc-msm8976";
+			reg = <0x01800000 0x80000>;
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+			#power-domain-cells = <1>;
+
+			assigned-clocks = <&gcc GPLL3>;
+			assigned-clock-rates = <1100000000>;
+
+			clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>,
+				 <&rpmcc RPM_SMD_XO_A_CLK_SRC>,
+				 <0>,
+				 <0>,
+				 <0>,
+				 <0>;
+			clock-names = "xo",
+				      "xo_a",
+				      "dsi0pll",
+				      "dsi0pllbyte",
+				      "dsi1pll",
+				      "dsi1pllbyte";
+		};
+
+		tcsr_mutex: hwlock@1905000 {
+			compatible = "qcom,tcsr-mutex";
+			reg = <0x01905000 0x20000>;
+			#hwlock-cells = <1>;
+		};
+
+		tcsr: syscon@1937000 {
+			compatible = "qcom,msm8976-tcsr", "syscon";
+			reg = <0x01937000 0x30000>;
+		};
+
+		spmi_bus: spmi@200f000 {
+			compatible = "qcom,spmi-pmic-arb";
+			reg = <0x0200f000 0x1000>,
+			      <0x02400000 0x800000>,
+			      <0x02c00000 0x800000>,
+			      <0x03800000 0x200000>,
+			      <0x0200a000 0x2100>;
+			reg-names = "core", "chnls", "obsrvr", "intr", "cnfg";
+			interrupts = <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "periph_irq";
+			qcom,channel = <0>;
+			qcom,ee = <0>;
+
+			#address-cells = <2>;
+			#size-cells = <0>;
+			interrupt-controller;
+			#interrupt-cells = <4>;
+			cell-index = <0>;
+		};
+
+		sdhc_1: mmc@7824000 {
+			compatible = "qcom,msm8976-sdhci", "qcom,sdhci-msm-v4";
+			reg = <0x07824900 0x500>, <0x07824000 0x800>;
+			reg-names = "hc", "core";
+
+			interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "hc_irq", "pwr_irq";
+
+			clocks = <&gcc GCC_SDCC1_AHB_CLK>,
+				 <&gcc GCC_SDCC1_APPS_CLK>,
+				 <&rpmcc RPM_SMD_XO_CLK_SRC>;
+			clock-names = "iface", "core", "xo";
+			status = "disabled";
+		};
+
+		sdhc_2: mmc@7864000 {
+			compatible = "qcom,msm8976-sdhci", "qcom,sdhci-msm-v4";
+			reg = <0x07864900 0x11c>, <0x07864000 0x800>;
+			reg-names = "hc", "core";
+
+			interrupts = <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 221 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "hc_irq", "pwr_irq";
+
+			clocks = <&gcc GCC_SDCC2_AHB_CLK>,
+				 <&gcc GCC_SDCC2_APPS_CLK>,
+				 <&rpmcc RPM_SMD_XO_CLK_SRC>;
+			clock-names = "iface", "core", "xo";
+			status = "disabled";
+		};
+
+		blsp1_dma: dma-controller@7884000 {
+			compatible = "qcom,bam-v1.7.0";
+			reg = <0x07884000 0x1f000>;
+			interrupts = <GIC_SPI 238 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP1_AHB_CLK>;
+			clock-names = "bam_clk";
+			#dma-cells = <1>;
+			qcom,ee = <0>;
+		};
+
+		blsp1_uart1: serial@78af000 {
+			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
+			reg = <0x078af000 0x200>;
+			interrupts = <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP1_UART1_APPS_CLK>, <&gcc GCC_BLSP1_AHB_CLK>;
+			clock-names = "core", "iface";
+			dmas = <&blsp1_dma 0>, <&blsp1_dma 1>;
+			dma-names = "tx", "rx";
+			status = "disabled";
+		};
+
+		blsp1_uart2: serial@78b0000 {
+			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
+			reg = <0x078b0000 0x200>;
+			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP1_UART2_APPS_CLK>, <&gcc GCC_BLSP1_AHB_CLK>;
+			clock-names = "core", "iface";
+			dmas = <&blsp1_dma 2>, <&blsp1_dma 3>;
+			dma-names = "tx", "rx";
+			status = "disabled";
+		};
+
+		blsp1_spi1: spi@78b5000 {
+			compatible = "qcom,spi-qup-v2.2.1";
+			reg = <0x078b5000 0x500>;
+			interrupts = <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP1_QUP1_SPI_APPS_CLK>, <&gcc GCC_BLSP1_AHB_CLK>;
+			clock-names = "core", "iface";
+			dmas = <&blsp1_dma 4>, <&blsp1_dma 5>;
+			dma-names = "tx", "rx";
+			pinctrl-names = "default", "sleep";
+			pinctrl-0 = <&spi1_default>;
+			pinctrl-1 = <&spi1_sleep>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		blsp1_i2c2: i2c@78b6000 {
+			compatible = "qcom,i2c-qup-v2.2.1";
+			reg = <0x078b6000 0x500>;
+			interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP1_QUP2_I2C_APPS_CLK>, <&gcc GCC_BLSP1_AHB_CLK>;
+			clock-names = "core", "iface";
+			clock-frequency = <400000>;
+			dmas = <&blsp1_dma 6>, <&blsp1_dma 7>;
+			dma-names = "tx", "rx";
+			pinctrl-names = "default", "sleep";
+			pinctrl-0 = <&blsp1_i2c2_default>;
+			pinctrl-1 = <&blsp1_i2c2_default>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		blsp1_i2c4: i2c@78b8000 {
+			compatible = "qcom,i2c-qup-v2.2.1";
+			reg = <0x078b8000 0x500>;
+			interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP1_QUP4_I2C_APPS_CLK>, <&gcc GCC_BLSP1_AHB_CLK>;
+			clock-names = "core", "iface";
+			clock-frequency = <400000>;
+			dmas = <&blsp1_dma 10>, <&blsp1_dma 11>;
+			dma-names = "tx", "rx";
+			pinctrl-names = "default", "sleep";
+			pinctrl-0 = <&blsp1_i2c4_default>;
+			pinctrl-1 = <&blsp1_i2c4_sleep>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		otg: usb@78db000 {
+			compatible = "qcom,ci-hdrc";
+			reg = <0x078db000 0x200>,
+			      <0x078db200 0x200>;
+			interrupts = <GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_USB_HS_AHB_CLK>, <&gcc GCC_USB_HS_SYSTEM_CLK>;
+			clock-names = "iface", "core";
+			assigned-clocks = <&gcc GCC_USB_HS_SYSTEM_CLK>;
+			assigned-clock-rates = <80000000>;
+			resets = <&gcc RST_USB_HS_BCR>;
+			reset-names = "core";
+			ahb-burst-config = <0>;
+			dr_mode = "peripheral";
+			phy_type = "ulpi";
+			phy-names = "usb-phy";
+			phys = <&usb_hs_phy>;
+			status = "disabled";
+			#reset-cells = <1>;
+		};
+
+		sdhc_3: mmc@7a24000 {
+			compatible = "qcom,msm8976-sdhci", "qcom,sdhci-msm-v4";
+			reg = <0x07a24900 0x11c>, <0x07a24000 0x800>;
+			reg-names = "hc", "core";
+
+			interrupts = <GIC_SPI 295 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 297 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "hc_irq", "pwr_irq";
+
+			clocks = <&gcc GCC_SDCC3_AHB_CLK>,
+				 <&gcc GCC_SDCC3_APPS_CLK>,
+				 <&rpmcc RPM_SMD_XO_CLK_SRC>;
+			clock-names = "iface", "core", "xo";
+
+			status = "disabled";
+		};
+
+		blsp2_dma: dma-controller@7ac4000 {
+			compatible = "qcom,bam-v1.7.0";
+			reg = <0x07ac4000 0x1f000>;
+			interrupts = <GIC_SPI 239 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP2_AHB_CLK>;
+			clock-names = "bam_clk";
+			#dma-cells = <1>;
+			qcom,ee = <0>;
+		};
+
+		blsp2_uart2: serial@7af0000 {
+			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
+			reg = <0x07af0000 0x200>;
+			interrupts = <GIC_SPI 307 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP2_UART2_APPS_CLK>, <&gcc GCC_BLSP2_AHB_CLK>;
+			clock-names = "core", "iface";
+			dmas = <&blsp2_dma 0>, <&blsp2_dma 1>;
+			dma-names = "tx", "rx";
+			status = "disabled";
+		};
+
+		blsp2_i2c2: i2c@7af6000 {
+			compatible = "qcom,i2c-qup-v2.2.1";
+			reg = <0x07af6000 0x600>;
+			interrupts = <GIC_SPI 300 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP2_QUP2_I2C_APPS_CLK>, <&gcc GCC_BLSP2_AHB_CLK>;
+			clock-names = "core", "iface";
+			clock-frequency = <400000>;
+			dmas = <&blsp2_dma 6>, <&blsp2_dma 7>;
+			dma-names = "tx", "rx";
+			pinctrl-names = "default", "sleep";
+			pinctrl-0 = <&blsp2_i2c2_default>;
+			pinctrl-1 = <&blsp2_i2c2_sleep>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		blsp2_i2c4: i2c@7af8000 {
+			compatible = "qcom,i2c-qup-v2.2.1";
+			reg = <0x07af8000 0x600>;
+			interrupts = <GIC_SPI 302 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP2_QUP4_I2C_APPS_CLK>, <&gcc GCC_BLSP2_AHB_CLK>;
+			clock-names = "core", "iface";
+			clock-frequency = <400000>;
+			dmas = <&blsp2_dma 10>, <&blsp2_dma 11>;
+			dma-names = "tx", "rx";
+			pinctrl-names = "default", "sleep";
+			pinctrl-0 = <&blsp2_i2c4_default>;
+			pinctrl-1 = <&blsp2_i2c4_sleep>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		intc: interrupt-controller@b000000 {
+			compatible = "qcom,msm-qgic2";
+			reg = <0x0b000000 0x1000>, <0x0b002000 0x1000>;
+			interrupt-controller;
+			#interrupt-cells = <3>;
+		};
+
+		apcs: mailbox@b011000 {
+			compatible = "qcom,msm8976-apcs-kpss-global", "syscon";
+			reg = <0x0b011000 0x1000>;
+			#mbox-cells = <1>;
+		};
+
+		timer@b120000 {
+			compatible = "arm,armv7-timer-mem";
+			reg = <0x0b120000 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+			clock-frequency = <19200000>;
+
+			frame@b121000 {
+				reg = <0x0b121000 0x1000>, <0x0b122000 0x1000>;
+				interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
+				frame-number = <0>;
+			};
+
+			frame@b123000 {
+				reg = <0x0b123000 0x1000>;
+				interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
+				frame-number = <1>;
+				status = "disabled";
+			};
+
+			frame@b124000 {
+				reg = <0x0b124000 0x1000>;
+				interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
+				frame-number = <2>;
+				status = "disabled";
+			};
+
+			frame@b125000 {
+				reg = <0x0b125000 0x1000>;
+				interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
+				frame-number = <3>;
+				status = "disabled";
+			};
+
+			frame@b126000 {
+				reg = <0x0b126000 0x1000>;
+				interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
+				frame-number = <4>;
+				status = "disabled";
+			};
+
+			frame@b127000 {
+				reg = <0x0b127000 0x1000>;
+				interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
+				frame-number = <5>;
+				status = "disabled";
+			};
+
+			frame@b128000 {
+				reg = <0x0b128000 0x1000>;
+				interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
+				frame-number = <6>;
+				status = "disabled";
+			};
+		};
+
+		imem: sram@8600000 {
+			compatible = "qcom,msm8976-imem", "syscon", "simple-mfd";
+			reg = <0x08600000 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			ranges = <0 0x08600000 0x1000>;
+
+			pil-reloc@94c {
+				compatible = "qcom,pil-reloc-info";
+				reg = <0x94c 0xc8>;
+			};
+		};
+	};
+
+	thermal-zones {
+		aoss0-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens 0>;
+
+			trips {
+				aoss0_alert0: trip-point0 {
+					temperature = <75000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+			};
+		};
+
+		modem-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens 1>;
+			trips {
+				modem_alert0: trip-point0 {
+					temperature = <75000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+			};
+		};
+
+		qdsp-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens 2>;
+			trips {
+				qdsp_alert0: trip-point0 {
+					temperature = <75000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+			};
+		};
+
+		cam-isp-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens 3>;
+			trips {
+				cam_isp_alert0: trip-point0 {
+					temperature = <75000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+			};
+		};
+
+		cpu4-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+			thermal-sensors = <&tsens 4>;
+
+			trips {
+				cpu4_alert0: trip-point0 {
+					temperature = <50000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+				cpu4_alert1: trip-point1 {
+					temperature = <55000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+				cpu4_crit: cpu-crit {
+					temperature = <75000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+
+		cpu5-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+			thermal-sensors = <&tsens 5>;
+
+			trips {
+				cpu5_alert0: trip-point0 {
+					temperature = <50000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+				cpu5_alert1: trip-point1 {
+					temperature = <55000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+				cpu5_crit: cpu-crit {
+					temperature = <75000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+
+		cpu6-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+			thermal-sensors = <&tsens 6>;
+
+			trips {
+				cpu6_alert0: trip-point0 {
+					temperature = <50000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+				cpu6_alert1: trip-point1 {
+					temperature = <55000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+				cpu6_crit: cpu-crit {
+					temperature = <75000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+
+		cpu7-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+			thermal-sensors = <&tsens 7>;
+
+			trips {
+				cpu7_alert0: trip-point0 {
+					temperature = <50000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+				cpu7_alert1: trip-point1 {
+					temperature = <55000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+				cpu7_crit: cpu-crit {
+					temperature = <75000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+
+		big-l2-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+			thermal-sensors = <&tsens 8>;
+
+			trips {
+				l2_alert0: trip-point0 {
+					temperature = <50000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+				l2_alert1: trip-point1 {
+					temperature = <55000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+				l2_crit: l2-crit {
+					temperature = <75000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+
+		cpu0-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+			thermal-sensors = <&tsens 9>;
+
+			trips {
+				cpu0_alert0: trip-point0 {
+					temperature = <50000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+				cpu0_alert1: trip-point1 {
+					temperature = <55000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+				cpu0_crit: cpu-crit {
+					temperature = <75000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+
+		gpu-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+			thermal-sensors = <&tsens 10>;
+
+			trips {
+				gpu_alert0: trip-point0 {
+					temperature = <50000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+				gpu_alert1: trip-point1 {
+					temperature = <55000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+				gpu_crit: gpu-crit {
+					temperature = <75000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupts = <GIC_PPI 2 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 3 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 4 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 1 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>;
+		clock-frequency = <19200000>;
+	};
+};
-- 
2.38.1

