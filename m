Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43A576C9EAA
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 10:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233510AbjC0Iye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 04:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233108AbjC0Ixz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 04:53:55 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 422F776B1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 01:49:22 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id a11so8085736lji.6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 01:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679906960;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rQjqzdBXqAJOzDs4ZiQ0n3N+e+RSLfiUjVnqD6OVw74=;
        b=F0jcUnuYFxPMehpg/pr64POSrk7Ky2sX/+y/1pb8BSoRbpn8jy4JYiZBnbk7OPP5Ih
         xF9bqzI/WFoGs9xyRs1W0g6V6FMnCyTCXTeh/Sl70spdwVci/yv5Ei/QOc4gsDdoJ8X+
         KcSUbkkaSRNKFYkxLE1vQpGqhpZrxTTA7lYyNMsfKx9YRIIiPXvLp4fa7qCnuNOOmzgG
         J222JiuhjaIkIuADJNimuVr6I47ZqYlnZVOw9AMvXuVO7TiZB38jzn4cqS8d6AW4YwlC
         mbMHLX0Q4Kn3btVAbqdVyCccplSLFJS7IlFTCGc8Q5LOMkbexG3rycbUZHZVXiZuwtxo
         cEBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679906960;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rQjqzdBXqAJOzDs4ZiQ0n3N+e+RSLfiUjVnqD6OVw74=;
        b=QpnStyCaeXxlwGR35i6Z+1lmmBt14Mcf3ZNZQIGh2huRhcDoeWNPvrRs+vTnjdSe8D
         E4dnCW/wvAkIdu2p/enf9f6VyE7lKgqmg8U1xXhzBlGcDrMyVt1MU3Gnxh+nY0e7Db8k
         q9MdlFGoYXNgu2nhnz6ZkE6L6sQsA4TAvbcERZ8bnzmYpAHqVEtpXfM+gN0C+r0ZTskb
         q9UONNBgwHYh60PA5UpFVyj4HUHlPe1W9oiuCpdoZ34VYRwsv3EB8A8+zGf6p8asLH6e
         2sN/YORqhPAp6vzXZucxJ1pPHCUuvQfrrJcboXTkYqA47wqWl8A2K5NDPioInPKejG75
         3tHA==
X-Gm-Message-State: AAQBX9eQmVWajEamX4vuOjmHw6kJDbh6hfXSV45IfVXs+EeK62AUiUz0
        o6qzaDaDgkrotCsyMWY8L+vNkQ==
X-Google-Smtp-Source: AKy350a1bF4BHb6k/QmhE8WmE6yO40IxBCS+KfZ7rFgXSvgXR+zZrepetq5VS0BAmbxt+p14FjZMKw==
X-Received: by 2002:a2e:9ec4:0:b0:293:591d:d84f with SMTP id h4-20020a2e9ec4000000b00293591dd84fmr3201198ljk.11.1679906960436;
        Mon, 27 Mar 2023 01:49:20 -0700 (PDT)
Received: from [192.168.1.101] (abxj225.neoplus.adsl.tpnet.pl. [83.9.3.225])
        by smtp.gmail.com with ESMTPSA id g7-20020ac25387000000b004db0d97b053sm4585718lfh.137.2023.03.27.01.49.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Mar 2023 01:49:20 -0700 (PDT)
Message-ID: <5ad54197-3638-fc75-02ee-5c285fe4dabb@linaro.org>
Date:   Mon, 27 Mar 2023 10:49:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 10/12] arm64: dts: qcom: Introduce the SC8180x platform
Content-Language: en-US
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230325122444.249507-1-vkoul@kernel.org>
 <20230325122444.249507-11-vkoul@kernel.org>
 <bfc64e55-3c06-e36b-70cc-33a0303681be@linaro.org> <ZCEr5WnbvA2jkHLn@matsya>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <ZCEr5WnbvA2jkHLn@matsya>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 27.03.2023 07:38, Vinod Koul wrote:
> On 25-03-23, 13:34, Konrad Dybcio wrote:
>>
>>
>> On 25.03.2023 13:24, Vinod Koul wrote:
>>> From: Bjorn Andersson <bjorn.andersson@linaro.org>
>>>
>>> Introduce a base dtsi for the Qualcomm SC8180x platform, with CPUs,
>>> global clock controller, SMMU, rpmh clocks, rpmh power-domains, CPUfreq,
>>> QUP blocks, UFS, USB, ADSP, CDSP and MPSS and WiFi.
>>>
>>> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
>>> Signed-off-by: Vinod Koul <vkoul@kernel.org>
>>> ---
>>>  arch/arm64/boot/dts/qcom/sc8180x.dtsi | 3950 +++++++++++++++++++++++++
>>>  1 file changed, 3950 insertions(+)
>>>  create mode 100644 arch/arm64/boot/dts/qcom/sc8180x.dtsi
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/sc8180x.dtsi b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
>>> new file mode 100644
>>> index 000000000000..4d4ee6bc91e5
>>> --- /dev/null
>>> +++ b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
>>> @@ -0,0 +1,3950 @@
>>> +// SPDX-License-Identifier: BSD-3-Clause
>>> +/*
>>> + * Copyright (c) 2017-2019, The Linux Foundation. All rights reserved.
>>> + * Copyright (c) 2020-2023, Linaro Limited
>>> + */
>>> +
>>> +#include <dt-bindings/clock/qcom,dispcc-sm8250.h>
>>> +#include <dt-bindings/clock/qcom,gcc-sc8180x.h>
>>> +#include <dt-bindings/clock/qcom,gpucc-sm8150.h>
>>> +#include <dt-bindings/clock/qcom,rpmh.h>
>>> +#include <dt-bindings/interconnect/qcom,osm-l3.h>
>>> +#include <dt-bindings/interconnect/qcom,sc8180x.h>
>>> +#include <dt-bindings/interrupt-controller/arm-gic.h>
>>> +#include <dt-bindings/power/qcom-rpmpd.h>
>>> +#include <dt-bindings/soc/qcom,rpmh-rsc.h>
>>> +#include <dt-bindings/thermal/thermal.h>
>>> +
>>> +/ {
>>> +	interrupt-parent = <&intc>;
>>> +
>>> +	#address-cells = <2>;
>>> +	#size-cells = <2>;
>>> +
>>> +	clocks {
>>> +		xo_board_clk: xo-board {
>>> +			compatible = "fixed-clock";
>>> +			#clock-cells = <0>;
>>> +			clock-frequency = <38400000>;
>>> +		};
>>> +
>>> +		sleep_clk: sleep-clk {
>>> +			compatible = "fixed-clock";
>>> +			#clock-cells = <0>;
>>> +			clock-frequency = <32764>;
>>> +			clock-output-names = "sleep_clk";
>>> +		};
>>> +	};
>>> +
>>> +	cpus {
>>> +		#address-cells = <2>;
>>> +		#size-cells = <0>;
>>> +
>>> +		CPU0: cpu@0 {
>>> +			device_type = "cpu";
>>> +			compatible = "qcom,kryo485";
>>> +			reg = <0x0 0x0>;
>> Please add clocks = <&cpufreq_hw n>;
>>  
>>> +			enable-method = "psci";
>>> +			capacity-dmips-mhz = <602>;
>>> +			next-level-cache = <&L2_0>;
>>> +			qcom,freq-domain = <&cpufreq_hw 0>;
> 
> You mean this or something else?
Check

https://lore.kernel.org/lkml/20221102065448.GA10650@thinkpad/T/

> 
>>> +			operating-points-v2 = <&cpu0_opp_table>;
>>> +			interconnects = <&gem_noc MASTER_AMPSS_M0 3 &mc_virt SLAVE_EBI_CH0 3>,
>>> +					<&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
>>> +			power-domains = <&CPU_PD0>;
>>> +			power-domain-names = "psci";
>>> +			#cooling-cells = <2>;
>> Add a newline before subnodes, please.
> 
> Sure
> 
>>
>>> +			L2_0: l2-cache {
>>> +				compatible = "cache";
>>> +				next-level-cache = <&L3_0>;
>>> +				L3_0: l3-cache {
>>> +				      compatible = "cache";
>>> +				};
>>> +			};
>>> +		};
>>> +
>> [...]
>>
>>> +
>>> +	cpu0_opp_table: opp-table-cpu0 {
>>> +		compatible = "operating-points-v2";
>>> +		opp-shared;
>>> +
>>> +		opp-300000000 {
>>> +			opp-hz = /bits/ 64 <300000000>;
>>> +			opp-peak-kBps = <800000 9600000>;
>> Maybe adding bwmon from the get-go would be better than statically
>> scaling DDR freq?
> 
> Maybe :-) but we would like to land the dts now rather than wait more :)
> 
>>
>> [...]
>>
>>> +	camnoc_virt: interconnect-0{
>> Missing space before {
> 
> Will fix
> 
>>> +		compatible = "qcom,sc8180x-camnoc-virt";
>>> +		#interconnect-cells = <2>;
>>> +		qcom,bcm-voters = <&apps_bcm_voter>;
>>> +	};
>>> +
>>> +	mc_virt: interconnect-mc-virt {
>> Please be consistent with your naming.
> 
> Are you referring to adding -0 for this?
I'm not sure which is preferred (-n vs -name), there's a mixed bag
upstream.. Krzysztof?

> 
>>
>>> +		compatible = "qcom,sc8180x-mc-virt";
>>> +		#interconnect-cells = <2>;
>>> +		qcom,bcm-voters = <&apps_bcm_voter>;
>>> +	};
>>> +
>>> +	qup_virt: interconnect-qup-virt {
>>> +		compatible = "qcom,sc8180x-qup-virt";
>>> +		#interconnect-cells = <2>;
>>> +		qcom,bcm-voters = <&apps_bcm_voter>;
>>> +	};
>>> +
>> [...]
>>
>>> +	reserved-memory {
>>> +		#address-cells = <2>;
>>> +		#size-cells = <2>;
>>> +		ranges;
>>> +
>>> +		hyp_mem: hyp-region@85700000 {
>> the -region seems a bit unnecessary in all of these nodes
> 
> This is reserved for hyp, I think we should add it here so that we dont
> touch this piece..?
I meant the '-region' bit in the node names

(label: name@unit-address)

Konrad
> 
>>
>>> +			reg = <0x0 0x85700000 0x0 0x600000>;
>>> +			no-map;
>>> +		};
>>> +
>> [...]
>>
>>> +
>>> +	soc: soc@0 {
>>> +		#address-cells = <2>;
>>> +		#size-cells = <2>;
>>> +		ranges = <0 0 0 0 0x10 0>;
>>> +		dma-ranges = <0 0 0 0 0x10 0>;
>>> +		compatible = "simple-bus";
>> compat
>> addr-cells
>> size-cella
>> ranges
>> dma-ranges
>>
>> please
> 
> Sure
> 
>>
>>> +
>>> +		gcc: clock-controller@100000 {
>>> +			compatible = "qcom,gcc-sc8180x";
>>> +			reg = <0x0 0x00100000 0x0 0x1f0000>;
>>> +			#clock-cells = <1>;
>>> +			#reset-cells = <1>;
>>> +			#power-domain-cells = <1>;
>>> +			clock-names = "bi_tcxo",
>>> +				      "bi_tcxo_ao",
>>> +				      "sleep_clk";
>>> +			clocks = <&rpmhcc RPMH_CXO_CLK>,
>>> +				 <&rpmhcc RPMH_CXO_CLK_A>,
>>> +				 <&sleep_clk>;
>> property before property-names
> 
> ok
> 
>>
>>
>>> +		};
>>> +
>>> +		qupv3_id_0: geniqup@8c0000 {
>>> +			compatible = "qcom,geni-se-qup";
>>> +			reg = <0 0x008c0000 0 0x6000>;
>>> +			clock-names = "m-ahb", "s-ahb";
>>> +			clocks = <&gcc GCC_QUPV3_WRAP_0_M_AHB_CLK>,
>>> +				 <&gcc GCC_QUPV3_WRAP_0_S_AHB_CLK>;
>>> +			#address-cells = <2>;
>>> +			#size-cells = <2>;
>>> +			ranges;
>>> +			iommus = <&apps_smmu 0x4c3 0>;
>>> +			status = "disabled";
>>> +
>>> +			i2c0: i2c@880000 {
>>> +				compatible = "qcom,geni-i2c";
>>> +				reg = <0 0x00880000 0 0x4000>;
>>> +				clock-names = "se";
>>> +				clocks = <&gcc GCC_QUPV3_WRAP0_S0_CLK>;
>> property before property-names
>>
>> Please split QUPs into a separate patch, this one is way
>> too big.
> 
> Will do
> 
>>
>> [...]
>>
>>> +		config_noc: interconnect@1500000 {
>> Interconnect could also realistically go to a separate patch.
> 
> Yeah already list is complaining, let me see how to split it up...
> 
>>
>>> +			compatible = "qcom,sc8180x-config-noc";
>>> +			reg = <0 0x01500000 0 0x7400>;
>>> +			#interconnect-cells = <2>;
>>> +			qcom,bcm-voters = <&apps_bcm_voter>;
>>> +		};
>>> +
>>> +		system_noc: interconnect@1620000 {
>>> +			compatible = "qcom,sc8180x-system-noc";
>>> +			reg = <0 0x01620000 0 0x19400>;
>>> +			#interconnect-cells = <2>;
>>> +			qcom,bcm-voters = <&apps_bcm_voter>;
>>> +		};
>>> +
>>> +		aggre1_noc: interconnect@16e0000 {
>>> +			compatible = "qcom,sc8180x-aggre1-noc";
>>> +			reg = <0 0x016e0000 0 0xd080>;
>>> +			#interconnect-cells = <2>;
>>> +			qcom,bcm-voters = <&apps_bcm_voter>;
>>> +		};
>>> +
>>> +		aggre2_noc: interconnect@1700000 {
>>> +			compatible = "qcom,sc8180x-aggre2-noc";
>>> +			reg = <0 0x01700000 0 0x20000>;
>>> +			#interconnect-cells = <2>;
>>> +			qcom,bcm-voters = <&apps_bcm_voter>;
>>> +		};
>>> +
>>> +		compute_noc: interconnect@1720000 {
>>> +			compatible = "qcom,sc8180x-compute-noc";
>>> +			reg = <0 0x01720000 0 0x7000>;
>>> +			#interconnect-cells = <2>;
>>> +			qcom,bcm-voters = <&apps_bcm_voter>;
>>> +		};
>>> +
>>> +		mmss_noc: interconnect@1740000 {
>>> +			compatible = "qcom,sc8180x-mmss-noc";
>>> +			reg = <0 0x01740000 0 0x1c100>;
>>> +			#interconnect-cells = <2>;
>>> +			qcom,bcm-voters = <&apps_bcm_voter>;
>>> +		};
>>> +
>> [...]
>>
>>> +		pcie0: pci@1c00000 {
>> And PCIe
>>
>>> +			compatible = "qcom,pcie-sc8180x";
>>> +			reg = <0 0x01c00000 0 0x3000>,
>>> +			      <0 0x60000000 0 0xf1d>,
>>> +			      <0 0x60000f20 0 0xa8>,
>>> +			      <0 0x60001000 0 0x1000>,
>>> +			      <0 0x60100000 0 0x100000>;
>>> +			reg-names = "parf", "dbi", "elbi", "atu", "config";
>> One per line, please
> 
> ok
> 
>>
>>
>> [...]
>>
>>> +
>>> +		ufs_mem_hc: ufshc@1d84000 {
>>> +			compatible = "qcom,sc8180x-ufshc", "qcom,ufshc",
>>> +				     "jedec,ufs-2.0";
>>> +			reg = <0 0x01d84000 0 0x2500>;
>>> +			interrupts = <GIC_SPI 265 IRQ_TYPE_LEVEL_HIGH>;
>>> +			phys = <&ufs_mem_phy_lanes>;
>>> +			phy-names = "ufsphy";
>>> +			lanes-per-direction = <2>;
>>> +			#reset-cells = <1>;
>>> +			resets = <&gcc GCC_UFS_PHY_BCR>;
>>> +			reset-names = "rst";
>>> +
>>> +			iommus = <&apps_smmu 0x300 0>;
>>> +
>>> +			clock-names =
>> No need for this weird newline split.
>>
>> Also, property before property-names.
>>
>> [...]
>>
>>
>>> +
>>> +		gpu: gpu@2c00000 {
>> GPUSS and MDSS related nodes should also go to their separate,
>> respective patches.
> 
> ok
> 
>>
>> [...]
>>> +
>>> +		remoteproc_mpss: remoteproc@4080000 {
>> And remote procs as well
>>
>>> +			compatible = "qcom,sc8180x-mpss-pas";
>>> +			reg = <0x0 0x04080000 0x0 0x4040>;
>>> +
>> [...]
>>
>>> +	thermal-zones {
>> And thermal-zones as well.
>>
>>
>> I'll go more in-depth after you split it up, this is pretty hard
>> to review as-is.
>>
>> Konrad
>>> +		cpu0-thermal {
>>> +			polling-delay-passive = <250>;
>>> +			polling-delay = <1000>;
>>> +
>>> +			thermal-sensors = <&tsens0 1>;
>>> +
>>> +			trips {
>>> +				cpu-crit {
>>> +					temperature = <110000>;
>>> +					hysteresis = <1000>;
>>> +					type = "critical";
>>> +				};
>>> +			};
>>> +		};
>>> +
>>> +		cpu1-thermal {
>>> +			polling-delay-passive = <250>;
>>> +			polling-delay = <1000>;
>>> +
>>> +			thermal-sensors = <&tsens0 2>;
>>> +
>>> +			trips {
>>> +				cpu-crit {
>>> +					temperature = <110000>;
>>> +					hysteresis = <1000>;
>>> +					type = "critical";
>>> +				};
>>> +			};
>>> +		};
>>> +
>>> +		cpu2-thermal {
>>> +			polling-delay-passive = <250>;
>>> +			polling-delay = <1000>;
>>> +
>>> +			thermal-sensors = <&tsens0 3>;
>>> +
>>> +			trips {
>>> +				cpu-crit {
>>> +					temperature = <110000>;
>>> +					hysteresis = <1000>;
>>> +					type = "critical";
>>> +				};
>>> +			};
>>> +		};
>>> +
>>> +		cpu3-thermal {
>>> +			polling-delay-passive = <250>;
>>> +			polling-delay = <1000>;
>>> +
>>> +			thermal-sensors = <&tsens0 4>;
>>> +
>>> +			trips {
>>> +				cpu-crit {
>>> +					temperature = <110000>;
>>> +					hysteresis = <1000>;
>>> +					type = "critical";
>>> +				};
>>> +			};
>>> +		};
>>> +
>>> +		cpu4-top-thermal {
>>> +			polling-delay-passive = <250>;
>>> +			polling-delay = <1000>;
>>> +
>>> +			thermal-sensors = <&tsens0 7>;
>>> +
>>> +			trips {
>>> +				cpu-crit {
>>> +					temperature = <110000>;
>>> +					hysteresis = <1000>;
>>> +					type = "critical";
>>> +				};
>>> +			};
>>> +		};
>>> +
>>> +		cpu5-top-thermal {
>>> +			polling-delay-passive = <250>;
>>> +			polling-delay = <1000>;
>>> +
>>> +			thermal-sensors = <&tsens0 8>;
>>> +
>>> +			trips {
>>> +				cpu-crit {
>>> +					temperature = <110000>;
>>> +					hysteresis = <1000>;
>>> +					type = "critical";
>>> +				};
>>> +			};
>>> +		};
>>> +
>>> +		cpu6-top-thermal {
>>> +			polling-delay-passive = <250>;
>>> +			polling-delay = <1000>;
>>> +
>>> +			thermal-sensors = <&tsens0 9>;
>>> +
>>> +			trips {
>>> +				cpu-crit {
>>> +					temperature = <110000>;
>>> +					hysteresis = <1000>;
>>> +					type = "critical";
>>> +				};
>>> +			};
>>> +		};
>>> +
>>> +		cpu7-top-thermal {
>>> +			polling-delay-passive = <250>;
>>> +			polling-delay = <1000>;
>>> +
>>> +			thermal-sensors = <&tsens0 10>;
>>> +
>>> +			trips {
>>> +				cpu-crit {
>>> +					temperature = <110000>;
>>> +					hysteresis = <1000>;
>>> +					type = "critical";
>>> +				};
>>> +			};
>>> +		};
>>> +
>>> +		cpu4-bottom-thermal {
>>> +			polling-delay-passive = <250>;
>>> +			polling-delay = <1000>;
>>> +
>>> +			thermal-sensors = <&tsens0 11>;
>>> +
>>> +			trips {
>>> +				cpu-crit {
>>> +					temperature = <110000>;
>>> +					hysteresis = <1000>;
>>> +					type = "critical";
>>> +				};
>>> +			};
>>> +		};
>>> +
>>> +		cpu5-bottom-thermal {
>>> +			polling-delay-passive = <250>;
>>> +			polling-delay = <1000>;
>>> +
>>> +			thermal-sensors = <&tsens0 12>;
>>> +
>>> +			trips {
>>> +				cpu-crit {
>>> +					temperature = <110000>;
>>> +					hysteresis = <1000>;
>>> +					type = "critical";
>>> +				};
>>> +			};
>>> +		};
>>> +
>>> +		cpu6-bottom-thermal {
>>> +			polling-delay-passive = <250>;
>>> +			polling-delay = <1000>;
>>> +
>>> +			thermal-sensors = <&tsens0 13>;
>>> +
>>> +			trips {
>>> +				cpu-crit {
>>> +					temperature = <110000>;
>>> +					hysteresis = <1000>;
>>> +					type = "critical";
>>> +				};
>>> +			};
>>> +		};
>>> +
>>> +		cpu7-bottom-thermal {
>>> +			polling-delay-passive = <250>;
>>> +			polling-delay = <1000>;
>>> +
>>> +			thermal-sensors = <&tsens0 14>;
>>> +
>>> +			trips {
>>> +				cpu-crit {
>>> +					temperature = <110000>;
>>> +					hysteresis = <1000>;
>>> +					type = "critical";
>>> +				};
>>> +			};
>>> +		};
>>> +
>>> +		aoss0-thermal {
>>> +			polling-delay-passive = <250>;
>>> +			polling-delay = <1000>;
>>> +
>>> +			thermal-sensors = <&tsens0 0>;
>>> +
>>> +			trips {
>>> +				trip-point0 {
>>> +					temperature = <90000>;
>>> +					hysteresis = <2000>;
>>> +					type = "hot";
>>> +				};
>>> +			};
>>> +		};
>>> +
>>> +		cluster0-thermal {
>>> +			polling-delay-passive = <250>;
>>> +			polling-delay = <1000>;
>>> +
>>> +			thermal-sensors = <&tsens0 5>;
>>> +
>>> +			trips {
>>> +				cluster-crit {
>>> +					temperature = <110000>;
>>> +					hysteresis = <2000>;
>>> +					type = "critical";
>>> +				};
>>> +			};
>>> +		};
>>> +
>>> +		cluster1-thermal {
>>> +			polling-delay-passive = <250>;
>>> +			polling-delay = <1000>;
>>> +
>>> +			thermal-sensors = <&tsens0 6>;
>>> +
>>> +			trips {
>>> +				cluster-crit {
>>> +					temperature = <110000>;
>>> +					hysteresis = <2000>;
>>> +					type = "critical";
>>> +				};
>>> +			};
>>> +		};
>>> +
>>> +		gpu-thermal-top {
>>> +			polling-delay-passive = <250>;
>>> +			polling-delay = <1000>;
>>> +
>>> +			thermal-sensors = <&tsens0 15>;
>>> +
>>> +			trips {
>>> +				trip-point0 {
>>> +					temperature = <90000>;
>>> +					hysteresis = <2000>;
>>> +					type = "hot";
>>> +				};
>>> +			};
>>> +		};
>>> +
>>> +		aoss1-thermal {
>>> +			polling-delay-passive = <250>;
>>> +			polling-delay = <1000>;
>>> +
>>> +			thermal-sensors = <&tsens1 0>;
>>> +
>>> +			trips {
>>> +				trip-point0 {
>>> +					temperature = <90000>;
>>> +					hysteresis = <2000>;
>>> +					type = "hot";
>>> +				};
>>> +			};
>>> +		};
>>> +
>>> +		wlan-thermal {
>>> +			polling-delay-passive = <250>;
>>> +			polling-delay = <1000>;
>>> +
>>> +			thermal-sensors = <&tsens1 1>;
>>> +
>>> +			trips {
>>> +				trip-point0 {
>>> +					temperature = <90000>;
>>> +					hysteresis = <2000>;
>>> +					type = "hot";
>>> +				};
>>> +			};
>>> +		};
>>> +
>>> +		video-thermal {
>>> +			polling-delay-passive = <250>;
>>> +			polling-delay = <1000>;
>>> +
>>> +			thermal-sensors = <&tsens1 2>;
>>> +
>>> +			trips {
>>> +				trip-point0 {
>>> +					temperature = <90000>;
>>> +					hysteresis = <2000>;
>>> +					type = "hot";
>>> +				};
>>> +			};
>>> +		};
>>> +
>>> +		mem-thermal {
>>> +			polling-delay-passive = <250>;
>>> +			polling-delay = <1000>;
>>> +
>>> +			thermal-sensors = <&tsens1 3>;
>>> +
>>> +			trips {
>>> +				trip-point0 {
>>> +					temperature = <90000>;
>>> +					hysteresis = <2000>;
>>> +					type = "hot";
>>> +				};
>>> +			};
>>> +		};
>>> +
>>> +		q6-hvx-thermal {
>>> +			polling-delay-passive = <250>;
>>> +			polling-delay = <1000>;
>>> +
>>> +			thermal-sensors = <&tsens1 4>;
>>> +
>>> +			trips {
>>> +				trip-point0 {
>>> +					temperature = <90000>;
>>> +					hysteresis = <2000>;
>>> +					type = "hot";
>>> +				};
>>> +			};
>>> +		};
>>> +
>>> +		camera-thermal {
>>> +			polling-delay-passive = <250>;
>>> +			polling-delay = <1000>;
>>> +
>>> +			thermal-sensors = <&tsens1 5>;
>>> +
>>> +			trips {
>>> +				trip-point0 {
>>> +					temperature = <90000>;
>>> +					hysteresis = <2000>;
>>> +					type = "hot";
>>> +				};
>>> +			};
>>> +		};
>>> +
>>> +		compute-thermal {
>>> +			polling-delay-passive = <250>;
>>> +			polling-delay = <1000>;
>>> +
>>> +			thermal-sensors = <&tsens1 6>;
>>> +
>>> +			trips {
>>> +				trip-point0 {
>>> +					temperature = <90000>;
>>> +					hysteresis = <2000>;
>>> +					type = "hot";
>>> +				};
>>> +			};
>>> +		};
>>> +
>>> +		mdm-dsp-thermal {
>>> +			polling-delay-passive = <250>;
>>> +			polling-delay = <1000>;
>>> +
>>> +			thermal-sensors = <&tsens1 7>;
>>> +
>>> +			trips {
>>> +				trip-point0 {
>>> +					temperature = <90000>;
>>> +					hysteresis = <2000>;
>>> +					type = "hot";
>>> +				};
>>> +			};
>>> +		};
>>> +
>>> +		npu-thermal {
>>> +			polling-delay-passive = <250>;
>>> +			polling-delay = <1000>;
>>> +
>>> +			thermal-sensors = <&tsens1 8>;
>>> +
>>> +			trips {
>>> +				trip-point0 {
>>> +					temperature = <90000>;
>>> +					hysteresis = <2000>;
>>> +					type = "hot";
>>> +				};
>>> +			};
>>> +		};
>>> +
>>> +		gpu-thermal-bottom {
>>> +			polling-delay-passive = <250>;
>>> +			polling-delay = <1000>;
>>> +
>>> +			thermal-sensors = <&tsens1 11>;
>>> +
>>> +			trips {
>>> +				trip-point0 {
>>> +					temperature = <90000>;
>>> +					hysteresis = <2000>;
>>> +					type = "hot";
>>> +				};
>>> +			};
>>> +		};
>>> +	};
>>> +
>>> +	timer {
>>> +		compatible = "arm,armv8-timer";
>>> +		interrupts = <GIC_PPI 1 IRQ_TYPE_LEVEL_LOW>,
>>> +			     <GIC_PPI 2 IRQ_TYPE_LEVEL_LOW>,
>>> +			     <GIC_PPI 3 IRQ_TYPE_LEVEL_LOW>,
>>> +			     <GIC_PPI 0 IRQ_TYPE_LEVEL_LOW>;
>>> +	};
>>> +};
> 
