Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDAB8618F62
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 05:06:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbiKDEGD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 00:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbiKDEF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 00:05:59 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C1DA1FFB3;
        Thu,  3 Nov 2022 21:05:58 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2A41uPL3010546;
        Fri, 4 Nov 2022 04:05:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=8a6sMLLhNX2wWc/82CouiCf22By832/hSFGRTCFq9R8=;
 b=mb/ar9N4hYzLjlVarDJ9P6iwXFGysaMidbgxqfIoVxov2m/98Mo+vQWD5Q0WDla+fA9l
 aKWv/gfSTnCwg0VJvp8mQGgvJWZDwg0Wd4+3WjrzLJW8lmdhx8Yr6QLuTQ3n+E5z9hhK
 d6Z6CQGpNQlXKdehKJ3Z85vi2ExaSYETtY3waMn0VdtSr0byl6dt+ZsR/s3oaFzCvo2m
 sqIxPkKDnFBkxL4ruLF0e0O+yVSw11OC/jqJRaSE1qrFRh8HmO/78zR5OoeKIEQowtjg
 XSHPN9hZIIIfmEE5fn7TyZOBv5/CBxd3+PS//d8kjums/e/exZhuv6Skt+c+U/GtDXoK sA== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kmqjtresk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Nov 2022 04:05:43 +0000
Received: from nasanex01a.na.qualcomm.com ([10.52.223.231])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2A445gDD019660
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 4 Nov 2022 04:05:42 GMT
Received: from [10.110.125.80] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 3 Nov 2022
 21:05:41 -0700
Message-ID: <5109d728-ebea-21ca-3ee1-15710dfd6f1b@quicinc.com>
Date:   Thu, 3 Nov 2022 21:05:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v3 3/4] arm64: dts: qcom: Add base QDU1000/QRU1000 DTSIs
Content-Language: en-US
To:     Melody Olvera <quic_molvera@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
References: <20221026200429.162212-1-quic_molvera@quicinc.com>
 <20221026200429.162212-4-quic_molvera@quicinc.com>
 <ae4b2333-d243-17ee-1ebd-6b1c89eef9f3@linaro.org>
 <d109cbdf-1b0e-ff67-879c-d0955da4898e@quicinc.com>
 <9eaaf256-8de2-ddc9-ac95-aed9b0670f5e@linaro.org>
 <4832b716-6caf-cf72-1c7e-f21a0670cbaa@quicinc.com>
From:   Trilok Soni <quic_tsoni@quicinc.com>
In-Reply-To: <4832b716-6caf-cf72-1c7e-f21a0670cbaa@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: G2XUuzBESKHEs9EGBgTP7oMdcGQD1bWW
X-Proofpoint-GUID: G2XUuzBESKHEs9EGBgTP7oMdcGQD1bWW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-04_02,2022-11-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 adultscore=0 lowpriorityscore=0 mlxlogscore=999 bulkscore=0 spamscore=0
 impostorscore=0 phishscore=0 clxscore=1011 mlxscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211040027
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Adding Konrad, Bjorn is already there in this email

On 11/3/2022 2:13 PM, Melody Olvera wrote:
> 
> 
> On 11/2/2022 9:24 AM, Krzysztof Kozlowski wrote:
>> On 31/10/2022 17:49, Melody Olvera wrote:
>>>
>>> On 10/27/2022 8:21 AM, Krzysztof Kozlowski wrote:
>>>> On 26/10/2022 16:04, Melody Olvera wrote:
>>>>> Add the base DTSI files for QDU1000 and QRU1000 SoCs, including base
>>>>> descriptions of CPUs, GCC, RPMHCC, QUP, TLMM, and interrupt-controller
>>>>> to boot to shell with console on these SoCs.
>>>>>
>>>>> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
>>>>> ---
>>>>>   arch/arm64/boot/dts/qcom/qdu1000.dtsi | 1406 +++++++++++++++++++++++++
>>>> Please use scripts/get_maintainers.pl to get a list of necessary people
>>>> and lists to CC.  It might happen, that command when run on an older
>>>> kernel, gives you outdated entries.  Therefore please be sure you base
>>>> your patches on recent Linux kernel.
>>> Sure thing; we talked about this on a different patch.
>>>>>   arch/arm64/boot/dts/qcom/qru1000.dtsi |   27 +
>>>>>   2 files changed, 1433 insertions(+)
>>>>>   create mode 100644 arch/arm64/boot/dts/qcom/qdu1000.dtsi
>>>>>   create mode 100644 arch/arm64/boot/dts/qcom/qru1000.dtsi
>>>>>
>>>>> diff --git a/arch/arm64/boot/dts/qcom/qdu1000.dtsi b/arch/arm64/boot/dts/qcom/qdu1000.dtsi
>>>>> new file mode 100644
>>>>> index 000000000000..76474106e931
>>>>> --- /dev/null
>>>>> +++ b/arch/arm64/boot/dts/qcom/qdu1000.dtsi
>>>>> @@ -0,0 +1,1406 @@
>>>>> +// SPDX-License-Identifier: BSD-3-Clause
>>>>> +/*
>>>>> + * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
>>>>> + */
>>>> (...)
>>>>
>>>>> +
>>>>> +	soc: soc@0 {
>>>>> +		#address-cells = <2>;
>>>>> +		#size-cells = <2>;
>>>>> +		ranges = <0 0 0 0 0x10 0>;
>>>>> +		dma-ranges = <0 0 0 0 0x10 0>;
>>>>> +		compatible = "simple-bus";
>>>>> +
>>>>> +		gcc: clock-controller@80000 {
>>>>> +			compatible = "qcom,gcc-qdu1000", "syscon";
>>>>> +			reg = <0x0 0x80000 0x0 0x1f4200>;
>>>>> +			#clock-cells = <1>;
>>>>> +			#reset-cells = <1>;
>>>>> +			#power-domain-cells = <1>;
>>>>> +			clocks = <&rpmhcc RPMH_CXO_CLK>, <&sleep_clk>;
>>>>> +			clock-names = "bi_tcxo", "sleep_clk";
>>>>> +		};
>>>>> +
>>>>> +		gpi_dma0: dma-controller@900000  {
>>>>> +			compatible = "qcom,sm6350-gpi-dma";
>>>> You should add here a specific compatible as well. Same in other places.
>>>> All places. I had impression we talked about this few times, so I don't
>>>> know what is missing on your side.
>>>>
>>>> This must be:
>>>> "qcom,qdu1000-gpi-dma", "qcom,sm6350-gpi-dma"
>>> Got it. I talked to Stephan and he said either your suggestion or just using
>>> preexisting compatibles would be ok. I thought it might be cleaner to not
>>> have the qdu compats, but I'm fine either way.
>>>>> +			#dma-cells = <3>;
>>>>> +			reg = <0x0 0x900000 0x0 0x60000>;
>>>>> +			interrupts = <GIC_SPI 244 IRQ_TYPE_LEVEL_HIGH>,
>>>>> +				     <GIC_SPI 245 IRQ_TYPE_LEVEL_HIGH>,
>>>>> +				     <GIC_SPI 246 IRQ_TYPE_LEVEL_HIGH>,
>>>>> +				     <GIC_SPI 247 IRQ_TYPE_LEVEL_HIGH>,
>>>>> +				     <GIC_SPI 248 IRQ_TYPE_LEVEL_HIGH>,
>>>>> +				     <GIC_SPI 249 IRQ_TYPE_LEVEL_HIGH>,
>>>>> +				     <GIC_SPI 250 IRQ_TYPE_LEVEL_HIGH>,
>>>>> +				     <GIC_SPI 251 IRQ_TYPE_LEVEL_HIGH>,
>>>>> +				     <GIC_SPI 252 IRQ_TYPE_LEVEL_HIGH>,
>>>>> +				     <GIC_SPI 253 IRQ_TYPE_LEVEL_HIGH>,
>>>>> +				     <GIC_SPI 254 IRQ_TYPE_LEVEL_HIGH>,
>>>>> +				     <GIC_SPI 255 IRQ_TYPE_LEVEL_HIGH>;
>>>>> +			dma-channels = <12>;
>>>>> +			dma-channel-mask = <0x3f>;
>>>>> +			iommus = <&apps_smmu 0xf6 0x0>;
>>>>> +		};
>>>>> +
>>>> (...)
>>>>
>>>>
>>>>> +
>>>>> +		tlmm: pinctrl@f000000 {
>>>>> +			compatible = "qcom,qdu1000-tlmm";
>>>>> +			reg = <0x0 0xf000000 0x0 0x1000000>;
>>>>> +			interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
>>>>> +			gpio-controller;
>>>>> +			#gpio-cells = <2>;
>>>>> +			interrupt-controller;
>>>>> +			#interrupt-cells = <2>;
>>>>> +			gpio-ranges = <&tlmm 0 0 151>;
>>>>> +			wakeup-parent = <&pdc>;
>>>>> +
>>>>> +			qup_uart0_default: qup-uart0-default-state {
>>>>> +				pins = "gpio6", "gpio7", "gpio8", "gpio9";
>>>>> +				function = "qup00";
>>>>> +			};
>>>>> +
>>>>> +			qup_i2c1_data_clk: qup-i2c1-data-clk-state {
>>>>> +				pins = "gpio10", "gpio11";
>>>>> +				function = "qup01";
>>>>> +				drive-strength = <2>;
>>>> Can we have some generic agreement where to put drive-strengths and bias?
>>>>
>>>> See also:
>>>> https://lore.kernel.org/linux-devicetree/20221026200357.391635-2-krzysztof.kozlowski@linaro.org/
>>>>
>>>> https://lore.kernel.org/lkml/CAD=FV=VUL4GmjaibAMhKNdpEso_Hg_R=XeMaqah1LSj_9-Ce4Q@mail.gmail.com/
>>> Not sure how much two-sense I have for the conversation at large, but generally I agree with Doug's
>>> point in the first paragraph. Pulls for this soc are consistent across boards so I don't think it makes
>>> sense to move them to the board files here. I vote that these stay here.
>> I would be great if Konrad and Bjorn shared their opinion on this... but
>> wait, you did not Cc all maintainers... Eh.
> I'm not sure why this is being brought up again; we've already discussed this here
> https://lore.kernel.org/all/9707bf67-1b22-8a77-7193-fc909b4f49de@quicinc.com/
> Would you like to discuss this issue here, on the next version, or not at all?
> 
> On a side note, I'm uncomfortable with how our continued interactions are going
> and do not believe this to be conductive to continued collaboration. I would ask that
> we keep our correspondence polite and professional moving forward.

I have added Konrad and Bjorn is already there on the thread. Our 
understanding is that CCing maintainers comment is for next patch series 
after this one.

Bjorn, please check and comment on above? If requires we should start 
writing the guidelines for MSM boards since lot of comments are based on 
the experience or knowledge in the community Vs caught by tools - so it 
is easy to be missed by developers submitting new boards. Thoughts?

---Trilok Soni


