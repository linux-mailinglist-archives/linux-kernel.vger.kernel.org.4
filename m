Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66DBA612C7B
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 20:43:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbiJ3Tnj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 15:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbiJ3Tng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 15:43:36 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E57F22A1;
        Sun, 30 Oct 2022 12:43:31 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id b2so16331130lfp.6;
        Sun, 30 Oct 2022 12:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nNMXEVj3jbCccFT9t89m7T8/2d9+3EbLDf5mwbvpDrM=;
        b=h/YuK7Vuun+cif7J9MHUeI4jiPoq1D45lH21KoGowJnYVU1E0zWZJttKERaE6AJIA1
         ctgsaOpHZb5LU+29VGOBVb3hDEkhjv9/EcL6mU1H6dRIpZxSC78DFtCQG9GnOd7cVeXo
         IEq4VlkMpPjPKnIg359AjtIyJrYdTGkkKs13E3FFM/j0ez6+6LgtqRdaMcssxm8Cfcw/
         brQUgx2o/pI6lfABwRarpiUszf0lJZ2tnrzQhZxO5pmAKPbDbzVzU8XeiCqQUIPsYAmL
         /nJo98vq98Hdimnaw9r8/hUuai6sPfVQgVJxzOk0toO9kDC25mPyZ5A3kiF+Hw/CKitj
         slkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nNMXEVj3jbCccFT9t89m7T8/2d9+3EbLDf5mwbvpDrM=;
        b=wCDMUaConfHPdN6YuPcmhOcAbxQnuvsJqvZd9+esGdOma2IOKRvnEvy6XV8D7WJMLf
         +Ac0ecCnKMg5aLN4iQDlTEhHGPxaBN/qrs8Tcs44Sqyk1VcIxr18iE86su24BJ1Fwy+g
         Xo1/bKxcwm6hNkjWgZqXLitHp9kekixJD4UBwr4M3Sk7MHcYZi/3nZTnjySNE7lxkotq
         08kDKeebKkFl4YM8FEZwLnnB9+2Ix9u4Uz72FlebNa5QEOMD6KCnBlfPhFGB0IJbnskr
         U6rRaSqAoVfUlZ3rXHNR6IHo7sKycvqHVJJFayF5qCCU/8Z6tJKmNOGiY4kgGoT8kpeW
         zaTQ==
X-Gm-Message-State: ACrzQf1YkZt/ABzhppIuQQJaUz6JJpKGlcYCgmES5MZUHsGUcAvjzF+a
        EY/UXn2HJ1sIOy5GtChb6W/0EEOgzSM=
X-Google-Smtp-Source: AMsMyM5DIpcdQFio06/l/WWn6CdkSuBRaoHz68x4D+3v0Y1e8KIXeANqsAuoWlZgeou3NZi/78DO6Q==
X-Received: by 2002:a05:6512:224e:b0:4a2:5060:55ef with SMTP id i14-20020a056512224e00b004a2506055efmr3819090lfu.412.1667159009943;
        Sun, 30 Oct 2022 12:43:29 -0700 (PDT)
Received: from localhost.localdomain (adld223.neoplus.adsl.tpnet.pl. [79.185.7.223])
        by smtp.gmail.com with ESMTPSA id s6-20020a056512202600b0049464d89e40sm937833lfs.72.2022.10.30.12.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Oct 2022 12:43:29 -0700 (PDT)
From:   Adam Skladowski <a39.skl@gmail.com>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Adam Skladowski <a39.skl@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] arm64: dts: qcom: Add MSM8976 device tree
Date:   Sun, 30 Oct 2022 20:42:56 +0100
Message-Id: <20221030194311.197909-2-a39.skl@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221030194311.197909-1-a39.skl@gmail.com>
References: <20221030194311.197909-1-a39.skl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a base DT for MSM8976 SoC.

Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
---
 arch/arm64/boot/dts/qcom/msm8976.dtsi | 1357 +++++++++++++++++++++++++
 1 file changed, 1357 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/msm8976.dtsi

diff --git a/arch/arm64/boot/dts/qcom/msm8976.dtsi b/arch/arm64/boot/dts/qcom/msm8976.dtsi
new file mode 100644
index 0000000000000..461593eb04635
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/msm8976.dtsi
@@ -0,0 +1,1357 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/* Copyright (c) 2022, The Linux Foundation. All rights reserved. */
+
+#include <dt-bindings/clock/qcom,gcc-msm8976.h>
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/power/qcom-rpmpd.h>
+#include <dt-bindings/thermal/thermal.h>
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
+		sleep_clk: sleep-clk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <32768>;
+		};
+
+		xo_board: xo-board {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <19200000>;
+			clock-output-names = "xo";
+		};
+	};
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
+			capacity-dmips-mhz = <1024>;
+			next-level-cache = <&L2_0>;
+			#cooling-cells = <2>;
+
+			l1-icache {
+				compatible = "cache";
+			};
+			l1-dcache {
+				compatible = "cache";
+			};
+		};
+
+		CPU1: cpu@1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			reg = <0x1>;
+			enable-method = "psci";
+			capacity-dmips-mhz = <1024>;
+			next-level-cache = <&L2_0>;
+			#cooling-cells = <2>;
+
+			l1-icache {
+				compatible = "cache";
+			};
+			l1-dcache {
+				compatible = "cache";
+			};
+		};
+
+		CPU2: cpu@2 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			reg = <0x2>;
+			enable-method = "psci";
+			capacity-dmips-mhz = <1024>;
+			next-level-cache = <&L2_0>;
+			#cooling-cells = <2>;
+
+			l1-icache {
+				compatible = "cache";
+			};
+			l1-dcache {
+				compatible = "cache";
+			};
+		};
+
+		CPU3: cpu@3 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			reg = <0x3>;
+			enable-method = "psci";
+			capacity-dmips-mhz = <1024>;
+			next-level-cache = <&L2_0>;
+			#cooling-cells = <2>;
+
+			l1-icache {
+				compatible = "cache";
+			};
+			l1-dcache {
+				compatible = "cache";
+			};
+		};
+
+		CPU4: cpu@100 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a72";
+			reg = <0x100>;
+			enable-method = "psci";
+			capacity-dmips-mhz = <1830>;
+			next-level-cache = <&L2_1>;
+			#cooling-cells = <2>;
+
+			l1-icache {
+				compatible = "cache";
+			};
+			l1-dcache {
+				compatible = "cache";
+			};
+		};
+
+		CPU5: cpu@101 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a72";
+			reg = <0x101>;
+			enable-method = "psci";
+			capacity-dmips-mhz = <1830>;
+			next-level-cache = <&L2_1>;
+			#cooling-cells = <2>;
+
+			l1-icache {
+				compatible = "cache";
+			};
+			l1-dcache {
+				compatible = "cache";
+			};
+		};
+
+		CPU6: cpu@102 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a72";
+			reg = <0x102>;
+			enable-method = "psci";
+			capacity-dmips-mhz = <1830>;
+			next-level-cache = <&L2_1>;
+			#cooling-cells = <2>;
+
+			l1-icache {
+				compatible = "cache";
+			};
+			l1-dcache {
+				compatible = "cache";
+			};
+		};
+
+		CPU7: cpu@103 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a72";
+			reg = <0x103>;
+			enable-method = "psci";
+			capacity-dmips-mhz = <1830>;
+			next-level-cache = <&L2_1>;
+			#cooling-cells = <2>;
+
+			l1-icache {
+				compatible = "cache";
+			};
+			l1-dcache {
+				compatible = "cache";
+			};
+		};
+
+		cpu-map {
+			cluster0 {
+				core0 {
+					cpu = <&CPU0>;
+				};
+				core1 {
+					cpu = <&CPU1>;
+				};
+				core2 {
+					cpu = <&CPU2>;
+				};
+				core3 {
+					cpu = <&CPU3>;
+				};
+			};
+
+			cluster1 {
+				core0 {
+					cpu = <&CPU4>;
+				};
+				core1 {
+					cpu = <&CPU5>;
+				};
+				core2 {
+					cpu = <&CPU6>;
+				};
+				core3 {
+					cpu = <&CPU7>;
+				};
+			};
+		};
+
+		L2_0: l2-cache_0 {
+			compatible = "cache";
+			cache-level = <2>;
+		};
+
+		L2_1: l2-cache_1 {
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
+		};
+	};
+
+	memory {
+		device_type = "memory";
+		/* We expect the bootloader to fill in the reg */
+		reg = <0 0 0 0>;
+	};
+
+	pmu {
+		compatible = "arm,cortex-a53-pmu";
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
+		cont_splash_mem: memory@83000000 {
+			reg = <0x0 0x83000000 0x0 0x2800000>;
+		};
+
+		ext_region: memory@85b00000 {
+			reg = <0x0 0x85b00000 0x0 0x500000>;
+			no-map;
+		};
+
+		msm_imem: memory@86000000 {
+			reg = <0x0 0x86000000 0x0 0x300000>;
+			no-map;
+		};
+
+		smem_mem: memory@86300000 {
+			compatible = "qcom,smem";
+			reg = <0x0 0x86300000 0x0 0x100000>;
+			qcom,rpm-msg-ram = <&rpm_msg_ram>;
+			hwlocks = <&tcsr_mutex 3>;
+			no-map;
+		};
+
+		memory@86400000 {
+			reg = <0x0 0x86400000 0x0 0x800000>;
+			no-map;
+		};
+
+		mpss_mem: memory@86c00000 {
+			reg = <0x0 0x86c00000 0x0 0x5600000>;
+			no-map;
+		};
+
+		adsp_fw_mem: memory@8c200000 {
+			reg = <0x0 0x8c200000 0x0 0x1000000>;
+			no-map;
+		};
+
+		wcnss_fw_mem: memory@8d200000 {
+			reg = <0x0 0x8d200000 0x0 0x2600000>;
+			no-map;
+		};
+
+		venus_mem: memory@8f800000 {
+			reg = <0x0 0x8f800000 0x0 0x500000>;
+			no-map;
+		};
+
+		memory@d5700000 {
+			compatible = "qcom,rmtfs-mem";
+			reg = <0x0 0xd5700000 0x0 0x200000>;
+			no-map;
+
+			qcom,client-id = <1>;
+		};
+
+		mba_mem: mba_mem@d5a00000 {
+			reg = <0x0 0xd5a00000 0x0 0x100000>;
+			no-map;
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
+				rpmcc: rpmcc {
+					compatible = "qcom,rpmcc-msm8976", "qcom,rpmcc";
+					clocks = <&xo_board>;
+					clock-names = "xo";
+					#clock-cells = <1>;
+				};
+
+				rpmpd: power-controller {
+					compatible = "qcom,msm8976-rpmpd";
+					#power-domain-cells = <1>;
+					operating-points-v2 = <&rpmpd_opp_table>;
+
+					clocks = <&xo_board>;
+					clock-names = "ref";
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
+		qcom,ipc-1 = <&apcs 8 13>;
+		qcom,ipc-3 = <&apcs 8 19>;
+
+		apps_smsm: apps@0 {
+			reg = <0>;
+
+			#qcom,smem-state-cells = <1>;
+		};
+
+		hexagon_smsm: hexagon@1 {
+			reg = <1>;
+			interrupts = <GIC_SPI 290 IRQ_TYPE_EDGE_RISING>;
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
+	smp2p-adsp {
+		compatible = "qcom,smp2p";
+		qcom,smem = <443>, <429>;
+
+		interrupts = <GIC_SPI 291 IRQ_TYPE_EDGE_RISING>;
+
+		mboxes = <&apcs 10>;
+
+		qcom,local-pid = <0>;
+		qcom,remote-pid = <2>;
+
+		smp2p_adsp_out: master-kernel {
+			qcom,entry-name = "master-kernel";
+			#qcom,smem-state-cells = <1>;
+		};
+
+		smp2p_adsp_in: slave-kernel {
+			qcom,entry-name = "slave-kernel";
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+
+	smp2p-modem {
+		compatible = "qcom,smp2p";
+		qcom,smem = <435>, <428>;
+
+		interrupts = <GIC_SPI 27 IRQ_TYPE_EDGE_RISING>;
+
+		qcom,ipc = <&apcs 8 14>;
+
+		qcom,local-pid = <0>;
+		qcom,remote-pid = <1>;
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
+		qcom,smem = <451>, <431>;
+
+		interrupts = <GIC_SPI 143 IRQ_TYPE_EDGE_RISING>;
+
+		qcom,ipc = <&apcs 8 18>;
+
+		qcom,local-pid = <0>;
+		qcom,remote-pid = <4>;
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
+	soc: soc@0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0 0 0xffffffff>;
+		compatible = "simple-bus";
+
+		rpm_msg_ram: sram@60000 {
+			compatible = "qcom,rpm-msg-ram";
+			reg = <0x60000 0x8000>;
+		};
+
+		rng@22000 {
+			compatible = "qcom,prng";
+			reg = <0x00022000 0x1000>;
+			clocks = <&gcc GCC_PRNG_AHB_CLK>;
+			clock-names = "core";
+		};
+
+		qfprom@a4000 {
+			compatible = "qcom,qfprom";
+			reg = <0x000a4000 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			tsens_caldata: caldata@218 {
+				reg = <0x218 0x18>;
+			};
+		};
+
+		tsens0: thermal-sensor@4a9000 {
+			compatible = "qcom,msm8976-tsens", "qcom,tsens-v1";
+			reg = <0x4a9000 0x1000>, /* TM */
+			      <0x4a8000 0x1000>; /* SROT */
+			#qcom,sensors = <11>;
+			interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "uplow";
+			nvmem-cells = <&tsens_caldata>;
+			nvmem-cell-names = "calib";
+			#thermal-sensor-cells = <1>;
+		};
+
+		restart@4ab000 {
+			compatible = "qcom,pshold";
+			reg = <0x4ab000 0x4>;
+		};
+
+		tlmm: pinctrl@1000000 {
+			compatible = "qcom,msm8976-pinctrl";
+			reg = <0x1000000 0x300000>;
+			interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			gpio-ranges = <&tlmm 0 0 158>;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+
+			mdss_te_default: mdss-te-pins {
+				pins = "gpio24";
+				function = "mdp_vsync";
+				drive-strength = <2>;
+				bias-pull-down;
+			};
+
+			sdc1_clk_on: sdc1-clk-on-state {
+				pins = "sdc1_clk";
+				bias-disable;
+				drive-strength = <16>;
+			};
+
+			sdc1_clk_off: sdc1-clk-off-state {
+				pins = "sdc1_clk";
+				bias-disable;
+				drive-strength = <2>;
+			};
+
+			sdc1_cmd_on: sdc1-cmd-on-state {
+				pins = "sdc1_cmd";
+				bias-disable;
+				drive-strength = <10>;
+			};
+
+			sdc1_cmd_off: sdc1-cmd-off-state {
+				pins = "sdc1_cmd";
+				bias-disable;
+				drive-strength = <2>;
+			};
+
+			sdc1_data_on: sdc1-data-on-state {
+				pins = "sdc1_data";
+				bias-pull-up;
+				drive-strength = <10>;
+			};
+
+			sdc1_data_off: sdc1-data-off-state {
+				pins = "sdc1_data";
+				bias-pull-up;
+				drive-strength = <2>;
+			};
+
+			sdc1_rclk_on: sdc1-rclk-on-state {
+				pins = "sdc1_rclk";
+				bias-pull-down;
+			};
+
+			sdc1_rclk_off: sdc1-rclk-off-state {
+				pins = "sdc1_rclk";
+				bias-pull-down;
+			};
+
+			sdc2_clk_on: sdc2-clk-on-state {
+				pins = "sdc2_clk";
+				drive-strength = <16>;
+				bias-disable;
+			};
+
+			sdc2_clk_off: sdc2-clk-off-state {
+				pins = "sdc2_clk";
+				bias-disable;
+				drive-strength = <2>;
+			};
+
+			sdc2_cmd_on: sdc2-cmd-on-state {
+				pins = "sdc2_cmd";
+				bias-pull-up;
+				drive-strength = <10>;
+			};
+
+			sdc2_cmd_off: sdc2-cmd-off-state {
+				pins = "sdc2_cmd";
+				bias-pull-up;
+				drive-strength = <2>;
+			};
+
+			sdc2_data_on: sdc2-data-on-state {
+				pins = "sdc2_data";
+				bias-pull-up;
+				drive-strength = <10>;
+			};
+
+			sdc2_data_off: sdc2-data-off-state {
+				pins = "sdc2_data";
+				bias-pull-up;
+				drive-strength = <2>;
+			};
+
+			sdc2_cd_on: cd-on-state {
+				pins = "gpio100";
+				function = "gpio";
+				drive-strength = <2>;
+				bias-pull-up;
+			};
+
+			sdc2_cd_off: cd-off-state {
+				pins = "gpio100";
+				function = "gpio";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
+			gpio_key_default: gpio-key-default-state {
+				pins = "gpio113";
+				function = "gpio";
+				drive-strength = <2>;
+				bias-pull-up;
+			};
+
+			i2c_1_default: i2c-1-default-state {
+				pins = "gpio2", "gpio3";
+				function = "blsp_i2c1";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
+			i2c_1_sleep: i2c-1-sleep-state {
+				pins = "gpio2", "gpio3";
+				function = "gpio";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
+			i2c_2_default: i2c-2-default-state {
+				pins = "gpio6", "gpio7";
+				function = "blsp_i2c2";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
+			i2c_2_sleep: i2c-2-sleep-state {
+				pins = "gpio6", "gpio7";
+				function = "gpio";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
+			i2c_3_default: i2c-3-default-state {
+				pins = "gpio10", "gpio11";
+				function = "blsp_i2c3";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
+			i2c_3_sleep: i2c-3-sleep-state {
+				pins = "gpio10", "gpio11";
+				function = "gpio";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
+			i2c_4_default: i2c-4-default-state {
+				pins = "gpio14", "gpio15";
+				function = "blsp_i2c4";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
+			i2c_4_sleep: i2c-4-sleep-state {
+				pins = "gpio14", "gpio15";
+				function = "gpio";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
+			i2c_5_default: i2c-5-default-state {
+				pins = "gpio136", "gpio137";
+				function = "blsp_i2c5";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
+			i2c_5_sleep: i2c-5-sleep-state {
+				pins = "gpio136", "gpio137";
+				function = "gpio";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
+			i2c_6_default: i2c-6-default-state {
+				pins = "gpio22", "gpio23";
+				function = "blsp_i2c6";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
+			i2c_6_sleep: i2c-6-sleep-state {
+				pins = "gpio22", "gpio23";
+				function = "gpio";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
+			i2c_7_default: i2c-7-default-state {
+				pins = "gpio110", "gpio111";
+				function = "blsp_i2c7";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
+			i2c_7_sleep: i2c-7-sleep-state {
+				pins = "gpio110", "gpio111";
+				function = "gpio";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
+			i2c_8_default: i2c-8-default-state {
+				pins = "gpio18", "gpio19";
+				function = "blsp_i2c8";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
+			i2c_8_sleep: i2c-8-sleep-state {
+				pins = "gpio18", "gpio19";
+				function = "gpio";
+				drive-strength = <2>;
+				bias-disable;
+			};
+		};
+
+		gcc: clock-controller@1800000 {
+			compatible = "qcom,gcc-msm8976-v1.1";
+			reg = <0x1800000 0x80000>;
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+			#power-domain-cells = <1>;
+			clocks = <&xo_board>,
+				 <&xo_board>,
+				 <&dsi0_phy 1>,
+				 <&dsi0_phy 0>,
+				 <&dsi1_phy 1>,
+				 <&dsi1_phy 0>;
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
+			reg = <0x1905000 0x20000>;
+			#hwlock-cells = <1>;
+		};
+
+		tcsr: syscon@1937000 {
+			compatible = "syscon";
+			reg = <0x1937000 0x30000>;
+		};
+
+		mdss: mdss@1a00000 {
+			compatible = "qcom,mdss";
+
+			reg = <0x1a00000 0x1000>,
+			      <0x1ab0000 0x1040>;
+			reg-names = "mdss_phys",
+				    "vbif_phys";
+
+			power-domains = <&gcc MDSS_GDSC>;
+			interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
+
+			interrupt-controller;
+			#interrupt-cells = <1>;
+
+			clocks = <&gcc GCC_MDSS_AHB_CLK>,
+				 <&gcc GCC_MDSS_AXI_CLK>,
+				 <&gcc GCC_MDSS_VSYNC_CLK>,
+				 <&gcc GCC_MDSS_MDP_CLK>;
+			clock-names = "iface",
+				      "bus",
+				      "vsync",
+				      "core";
+
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			status = "disabled";
+
+			mdp: mdp@1a01000 {
+				compatible = "qcom,mdp5";
+				reg = <0x1a01000 0x89000>;
+				reg-names = "mdp_phys";
+
+				interrupt-parent = <&mdss>;
+				interrupts = <0>;
+
+				power-domains = <&gcc MDSS_GDSC>;
+
+				clocks = <&gcc GCC_MDSS_AHB_CLK>,
+					 <&gcc GCC_MDSS_AXI_CLK>,
+					 <&gcc GCC_MDSS_MDP_CLK>,
+					 <&gcc GCC_MDSS_VSYNC_CLK>,
+					 <&gcc GCC_MDP_TBU_CLK>,
+					 <&gcc GCC_MDP_RT_TBU_CLK>;
+				clock-names = "iface",
+					      "bus",
+					      "core",
+					      "vsync",
+					      "tbu",
+					      "tbu_rt";
+				iommus = <&apps_iommu 0x17>;
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port@0 {
+						reg = <0>;
+						mdp5_intf1_out: endpoint {
+							remote-endpoint = <&dsi0_in>;
+						};
+					};
+
+					port@1 {
+						reg = <1>;
+						mdp5_intf2_out: endpoint {
+							remote-endpoint = <&dsi1_in>;
+						};
+					};
+				};
+			};
+
+			dsi0: dsi@1a94000 {
+				compatible = "qcom,mdss-dsi-ctrl";
+				reg = <0x1a94000 0x2d4>;
+				reg-names = "dsi_ctrl";
+
+				interrupt-parent = <&mdss>;
+				interrupts = <4>;
+
+				assigned-clocks = <&gcc GCC_MDSS_BYTE0_CLK_SRC>,
+						  <&gcc GCC_MDSS_PCLK0_CLK_SRC>;
+				assigned-clock-parents = <&dsi0_phy 0>,
+							 <&dsi0_phy 1>;
+
+				clocks = <&gcc GCC_MDSS_MDP_CLK>,
+					 <&gcc GCC_MDSS_AHB_CLK>,
+					 <&gcc GCC_MDSS_AXI_CLK>,
+					 <&gcc GCC_MDSS_BYTE0_CLK>,
+					 <&gcc GCC_MDSS_PCLK0_CLK>,
+					 <&gcc GCC_MDSS_ESC0_CLK>;
+				clock-names = "mdp_core",
+					      "iface",
+					      "bus",
+					      "byte",
+					      "pixel",
+					      "core";
+
+				phys = <&dsi0_phy>;
+
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				status = "disabled";
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port@0 {
+						reg = <0>;
+						dsi0_in: endpoint {
+							remote-endpoint = <&mdp5_intf1_out>;
+						};
+					};
+
+					port@1 {
+						reg = <1>;
+						dsi0_out: endpoint {
+						};
+					};
+				};
+			};
+
+			dsi0_phy: phy@1a94400 {
+				compatible = "qcom,dsi-phy-28nm-hpm-fam-b";
+				reg = <0x1a94400 0x20c>,
+				      <0x1a94b80 0x2c>,
+				      <0x1a94a00 0xd4>;
+				reg-names = "dsi_phy",
+					    "dsi_phy_regulator",
+					    "dsi_pll";
+
+				#clock-cells = <1>;
+				#phy-cells = <0>;
+
+				clocks = <&gcc GCC_MDSS_AHB_CLK>, <&xo_board>;
+				clock-names = "iface", "ref";
+
+				status = "disabled";
+			};
+
+			dsi1: dsi@1a96000 {
+				compatible = "qcom,mdss-dsi-ctrl";
+				reg = <0x1a96000 0x2d4>;
+				reg-names = "dsi_ctrl";
+
+				interrupt-parent = <&mdss>;
+				interrupts = <5>;
+
+				assigned-clocks = <&gcc GCC_MDSS_BYTE1_CLK_SRC>,
+						  <&gcc GCC_MDSS_PCLK1_CLK_SRC>;
+				assigned-clock-parents = <&dsi1_phy 0>,
+							 <&dsi1_phy 1>;
+
+				clocks = <&gcc GCC_MDSS_MDP_CLK>,
+					 <&gcc GCC_MDSS_AHB_CLK>,
+					 <&gcc GCC_MDSS_AXI_CLK>,
+					 <&gcc GCC_MDSS_BYTE1_CLK>,
+					 <&gcc GCC_MDSS_PCLK1_CLK>,
+					 <&gcc GCC_MDSS_ESC1_CLK>;
+				clock-names = "mdp_core",
+					      "iface",
+					      "bus",
+					      "byte",
+					      "pixel",
+					      "core";
+
+				phys = <&dsi1_phy>;
+
+				status = "disabled";
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port@0 {
+						reg = <0>;
+						dsi1_in: endpoint {
+							remote-endpoint = <&mdp5_intf2_out>;
+						};
+					};
+
+					port@1 {
+						reg = <1>;
+						dsi1_out: endpoint {
+						};
+					};
+				};
+			};
+
+			dsi1_phy: phy@1a96400 {
+				compatible = "qcom,dsi-phy-28nm-hpm-fam-b";
+				reg = <0x1a96400 0x20c>,
+				      <0x1a96b80 0x2c>,
+				      <0x1a96a00 0xd4>;
+				reg-names = "dsi_phy",
+					    "dsi_phy_regulator",
+					    "dsi_pll";
+
+				#clock-cells = <1>;
+				#phy-cells = <0>;
+
+				clocks = <&gcc GCC_MDSS_AHB_CLK>, <&xo_board>;
+				clock-names = "iface", "ref";
+
+				status = "disabled";
+			};
+		};
+
+		apps_iommu: iommu@1e00000 {
+			compatible = "qcom,msm-iommu-v1";
+			ranges  = <0 0x1e20000 0x20000>;
+
+			clocks = <&gcc GCC_SMMU_CFG_CLK>,
+				 <&gcc GCC_APSS_TCU_CLK>;
+			clock-names = "iface", "bus";
+
+			qcom,iommu-secure-id = <17>;
+
+			#address-cells = <1>;
+			#iommu-cells = <1>;
+			#size-cells = <1>;
+
+			// mdp_0
+			iommu-ctx@17000 {
+				compatible = "qcom,msm-iommu-v1-ns";
+				reg = <0x17000 0x1000>;
+				interrupts = <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>;
+			};
+
+		};
+
+		spmi_bus: spmi@200f000 {
+			compatible = "qcom,spmi-pmic-arb";
+			reg = <0x200f000 0x1000>,
+			      <0x2400000 0x800000>,
+			      <0x2c00000 0x800000>,
+			      <0x3800000 0x200000>,
+			      <0x200a000 0x2100>;
+			reg-names = "core", "chnls", "obsrvr", "intr", "cnfg";
+			interrupt-names = "periph_irq";
+			interrupts = <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>;
+			qcom,ee = <0>;
+			qcom,channel = <0>;
+			interrupt-controller;
+
+			#interrupt-cells = <4>;
+			#address-cells = <2>;
+			#size-cells = <0>;
+		};
+
+		sdhc_1: mmc@7824900 {
+			compatible = "qcom,sdhci-msm-v4";
+
+			reg = <0x7824900 0x500>, <0x7824000 0x800>;
+			reg-names = "hc", "core";
+
+			interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "hc_irq", "pwr_irq";
+
+			clocks = <&gcc GCC_SDCC1_AHB_CLK>,
+				 <&gcc GCC_SDCC1_APPS_CLK>,
+				 <&xo_board>;
+			clock-names = "iface", "core", "xo";
+
+			power-domains = <&rpmpd MSM8976_VDDCX>;
+			operating-points-v2 = <&sdhc1_opp_table>;
+
+			pinctrl-names = "default", "sleep";
+			pinctrl-0 = <&sdc1_clk_on &sdc1_cmd_on &sdc1_data_on &sdc1_rclk_on>;
+			pinctrl-1 = <&sdc1_clk_off &sdc1_cmd_off &sdc1_data_off &sdc1_rclk_off>;
+
+			mmc-hs400-1_8v;
+			mmc-hs200-1_8v;
+			mmc-ddr-1_8v;
+			bus-width = <8>;
+			non-removable;
+
+			status = "disabled";
+
+			sdhc1_opp_table: opp-table-sdhc1 {
+				compatible = "operating-points-v2";
+
+				opp-100000000 {
+					opp-hz = /bits/ 64 <100000000>;
+					required-opps = <&rpmpd_opp_svs>;
+				};
+
+				opp-186400000 {
+					opp-hz = /bits/ 64 <186400000>;
+					required-opps = <&rpmpd_opp_nom>;
+				};
+
+				opp-372800000 {
+					opp-hz = /bits/ 64 <372800000>;
+					required-opps = <&rpmpd_opp_nom>;
+				};
+			};
+		};
+
+		sdhc_2: mmc@7864900 {
+			compatible = "qcom,sdhci-msm-v4";
+
+			reg = <0x7864900 0x500>, <0x7864000 0x800>;
+			reg-names = "hc", "core";
+
+			interrupts = <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 221 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "hc_irq", "pwr_irq";
+
+			clocks = <&gcc GCC_SDCC2_AHB_CLK>,
+				 <&gcc GCC_SDCC2_APPS_CLK>,
+				 <&xo_board>;
+			clock-names = "iface", "core", "xo";
+
+			power-domains = <&rpmpd MSM8976_VDDCX>;
+			operating-points-v2 = <&sdhc2_opp_table>;
+
+			pinctrl-names = "default", "sleep";
+			pinctrl-0 = <&sdc2_clk_on &sdc2_cmd_on &sdc2_data_on>;
+			pinctrl-1 = <&sdc2_clk_off &sdc2_cmd_off &sdc2_data_off>;
+
+			bus-width = <4>;
+
+			status = "disabled";
+
+			sdhc2_opp_table: opp-table-sdhc2 {
+				compatible = "operating-points-v2";
+
+				opp-50000000 {
+					opp-hz = /bits/ 64 <50000000>;
+					required-opps = <&rpmpd_opp_svs>;
+				};
+
+				opp-200000000 {
+					opp-hz = /bits/ 64 <200000000>;
+					required-opps = <&rpmpd_opp_nom>;
+				};
+			};
+		};
+
+		i2c_1: i2c@78b5000 {
+			compatible = "qcom,i2c-qup-v2.2.1";
+			reg = <0x78b5000 0x600>;
+			interrupts = <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>;
+			clock-names = "core", "iface";
+			clocks = <&gcc GCC_BLSP1_QUP1_I2C_APPS_CLK>,
+				 <&gcc GCC_BLSP1_AHB_CLK>;
+
+			pinctrl-names = "default", "sleep";
+			pinctrl-0 = <&i2c_1_default>;
+			pinctrl-1 = <&i2c_1_sleep>;
+
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			status = "disabled";
+		};
+
+		i2c_2: i2c@78b6000 {
+			compatible = "qcom,i2c-qup-v2.2.1";
+			reg = <0x78b6000 0x600>;
+			interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
+			clock-names = "core", "iface";
+			clocks = <&gcc GCC_BLSP1_QUP2_I2C_APPS_CLK>,
+				 <&gcc GCC_BLSP1_AHB_CLK>;
+
+			pinctrl-names = "default", "sleep";
+			pinctrl-0 = <&i2c_2_default>;
+			pinctrl-1 = <&i2c_2_sleep>;
+
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			status = "disabled";
+		};
+
+		i2c_3: i2c@78b7000 {
+			compatible = "qcom,i2c-qup-v2.2.1";
+			reg = <0x78b7000 0x600>;
+			interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
+			clock-names = "core", "iface";
+			clocks = <&gcc GCC_BLSP1_QUP3_I2C_APPS_CLK>,
+				 <&gcc GCC_BLSP1_AHB_CLK>;
+			pinctrl-names = "default", "sleep";
+			pinctrl-0 = <&i2c_3_default>;
+			pinctrl-1 = <&i2c_3_sleep>;
+
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			status = "disabled";
+		};
+
+		i2c_4: i2c@78b8000 {
+			compatible = "qcom,i2c-qup-v2.2.1";
+			reg = <0x78b8000 0x600>;
+			interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
+			clock-names = "core", "iface";
+			clocks = <&gcc GCC_BLSP1_QUP4_I2C_APPS_CLK>,
+				 <&gcc GCC_BLSP1_AHB_CLK>;
+			pinctrl-names = "default", "sleep";
+			pinctrl-0 = <&i2c_4_default>;
+			pinctrl-1 = <&i2c_4_sleep>;
+
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			status = "disabled";
+		};
+
+		i2c_5: i2c@7af5000 {
+			compatible = "qcom,i2c-qup-v2.2.1";
+			reg = <0x7af5000 0x600>;
+			interrupts = <GIC_SPI 299 IRQ_TYPE_LEVEL_HIGH>;
+			clock-names = "core", "iface";
+			clocks = <&gcc GCC_BLSP2_QUP1_I2C_APPS_CLK>,
+				 <&gcc GCC_BLSP2_AHB_CLK>;
+			pinctrl-names = "default", "sleep";
+			pinctrl-0 = <&i2c_5_default>;
+			pinctrl-1 = <&i2c_5_sleep>;
+
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			status = "disabled";
+		};
+
+		i2c_6: i2c@7af6000 {
+			compatible = "qcom,i2c-qup-v2.2.1";
+			reg = <0x7af6000 0x600>;
+			interrupts = <GIC_SPI 300 IRQ_TYPE_LEVEL_HIGH>;
+			clock-names = "core", "iface";
+			clocks = <&gcc GCC_BLSP2_QUP2_I2C_APPS_CLK>,
+				 <&gcc GCC_BLSP2_AHB_CLK>;
+			pinctrl-names = "default", "sleep";
+			pinctrl-0 = <&i2c_6_default>;
+			pinctrl-1 = <&i2c_6_sleep>;
+
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			status = "disabled";
+		};
+
+		i2c_7: i2c@7af7000 {
+			compatible = "qcom,i2c-qup-v2.2.1";
+			reg = <0x7af7000 0x600>;
+			interrupts = <GIC_SPI 301 IRQ_TYPE_LEVEL_HIGH>;
+			clock-names = "core", "iface";
+			clocks = <&gcc GCC_BLSP2_QUP3_I2C_APPS_CLK>,
+				 <&gcc GCC_BLSP2_AHB_CLK>;
+			pinctrl-names = "default", "sleep";
+			pinctrl-0 = <&i2c_7_default>;
+			pinctrl-1 = <&i2c_7_sleep>;
+
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			status = "disabled";
+		};
+
+		i2c_8: i2c@7af8000 {
+			compatible = "qcom,i2c-qup-v2.2.1";
+			reg = <0x7af8000 0x600>;
+			interrupts = <GIC_SPI 302 IRQ_TYPE_LEVEL_HIGH>;
+			clock-names = "core", "iface";
+			clocks = <&gcc GCC_BLSP2_QUP4_I2C_APPS_CLK>,
+				 <&gcc GCC_BLSP2_AHB_CLK>;
+			pinctrl-names = "default", "sleep";
+			pinctrl-0 = <&i2c_8_default>;
+			pinctrl-1 = <&i2c_8_sleep>;
+
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			status = "disabled";
+		};
+
+		intc: interrupt-controller@b000000 {
+			compatible = "qcom,msm-qgic2";
+			interrupt-controller;
+			#interrupt-cells = <3>;
+			reg = <0x0b000000 0x1000>, <0x0b002000 0x1000>;
+		};
+
+		apcs: mailbox@b011000 {
+			compatible = "qcom,msm8976-apcs-kpss-global", "syscon";
+			reg = <0xb011000 0x1000>;
+			#mbox-cells = <1>;
+		};
+
+		timer@b120000 {
+			compatible = "arm,armv7-timer-mem";
+			reg = <0xb120000 0x1000>;
+			#address-cells = <0x01>;
+			#size-cells = <0x01>;
+			ranges;
+
+			frame@b121000 {
+				frame-number = <0>;
+				interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
+				reg = <0xb121000 0x1000>,
+				      <0xb122000 0x1000>;
+			};
+
+			frame@b123000 {
+				frame-number = <1>;
+				interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
+				reg = <0xb123000 0x1000>;
+				status = "disabled";
+			};
+
+			frame@b124000 {
+				frame-number = <2>;
+				interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
+				reg = <0xb124000 0x1000>;
+				status = "disabled";
+			};
+
+			frame@b125000 {
+				frame-number = <3>;
+				interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
+				reg = <0xb125000 0x1000>;
+				status = "disabled";
+			};
+
+			frame@b126000 {
+				frame-number = <4>;
+				interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
+				reg = <0xb126000 0x1000>;
+				status = "disabled";
+			};
+
+			frame@b127000 {
+				frame-number = <5>;
+				interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
+				reg = <0xb127000 0x1000>;
+				status = "disabled";
+			};
+
+			frame@b128000 {
+				frame-number = <6>;
+				interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
+				reg = <0xb128000 0x1000>;
+				status = "disabled";
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
+	};
+};
-- 
2.25.1

