Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40D3B715D8F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 13:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232020AbjE3Llx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 07:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232009AbjE3LlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 07:41:24 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6443BC5;
        Tue, 30 May 2023 04:41:19 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34UAvKrP017680;
        Tue, 30 May 2023 11:40:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=C+1W4yC5tWE+8Yc0UUM/AugePwf0UpR0wu8bWDMYeJ8=;
 b=Jht/QMJDp5J2wluapefC0M+V/u/11OCZ6iYObWsdv83v05xiXb0I6o0UeZMEKLHCY9Kr
 KDEPzPOx/mDhqMLwTMG48bq5P8aulWJh37JOov4vyBX+QS003n7NrjAigCRmgA4w2z3f
 /Pz1BYvmhmbAOx/+BA7YiUpHMymuungNdYqN8vxmVePkDYX4/r6ri/TvapI9y8dsnMKu
 04w/NkyvzdM0jMhPHhMamlh/Tyvhd9NeMriwmyHXKlCVBxicyWSvxTXIGFcSeraocjMp
 3kx5sZK1Cp5tkA/MoOhZm6vmmm6BFLMa/O5jOd3Kk+iv1S8qMRwcQ3aPKZL/DwsUCBMq kA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qvsr22djv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 May 2023 11:40:40 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34UBedJQ029753
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 May 2023 11:40:39 GMT
Received: from [10.214.66.58] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Tue, 30 May
 2023 04:40:34 -0700
Message-ID: <ec664db0-ae0f-5046-25c4-315d0a2c8a3f@quicinc.com>
Date:   Tue, 30 May 2023 17:10:31 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH 5/8] arm64: dts: qcom: Add SDX75 platform and IDP board
 support
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <tglx@linutronix.de>, <maz@kernel.org>, <will@kernel.org>,
        <robin.murphy@arm.com>, <joro@8bytes.org>, <robimarko@gmail.com>,
        <quic_gurus@quicinc.com>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>
References: <1684487350-30476-1-git-send-email-quic_rohiagar@quicinc.com>
 <1684487350-30476-6-git-send-email-quic_rohiagar@quicinc.com>
 <405186ab-46df-fcf1-2894-a08c4b42c069@linaro.org>
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
In-Reply-To: <405186ab-46df-fcf1-2894-a08c4b42c069@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: MdBpNHBErCWz9bwsmzJ9zZmY0sJErEq-
X-Proofpoint-GUID: MdBpNHBErCWz9bwsmzJ9zZmY0sJErEq-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-30_08,2023-05-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=999 priorityscore=1501 spamscore=0
 phishscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305300096
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for reviewing. Sorry for the late reply was on leave.

On 5/19/2023 10:58 PM, Konrad Dybcio wrote:
>
> On 19.05.2023 11:09, Rohit Agarwal wrote:
>> Add basic devicetree support for SDX75 platform and IDP board from
>> Qualcomm. The SDX75 platform features an ARM Cortex A55 CPU which forms
>> the Application Processor Sub System (APSS) along with standard Qualcomm
>> peripherals like GCC, TLMM, UART, QPIC, and BAM etc... Also, there
>> exists the networking parts such as IPA, MHI, PCIE-EP, EMAC, and Modem
>> etc..
>>
>> This commit adds basic devicetree support.
>>
>> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/Makefile      |   1 +
>>   arch/arm64/boot/dts/qcom/sdx75-idp.dts |  19 ++
>>   arch/arm64/boot/dts/qcom/sdx75.dtsi    | 534 +++++++++++++++++++++++++++++++++
>>   3 files changed, 554 insertions(+)
>>   create mode 100644 arch/arm64/boot/dts/qcom/sdx75-idp.dts
>>   create mode 100644 arch/arm64/boot/dts/qcom/sdx75.dtsi
>>
>> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
>> index d42c595..4fd5a18 100644
>> --- a/arch/arm64/boot/dts/qcom/Makefile
>> +++ b/arch/arm64/boot/dts/qcom/Makefile
>> @@ -173,6 +173,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-xiaomi-polaris.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-shift-axolotl.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)	+= sdm850-lenovo-yoga-c630.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)	+= sdm850-samsung-w737.dtb
>> +dtb-$(CONFIG_ARCH_QCOM)	+= sdx75-idp.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)	+= sm4250-oneplus-billie2.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)	+= sm6115p-lenovo-j606f.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)	+= sm6125-sony-xperia-seine-pdx201.dtb
>> diff --git a/arch/arm64/boot/dts/qcom/sdx75-idp.dts b/arch/arm64/boot/dts/qcom/sdx75-idp.dts
>> new file mode 100644
>> index 0000000..e2e803b
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/qcom/sdx75-idp.dts
>> @@ -0,0 +1,19 @@
>> +// SPDX-License-Identifier: BSD-3-Clause
>> +/*
>> + * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
>> + */
>> +
>> +/dts-v1/;
>> +
>> +#include "sdx75.dtsi"
>> +
>> +/ {
>> +	model = "Qualcomm Technologies, Inc. SDX75 IDP";
>> +	compatible = "qcom,sdx75-idp", "qcom,sdx75";
>> +	qcom,board-id = <0x2010022 0x302>;
> You should be able to get by without qcom,{msm,board}-id.
Actually the bootloader requires the msm and board id. Shouldn't this 
become a necessary field then?
>
>> +
>> +};
>> +
>> +&tlmm {
>> +	gpio-reserved-ranges = <110 6>;
>> +};
>> diff --git a/arch/arm64/boot/dts/qcom/sdx75.dtsi b/arch/arm64/boot/dts/qcom/sdx75.dtsi
>> new file mode 100644
>> index 0000000..c2b8810
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/qcom/sdx75.dtsi
>> @@ -0,0 +1,534 @@
>> +// SPDX-License-Identifier: BSD-3-Clause
>> +/*
>> + * SDX75 SoC device tree source
>> + *
>> + * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
>> + *
>> + */
>> +
>> +#include <dt-bindings/clock/qcom,rpmh.h>
>> +#include <dt-bindings/interrupt-controller/arm-gic.h>
>> +#include <dt-bindings/soc/qcom,rpmh-rsc.h>
>> +
>> +/ {
>> +	#address-cells = <2>;
>> +	#size-cells = <2>;
>> +	qcom,msm-id = <556 0x10000>;
>> +	interrupt-parent = <&intc>;
>> +
>> +	chosen: chosen { };
>> +
>> +	memory {
> The memory node should have a unit address.
Sure will update this.
>
>> +		device_type = "memory";
>> +		reg = <0 0 0 0>;
>> +	};
>> +
>> +	clocks { };
>> +
>> +	cpus {
>> +		#address-cells = <2>;
>> +		#size-cells = <0>;
>> +
> [...]
>
>> +
>> +		CLUSTER_PD: power-domain-cpu-cluster0 {
>> +			#power-domain-cells = <0>;
>> +			domain-idle-states = <&CLUSTER_SLEEP_0 &CX_RET &CLUSTER_SLEEP_1>;
> Is CLUSTER_SLEEP_1 deeper than CX retention?
Yes
>
>> +		};
>> +	};
>> +
>> +	firmware {
>> +		scm: scm {
>> +			compatible = "qcom,scm-sdx75", "qcom,scm";
>> +		};
>> +	};
>> +
>> +	pmu {
>> +		compatible = "arm,armv8-pmuv3";
>> +		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>;
>> +	};
>> +
>> +	reserved-memory {
>> +		#address-cells = <2>;
>> +		#size-cells = <2>;
>> +		ranges;
>> +
>> +		gunyah_hyp_mem: memory@80000000 {
> reserved memory subnodes should have meaningful node names, e.g.
>
> hypervisor@800...
Will update this.
>
>> +			reg = <0x0 0x80000000 0x0 0x800000>;
>> +			no-map;
>> +		};
>> +
> [...]
>
>> +
>> +	smem: qcom,smem {
>> +		compatible = "qcom,smem";
>> +		memory-region = <&smem_mem>;
>> +		hwlocks = <&tcsr_mutex 3>;
>> +	};
>> +
>> +	soc: soc {
>> +		#address-cells = <2>;
>> +		#size-cells = <2>;
>> +		ranges;
> Are the SoC buses limited to 32b addresses?
No, Will fix this in the next.
>
>> +		compatible = "simple-bus";
> Compatible should go first.
Yes, Ok.
>> +
>> +		tcsr_mutex: hwlock@1f40000 {
>> +			compatible = "qcom,tcsr-mutex";
>> +			reg = <0x0 0x01f40000 0x0 0x40000>;
>> +			#hwlock-cells = <1>;
>> +		};
>> +
>> +		pdc: interrupt-controller@b220000 {
>> +			compatible = "qcom,sdx75-pdc", "qcom,pdc";
>> +			reg = <0x0 0xb220000 0x0 0x30000>,
>> +			      <0x0 0x174000f0 0x0 0x64>;
>> +			qcom,pdc-ranges = <0 147 52>,
>> +					  <52 266 32>,
>> +					  <84 500 59>;
>> +			#interrupt-cells = <2>;
>> +			interrupt-parent = <&intc>;
>> +			interrupt-controller;
>> +		};
>> +
>> +		tlmm: pinctrl@f000000 {
>> +			compatible = "qcom,sdx75-tlmm";
>> +			reg = <0x0 0x0f000000 0x0 0x400000>;
>> +			interrupts = <GIC_SPI 212 IRQ_TYPE_LEVEL_HIGH>;
>> +			gpio-controller;
>> +			#gpio-cells = <2>;
>> +			gpio-ranges = <&tlmm 0 0 133>;
>> +			interrupt-controller;
>> +			#interrupt-cells = <2>;
>> +			wakeup-parent = <&pdc>;
>> +		};
>> +
>> +		apps_smmu: iommu@15000000 {
>> +			compatible = "qcom,sdx75-smmu-500", "arm,mmu-500";
>> +			reg = <0x0 0x15000000 0x0 0x40000>;
>> +			#iommu-cells = <2>;
>> +			#global-interrupts = <2>;
>> +			interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 298 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 299 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 300 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 301 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 302 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 303 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 304 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 305 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 306 IRQ_TYPE_LEVEL_HIGH>;
> Many newer SoCs have dma-coherent SMMUs. Is this the case here?
Yes, Will add the dma-coherent property here.
>
>> +		};
>> +
>> +		intc: interrupt-controller@17200000 {
>> +			compatible = "arm,gic-v3";
>> +			#interrupt-cells = <3>;
>> +			interrupt-controller;
>> +			#redistributor-regions = <1>;
>> +			redistributor-stride = <0x0 0x20000>;
>> +			reg = <0x0 0x17200000 0x0 0x10000>,
>> +			      <0x0 0x17260000 0x0 0x80000>;
>> +			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
>> +		};
>> +
>> +		timer@17420000 {
>> +			compatible = "arm,armv7-timer-mem";
>> +			#address-cells = <2>;
>> +			#size-cells = <2>;
>> +			ranges;
>> +			reg = <0x0 0x17420000 0x0 0x1000>;
>> +			clock-frequency = <19200000>;
> clock-frequency is discouraged, unless strictly necessary.
>
> Since gh is running, the timer is already programmed so it should be
> fine to drop this.
>
> [...]
>
>> +	timer {
>> +		compatible = "arm,armv8-timer";
>> +		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
>> +			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
>> +			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
>> +			     <GIC_PPI 12 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>;
>> +		clock-frequency = <19200000>;
> Ditto
Ok Thanks for the info. Dropping the clock frequency property in the 
next version.

Thanks,
Rohit.
>
> Konrad
>> +	};
>> +};
