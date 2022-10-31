Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAA11614025
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 22:49:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbiJaVtx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 17:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiJaVtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 17:49:51 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26FC510FD3;
        Mon, 31 Oct 2022 14:49:50 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 29VL55OU016793;
        Mon, 31 Oct 2022 21:49:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=CkhE949TVC0iDdW3/Q+OOK85Q2bDYQ+v7ZIaOAkG96Y=;
 b=HzBf6v2wnUQn/sQsewcAtn3m7cFCzflv+Im7OG4Qq4Ni/skhs46KIimLv/2Ygea5+Teu
 15ADI2W6xKWFiO8WZj4EWeAkOHBctY0fZIAhlGCCwWToONnLp2xXeicKluWK3skWC/8g
 KM7nzqfWfqGtnofVgSzSKZQdGhL5SX7pcKVKzoACCr5Rp89xmQgs2EHRpu7zoWDOVNEQ
 1zmdo8ezAfcZF3TomQElBBVX5oyP2gZ0IivmP6Kth+D24SdPUQ9eWrmVwvQkS3ZxnFZd
 X0oo+OxOiC3bQp4isCXkASmLapv2eu1EHD85MmVQT+LsGmoaf8YqxersoZeeTZv9RjNw jA== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kjj148vpt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Oct 2022 21:49:46 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29VLnkvN003739
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Oct 2022 21:49:46 GMT
Received: from [10.110.115.41] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 31 Oct
 2022 14:49:45 -0700
Message-ID: <d109cbdf-1b0e-ff67-879c-d0955da4898e@quicinc.com>
Date:   Mon, 31 Oct 2022 14:49:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v3 3/4] arm64: dts: qcom: Add base QDU1000/QRU1000 DTSIs
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20221026200429.162212-1-quic_molvera@quicinc.com>
 <20221026200429.162212-4-quic_molvera@quicinc.com>
 <ae4b2333-d243-17ee-1ebd-6b1c89eef9f3@linaro.org>
From:   Melody Olvera <quic_molvera@quicinc.com>
In-Reply-To: <ae4b2333-d243-17ee-1ebd-6b1c89eef9f3@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 1q56z4J4NQ0pGJ5Bvl_v_sObOSMBFZd6
X-Proofpoint-GUID: 1q56z4J4NQ0pGJ5Bvl_v_sObOSMBFZd6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-31_21,2022-10-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 mlxscore=0
 bulkscore=0 mlxlogscore=999 impostorscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2210310135
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/27/2022 8:21 AM, Krzysztof Kozlowski wrote:
> On 26/10/2022 16:04, Melody Olvera wrote:
>> Add the base DTSI files for QDU1000 and QRU1000 SoCs, including base
>> descriptions of CPUs, GCC, RPMHCC, QUP, TLMM, and interrupt-controller
>> to boot to shell with console on these SoCs.
>>
>> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
>> ---
>>  arch/arm64/boot/dts/qcom/qdu1000.dtsi | 1406 +++++++++++++++++++++++++
> Please use scripts/get_maintainers.pl to get a list of necessary people
> and lists to CC.  It might happen, that command when run on an older
> kernel, gives you outdated entries.  Therefore please be sure you base
> your patches on recent Linux kernel.
Sure thing; we talked about this on a different patch.
>
>>  arch/arm64/boot/dts/qcom/qru1000.dtsi |   27 +
>>  2 files changed, 1433 insertions(+)
>>  create mode 100644 arch/arm64/boot/dts/qcom/qdu1000.dtsi
>>  create mode 100644 arch/arm64/boot/dts/qcom/qru1000.dtsi
>>
>> diff --git a/arch/arm64/boot/dts/qcom/qdu1000.dtsi b/arch/arm64/boot/dts/qcom/qdu1000.dtsi
>> new file mode 100644
>> index 000000000000..76474106e931
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/qcom/qdu1000.dtsi
>> @@ -0,0 +1,1406 @@
>> +// SPDX-License-Identifier: BSD-3-Clause
>> +/*
>> + * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
>> + */
> (...)
>
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
>> +			clocks = <&rpmhcc RPMH_CXO_CLK>, <&sleep_clk>;
>> +			clock-names = "bi_tcxo", "sleep_clk";
>> +		};
>> +
>> +		gpi_dma0: dma-controller@900000  {
>> +			compatible = "qcom,sm6350-gpi-dma";
> You should add here a specific compatible as well. Same in other places.
> All places. I had impression we talked about this few times, so I don't
> know what is missing on your side.
>
> This must be:
> "qcom,qdu1000-gpi-dma", "qcom,sm6350-gpi-dma"
Got it. I talked to Stephan and he said either your suggestion or just using
preexisting compatibles would be ok. I thought it might be cleaner to not
have the qdu compats, but I'm fine either way.
>
>> +			#dma-cells = <3>;
>> +			reg = <0x0 0x900000 0x0 0x60000>;
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
> (...)
>
>
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
> Can we have some generic agreement where to put drive-strengths and bias?
>
> See also:
> https://lore.kernel.org/linux-devicetree/20221026200357.391635-2-krzysztof.kozlowski@linaro.org/
>
> https://lore.kernel.org/lkml/CAD=FV=VUL4GmjaibAMhKNdpEso_Hg_R=XeMaqah1LSj_9-Ce4Q@mail.gmail.com/
Not sure how much two-sense I have for the conversation at large, but generally I agree with Doug's
point in the first paragraph. Pulls for this soc are consistent across boards so I don't think it makes
sense to move them to the board files here. I vote that these stay here.
>
>> +				bias-pull-up;
>> +			};
> (...)
>
>> +		};
>> +
>> +		cpufreq_hw: cpufreq@17d90000 {
>> +			compatible = "qcom,sm8250-cpufreq-epss", "qcom,cpufreq-epss";
> This is not sm8250...
Ack.
>
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
>> +			#interconnect-cells = <1>;
>> +			qcom,bcm-voters = <&apps_bcm_voter>;
>> +		};
>> +	};
Thanks,
Melody
