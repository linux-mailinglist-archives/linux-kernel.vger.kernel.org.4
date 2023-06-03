Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F6C6720E95
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 09:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233826AbjFCHwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jun 2023 03:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjFCHwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jun 2023 03:52:03 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA98A1B7;
        Sat,  3 Jun 2023 00:52:02 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3537pwQJ011429;
        Sat, 3 Jun 2023 07:51:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=T/3GhhMrKO8+boF+yymriVWi1jONerKzIa18X0PZd+M=;
 b=nZ5/vOGdCszR8/relltRqo8zNeVjArwLR5BZ9UMogV6qMeOGgDff31u5ltc1P5TEBcHQ
 gZGQ9aEBAZwzCQLFWugRHjAu8j89Wg71FocKjAebjnMQEmH/qGkQWjcDTNkbQOjNqp1P
 6YcyTRHV0SkyUnRkYbLyPtC+z0/WrIhY9u1UeRx5C6smn/Nq99x8EGa0CsTyX2ibmqX9
 /RXX9ybR8n+GvNKkhgIMp2JKMi9KWcMiEjxqpmqAmsu75gGUYbDwxqJlYoPqZSOVzJyj
 RUzwt9n3Db4R0lUSqT+ihEugYN+QxxImgsokBaIlDrSYzuDFpalNjCmjEhmZw7zhqzS5 DA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qywwcr759-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 03 Jun 2023 07:51:58 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3537pvP4029994
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 3 Jun 2023 07:51:57 GMT
Received: from [10.216.19.222] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Sat, 3 Jun 2023
 00:51:52 -0700
Message-ID: <e928c95e-dbce-d298-8c53-b54d0f796643@quicinc.com>
Date:   Sat, 3 Jun 2023 13:21:48 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 2/2] arm64: dts: qcom: ipq9574: add support for RDP453
 variant
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_sjaganat@quicinc.com>,
        <quic_kathirav@quicinc.com>, <quic_arajkuma@quicinc.com>,
        <quic_anusha@quicinc.com>
References: <20230526153152.777-1-quic_devipriy@quicinc.com>
 <20230526153152.777-3-quic_devipriy@quicinc.com>
 <61e81ac1-d7e2-a909-2e39-dad315acf8fe@linaro.org>
From:   Devi Priya <quic_devipriy@quicinc.com>
In-Reply-To: <61e81ac1-d7e2-a909-2e39-dad315acf8fe@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: RCw3VXfyY-fe0eOtVjTCKjW2Wp4_dT1f
X-Proofpoint-ORIG-GUID: RCw3VXfyY-fe0eOtVjTCKjW2Wp4_dT1f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-03_04,2023-06-02_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 adultscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 impostorscore=0
 malwarescore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306030072
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/27/2023 2:15 AM, Konrad Dybcio wrote:
> 
> 
> On 26.05.2023 17:31, Devi Priya wrote:
>> Add the initial device tree support for the Reference Design Platform (RDP)
>> 453 based on IPQ9574 family of SoCs. This patch adds support for Console
>> UART, SPI NOR and SMPA1 regulator node.
>>
>> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
>> ---
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> 
> 
> BTW what's the naming scheme for IPQ?
> 
> IPQabcd
> 
> 'a' - tier
> 'b' - 0/5 - network generation dependent?
> 'cd' - model
> 
> ?
> 
Hi konrad,

Below is the naming scheme,
IPQabcd
a-> product category(5-Immersive home, 6-Home, 9-Networking Pro)
b-> generation (5-Alder)
c-> SKU customization (0-base SKU)
d-> #chains

Thanks,
Devi Priya
> Konrad
>>   arch/arm64/boot/dts/qcom/Makefile           |  1 +
>>   arch/arm64/boot/dts/qcom/ipq9574-rdp453.dts | 80 +++++++++++++++++++++
>>   2 files changed, 81 insertions(+)
>>   create mode 100644 arch/arm64/boot/dts/qcom/ipq9574-rdp453.dts
>>
>> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
>> index 834e790bec90..56ec3d84ad43 100644
>> --- a/arch/arm64/boot/dts/qcom/Makefile
>> +++ b/arch/arm64/boot/dts/qcom/Makefile
>> @@ -12,6 +12,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= ipq8074-hk10-c2.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)	+= ipq9574-rdp418.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)	+= ipq9574-rdp433.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)	+= ipq9574-rdp449.dtb
>> +dtb-$(CONFIG_ARCH_QCOM)	+= ipq9574-rdp453.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)	+= ipq9574-rdp454.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-acer-a1-724.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-alcatel-idol347.dtb
>> diff --git a/arch/arm64/boot/dts/qcom/ipq9574-rdp453.dts b/arch/arm64/boot/dts/qcom/ipq9574-rdp453.dts
>> new file mode 100644
>> index 000000000000..f01de6628c3b
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/qcom/ipq9574-rdp453.dts
>> @@ -0,0 +1,80 @@
>> +// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
>> +/*
>> + * IPQ9574 RDP453 board device tree source
>> + *
>> + * Copyright (c) 2020-2021 The Linux Foundation. All rights reserved.
>> + * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
>> + */
>> +
>> +/dts-v1/;
>> +
>> +#include "ipq9574.dtsi"
>> +
>> +/ {
>> +	model = "Qualcomm Technologies, Inc. IPQ9574/AP-AL02-C8";
>> +	compatible = "qcom,ipq9574-ap-al02-c8", "qcom,ipq9574";
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
