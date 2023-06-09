Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6467272970F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 12:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbjFIKhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 06:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231130AbjFIKgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 06:36:25 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C11942738;
        Fri,  9 Jun 2023 03:34:46 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3598ZdTD021128;
        Fri, 9 Jun 2023 10:34:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=XkLF+TfoAL7j5uqmjlX1JwwkmmWunUXnDAJGkXxXDIw=;
 b=IPXN+Eh3aVuK6LZN8HDrpblTjgh+MRVxW5WsdX9NYzzOOo6aJ5MjP/WkdmfBBeSUYe25
 z9NQt7ehqeIBqIie7RYfv2xBPSN252GhTcW7PEFwhgmXB4PZX89xGdLTmYwLfracvT89
 R32O1dGdSvg9lCKWCbXQ3udrjSWVBxFHuqRhhKKzfFEsNApA2HBPMqen+HiOHb6Hv+/U
 ISGXxH7CNQ3OONnAomK7BEYNIMym4TqcilXx8TvLboSuOsHT5QDLMXLLNK7LX9v6XNCK
 ZSH/2cAFieW2VlOXw0SRt6PG1nmTcfQC1wgiu5GzbIK78quA+W0AT7kMA821G1A8dhiQ pg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r3t70gved-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Jun 2023 10:34:43 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 359AYgBO021944
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 9 Jun 2023 10:34:42 GMT
Received: from [10.201.206.212] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Fri, 9 Jun 2023
 03:34:39 -0700
Message-ID: <0d374348-4127-2c98-dc43-a1a474a2cafd@quicinc.com>
Date:   Fri, 9 Jun 2023 16:04:36 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH V2 1/2] arm64: dts: qcom: ipq5332: enable GPIO based LEDs
 and Buttons
To:     Konrad Dybcio <konrad.dybcio@linaro.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230605052907.18837-1-quic_sridsn@quicinc.com>
 <20230605052907.18837-2-quic_sridsn@quicinc.com>
 <669d2745-c7fc-dff5-a6e6-c2c55b4428ee@linaro.org>
Content-Language: en-US
From:   Sridharan S N <quic_sridsn@quicinc.com>
In-Reply-To: <669d2745-c7fc-dff5-a6e6-c2c55b4428ee@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 9H053G8DcHMQ-MB3eYPqAR20TGGoegAp
X-Proofpoint-ORIG-GUID: 9H053G8DcHMQ-MB3eYPqAR20TGGoegAp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-09_06,2023-06-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 mlxscore=0 spamscore=0 clxscore=1011 suspectscore=0
 bulkscore=0 malwarescore=0 priorityscore=1501 mlxlogscore=821 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306090089
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/6/2023 6:27 PM, Konrad Dybcio wrote:
>
> On 5.06.2023 07:29, Sridharan S N wrote:
>> Add support for wlan-2g LED on GPIO 36 and wps buttons on GPIO 35.
>>
>> Signed-off-by: Sridharan S N <quic_sridsn@quicinc.com>
>> ---
>> Changes in V2:
>> 	- Used the hypen in node name instead of underscore
>> 	- Dropped the status property
>>   
>>   arch/arm64/boot/dts/qcom/ipq5332-mi01.2.dts | 42 +++++++++++++++++++++
>>   arch/arm64/boot/dts/qcom/ipq5332-rdp442.dts | 42 +++++++++++++++++++++
>>   arch/arm64/boot/dts/qcom/ipq5332-rdp468.dts | 42 +++++++++++++++++++++
>>   3 files changed, 126 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/ipq5332-mi01.2.dts b/arch/arm64/boot/dts/qcom/ipq5332-mi01.2.dts
>> index 3af1d5556950..5bd4ff3ad86b 100644
>> --- a/arch/arm64/boot/dts/qcom/ipq5332-mi01.2.dts
>> +++ b/arch/arm64/boot/dts/qcom/ipq5332-mi01.2.dts
>> @@ -7,6 +7,8 @@
>>   
>>   /dts-v1/;
>>   
>> +#include <dt-bindings/gpio/gpio.h>
>> +#include <dt-bindings/input/input.h>
>>   #include "ipq5332.dtsi"
>>   
>>   / {
>> @@ -20,6 +22,32 @@
>>   	chosen {
>>   		stdout-path = "serial0";
>>   	};
>> +
>> +	gpio-keys {
>> +		compatible = "gpio-keys";
>> +		pinctrl-0 = <&gpio_keys_default>;
>> +		pinctrl-names = "default";
>> +
>> +		button-wps {
>> +			label = "wps";
>> +			linux,code = <KEY_WPS_BUTTON>;
>> +			gpios = <&tlmm 35 GPIO_ACTIVE_LOW>;
>> +			linux,input-type = <1>;
>> +			debounce-interval = <60>;
>> +		};
>> +	};
> All of these changes seem very repetetive.. Are these devboards based
> on a common design? Maybe ipq5332-rdp-common.dtsi would be beneficial
> here?
Will move all the common nodes to common dtsi in the next patch
> Thanks,
Sridharan
> +
> +	leds {
> +		compatible = "gpio-leds";
> +		pinctrl-0 = <&gpio_leds_default>;
> +		pinctrl-names = "default";
> +
> +		led-0 {
> +			gpios = <&tlmm 36 GPIO_ACTIVE_HIGH>;
> +			linux,default-trigger = "phy0tx";
> +			default-state = "off";
> +		};
> +	};
>   };
>   
>   &blsp1_uart0 {
> @@ -57,6 +85,20 @@
>   /* PINCTRL */
>   
>   &tlmm {
> +	gpio_keys_default: gpio-keys-default-state {
> +		pins = "gpio35";
> +		function = "gpio";
> +		drive-strength = <8>;
> +		bias-pull-up;
> +	};
> +
> +	gpio_leds_default: gpio-leds-default-state {
> +		pins = "gpio36";
> +		function = "gpio";
> +		drive-strength = <8>;
> +		bias-pull-down;
> +	};
> +
>   	i2c_1_pins: i2c-1-state {
>   		pins = "gpio29", "gpio30";
>   		function = "blsp1_i2c0";
> diff --git a/arch/arm64/boot/dts/qcom/ipq5332-rdp442.dts b/arch/arm64/boot/dts/qcom/ipq5332-rdp442.dts
> index bcf3b31c20e3..36cbebb75c48 100644
> --- a/arch/arm64/boot/dts/qcom/ipq5332-rdp442.dts
> +++ b/arch/arm64/boot/dts/qcom/ipq5332-rdp442.dts
> @@ -7,6 +7,8 @@
>   
>   /dts-v1/;
>   
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/input.h>
>   #include "ipq5332.dtsi"
>   
>   / {
> @@ -20,6 +22,32 @@
>   	chosen {
>   		stdout-path = "serial0";
>   	};
> +
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +		pinctrl-0 = <&gpio_keys_default>;
> +		pinctrl-names = "default";
> +
> +		button-wps {
> +			label = "wps";
> +			linux,code = <KEY_WPS_BUTTON>;
> +			gpios = <&tlmm 35 GPIO_ACTIVE_LOW>;
> +			linux,input-type = <1>;
> +			debounce-interval = <60>;
> +		};
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +		pinctrl-0 = <&gpio_leds_default>;
> +		pinctrl-names = "default";
> +
> +		led-0 {
> +			gpios = <&tlmm 36 GPIO_ACTIVE_HIGH>;
> +			linux,default-trigger = "phy0tx";
> +			default-state = "off";
> +		};
> +	};
>   };
>   
>   &blsp1_uart0 {
> @@ -71,6 +99,20 @@
>   /* PINCTRL */
>   
>   &tlmm {
> +	gpio_keys_default: gpio-keys-default-state {
> +		pins = "gpio35";
> +		function = "gpio";
> +		drive-strength = <8>;
> +		bias-pull-up;
> +	};
> +
> +	gpio_leds_default: gpio-leds-default-state {
> +		pins = "gpio36";
> +		function = "gpio";
> +		drive-strength = <8>;
> +		bias-pull-down;
> +	};
> +
>   	i2c_1_pins: i2c-1-state {
>   		pins = "gpio29", "gpio30";
>   		function = "blsp1_i2c0";
> diff --git a/arch/arm64/boot/dts/qcom/ipq5332-rdp468.dts b/arch/arm64/boot/dts/qcom/ipq5332-rdp468.dts
> index 3b6a5cb8bf07..2d27f48f00c0 100644
> --- a/arch/arm64/boot/dts/qcom/ipq5332-rdp468.dts
> +++ b/arch/arm64/boot/dts/qcom/ipq5332-rdp468.dts
> @@ -7,6 +7,8 @@
>   
>   /dts-v1/;
>   
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/input.h>
>   #include "ipq5332.dtsi"
>   
>   / {
> @@ -20,6 +22,32 @@
>   	chosen {
>   		stdout-path = "serial0";
>   	};
> +
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +		pinctrl-0 = <&gpio_keys_default>;
> +		pinctrl-names = "default";
> +
> +		button-wps {
> +			label = "wps";
> +			linux,code = <KEY_WPS_BUTTON>;
> +			gpios = <&tlmm 35 GPIO_ACTIVE_LOW>;
> +			linux,input-type = <1>;
> +			debounce-interval = <60>;
> +		};
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +		pinctrl-0 = <&gpio_leds_default>;
> +		pinctrl-names = "default";
> +
> +		led-0 {
> +			gpios = <&tlmm 36 GPIO_ACTIVE_HIGH>;
> +			linux,default-trigger = "phy0tx";
> +			default-state = "off";
> +		};
> +	};
>   };
>   
>   &blsp1_uart0 {
> @@ -64,6 +92,20 @@
>   /* PINCTRL */
>   
>   &tlmm {
> +	gpio_keys_default: gpio-keys-default-state {
> +		pins = "gpio35";
> +		function = "gpio";
> +		drive-strength = <8>;
> +		bias-pull-up;
> +	};
> +
> +	gpio_leds_default: gpio-leds-default-state {
> +		pins = "gpio36";
> +		function = "gpio";
> +		drive-strength = <8>;
> +		bias-pull-down;
> +	};
> +
>   	sdc_default_state: sdc-default-state {
>   		clk-pins {
>   			pins = "gpio13";
