Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8077C71487C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 13:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231488AbjE2L0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 07:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjE2L0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 07:26:10 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AF0DE3;
        Mon, 29 May 2023 04:26:04 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34TAa3kr031395;
        Mon, 29 May 2023 11:26:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=2AqSR667t5Vzc2GyeIS1unOFBhkMKqudJXgsYyN/Rj0=;
 b=En/epoxJfCCiNZXt3InPr+qrqPYANvrMLcUbEib3E4nf4EKE9bAadqiDEpZOtlCPy9A8
 sP0ZaG+b4bQLuvAz+GpgawZXftzcKr8yR6UwxMYyClRW77/0HGuslw+i48wMqEuJscyK
 3gWUcCXT5IBYeobQ6zSL6PJRn/MUub66M3TVo73aqAeRRDYiTNQbfGeS8GfJoGsEXojq
 80P2oDlfLY4812HYMsyTmIfp98h5Xo+ppnCQnRmDqd0gWYR+U19CMkAVd+WtIi6gFU+l
 4P0tC29JKdxzDl6S2UBDHm0qqikL15YljQKC7vP/XhhvIjNxM/c5rGvW4OkaEJH6jtbs Xg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3quaqpbbg0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 May 2023 11:26:00 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34TBPxdX001481
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 May 2023 11:25:59 GMT
Received: from [10.201.198.120] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Mon, 29 May
 2023 04:25:53 -0700
Message-ID: <408e5161-f290-68a6-048c-472a2b34a587@quicinc.com>
Date:   Mon, 29 May 2023 16:55:49 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 2/2] arm64: dts: qcom: ipq9574: add support for RDP454
 variant
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_gokulsri@quicinc.com>,
        <quic_sjaganat@quicinc.com>, <quic_kathirav@quicinc.com>,
        <quic_arajkuma@quicinc.com>, <quic_anusha@quicinc.com>,
        <quic_devipriy@quicinc.com>
References: <20230519103128.30783-1-quic_poovendh@quicinc.com>
 <20230519103128.30783-3-quic_poovendh@quicinc.com>
 <8a5df35a-2429-3880-6a1e-795c13c3b3d1@linaro.org>
From:   POOVENDHAN SELVARAJ <quic_poovendh@quicinc.com>
In-Reply-To: <8a5df35a-2429-3880-6a1e-795c13c3b3d1@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: EngBIo-bPQYd3djRPm80XBROK92y441T
X-Proofpoint-ORIG-GUID: EngBIo-bPQYd3djRPm80XBROK92y441T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-29_07,2023-05-25_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 bulkscore=0 impostorscore=0 priorityscore=1501 mlxlogscore=999
 clxscore=1011 spamscore=0 suspectscore=0 phishscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305290098
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/19/2023 11:01 PM, Konrad Dybcio wrote:
>
> On 19.05.2023 12:31, Poovendhan Selvaraj wrote:
>> From: POOVENDHAN SELVARAJ <quic_poovendh@quicinc.com>
>>
>> Add the initial device tree support for the Reference Design Platform (RDP)
>> 454 based on IPQ9574 family of SoCs. This patch adds support for Console
>> UART, SPI NOR and SMPA1 regulator node.
>>
>> Signed-off-by: Poovendhan Selvaraj <quic_poovendh@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/Makefile           |  1 +
>>   arch/arm64/boot/dts/qcom/ipq9574-rdp454.dts | 92 +++++++++++++++++++++
>>   2 files changed, 93 insertions(+)
>>   create mode 100644 arch/arm64/boot/dts/qcom/ipq9574-rdp454.dts
>>
>> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
>> index 7b5466395f46..834e790bec90 100644
>> --- a/arch/arm64/boot/dts/qcom/Makefile
>> +++ b/arch/arm64/boot/dts/qcom/Makefile
>> @@ -12,6 +12,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= ipq8074-hk10-c2.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)	+= ipq9574-rdp418.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)	+= ipq9574-rdp433.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)	+= ipq9574-rdp449.dtb
>> +dtb-$(CONFIG_ARCH_QCOM)	+= ipq9574-rdp454.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-acer-a1-724.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-alcatel-idol347.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-asus-z00l.dtb
>> diff --git a/arch/arm64/boot/dts/qcom/ipq9574-rdp454.dts b/arch/arm64/boot/dts/qcom/ipq9574-rdp454.dts
>> new file mode 100644
>> index 000000000000..b3e853a9cc94
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/qcom/ipq9574-rdp454.dts
>> @@ -0,0 +1,92 @@
>> +// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
>> +/*
>> + * IPQ9574 RDP454 board device tree source
>> + *
>> + * Copyright (c) 2020-2021 The Linux Foundation. All rights reserved.
>> + * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
>> + */
>> +
>> +/dts-v1/;
>> +
>> +#include "ipq9574.dtsi"
>> +
>> +/ {
>> +	model = "Qualcomm Technologies, Inc. IPQ9574/AP-AL02-C9";
>> +	compatible = "qcom,ipq9574-ap-al02-c9", "qcom,ipq9574";
>> +
>> +	aliases {
>> +		serial0 = &blsp1_uart2;
>> +	};
>> +
>> +	chosen {
>> +		stdout-path = "serial0:115200n8";
>> +	};
>> +};
>> +
>> +/* In AL02-C9, the max supported CPU Freq is 1.5 GHz. Disabling frequencies beyond 1.5GHz*/
> In -> On
>
> GHz*/ -> GHz */
>
> Disabling -> Disable
Okay. Will address them in next spin
>
> Can this not be determined based on fuse values?

Yes...That should be possible.Will then drop the below cpu_opp_table 
entries and post a separate series for the same.

>
>> +&cpu_opp_table {
>> +	opp-1800000000 {
>> +		opp-supported-hw = <0>;
>> +	};
>> +
>> +	opp-2208000000 {
>> +		opp-supported-hw = <0>;
>> +	};
>> +};
>> +
>> +/* Disable IPQ9574 integrated radio's reserved memory */
> ?
>
> Konrad

sorry, will drop it as it got added by mistake.

Regards,
Poovendhan S

>> +&blsp1_spi0 {
>> +	pinctrl-0 = <&spi_0_pins>;
>> +	pinctrl-names = "default";
>> +	status = "okay";
>> +
>> +	flash@0 {
>> +		compatible = "micron,n25q128a11", "jedec,spi-nor";
>> +		reg = <0>;
>> +		#address-cells = <1>;
>> +		#size-cells = <1>;
>> +		spi-max-frequency = <50000000>;
>> +	};
>> +};
>> +
>> +&blsp1_uart2 {
>> +	pinctrl-0 = <&uart2_pins>;
>> +	pinctrl-names = "default";
>> +	status = "okay";
>> +};
>> +
>> +&rpm_requests {
>> +	regulators {
>> +		compatible = "qcom,rpm-mp5496-regulators";
>> +
>> +		ipq9574_s1: s1 {
>> +		/*
>> +		 * During kernel bootup, the SoC runs at 800MHz with 875mV set by the bootloaders.
>> +		 * During regulator registration, kernel not knowing the initial voltage,
>> +		 * considers it as zero and brings up the regulators with minimum supported voltage.
>> +		 * Update the regulator-min-microvolt with SVS voltage of 725mV so that
>> +		 * the regulators are brought up with 725mV which is sufficient for all the
>> +		 * corner parts to operate at 800MHz
>> +		 */
>> +			regulator-min-microvolt = <725000>;
>> +			regulator-max-microvolt = <1075000>;
>> +		};
>> +	};
>> +};
>> +
>> +&sleep_clk {
>> +	clock-frequency = <32000>;
>> +};
>> +
>> +&tlmm {
>> +	spi_0_pins: spi-0-state {
>> +		pins = "gpio11", "gpio12", "gpio13", "gpio14";
>> +		function = "blsp0_spi";
>> +		drive-strength = <8>;
>> +		bias-disable;
>> +	};
>> +};
>> +
>> +&xo_board_clk {
>> +	clock-frequency = <24000000>;
>> +};
