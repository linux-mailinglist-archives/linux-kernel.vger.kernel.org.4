Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27D2569773B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 08:16:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233526AbjBOHQJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 02:16:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232736AbjBOHQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 02:16:06 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C575A2B617;
        Tue, 14 Feb 2023 23:16:02 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31F0G84r000767;
        Wed, 15 Feb 2023 07:07:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=292uJiw2hx28pukGWdVxufTI7npD8mJX0Jnlaof2z88=;
 b=FAt+QC1FEGF587Qy/cPy2wWcYMLYAC1SRByv9LilRJVgasyYz/p2zKAbj59NFqyGIlKW
 FoUcTRd6YK0jpg1hSDv71rJ8hsmBCwdEOH+ISv+HnDiqGAv2EgdBGw0s1FjIDUwmF1MV
 YNwqbsxyVcpMIH5yazy2cM/6iOu9Gl7Y9no8lfQO3bQgZxv8J1vbAM+splv8OF+sSk6G
 0/4EY++c24B3e/oSssvU4TziaBDYX18V/bKVVzz2IEZsrfXHLG2+X8wrH/gqajZAgqLn
 I2nC9Mumajcsbs8+717vgyOQkc8PAndXwjtx1ow3peIoxwh+VVFX6QjumNmzX3lfDFaL TQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nqts7vngv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Feb 2023 07:06:56 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31F76tIQ019499
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Feb 2023 07:06:55 GMT
Received: from [10.216.30.120] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 14 Feb
 2023 23:06:50 -0800
Message-ID: <8597a9e2-534a-def9-a2c0-4d841dc9fa60@quicinc.com>
Date:   Wed, 15 Feb 2023 12:36:45 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 3/3] arm64: dts: qcom: sa8775p: add the GNSS high-speed
 UART for sa8775p-ride
Content-Language: en-US
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20230214155715.451130-1-brgl@bgdev.pl>
 <20230214155715.451130-4-brgl@bgdev.pl>
From:   Shazad Hussain <quic_shazhuss@quicinc.com>
In-Reply-To: <20230214155715.451130-4-brgl@bgdev.pl>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 7kcRcdU7qOA_KEg79Zz7uLPYGzu8N7cl
X-Proofpoint-ORIG-GUID: 7kcRcdU7qOA_KEg79Zz7uLPYGzu8N7cl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-15_02,2023-02-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 impostorscore=0 spamscore=0 phishscore=0
 clxscore=1015 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302150061
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/14/2023 9:27 PM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Add the serial port connected to the GNSS on sa8775p-ride.
> 

Same here, this is for BT HS UART.

-Shazad

> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>   arch/arm64/boot/dts/qcom/sa8775p-ride.dts | 34 +++++++++++++++++++++++
>   arch/arm64/boot/dts/qcom/sa8775p.dtsi     | 17 ++++++++++++
>   2 files changed, 51 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
> index d01ca3a9ee37..9aee6e4c1ba1 100644
> --- a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
> +++ b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
> @@ -13,6 +13,7 @@ / {
>   
>   	aliases {
>   		serial0 = &uart10;
> +		serial1 = &uart17;
>   		i2c18 = &i2c18;
>   		spi16 = &spi16;
>   	};
> @@ -66,6 +67,30 @@ qup_i2c18_default: qup-i2c18-state {
>   		drive-strength = <2>;
>   		bias-pull-up;
>   	};
> +
> +	qup_uart17_cts: qup-uart17-cts-state {
> +		pins = "gpio91";
> +		function = "qup2_se3";
> +		bias-disable;
> +	};
> +
> +	qup_uart17_rts: qup0_uart17_rts-state {
> +		pins = "gpio92";
> +		function = "qup2_se3";
> +		bias-pull-down;
> +	};
> +
> +	qup_uart17_tx: qup0_uart17_tx-state {
> +		pins = "gpio93";
> +		function = "qup2_se3";
> +		bias-pull-up;
> +	};
> +
> +	qup_uart17_rx: qup0_uart17_rx-state {
> +		pins = "gpio94";
> +		function = "qup2_se3";
> +		bias-pull-down;
> +	};
>   };
>   
>   &uart10 {
> @@ -75,6 +100,15 @@ &uart10 {
>   	status = "okay";
>   };
>   
> +&uart17 {
> +	pinctrl-0 = <&qup_uart17_cts>,
> +		    <&qup_uart17_rts>,
> +		    <&qup_uart17_tx>,
> +		    <&qup_uart17_rx>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +};
> +
>   &xo_board_clk {
>   	clock-frequency = <38400000>;
>   };
> diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> index 1abb545ff4f4..b009e1100c0a 100644
> --- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> @@ -524,6 +524,23 @@ &config_noc SLAVE_QUP_2 0>,
>   				status = "disabled";
>   			};
>   
> +			uart17: serial@88c000 {
> +				compatible = "qcom,geni-uart";
> +				reg = <0x0 0x88c000 0x0 0x4000>;
> +				interrupts-extended = <&intc GIC_SPI 585 IRQ_TYPE_LEVEL_HIGH>,
> +						      <&tlmm 94 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&gcc GCC_QUPV3_WRAP2_S3_CLK>;
> +				clock-names = "se";
> +				interconnects = <&clk_virt MASTER_QUP_CORE_2 0
> +						 &clk_virt SLAVE_QUP_CORE_2 0>,
> +						<&gem_noc MASTER_APPSS_PROC 0
> +						 &config_noc SLAVE_QUP_2 0>;
> +				interconnect-names = "qup-core",
> +						     "qup-config";
> +				power-domains = <&rpmhpd SA8775P_CX>;
> +				status = "disabled";
> +			};
> +
>   			i2c18: i2c@890000 {
>   				compatible = "qcom,geni-i2c";
>   				reg = <0x0 0x890000 0x0 0x4000>;
