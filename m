Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDF506D0FD3
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 22:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbjC3UPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 16:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjC3UPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 16:15:43 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0860310A85;
        Thu, 30 Mar 2023 13:15:32 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32UIurar029465;
        Thu, 30 Mar 2023 20:15:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=KAVpW8Nb7Qii15X6Z3Bsc9IGktV0LxSE3LrJvzFQW2Y=;
 b=FrvdsMUtQVa4MuWKBSdK1IMXpso7lNRPK8WuwZUf05dzqTWHBgBX7tmPLE/Kk4dNWMXs
 V5CbVfZ9zDlQYPYnB7ZVpMk8s0Mmgc6rhYhX1XqiTk3E6aSrWg2yUxk1j8bQG2eGVuAG
 K3yYz7Uw5FeqoTndW3RKktf3t6OPoKvA1rkPP1571hvno1CANzdlZmGPmJpzZbm1hFcg
 AI1hS3q/pY4J2u+02rwfxMVvrIfPC71nhXRax9Rmk9K0cvnMnV3FoHbsiiffXjL5p1pl
 IcxpKDJJBHc3CdNX6KHUgAekzvsp07XTdFlOAMIV1MXYjcTVJrrSpSIfxDCU8mmtzuoy Ew== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3png55g50s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Mar 2023 20:15:13 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32UKFCww015920
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Mar 2023 20:15:12 GMT
Received: from [10.216.46.49] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Thu, 30 Mar
 2023 13:15:08 -0700
Message-ID: <1772ce2e-9a52-7fc6-62bc-990755ca63ab@quicinc.com>
Date:   Fri, 31 Mar 2023 01:45:05 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 2/2] arm64: dts: qcom: ipq9574: add few device nodes
Content-Language: en-US
To:     Kathiravan T <quic_kathirav@quicinc.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <wim@linux-watchdog.org>, <linux@roeck-us.net>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-watchdog@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230329053726.14860-1-quic_kathirav@quicinc.com>
 <20230329053726.14860-3-quic_kathirav@quicinc.com>
From:   Sricharan Ramabadhran <quic_srichara@quicinc.com>
In-Reply-To: <20230329053726.14860-3-quic_kathirav@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: wpPGp2eGdBZbyMPN701M6AcvA0eHUkea
X-Proofpoint-ORIG-GUID: wpPGp2eGdBZbyMPN701M6AcvA0eHUkea
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-30_13,2023-03-30_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 mlxlogscore=999 adultscore=0 clxscore=1011 phishscore=0 malwarescore=0
 suspectscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2303300160
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/29/2023 11:07 AM, Kathiravan T wrote:
> Add QUP(SPI / I2C) peripheral, PRNG, WDOG and the remaining UART nodes.
> While at it, enable the SPI NOR in RDP433 board.
> 
> Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
> ---
>   arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts |  21 ++
>   arch/arm64/boot/dts/qcom/ipq9574.dtsi       | 202 ++++++++++++++++++++
>   2 files changed, 223 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts b/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
> index 2ce8e09e7565..7be578017bf7 100644
> --- a/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
> +++ b/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
> @@ -29,6 +29,20 @@
>   	status = "okay";
>   };
>   
> +&blsp1_spi0 {
> +	pinctrl-0 = <&spi_0_pins>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +
> +	flash@0 {
> +		compatible = "micron,n25q128a11", "jedec,spi-nor";
> +		reg = <0>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		spi-max-frequency = <50000000>;
> +	};
> +};
> +
>   &sdhc_1 {
>   	pinctrl-0 = <&sdc_default_state>;
>   	pinctrl-names = "default";
> @@ -77,6 +91,13 @@
>   			bias-pull-down;
>   		};
>   	};
> +
> +	spi_0_pins: spi-0-state {
> +		pins = "gpio11", "gpio12", "gpio13", "gpio14";
> +		function = "blsp0_spi";
> +		drive-strength = <8>;
> +		bias-disable;
> +	};
>   };
>   
>   &xo_board_clk {
> diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> index 14a3396b0381..f3da0190284c 100644
> --- a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> @@ -122,6 +122,13 @@
>   		#size-cells = <1>;
>   		ranges = <0 0 0 0xffffffff>;
>   
> +		rng: rng@e3000 {
> +			compatible = "qcom,prng-ee";
> +			reg = <0x000e3000 0x1000>;
> +			clocks = <&gcc GCC_PRNG_AHB_CLK>;
> +			clock-names = "core";
> +		};
> +
>   		tlmm: pinctrl@1000000 {
>   			compatible = "qcom,ipq9574-tlmm";
>   			reg = <0x01000000 0x300000>;
> @@ -184,6 +191,36 @@
>   			status = "disabled";
>   		};
>   
> +		blsp_dma: dma-controller@7884000 {
> +			compatible = "qcom,bam-v1.7.0";
> +			reg = <0x07884000 0x2b000>;

  Does the size needs to be 0x2b000 really ?

Regards,
  Sricharan

> +			interrupts = <GIC_SPI 238 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&gcc GCC_BLSP1_AHB_CLK>;
> +			clock-names = "bam_clk";
> +			#dma-cells = <1>;
> +			qcom,ee = <0>;
> +		};
> +
> +		blsp1_uart0: serial@78af000 {
> +			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
> +			reg = <0x078af000 0x200>;
> +			interrupts = <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&gcc GCC_BLSP1_UART1_APPS_CLK>,
> +				 <&gcc GCC_BLSP1_AHB_CLK>;
> +			clock-names = "core", "iface";
> +			status = "disabled";
> +		};
> +
> +		blsp1_uart1: serial@78b0000 {
> +			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
> +			reg = <0x078b0000 0x200>;
> +			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&gcc GCC_BLSP1_UART2_APPS_CLK>,
> +				 <&gcc GCC_BLSP1_AHB_CLK>;
> +			clock-names = "core", "iface";
> +			status = "disabled";
> +		};
> +
>   		blsp1_uart2: serial@78b1000 {
>   			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
>   			reg = <0x078b1000 0x200>;
> @@ -194,6 +231,163 @@
>   			status = "disabled";
>   		};
>   
> +		blsp1_uart3: serial@78b2000 {
> +			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
> +			reg = <0x078b2000 0x200>;
> +			interrupts = <GIC_SPI 307 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&gcc GCC_BLSP1_UART4_APPS_CLK>,
> +				 <&gcc GCC_BLSP1_AHB_CLK>;
> +			clock-names = "core", "iface";
> +			status = "disabled";
> +		};
> +
> +		blsp1_uart4: serial@78b3000 {
> +			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
> +			reg = <0x078b3000 0x200>;
> +			interrupts = <GIC_SPI 308 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&gcc GCC_BLSP1_UART5_APPS_CLK>,
> +				 <&gcc GCC_BLSP1_AHB_CLK>;
> +			clock-names = "core", "iface";
> +			status = "disabled";
> +		};
> +
> +		blsp1_uart5: serial@78b4000 {
> +			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
> +			reg = <0x078b4000 0x200>;
> +			interrupts = <GIC_SPI 309 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&gcc GCC_BLSP1_UART6_APPS_CLK>,
> +				 <&gcc GCC_BLSP1_AHB_CLK>;
> +			clock-names = "core", "iface";
> +			status = "disabled";
> +		};
> +
> +		blsp1_spi0: spi@78b5000 {
> +			compatible = "qcom,spi-qup-v2.2.1";
> +			reg = <0x078b5000 0x600>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			interrupts = <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&gcc GCC_BLSP1_QUP1_SPI_APPS_CLK>,
> +				 <&gcc GCC_BLSP1_AHB_CLK>;
> +			clock-names = "core", "iface";
> +			dmas = <&blsp_dma 12>, <&blsp_dma 13>;
> +			dma-names = "tx", "rx";
> +			status = "disabled";
> +		};
> +
> +		blsp1_i2c1: i2c@78b6000 {
> +			compatible = "qcom,i2c-qup-v2.2.1";
> +			reg = <0x078b6000 0x600>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&gcc GCC_BLSP1_QUP2_I2C_APPS_CLK>,
> +				 <&gcc GCC_BLSP1_AHB_CLK>;
> +			clock-names = "core", "iface";
> +			dmas = <&blsp_dma 14>, <&blsp_dma 15>;
> +			dma-names = "tx", "rx";
> +			status = "disabled";
> +		};
> +
> +		blsp1_spi1: spi@78b6000 {
> +			compatible = "qcom,spi-qup-v2.2.1";
> +			reg = <0x078b6000 0x600>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&gcc GCC_BLSP1_QUP2_SPI_APPS_CLK>,
> +				 <&gcc GCC_BLSP1_AHB_CLK>;
> +			clock-names = "core", "iface";
> +			dmas = <&blsp_dma 14>, <&blsp_dma 15>;
> +			dma-names = "tx", "rx";
> +			status = "disabled";
> +		};
> +
> +		blsp1_i2c2: i2c@78b7000 {
> +			compatible = "qcom,i2c-qup-v2.2.1";
> +			reg = <0x078b7000 0x600>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&gcc GCC_BLSP1_QUP3_I2C_APPS_CLK>,
> +				 <&gcc GCC_BLSP1_AHB_CLK>;
> +			clock-names = "core", "iface";
> +			dmas = <&blsp_dma 16>, <&blsp_dma 17>;
> +			dma-names = "tx", "rx";
> +			status = "disabled";
> +		};
> +
> +		blsp1_spi2: spi@78b7000 {
> +			compatible = "qcom,spi-qup-v2.2.1";
> +			reg = <0x078b7000 0x600>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&gcc GCC_BLSP1_QUP3_SPI_APPS_CLK>,
> +				 <&gcc GCC_BLSP1_AHB_CLK>;
> +			clock-names = "core", "iface";
> +			dmas = <&blsp_dma 16>, <&blsp_dma 17>;
> +			dma-names = "tx", "rx";
> +			status = "disabled";
> +		};
> +
> +		blsp1_i2c3: i2c@78b8000 {
> +			compatible = "qcom,i2c-qup-v2.2.1";
> +			reg = <0x078b8000 0x600>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&gcc GCC_BLSP1_QUP4_I2C_APPS_CLK>,
> +				 <&gcc GCC_BLSP1_AHB_CLK>;
> +			clock-names = "core", "iface";
> +			dmas = <&blsp_dma 18>, <&blsp_dma 19>;
> +			dma-names = "tx", "rx";
> +			status = "disabled";
> +		};
> +
> +		blsp1_spi3: spi@78b8000 {
> +			compatible = "qcom,spi-qup-v2.2.1";
> +			reg = <0x078b8000 0x600>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
> +			spi-max-frequency = <50000000>;
> +			clocks = <&gcc GCC_BLSP1_QUP4_SPI_APPS_CLK>,
> +				 <&gcc GCC_BLSP1_AHB_CLK>;
> +			clock-names = "core", "iface";
> +			dmas = <&blsp_dma 18>, <&blsp_dma 19>;
> +			dma-names = "tx", "rx";
> +			status = "disabled";
> +		};
> +
> +		blsp1_i2c4: i2c@78b9000 {
> +			compatible = "qcom,i2c-qup-v2.2.1";
> +			reg = <0x078b9000 0x600>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			interrupts = <GIC_SPI 299 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&gcc GCC_BLSP1_QUP5_I2C_APPS_CLK>,
> +				 <&gcc GCC_BLSP1_AHB_CLK>;
> +			clock-names = "core", "iface";
> +			dmas = <&blsp_dma 20>, <&blsp_dma 21>;
> +			dma-names = "tx", "rx";
> +			status = "disabled";
> +		};
> +
> +		blsp1_spi4: spi@78b9000 {
> +			compatible = "qcom,spi-qup-v2.2.1";
> +			reg = <0x078b9000 0x600>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			interrupts = <GIC_SPI 299 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&gcc GCC_BLSP1_QUP5_SPI_APPS_CLK>,
> +				 <&gcc GCC_BLSP1_AHB_CLK>;
> +			clock-names = "core", "iface";
> +			dmas = <&blsp_dma 20>, <&blsp_dma 21>;
> +			dma-names = "tx", "rx";
> +			status = "disabled";
> +		};
> +
>   		intc: interrupt-controller@b000000 {
>   			compatible = "qcom,msm-qgic2";
>   			reg = <0x0b000000 0x1000>,  /* GICD */
> @@ -226,6 +420,14 @@
>   			};
>   		};
>   
> +		watchdog: watchdog@b017000 {
> +			compatible = "qcom,apss-wdt-ipq9574", "qcom,kpss-wdt";
> +			reg = <0x0b017000 0x1000>;
> +			interrupts = <GIC_SPI 3 IRQ_TYPE_EDGE_RISING>;
> +			clocks = <&sleep_clk>;
> +			timeout-sec = <30>;
> +		};
> +
>   		timer@b120000 {
>   			compatible = "arm,armv7-timer-mem";
>   			reg = <0x0b120000 0x1000>;
