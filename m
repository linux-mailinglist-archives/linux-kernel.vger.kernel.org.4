Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96A3562089F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 05:59:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233477AbiKHE7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 23:59:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233382AbiKHE6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 23:58:54 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8569E40448;
        Mon,  7 Nov 2022 20:55:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 23556B818F8;
        Tue,  8 Nov 2022 04:55:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE3F2C433D6;
        Tue,  8 Nov 2022 04:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667883312;
        bh=xkR30a+entgy1vXyIX0srbFHhSZZjvV2+o31MTjdbMM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QNAC1UX1ZD1iQhthMdjWT5RYSzCnzWVQ4pyMyHLWaLhx4mesgWRR600qBYaX7BAvY
         +v8KKzPPSsej6S8h9Wwnwx5l6gGlFUIg/YgJlpxZ1lSsvQLIneoOHsV3p6XmrGMo9H
         kUYOSYvpnK1pYnZHTZw0sWRopWb5qUCQrNL++1Qe34gTpmd8t4alBis8QzyWZOhMS/
         fR7I2U2bmNjvhRyLmikUi5tk2MfqEIlZAdcN97h8Ilb6gW/2rMe/U7OtkrrMaX9zVk
         dMf25nqpJifkAyUFi2TxHvZPl+DK+YxYK+tdGRJCBMq0tnJG2my7lkOI9wG9zsK5AQ
         yoSASNzJJcC2w==
Date:   Mon, 7 Nov 2022 22:55:08 -0600
From:   Bjorn Andersson <andersson@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     agross@kernel.org, konrad.dybcio@somainline.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, ulf.hansson@linaro.org,
        srinivas.kandagatla@linaro.org, jic23@kernel.org, lars@metafoo.de,
        keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com,
        bhupesh.sharma@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-hardening@vger.kernel.org, marijn.suijten@somainline.org,
        kernel@collabora.com, luca@z3ntu.xyz, a39.skl@gmail.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Subject: Re: [PATCH 8/9] arm64: dts: qcom: Add DTS for MSM8976 and MSM8956
 SoCs
Message-ID: <20221108045508.hnnwt22m6ceg5u4y@builder.lan>
References: <20221104172122.252761-1-angelogioacchino.delregno@collabora.com>
 <20221104172122.252761-9-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221104172122.252761-9-angelogioacchino.delregno@collabora.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 04, 2022 at 06:21:21PM +0100, AngeloGioacchino Del Regno wrote:
> From: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> 
> This commit adds device trees for MSM8956 and MSM8976 SoCs.
> They are *almost* identical, with minor differences, such as
> MSM8956 having two A72 cores less.
> 
> However, there is a bug in Sony Loire bootloader that requires presence
> of all 8 cores in the cpu{} node, so these will not be deleted.
> 
> Co-developed-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> Co-developed-by: Marijn Suijten <marijn.suijten@somainline.org>
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  arch/arm64/boot/dts/qcom/msm8956.dtsi |   18 +
>  arch/arm64/boot/dts/qcom/msm8976.dtsi | 1208 +++++++++++++++++++++++++
>  2 files changed, 1226 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/msm8956.dtsi
>  create mode 100644 arch/arm64/boot/dts/qcom/msm8976.dtsi
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8956.dtsi b/arch/arm64/boot/dts/qcom/msm8956.dtsi
> new file mode 100644
> index 000000000000..eb2c1345172c
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/msm8956.dtsi
> @@ -0,0 +1,18 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2016-2022, AngeloGioacchino Del Regno
> + *                          <angelogioacchino.delregno@somainline.org>
> + * Copyright (c) 2022, Konrad Dybcio <konrad.dybcio@somainline.org>
> + * Copyright (c) 2022, Marijn Suijten <marijn.suijten@somainline.org>
> + */
> +
> +#include "msm8976.dtsi"
> +
> +&pmu {
> +	interrupts = <GIC_PPI 7 (GIC_CPU_MASK_SIMPLE(6) | IRQ_TYPE_LEVEL_HIGH)>;
> +};
> +
> +/*
> + * You might be wondering.. why is it so empty out there?
> + * Well, the SoCs are almost identical.
> + */
> diff --git a/arch/arm64/boot/dts/qcom/msm8976.dtsi b/arch/arm64/boot/dts/qcom/msm8976.dtsi
> new file mode 100644
> index 000000000000..e084a3a78f18
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/msm8976.dtsi
> @@ -0,0 +1,1208 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2016-2022, AngeloGioacchino Del Regno
> + *                          <angelogioacchino.delregno@somainline.org>
> + * Copyright (c) 2022, Konrad Dybcio <konrad.dybcio@somainline.org>
> + * Copyright (c) 2022, Marijn Suijten <marijn.suijten@somainline.org>
> + */
> +
> +#include <dt-bindings/clock/qcom,gcc-msm8976.h>
> +#include <dt-bindings/clock/qcom,rpmcc.h>
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/power/qcom-rpmpd.h>
> +
> +/ {
> +	interrupt-parent = <&intc>;
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +
> +	chosen { };
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		CPU0: cpu@0 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53";
> +			reg = <0x0>;
> +			enable-method = "psci";
> +			cpu-idle-states = <&little_cpu_sleep_0>;
> +			capacity-dmips-mhz = <573>;
> +			next-level-cache = <&l2_0>;
> +			#cooling-cells = <2>;
> +		};
> +
> +		CPU1: cpu@1 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53";
> +			reg = <0x1>;
> +			enable-method = "psci";
> +			cpu-idle-states = <&little_cpu_sleep_0>;
> +			capacity-dmips-mhz = <573>;
> +			next-level-cache = <&l2_0>;
> +			#cooling-cells = <2>;
> +		};
> +
> +		CPU2: cpu@2 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53";
> +			reg = <0x2>;
> +			enable-method = "psci";
> +			cpu-idle-states = <&little_cpu_sleep_0>;
> +			capacity-dmips-mhz = <573>;
> +			next-level-cache = <&l2_0>;
> +			#cooling-cells = <2>;
> +		};
> +
> +		CPU3: cpu@3 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53";
> +			reg = <0x3>;
> +			enable-method = "psci";
> +			cpu-idle-states = <&little_cpu_sleep_0>;
> +			capacity-dmips-mhz = <573>;
> +			next-level-cache = <&l2_0>;
> +			#cooling-cells = <2>;
> +		};
> +
> +		CPU4: cpu@100 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a72";
> +			reg = <0x100>;
> +			enable-method = "psci";
> +			cpu-idle-states = <&big_cpu_sleep_0 &big_cpu_sleep_1>;
> +			capacity-dmips-mhz = <1024>;
> +			next-level-cache = <&l2_1>;
> +			#cooling-cells = <2>;
> +		};
> +
> +		CPU5: cpu@101 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a72";
> +			reg = <0x101>;
> +			enable-method = "psci";
> +			cpu-idle-states = <&big_cpu_sleep_0 &big_cpu_sleep_1>;
> +			capacity-dmips-mhz = <1024>;
> +			next-level-cache = <&l2_1>;
> +			#cooling-cells = <2>;
> +		};
> +
> +		CPU6: cpu@102 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a72";
> +			reg = <0x102>;
> +			enable-method = "psci";
> +			cpu-idle-states = <&big_cpu_sleep_0 &big_cpu_sleep_1>;
> +			capacity-dmips-mhz = <1024>;
> +			next-level-cache = <&l2_1>;
> +			#cooling-cells = <2>;
> +		};
> +
> +		CPU7: cpu@103 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a72";
> +			reg = <0x103>;
> +			enable-method = "psci";
> +			cpu-idle-states = <&big_cpu_sleep_0 &big_cpu_sleep_1>;
> +			capacity-dmips-mhz = <1024>;
> +			next-level-cache = <&l2_1>;
> +			#cooling-cells = <2>;
> +		};
> +
> +		cpu-map {
> +			cluster0 {
> +				core0 {
> +					cpu = <&CPU0>;
> +				};
> +
> +				core1 {
> +					cpu = <&CPU1>;
> +				};
> +
> +				core2 {
> +					cpu = <&CPU2>;
> +				};
> +
> +				core3 {
> +					cpu = <&CPU3>;
> +				};
> +			};
> +
> +			cluster1 {

Are you sure that the two clusters should be expressed separately in the
cpu-map?

> +				core0 {
> +					cpu = <&CPU4>;
> +				};
> +
> +				core1 {
> +					cpu = <&CPU5>;
> +				};
> +
> +				core2 {
> +					cpu = <&CPU6>;
> +				};
> +
> +				core3 {
> +					cpu = <&CPU7>;
> +				};
> +			};
> +		};
> +
> +		idle-states {
> +			entry-method = "psci";
> +
> +			little_cpu_sleep_0: cpu-sleep-0-0 {
> +				compatible = "arm,idle-state";
> +				idle-state-name = "little-power-collapse";
> +				arm,psci-suspend-param = <0x40000003>;
> +				entry-latency-us = <181>;
> +				exit-latency-us = <149>;
> +				min-residency-us = <703>;
> +				local-timer-stop;
> +			};
> +
> +			big_cpu_sleep_0: cpu-sleep-1-0 {
> +				compatible = "arm,idle-state";
> +				idle-state-name = "big-retention";
> +				arm,psci-suspend-param = <0x00000002>;
> +				entry-latency-us = <142>;
> +				exit-latency-us = <99>;
> +				min-residency-us = <242>;
> +			};
> +
> +			big_cpu_sleep_1: cpu-sleep-1-1 {
> +				compatible = "arm,idle-state";
> +				idle-state-name = "big-power-collapse";
> +				arm,psci-suspend-param = <0x40000003>;
> +				entry-latency-us = <158>;
> +				exit-latency-us = <144>;
> +				min-residency-us = <863>;
> +				local-timer-stop;
> +			};
> +		};
> +
> +		l2_0: l2-cache0 {
> +			compatible = "cache";
> +			cache-level = <2>;
> +		};
> +
> +		l2_1: l2-cache1 {
> +			compatible = "cache";
> +			cache-level = <2>;
> +		};
> +	};
> +
> +	firmware {
> +		scm: scm {
> +			compatible = "qcom,scm-msm8976", "qcom,scm";
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
> +	memory@80000000 {
> +		device_type = "memory";
> +		/* We expect the bootloader to fill in the size */
> +		reg = <0x0 0x80000000 0x0 0x0>;
> +	};
> +
> +	pmu: pmu {
> +		compatible = "arm,armv8-pmuv3";
> +		interrupts = <GIC_PPI 7 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_HIGH)>;
> +	};
> +
> +	psci {
> +		compatible = "arm,psci-1.0";
> +		method = "smc";
> +	};
> +
> +	reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		cont_splash_mem: memory@83000000 {

memory is "reserved", please use specific node names for these regions.

> +			reg = <0x0 0x83000000 0x0 0x2800000>;
> +		};
[..]
> +		apcs: syscon@b011000 {
> +			compatible = "syscon";

Why not use qcom,msm8976-apcs-kpss-global here?

> +			reg = <0x0b011000 0x1000>;
> +		};
[..]
> +
> +		imem: imem@8600000 {
> +			compatible = "simple-mfd";

sram/qcom,imem.yaml please.

> +			reg = <0x08600000 0x1000>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +
> +			ranges = <0 0x08600000 0x1000>;
> +
> +			pil-reloc@94c {
> +				compatible = "qcom,pil-reloc-info";
> +				reg = <0x94c 0xc8>;
> +			};
> +		};
> +	};
> +

Regards,
Bjorn
