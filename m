Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD35632EF3
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 22:39:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231408AbiKUVj5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 16:39:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231526AbiKUVjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 16:39:55 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C2D58021;
        Mon, 21 Nov 2022 13:39:52 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ALGmV3D012507;
        Mon, 21 Nov 2022 21:39:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : from : subject : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=x+BHob8Eyp25zgDwDULnaJK6DKOTCBUHH6QyLHHp9m8=;
 b=Ky8KpclD/tdDubou9gfNPPtVZoWPPcffLQLygzJbetj9USIa/bVC+v7TEqoDWoadN36b
 6hhJETK6+NcBgeBKizK2d7ImzvuMW9xJWIsD7F+W0ghB1H+Wh0Btp/PFzJC5lr0K++nj
 va127jLG3jgxlyKdv7mOMEZNuYxnyemBYVcXpp3InbGryAKV/tmrIzm6YI9DD4wFp0Bu
 j0S7al8ACTSVpmnpLelMMvHIWiwYXmkdPZ21XB4qRn0ZjFHw+sGg0nYmfZDsaS7gO+zf
 mfYBfKgYOQOaCxtY9UnoeLZTPLJ+0+hCxHp1+YesdFwAg494OJHGPUfYYsH43bDM5D/A GA== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kxrf5nt7h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Nov 2022 21:39:46 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2ALLdkp6026116
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Nov 2022 21:39:46 GMT
Received: from [10.110.33.239] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 21 Nov
 2022 13:39:45 -0800
Message-ID: <1633d309-05e3-e7bd-c1cd-54c1069bad5c@quicinc.com>
Date:   Mon, 21 Nov 2022 15:39:44 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
From:   Melody Olvera <quic_molvera@quicinc.com>
Subject: Re: [PATCH v4 1/2] arm64: dts: qcom: Add base QDU1000/QRU1000 DTSIs
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20221118192241.29384-1-quic_molvera@quicinc.com>
 <20221118192241.29384-2-quic_molvera@quicinc.com>
 <8341830c-a09c-9366-096a-d58d34da36bd@linaro.org>
Content-Language: en-US
In-Reply-To: <8341830c-a09c-9366-096a-d58d34da36bd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: VsLIymTN6mbURfvrYkkAjts7o7T1lvYa
X-Proofpoint-ORIG-GUID: VsLIymTN6mbURfvrYkkAjts7o7T1lvYa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-21_18,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211210163
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/21/2022 5:03 AM, Konrad Dybcio wrote:
> On 18.11.2022 20:22, Melody Olvera wrote:
>> Add the base DTSI files for QDU1000 and QRU1000 SoCs, including base
>> descriptions of CPUs, GCC, RPMHCC, QUP, TLMM, and interrupt-controller
>> to boot to shell with console on these SoCs.
>>
>> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
>> ---
>>  arch/arm64/boot/dts/qcom/qdu1000.dtsi | 1406 +++++++++++++++++++++++++
>>  arch/arm64/boot/dts/qcom/qru1000.dtsi |   27 +
>>  2 files changed, 1433 insertions(+)
>>  create mode 100644 arch/arm64/boot/dts/qcom/qdu1000.dtsi
>>  create mode 100644 arch/arm64/boot/dts/qcom/qru1000.dtsi
>>
>> diff --git a/arch/arm64/boot/dts/qcom/qdu1000.dtsi b/arch/arm64/boot/dts/qcom/qdu1000.dtsi
>> new file mode 100644
>> index 000000000000..8f1b52cc8ff4
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/qcom/qdu1000.dtsi
>> @@ -0,0 +1,1406 @@
>> +// SPDX-License-Identifier: BSD-3-Clause
>> +/*
>> + * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
>> + */
>> +
>> +#include <dt-bindings/interrupt-controller/arm-gic.h>
>> +#include <dt-bindings/clock/qcom,gcc-qdu1000.h>
>> +#include <dt-bindings/clock/qcom,rpmh.h>
>> +#include <dt-bindings/dma/qcom-gpi.h>
>> +#include <dt-bindings/interconnect/qcom,qdu1000.h>
>> +#include <dt-bindings/power/qcom-rpmpd.h>
>> +#include <dt-bindings/soc/qcom,rpmh-rsc.h>
> Hi!
>
> Please sort these.

Sure thing.

>> +
>> +/ {
>> +	interrupt-parent = <&intc>;
>> +
>> +	#address-cells = <2>;
>> +	#size-cells = <2>;
>> +
>> +	chosen: chosen { };
>> +
>> +	cpus {
>> +		#address-cells = <2>;
>> +		#size-cells = <0>;
>> +
>> +		CPU0: cpu@0 {
>> +			device_type = "cpu";
>> +			compatible = "arm,cortex-a55";
>> +			reg = <0x0 0x0>;
>> +			enable-method = "psci";
>> +			power-domain-names = "psci";
>> +			power-domains = <&CPU_PD0>;
>> +			qcom,freq-domains = <&cpufreq_hw 0>;
>> +			next-level-cache = <&L2_0>;
>> +			L2_0: l2-cache {
>> +				compatible = "cache";
>> +				next-level-cache = <&L3_0>;
>> +				L3_0: l3-cache {
>> +					compatible = "cache";
>> +				};
>> +			};
>> +		};
>> +
>> +		CPU1: cpu@100 {
>> +			device_type = "cpu";
>> +			compatible = "arm,cortex-a55";
>> +			reg = <0x0 0x100>;
>> +			enable-method = "psci";
>> +			power-domains = <&CPU_PD1>;
>> +			power-domain-names = "psci";
>> +			qcom,freq-domains = <&cpufreq_hw 0>;
>> +			next-level-cache = <&L2_100>;
>> +			L2_100: l2-cache {
>> +				compatible = "cache";
>> +				next-level-cache = <&L3_0>;
>> +			};
>> +		};
>> +
>> +		CPU2: cpu@200 {
>> +			device_type = "cpu";
>> +			compatible = "arm,cortex-a55";
>> +			reg = <0x0 0x200>;
>> +			enable-method = "psci";
>> +			power-domains = <&CPU_PD2>;
>> +			power-domain-names = "psci";
>> +			qcom,freq-domains = <&cpufreq_hw 0>;
>> +			next-level-cache = <&L2_200>;
>> +			L2_200: l2-cache {
>> +				compatible = "cache";
>> +				next-level-cache = <&L3_0>;
>> +			};
>> +		};
>> +
>> +		CPU3: cpu@300 {
>> +			device_type = "cpu";
>> +			compatible = "arm,cortex-a55";
>> +			reg = <0x0 0x300>;
>> +			enable-method = "psci";
>> +			power-domains = <&CPU_PD3>;
>> +			power-domain-names = "psci";
>> +			qcom,freq-domains = <&cpufreq_hw 0>;
>> +			next-level-cache = <&L2_300>;
>> +			L2_300: l2-cache {
>> +				compatible = "cache";
>> +				next-level-cache = <&L3_0>;
>> +			};
>> +		};
>> +
>> +		cpu-map {
>> +			cluster0 {
>> +				core0 {
>> +					cpu = <&CPU0>;
>> +				};
>> +
>> +				core1 {
>> +					cpu = <&CPU1>;
>> +				};
>> +
>> +				core2 {
>> +					cpu = <&CPU2>;
>> +				};
>> +
>> +				core3 {
>> +					cpu = <&CPU3>;
>> +				};
>> +			};
>> +		};
>> +	};
>> +
>> +	idle-states {
>> +		entry-method = "psci";
>> +
>> +		CPU_OFF: cpu-sleep-0 {
>> +			compatible = "arm,idle-state";
>> +			entry-latency-us = <274>;
>> +			exit-latency-us = <480>;
>> +			min-residency-us = <3934>;
>> +			arm,psci-suspend-param = <0x40000004>;
>> +			local-timer-stop;
>> +		};
>> +	};
>> +
>> +	domain-idle-states {
>> +		CLUSTER_SLEEP_0: cluster-sleep-0 {
>> +			compatible = "domain-idle-state";
>> +			entry-latency-us = <584>;
>> +			exit-latency-us = <2332>;
>> +			min-residency-us = <6118>;
>> +			arm,psci-suspend-param = <0x41000044>;
>> +		};
>> +
>> +		CLUSTER_SLEEP_1: cluster-sleep-1 {
>> +			compatible = "domain-idle-state";
>> +			entry-latency-us = <2893>;
>> +			exit-latency-us = <4023>;
>> +			min-residency-us = <9987>;
>> +			arm,psci-suspend-param = <0x41003344>;
>> +		};
>> +	};
>> +
>> +	firmware {
>> +		scm {
>> +			compatible = "qcom,scm-qdu1000", "qcom,scm";
>> +		};
>> +	};
>> +
>> +	mc_virt: interconnect-0 {
>> +		compatible = "qcom,qdu1000-mc-virt";
>> +		#interconnect-cells = <2>;
>> +		qcom,bcm-voters = <&apps_bcm_voter>;
>> +	};
>> +
>> +	clk_virt: interconnect-1 {
>> +		compatible = "qcom,qdu1000-clk-virt";
>> +		#interconnect-cells = <2>;
>> +		qcom,bcm-voters = <&apps_bcm_voter>;
>> +	};
>> +
>> +	memory@80000000 {
>> +		device_type = "memory";
>> +		/* We expect the bootloader to fill in the size */
>> +		reg = <0x0 0x80000000 0x0 0x0>;
>> +	};
>> +
>> +	pmu {
>> +		compatible = "arm,armv8-pmuv3";
>> +		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>;
>> +	};
>> +
>> +	psci {
>> +		compatible = "arm,psci-1.0";
>> +		method = "smc";
>> +
>> +		CPU_PD0: power-domain-cpu0 {
>> +			#power-domain-cells = <0>;
>> +			power-domains = <&CLUSTER_PD>;
>> +			domain-idle-states = <&CPU_OFF>;
>> +		};
>> +
>> +		CPU_PD1: power-domain-cpu1 {
>> +			#power-domain-cells = <0>;
>> +			power-domains = <&CLUSTER_PD>;
>> +			domain-idle-states = <&CPU_OFF>;
>> +		};
>> +
>> +		CPU_PD2: power-domain-cpu2 {
>> +			#power-domain-cells = <0>;
>> +			power-domains = <&CLUSTER_PD>;
>> +			domain-idle-states = <&CPU_OFF>;
>> +		};
>> +
>> +		CPU_PD3: power-domain-cpu3 {
>> +			#power-domain-cells = <0>;
>> +			power-domains = <&CLUSTER_PD>;
>> +			domain-idle-states = <&CPU_OFF>;
>> +		};
>> +
>> +		CLUSTER_PD: power-domain-cluster {
>> +			#power-domain-cells = <0>;
>> +			domain-idle-states = <&CLUSTER_SLEEP_0 &CLUSTER_SLEEP_1>;
>> +		};
>> +	};
>> +
>> +	reserved_memory: reserved-memory {
>> +		#address-cells = <2>;
>> +		#size-cells = <2>;
>> +		ranges;
>> +
>> +		hyp_mem: memory@80000000 {
> Nodes should not use 'memory@', but something more descriptive,
> in this case you can use hyp@, for example.

Ok, makes sense.

>> +			no-map;
>> +			reg = <0x0 0x80000000 0x0 0x600000>;
> Please make reg the first property.

Ok.

>> +		};
>> +
>> +		xbl_dt_log_mem: memory@80600000 {
>> +			no-map;
>> +			reg = <0x0 0x80600000 0x0 0x40000>;
>> +		};
>> +
>> +		xbl_ramdump_mem: memory@80640000 {
>> +			no-map;
>> +			reg = <0x0 0x80640000 0x0 0x1c0000>;
>> +		};
>> +
>> +		aop_image_mem: memory@80800000 {
>> +			no-map;
>> +			reg = <0x0 0x80800000 0x0 0x60000>;
>> +		};
>> +
>> +		aop_cmd_db_mem: memory@80860000 {
>> +			compatible = "qcom,cmd-db";
>> +			no-map;
>> +			reg = <0x0 0x80860000 0x0 0x20000>;
>> +		};
>> +
>> +		aop_config_mem: memory@80880000 {
>> +			no-map;
>> +			reg = <0x0 0x80880000 0x0 0x20000>;
>> +		};
>> +
>> +		tme_crash_dump_mem: memory@808a0000 {
>> +			no-map;
>> +			reg = <0x0 0x808a0000 0x0 0x40000>;
>> +		};
>> +
>> +		tme_log_mem: memory@808e0000 {
>> +			no-map;
>> +			reg = <0x0 0x808e0000 0x0 0x4000>;
>> +		};
>> +
>> +		uefi_log_mem: memory@808e4000 {
>> +			no-map;
>> +			reg = <0x0 0x808e4000 0x0 0x10000>;
>> +		};
>> +
>> +		/* secdata region can be reused by apps */
>> +
>> +		smem_mem: memory@80900000 {
>> +			compatible = "qcom,smem";
>> +			no-map;
>> +			reg = <0x0 0x80900000 0x0 0x200000>;
>> +			hwlocks = <&tcsr_mutex 3>;
>> +		};
>> +
>> +		cpucp_fw_mem: memory@80b00000 {
>> +			no-map;
>> +			reg = <0x0 0x80b00000 0x0 0x100000>;
>> +		};
>> +
>> +		xbl_sc_mem: memory@80c00000 {
>> +			no-map;
>> +			reg = <0x0 0x80c00000 0x0 0x40000>;
>> +		};
>> +
>> +		/* uefi region can be reused by apps */
>> +
>> +		tz_stat_mem: memory@81d00000 {
>> +			no-map;
>> +			reg = <0x0 0x81d00000 0x0 0x100000>;
>> +		};
>> +
>> +		tags_mem: memory@81e00000 {
>> +			no-map;
>> +			reg = <0x0 0x81e00000 0x0 0x500000>;
>> +		};
>> +
>> +		qtee_mem: memory@82300000 {
>> +			no-map;
>> +			reg = <0x0 0x82300000 0x0 0x500000>;
>> +		};
>> +
>> +		ta_mem: memory@82800000 {
>> +			no-map;
>> +			reg = <0x0 0x82800000 0x0 0xa00000>;
>> +		};
>> +
>> +		fs1_mem: memory@83200000 {
>> +			no-map;
>> +			reg = <0x0 0x83200000 0x0 0x400000>;
>> +		};
>> +
>> +		fs2_mem: memory@83600000 {
>> +			no-map;
>> +			reg = <0x0 0x83600000 0x0 0x400000>;
>> +		};
>> +
>> +		fs3_mem: memory@83a00000 {
>> +			no-map;
>> +			reg = <0x0 0x83a00000 0x0 0x400000>;
>> +		};
>> +
>> +		/* Linux kernel image is loaded at 0x83e00000 */
>> +
>> +		ipa_fw_mem: memory@8be00000 {
>> +			no-map;
>> +			reg = <0x0 0x8be00000 0x0 0x10000>;
>> +		};
>> +
>> +		ipa_gsi_mem: memory@8be10000 {
>> +			no-map;
>> +			reg = <0x0 0x8be10000 0x0 0x14000>;
>> +		};
>> +
>> +		mpss_mem: memory@8c000000 {
>> +			no-map;
>> +			reg = <0x0 0x8c000000 0x0 0x12c00000>;
>> +		};
>> +
>> +		q6_mpss_dtb_mem: memory@9ec00000 {
>> +			no-map;
>> +			reg = <0x0 0x9ec00000 0x0 0x80000>;
>> +		};
>> +
>> +		tenx_mem: memory@a0000000 {
>> +			no-map;
>> +			reg = <0x0 0xa0000000 0x0 0x19600000>;
>> +		};
>> +
>> +		oem_tenx_mem: memory@b9600000 {
>> +			no-map;
>> +			reg = <0x0 0xb9600000 0x0 0x6a00000>;
>> +		};
>> +
>> +		tenx_q6_buffer_mem: memory@c0000000 {
>> +			no-map;
>> +			reg = <0x0 0xc0000000 0x0 0x3200000>;
>> +		};
>> +
>> +		ipa_buffer_mem: memory@c3200000 {
>> +			no-map;
>> +			reg = <0x0 0xc3200000 0x0 0x12c00000>;
>> +		};
>> +	};
>> +
>> +	soc: soc@0 {
>> +		#address-cells = <2>;
>> +		#size-cells = <2>;
>> +		ranges = <0 0 0 0 0x10 0>;
>> +		dma-ranges = <0 0 0 0 0x10 0>;
>> +		compatible = "simple-bus";
>> +
>> +		gcc: clock-controller@80000 {
>> +			compatible = "qcom,gcc-qdu1000", "syscon";
>> +			reg = <0x0 0x80000 0x0 0x1f4200>;
>> +			#clock-cells = <1>;
>> +			#reset-cells = <1>;
>> +			#power-domain-cells = <1>;
> Please move #-cells below clocks.

Got it.

>> +			clocks = <&rpmhcc RPMH_CXO_CLK>, <&sleep_clk>,
>> +				 <&pcie_0_pipe_clk>, <&pcie_0_phy_aux_clk>,
>> +				 <&usb3_phy_wrapper_pipe_clk>;
>> +		};
>> +
>> +		gpi_dma0: dma-controller@900000  {
>> +			compatible = "qcom,qdu1000-gpi-dma", "qcom,sm6350-gpi-dma";
>> +			#dma-cells = <3>;
>> +			reg = <0x0 0x900000 0x0 0x60000>;
> compatible and reg should go first.

Sure, for all nodes.

>> +			interrupts = <GIC_SPI 244 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 245 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 246 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 247 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 248 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 249 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 250 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 251 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 252 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 253 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 254 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 255 IRQ_TYPE_LEVEL_HIGH>;
>> +			dma-channels = <12>;
>> +			dma-channel-mask = <0x3f>;
>> +			iommus = <&apps_smmu 0xf6 0x0>;
>> +		};
>> +
>> +		qupv3_id_0: geniqup@9c0000 {
>> +			compatible = "qcom,geni-se-qup";
>> +			reg = <0x0 0x9c0000 0x0 0x2000>;
>> +			clocks = <&gcc GCC_QUPV3_WRAP_0_M_AHB_CLK>,
>> +				<&gcc GCC_QUPV3_WRAP_0_S_AHB_CLK>;
>> +			clock-names = "m-ahb", "s-ahb";
>> +			iommus = <&apps_smmu 0xe3 0x0>;
>> +			interconnects = <&clk_virt MASTER_QUP_CORE_0 0
>> +					 &clk_virt SLAVE_QUP_CORE_0 0>;
>> +			interconnect-names = "qup-core";
>> +
>> +			#address-cells = <2>;
>> +			#size-cells = <2>;
>> +			ranges;
>> +			status = "disabled";
>> +
>> +			uart0: serial@980000 {
>> +				compatible = "qcom,geni-uart";
>> +				reg = <0x0 0x980000 0x0 0x4000>;
>> +				clock-names = "se";
>> +				clocks = <&gcc GCC_QUPV3_WRAP0_S0_CLK>;
>> +				pinctrl-names = "default";
>> +				pinctrl-0 = <&qup_uart0_default>;
>> +				interrupts = <GIC_SPI 601 IRQ_TYPE_LEVEL_HIGH>;
>> +				#address-cells = <1>;
>> +				#size-cells = <0>;
>> +				status = "disabled";
>> +			};
>> +
>> +			i2c1: i2c@984000 {
>> +				compatible = "qcom,geni-i2c";
>> +				reg = <0x0 0x984000 0x0 0x4000>;
>> +				clock-names = "se";
>> +				clocks = <&gcc GCC_QUPV3_WRAP0_S1_CLK>;
>> +				interrupts = <GIC_SPI 602 IRQ_TYPE_LEVEL_HIGH>;
>> +				pinctrl-names = "default";
>> +				pinctrl-0 = <&qup_i2c1_data_clk>;
>> +				#address-cells = <1>;
>> +				#size-cells = <0>;
>> +				status = "disabled";
>> +			};
>> +
>> +			spi1: spi@984000 {
>> +				compatible = "qcom,geni-spi";
>> +				reg = <0x0 0x984000 0x0 0x4000>;
>> +				#address-cells = <1>;
>> +				#size-cells = <0>;
>> +				interrupts = <GIC_SPI 602 IRQ_TYPE_LEVEL_HIGH>;
>> +				clock-names = "se";
>> +				clocks = <&gcc GCC_QUPV3_WRAP0_S1_CLK>;
>> +				pinctrl-names = "default";
>> +				pinctrl-0 = <&qup_spi1_data_clk>, <&qup_spi1_cs>;
>> +				status = "disabled";
>> +			};
>> +
>> +			i2c2: i2c@988000 {
>> +				compatible = "qcom,geni-i2c";
>> +				reg = <0x0 0x988000 0x0 0x4000>;
>> +				clock-names = "se";
>> +				clocks = <&gcc GCC_QUPV3_WRAP0_S2_CLK>;
>> +				interrupts = <GIC_SPI 603 IRQ_TYPE_LEVEL_HIGH>;
>> +				pinctrl-names = "default";
>> +				pinctrl-0 = <&qup_i2c2_data_clk>;
>> +				#address-cells = <1>;
>> +				#size-cells = <0>;
>> +				status = "disabled";
>> +			};
>> +
>> +			spi2: spi@988000 {
>> +				compatible = "qcom,geni-spi";
>> +				reg = <0x0 0x988000 0x0 0x4000>;
>> +				#address-cells = <1>;
>> +				#size-cells = <0>;
>> +				interrupts = <GIC_SPI 603 IRQ_TYPE_LEVEL_HIGH>;
>> +				clock-names = "se";
>> +				clocks = <&gcc GCC_QUPV3_WRAP0_S2_CLK>;
>> +				pinctrl-names = "default";
>> +				pinctrl-0 = <&qup_spi2_data_clk>, <&qup_spi2_cs>;
>> +				status = "disabled";
>> +			};
>> +
>> +			i2c3: i2c@98c000 {
>> +				compatible = "qcom,geni-i2c";
>> +				reg = <0x0 0x98c000 0x0 0x4000>;
>> +				clock-names = "se";
>> +				clocks = <&gcc GCC_QUPV3_WRAP0_S3_CLK>;
>> +				interrupts = <GIC_SPI 604 IRQ_TYPE_LEVEL_HIGH>;
>> +				pinctrl-names = "default";
>> +				pinctrl-0 = <&qup_i2c3_data_clk>;
>> +				#address-cells = <1>;
>> +				#size-cells = <0>;
>> +				status = "disabled";
>> +			};
>> +
>> +			spi3: spi@98c000 {
>> +				compatible = "qcom,geni-spi";
>> +				reg = <0x0 0x98c000 0x0 0x4000>;
>> +				#address-cells = <1>;
>> +				#size-cells = <0>;
>> +				interrupts = <GIC_SPI 604 IRQ_TYPE_LEVEL_HIGH>;
>> +				clock-names = "se";
>> +				clocks = <&gcc GCC_QUPV3_WRAP0_S3_CLK>;
>> +				pinctrl-names = "default";
>> +				pinctrl-0 = <&qup_spi3_data_clk>, <&qup_spi3_cs>;
>> +				status = "disabled";
>> +			};
>> +
>> +			i2c4: i2c@990000 {
>> +				compatible = "qcom,geni-i2c";
>> +				reg = <0x0 0x990000 0x0 0x4000>;
>> +				clock-names = "se";
>> +				clocks = <&gcc GCC_QUPV3_WRAP0_S4_CLK>;
>> +				interrupts = <GIC_SPI 605 IRQ_TYPE_LEVEL_HIGH>;
>> +				pinctrl-names = "default";
>> +				pinctrl-0 = <&qup_i2c4_data_clk>;
>> +				#address-cells = <1>;
>> +				#size-cells = <0>;
>> +				status = "disabled";
>> +			};
>> +
>> +			spi4: spi@990000 {
>> +				compatible = "qcom,geni-spi";
>> +				reg = <0x0 0x990000 0x0 0x4000>;
>> +				#address-cells = <1>;
>> +				#size-cells = <0>;
>> +				interrupts = <GIC_SPI 605 IRQ_TYPE_LEVEL_HIGH>;
>> +				clock-names = "se";
>> +				clocks = <&gcc GCC_QUPV3_WRAP0_S4_CLK>;
>> +				pinctrl-names = "default";
>> +				pinctrl-0 = <&qup_spi4_data_clk>, <&qup_spi4_cs>;
>> +				status = "disabled";
>> +			};
>> +
>> +			i2c5: i2c@994000 {
>> +				compatible = "qcom,geni-i2c";
>> +				reg = <0x0 0x994000 0x0 0x4000>;
>> +				clock-names = "se";
>> +				clocks = <&gcc GCC_QUPV3_WRAP0_S5_CLK>;
>> +				interrupts = <GIC_SPI 606 IRQ_TYPE_LEVEL_HIGH>;
>> +				pinctrl-names = "default";
>> +				pinctrl-0 = <&qup_i2c5_data_clk>;
>> +				#address-cells = <1>;
>> +				#size-cells = <0>;
>> +				status = "disabled";
>> +			};
>> +
>> +			spi5: spi@994000 {
>> +				compatible = "qcom,geni-spi";
>> +				reg = <0x0 0x994000 0x0 0x4000>;
>> +				#address-cells = <1>;
>> +				#size-cells = <0>;
>> +				interrupts = <GIC_SPI 606 IRQ_TYPE_LEVEL_HIGH>;
>> +				clock-names = "se";
>> +				clocks = <&gcc GCC_QUPV3_WRAP0_S5_CLK>;
>> +				pinctrl-names = "default";
>> +				pinctrl-0 = <&qup_spi5_data_clk>, <&qup_spi5_cs>;
>> +				status = "disabled";
>> +			};
>> +
>> +			i2c6: i2c@998000 {
>> +				compatible = "qcom,geni-i2c";
>> +				reg = <0x0 0x998000 0x0 0x4000>;
>> +				clock-names = "se";
>> +				clocks = <&gcc GCC_QUPV3_WRAP0_S6_CLK>;
>> +				interrupts = <GIC_SPI 607 IRQ_TYPE_LEVEL_HIGH>;
>> +				pinctrl-names = "default";
>> +				pinctrl-0 = <&qup_i2c6_data_clk>;
>> +				#address-cells = <1>;
>> +				#size-cells = <0>;
>> +				status = "disabled";
>> +			};
>> +
>> +			spi6: spi@998000 {
>> +				compatible = "qcom,geni-spi";
>> +				reg = <0x0 0x998000 0x0 0x4000>;
>> +				#address-cells = <1>;
>> +				#size-cells = <0>;
>> +				interrupts = <GIC_SPI 607 IRQ_TYPE_LEVEL_HIGH>;
>> +				clock-names = "se";
>> +				clocks = <&gcc GCC_QUPV3_WRAP0_S6_CLK>;
>> +				pinctrl-names = "default";
>> +				pinctrl-0 = <&qup_spi6_data_clk>, <&qup_spi6_cs>;
>> +				status = "disabled";
>> +			};
>> +
>> +			uart7: serial@99c000 {
>> +				compatible = "qcom,geni-debug-uart";
>> +				reg = <0x0 0x99c000 0x0 0x4000>;
>> +				clock-names = "se";
>> +				clocks = <&gcc GCC_QUPV3_WRAP0_S7_CLK>;
>> +				pinctrl-names = "default";
>> +				pinctrl-0 = <&qup_uart7_tx>, <&qup_uart7_rx>;
>> +				interrupts = <GIC_SPI 608 IRQ_TYPE_LEVEL_HIGH>;
>> +				#address-cells = <1>;
>> +				#size-cells = <0>;
>> +				status = "disabled";
>> +			};
>> +		};
>> +
>> +		gpi_dma1: dma-controller@a00000  {
>> +			compatible = "qcom,qdu1000-gpi-dma", "qcom,sm6350-gpi-dma";
>> +			#dma-cells = <3>;
>> +			reg = <0x0 0xa00000 0x0 0x60000>;
>> +			interrupts = <GIC_SPI 279 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 280 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 281 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 282 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 283 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 284 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 293 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 294 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 295 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 296 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 297 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 298 IRQ_TYPE_LEVEL_HIGH>;
>> +			dma-channels = <12>;
>> +			dma-channel-mask = <0x3f>;
>> +			iommus = <&apps_smmu 0x116 0x0>;
>> +		};
>> +
>> +		qupv3_id_1: geniqup@ac0000 {
>> +			compatible = "qcom,geni-se-qup";
>> +			reg = <0x0 0xac0000 0x0 0x2000>;
>> +			clocks = <&gcc GCC_QUPV3_WRAP_1_M_AHB_CLK>,
>> +				<&gcc GCC_QUPV3_WRAP_1_S_AHB_CLK>;
>> +			clock-names = "m-ahb", "s-ahb";
>> +			iommus = <&apps_smmu 0x103 0x0>;
>> +			#address-cells = <2>;
>> +			#size-cells = <2>;
>> +
>> +			ranges;
>> +			status = "disabled";
>> +
>> +			uart8: serial@a80000 {
>> +				compatible = "qcom,geni-uart";
>> +				reg = <0x0 0xa80000 0x0 0x4000>;
>> +				clock-names = "se";
>> +				clocks = <&gcc GCC_QUPV3_WRAP1_S0_CLK>;
>> +				pinctrl-names = "default";
>> +				pinctrl-0 = <&qup_uart8_default>;
>> +				interrupts = <GIC_SPI 353 IRQ_TYPE_LEVEL_HIGH>;
>> +				#address-cells = <1>;
>> +				#size-cells = <0>;
>> +				status = "disabled";
>> +			};
>> +
>> +			i2c9: i2c@a84000 {
>> +				compatible = "qcom,geni-i2c";
>> +				reg = <0x0 0xa84000 0x0 0x4000>;
>> +				clock-names = "se";
>> +				clocks = <&gcc GCC_QUPV3_WRAP1_S1_CLK>;
>> +				interrupts = <GIC_SPI 354 IRQ_TYPE_LEVEL_HIGH>;
>> +				pinctrl-names = "default";
>> +				pinctrl-0 = <&qup_i2c9_data_clk>;
>> +				#address-cells = <1>;
>> +				#size-cells = <0>;
>> +				status = "disabled";
>> +			};
>> +
>> +			spi9: spi@a84000 {
>> +				compatible = "qcom,geni-spi";
>> +				reg = <0x0 0xa84000 0x0 0x4000>;
>> +				#address-cells = <1>;
>> +				#size-cells = <0>;
>> +				interrupts = <GIC_SPI 354 IRQ_TYPE_LEVEL_HIGH>;
>> +				clock-names = "se";
>> +				clocks = <&gcc GCC_QUPV3_WRAP1_S1_CLK>;
>> +				pinctrl-names = "default";
>> +				pinctrl-0 = <&qup_spi9_data_clk>, <&qup_spi9_cs>;
>> +				status = "disabled";
>> +			};
>> +
>> +			i2c10: i2c@a88000 {
>> +				compatible = "qcom,geni-i2c";
>> +				reg = <0x0 0xa88000 0x0 0x4000>;
>> +				clock-names = "se";
>> +				clocks = <&gcc GCC_QUPV3_WRAP1_S2_CLK>;
>> +				interrupts = <GIC_SPI 355 IRQ_TYPE_LEVEL_HIGH>;
>> +				pinctrl-names = "default";
>> +				pinctrl-0 = <&qup_i2c10_data_clk>;
>> +				#address-cells = <1>;
>> +				#size-cells = <0>;
>> +				status = "disabled";
>> +			};
>> +
>> +			spi10: spi@a88000 {
>> +				compatible = "qcom,geni-spi";
>> +				reg = <0x0 0xa88000 0x0 0x4000>;
>> +				#address-cells = <1>;
>> +				#size-cells = <0>;
>> +				interrupts = <GIC_SPI 355 IRQ_TYPE_LEVEL_HIGH>;
>> +				clock-names = "se";
>> +				clocks = <&gcc GCC_QUPV3_WRAP1_S2_CLK>;
>> +				pinctrl-names = "default";
>> +				pinctrl-0 = <&qup_spi10_data_clk>, <&qup_spi10_cs>;
>> +				status = "disabled";
>> +			};
>> +
>> +			i2c11: i2c@a8c000 {
>> +				compatible = "qcom,geni-i2c";
>> +				reg = <0x0 0xa8c000 0x0 0x4000>;
>> +				clock-names = "se";
>> +				clocks = <&gcc GCC_QUPV3_WRAP1_S3_CLK>;
>> +				interrupts = <GIC_SPI 356 IRQ_TYPE_LEVEL_HIGH>;
>> +				pinctrl-names = "default";
>> +				pinctrl-0 = <&qup_i2c11_data_clk>;
>> +				#address-cells = <1>;
>> +				#size-cells = <0>;
>> +				status = "disabled";
>> +			};
>> +
>> +			spi11: spi@a8c000 {
>> +				compatible = "qcom,geni-spi";
>> +				reg = <0x0 0xa8c000 0x0 0x4000>;
>> +				#address-cells = <1>;
>> +				#size-cells = <0>;
>> +				interrupts = <GIC_SPI 356 IRQ_TYPE_LEVEL_HIGH>;
>> +				clock-names = "se";
>> +				clocks = <&gcc GCC_QUPV3_WRAP1_S3_CLK>;
>> +				pinctrl-names = "default";
>> +				pinctrl-0 = <&qup_spi11_data_clk>, <&qup_spi11_cs>;
>> +				status = "disabled";
>> +			};
>> +
>> +			i2c12: i2c@a90000 {
>> +				compatible = "qcom,geni-i2c";
>> +				reg = <0x0 0xa90000 0x0 0x4000>;
>> +				clock-names = "se";
>> +				clocks = <&gcc GCC_QUPV3_WRAP1_S4_CLK>;
>> +				interrupts = <GIC_SPI 357 IRQ_TYPE_LEVEL_HIGH>;
>> +				pinctrl-names = "default";
>> +				pinctrl-0 = <&qup_i2c12_data_clk>;
>> +				#address-cells = <1>;
>> +				#size-cells = <0>;
>> +				status = "disabled";
>> +			};
>> +
>> +			spi12: spi@a90000 {
>> +				compatible = "qcom,geni-spi";
>> +				reg = <0x0 0xa90000 0x0 0x4000>;
>> +				#address-cells = <1>;
>> +				#size-cells = <0>;
>> +				interrupts = <GIC_SPI 357 IRQ_TYPE_LEVEL_HIGH>;
>> +				clock-names = "se";
>> +				clocks = <&gcc GCC_QUPV3_WRAP1_S4_CLK>;
>> +				pinctrl-names = "default";
>> +				pinctrl-0 = <&qup_spi12_data_clk>, <&qup_spi12_cs>;
>> +				status = "disabled";
>> +			};
>> +
>> +			i2c13: i2c@a94000 {
>> +				compatible = "qcom,geni-i2c";
>> +				reg = <0x0 0xa94000 0x0 0x4000>;
>> +				clock-names = "se";
>> +				clocks = <&gcc GCC_QUPV3_WRAP1_S5_CLK>;
>> +				interrupts = <GIC_SPI 358 IRQ_TYPE_LEVEL_HIGH>;
>> +				pinctrl-names = "default";
>> +				pinctrl-0 = <&qup_i2c13_data_clk>;
>> +				#address-cells = <1>;
>> +				#size-cells = <0>;
>> +				status = "disabled";
>> +			};
>> +
>> +			uart13: serial@a94000 {
>> +				compatible = "qcom,geni-uart";
>> +				reg = <0x0 0xa94000 0x0 0x4000>;
>> +				clock-names = "se";
>> +				clocks = <&gcc GCC_QUPV3_WRAP1_S5_CLK>;
>> +				pinctrl-names = "default";
>> +				pinctrl-0 = <&qup_uart13_default>;
>> +				interrupts = <GIC_SPI 358 IRQ_TYPE_LEVEL_HIGH>;
>> +				#address-cells = <1>;
>> +				#size-cells = <0>;
>> +				status = "disabled";
>> +			};
>> +
>> +			spi13: spi@a94000 {
>> +				compatible = "qcom,geni-spi";
>> +				reg = <0x0 0xa94000 0x0 0x4000>;
>> +				#address-cells = <1>;
>> +				#size-cells = <0>;
>> +				interrupts = <GIC_SPI 358 IRQ_TYPE_LEVEL_HIGH>;
>> +				clock-names = "se";
>> +				clocks = <&gcc GCC_QUPV3_WRAP1_S5_CLK>;
>> +				pinctrl-names = "default";
>> +				pinctrl-0 = <&qup_spi13_data_clk>, <&qup_spi13_cs>;
>> +				status = "disabled";
>> +			};
>> +
>> +			i2c14: i2c@a98000 {
>> +				compatible = "qcom,geni-i2c";
>> +				reg = <0x0 0xa98000 0x0 0x4000>;
>> +				clock-names = "se";
>> +				clocks = <&gcc GCC_QUPV3_WRAP1_S6_CLK>;
>> +				interrupts = <GIC_SPI 363 IRQ_TYPE_LEVEL_HIGH>;
>> +				pinctrl-names = "default";
>> +				pinctrl-0 = <&qup_i2c14_data_clk>;
>> +				#address-cells = <1>;
>> +				#size-cells = <0>;
>> +				status = "disabled";
>> +			};
>> +
>> +			spi14: spi@a98000 {
>> +				compatible = "qcom,geni-spi";
>> +				reg = <0x0 0xa98000 0x0 0x4000>;
>> +				#address-cells = <1>;
>> +				#size-cells = <0>;
>> +				interrupts = <GIC_SPI 363 IRQ_TYPE_LEVEL_HIGH>;
>> +				clock-names = "se";
>> +				clocks = <&gcc GCC_QUPV3_WRAP1_S6_CLK>;
>> +				pinctrl-names = "default";
>> +				pinctrl-0 = <&qup_spi14_data_clk>, <&qup_spi14_cs>;
>> +				status = "disabled";
>> +			};
>> +
>> +			i2c15: i2c@a9c000 {
>> +				compatible = "qcom,geni-i2c";
>> +				reg = <0x0 0xa9c000 0x0 0x4000>;
>> +				clock-names = "se";
>> +				clocks = <&gcc GCC_QUPV3_WRAP1_S7_CLK>;
>> +				interrupts = <GIC_SPI 365 IRQ_TYPE_LEVEL_HIGH>;
>> +				pinctrl-0 = <&qup_i2c15_data_clk>;
>> +				#address-cells = <1>;
>> +				#size-cells = <0>;
>> +				status = "disabled";
>> +			};
>> +
>> +			spi15: spi@a9c000 {
>> +				compatible = "qcom,geni-spi";
>> +				reg = <0x0 0xa9c000 0x0 0x4000>;
>> +				#address-cells = <1>;
>> +				#size-cells = <0>;
>> +				interrupts = <GIC_SPI 365 IRQ_TYPE_LEVEL_HIGH>;
>> +				clock-names = "se";
>> +				clocks = <&gcc GCC_QUPV3_WRAP1_S7_CLK>;
>> +				pinctrl-names = "default";
>> +				pinctrl-0 = <&qup_spi15_data_clk>, <&qup_spi15_cs>;
>> +				status = "disabled";
>> +			};
>> +		};
>> +
>> +		system_noc: interconnect@1640000 {
>> +			reg = <0x0 0x1640000 0x0 0x45080>;
>> +			compatible = "qcom,qdu1000-system-noc";
>> +			#interconnect-cells = <2>;
>> +			qcom,bcm-voters = <&apps_bcm_voter>;
>> +		};
>> +
>> +		tcsr_mutex: hwlock@1f40000 {
>> +			compatible = "qcom,tcsr-mutex";
>> +			reg = <0x0 0x1f40000 0x0 0x20000>;
>> +			#hwlock-cells = <1>;
>> +		};
>> +
>> +		pdc: interrupt-controller@b220000 {
>> +			compatible = "qcom,qdu1000-pdc", "qcom,pdc";
>> +			reg = <0x0 0xb220000 0x0 0x30000>, <0x0 0x174000f0 0x0 0x64>;
>> +			qcom,pdc-ranges = <0 480 12>, <14 494 24>, <40 520 54>,
>> +					  <94 609 31>, <125 63 1>;
>> +			#interrupt-cells = <2>;
>> +			interrupt-parent = <&intc>;
>> +			interrupt-controller;
>> +		};
>> +
>> +		spmi_bus: spmi@c400000 {
>> +			compatible = "qcom,spmi-pmic-arb";
>> +			reg = <0x0 0xc400000 0x0 0x3000>,
>> +			      <0x0 0xc500000 0x0 0x400000>,
>> +			      <0x0 0xc440000 0x0 0x80000>,
>> +			      <0x0 0xc4c0000 0x0 0x10000>,
>> +			      <0x0 0xc42d000 0x0 0x4000>;
>> +			reg-names = "core", "chnls", "obsrvr", "intr", "cnfg";
>> +			interrupt-names = "periph_irq";
>> +			interrupts-extended = <&pdc 1 IRQ_TYPE_LEVEL_HIGH>;
>> +			qcom,ee = <0>;
>> +			qcom,channel = <0>;
>> +			#address-cells = <2>;
>> +			#size-cells = <0>;
>> +			interrupt-controller;
>> +			#interrupt-cells = <4>;
>> +		};
>> +
>> +		tlmm: pinctrl@f000000 {
>> +			compatible = "qcom,qdu1000-tlmm";
>> +			reg = <0x0 0xf000000 0x0 0x1000000>;
>> +			interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
>> +			gpio-controller;
>> +			#gpio-cells = <2>;
>> +			interrupt-controller;
>> +			#interrupt-cells = <2>;
>> +			gpio-ranges = <&tlmm 0 0 151>;
>> +			wakeup-parent = <&pdc>;
>> +
>> +			qup_uart0_default: qup-uart0-default-state {
>> +				pins = "gpio6", "gpio7", "gpio8", "gpio9";
>> +				function = "qup00";
>> +			};
>> +
>> +			qup_i2c1_data_clk: qup-i2c1-data-clk-state {
>> +				pins = "gpio10", "gpio11";
>> +				function = "qup01";
>> +				drive-strength = <2>;
>> +				bias-pull-up;
>> +			};
>> +
>> +			qup_spi1_data_clk: qup-spi1-data-clk-state {
>> +				pins = "gpio10", "gpio11", "gpio12";
>> +				function = "qup01";
>> +				drive-strength = <6>;
>> +				bias-disable;
>> +			};
>> +
>> +			qup_spi1_cs: qup-spi1-cs-state {
>> +				pins = "gpio13";
>> +				drive-strength = <6>;
>> +				bias-disable;
>> +			};
>> +
>> +			qup_i2c2_data_clk: qup-i2c2-data-clk-state {
>> +				pins = "gpio12", "gpio13";
>> +				function = "qup02";
>> +				drive-strength = <2>;
>> +				bias-pull-up;
>> +			};
>> +
>> +			qup_spi2_data_clk: qup-spi2-data-clk-state {
>> +				pins = "gpio12", "gpio13", "gpio10";
>> +				function = "qup02";
>> +				drive-strength = <6>;
>> +				bias-disable;
>> +			};
>> +
>> +			qup_spi2_cs: qup-spi2-cs-state {
>> +				pins = "gpio11";
>> +				drive-strength = <6>;
>> +				bias-disable;
>> +			};
>> +
>> +			qup_i2c3_data_clk: qup-i2c3-data-clk-state {
>> +				pins = "gpio14", "gpio15";
>> +				function = "qup03";
>> +				drive-strength = <2>;
>> +				bias-pull-up;
>> +			};
>> +
>> +			qup_spi3_data_clk: qup-spi3-data-clk-state {
>> +				pins = "gpio14", "gpio15", "gpio16";
>> +				function = "qup03";
>> +				drive-strength = <6>;
>> +				bias-disable;
>> +			};
>> +
>> +			qup_spi3_cs: qup-spi3-cs-state {
>> +				pins = "gpio17";
>> +				drive-strength = <6>;
>> +				bias-disable;
>> +			};
>> +
>> +			qup_i2c4_data_clk: qup-i2c4-data-clk-state {
>> +				pins = "gpio16", "gpio17";
>> +				function = "qup04";
>> +				drive-strength = <2>;
>> +				bias-pull-up;
>> +			};
>> +
>> +			qup_spi4_data_clk: qup-spi4-data-clk-state {
>> +				pins = "gpio16", "gpio17", "gpio14";
>> +				function = "qup04";
>> +				drive-strength = <6>;
>> +				bias-disable;
>> +			};
>> +
>> +			qup_spi4_cs: qup-spi4-cs-state {
>> +				pins = "gpio15";
>> +				drive-strength = <6>;
>> +				bias-disable;
>> +			};
>> +
>> +			qup_i2c5_data_clk: qup-i2c5-data-clk-state {
>> +				pins = "gpio130", "gpio131";
>> +				function = "qup05";
>> +				drive-strength = <2>;
>> +				bias-pull-up;
>> +			};
>> +
>> +			qup_spi5_data_clk: qup-spi5-data-clk-state {
>> +				pins = "gpio130", "gpio131", "gpio132";
>> +				function = "qup05";
>> +				drive-strength = <6>;
>> +				bias-disable;
>> +			};
>> +
>> +			qup_spi5_cs: qup-spi5-cs-state {
>> +				pins = "gpio133";
>> +				drive-strength = <6>;
>> +				bias-disable;
>> +			};
>> +
>> +			qup_i2c6_data_clk: qup-i2c6-data-clk-state {
>> +				pins = "gpio132", "gpio133";
>> +				function = "qup06";
>> +				drive-strength = <2>;
>> +				bias-pull-up;
>> +			};
>> +
>> +			qup_spi6_data_clk: qup-spi6-data-clk-state {
>> +				pins = "gpio132", "gpio133", "gpio130";
>> +				function = "qup06";
>> +				drive-strength = <6>;
>> +				bias-disable;
>> +			};
>> +
>> +			qup_spi6_cs: qup-spi6-cs-state {
>> +				pins = "gpio131";
>> +				drive-strength = <6>;
>> +				bias-disable;
>> +			};
>> +
>> +			qup_uart7_rx: qup-uart7-rx-state {
>> +				pins = "gpio135";
>> +				function = "qup07";
>> +				drive-strength = <2>;
>> +				bias-disable;
>> +			};
>> +
>> +			qup_uart7_tx: qup-uart7-tx-state  {
>> +				pins = "gpio134";
>> +				function = "qup07";
>> +				drive-strength = <2>;
>> +				bias-disable;
>> +			};
>> +
>> +			qup_uart8_default: qup-uart8-default-state {
>> +				pins = "gpio18", "gpio19", "gpio20", "gpio21";
>> +				function = "qup10";
>> +			};
>> +
>> +			qup_i2c9_data_clk: qup-i2c9-data-clk-state {
>> +				pins = "gpio22", "gpio23";
>> +				function = "qup11";
>> +				drive-strength = <2>;
>> +				bias-pull-up;
>> +			};
>> +
>> +			qup_spi9_data_clk: qup-spi9-data-clk-state {
>> +				pins = "gpio22", "gpio23", "gpio24";
>> +				function = "qup11";
>> +				drive-strength = <6>;
>> +				bias-disable;
>> +			};
>> +
>> +			qup_spi9_cs: qup-spi9-cs-state {
>> +				pins = "gpio25";
>> +				drive-strength = <6>;
>> +				bias-disable;
>> +			};
>> +
>> +			qup_i2c10_data_clk: qup-i2c10-data-clk-state {
>> +				pins = "gpio24", "gpio25";
>> +				function = "qup12";
>> +				drive-strength = <2>;
>> +				bias-pull-up;
>> +			};
>> +
>> +			qup_spi10_data_clk: qup-spi10-data-clk-state {
>> +				pins = "gpio24", "gpio25", "gpio22";
>> +				function = "qup12";
>> +				drive-strength = <6>;
>> +				bias-disable;
>> +			};
>> +
>> +			qup_spi10_cs: qup-spi10-cs-state {
>> +				pins = "gpio23";
>> +				drive-strength = <6>;
>> +				bias-disable;
>> +			};
>> +
>> +			qup_i2c11_data_clk: qup-i2c11-data-clk-state {
>> +				pins = "gpio26", "gpio27";
>> +				function = "qup13";
>> +				drive-strength = <2>;
>> +				bias-pull-up;
>> +			};
>> +
>> +			qup_spi11_data_clk: qup-spi11-data-clk-state {
>> +				pins = "gpio26", "gpio27", "gpio28";
>> +				function = "qup13";
>> +				drive-strength = <6>;
>> +				bias-disable;
>> +			};
>> +
>> +			qup_spi11_cs: qup-spi11-cs-state {
>> +				pins = "gpio29";
>> +				drive-strength = <6>;
>> +				bias-disable;
>> +			};
>> +
>> +			qup_i2c12_data_clk: qup-i2c12-data-clk-state {
>> +				pins = "gpio28", "gpio29";
>> +				function = "qup14";
>> +				drive-strength = <2>;
>> +				bias-pull-up;
>> +			};
>> +
>> +			qup_spi12_data_clk: qup-spi12-data-clk-state {
>> +				pins = "gpio28", "gpio29", "gpio26";
>> +				function = "qup14";
>> +				drive-strength = <6>;
>> +				bias-disable;
>> +			};
>> +
>> +			qup_spi12_cs: qup-spi12-cs-state {
>> +				pins = "gpio27";
>> +				drive-strength = <6>;
>> +				bias-disable;
>> +			};
>> +
>> +			qup_i2c13_data_clk: qup-i2c13-data-clk-state {
>> +				pins = "gpio30", "gpio31";
>> +				function = "qup15";
>> +				drive-strength = <2>;
>> +				bias-pull-up;
>> +			};
>> +
>> +			qup_spi13_data_clk: qup-spi13-data-clk-state {
>> +				pins = "gpio30", "gpio31", "gpio32";
>> +				function = "qup15";
>> +				drive-strength = <6>;
>> +				bias-disable;
>> +			};
>> +
>> +			qup_spi13_cs: qup-spi13-cs-state {
>> +				pins = "gpio33";
>> +				drive-strength = <6>;
>> +				bias-disable;
>> +			};
>> +
>> +			qup_uart13_default: qup-uart13-default-state {
>> +				pins = "gpio30", "gpio31", "gpio32", "gpio33";
>> +				function = "qup15";
>> +			};
>> +
>> +			qup_i2c14_data_clk: qup-i2c14-data-clk-state {
>> +				pins = "gpio34", "gpio35";
>> +				function = "qup16";
>> +				drive-strength = <2>;
>> +				bias-pull-up;
>> +			};
>> +
>> +			qup_spi14_data_clk: qup-spi14-data-clk-state {
>> +				pins = "gpio34", "gpio35", "gpio36";
>> +				function = "qup16";
>> +				drive-strength = <6>;
>> +				bias-disable;
>> +			};
>> +
>> +			qup_spi14_cs: qup-spi14-cs-state {
>> +				pins = "gpio37", "gpio38";
>> +				drive-strength = <6>;
>> +				bias-disable;
>> +			};
>> +
>> +			qup_i2c15_data_clk: qup-i2c15-data-clk-state {
>> +				pins = "gpio40", "gpio41";
>> +				function = "qup17";
>> +				drive-strength = <2>;
>> +				bias-pull-up;
>> +			};
>> +
>> +			qup_spi15_data_clk: qup-spi15-data-clk-state {
>> +				pins = "gpio40", "gpio41", "gpio30";
>> +				function = "qup17";
>> +				drive-strength = <6>;
>> +				bias-disable;
>> +			};
>> +
>> +			qup_spi15_cs: qup-spi15-cs-state {
>> +				pins = "gpio31";
>> +				drive-strength = <6>;
>> +				bias-disable;
>> +			};
>> +		};
>> +
>> +		apps_smmu: iommu@15000000 {
>> +			compatible = "qcom,qdu1000-smmu-500", "arm,mmu-500";
>> +			reg = <0x0 0x15000000 0x0 0x100000>;
>> +			#iommu-cells = <2>;
>> +			#global-interrupts = <2>;
>> +			interrupts =	<GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>,
>> +					<GIC_SPI 426 IRQ_TYPE_LEVEL_HIGH>,
>> +					<GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>,
>> +					<GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>,
>> +					<GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>,
>> +					<GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>,
>> +					<GIC_SPI 671 IRQ_TYPE_LEVEL_HIGH>,
>> +					<GIC_SPI 672 IRQ_TYPE_LEVEL_HIGH>,
>> +					<GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>,
>> +					<GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>,
>> +					<GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>,
>> +					<GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>,
>> +					<GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>,
>> +					<GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>,
>> +					<GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>,
>> +					<GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>,
>> +					<GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>,
>> +					<GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>,
>> +					<GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>,
>> +					<GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>,
>> +					<GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>,
>> +					<GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>,
>> +					<GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>,
>> +					<GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>,
>> +					<GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>,
>> +					<GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>,
>> +					<GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>,
>> +					<GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>,
>> +					<GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>,
>> +					<GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>,
>> +					<GIC_SPI 181 IRQ_TYPE_LEVEL_HIGH>,
>> +					<GIC_SPI 182 IRQ_TYPE_LEVEL_HIGH>,
>> +					<GIC_SPI 183 IRQ_TYPE_LEVEL_HIGH>,
>> +					<GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>,
>> +					<GIC_SPI 185 IRQ_TYPE_LEVEL_HIGH>,
>> +					<GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH>,
>> +					<GIC_SPI 187 IRQ_TYPE_LEVEL_HIGH>,
>> +					<GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>,
>> +					<GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>,
>> +					<GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>,
>> +					<GIC_SPI 191 IRQ_TYPE_LEVEL_HIGH>,
>> +					<GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>,
>> +					<GIC_SPI 315 IRQ_TYPE_LEVEL_HIGH>,
>> +					<GIC_SPI 316 IRQ_TYPE_LEVEL_HIGH>,
>> +					<GIC_SPI 317 IRQ_TYPE_LEVEL_HIGH>,
>> +					<GIC_SPI 318 IRQ_TYPE_LEVEL_HIGH>,
>> +					<GIC_SPI 319 IRQ_TYPE_LEVEL_HIGH>,
>> +					<GIC_SPI 320 IRQ_TYPE_LEVEL_HIGH>,
>> +					<GIC_SPI 321 IRQ_TYPE_LEVEL_HIGH>;
>> +		};
>> +
>> +		intc: interrupt-controller@17200000 {
>> +			compatible = "arm,gic-v3";
>> +			#interrupt-cells = <3>;
>> +			interrupt-controller;
>> +			#redistributor-regions = <1>;
>> +			redistributor-stride = <0x0 0x20000>;
>> +			reg = <0x0 0x17200000 0x0 0x10000>,	/* GICD */
>> +			      <0x0 0x17260000 0x0 0x80000>;	/* GICR * 4 */
> compatible and reg should go first.

Ack.

>> +			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_LOW>;
>> +		};
>> +
>> +		timer@17420000 {
>> +			compatible = "arm,armv7-timer-mem";
>> +			#address-cells = <1>;
>> +			#size-cells = <1>;
>> +			ranges;
>> +			reg = <0x0 0x17420000 0x0 0x1000>;
> compatible and reg should go first.

Ack.

>> +			clock-frequency = <19200000>;
> This should be removed if not necessary (on qcom CNTFRQ_ELn is
> configured earlier, anyway).
>
>
>> +
>> +			frame@17421000 {
>> +				frame-number = <0>;
>> +				interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
>> +					     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
>> +				reg = <0x17421000 0x1000>,
>> +				      <0x17422000 0x1000>;
> Please move reg up, in all subnodes.

Ack.

>
>
>> +			};
>> +
>> +			frame@17423000 {
>> +				frame-number = <1>;
>> +				interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
>> +				reg = <0x17423000 0x1000>;
>> +				status = "disabled";
>> +			};
>> +
>> +			frame@17425000 {
>> +				frame-number = <2>;
>> +				interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
>> +				reg = <0x17425000 0x1000>,
>> +				      <0x17426000 0x1000>;
>> +				status = "disabled";
>> +			};
>> +
>> +			frame@17427000 {
>> +				frame-number = <3>;
>> +				interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
>> +				reg = <0x17427000 0x1000>;
>> +				status = "disabled";
>> +			};
>> +
>> +			frame@17429000 {
>> +				frame-number = <4>;
>> +				interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
>> +				reg = <0x17429000 0x1000>;
>> +				status = "disabled";
>> +			};
>> +
>> +			frame@1742b000 {
>> +				frame-number = <5>;
>> +				interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
>> +				reg = <0x1742b000 0x1000>;
>> +				status = "disabled";
>> +			};
>> +
>> +			frame@1742d000 {
>> +				frame-number = <6>;
>> +				interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
>> +				reg = <0x1742d000 0x1000>;
>> +				status = "disabled";
>> +			};
>> +		};
>> +
>> +		apps_rsc: rsc@17a00000 {
>> +			compatible = "qcom,rpmh-rsc";
>> +			reg = <0x0 0x17a00000 0x0 0x10000>,
>> +			      <0x0 0x17a10000 0x0 0x10000>,
>> +			      <0x0 0x17a20000 0x0 0x10000>;
>> +			reg-names = "drv-0", "drv-1", "drv-2";
>> +			interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
>> +			qcom,tcs-offset = <0xd00>;
>> +			qcom,drv-id = <2>;
>> +			qcom,tcs-config = <ACTIVE_TCS    2>, <SLEEP_TCS     3>,
>> +					  <WAKE_TCS      3>, <CONTROL_TCS   0>;
>> +			label = "apps_rsc";
>> +
>> +			apps_bcm_voter: bcm-voter {
>> +				compatible = "qcom,bcm-voter";
>> +			};
>> +
>> +			rpmhcc: clock-controller {
>> +				compatible = "qcom,qdu1000-rpmh-clk";
>> +				#clock-cells = <1>;
>> +				clock-names = "xo";
>> +				clocks = <&xo_board>;
>> +			};
>> +
>> +			rpmhpd: power-controller {
>> +				compatible = "qcom,qdu1000-rpmhpd";
>> +				#power-domain-cells = <1>;
>> +				operating-points-v2 = <&rpmhpd_opp_table>;
>> +
>> +				rpmhpd_opp_table: opp-table {
>> +					compatible = "operating-points-v2";
>> +
>> +					rpmhpd_opp_ret: opp1 {
>> +						opp-level = <RPMH_REGULATOR_LEVEL_RETENTION>;
>> +					};
>> +
>> +					rpmhpd_opp_min_svs: opp2 {
>> +						opp-level = <RPMH_REGULATOR_LEVEL_MIN_SVS>;
>> +					};
>> +
>> +					rpmhpd_opp_low_svs: opp3 {
>> +						opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS>;
>> +					};
>> +
>> +					rpmhpd_opp_svs: opp4 {
>> +						opp-level = <RPMH_REGULATOR_LEVEL_SVS>;
>> +					};
>> +
>> +					rpmhpd_opp_svs_l1: opp5 {
>> +						opp-level = <RPMH_REGULATOR_LEVEL_SVS_L1>;
>> +					};
>> +
>> +					rpmhpd_opp_nom: opp6 {
>> +						opp-level = <RPMH_REGULATOR_LEVEL_NOM>;
>> +					};
>> +
>> +					rpmhpd_opp_nom_l1: opp7 {
>> +						opp-level = <RPMH_REGULATOR_LEVEL_NOM_L1>;
>> +					};
>> +
>> +					rpmhpd_opp_nom_l2: opp8 {
>> +						opp-level = <RPMH_REGULATOR_LEVEL_NOM_L2>;
>> +					};
>> +
>> +					rpmhpd_opp_turbo: opp9 {
>> +						opp-level = <RPMH_REGULATOR_LEVEL_TURBO>;
>> +					};
>> +
>> +					rpmhpd_opp_turbo_l1: opp10 {
>> +						opp-level = <RPMH_REGULATOR_LEVEL_TURBO_L1>;
>> +					};
>> +				};
>> +			};
>> +		};
>> +
>> +		cpufreq_hw: cpufreq@17d90000 {
>> +			compatible = "qcom,qdu1000-cpufreq-epss", "qcom,cpufreq-epss";
>> +			reg = <0x0 0x17d90000 0x0 0x1000>, <0x0 0x17d91000 0x0 0x1000>;
>> +			reg-names = "freq-domain0", "freq-domain1";
>> +			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GCC_GPLL0>;
>> +			clock-names = "xo", "alternate";
>> +			#freq-domain-cells = <1>;
>> +		};
>> +
>> +		gem_noc: interconnect@19100000 {
>> +			reg = <0x0 0x19100000 0x0 0xB8080>;
>> +			compatible = "qcom,qdu1000-gem-noc";
>> +			#interconnect-cells = <2>;
>> +			qcom,bcm-voters = <&apps_bcm_voter>;
>> +		};
>> +	};
>> +
>> +	arch_timer: timer {
>> +		compatible = "arm,armv8-timer";
>> +		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
>> +			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
>> +			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
>> +			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
>> +			     <GIC_PPI 12 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>;
>> +		clock-frequency = <19200000>;
>> +	};
>> +};
>> diff --git a/arch/arm64/boot/dts/qcom/qru1000.dtsi b/arch/arm64/boot/dts/qcom/qru1000.dtsi
>> new file mode 100644
>> index 000000000000..074fe126e85e
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/qcom/qru1000.dtsi
>> @@ -0,0 +1,27 @@
>> +// SPDX-License-Identifier: BSD-3-Clause
>> +/*
>> + * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
>> + */
>> +
>> +#include "qdu1000.dtsi"
>> +
>> +&reserved_memory {
>> +	/delete-node/ memory@a0000000;
>> +	/delete-node/ memory@b9600000;
>> +	/delete-node/ memory@c0000000;
> Please delete memory nodes by referencing the label, so that
> we don't have to cross-check the files every time.
>
> First DT:
> some_region: something@a0000000 { [...] }
>
>
> Second DT:
> /delete-node/ &some_region;

Sure thing. I was having some issues with this approach earlier,
but seems to be working now.

Thanks,
Melody
>
>
> Konrad
>
>> +
>> +	oem_tenx_mem: memory@a0000000 {
>> +		no-map;
>> +		reg = <0x0 0xa0000000 0x0 0x6400000>;
>> +	};
>> +
>> +	mpss_diag_buffer_mem: memory@aea00000 {
>> +		no-map;
>> +		reg = <0x0 0xaea00000 0x0 0x6400000>;
>> +	};
>> +
>> +	tenx_q6_buffer_mem: memory@b4e00000 {
>> +		no-map;
>> +		reg = <0x0 0xb4e00000 0x0 0x3200000>;
>> +	};
>> +};

