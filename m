Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10F5761F26A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 13:06:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231893AbiKGMGL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 07:06:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231600AbiKGMGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 07:06:05 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 136CE186F9
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 04:06:03 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id j16so16399013lfe.12
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 04:06:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=06Bp89pIv/hMD+RiIU9L2+JZc/5tQ06I49Az52SmE3c=;
        b=zwsBn7aeuaLIn1maMCzQQcQZsvnKhy+i3HHfJMUz27vQh9kkqpR0YJITJf2eCCLuzv
         gZUf2sWDw/M+JbTStCmaI6jwwSYJfjh6xTaJjiF8eUM4cvZMObnfRP102UipierSgF3F
         295cjLoemr8yU0sSg1jqK+FatPob83GgJHhwbOg8gUtgdYVKzkWESzf745doBkJmOUKW
         wb5P5x3NiYYOXn39SECFiH/8/bS9ngeeDx8Wf6PxmyuTE3/Sxvn35E27aj4yGdIbjQyT
         h5fXBA47KSjz7U4ovPBzHajMN8zy75DKdV0nAIZoavE62RUSIu6k4ZucfnVX9Bupu4Uj
         B86g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=06Bp89pIv/hMD+RiIU9L2+JZc/5tQ06I49Az52SmE3c=;
        b=JP1OefmJo2D4doM2F0PWr+m+P4szzHUt+Q84aQjHIYIw3qmT2ictbue7KzivuEdSex
         K4Q474/7N//DXQG31xs+FbwLiDosEvEKlTrF3+mcW7mhWR12DLUgsWM5ItifK129M5h2
         ohobG4JKfss7Q3x7HJxfezrW93q3JMBbk7dkyvWzTDA5uIceg6G6pMvXo/hDh1iD9UGH
         thScJo7mOguqUagnpkNQG5URHAxsEOfB57GonMnHAJteGn0OJls+gats/fKWX6HToWzu
         ovP2Ru2zCoZ7tgDiKS/My66wXXDHgyen22FKMu6YUVjwh3XP+fqSR8PSyrGyuWh9T7mA
         jTgQ==
X-Gm-Message-State: ACrzQf1bLsTMx+qlMBWZEgR64RHfzwvBMOMD9bz1sJkaY87Mz2azidIy
        Z2bfOws65a93Y+vsfWJ5YHsAyw==
X-Google-Smtp-Source: AMsMyM4deYB3X/1tpAHYd+MWsH1EKZjvb/xUvRe5gAiy84TyqqwCr6SMQDKTJofikP09/j88Z3/K0g==
X-Received: by 2002:ac2:58ca:0:b0:4a2:7bb1:ad61 with SMTP id u10-20020ac258ca000000b004a27bb1ad61mr18163415lfo.212.1667822761274;
        Mon, 07 Nov 2022 04:06:01 -0800 (PST)
Received: from localhost.localdomain ([194.29.137.22])
        by smtp.gmail.com with ESMTPSA id p13-20020ac24ecd000000b0049936272173sm1200065lfr.204.2022.11.07.04.05.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 07 Nov 2022 04:06:00 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org
Cc:     patches@linaro.org, Konrad Dybcio <konrad.dybcio@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Chanho Park <chanho61.park@samsung.com>,
        Thierry Reding <treding@nvidia.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] arm64: dts: qcom: Add initial device tree for SM6375
Date:   Mon,  7 Nov 2022 13:05:36 +0100
Message-Id: <20221107120539.12305-3-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20221107120539.12305-1-konrad.dybcio@linaro.org>
References: <20221107120539.12305-1-konrad.dybcio@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Konrad Dybcio <konrad.dybcio@somainline.org>

Add an initial device tree for the SM6375 (SD695) SoC.

Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Changes since v1:
- Add second s-o-b
- Collapse the smem node into its mem region
- Use non-generic node names for reserved-memory children
- Feed rpmcc the xo clock
- Remove clock-output-names from xo
- Rename xo-board to xo-board-clk and remove clk-output-names
- Move xo clk freq to device DTS

 arch/arm64/boot/dts/qcom/sm6375.dtsi | 804 +++++++++++++++++++++++++++
 1 file changed, 804 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/sm6375.dtsi

diff --git a/arch/arm64/boot/dts/qcom/sm6375.dtsi b/arch/arm64/boot/dts/qcom/sm6375.dtsi
new file mode 100644
index 000000000000..9b1a497e5ca7
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sm6375.dtsi
@@ -0,0 +1,804 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2022, Konrad Dybcio <konrad.dybcio@somainline.org>
+ */
+
+#include <dt-bindings/clock/qcom,rpmcc.h>
+#include <dt-bindings/clock/qcom,sm6375-gcc.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/mailbox/qcom-ipcc.h>
+#include <dt-bindings/power/qcom-rpmpd.h>
+
+/ {
+	interrupt-parent = <&intc>;
+
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	chosen { };
+
+	clocks {
+		xo_board_clk: xo-board-clk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+		};
+
+		sleep_clk: sleep-clk {
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
+			compatible = "qcom,kryo660";
+			reg = <0x0 0x0>;
+			enable-method = "psci";
+			next-level-cache = <&L2_0>;
+			qcom,freq-domain = <&cpufreq_hw 0>;
+			power-domains = <&CPU_PD0>;
+			power-domain-names = "psci";
+			#cooling-cells = <2>;
+			L2_0: l2-cache {
+			      compatible = "cache";
+			      next-level-cache = <&L3_0>;
+				L3_0: l3-cache {
+				      compatible = "cache";
+				};
+			};
+		};
+
+		CPU1: cpu@100 {
+			device_type = "cpu";
+			compatible = "qcom,kryo660";
+			reg = <0x0 0x100>;
+			enable-method = "psci";
+			next-level-cache = <&L2_100>;
+			qcom,freq-domain = <&cpufreq_hw 0>;
+			power-domains = <&CPU_PD1>;
+			power-domain-names = "psci";
+			#cooling-cells = <2>;
+			L2_100: l2-cache {
+			      compatible = "cache";
+			      next-level-cache = <&L3_0>;
+			};
+		};
+
+		CPU2: cpu@200 {
+			device_type = "cpu";
+			compatible = "qcom,kryo660";
+			reg = <0x0 0x200>;
+			enable-method = "psci";
+			next-level-cache = <&L2_200>;
+			qcom,freq-domain = <&cpufreq_hw 0>;
+			power-domains = <&CPU_PD2>;
+			power-domain-names = "psci";
+			#cooling-cells = <2>;
+			L2_200: l2-cache {
+			      compatible = "cache";
+			      next-level-cache = <&L3_0>;
+			};
+		};
+
+		CPU3: cpu@300 {
+			device_type = "cpu";
+			compatible = "qcom,kryo660";
+			reg = <0x0 0x300>;
+			enable-method = "psci";
+			next-level-cache = <&L2_300>;
+			qcom,freq-domain = <&cpufreq_hw 0>;
+			power-domains = <&CPU_PD3>;
+			power-domain-names = "psci";
+			#cooling-cells = <2>;
+			L2_300: l2-cache {
+			      compatible = "cache";
+			      next-level-cache = <&L3_0>;
+			};
+		};
+
+		CPU4: cpu@400 {
+			device_type = "cpu";
+			compatible = "qcom,kryo660";
+			reg = <0x0 0x400>;
+			enable-method = "psci";
+			next-level-cache = <&L2_400>;
+			qcom,freq-domain = <&cpufreq_hw 0>;
+			power-domains = <&CPU_PD4>;
+			power-domain-names = "psci";
+			#cooling-cells = <2>;
+			L2_400: l2-cache {
+			      compatible = "cache";
+			      next-level-cache = <&L3_0>;
+			};
+		};
+
+		CPU5: cpu@500 {
+			device_type = "cpu";
+			compatible = "qcom,kryo660";
+			reg = <0x0 0x500>;
+			enable-method = "psci";
+			next-level-cache = <&L2_500>;
+			qcom,freq-domain = <&cpufreq_hw 0>;
+			power-domains = <&CPU_PD5>;
+			power-domain-names = "psci";
+			#cooling-cells = <2>;
+			L2_500: l2-cache {
+			      compatible = "cache";
+			      next-level-cache = <&L3_0>;
+			};
+
+		};
+
+		CPU6: cpu@600 {
+			device_type = "cpu";
+			compatible = "qcom,kryo660";
+			reg = <0x0 0x600>;
+			enable-method = "psci";
+			next-level-cache = <&L2_600>;
+			qcom,freq-domain = <&cpufreq_hw 1>;
+			power-domains = <&CPU_PD6>;
+			power-domain-names = "psci";
+			#cooling-cells = <2>;
+			L2_600: l2-cache {
+			      compatible = "cache";
+			      next-level-cache = <&L3_0>;
+			};
+		};
+
+		CPU7: cpu@700 {
+			device_type = "cpu";
+			compatible = "qcom,kryo660";
+			reg = <0x0 0x700>;
+			enable-method = "psci";
+			next-level-cache = <&L2_700>;
+			qcom,freq-domain = <&cpufreq_hw 1>;
+			power-domains = <&CPU_PD7>;
+			power-domain-names = "psci";
+			#cooling-cells = <2>;
+			L2_700: l2-cache {
+			      compatible = "cache";
+			      next-level-cache = <&L3_0>;
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
+
+				core4 {
+					cpu = <&CPU4>;
+				};
+
+				core5 {
+					cpu = <&CPU5>;
+				};
+
+				core6 {
+					cpu = <&CPU6>;
+				};
+
+				core7 {
+					cpu = <&CPU7>;
+				};
+			};
+		};
+
+		idle-states {
+			entry-method = "psci";
+
+			LITTLE_CPU_SLEEP_0: cpu-sleep-0-0 {
+				compatible = "arm,idle-state";
+				idle-state-name = "silver-rail-power-collapse";
+				arm,psci-suspend-param = <0x40000004>;
+				entry-latency-us = <702>;
+				exit-latency-us = <915>;
+				min-residency-us = <4001>;
+				local-timer-stop;
+			};
+
+			BIG_CPU_SLEEP_0: cpu-sleep-1-0 {
+				compatible = "arm,idle-state";
+				idle-state-name = "gold-rail-power-collapse";
+				arm,psci-suspend-param = <0x40000004>;
+				entry-latency-us = <526>;
+				exit-latency-us = <1854>;
+				min-residency-us = <5555>;
+				local-timer-stop;
+			};
+		};
+
+		domain-idle-states {
+			CLUSTER_SLEEP_0: cluster-sleep-0 {
+				compatible = "domain-idle-state";
+				idle-state-name = "cluster-power-collapse";
+				arm,psci-suspend-param = <0x41000044>;
+				entry-latency-us = <2752>;
+				exit-latency-us = <3048>;
+				min-residency-us = <6118>;
+				local-timer-stop;
+			};
+		};
+	};
+
+	firmware {
+		scm {
+			compatible = "qcom,scm-sm6375", "qcom,scm";
+			clocks = <&rpmcc RPM_SMD_CE1_CLK>;
+			clock-names = "core";
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
+		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW>;
+	};
+
+	psci {
+		compatible = "arm,psci-1.0";
+		method = "smc";
+
+		CPU_PD0: cpu0 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER_PD>;
+			domain-idle-states = <&LITTLE_CPU_SLEEP_0>;
+		};
+
+		CPU_PD1: cpu1 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER_PD>;
+			domain-idle-states = <&LITTLE_CPU_SLEEP_0>;
+		};
+
+		CPU_PD2: cpu2 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER_PD>;
+			domain-idle-states = <&LITTLE_CPU_SLEEP_0>;
+		};
+
+		CPU_PD3: cpu3 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER_PD>;
+			domain-idle-states = <&LITTLE_CPU_SLEEP_0>;
+		};
+
+		CPU_PD4: cpu4 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER_PD>;
+			domain-idle-states = <&LITTLE_CPU_SLEEP_0>;
+		};
+
+		CPU_PD5: cpu5 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER_PD>;
+			domain-idle-states = <&LITTLE_CPU_SLEEP_0>;
+		};
+
+		CPU_PD6: cpu6 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER_PD>;
+			domain-idle-states = <&BIG_CPU_SLEEP_0>;
+		};
+
+		CPU_PD7: cpu7 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER_PD>;
+			domain-idle-states = <&BIG_CPU_SLEEP_0>;
+		};
+
+		CLUSTER_PD: cpu-cluster0 {
+			#power-domain-cells = <0>;
+			domain-idle-states = <&CLUSTER_SLEEP_0>;
+		};
+	};
+
+	reserved_memory: reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		hyp_mem: hypervisor@80000000 {
+			reg = <0 0x80000000 0 0x600000>;
+			no-map;
+		};
+
+		xbl_aop_mem: xbl-aop@80700000 {
+			reg = <0 0x80700000 0 0x100000>;
+			no-map;
+		};
+
+		reserved_xbl_uefi: xbl-uefi-res@80880000 {
+			reg = <0 0x80880000 0 0x14000>;
+			no-map;
+		};
+
+		smem_mem: smem@80900000 {
+			compatible = "qcom,smem";
+			reg = <0 0x80900000 0 0x200000>;
+			hwlocks = <&tcsr_mutex 3>;
+			no-map;
+		};
+
+		fw_mem: fw@80b00000 {
+			reg = <0 0x80b00000 0 0x100000>;
+			no-map;
+		};
+
+		cdsp_secure_heap_mem: cdsp-sec-heap@80c00000 {
+			reg = <0 0x80c00000 0 0x1e00000>;
+			no-map;
+		};
+
+		dfps_data_mem: dpfs-data@85e00000 {
+			reg = <0 0x85e00000 0 0x100000>;
+			no-map;
+		};
+
+		pil_wlan_mem: pil-wlan@86500000 {
+			reg = <0 0x86500000 0 0x200000>;
+			no-map;
+		};
+
+		pil_adsp_mem: pil-adsp@86700000 {
+			reg = <0 0x86700000 0 0x2000000>;
+			no-map;
+		};
+
+		pil_cdsp_mem: pil-cdsp@88700000 {
+			reg = <0 0x88700000 0 0x1e00000>;
+			no-map;
+		};
+
+		pil_video_mem: pil-video@8a500000 {
+			reg = <0 0x8a500000 0 0x500000>;
+			no-map;
+		};
+
+		pil_ipa_fw_mem: pil-ipa-fw@8aa00000 {
+			reg = <0 0x8aa00000 0 0x10000>;
+			no-map;
+		};
+
+		pil_ipa_gsi_mem: pil-ipa-gsi@8aa10000 {
+			reg = <0 0x8aa10000 0 0xa000>;
+			no-map;
+		};
+
+		pil_gpu_micro_code_mem: pil-gpu-ucode@8aa1a000 {
+			reg = <0 0x8aa1a000 0 0x2000>;
+			no-map;
+		};
+
+		pil_mpss_wlan_mem: pil-mpss-wlan@8b800000 {
+			reg = <0 0x8b800000 0 0x10000000>;
+			no-map;
+		};
+
+		removed_mem: removed@c0000000 {
+			reg = <0 0xc0000000 0 0x5100000>;
+			no-map;
+		};
+
+		debug_mem: debug@ffb00000 {
+			reg = <0 0xffb00000 0 0xc0000>;
+			no-map;
+		};
+
+		last_log_mem: lastlog@ffbc0000 {
+			reg = <0 0xffbc0000 0 0x80000>;
+			no-map;
+		};
+
+		cmdline_region: cmdline@ffd00000 {
+			reg = <0 0xffd00000 0 0x1000>;
+			no-map;
+		};
+	};
+
+	rpm-glink {
+		compatible = "qcom,glink-rpm";
+		interrupts-extended = <&ipcc IPCC_CLIENT_AOP
+					     IPCC_MPROC_SIGNAL_GLINK_QMP
+					     IRQ_TYPE_EDGE_RISING>;
+		qcom,rpm-msg-ram = <&rpm_msg_ram>;
+		mboxes = <&ipcc IPCC_CLIENT_AOP IPCC_MPROC_SIGNAL_GLINK_QMP>;
+
+		rpm_requests: rpm-requests {
+			compatible = "qcom,rpm-sm6375";
+			qcom,glink-channels = "rpm_requests";
+
+			rpmcc: clock-controller {
+				compatible = "qcom,rpmcc-sm6375", "qcom,rpmcc";
+				clocks = <&xo_board_clk>;
+				clock-names = "xo";
+				#clock-cells = <1>;
+			};
+
+			rpmpd: power-controller {
+				compatible = "qcom,sm6375-rpmpd";
+				#power-domain-cells = <1>;
+				operating-points-v2 = <&rpmpd_opp_table>;
+
+				rpmpd_opp_table: opp-table {
+					compatible = "operating-points-v2";
+
+					rpmpd_opp_ret: opp1 {
+						opp-level = <RPM_SMD_LEVEL_RETENTION>;
+					};
+
+					rpmpd_opp_min_svs: opp2 {
+						opp-level = <RPM_SMD_LEVEL_MIN_SVS>;
+					};
+
+					rpmpd_opp_low_svs: opp3 {
+						opp-level = <RPM_SMD_LEVEL_LOW_SVS>;
+					};
+
+					rpmpd_opp_svs: opp4 {
+						opp-level = <RPM_SMD_LEVEL_SVS>;
+					};
+
+					rpmpd_opp_svs_plus: opp5 {
+						opp-level = <RPM_SMD_LEVEL_SVS_PLUS>;
+					};
+
+					rpmpd_opp_nom: opp6 {
+						opp-level = <RPM_SMD_LEVEL_NOM>;
+					};
+
+					rpmpd_opp_nom_plus: opp7 {
+						opp-level = <RPM_SMD_LEVEL_NOM_PLUS>;
+					};
+
+					rpmpd_opp_turbo: opp8 {
+						opp-level = <RPM_SMD_LEVEL_TURBO>;
+					};
+
+					rpmpd_opp_turbo_no_cpr: opp9 {
+						opp-level = <RPM_SMD_LEVEL_TURBO_NO_CPR>;
+					};
+				};
+			};
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
+		ipcc: mailbox@208000 {
+			compatible = "qcom,sm6375-ipcc", "qcom,ipcc";
+			reg = <0 0x00208000 0 0x1000>;
+			interrupts = <GIC_SPI 334 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-controller;
+			#interrupt-cells = <3>;
+			#mbox-cells = <2>;
+		};
+
+		tcsr_mutex: hwlock@340000 {
+			compatible = "qcom,tcsr-mutex";
+			reg = <0x0 0x00340000 0x0 0x40000>;
+			#hwlock-cells = <1>;
+		};
+
+		tlmm: pinctrl@500000 {
+			compatible = "qcom,sm6375-tlmm";
+			reg = <0 0x00500000 0 0x800000>;
+			interrupts = <GIC_SPI 227 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-ranges = <&tlmm 0 0 157>;
+			/* TODO: Hook up MPM as wakeup-parent when it's there */
+			interrupt-controller;
+			gpio-controller;
+			#interrupt-cells = <2>;
+			#gpio-cells = <2>;
+		};
+
+		gcc: clock-controller@1400000 {
+			compatible = "qcom,sm6375-gcc";
+			reg = <0 0x01400000 0 0x1f0000>;
+			clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>,
+				 <&rpmcc RPM_SMD_XO_A_CLK_SRC>,
+				 <&sleep_clk>;
+			#power-domain-cells = <1>;
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+		};
+
+		usb_1_hsphy: phy@162b000 {
+			compatible = "qcom,sm6375-usb-hs-phy", "qcom,usb-snps-hs-7nm-phy";
+			reg = <0 0x0162b000 0 0x400>;
+
+			clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>;
+			clock-names = "ref";
+			resets = <&gcc GCC_QUSB2PHY_PRIM_BCR>;
+			#phy-cells = <0>;
+
+			status = "disabled";
+		};
+
+		spmi_bus: spmi@1c40000 {
+			compatible = "qcom,spmi-pmic-arb";
+			reg = <0 0x01c40000 0 0x1100>,
+			      <0 0x01e00000 0 0x2000000>,
+			      <0 0x03e00000 0 0x100000>,
+			      <0 0x03f00000 0 0xa0000>,
+			      <0 0x01c0a000 0 0x26000>;
+			reg-names = "core", "chnls", "obsrvr", "intr", "cnfg";
+			interrupt-names = "periph_irq";
+			interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
+			qcom,ee = <0>;
+			qcom,channel = <0>;
+			#address-cells = <2>;
+			#size-cells = <0>;
+			interrupt-controller;
+			#interrupt-cells = <4>;
+		};
+
+		rpm_msg_ram: sram@45f0000 {
+			compatible = "qcom,rpm-msg-ram";
+			reg = <0 0x045f0000 0 0x7000>;
+		};
+
+		usb_1: usb@4ef8800 {
+			compatible = "qcom,sm6375-dwc3", "qcom,dwc3";
+			reg = <0 0x04ef8800 0 0x400>;
+
+			clocks = <&gcc GCC_CFG_NOC_USB3_PRIM_AXI_CLK>,
+				 <&gcc GCC_USB30_PRIM_MASTER_CLK>,
+				 <&gcc GCC_SYS_NOC_USB3_PRIM_AXI_CLK>,
+				 <&gcc GCC_USB30_PRIM_SLEEP_CLK>,
+				 <&gcc GCC_USB30_PRIM_MOCK_UTMI_CLK>,
+				 <&gcc GCC_USB3_PRIM_CLKREF_CLK>;
+			clock-names = "cfg_noc",
+				      "core",
+				      "iface",
+				      "sleep",
+				      "mock_utmi",
+				      "xo";
+
+			assigned-clocks = <&gcc GCC_USB30_PRIM_MOCK_UTMI_CLK>,
+					  <&gcc GCC_USB30_PRIM_MASTER_CLK>;
+			assigned-clock-rates = <19200000>, <133333333>;
+
+			interrupts = <GIC_SPI 302 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "hs_phy_irq",
+					  "ss_phy_irq",
+					  "dm_hs_phy_irq",
+					  "dp_hs_phy_irq";
+
+			power-domains = <&gcc USB30_PRIM_GDSC>;
+
+			resets = <&gcc GCC_USB30_PRIM_BCR>;
+
+			/*
+			 * This property is there to allow USB2 to work, as
+			 * USB3 is not implemented yet - (re)move it when
+			 * proper support is in place.
+			 */
+			qcom,select-utmi-as-pipe-clk;
+
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+
+			status = "disabled";
+
+			usb_1_dwc3: usb@4e00000 {
+				compatible = "snps,dwc3";
+				reg = <0 0x04e00000 0 0xcd00>;
+				interrupts = <GIC_SPI 255 IRQ_TYPE_LEVEL_HIGH>;
+				maximum-speed = "high-speed";
+				phys = <&usb_1_hsphy>;
+				phy-names = "usb2-phy";
+				iommus = <&apps_smmu 0xe0 0x0>;
+
+				/* Yes, this impl *does* have an unfunny number of quirks.. */
+				snps,hird-threshold = /bits/ 8 <0x10>;
+				snps,usb2-gadget-lpm-disable;
+				snps,dis_u2_susphy_quirk;
+				snps,is-utmi-l1-suspend;
+				snps,dis-u1-entry-quirk;
+				snps,dis-u2-entry-quirk;
+				snps,usb3_lpm_capable;
+				snps,has-lpm-erratum;
+				tx-fifo-resize;
+			};
+		};
+
+		apps_smmu: iommu@c600000 {
+			compatible = "qcom,sm6375-smmu-500", "arm,mmu-500";
+			reg = <0 0x0c600000 0 0x100000>;
+			interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH>,
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
+				     <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 129 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 132 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 135 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 139 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 151 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>;
+
+			power-domains = <&gcc HLOS1_VOTE_MM_SNOC_MMU_TBU_RT_GDSC>,
+					<&gcc HLOS1_VOTE_MM_SNOC_MMU_TBU_NRT_GDSC>,
+					<&gcc HLOS1_VOTE_TURING_MMU_TBU0_GDSC>;
+			#global-interrupts = <1>;
+			#iommu-cells = <2>;
+		};
+
+		intc: interrupt-controller@f200000 {
+			compatible = "arm,gic-v3";
+			reg = <0x0 0x0f200000 0x0 0x10000>,  /* GICD */
+			      <0x0 0x0f240000 0x0 0x100000>; /* GICR * 8 */
+			interrupts = <GIC_PPI 8 IRQ_TYPE_LEVEL_HIGH>;
+			#redistributor-regions = <1>;
+			#interrupt-cells = <3>;
+			redistributor-stride = <0 0x20000>;
+			interrupt-controller;
+		};
+
+		timer@f420000 {
+			compatible = "arm,armv7-timer-mem";
+			reg = <0 0x0f420000 0 0x1000>;
+			ranges = <0 0 0 0x20000000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			frame@f421000 {
+				reg = <0x0f421000 0x1000>, <0x0f422000 0x1000>;
+				interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
+				frame-number = <0>;
+			};
+
+			frame@f423000 {
+				reg = <0x0f243000 0x1000>;
+				interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
+				frame-number = <1>;
+				status = "disabled";
+			};
+
+			frame@f425000 {
+				reg = <0x0f425000 0x1000>;
+				interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
+				frame-number = <2>;
+				status = "disabled";
+			};
+
+			frame@f427000 {
+				reg = <0x0f427000 0x1000>;
+				interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
+				frame-number = <3>;
+				status = "disabled";
+			};
+
+			frame@f429000 {
+				reg = <0x0f429000 0x1000>;
+				interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
+				frame-number = <4>;
+				status = "disabled";
+			};
+
+			frame@f42b000 {
+				reg = <0x0f42b000 0x1000>;
+				interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
+				frame-number = <5>;
+				status = "disabled";
+			};
+
+			frame@f42d000 {
+				reg = <0x0f42d000 0x1000>;
+				interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
+				frame-number = <6>;
+				status = "disabled";
+			};
+		};
+
+		cpufreq_hw: cpufreq@fd91000 {
+			compatible = "qcom,sm6375-cpufreq-epss", "qcom,cpufreq-epss";
+			reg = <0 0x0fd91000 0 0x1000>, <0 0x0fd92000 0 0x1000>;
+			reg-names = "freq-domain0", "freq-domain1";
+
+			clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>, <&gcc GPLL0>;
+			clock-names = "xo", "alternate";
+			interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "dcvsh-irq-0", "dcvsh-irq-1";
+			#freq-domain-cells = <1>;
+		};
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupts = <GIC_PPI 1 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 2 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 3 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 0 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>;
+	};
+};
-- 
2.38.1

