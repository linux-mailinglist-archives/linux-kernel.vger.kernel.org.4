Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8AD76C9AE8
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 07:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231950AbjC0Fi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 01:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbjC0Fiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 01:38:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 826184C01;
        Sun, 26 Mar 2023 22:38:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0EFC1B80DAC;
        Mon, 27 Mar 2023 05:38:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4655C433D2;
        Mon, 27 Mar 2023 05:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679895530;
        bh=Yhb2RGYjg/g3c0wqYGwzgujjwyviDdmR0hflJF8Bga0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dMphlRGkOjzy2goSoW7ymBZEjRZ9qSvWG/AtZOyRTElak+e5fDVowtpqT1UU2BrbH
         tGx8H4u1tlmeGexvd9QvaD8N7Ji8DfyuvfETvQ1CpcjPnNEBcdYME0P5vJbkGN9A+c
         f0mhFxiFaw+KVjzYcv7ZOL1juwleZnFfDz/rfoHLFgJZj6Yy6eFK57lMNe/ibz3PoG
         iTILb2Gftve7LOUj7kG7M8OJwlL7RN7ZVodWp3MgeuK+Mlf0CKCOc3bX/9KUozKuk7
         bbsFC8+k5W/fMZ6/pETxEosuREL4Q6Kwp7oK8/lqbUnGnXhx4aPn8uGucPag8/Qu72
         an22BHIWfb34Q==
Date:   Mon, 27 Mar 2023 11:08:45 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 10/12] arm64: dts: qcom: Introduce the SC8180x platform
Message-ID: <ZCEr5WnbvA2jkHLn@matsya>
References: <20230325122444.249507-1-vkoul@kernel.org>
 <20230325122444.249507-11-vkoul@kernel.org>
 <bfc64e55-3c06-e36b-70cc-33a0303681be@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bfc64e55-3c06-e36b-70cc-33a0303681be@linaro.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-03-23, 13:34, Konrad Dybcio wrote:
> 
> 
> On 25.03.2023 13:24, Vinod Koul wrote:
> > From: Bjorn Andersson <bjorn.andersson@linaro.org>
> > 
> > Introduce a base dtsi for the Qualcomm SC8180x platform, with CPUs,
> > global clock controller, SMMU, rpmh clocks, rpmh power-domains, CPUfreq,
> > QUP blocks, UFS, USB, ADSP, CDSP and MPSS and WiFi.
> > 
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > Signed-off-by: Vinod Koul <vkoul@kernel.org>
> > ---
> >  arch/arm64/boot/dts/qcom/sc8180x.dtsi | 3950 +++++++++++++++++++++++++
> >  1 file changed, 3950 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/qcom/sc8180x.dtsi
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/sc8180x.dtsi b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
> > new file mode 100644
> > index 000000000000..4d4ee6bc91e5
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
> > @@ -0,0 +1,3950 @@
> > +// SPDX-License-Identifier: BSD-3-Clause
> > +/*
> > + * Copyright (c) 2017-2019, The Linux Foundation. All rights reserved.
> > + * Copyright (c) 2020-2023, Linaro Limited
> > + */
> > +
> > +#include <dt-bindings/clock/qcom,dispcc-sm8250.h>
> > +#include <dt-bindings/clock/qcom,gcc-sc8180x.h>
> > +#include <dt-bindings/clock/qcom,gpucc-sm8150.h>
> > +#include <dt-bindings/clock/qcom,rpmh.h>
> > +#include <dt-bindings/interconnect/qcom,osm-l3.h>
> > +#include <dt-bindings/interconnect/qcom,sc8180x.h>
> > +#include <dt-bindings/interrupt-controller/arm-gic.h>
> > +#include <dt-bindings/power/qcom-rpmpd.h>
> > +#include <dt-bindings/soc/qcom,rpmh-rsc.h>
> > +#include <dt-bindings/thermal/thermal.h>
> > +
> > +/ {
> > +	interrupt-parent = <&intc>;
> > +
> > +	#address-cells = <2>;
> > +	#size-cells = <2>;
> > +
> > +	clocks {
> > +		xo_board_clk: xo-board {
> > +			compatible = "fixed-clock";
> > +			#clock-cells = <0>;
> > +			clock-frequency = <38400000>;
> > +		};
> > +
> > +		sleep_clk: sleep-clk {
> > +			compatible = "fixed-clock";
> > +			#clock-cells = <0>;
> > +			clock-frequency = <32764>;
> > +			clock-output-names = "sleep_clk";
> > +		};
> > +	};
> > +
> > +	cpus {
> > +		#address-cells = <2>;
> > +		#size-cells = <0>;
> > +
> > +		CPU0: cpu@0 {
> > +			device_type = "cpu";
> > +			compatible = "qcom,kryo485";
> > +			reg = <0x0 0x0>;
> Please add clocks = <&cpufreq_hw n>;
>  
> > +			enable-method = "psci";
> > +			capacity-dmips-mhz = <602>;
> > +			next-level-cache = <&L2_0>;
> > +			qcom,freq-domain = <&cpufreq_hw 0>;

You mean this or something else?

> > +			operating-points-v2 = <&cpu0_opp_table>;
> > +			interconnects = <&gem_noc MASTER_AMPSS_M0 3 &mc_virt SLAVE_EBI_CH0 3>,
> > +					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
> > +			power-domains = <&CPU_PD0>;
> > +			power-domain-names = "psci";
> > +			#cooling-cells = <2>;
> Add a newline before subnodes, please.

Sure

> 
> > +			L2_0: l2-cache {
> > +				compatible = "cache";
> > +				next-level-cache = <&L3_0>;
> > +				L3_0: l3-cache {
> > +				      compatible = "cache";
> > +				};
> > +			};
> > +		};
> > +
> [...]
> 
> > +
> > +	cpu0_opp_table: opp-table-cpu0 {
> > +		compatible = "operating-points-v2";
> > +		opp-shared;
> > +
> > +		opp-300000000 {
> > +			opp-hz = /bits/ 64 <300000000>;
> > +			opp-peak-kBps = <800000 9600000>;
> Maybe adding bwmon from the get-go would be better than statically
> scaling DDR freq?

Maybe :-) but we would like to land the dts now rather than wait more :)

> 
> [...]
> 
> > +	camnoc_virt: interconnect-0{
> Missing space before {

Will fix

> > +		compatible = "qcom,sc8180x-camnoc-virt";
> > +		#interconnect-cells = <2>;
> > +		qcom,bcm-voters = <&apps_bcm_voter>;
> > +	};
> > +
> > +	mc_virt: interconnect-mc-virt {
> Please be consistent with your naming.

Are you referring to adding -0 for this?

> 
> > +		compatible = "qcom,sc8180x-mc-virt";
> > +		#interconnect-cells = <2>;
> > +		qcom,bcm-voters = <&apps_bcm_voter>;
> > +	};
> > +
> > +	qup_virt: interconnect-qup-virt {
> > +		compatible = "qcom,sc8180x-qup-virt";
> > +		#interconnect-cells = <2>;
> > +		qcom,bcm-voters = <&apps_bcm_voter>;
> > +	};
> > +
> [...]
> 
> > +	reserved-memory {
> > +		#address-cells = <2>;
> > +		#size-cells = <2>;
> > +		ranges;
> > +
> > +		hyp_mem: hyp-region@85700000 {
> the -region seems a bit unnecessary in all of these nodes

This is reserved for hyp, I think we should add it here so that we dont
touch this piece..?

> 
> > +			reg = <0x0 0x85700000 0x0 0x600000>;
> > +			no-map;
> > +		};
> > +
> [...]
> 
> > +
> > +	soc: soc@0 {
> > +		#address-cells = <2>;
> > +		#size-cells = <2>;
> > +		ranges = <0 0 0 0 0x10 0>;
> > +		dma-ranges = <0 0 0 0 0x10 0>;
> > +		compatible = "simple-bus";
> compat
> addr-cells
> size-cella
> ranges
> dma-ranges
> 
> please

Sure

> 
> > +
> > +		gcc: clock-controller@100000 {
> > +			compatible = "qcom,gcc-sc8180x";
> > +			reg = <0x0 0x00100000 0x0 0x1f0000>;
> > +			#clock-cells = <1>;
> > +			#reset-cells = <1>;
> > +			#power-domain-cells = <1>;
> > +			clock-names = "bi_tcxo",
> > +				      "bi_tcxo_ao",
> > +				      "sleep_clk";
> > +			clocks = <&rpmhcc RPMH_CXO_CLK>,
> > +				 <&rpmhcc RPMH_CXO_CLK_A>,
> > +				 <&sleep_clk>;
> property before property-names

ok

> 
> 
> > +		};
> > +
> > +		qupv3_id_0: geniqup@8c0000 {
> > +			compatible = "qcom,geni-se-qup";
> > +			reg = <0 0x008c0000 0 0x6000>;
> > +			clock-names = "m-ahb", "s-ahb";
> > +			clocks = <&gcc GCC_QUPV3_WRAP_0_M_AHB_CLK>,
> > +				 <&gcc GCC_QUPV3_WRAP_0_S_AHB_CLK>;
> > +			#address-cells = <2>;
> > +			#size-cells = <2>;
> > +			ranges;
> > +			iommus = <&apps_smmu 0x4c3 0>;
> > +			status = "disabled";
> > +
> > +			i2c0: i2c@880000 {
> > +				compatible = "qcom,geni-i2c";
> > +				reg = <0 0x00880000 0 0x4000>;
> > +				clock-names = "se";
> > +				clocks = <&gcc GCC_QUPV3_WRAP0_S0_CLK>;
> property before property-names
> 
> Please split QUPs into a separate patch, this one is way
> too big.

Will do

> 
> [...]
> 
> > +		config_noc: interconnect@1500000 {
> Interconnect could also realistically go to a separate patch.

Yeah already list is complaining, let me see how to split it up...

> 
> > +			compatible = "qcom,sc8180x-config-noc";
> > +			reg = <0 0x01500000 0 0x7400>;
> > +			#interconnect-cells = <2>;
> > +			qcom,bcm-voters = <&apps_bcm_voter>;
> > +		};
> > +
> > +		system_noc: interconnect@1620000 {
> > +			compatible = "qcom,sc8180x-system-noc";
> > +			reg = <0 0x01620000 0 0x19400>;
> > +			#interconnect-cells = <2>;
> > +			qcom,bcm-voters = <&apps_bcm_voter>;
> > +		};
> > +
> > +		aggre1_noc: interconnect@16e0000 {
> > +			compatible = "qcom,sc8180x-aggre1-noc";
> > +			reg = <0 0x016e0000 0 0xd080>;
> > +			#interconnect-cells = <2>;
> > +			qcom,bcm-voters = <&apps_bcm_voter>;
> > +		};
> > +
> > +		aggre2_noc: interconnect@1700000 {
> > +			compatible = "qcom,sc8180x-aggre2-noc";
> > +			reg = <0 0x01700000 0 0x20000>;
> > +			#interconnect-cells = <2>;
> > +			qcom,bcm-voters = <&apps_bcm_voter>;
> > +		};
> > +
> > +		compute_noc: interconnect@1720000 {
> > +			compatible = "qcom,sc8180x-compute-noc";
> > +			reg = <0 0x01720000 0 0x7000>;
> > +			#interconnect-cells = <2>;
> > +			qcom,bcm-voters = <&apps_bcm_voter>;
> > +		};
> > +
> > +		mmss_noc: interconnect@1740000 {
> > +			compatible = "qcom,sc8180x-mmss-noc";
> > +			reg = <0 0x01740000 0 0x1c100>;
> > +			#interconnect-cells = <2>;
> > +			qcom,bcm-voters = <&apps_bcm_voter>;
> > +		};
> > +
> [...]
> 
> > +		pcie0: pci@1c00000 {
> And PCIe
> 
> > +			compatible = "qcom,pcie-sc8180x";
> > +			reg = <0 0x01c00000 0 0x3000>,
> > +			      <0 0x60000000 0 0xf1d>,
> > +			      <0 0x60000f20 0 0xa8>,
> > +			      <0 0x60001000 0 0x1000>,
> > +			      <0 0x60100000 0 0x100000>;
> > +			reg-names = "parf", "dbi", "elbi", "atu", "config";
> One per line, please

ok

> 
> 
> [...]
> 
> > +
> > +		ufs_mem_hc: ufshc@1d84000 {
> > +			compatible = "qcom,sc8180x-ufshc", "qcom,ufshc",
> > +				     "jedec,ufs-2.0";
> > +			reg = <0 0x01d84000 0 0x2500>;
> > +			interrupts = <GIC_SPI 265 IRQ_TYPE_LEVEL_HIGH>;
> > +			phys = <&ufs_mem_phy_lanes>;
> > +			phy-names = "ufsphy";
> > +			lanes-per-direction = <2>;
> > +			#reset-cells = <1>;
> > +			resets = <&gcc GCC_UFS_PHY_BCR>;
> > +			reset-names = "rst";
> > +
> > +			iommus = <&apps_smmu 0x300 0>;
> > +
> > +			clock-names =
> No need for this weird newline split.
> 
> Also, property before property-names.
> 
> [...]
> 
> 
> > +
> > +		gpu: gpu@2c00000 {
> GPUSS and MDSS related nodes should also go to their separate,
> respective patches.

ok

> 
> [...]
> > +
> > +		remoteproc_mpss: remoteproc@4080000 {
> And remote procs as well
> 
> > +			compatible = "qcom,sc8180x-mpss-pas";
> > +			reg = <0x0 0x04080000 0x0 0x4040>;
> > +
> [...]
> 
> > +	thermal-zones {
> And thermal-zones as well.
> 
> 
> I'll go more in-depth after you split it up, this is pretty hard
> to review as-is.
> 
> Konrad
> > +		cpu0-thermal {
> > +			polling-delay-passive = <250>;
> > +			polling-delay = <1000>;
> > +
> > +			thermal-sensors = <&tsens0 1>;
> > +
> > +			trips {
> > +				cpu-crit {
> > +					temperature = <110000>;
> > +					hysteresis = <1000>;
> > +					type = "critical";
> > +				};
> > +			};
> > +		};
> > +
> > +		cpu1-thermal {
> > +			polling-delay-passive = <250>;
> > +			polling-delay = <1000>;
> > +
> > +			thermal-sensors = <&tsens0 2>;
> > +
> > +			trips {
> > +				cpu-crit {
> > +					temperature = <110000>;
> > +					hysteresis = <1000>;
> > +					type = "critical";
> > +				};
> > +			};
> > +		};
> > +
> > +		cpu2-thermal {
> > +			polling-delay-passive = <250>;
> > +			polling-delay = <1000>;
> > +
> > +			thermal-sensors = <&tsens0 3>;
> > +
> > +			trips {
> > +				cpu-crit {
> > +					temperature = <110000>;
> > +					hysteresis = <1000>;
> > +					type = "critical";
> > +				};
> > +			};
> > +		};
> > +
> > +		cpu3-thermal {
> > +			polling-delay-passive = <250>;
> > +			polling-delay = <1000>;
> > +
> > +			thermal-sensors = <&tsens0 4>;
> > +
> > +			trips {
> > +				cpu-crit {
> > +					temperature = <110000>;
> > +					hysteresis = <1000>;
> > +					type = "critical";
> > +				};
> > +			};
> > +		};
> > +
> > +		cpu4-top-thermal {
> > +			polling-delay-passive = <250>;
> > +			polling-delay = <1000>;
> > +
> > +			thermal-sensors = <&tsens0 7>;
> > +
> > +			trips {
> > +				cpu-crit {
> > +					temperature = <110000>;
> > +					hysteresis = <1000>;
> > +					type = "critical";
> > +				};
> > +			};
> > +		};
> > +
> > +		cpu5-top-thermal {
> > +			polling-delay-passive = <250>;
> > +			polling-delay = <1000>;
> > +
> > +			thermal-sensors = <&tsens0 8>;
> > +
> > +			trips {
> > +				cpu-crit {
> > +					temperature = <110000>;
> > +					hysteresis = <1000>;
> > +					type = "critical";
> > +				};
> > +			};
> > +		};
> > +
> > +		cpu6-top-thermal {
> > +			polling-delay-passive = <250>;
> > +			polling-delay = <1000>;
> > +
> > +			thermal-sensors = <&tsens0 9>;
> > +
> > +			trips {
> > +				cpu-crit {
> > +					temperature = <110000>;
> > +					hysteresis = <1000>;
> > +					type = "critical";
> > +				};
> > +			};
> > +		};
> > +
> > +		cpu7-top-thermal {
> > +			polling-delay-passive = <250>;
> > +			polling-delay = <1000>;
> > +
> > +			thermal-sensors = <&tsens0 10>;
> > +
> > +			trips {
> > +				cpu-crit {
> > +					temperature = <110000>;
> > +					hysteresis = <1000>;
> > +					type = "critical";
> > +				};
> > +			};
> > +		};
> > +
> > +		cpu4-bottom-thermal {
> > +			polling-delay-passive = <250>;
> > +			polling-delay = <1000>;
> > +
> > +			thermal-sensors = <&tsens0 11>;
> > +
> > +			trips {
> > +				cpu-crit {
> > +					temperature = <110000>;
> > +					hysteresis = <1000>;
> > +					type = "critical";
> > +				};
> > +			};
> > +		};
> > +
> > +		cpu5-bottom-thermal {
> > +			polling-delay-passive = <250>;
> > +			polling-delay = <1000>;
> > +
> > +			thermal-sensors = <&tsens0 12>;
> > +
> > +			trips {
> > +				cpu-crit {
> > +					temperature = <110000>;
> > +					hysteresis = <1000>;
> > +					type = "critical";
> > +				};
> > +			};
> > +		};
> > +
> > +		cpu6-bottom-thermal {
> > +			polling-delay-passive = <250>;
> > +			polling-delay = <1000>;
> > +
> > +			thermal-sensors = <&tsens0 13>;
> > +
> > +			trips {
> > +				cpu-crit {
> > +					temperature = <110000>;
> > +					hysteresis = <1000>;
> > +					type = "critical";
> > +				};
> > +			};
> > +		};
> > +
> > +		cpu7-bottom-thermal {
> > +			polling-delay-passive = <250>;
> > +			polling-delay = <1000>;
> > +
> > +			thermal-sensors = <&tsens0 14>;
> > +
> > +			trips {
> > +				cpu-crit {
> > +					temperature = <110000>;
> > +					hysteresis = <1000>;
> > +					type = "critical";
> > +				};
> > +			};
> > +		};
> > +
> > +		aoss0-thermal {
> > +			polling-delay-passive = <250>;
> > +			polling-delay = <1000>;
> > +
> > +			thermal-sensors = <&tsens0 0>;
> > +
> > +			trips {
> > +				trip-point0 {
> > +					temperature = <90000>;
> > +					hysteresis = <2000>;
> > +					type = "hot";
> > +				};
> > +			};
> > +		};
> > +
> > +		cluster0-thermal {
> > +			polling-delay-passive = <250>;
> > +			polling-delay = <1000>;
> > +
> > +			thermal-sensors = <&tsens0 5>;
> > +
> > +			trips {
> > +				cluster-crit {
> > +					temperature = <110000>;
> > +					hysteresis = <2000>;
> > +					type = "critical";
> > +				};
> > +			};
> > +		};
> > +
> > +		cluster1-thermal {
> > +			polling-delay-passive = <250>;
> > +			polling-delay = <1000>;
> > +
> > +			thermal-sensors = <&tsens0 6>;
> > +
> > +			trips {
> > +				cluster-crit {
> > +					temperature = <110000>;
> > +					hysteresis = <2000>;
> > +					type = "critical";
> > +				};
> > +			};
> > +		};
> > +
> > +		gpu-thermal-top {
> > +			polling-delay-passive = <250>;
> > +			polling-delay = <1000>;
> > +
> > +			thermal-sensors = <&tsens0 15>;
> > +
> > +			trips {
> > +				trip-point0 {
> > +					temperature = <90000>;
> > +					hysteresis = <2000>;
> > +					type = "hot";
> > +				};
> > +			};
> > +		};
> > +
> > +		aoss1-thermal {
> > +			polling-delay-passive = <250>;
> > +			polling-delay = <1000>;
> > +
> > +			thermal-sensors = <&tsens1 0>;
> > +
> > +			trips {
> > +				trip-point0 {
> > +					temperature = <90000>;
> > +					hysteresis = <2000>;
> > +					type = "hot";
> > +				};
> > +			};
> > +		};
> > +
> > +		wlan-thermal {
> > +			polling-delay-passive = <250>;
> > +			polling-delay = <1000>;
> > +
> > +			thermal-sensors = <&tsens1 1>;
> > +
> > +			trips {
> > +				trip-point0 {
> > +					temperature = <90000>;
> > +					hysteresis = <2000>;
> > +					type = "hot";
> > +				};
> > +			};
> > +		};
> > +
> > +		video-thermal {
> > +			polling-delay-passive = <250>;
> > +			polling-delay = <1000>;
> > +
> > +			thermal-sensors = <&tsens1 2>;
> > +
> > +			trips {
> > +				trip-point0 {
> > +					temperature = <90000>;
> > +					hysteresis = <2000>;
> > +					type = "hot";
> > +				};
> > +			};
> > +		};
> > +
> > +		mem-thermal {
> > +			polling-delay-passive = <250>;
> > +			polling-delay = <1000>;
> > +
> > +			thermal-sensors = <&tsens1 3>;
> > +
> > +			trips {
> > +				trip-point0 {
> > +					temperature = <90000>;
> > +					hysteresis = <2000>;
> > +					type = "hot";
> > +				};
> > +			};
> > +		};
> > +
> > +		q6-hvx-thermal {
> > +			polling-delay-passive = <250>;
> > +			polling-delay = <1000>;
> > +
> > +			thermal-sensors = <&tsens1 4>;
> > +
> > +			trips {
> > +				trip-point0 {
> > +					temperature = <90000>;
> > +					hysteresis = <2000>;
> > +					type = "hot";
> > +				};
> > +			};
> > +		};
> > +
> > +		camera-thermal {
> > +			polling-delay-passive = <250>;
> > +			polling-delay = <1000>;
> > +
> > +			thermal-sensors = <&tsens1 5>;
> > +
> > +			trips {
> > +				trip-point0 {
> > +					temperature = <90000>;
> > +					hysteresis = <2000>;
> > +					type = "hot";
> > +				};
> > +			};
> > +		};
> > +
> > +		compute-thermal {
> > +			polling-delay-passive = <250>;
> > +			polling-delay = <1000>;
> > +
> > +			thermal-sensors = <&tsens1 6>;
> > +
> > +			trips {
> > +				trip-point0 {
> > +					temperature = <90000>;
> > +					hysteresis = <2000>;
> > +					type = "hot";
> > +				};
> > +			};
> > +		};
> > +
> > +		mdm-dsp-thermal {
> > +			polling-delay-passive = <250>;
> > +			polling-delay = <1000>;
> > +
> > +			thermal-sensors = <&tsens1 7>;
> > +
> > +			trips {
> > +				trip-point0 {
> > +					temperature = <90000>;
> > +					hysteresis = <2000>;
> > +					type = "hot";
> > +				};
> > +			};
> > +		};
> > +
> > +		npu-thermal {
> > +			polling-delay-passive = <250>;
> > +			polling-delay = <1000>;
> > +
> > +			thermal-sensors = <&tsens1 8>;
> > +
> > +			trips {
> > +				trip-point0 {
> > +					temperature = <90000>;
> > +					hysteresis = <2000>;
> > +					type = "hot";
> > +				};
> > +			};
> > +		};
> > +
> > +		gpu-thermal-bottom {
> > +			polling-delay-passive = <250>;
> > +			polling-delay = <1000>;
> > +
> > +			thermal-sensors = <&tsens1 11>;
> > +
> > +			trips {
> > +				trip-point0 {
> > +					temperature = <90000>;
> > +					hysteresis = <2000>;
> > +					type = "hot";
> > +				};
> > +			};
> > +		};
> > +	};
> > +
> > +	timer {
> > +		compatible = "arm,armv8-timer";
> > +		interrupts = <GIC_PPI 1 IRQ_TYPE_LEVEL_LOW>,
> > +			     <GIC_PPI 2 IRQ_TYPE_LEVEL_LOW>,
> > +			     <GIC_PPI 3 IRQ_TYPE_LEVEL_LOW>,
> > +			     <GIC_PPI 0 IRQ_TYPE_LEVEL_LOW>;
> > +	};
> > +};

-- 
~Vinod
