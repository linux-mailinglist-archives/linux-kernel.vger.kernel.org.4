Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 024B365BCDC
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 10:14:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233100AbjACJOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 04:14:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236816AbjACJOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 04:14:37 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BE1AE019
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 01:14:34 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id e13so28628612ljn.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 01:14:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WaBuQ9fwG0wAQiRR2Yt/WzGF9p4afNWb4h2R5WHNYNo=;
        b=Yrgu+Cex1YpOOdg13Rp2MlznOHTeOVeHCio70W9VnU3fGz3cjnCMoIaqc8gVWTgCIx
         mefu4Uj0P0+VZeTkra+der/GJffbuuSiYrHTQxIB9yBDiAYC2dZNOTPQUFCG5yjxZPRF
         xqzd6TXWiLG1j9mxWv/gE3c7P4tkbBVUumIlwklOnuZUyyRPInYDpqmUnRpvlR5R4Mie
         6ovSR43W7EjvD56EBK7XavYBJdf8g+ivu8UWIcSyJw3vwbaZehEFd1fm1fksucojGraC
         G+Nct/NS8Ut/xI+r9FciodFp8k7nXTkbMs/W5F1krTDm8Z6mld7DL3vCIWSoUrPb9l+9
         XnbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WaBuQ9fwG0wAQiRR2Yt/WzGF9p4afNWb4h2R5WHNYNo=;
        b=kOaHd54skhnX+bh+Sq/vre1/HIjxRlRwiF2nLKGGEO36btDVbBIqG4Z9Ccj31l1jzp
         kjz3uu6WOKB/WKzBWsHn7LZDIupA5x5jzc8Xo8MKwwn94lLKkkiYoM63Wu4Cq6Wyc1ih
         YZyGSzg8/kVB8quOYJueHWvd+zJECsAoUK28XXxF8zzxQMfC5qfGbODyZeAT/IIzNmrH
         vbBnl35GdNW7vsA5KYYnc+ojfPllQB+4mhABudo/FJizXw2RC6dnBjY4tflwPWEFQxk2
         7PiFIahVfdiKb99g8neGvAwjg5iJbyQ2iwP6Au/Wj7fhDdh2v1Enq6R+7vGn3Emnt87r
         NTJA==
X-Gm-Message-State: AFqh2kpSslRQfkMQSS73Jnv35PVSpfWt27+Nh3mCVSi2gjGexA/3NqAX
        F9b70ZFmAZAOeh02ZZ2FCwsodg==
X-Google-Smtp-Source: AMrXdXu0/9XRzoeNB2Cg0a/Qul8NgifiZtWip2zcKedq6ypdQ59wAMYSa81Vn7aADRw6XfJlUm26dw==
X-Received: by 2002:a2e:8608:0:b0:27f:b584:45e4 with SMTP id a8-20020a2e8608000000b0027fb58445e4mr12963980lji.0.1672737272751;
        Tue, 03 Jan 2023 01:14:32 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id 4-20020a2e1644000000b0027fed440702sm529389ljw.98.2023.01.03.01.14.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jan 2023 01:14:32 -0800 (PST)
Message-ID: <6e594438-843a-d03e-5276-d6316a9dc2c0@linaro.org>
Date:   Tue, 3 Jan 2023 10:14:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 4/7] arm64: dts: qcom: Add msm8939 SoC
Content-Language: en-US
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, djakov@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        benl@squareup.com, shawn.guo@linaro.org, fabien.parent@linaro.org,
        leo.yan@linaro.org, dmitry.baryshkov@linaro.org,
        Jun Nie <jun.nie@linaro.org>,
        James Willcox <jwillcox@squareup.com>,
        Joseph Gates <jgates@squareup.com>,
        Max Chen <mchen@squareup.com>, Zac Crosby <zac@squareup.com>,
        Vincent Knecht <vincent.knecht@mailoo.org>,
        Stephan Gerhold <stephan@gerhold.net>
References: <20230103010904.3201835-1-bryan.odonoghue@linaro.org>
 <20230103010904.3201835-5-bryan.odonoghue@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230103010904.3201835-5-bryan.odonoghue@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/01/2023 02:09, Bryan O'Donoghue wrote:
> Add msm8939 a derivative SoC of msm8916. This SoC contains a number of key
> differences to msm8916.
> 
> - big.LITTLE Octa Core - quad 1.5GHz + quad 1.0GHz
> - DRAM 1x800 LPDDR3
> - Camera 4+4 lane CSI
> - Venus @ 1080p60 HEVC
> - DSI x 2
> - Adreno A405
> - WiFi wcn3660/wcn3680b 802.11ac
> 
> Co-developed-by: Shawn Guo <shawn.guo@linaro.org>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> Co-developed-by: Jun Nie <jun.nie@linaro.org>
> Signed-off-by: Jun Nie <jun.nie@linaro.org>
> Co-developed-by: Benjamin Li <benl@squareup.com>
> Signed-off-by: Benjamin Li <benl@squareup.com>
> Co-developed-by: James Willcox <jwillcox@squareup.com>
> Signed-off-by: James Willcox <jwillcox@squareup.com>
> Co-developed-by: Leo Yan <leo.yan@linaro.org>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> Co-developed-by: Joseph Gates <jgates@squareup.com>
> Signed-off-by: Joseph Gates <jgates@squareup.com>
> Co-developed-by: Max Chen <mchen@squareup.com>
> Signed-off-by: Max Chen <mchen@squareup.com>
> Co-developed-by: Zac Crosby <zac@squareup.com>
> Signed-off-by: Zac Crosby <zac@squareup.com>
> Co-developed-by: Vincent Knecht <vincent.knecht@mailoo.org>
> Signed-off-by: Vincent Knecht <vincent.knecht@mailoo.org>
> Co-developed-by: Stephan Gerhold <stephan@gerhold.net>
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/msm8939.dtsi | 2470 +++++++++++++++++++++++++
>  1 file changed, 2470 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/msm8939.dtsi
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8939.dtsi b/arch/arm64/boot/dts/qcom/msm8939.dtsi
> new file mode 100644
> index 0000000000000..03714cdb8b69e
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/msm8939.dtsi
> @@ -0,0 +1,2470 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2013-2015, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2020-2023, Linaro Limited
> + */
> +
> +#include <dt-bindings/clock/qcom,gcc-msm8939.h>
> +#include <dt-bindings/clock/qcom,rpmcc.h>
> +#include <dt-bindings/interconnect/qcom,msm8939.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/power/qcom-rpmpd.h>
> +#include <dt-bindings/reset/qcom,gcc-msm8939.h>
> +#include <dt-bindings/thermal/thermal.h>
> +
> +/ {
> +	qcom,msm-id = <239 0>, <239 0x30000>, <241 0x30000>, <263 0x30000>;
> +
> +	interrupt-parent = <&intc>;
> +
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +
> +	aliases {
> +		mmc0 = &sdhc_1; /* SDC1 eMMC slot */
> +		mmc1 = &sdhc_2; /* SDC2 SD card slot */

These are board specific, not SoC. They depend on physical routing and
labeling on the board (e.g. each board defines what is actually mmc0 or
mmc1). Move to them to board DTS.

> +	};
> +
> +	clocks {
> +		xo_board: xo-board {
> +			compatible = "fixed-clock";
> +			#clock-cells = <0>;
> +			clock-frequency = <19200000>;
> +			clock-output-names = "xo_board";
> +		};
> +
> +		sleep_clk: sleep-clk {
> +			compatible = "fixed-clock";
> +			#clock-cells = <0>;
> +			clock-frequency = <32768>;
> +			clock-output-names = "sleep_clk";
> +		};
> +	};
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		cpu0: cpu@100 {
> +			compatible = "arm,cortex-a53";
> +			device_type = "cpu";
> +			enable-method = "spin-table";
> +			reg = <0x100>;
> +			next-level-cache = <&L2_1>;
> +			power-domains = <&vreg_dummy>;
> +			power-domain-names = "cpr";
> +			qcom,acc = <&acc0>;
> +			qcom,saw = <&saw0>;
> +			cpu-idle-states = <&CPU_SLEEP_0>;
> +			clocks = <&apcs1_mbox>;
> +			#cooling-cells = <2>;
> +			L2_1: l2-cache@1 {

That's not correct unit address. Look at other DTSI. dtc should scream
here with W=1. Please check your DTS for warnings...

../arch/arm64/boot/dts/qcom/msm8939.dtsi:61.21-64.6: Warning
(unit_address_vs_reg): /cpus/cpu@100/l2-cache@1: node has a unit name,
but no reg or ranges property

In other places:

../arch/arm64/boot/dts/qcom/msm8939.dtsi:1825.23-1842.5: Warning
(simple_bus_reg): /soc@0/mmc@7824000: simple-bus unit address format
error, expected "7824900"



../arch/arm64/boot/dts/qcom/msm8939.dtsi:1844.23-1859.5: Warning
(simple_bus_reg): /soc@0/mmc@7864000: simple-bus unit address format
error, expected "7864900"

../arch/arm64/boot/dts/qcom/msm8939.dtsi:1225.22-1276.6: Warning
(avoid_unnecessary_addr_size): /soc@0/mdss@1a00000/dsi@1a98000:
unnecessary #address-cells/#size-cells without "ranges" or child "reg"
property

../arch/arm64/boot/dts/qcom/msm8939.dtsi:415.42-418.6: Warning
(unique_unit_address_if_enabled): /soc@0/qfprom@5c000/ivoltage1@dc:
duplicate unit-address (also used in node /soc@0/qfprom@5c000/quot1@dc)

and some more


> +				compatible = "cache";
> +				cache-level = <2>;
> +			};
> +		};
> +
> +		cpu1: cpu@101 {
> +			compatible = "arm,cortex-a53";
> +			device_type = "cpu";
> +			enable-method = "spin-table";
> +			reg = <0x101>;
> +			next-level-cache = <&L2_1>;
> +			power-domains = <&vreg_dummy>;
> +			power-domain-names = "cpr";
> +			qcom,acc = <&acc1>;
> +			qcom,saw = <&saw1>;
> +			cpu-idle-states = <&CPU_SLEEP_0>;
> +			clocks = <&apcs1_mbox>;
> +			#cooling-cells = <2>;
> +		};
> +
> +		cpu2: cpu@102 {
> +			compatible = "arm,cortex-a53";
> +			device_type = "cpu";
> +			enable-method = "spin-table";
> +			reg = <0x102>;
> +			next-level-cache = <&L2_1>;
> +			power-domains = <&vreg_dummy>;
> +			power-domain-names = "cpr";
> +			qcom,acc = <&acc2>;
> +			qcom,saw = <&saw2>;
> +			cpu-idle-states = <&CPU_SLEEP_0>;
> +			clocks = <&apcs1_mbox>;
> +			#cooling-cells = <2>;
> +		};
> +
> +		cpu3: cpu@103 {
> +			compatible = "arm,cortex-a53";
> +			device_type = "cpu";
> +			enable-method = "spin-table";
> +			reg = <0x103>;
> +			next-level-cache = <&L2_1>;
> +			power-domains = <&vreg_dummy>;
> +			power-domain-names = "cpr";
> +			qcom,acc = <&acc3>;
> +			qcom,saw = <&saw3>;
> +			cpu-idle-states = <&CPU_SLEEP_0>;
> +			clocks = <&apcs1_mbox>;
> +			#cooling-cells = <2>;
> +		};
> +
> +		cpu4: cpu@0 {
> +			compatible = "arm,cortex-a53";
> +			device_type = "cpu";
> +			enable-method = "spin-table";
> +			reg = <0x0>;
> +			qcom,acc = <&acc4>;
> +			qcom,saw = <&saw4>;
> +			cpu-idle-states = <&CPU_SLEEP_0>;
> +			clocks = <&apcs0_mbox>;
> +			#cooling-cells = <2>;
> +			next-level-cache = <&L2_0>;
> +			power-domains = <&vreg_dummy>;
> +			power-domain-names = "cpr";
> +			L2_0: l2-cache@0 {
> +				compatible = "cache";
> +				cache-level = <2>;
> +			};
> +		};
> +
> +		cpu5: cpu@1 {
> +			compatible = "arm,cortex-a53";
> +			device_type = "cpu";
> +			enable-method = "spin-table";
> +			reg = <0x1>;
> +			next-level-cache = <&L2_0>;
> +			power-domains = <&vreg_dummy>;
> +			power-domain-names = "cpr";
> +			qcom,acc = <&acc5>;
> +			qcom,saw = <&saw5>;
> +			cpu-idle-states = <&CPU_SLEEP_0>;
> +			clocks = <&apcs0_mbox>;
> +			#cooling-cells = <2>;
> +		};
> +
> +		cpu6: cpu@2 {
> +			compatible = "arm,cortex-a53";
> +			device_type = "cpu";
> +			enable-method = "spin-table";
> +			reg = <0x2>;
> +			next-level-cache = <&L2_0>;
> +			power-domains = <&vreg_dummy>;
> +			power-domain-names = "cpr";
> +			qcom,acc = <&acc6>;
> +			qcom,saw = <&saw6>;
> +			cpu-idle-states = <&CPU_SLEEP_0>;
> +			clocks = <&apcs0_mbox>;
> +			#cooling-cells = <2>;
> +		};
> +
> +		cpu7: cpu@3 {
> +			compatible = "arm,cortex-a53";
> +			device_type = "cpu";
> +			enable-method = "spin-table";
> +			reg = <0x3>;
> +			next-level-cache = <&L2_0>;
> +			power-domains = <&vreg_dummy>;
> +			power-domain-names = "cpr";
> +			qcom,acc = <&acc7>;
> +			qcom,saw = <&saw7>;
> +			cpu-idle-states = <&CPU_SLEEP_0>;
> +			clocks = <&apcs0_mbox>;
> +			#cooling-cells = <2>;
> +		};
> +
> +		idle-states {
> +			CPU_SLEEP_0: cpu-sleep-0 {
> +				compatible ="qcom,idle-state-spc", "arm,idle-state";
> +				entry-latency-us = <130>;
> +				exit-latency-us = <150>;
> +				min-residency-us = <2000>;
> +				local-timer-stop;
> +			};
> +		};
> +	};
> +
> +	/*
> +	 * MSM8939 has a big.LITTLE heterogeneous computing architecture,
> +	 * consisting of two clusters of four ARM Cortex-A53s each. The
> +	 * LITTLE cluster runs at 1.0-1.2GHz, and the big cluster runs
> +	 * at 1.5-1.7GHz.
> +	 *
> +	 * The enable method used here is spin-table which presupposes use
> +	 * of a 2nd stage boot shim such as lk2nd to have installed a
> +	 * spin-table, the downstream non-psci/non-spin-table method that
> +	 * default msm8916/msm8936/msm8939 will not be supported upstream.
> +	 */
> +	cpu-map {
> +		/* LITTLE (efficiency) cluster */
> +		cluster0 {
> +			core0 {
> +				cpu = <&cpu4>;
> +			};
> +
> +			core1 {
> +				cpu = <&cpu5>;
> +			};
> +
> +			core2 {
> +				cpu = <&cpu6>;
> +			};
> +
> +			core3 {
> +				cpu = <&cpu7>;
> +			};
> +		};
> +
> +		/* big (performance) cluster */
> +		/* Boot CPU is cluster 1 core 0 */
> +		cluster1 {
> +			core0 {
> +				cpu = <&cpu0>;
> +			};
> +
> +			core1 {
> +				cpu = <&cpu1>;
> +			};
> +
> +			core2 {
> +				cpu = <&cpu2>;
> +			};
> +
> +			core3 {
> +				cpu = <&cpu3>;
> +			};
> +		};
> +	};
> +
> +	firmware {
> +		scm: scm {
> +			compatible = "qcom,scm-msm8916", "qcom,scm";
> +			clocks = <&gcc GCC_CRYPTO_CLK>,
> +				 <&gcc GCC_CRYPTO_AXI_CLK>,
> +				 <&gcc GCC_CRYPTO_AHB_CLK>;
> +			clock-names = "core", "bus", "iface";
> +			#reset-cells = <1>;
> +
> +			qcom,dload-mode = <&tcsr 0x6100>;
> +		};
> +	};
> +
> +	hexagon-smp2p {
> +		compatible = "qcom,smp2p";
> +		qcom,smem = <435>, <428>;
> +
> +		interrupts = <GIC_SPI 27 IRQ_TYPE_EDGE_RISING>;
> +
> +		mboxes = <&apcs1_mbox 14>;
> +
> +		qcom,local-pid = <0>;
> +		qcom,remote-pid = <1>;
> +
> +		hexagon_smp2p_out: master-kernel {
> +			qcom,entry-name = "master-kernel";
> +
> +			#qcom,smem-state-cells = <1>;
> +		};
> +
> +		hexagon_smp2p_in: slave-kernel {
> +			qcom,entry-name = "slave-kernel";
> +
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +		};
> +	};
> +
> +	memory@80000000 {
> +		device_type = "memory";
> +		/* We expect the bootloader to fill in the reg */
> +		reg = <0x0 0x80000000 0x0 0x0>;
> +	};
> +
> +	pmu {
> +		compatible = "arm,cortex-a53-pmu";
> +		interrupts = <GIC_PPI 7 (GIC_CPU_MASK_SIMPLE(8)| IRQ_TYPE_LEVEL_HIGH)>;
> +	};
> +
> +	reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		tz-apps@86000000 {
> +			reg = <0x0 0x86000000 0x0 0x300000>;
> +			no-map;
> +		};
> +
> +		smem_mem: smem@86300000 {
> +			reg = <0x0 0x86300000 0x0 0x100000>;
> +			no-map;
> +		};
> +
> +		hypervisor@86400000 {
> +			reg = <0x0 0x86400000 0x0 0x100000>;
> +			no-map;
> +		};
> +
> +		tz@86500000 {
> +			reg = <0x0 0x86500000 0x0 0x180000>;
> +			no-map;
> +		};
> +
> +		reserved@86680000 {
> +			reg = <0x0 0x86680000 0x0 0x80000>;
> +			no-map;
> +		};
> +
> +		rmtfs@86700000 {
> +			compatible = "qcom,rmtfs-mem";
> +			reg = <0x0 0x86700000 0x0 0xe0000>;
> +			no-map;
> +
> +			qcom,client-id = <1>;
> +		};
> +
> +		rfsa@867e0000 {
> +			reg = <0x0 0x867e0000 0x0 0x20000>;
> +			no-map;
> +		};
> +
> +		mpss_mem: mpss@86800000 {
> +			reg = <0x0 0x86800000 0x0 0x5500000>;
> +			no-map;
> +		};
> +
> +		wcnss_mem: wcnss@8bd00000 {
> +			reg = <0x0 0x8bd00000 0x0 0x600000>;
> +			no-map;
> +		};
> +
> +		venus_mem: venus@8c300000 {
> +			reg = <0x0 0x8c300000 0x0 0x800000>;
> +			no-map;
> +		};
> +
> +		mba_mem: mba@8cb00000 {
> +			no-map;
> +			reg = <0x0 0x8cb00000 0x0 0x100000>;
> +		};
> +	};
> +
> +	smem {
> +		compatible = "qcom,smem";
> +
> +		memory-region = <&smem_mem>;
> +		qcom,rpm-msg-ram = <&rpm_msg_ram>;
> +
> +		hwlocks = <&tcsr_mutex 3>;
> +	};
> +
> +	smsm {
> +		compatible = "qcom,smsm";
> +
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		qcom,ipc-1 = <&apcs1_mbox 8 13>;
> +		qcom,ipc-3 = <&apcs1_mbox 8 19>;
> +
> +		apps_smsm: apps@0 {
> +			reg = <0>;
> +
> +			#qcom,smem-state-cells = <1>;
> +		};
> +
> +		hexagon_smsm: hexagon@1 {
> +			reg = <1>;
> +			interrupts = <GIC_SPI 26 IRQ_TYPE_EDGE_RISING>;
> +
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +		};
> +
> +		wcnss_smsm: wcnss@6 {
> +			reg = <6>;
> +			interrupts = <GIC_SPI 144 IRQ_TYPE_EDGE_RISING>;
> +
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +		};
> +	};
> +
> +	soc: soc@0 {
> +

Drop blank line.

> +		compatible = "simple-bus";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges = <0 0 0 0xffffffff>;
> +
> +		rng@22000 {
> +			compatible = "qcom,prng";
> +			reg = <0x00022000 0x200>;
> +			clocks = <&gcc GCC_PRNG_AHB_CLK>;
> +			clock-names = "core";
> +		};
> +
> +		qfprom: qfprom@5c000 {
> +			compatible = "qcom,msm8916-qfprom", "qcom,qfprom";
> +			reg = <0x0005c000 0x1000>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			tsens_caldata: caldata@a0 {
> +				reg = <0xa0 0x5c>;
> +			};
> +			cpr_efuse_init_voltage1: ivoltage1@dc {
> +				reg = <0xdc 0x4>;
> +				bits = <4 6>;
> +			};
> +			cpr_efuse_init_voltage2: ivoltage2@da {
> +				reg = <0xda 0x4>;
> +				bits = <2 6>;
> +			};
> +			cpr_efuse_init_voltage3: ivoltage3@d8 {
> +				reg = <0xd8 0x4>;
> +				bits = <0 6>;
> +			};
> +			cpr_efuse_quot1: quot1@dc {
> +				reg = <0xdd 0x8>;

Also need fixes and dtc points this.

> +				bits = <2 12>;
> +			};
> +			cpr_efuse_quot2: quot2@da {
> +				reg = <0xdb 0x8>;
> +				bits = <0x0 12>;
> +			};
> +			cpr_efuse_quot3: quot3@d8 {
> +				reg = <0xd8 0x8>;
> +				bits = <6 12>;
> +			};
> +			cpr_efuse_ring1: ring1@de {
> +				reg = <0xde 0x4>;
> +				bits = <6 3>;
> +			};
> +			cpr_efuse_ring2: ring2@de {
> +				reg = <0xde 0x4>;
> +				bits = <6 3>;
> +			};
> +			cpr_efuse_ring3: ring3@de {
> +				reg = <0xde 0x4>;
> +				bits = <6 3>;
> +			};
> +			cpr_efuse_revision: revision@4 {
> +				reg = <0x5 0x1>;
> +				bits = <5 1>;
> +			};
> +			cpr_efuse_revision_high: revision-high@4 {
> +				reg = <0x7 0x1>;
> +				bits = <0 1>;
> +			};
> +			cpr_efuse_pvs_version: pvs@4 {
> +				reg = <0x3 0x1>;
> +				bits = <5 1>;
> +			};
> +			cpr_efuse_pvs_version_high: pvs-high@4 {
> +				reg = <0x6 0x1>;
> +				bits = <2 2>;
> +			};
> +			cpr_efuse_speedbin: speedbin@c {
> +				reg = <0xc 0x1>;
> +				bits = <2 3>;
> +			};
> +

Drop blank line.

> +		};
> +
> +		rpm_msg_ram: sram@60000 {
> +			compatible = "qcom,rpm-msg-ram";
> +			reg = <0x00060000 0x8000>;
> +		};
> +
> +		bimc: interconnect@400000 {
> +			compatible = "qcom,msm8939-bimc";
> +			reg = <0x00400000 0x62000>;
> +			clock-names = "bus", "bus_a";
> +			clocks = <&rpmcc RPM_SMD_BIMC_CLK>,
> +				 <&rpmcc RPM_SMD_BIMC_A_CLK>;
> +			#interconnect-cells = <1>;
> +			status = "okay";

No need.

> +		};
> +
> +		tsens: thermal-sensor@4a9000 {
> +			compatible = "qcom,msm8939-tsens", "qcom,tsens-v0_1";
> +			reg = <0x004a9000 0x1000>, /* TM */
> +			      <0x004a8000 0x1000>; /* SROT */
> +			nvmem-cells = <&tsens_caldata>;
> +			nvmem-cell-names = "calib";
> +			#qcom,sensors = <10>;
> +			interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "uplow";
> +			#thermal-sensor-cells = <1>;
> +		};
> +
> +		restart@4ab000 {
> +			compatible = "qcom,pshold";
> +			reg = <0x004ab000 0x4>;
> +		};
> +
> +		pcnoc: interconnect@500000 {
> +			compatible = "qcom,msm8939-pcnoc";
> +			reg = <0x00500000 0x11000>;
> +			clock-names = "bus", "bus_a";
> +			clocks = <&rpmcc RPM_SMD_PCNOC_CLK>,
> +				 <&rpmcc RPM_SMD_PCNOC_A_CLK>;
> +			#interconnect-cells = <1>;
> +			status = "okay";

Drop...

> +		};
> +
> +		snoc: interconnect@580000 {
> +			compatible = "qcom,msm8939-snoc";
> +			reg = <0x00580000 0x14080>;
> +			clock-names = "bus", "bus_a";
> +			clocks = <&rpmcc RPM_SMD_SNOC_CLK>,
> +				 <&rpmcc RPM_SMD_SNOC_A_CLK>;
> +			#interconnect-cells = <1>;
> +			status = "okay";

Everywhere.

> +
> +			snoc_mm: interconnect-snoc {
> +				compatible = "qcom,msm8939-snoc-mm";
> +				clock-names = "bus", "bus_a";
> +				clocks = <&rpmcc RPM_SMD_SYSMMNOC_CLK>,
> +					 <&rpmcc RPM_SMD_SYSMMNOC_A_CLK>;
> +				#interconnect-cells = <1>;
> +				status = "okay";
> +			};
> +
> +		};
> +
> +		msmgpio: pinctrl@1000000 {
> +			compatible = "qcom,msm8916-pinctrl";
> +			reg = <0x01000000 0x300000>;
> +			interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
> +			gpio-controller;
> +			gpio-ranges = <&msmgpio 0 0 122>;
> +			#gpio-cells = <2>;
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +
> +			blsp1_uart1_default: blsp1-uart1-default-state {
> +				pins = "gpio0", "gpio1", "gpio2", "gpio3";
> +				function = "blsp_uart1";
> +
> +				drive-strength = <16>;
> +				bias-disable;
> +			};
> +
> +			blsp1_uart1_sleep: blsp1-uart1-sleep-state {
> +				pins = "gpio0", "gpio1", "gpio2", "gpio3";
> +				function = "gpio";
> +
> +				drive-strength = <2>;
> +				bias-pull-down;
> +			};
> +
> +			blsp1_uart2_default: blsp1-uart2-default-state {
> +				pins = "gpio4", "gpio5";
> +				function = "blsp_uart2";
> +
> +				drive-strength = <16>;
> +				bias-disable;
> +			};
> +
> +			blsp1_uart2_sleep: blsp1-uart2-sleep-state {
> +				pins = "gpio4", "gpio5";
> +				function = "gpio";
> +
> +				drive-strength = <2>;
> +				bias-pull-down;
> +			};
> +
> +			camera_front_default: camera-front-default-state {
> +				pwdn-pins {
> +					pins = "gpio33";
> +					function = "gpio";
> +
> +					drive-strength = <16>;
> +					bias-disable;
> +				};
> +				rst-pins {
> +					pins = "gpio28";
> +					function = "gpio";
> +
> +					drive-strength = <16>;
> +					bias-disable;
> +				};
> +				mclk1-pins {
> +					pins = "gpio27";
> +					function = "cam_mclk1";
> +
> +					drive-strength = <16>;
> +					bias-disable;
> +				};
> +			};
> +
> +			camera_rear_default: camera-rear-default-state {
> +				pwdn-pins {
> +					pins = "gpio34";
> +					function = "gpio";
> +
> +					drive-strength = <16>;
> +					bias-disable;
> +				};
> +				rst-pins {
> +					pins = "gpio35";
> +					function = "gpio";
> +
> +					drive-strength = <16>;
> +					bias-disable;
> +				};
> +				mclk0-pins {
> +					pins = "gpio26";
> +					function = "cam_mclk0";
> +
> +					drive-strength = <16>;
> +					bias-disable;
> +				};
> +			};
> +
> +			cci0_default: cci0-default-state {
> +				pins = "gpio29", "gpio30";
> +				function = "cci_i2c";
> +
> +				drive-strength = <16>;
> +				bias-disable;
> +			};
> +
> +			cdc-pdm-lines-state {
> +				cdc_pdm_lines_act: pdm-lines-on-pins {
> +					pins = "gpio63", "gpio64", "gpio65", "gpio66",
> +					       "gpio67", "gpio68";
> +					function = "cdc_pdm0";
> +
> +					drive-strength = <8>;
> +					bias-disable;
> +				};
> +				cdc_pdm_lines_sus: pdm-lines-off-pins {
> +					pins = "gpio63", "gpio64", "gpio65", "gpio66",
> +					       "gpio67", "gpio68";
> +					function = "cdc_pdm0";
> +
> +					drive-strength = <2>;
> +					bias-pull-down;
> +				};
> +			};
> +
> +			cdc_dmic_lines_act: cdc-dmic-lines-on-state {
> +				clk-pins {
> +					pins = "gpio0";
> +					function = "dmic0_clk";
> +
> +					drive-strength = <8>;
> +				};
> +				data-pins {
> +					pins = "gpio1";
> +					function = "dmic0_data";
> +
> +					drive-strength = <8>;
> +				};
> +			};
> +			cdc_dmic_lines_sus: cdc-dmic-lines-off-state {
> +				clk-pins {
> +					pins = "gpio0";
> +					function = "dmic0_clk";
> +
> +					drive-strength = <2>;
> +					bias-disable;
> +				};
> +				data-pins {
> +					pins = "gpio1";
> +					function = "dmic0_data";
> +
> +					drive-strength = <2>;
> +					bias-disable;
> +				};
> +			};
> +
> +			ext-mclk-tlmm-lines-state {
> +				ext_mclk_tlmm_lines_act: mclk-lines-on-pins {
> +					pins = "gpio116";
> +					function = "pri_mi2s";
> +
> +					drive-strength = <8>;
> +					bias-disable;
> +				};
> +				ext_mclk_tlmm_lines_sus: mclk-lines-off-pins {
> +					pins = "gpio116";
> +					function = "pri_mi2s";
> +
> +					drive-strength = <2>;
> +					bias-disable;
> +				};
> +			};
> +
> +			ext-pri-tlmm-lines-state {
> +				ext_pri_tlmm_lines_act: ext-pa-on-pins {
> +					pins = "gpio113", "gpio114", "gpio115", "gpio116";
> +					function = "pri_mi2s";
> +
> +					drive-strength = <8>;
> +					bias-disable;
> +				};
> +				ext_pri_tlmm_lines_sus: ext-pa-off-pins {
> +					pins = "gpio113", "gpio114", "gpio115", "gpio116";
> +					function = "pri_mi2s";
> +
> +					drive-strength = <2>;
> +					bias-disable;
> +				};
> +			};
> +
> +			ext-pri-ws-line-state {
> +				ext_pri_ws_act: ext-pa-on-pins {
> +					pins = "gpio110";
> +					function = "pri_mi2s_ws";
> +
> +					drive-strength = <8>;
> +					bias-disable;
> +				};
> +				ext_pri_ws_sus: ext-pa-off-pins {
> +					pins = "gpio110";
> +					function = "pri_mi2s_ws";
> +
> +					drive-strength = <2>;
> +					bias-disable;
> +				};
> +			};
> +
> +			/* secondary Mi2S */
> +			ext-sec-tlmm-lines-state {
> +				ext_sec_tlmm_lines_act: tlmm-lines-on-pins {
> +					pins = "gpio112", "gpio117", "gpio118", "gpio119";
> +					function = "sec_mi2s";
> +
> +					drive-strength = <8>;
> +					bias-disable;
> +				};
> +				ext_sec_tlmm_lines_sus: tlmm-lines-off-pins {
> +					pins = "gpio112", "gpio117", "gpio118", "gpio119";
> +					function = "sec_mi2s";
> +
> +					drive-strength = <2>;
> +					bias-disable;
> +				};
> +			};
> +
> +			i2c1_default: i2c1-default-state {
> +				pins = "gpio2", "gpio3";
> +				function = "blsp_i2c1";
> +
> +				drive-strength = <2>;
> +				bias-disable;
> +			};
> +
> +			i2c1_sleep: i2c1-sleep-state {
> +				pins = "gpio2", "gpio3";
> +				function = "gpio";
> +
> +				drive-strength = <2>;
> +				bias-disable;
> +			};
> +
> +			i2c2_default: i2c2-default-state {
> +				pins = "gpio6", "gpio7";
> +				function = "blsp_i2c2";
> +
> +				drive-strength = <2>;
> +				bias-disable;
> +			};
> +
> +			i2c2_sleep: i2c2-sleep-state {
> +				pins = "gpio6", "gpio7";
> +				function = "gpio";
> +
> +				drive-strength = <2>;
> +				bias-disable;
> +			};
> +
> +			i2c3_default: i2c3-default-state {
> +				pins = "gpio10", "gpio11";
> +				function = "blsp_i2c3";
> +
> +				drive-strength = <2>;
> +				bias-disable;
> +			};
> +
> +			i2c3_sleep: i2c3-sleep-state {
> +				pins = "gpio10", "gpio11";
> +				function = "gpio";
> +
> +				drive-strength = <2>;
> +				bias-disable;
> +			};
> +
> +			i2c4_default: i2c4-default-state {
> +				pins = "gpio14", "gpio15";
> +				function = "blsp_i2c4";
> +
> +				drive-strength = <2>;
> +				bias-disable;
> +			};
> +
> +			i2c4_sleep: i2c4-sleep-state {
> +				pins = "gpio14", "gpio15";
> +				function = "gpio";
> +
> +				drive-strength = <2>;
> +				bias-disable;
> +			};
> +
> +			i2c5_default: i2c5-default-state {
> +				pins = "gpio18", "gpio19";
> +				function = "blsp_i2c5";
> +
> +				drive-strength = <2>;
> +				bias-disable;
> +			};
> +
> +			i2c5_sleep: i2c5-sleep-state {
> +				pins = "gpio18", "gpio19";
> +				function = "gpio";
> +
> +				drive-strength = <2>;
> +				bias-disable;
> +			};
> +
> +			i2c6_default: i2c6-default-state {
> +				pins = "gpio22", "gpio23";
> +				function = "blsp_i2c6";
> +
> +				drive-strength = <2>;
> +				bias-disable;
> +			};
> +
> +			i2c6_sleep: i2c6-sleep-state {
> +				pins = "gpio22", "gpio23";
> +				function = "gpio";
> +
> +				drive-strength = <2>;
> +				bias-disable;
> +			};
> +
> +			pmx-sdc1-clk-state {
> +				sdc1_clk_on: clk-on-pins {
> +					pins = "sdc1_clk";
> +
> +					bias-disable;
> +					drive-strength = <16>;
> +				};
> +				sdc1_clk_off: clk-off-pins {
> +					pins = "sdc1_clk";
> +
> +					bias-disable;
> +					drive-strength = <2>;
> +				};
> +			};
> +
> +			pmx-sdc1-cmd-state {
> +				sdc1_cmd_on: cmd-on-pins {
> +					pins = "sdc1_cmd";
> +
> +					bias-pull-up;
> +					drive-strength = <10>;
> +				};
> +				sdc1_cmd_off: cmd-off-pins {
> +					pins = "sdc1_cmd";
> +
> +					bias-pull-up;
> +					drive-strength = <2>;
> +				};
> +			};
> +
> +			pmx-sdc1-data-state {
> +				sdc1_data_on: data-on-pins {
> +					pins = "sdc1_data";
> +
> +					bias-pull-up;
> +					drive-strength = <10>;
> +				};
> +				sdc1_data_off: data-off-pins {
> +					pins = "sdc1_data";
> +
> +					bias-pull-up;
> +					drive-strength = <2>;
> +				};
> +			};
> +
> +			pmx-sdc2-clk-state {
> +				sdc2_clk_on: clk-on-pins {
> +					pins = "sdc2_clk";
> +
> +					bias-disable;
> +					drive-strength = <16>;
> +				};
> +				sdc2_clk_off: clk-off-pins {
> +					pins = "sdc2_clk";
> +
> +					bias-disable;
> +					drive-strength = <2>;
> +				};
> +			};
> +
> +			pmx-sdc2-cmd-state {
> +				sdc2_cmd_on: cmd-on-pins {
> +					pins = "sdc2_cmd";
> +
> +					bias-pull-up;
> +					drive-strength = <10>;
> +				};
> +				sdc2_cmd_off: cmd-off-pins {
> +					pins = "sdc2_cmd";
> +
> +					bias-pull-up;
> +					drive-strength = <2>;
> +				};
> +			};
> +
> +			pmx-sdc2-data-state {
> +				sdc2_data_on: data-on-pins {
> +					pins = "sdc2_data";
> +
> +					bias-pull-up;
> +					drive-strength = <10>;
> +				};
> +				sdc2_data_off: data-off-pins {
> +					pins = "sdc2_data";
> +
> +					bias-pull-up;
> +					drive-strength = <2>;
> +				};
> +			};
> +
> +			pmx-sdc2-cd-pin-state {
> +				sdc2_cd_on: cd-on-pins {
> +					pins = "gpio38";
> +					function = "gpio";
> +
> +					drive-strength = <2>;
> +					bias-pull-up;
> +				};
> +				sdc2_cd_off: cd-off-pins {
> +					pins = "gpio38";
> +					function = "gpio";
> +
> +					drive-strength = <2>;
> +					bias-disable;
> +				};
> +			};
> +
> +			spi1_default: spi1-default-state {
> +				spi-pins {
> +					pins = "gpio0", "gpio1", "gpio3";
> +					function = "blsp_spi1";
> +
> +					drive-strength = <12>;
> +					bias-disable;
> +				};
> +				cs-pins {
> +					pins = "gpio2";
> +					function = "gpio";
> +
> +					drive-strength = <16>;
> +					bias-disable;
> +					output-high;
> +				};
> +			};
> +
> +			spi1_sleep: spi1-sleep-state {
> +				pins = "gpio0", "gpio1", "gpio2", "gpio3";
> +				function = "gpio";
> +
> +				drive-strength = <2>;
> +				bias-pull-down;
> +			};
> +
> +			spi2_default: spi2-default-state {
> +				spi-pins {
> +					pins = "gpio4", "gpio5", "gpio7";
> +					function = "blsp_spi2";
> +
> +					drive-strength = <12>;
> +					bias-disable;
> +				};
> +				cs-pins {
> +					pins = "gpio6";
> +					function = "gpio";
> +
> +					drive-strength = <16>;
> +					bias-disable;
> +					output-high;
> +				};
> +			};
> +
> +			spi2_sleep: spi2-sleep-state {
> +				pins = "gpio4", "gpio5", "gpio6", "gpio7";
> +				function = "gpio";
> +
> +				drive-strength = <2>;
> +				bias-pull-down;
> +			};
> +
> +			spi3_default: spi3-default-state {
> +				spi-pins {
> +					pins = "gpio8", "gpio9", "gpio11";
> +					function = "blsp_spi3";
> +
> +					drive-strength = <12>;
> +					bias-disable;
> +				};
> +				cs-pins {
> +					pins = "gpio10";
> +					function = "gpio";
> +
> +					drive-strength = <16>;
> +					bias-disable;
> +					output-high;
> +				};
> +			};
> +
> +			spi3_sleep: spi3-sleep-state {
> +				pins = "gpio8", "gpio9", "gpio10", "gpio11";
> +				function = "gpio";
> +
> +				drive-strength = <2>;
> +				bias-pull-down;
> +			};
> +
> +			spi4_default: spi4-default-state {
> +				spi-pins {
> +					pins = "gpio12", "gpio13", "gpio15";
> +					function = "blsp_spi4";
> +
> +					drive-strength = <12>;
> +					bias-disable;
> +				};
> +				cs-pins {
> +					pins = "gpio14";
> +					function = "gpio";
> +
> +					drive-strength = <16>;
> +					bias-disable;
> +					output-high;
> +				};
> +			};
> +
> +			spi4_sleep: spi4-sleep-state {
> +				pins = "gpio12", "gpio13", "gpio14", "gpio15";
> +				function = "gpio";
> +
> +				drive-strength = <2>;
> +				bias-pull-down;
> +			};
> +
> +			spi5_default: spi5-default-state {
> +				spi-pins {
> +					pins = "gpio16", "gpio17", "gpio19";
> +					function = "blsp_spi5";
> +
> +					drive-strength = <12>;
> +					bias-disable;
> +				};
> +				cs-pins {
> +					pins = "gpio18";
> +					function = "gpio";
> +
> +					drive-strength = <16>;
> +					bias-disable;
> +					output-high;
> +				};
> +			};
> +
> +			spi5_sleep: spi5-sleep-state {
> +				pins = "gpio16", "gpio17", "gpio18", "gpio19";
> +				function = "gpio";
> +
> +				drive-strength = <2>;
> +				bias-pull-down;
> +			};
> +
> +			spi6_default: spi6-default-state {
> +				spi-pins {
> +					pins = "gpio20", "gpio21", "gpio23";
> +					function = "blsp_spi6";
> +
> +					drive-strength = <12>;
> +					bias-disable;
> +				};
> +				cs-pins {
> +					pins = "gpio22";
> +					function = "gpio";
> +
> +					drive-strength = <16>;
> +					bias-disable;
> +					output-high;
> +				};
> +			};
> +
> +			spi6_sleep: spi6-sleep-state {
> +				pins = "gpio20", "gpio21", "gpio22", "gpio23";
> +				function = "gpio";
> +
> +				drive-strength = <2>;
> +				bias-pull-down;
> +			};
> +
> +			wcnss_pin_a: wcnss-active-state {
> +				pins = "gpio40", "gpio41", "gpio42", "gpio43", "gpio44";
> +				function = "wcss_wlan";
> +
> +				drive-strength = <6>;
> +				bias-pull-up;
> +			};
> +		};
> +
> +		gcc: clock-controller@1800000 {
> +			compatible = "qcom,gcc-msm8939";
> +			reg = <0x01800000 0x80000>;
> +			clocks = <&xo_board>,
> +				 <&sleep_clk>,
> +				 <&dsi_phy0 1>,
> +				 <&dsi_phy0 0>,
> +				 <0>,
> +				 <0>,
> +				 <0>;
> +			clock-names = "xo",
> +				      "sleep_clk",
> +				      "dsi0pll",
> +				      "dsi0pllbyte",
> +				      "ext_mclk",
> +				      "ext_pri_i2s",
> +				      "ext_sec_i2s";
> +			#clock-cells = <1>;
> +			#reset-cells = <1>;
> +			#power-domain-cells = <1>;
> +		};
> +
> +		tcsr_mutex: hwlock@1905000 {
> +			compatible = "qcom,tcsr-mutex";
> +			reg = <0x01905000 0x20000>;
> +			#hwlock-cells = <1>;
> +		};
> +
> +		tcsr: syscon@1937000 {
> +			compatible = "qcom,tcsr-msm8916", "syscon";

You should rather use your own compatible (msm8939).

I finished here. Please build dtbs with W=1.

Best regards,
Krzysztof

