Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF7536D4F19
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 19:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231725AbjDCRgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 13:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbjDCRgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 13:36:35 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0049F30D3
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 10:36:31 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id k37so39138613lfv.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 10:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680543390;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g23+EGx4vbM+tIPH+iw75Al/HAOh0U2bUD0TNr2qG48=;
        b=L2aCh3C7rV4q81NvoqFuRo0fYOoDw9iTu/L1byw3Jbx1fMP0Je4WaXlk8hIv/Fewxr
         8oOA6x5EleN5pNg2pjQS/EHIjqIWiW375kDXZjPpn+Sn0Fs/b94VnVGTiQUzIz7Dv6Kx
         CmdqeFjOqP7+ZyPseet/TtiBtR2b3f9v1P+tlInA88nCJbC2T2zEB7h4qQsuW9MXu0Kh
         XGkVYN6JyHdQKwfkoIcv/XxYxzYcojnXBAP4SkyAggCQBFGP7Sw2rH42Kv18+tTwCNNK
         XX5hqLzfMnXjYv7zdXEyDOkn744Kt+CLZbHvTo4KnFLQI51q8PnSUpLXqE+F034+dGrh
         9zRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680543390;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g23+EGx4vbM+tIPH+iw75Al/HAOh0U2bUD0TNr2qG48=;
        b=jhx3wT1sA0T8M0BFFpkh67iuYBiev+HI6GNgBA8XT29OzH0OJPV8JoOL+5D1So1LBi
         ruQtgeyXWRS1bUvUtncv+7XbN3LABP1UeuSo2hCGsR+Ym3AyodmCUbPMEoKFPJhsuRW4
         dvjvOnL+VrNZICuzfU0aYUrc5PPjxD9baXsW/V8M9FsSEzf1z3W/bArPJSsVnddl+zSW
         ciDCP5wwoUbr/K9CxujadnNAl/nSdSh8lcKE3sOEu9c4pNWaVmWF+BmUvcTrWs1RyP6y
         lWUnKA21+sje2+ky2iyQPAv3dmxrWTa36SEyHKa8A+3ssUJt5Ogn0j4hZMEf1dnRgHbl
         urbw==
X-Gm-Message-State: AAQBX9dSNwbWRFpuxQGp64I+TXjdQeiCu6K8Ktf9hFSoySFIoT1zOx7a
        VWNwocADkWWnmx4NTeroSrG9Zg==
X-Google-Smtp-Source: AKy350Ye/HY5bTrjVRWGNoKyEI4nkHHctqDLBPZR68x4tjNC4Xjd9+b+vt0T4xJL3wemAzWg02lUwQ==
X-Received: by 2002:ac2:410d:0:b0:4e9:b165:cdc with SMTP id b13-20020ac2410d000000b004e9b1650cdcmr10216444lfi.17.1680543390024;
        Mon, 03 Apr 2023 10:36:30 -0700 (PDT)
Received: from [192.168.1.101] (abxj135.neoplus.adsl.tpnet.pl. [83.9.3.135])
        by smtp.gmail.com with ESMTPSA id v2-20020a056512096200b004cc5f44747dsm1871094lft.220.2023.04.03.10.36.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 10:36:29 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 03 Apr 2023 19:36:01 +0200
Subject: [PATCH 3/9] arm64: dts: qcom: Add initial QCM2290, PM2250 & RB1
 device trees
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230403-topic-rb1_qcm-v1-3-ca849b62ba07@linaro.org>
References: <20230403-topic-rb1_qcm-v1-0-ca849b62ba07@linaro.org>
In-Reply-To: <20230403-topic-rb1_qcm-v1-0-ca849b62ba07@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Robert Marko <robimarko@gmail.com>,
        Das Srinagesh <quic_gurus@quicinc.com>
Cc:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1680543384; l=28839;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=tUOXV/CqLlhenaOCipvuHX/hCy02O+5mrytX6ELmC1k=;
 b=+f6ru+F9Zh6F8As37x0woLbPsfyOwJx6MkVRX1s7d6my1ASwRq2R2ULu8pZSL6ZN8NiEOwSWN22x
 7VoRAbKzCYnOKtXff+sBhYrb7wjnFKWGWstobLwB1Fj6R/5T52Fn
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add initial device trees for the QCM2290 SoC, QC Robotics RB1 board, as
well as the bundled PM2250 PMIC.

On the SoC part, CA53 compatibles were used, as Qualcomm claims that's
what has been implemented, despite the cores reporting a Qualcomm Kryo
MIDR_EL1[PART_NUM].

To get a successful boot on RB1, run:

cat arch/arm64/boot/Image.gz arch/arm64/boot/dts/qcom/qrb2210-rb1.dtb >\
.Image.gz-dtb

mkbootimg \
        --kernel .Image.gz-dtb \
        --ramdisk some_initrd \
        --output rb1-boot.img \
        --pagesize 4096 \
        --base 0x8000 \
        --cmdline 'some cmdline'

fastboot boot rb1-boot.img

There's no dtbo or other craziness to worry about.
For the best dev experience, you can erase boot and use fastboot boot
everytime, so that the bootloader doesn't mess with you.

If you have a SoM revision 3 or older (there should be a sticker on it
with text like -r00, where r is the revision), you will need to apply
this additional diff:

        aliases {
-               serial0 = &uart0;
+               serial0 = &uart4;

/* UART connected to the Micro-USB port via a FTDI chip */
-&uart0 {
+&uart4 {

That should however only concern preproduction boards.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/Makefile        |   1 +
 arch/arm64/boot/dts/qcom/pm2250.dtsi     |  63 +++
 arch/arm64/boot/dts/qcom/qcm2290.dtsi    | 848 +++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/qrb2210-rb1.dts | 107 ++++
 4 files changed, 1019 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index 1a29403400b7..6fc8d6664f0c 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -70,6 +70,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= msm8998-xiaomi-sagit.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= qcs404-evb-1000.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= qcs404-evb-4000.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= qdu1000-idp.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= qrb2210-rb1.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= qrb5165-rb5.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= qrb5165-rb5-vision-mezzanine.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= qru1000-idp.dtb
diff --git a/arch/arm64/boot/dts/qcom/pm2250.dtsi b/arch/arm64/boot/dts/qcom/pm2250.dtsi
new file mode 100644
index 000000000000..c5344d6e47c4
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/pm2250.dtsi
@@ -0,0 +1,63 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+/*
+ * Copyright (c) 2023, Linaro Ltd
+ */
+
+#include <dt-bindings/iio/qcom,spmi-vadc.h>
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/spmi/spmi.h>
+
+&spmi_bus {
+	pmic@0 {
+		compatible = "qcom,pm2250", "qcom,spmi-pmic";
+		reg = <0x0 SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		pon@800 {
+			compatible = "qcom,pm8916-pon";
+			reg = <0x800>;
+
+			pm2250_pwrkey: pwrkey {
+				compatible = "qcom,pm8941-pwrkey";
+				interrupts-extended = <&spmi_bus 0x0 0x8 0 IRQ_TYPE_EDGE_BOTH>;
+				linux,code = <KEY_POWER>;
+				debounce = <15625>;
+				bias-pull-up;
+			};
+
+			pm2250_resin: resin {
+				compatible = "qcom,pm8941-resin";
+				interrupts-extended = <&spmi_bus 0x0 0x8 1 IRQ_TYPE_EDGE_BOTH>;
+				debounce = <15625>;
+				bias-pull-up;
+				status = "disabled";
+			};
+		};
+
+		rtc@6000 {
+			compatible = "qcom,pm8941-rtc";
+			reg = <0x6000>, <0x6100>;
+			reg-names = "rtc", "alarm";
+			interrupts-extended = <&spmi_bus 0x0 0x61 0x1 IRQ_TYPE_EDGE_RISING>;
+		};
+
+		pm2250_gpios: gpio@c000 {
+			compatible = "qcom,pm2250-gpio", "qcom,spmi-gpio";
+			reg = <0xc000>;
+			gpio-controller;
+			gpio-ranges = <&pm2250_gpios 0 0 10>;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+
+	pmic@1 {
+		compatible = "qcom,pm2250", "qcom,spmi-pmic";
+		reg = <0x1 SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
+};
\ No newline at end of file
diff --git a/arch/arm64/boot/dts/qcom/qcm2290.dtsi b/arch/arm64/boot/dts/qcom/qcm2290.dtsi
new file mode 100644
index 000000000000..27d4742cdb19
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/qcm2290.dtsi
@@ -0,0 +1,848 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+/*
+ * Copyright (c) 2023, Linaro Ltd
+ *
+ * Based on sm6115.dtsi and previous efforts by Shawn Guo & Loic Poulain.
+ */
+
+#include <dt-bindings/clock/qcom,gcc-qcm2290.h>
+#include <dt-bindings/clock/qcom,rpmcc.h>
+#include <dt-bindings/dma/qcom-gpi.h>
+#include <dt-bindings/firmware/qcom,scm.h>
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
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
+		xo_board: xo-board {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+		};
+
+		sleep_clk: sleep-clk {
+			compatible = "fixed-clock";
+			clock-frequency = <32764>;
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
+			compatible = "arm,cortex-a53";
+			reg = <0x0 0x0>;
+			clocks = <&cpufreq_hw 0>;
+			capacity-dmips-mhz = <1024>;
+			dynamic-power-coefficient = <100>;
+			enable-method = "psci";
+			next-level-cache = <&L2_0>;
+			qcom,freq-domain = <&cpufreq_hw 0>;
+			L2_0: l2-cache {
+				compatible = "cache";
+				cache-level = <2>;
+			};
+		};
+
+		CPU1: cpu@1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			reg = <0x0 0x1>;
+			clocks = <&cpufreq_hw 0>;
+			capacity-dmips-mhz = <1024>;
+			dynamic-power-coefficient = <100>;
+			enable-method = "psci";
+			next-level-cache = <&L2_0>;
+			qcom,freq-domain = <&cpufreq_hw 0>;
+		};
+
+		CPU2: cpu@2 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			reg = <0x0 0x2>;
+			clocks = <&cpufreq_hw 0>;
+			capacity-dmips-mhz = <1024>;
+			dynamic-power-coefficient = <100>;
+			enable-method = "psci";
+			next-level-cache = <&L2_0>;
+			qcom,freq-domain = <&cpufreq_hw 0>;
+		};
+
+		CPU3: cpu@3 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			reg = <0x0 0x3>;
+			clocks = <&cpufreq_hw 0>;
+			capacity-dmips-mhz = <1024>;
+			dynamic-power-coefficient = <100>;
+			enable-method = "psci";
+			next-level-cache = <&L2_0>;
+			qcom,freq-domain = <&cpufreq_hw 0>;
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
+	firmware {
+		scm: scm {
+			compatible = "qcom,scm-qcm2290", "qcom,scm";
+			clocks = <&rpmcc RPM_SMD_CE1_CLK>;
+			clock-names = "core";
+			#reset-cells = <1>;
+		};
+	};
+
+	memory@40000000 {
+		device_type = "memory";
+		/* We expect the bootloader to fill in the size */
+		reg = <0 0x40000000 0 0>;
+	};
+
+	pmu {
+		compatible = "arm,armv8-pmuv3";
+		interrupts = <GIC_PPI 6 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	psci {
+		compatible = "arm,psci-1.0";
+		method = "smc";
+	};
+
+	reserved_memory: reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		hyp_mem: hyp@45700000 {
+			reg = <0x0 0x45700000 0x0 0x600000>;
+			no-map;
+		};
+
+		xbl_aop_mem: xbl-aop@45e00000 {
+			reg = <0x0 0x45e00000 0x0 0x140000>;
+			no-map;
+		};
+
+		sec_apps_mem: sec-apps@45fff000 {
+			reg = <0x0 0x45fff000 0x0 0x1000>;
+			no-map;
+		};
+
+		smem_mem: smem@46000000 {
+			compatible = "qcom,smem";
+			reg = <0x0 0x46000000 0x0 0x200000>;
+			no-map;
+
+			hwlocks = <&tcsr_mutex 3>;
+			qcom,rpm-msg-ram = <&rpm_msg_ram>;
+		};
+
+		pil_modem_mem: modem@4ab00000 {
+			reg = <0x0 0x4ab00000 0x0 0x6900000>;
+			no-map;
+		};
+
+		pil_video_mem: video@51400000 {
+			reg = <0x0 0x51400000 0x0 0x500000>;
+			no-map;
+		};
+
+		wlan_msa_mem: wlan-msa@51900000 {
+			reg = <0x0 0x51900000 0x0 0x100000>;
+			no-map;
+		};
+
+		pil_adsp_mem: adsp@51a00000 {
+			reg = <0x0 0x51a00000 0x0 0x1c00000>;
+			no-map;
+		};
+
+		pil_ipa_fw_mem: ipa-fw@53600000 {
+			reg = <0x0 0x53600000 0x0 0x10000>;
+			no-map;
+		};
+
+		pil_ipa_gsi_mem: ipa-gsi@53610000 {
+			reg = <0x0 0x53610000 0x0 0x5000>;
+			no-map;
+		};
+
+		pil_gpu_mem: zap@53615000 {
+			compatible = "shared-dma-pool";
+			reg = <0x0 0x53615000 0x0 0x2000>;
+			no-map;
+		};
+
+		cont_splash_memory: framebuffer@5c000000 {
+			reg = <0x0 0x5c000000 0x0 0x00f00000>;
+			no-map;
+		};
+
+		dfps_data_memory: dpfs-data@5cf00000 {
+			reg = <0x0 0x5cf00000 0x0 0x0100000>;
+			no-map;
+		};
+
+		removed_mem: reserved@60000000 {
+			reg = <0x0 0x60000000 0x0 0x3900000>;
+			no-map;
+		};
+
+		rmtfs_mem: memory@89b01000 {
+			compatible = "qcom,rmtfs-mem";
+			reg = <0x0 0x89b01000 0x0 0x200000>;
+			no-map;
+
+			qcom,client-id = <1>;
+			qcom,vmid = <QCOM_SCM_VMID_MSS_MSA QCOM_SCM_VMID_NAV>;
+		};
+	};
+
+	rpm-glink {
+		compatible = "qcom,glink-rpm";
+		interrupts = <GIC_SPI 194 IRQ_TYPE_EDGE_RISING>;
+		qcom,rpm-msg-ram = <&rpm_msg_ram>;
+		mboxes = <&apcs_glb 0>;
+
+		rpm_requests: rpm-requests {
+			compatible = "qcom,rpm-qcm2290";
+			qcom,glink-channels = "rpm_requests";
+
+			rpmcc: clock-controller {
+				compatible = "qcom,rpmcc-qcm2290", "qcom,rpmcc";
+				clocks = <&xo_board>;
+				clock-names = "xo";
+				#clock-cells = <1>;
+			};
+
+			rpmpd: power-controller {
+				compatible = "qcom,qcm2290-rpmpd";
+				#power-domain-cells = <1>;
+				operating-points-v2 = <&rpmpd_opp_table>;
+
+				rpmpd_opp_table: opp-table {
+					compatible = "operating-points-v2";
+
+					rpmpd_opp_min_svs: opp1 {
+						opp-level = <RPM_SMD_LEVEL_MIN_SVS>;
+					};
+
+					rpmpd_opp_low_svs: opp2 {
+						opp-level = <RPM_SMD_LEVEL_LOW_SVS>;
+					};
+
+					rpmpd_opp_svs: opp3 {
+						opp-level = <RPM_SMD_LEVEL_SVS>;
+					};
+
+					rpmpd_opp_svs_plus: opp4 {
+						opp-level = <RPM_SMD_LEVEL_SVS_PLUS>;
+					};
+
+					rpmpd_opp_nom: opp5 {
+						opp-level = <RPM_SMD_LEVEL_NOM>;
+					};
+
+					rpmpd_opp_nom_plus: opp6 {
+						opp-level = <RPM_SMD_LEVEL_NOM_PLUS>;
+					};
+
+					rpmpd_opp_turbo: opp7 {
+						opp-level = <RPM_SMD_LEVEL_TURBO>;
+					};
+
+					rpmpd_opp_turbo_plus: opp8 {
+						opp-level = <RPM_SMD_LEVEL_TURBO_NO_CPR>;
+					};
+				};
+			};
+		};
+	};
+
+	soc: soc@0 {
+		compatible = "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges = <0 0 0 0 0x10 0>;
+		dma-ranges = <0 0 0 0 0x10 0>;
+
+		tcsr_mutex: hwlock@340000 {
+			compatible = "qcom,tcsr-mutex";
+			reg = <0x0 0x00340000 0x0 0x20000>;
+			#hwlock-cells = <1>;
+		};
+
+		tlmm: pinctrl@500000 {
+			compatible = "qcom,qcm2290-tlmm";
+			reg = <0x0 0x00500000 0x0 0x300000>;
+			interrupts = <GIC_SPI 227 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			gpio-ranges = <&tlmm 0 0 127>;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+
+			qup_uart0_default: qup-uart0-default-state {
+				pins = "gpio0", "gpio1", "gpio2", "gpio3";
+				function = "qup0";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
+			sdc1_state_on: sdc1-on-state {
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
+			sdc1_state_off: sdc1-off-state {
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
+
+			sdc2_state_on: sdc2-on-state {
+				clk-pins {
+					pins = "sdc2_clk";
+					drive-strength = <16>;
+					bias-disable;
+				};
+
+				cmd-pins {
+					pins = "sdc2_cmd";
+					drive-strength = <10>;
+					bias-pull-up;
+				};
+
+				data-pins {
+					pins = "sdc2_data";
+					drive-strength = <10>;
+					bias-pull-up;
+				};
+			};
+
+			sdc2_state_off: sdc2-off-state {
+				clk-pins {
+					pins = "sdc2_clk";
+					drive-strength = <2>;
+					bias-disable;
+				};
+
+				cmd-pins {
+					pins = "sdc2_cmd";
+					drive-strength = <2>;
+					bias-pull-up;
+				};
+
+				data-pins {
+					pins = "sdc2_data";
+					drive-strength = <2>;
+					bias-pull-up;
+				};
+			};
+		};
+
+		gcc: clock-controller@1400000 {
+			compatible = "qcom,gcc-qcm2290";
+			reg = <0x0 0x01400000 0x0 0x1f0000>;
+			clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>, <&sleep_clk>;
+			clock-names = "bi_tcxo", "sleep_clk";
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+			#power-domain-cells = <1>;
+		};
+
+		usb_hsphy: phy@1613000 {
+			compatible = "qcom,qcm2290-qusb2-phy";
+			reg = <0x0 0x01613000 0x0 0x180>;
+
+			clocks = <&gcc GCC_AHB2PHY_USB_CLK>,
+				 <&rpmcc RPM_SMD_XO_CLK_SRC>;
+			clock-names = "cfg_ahb", "ref";
+
+			resets = <&gcc GCC_QUSB2PHY_PRIM_BCR>;
+			nvmem-cells = <&qusb2_hstx_trim>;
+			#phy-cells = <0>;
+
+			status = "disabled";
+		};
+
+		qfprom@1b44000 {
+			compatible = "qcom,qcm2290-qfprom", "qcom,qfprom";
+			reg = <0x0 0x01b44000 0x0 0x3000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			qusb2_hstx_trim: hstx-trim@25b {
+				reg = <0x25b 0x1>;
+				bits = <1 4>;
+			};
+		};
+
+		spmi_bus: spmi@1c40000 {
+			compatible = "qcom,spmi-pmic-arb";
+			reg = <0x0 0x01c40000 0x0 0x1100>,
+			      <0x0 0x01e00000 0x0 0x2000000>,
+			      <0x0 0x03e00000 0x0 0x100000>,
+			      <0x0 0x03f00000 0x0 0xa0000>,
+			      <0x0 0x01c0a000 0x0 0x26000>;
+			reg-names = "core",
+				    "chnls",
+				    "obsrvr",
+				    "intr",
+				    "cnfg";
+			interrupts = <GIC_SPI 183 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "periph_irq";
+			qcom,ee = <0>;
+			qcom,channel = <0>;
+			#address-cells = <2>;
+			#size-cells = <0>;
+			interrupt-controller;
+			#interrupt-cells = <4>;
+		};
+
+		tsens0: thermal-sensor@4411000 {
+			compatible = "qcom,qcm2290-tsens", "qcom,tsens-v2";
+			reg = <0x0 0x04411000 0x0 0x1ff>,
+			      <0x0 0x04410000 0x0 0x8>;
+			#qcom,sensors = <10>;
+			interrupts = <GIC_SPI 275 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "uplow", "critical";
+			#thermal-sensor-cells = <1>;
+		};
+
+		rng: rng@4453000 {
+			compatible = "qcom,prng-ee";
+			reg = <0x0 0x04453000 0x0 0x1000>;
+			clocks = <&rpmcc RPM_SMD_HWKM_CLK>;
+			clock-names = "core";
+		};
+
+		rpm_msg_ram: sram@45f0000 {
+			compatible = "qcom,rpm-msg-ram";
+			reg = <0x0 0x045f0000 0x0 0x7000>;
+		};
+
+		sram@4690000 {
+			compatible = "qcom,rpm-stats";
+			reg = <0x0 0x04690000 0x0 0x10000>;
+		};
+
+		sdhc_1: mmc@4744000 {
+			compatible = "qcom,qcm2290-sdhci", "qcom,sdhci-msm-v5";
+			reg = <0x0 0x04744000 0x0 0x1000>,
+			      <0x0 0x04745000 0x0 0x1000>,
+			      <0x0 0x04748000 0x0 0x8000>;
+			reg-names = "hc",
+				    "cqhci",
+				    "ice";
+
+			interrupts = <GIC_SPI 348 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 352 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "hc_irq", "pwr_irq";
+
+			clocks = <&gcc GCC_SDCC1_AHB_CLK>,
+				 <&gcc GCC_SDCC1_APPS_CLK>,
+				 <&rpmcc RPM_SMD_XO_CLK_SRC>,
+				 <&gcc GCC_SDCC1_ICE_CORE_CLK>;
+			clock-names = "iface",
+				      "core",
+				      "xo",
+				      "ice";
+
+			resets = <&gcc GCC_SDCC1_BCR>;
+
+			power-domains = <&rpmpd QCM2290_VDDCX>;
+			iommus = <&apps_smmu 0xc0 0x0>;
+
+			qcom,dll-config = <0x000f642c>;
+			qcom,ddr-config = <0x80040868>;
+			bus-width = <8>;
+
+			status = "disabled";
+		};
+
+		sdhc_2: mmc@4784000 {
+			compatible = "qcom,qcm2290-sdhci", "qcom,sdhci-msm-v5";
+			reg = <0x0 0x04784000 0x0 0x1000>;
+			reg-names = "hc";
+
+			interrupts = <GIC_SPI 350 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 353 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "hc_irq", "pwr_irq";
+
+			clocks = <&gcc GCC_SDCC2_AHB_CLK>,
+				 <&gcc GCC_SDCC2_APPS_CLK>,
+				 <&rpmcc RPM_SMD_XO_CLK_SRC>;
+			clock-names = "iface",
+				      "core",
+				      "xo";
+
+			resets = <&gcc GCC_SDCC2_BCR>;
+
+			power-domains = <&rpmpd QCM2290_VDDCX>;
+			operating-points-v2 = <&sdhc2_opp_table>;
+			iommus = <&apps_smmu 0xa0 0x0>;
+
+			qcom,dll-config = <0x0007642c>;
+			qcom,ddr-config = <0x80040868>;
+			bus-width = <4>;
+
+			status = "disabled";
+
+			sdhc2_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-100000000 {
+					opp-hz = /bits/ 64 <100000000>;
+					required-opps = <&rpmpd_opp_low_svs>;
+				};
+
+				opp-202000000 {
+					opp-hz = /bits/ 64 <202000000>;
+					required-opps = <&rpmpd_opp_svs_plus>;
+				};
+			};
+		};
+
+		gpi_dma0: dma-controller@4a00000 {
+			compatible = "qcom,qcm2290-gpi-dma", "qcom,sm6350-gpi-dma";
+			reg = <0x0 0x04a00000 0x0 0x60000>;
+			interrupts = <GIC_SPI 335 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 336 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 337 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 338 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 339 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 340 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 341 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 342 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 343 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 344 IRQ_TYPE_LEVEL_HIGH>;
+			dma-channels =  <10>;
+			dma-channel-mask = <0x1f>;
+			iommus = <&apps_smmu 0xf6 0x0>;
+			#dma-cells = <3>;
+			status = "disabled";
+		};
+
+		qupv3_id_0: geniqup@4ac0000 {
+			compatible = "qcom,geni-se-qup";
+			reg = <0x0 0x04ac0000 0x0 0x2000>;
+			clocks = <&gcc GCC_QUPV3_WRAP_0_M_AHB_CLK>,
+				 <&gcc GCC_QUPV3_WRAP_0_S_AHB_CLK>;
+			clock-names = "m-ahb", "s-ahb";
+			iommus = <&apps_smmu 0xe3 0x0>;
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+			status = "disabled";
+
+			uart0: serial@4a80000 {
+				compatible = "qcom,geni-uart";
+				reg = <0x0 0x04a80000 0x0 0x4000>;
+				interrupts = <GIC_SPI 327 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&gcc GCC_QUPV3_WRAP0_S0_CLK>;
+				clock-names = "se";
+				pinctrl-0 = <&qup_uart0_default>;
+				pinctrl-names = "default";
+				status = "disabled";
+			};
+		};
+
+		usb: usb@4ef8800 {
+			compatible = "qcom,qcm2290-dwc3", "qcom,dwc3";
+			reg = <0x0 0x04ef8800 0x0 0x400>;
+			interrupts = <GIC_SPI 260 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 422 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "hs_phy_irq", "ss_phy_irq";
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
+			resets = <&gcc GCC_USB30_PRIM_BCR>;
+			power-domains = <&gcc GCC_USB30_PRIM_GDSC>;
+			wakeup-source;
+
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+
+			status = "disabled";
+
+			usb_dwc3: usb@4e00000 {
+				compatible = "snps,dwc3";
+				reg = <0x0 0x04e00000 0x0 0xcd00>;
+				interrupts = <GIC_SPI 255 IRQ_TYPE_LEVEL_HIGH>;
+				phys = <&usb_hsphy>;
+				phy-names = "usb2-phy";
+				iommus = <&apps_smmu 0x120 0x0>;
+				snps,dis_u2_susphy_quirk;
+				snps,dis_enblslpm_quirk;
+				snps,has-lpm-erratum;
+				snps,hird-threshold = /bits/ 8 <0x10>;
+				snps,usb3_lpm_capable;
+				maximum-speed = "super-speed";
+				dr_mode = "otg";
+			};
+		};
+
+		apps_smmu: iommu@c600000 {
+			compatible = "qcom,qcm2290-smmu-500", "qcom,smmu-500", "arm,mmu-500";
+			reg = <0x0 0x0c600000 0x0 0x80000>;
+			#iommu-cells = <2>;
+			#global-interrupts = <1>;
+
+			interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>,
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
+				     <GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		watchdog@f017000 {
+			compatible = "qcom,apss-wdt-qcm2290", "qcom,kpss-wdt";
+			reg = <0x0 0x0f017000 0x0 0x1000>;
+			interrupts = <GIC_SPI 3 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&sleep_clk>;
+		};
+
+		apcs_glb: mailbox@f111000 {
+			compatible = "qcom,qcm2290-apcs-hmss-global";
+			reg = <0x0 0x0f111000 0x0 0x1000>;
+			#mbox-cells = <1>;
+		};
+
+		timer@f120000 {
+			compatible = "arm,armv7-timer-mem";
+			reg = <0x0 0x0f120000 0x0 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0x0 0x0f121000 0x8000>;
+
+			frame@0 {
+				reg = <0x0 0x1000>,
+				      <0x1000 0x1000>;
+				interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
+				frame-number = <0>;
+			};
+
+			frame@2000 {
+				reg = <0x2000 0x1000>;
+				interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
+				frame-number = <1>;
+				status = "disabled";
+			};
+
+			frame@3000 {
+				reg = <0x3000 0x1000>;
+				interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
+				frame-number = <2>;
+				status = "disabled";
+			};
+
+			frame@4000 {
+				reg = <0x4000 0x1000>;
+				interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
+				frame-number = <3>;
+				status = "disabled";
+			};
+
+			frame@5000 {
+				reg = <0x5000 0x1000>;
+				interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
+				frame-number = <4>;
+				status = "disabled";
+			};
+
+			frame@6000 {
+				reg = <0x6000 0x1000>;
+				interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
+				frame-number = <5>;
+				status = "disabled";
+			};
+
+			frame@7000 {
+				reg = <0x7000 0x1000>;
+				interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
+				frame-number = <6>;
+				status = "disabled";
+			};
+		};
+
+		intc: interrupt-controller@f200000 {
+			compatible = "arm,gic-v3";
+			reg = <0x0 0x0f200000 0x0 0x10000>,
+			      <0x0 0x0f300000 0x0 0x100000>;
+			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
+			#interrupt-cells = <3>;
+			interrupt-controller;
+			interrupt-parent = <&intc>;
+			#redistributor-regions = <1>;
+			redistributor-stride = <0x0 0x20000>;
+		};
+
+		cpufreq_hw: cpufreq@f521000 {
+			compatible = "qcom,qcm2290-cpufreq-hw", "qcom,cpufreq-hw";
+			reg = <0x0 0x0f521000 0x0 0x1000>;
+			reg-names = "freq-domain0";
+			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "dcvsh-irq-0";
+			clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>, <&gcc GPLL0>;
+			clock-names = "xo", "alternate";
+
+			#freq-domain-cells = <1>;
+			#clock-cells = <1>;
+		};
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupts = <GIC_PPI 1 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 2 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 3 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 0 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
+	};
+};
diff --git a/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts b/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
new file mode 100644
index 000000000000..539a06456334
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
@@ -0,0 +1,107 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+/*
+ * Copyright (c) 2023, Linaro Ltd
+ */
+
+/dts-v1/;
+
+#include "qcm2290.dtsi"
+#include "pm2250.dtsi"
+
+/ {
+	model = "Qualcomm Technologies, Inc. Robotics RB1";
+	compatible = "qcom,qrb2210-rb1", "qcom,qrb2210", "qcom,qcm2290";
+
+	aliases {
+		serial0 = &uart0;
+		sdhc1 = &sdhc_1;
+		sdhc2 = &sdhc_2;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+		label = "gpio-keys";
+
+		pinctrl-0 = <&key_volp_n>;
+		pinctrl-names = "default";
+
+		key-volume-up {
+			label = "Volume Up";
+			linux,code = <KEY_VOLUMEUP>;
+			gpios = <&tlmm 96 GPIO_ACTIVE_LOW>;
+			debounce-interval = <15>;
+			linux,can-disable;
+			wakeup-source;
+		};
+	};
+};
+
+&qupv3_id_0 {
+	status = "okay";
+};
+
+&sdhc_1 {
+	pinctrl-0 = <&sdc1_state_on>;
+	pinctrl-1 = <&sdc1_state_off>;
+	pinctrl-names = "default", "sleep";
+	non-removable;
+	supports-cqe;
+	no-sdio;
+	no-sd;
+	status = "okay";
+};
+
+&sdhc_2 {
+	cd-gpios = <&tlmm 88 GPIO_ACTIVE_LOW>;
+	pinctrl-0 = <&sdc2_state_on &sd_det_in_on>;
+	pinctrl-1 = <&sdc2_state_off &sd_det_in_off>;
+	pinctrl-names = "default", "sleep";
+	no-sdio;
+	no-mmc;
+	status = "okay";
+};
+
+&tlmm {
+	sd_det_in_on: sd-det-in-on-state {
+		pins = "gpio88";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-pull-up;
+	};
+
+	sd_det_in_off: sd-det-in-off-state {
+		pins = "gpio88";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
+	key_volp_n: key-volp-n-state {
+		pins = "gpio96";
+		function = "gpio";
+		bias-pull-up;
+		output-disable;
+	};
+};
+
+/* UART connected to the Micro-USB port via a FTDI chip */
+&uart0 {
+	compatible = "qcom,geni-debug-uart";
+	status = "okay";
+};
+
+&usb {
+	status = "okay";
+};
+
+&usb_hsphy {
+	status = "okay";
+};
+
+&xo_board {
+	clock-frequency = <38400000>;
+};

-- 
2.40.0

