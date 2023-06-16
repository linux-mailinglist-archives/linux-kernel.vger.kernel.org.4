Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35404733198
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 14:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345428AbjFPMtX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 08:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234741AbjFPMtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 08:49:21 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18CDB270B;
        Fri, 16 Jun 2023 05:49:18 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35GCdDer004033;
        Fri, 16 Jun 2023 12:49:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=sKqM6rWhjyCVu/mMZh9RMO5FEQj6VWnFsBwea7Gh2kM=;
 b=GcMW4tuyK5j3c5yht4X2GfQDoDFNUQqn/m5kFs+g/AUHPMgy4yQX/5+TqyHB2A20rvFZ
 qLoV215lRbN3ZGZvtrshpnCG2LLCnaIn2VNOSsGYwTkASs+FGmQOTmHlD001DUVmochm
 R10OF6Q6V1fa7Yy7l/ELMBlIab9Z6YjuMe5//f5urJoZ64y/fRz27vErWdWeMdP9PHp9
 p8mH9FT91T7eMDp6TDRE1BFoa6Pul8qbFNKtUeYNq99kRubWE3cHQolfIL0eaLqfAzwk
 o/1SRk0gvJeNOCKoWqGKMOGuzaMPFaGOnYKOzhqlgf9+36S9xksnxoxqSkPiBce4iv+J oA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r8mt0rdct-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Jun 2023 12:49:13 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35GCnCtT021299
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Jun 2023 12:49:12 GMT
Received: from [10.216.44.30] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Fri, 16 Jun
 2023 05:49:05 -0700
Message-ID: <c34008c5-6ef7-aae7-51e4-fe7d6ea60d7f@quicinc.com>
Date:   Fri, 16 Jun 2023 18:19:00 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 1/2] arm64: dts: qcom: ipq9574: Add common RDP dtsi file
To:     Konrad Dybcio <konrad.dybcio@linaro.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_gokulsri@quicinc.com>,
        <quic_sjaganat@quicinc.com>, <quic_kathirav@quicinc.com>,
        <quic_arajkuma@quicinc.com>, <quic_poovendh@quicinc.com>
References: <20230614085040.22071-1-quic_anusha@quicinc.com>
 <20230614085040.22071-2-quic_anusha@quicinc.com>
 <f850b295-212f-ac06-3ad2-c86213875019@linaro.org>
From:   Anusha Canchi <quic_anusha@quicinc.com>
In-Reply-To: <f850b295-212f-ac06-3ad2-c86213875019@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: L0ErV58rGfhozmLqfw-I_e2hBE5nc_-T
X-Proofpoint-GUID: L0ErV58rGfhozmLqfw-I_e2hBE5nc_-T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-16_08,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 phishscore=0
 adultscore=0 clxscore=1015 mlxlogscore=999 malwarescore=0 spamscore=0
 impostorscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306160115
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/14/2023 4:10 PM, Konrad Dybcio wrote:
>
> On 14.06.2023 10:50, Anusha Rao wrote:
>> Add a dtsi file to include interfaces that are common
>> across RDPs.
>>
>> Signed-off-by: Anusha Rao <quic_anusha@quicinc.com>
>> ---
> This enables SDHCI on RDP453. Whether or not it was intended, please
> mention it in the commit message.
Thanks for pointing out! Will address in the next patch.

Thanks,
Anusha
> Konrad
>>   .../boot/dts/qcom/ipq9574-rdp-common.dtsi     | 121 ++++++++++++++++++
>>   arch/arm64/boot/dts/qcom/ipq9574-rdp418.dts   | 107 +---------------
>>   arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts   |  88 +------------
>>   arch/arm64/boot/dts/qcom/ipq9574-rdp449.dts   |  65 +---------
>>   arch/arm64/boot/dts/qcom/ipq9574-rdp453.dts   |  65 +---------
>>   5 files changed, 125 insertions(+), 321 deletions(-)
>>   create mode 100644 arch/arm64/boot/dts/qcom/ipq9574-rdp-common.dtsi
>>
>> diff --git a/arch/arm64/boot/dts/qcom/ipq9574-rdp-common.dtsi b/arch/arm64/boot/dts/qcom/ipq9574-rdp-common.dtsi
>> new file mode 100644
>> index 000000000000..999902bc70bd
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/qcom/ipq9574-rdp-common.dtsi
>> @@ -0,0 +1,121 @@
>> +// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
>> +/*
>> + * IPQ9574 RDP board common device tree source
>> + *
>> + * Copyright (c) 2020-2021 The Linux Foundation. All rights reserved.
>> + * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
>> + */
>> +
>> +/dts-v1/;
>> +
>> +#include "ipq9574.dtsi"
>> +
>> +/ {
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
>> +&sdhc_1 {
>> +	pinctrl-0 = <&sdc_default_state>;
>> +	pinctrl-names = "default";
>> +	mmc-ddr-1_8v;
>> +	mmc-hs200-1_8v;
>> +	mmc-hs400-1_8v;
>> +	mmc-hs400-enhanced-strobe;
>> +	max-frequency = <384000000>;
>> +	bus-width = <8>;
>> +	status = "okay";
>> +};
>> +
>> +&sleep_clk {
>> +	clock-frequency = <32000>;
>> +};
>> +
>> +&tlmm {
>> +	sdc_default_state: sdc-default-state {
>> +		clk-pins {
>> +			pins = "gpio5";
>> +			function = "sdc_clk";
>> +			drive-strength = <8>;
>> +			bias-disable;
>> +		};
>> +
>> +		cmd-pins {
>> +			pins = "gpio4";
>> +			function = "sdc_cmd";
>> +			drive-strength = <8>;
>> +			bias-pull-up;
>> +		};
>> +
>> +		data-pins {
>> +			pins = "gpio0", "gpio1", "gpio2",
>> +			       "gpio3", "gpio6", "gpio7",
>> +			       "gpio8", "gpio9";
>> +			function = "sdc_data";
>> +			drive-strength = <8>;
>> +			bias-pull-up;
>> +		};
>> +
>> +		rclk-pins {
>> +			pins = "gpio10";
>> +			function = "sdc_rclk";
>> +			drive-strength = <8>;
>> +			bias-pull-down;
>> +		};
>> +	};
>> +
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
>> diff --git a/arch/arm64/boot/dts/qcom/ipq9574-rdp418.dts b/arch/arm64/boot/dts/qcom/ipq9574-rdp418.dts
>> index 2b093e02637b..924e4c50101a 100644
>> --- a/arch/arm64/boot/dts/qcom/ipq9574-rdp418.dts
>> +++ b/arch/arm64/boot/dts/qcom/ipq9574-rdp418.dts
>> @@ -8,117 +8,12 @@
>>   
>>   /dts-v1/;
>>   
>> -#include "ipq9574.dtsi"
>> +#include "ipq9574-rdp-common.dtsi"
>>   
>>   / {
>>   	model = "Qualcomm Technologies, Inc. IPQ9574/AP-AL02-C2";
>>   	compatible = "qcom,ipq9574-ap-al02-c2", "qcom,ipq9574";
>>   
>> -	aliases {
>> -		serial0 = &blsp1_uart2;
>> -	};
>> -
>> -	chosen {
>> -		stdout-path = "serial0:115200n8";
>> -	};
>> -};
>> -
>> -&blsp1_spi0 {
>> -	pinctrl-0 = <&spi_0_pins>;
>> -	pinctrl-names = "default";
>> -	status = "okay";
>> -
>> -	flash@0 {
>> -		compatible = "micron,n25q128a11", "jedec,spi-nor";
>> -		reg = <0>;
>> -		#address-cells = <1>;
>> -		#size-cells = <1>;
>> -		spi-max-frequency = <50000000>;
>> -	};
>> -};
>> -
>> -&blsp1_uart2 {
>> -	pinctrl-0 = <&uart2_pins>;
>> -	pinctrl-names = "default";
>> -	status = "okay";
>>   };
>>   
>> -&rpm_requests {
>> -	regulators {
>> -		compatible = "qcom,rpm-mp5496-regulators";
>> -
>> -		ipq9574_s1: s1 {
>> -		/*
>> -		 * During kernel bootup, the SoC runs at 800MHz with 875mV set by the bootloaders.
>> -		 * During regulator registration, kernel not knowing the initial voltage,
>> -		 * considers it as zero and brings up the regulators with minimum supported voltage.
>> -		 * Update the regulator-min-microvolt with SVS voltage of 725mV so that
>> -		 * the regulators are brought up with 725mV which is sufficient for all the
>> -		 * corner parts to operate at 800MHz
>> -		 */
>> -			regulator-min-microvolt = <725000>;
>> -			regulator-max-microvolt = <1075000>;
>> -		};
>> -	};
>> -};
>> -
>> -&sdhc_1 {
>> -	pinctrl-0 = <&sdc_default_state>;
>> -	pinctrl-names = "default";
>> -	mmc-ddr-1_8v;
>> -	mmc-hs200-1_8v;
>> -	mmc-hs400-1_8v;
>> -	mmc-hs400-enhanced-strobe;
>> -	max-frequency = <384000000>;
>> -	bus-width = <8>;
>> -	status = "okay";
>> -};
>>   
>> -&sleep_clk {
>> -	clock-frequency = <32000>;
>> -};
>> -
>> -&tlmm {
>> -	sdc_default_state: sdc-default-state {
>> -		clk-pins {
>> -			pins = "gpio5";
>> -			function = "sdc_clk";
>> -			drive-strength = <8>;
>> -			bias-disable;
>> -		};
>> -
>> -		cmd-pins {
>> -			pins = "gpio4";
>> -			function = "sdc_cmd";
>> -			drive-strength = <8>;
>> -			bias-pull-up;
>> -		};
>> -
>> -		data-pins {
>> -			pins = "gpio0", "gpio1", "gpio2",
>> -			       "gpio3", "gpio6", "gpio7",
>> -			       "gpio8", "gpio9";
>> -			function = "sdc_data";
>> -			drive-strength = <8>;
>> -			bias-pull-up;
>> -		};
>> -
>> -		rclk-pins {
>> -			pins = "gpio10";
>> -			function = "sdc_rclk";
>> -			drive-strength = <8>;
>> -			bias-pull-down;
>> -		};
>> -	};
>> -
>> -	spi_0_pins: spi-0-state {
>> -		pins = "gpio11", "gpio12", "gpio13", "gpio14";
>> -		function = "blsp0_spi";
>> -		drive-strength = <8>;
>> -		bias-disable;
>> -	};
>> -};
>> -
>> -&xo_board_clk {
>> -	clock-frequency = <24000000>;
>> -};
>> diff --git a/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts b/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
>> index 2b3ed8d351f7..ae2578ba6980 100644
>> --- a/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
>> +++ b/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
>> @@ -8,96 +8,10 @@
>>   
>>   /dts-v1/;
>>   
>> -#include "ipq9574.dtsi"
>> +#include "ipq9574-rdp-common.dtsi"
>>   
>>   / {
>>   	model = "Qualcomm Technologies, Inc. IPQ9574/AP-AL02-C7";
>>   	compatible = "qcom,ipq9574-ap-al02-c7", "qcom,ipq9574";
>>   
>> -	aliases {
>> -		serial0 = &blsp1_uart2;
>> -	};
>> -
>> -	chosen {
>> -		stdout-path = "serial0:115200n8";
>> -	};
>> -};
>> -
>> -&blsp1_uart2 {
>> -	pinctrl-0 = <&uart2_pins>;
>> -	pinctrl-names = "default";
>> -	status = "okay";
>> -};
>> -
>> -&rpm_requests {
>> -	regulators {
>> -		compatible = "qcom,rpm-mp5496-regulators";
>> -
>> -		ipq9574_s1: s1 {
>> -		/*
>> -		 * During kernel bootup, the SoC runs at 800MHz with 875mV set by the bootloaders.
>> -		 * During regulator registration, kernel not knowing the initial voltage,
>> -		 * considers it as zero and brings up the regulators with minimum supported voltage.
>> -		 * Update the regulator-min-microvolt with SVS voltage of 725mV so that
>> -		 * the regulators are brought up with 725mV which is sufficient for all the
>> -		 * corner parts to operate at 800MHz
>> -		 */
>> -			regulator-min-microvolt = <725000>;
>> -			regulator-max-microvolt = <1075000>;
>> -		};
>> -	};
>> -};
>> -
>> -&sdhc_1 {
>> -	pinctrl-0 = <&sdc_default_state>;
>> -	pinctrl-names = "default";
>> -	mmc-ddr-1_8v;
>> -	mmc-hs200-1_8v;
>> -	mmc-hs400-1_8v;
>> -	mmc-hs400-enhanced-strobe;
>> -	max-frequency = <384000000>;
>> -	bus-width = <8>;
>> -	status = "okay";
>> -};
>> -
>> -&sleep_clk {
>> -	clock-frequency = <32000>;
>> -};
>> -
>> -&tlmm {
>> -	sdc_default_state: sdc-default-state {
>> -		clk-pins {
>> -			pins = "gpio5";
>> -			function = "sdc_clk";
>> -			drive-strength = <8>;
>> -			bias-disable;
>> -		};
>> -
>> -		cmd-pins {
>> -			pins = "gpio4";
>> -			function = "sdc_cmd";
>> -			drive-strength = <8>;
>> -			bias-pull-up;
>> -		};
>> -
>> -		data-pins {
>> -			pins = "gpio0", "gpio1", "gpio2",
>> -			       "gpio3", "gpio6", "gpio7",
>> -			       "gpio8", "gpio9";
>> -			function = "sdc_data";
>> -			drive-strength = <8>;
>> -			bias-pull-up;
>> -		};
>> -
>> -		rclk-pins {
>> -			pins = "gpio10";
>> -			function = "sdc_rclk";
>> -			drive-strength = <8>;
>> -			bias-pull-down;
>> -		};
>> -	};
>> -};
>> -
>> -&xo_board_clk {
>> -	clock-frequency = <24000000>;
>>   };
>> diff --git a/arch/arm64/boot/dts/qcom/ipq9574-rdp449.dts b/arch/arm64/boot/dts/qcom/ipq9574-rdp449.dts
>> index c8fa54e1a62c..d36d1078763e 100644
>> --- a/arch/arm64/boot/dts/qcom/ipq9574-rdp449.dts
>> +++ b/arch/arm64/boot/dts/qcom/ipq9574-rdp449.dts
>> @@ -8,73 +8,10 @@
>>   
>>   /dts-v1/;
>>   
>> -#include "ipq9574.dtsi"
>> +#include "ipq9574-rdp-common.dtsi"
>>   
>>   / {
>>   	model = "Qualcomm Technologies, Inc. IPQ9574/AP-AL02-C6";
>>   	compatible = "qcom,ipq9574-ap-al02-c6", "qcom,ipq9574";
>>   
>> -	aliases {
>> -		serial0 = &blsp1_uart2;
>> -	};
>> -
>> -	chosen {
>> -		stdout-path = "serial0:115200n8";
>> -	};
>> -};
>> -
>> -&blsp1_spi0 {
>> -	pinctrl-0 = <&spi_0_pins>;
>> -	pinctrl-names = "default";
>> -	status = "okay";
>> -
>> -	flash@0 {
>> -		compatible = "micron,n25q128a11", "jedec,spi-nor";
>> -		reg = <0>;
>> -		#address-cells = <1>;
>> -		#size-cells = <1>;
>> -		spi-max-frequency = <50000000>;
>> -	};
>> -};
>> -
>> -&blsp1_uart2 {
>> -	pinctrl-0 = <&uart2_pins>;
>> -	pinctrl-names = "default";
>> -	status = "okay";
>> -};
>> -
>> -&rpm_requests {
>> -	regulators {
>> -		compatible = "qcom,rpm-mp5496-regulators";
>> -
>> -		ipq9574_s1: s1 {
>> -		/*
>> -		 * During kernel bootup, the SoC runs at 800MHz with 875mV set by the bootloaders.
>> -		 * During regulator registration, kernel not knowing the initial voltage,
>> -		 * considers it as zero and brings up the regulators with minimum supported voltage.
>> -		 * Update the regulator-min-microvolt with SVS voltage of 725mV so that
>> -		 * the regulators are brought up with 725mV which is sufficient for all the
>> -		 * corner parts to operate at 800MHz
>> -		 */
>> -			regulator-min-microvolt = <725000>;
>> -			regulator-max-microvolt = <1075000>;
>> -		};
>> -	};
>> -};
>> -
>> -&sleep_clk {
>> -	clock-frequency = <32000>;
>> -};
>> -
>> -&tlmm {
>> -	spi_0_pins: spi-0-state {
>> -		pins = "gpio11", "gpio12", "gpio13", "gpio14";
>> -		function = "blsp0_spi";
>> -		drive-strength = <8>;
>> -		bias-disable;
>> -	};
>> -};
>> -
>> -&xo_board_clk {
>> -	clock-frequency = <24000000>;
>>   };
>> diff --git a/arch/arm64/boot/dts/qcom/ipq9574-rdp453.dts b/arch/arm64/boot/dts/qcom/ipq9574-rdp453.dts
>> index f01de6628c3b..c30c9fbedf26 100644
>> --- a/arch/arm64/boot/dts/qcom/ipq9574-rdp453.dts
>> +++ b/arch/arm64/boot/dts/qcom/ipq9574-rdp453.dts
>> @@ -8,73 +8,10 @@
>>   
>>   /dts-v1/;
>>   
>> -#include "ipq9574.dtsi"
>> +#include "ipq9574-rdp-common.dtsi"
>>   
>>   / {
>>   	model = "Qualcomm Technologies, Inc. IPQ9574/AP-AL02-C8";
>>   	compatible = "qcom,ipq9574-ap-al02-c8", "qcom,ipq9574";
>>   
>> -	aliases {
>> -		serial0 = &blsp1_uart2;
>> -	};
>> -
>> -	chosen {
>> -		stdout-path = "serial0:115200n8";
>> -	};
>> -};
>> -
>> -&blsp1_spi0 {
>> -	pinctrl-0 = <&spi_0_pins>;
>> -	pinctrl-names = "default";
>> -	status = "okay";
>> -
>> -	flash@0 {
>> -		compatible = "micron,n25q128a11", "jedec,spi-nor";
>> -		reg = <0>;
>> -		#address-cells = <1>;
>> -		#size-cells = <1>;
>> -		spi-max-frequency = <50000000>;
>> -	};
>> -};
>> -
>> -&blsp1_uart2 {
>> -	pinctrl-0 = <&uart2_pins>;
>> -	pinctrl-names = "default";
>> -	status = "okay";
>> -};
>> -
>> -&rpm_requests {
>> -	regulators {
>> -		compatible = "qcom,rpm-mp5496-regulators";
>> -
>> -		ipq9574_s1: s1 {
>> -		/*
>> -		 * During kernel bootup, the SoC runs at 800MHz with 875mV set by the bootloaders.
>> -		 * During regulator registration, kernel not knowing the initial voltage,
>> -		 * considers it as zero and brings up the regulators with minimum supported voltage.
>> -		 * Update the regulator-min-microvolt with SVS voltage of 725mV so that
>> -		 * the regulators are brought up with 725mV which is sufficient for all the
>> -		 * corner parts to operate at 800MHz
>> -		 */
>> -			regulator-min-microvolt = <725000>;
>> -			regulator-max-microvolt = <1075000>;
>> -		};
>> -	};
>> -};
>> -
>> -&sleep_clk {
>> -	clock-frequency = <32000>;
>> -};
>> -
>> -&tlmm {
>> -	spi_0_pins: spi-0-state {
>> -		pins = "gpio11", "gpio12", "gpio13", "gpio14";
>> -		function = "blsp0_spi";
>> -		drive-strength = <8>;
>> -		bias-disable;
>> -	};
>> -};
>> -
>> -&xo_board_clk {
>> -	clock-frequency = <24000000>;
>>   };

