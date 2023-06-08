Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57F6D7280D9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 15:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236648AbjFHNDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 09:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236611AbjFHNC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 09:02:56 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3645A1707;
        Thu,  8 Jun 2023 06:02:54 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3589O9ll007584;
        Thu, 8 Jun 2023 15:02:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=ejaaba8UeVacQJUONM9cP7HN8p5aNxGX9BhxAgM9wSo=;
 b=1CFxNfxJ1wZVeNhvewqeLwZoTmY1mz386EXF4XegWKT9SSqGXbctAuUaYP0nT72tHT45
 UFhPe6UE17w3GVPHPye2EakQ0nRUIXl+qTgivJKM+c1z/+j5bdZvjLr2sj28TdJ3/lD7
 iU7/kdXR1jmToXjfBH38irl8qAMshc6SKeEVItyL+wbCJ1uxo0v/HRxdstQcto70f4jD
 d5+s/IdFO0RW83EbFIFQjgKakI50Myq6t8bqxUjSj0bIXGh7RsibV5/WKbDMFS6xqAAA
 MbiYUuWRPrOea9Ux0Vo63QrEzqlYMDUCYkpheewAA8fH0NyN47TUVQp74oi+wOkFkCs2 9w== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3r3cax1e8x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Jun 2023 15:02:36 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id AD57C10003B;
        Thu,  8 Jun 2023 15:02:35 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A57C122F7AE;
        Thu,  8 Jun 2023 15:02:35 +0200 (CEST)
Received: from [10.201.21.93] (10.201.21.93) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Thu, 8 Jun
 2023 15:02:35 +0200
Message-ID: <b693811d-ac17-193e-377e-8859f8dedd89@foss.st.com>
Date:   Thu, 8 Jun 2023 15:02:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v1 6/8] ARM: dts: stm32: Add pinmux groups for Linux
 Automation GmbH TAC
Content-Language: en-US
To:     =?UTF-8?Q?Leonard_G=c3=b6hrs?= <l.goehrs@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
CC:     <kernel@pengutronix.de>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20230607115508.2964574-1-l.goehrs@pengutronix.de>
 <20230607115508.2964574-6-l.goehrs@pengutronix.de>
From:   Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20230607115508.2964574-6-l.goehrs@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.201.21.93]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-08_09,2023-06-08_01,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On 6/7/23 13:55, Leonard Göhrs wrote:
> Add pinmux groups required for the Linux Automation GmbH TAC.
> 
> Signed-off-by: Leonard Göhrs <l.goehrs@pengutronix.de>
> ---
>   arch/arm/boot/dts/stm32mp15-pinctrl.dtsi | 129 +++++++++++++++++++++++
>   1 file changed, 129 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi b/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi
> index e86d989dd351d..0c864461ca449 100644
> --- a/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi
> +++ b/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi
> @@ -6,6 +6,17 @@
>   #include <dt-bindings/pinctrl/stm32-pinfunc.h>
>   
>   &pinctrl {
> +	adc1_ain_pins_a: adc1-ain-0 {
> +		pins {
> +			pinmux = <STM32_PINMUX('F', 11, ANALOG)>, /* ADC1_INP2 */
> +				 <STM32_PINMUX('B', 1, ANALOG)>, /* ADC1_INP5 */
> +				 <STM32_PINMUX('B', 0, ANALOG)>, /* ADC1_INP9 */
> +				 <STM32_PINMUX('C', 0, ANALOG)>, /* ADC1_INP10 */
> +				 <STM32_PINMUX('C', 3, ANALOG)>, /* ADC1_INP13 */
> +				 <STM32_PINMUX('A', 3, ANALOG)>; /* ADC1_INP15 */
> +		};
> +	};
> +
>   	adc1_in6_pins_a: adc1-in6-0 {
>   		pins {
>   			pinmux = <STM32_PINMUX('F', 12, ANALOG)>;
> @@ -341,6 +352,46 @@ pins1 {
>   		};
>   	};
>   
> +	ethernet0_rgmii_pins_d: rgmii-1 {

xxx_pins_d is already defined for rgmii-3, it should be xxx_pins_e
And rgmii-1 is already defined, it should be rgmii-4. Don't forget to 
update boards files with new pinctrl names in eth node.

please rebase on top of stm32-next branch.

> +		pins1 {
> +			pinmux = <STM32_PINMUX('G', 4, AF11)>, /* ETH_RGMII_GTX_CLK */
> +				 <STM32_PINMUX('G', 13, AF11)>, /* ETH_RGMII_TXD0 */
> +				 <STM32_PINMUX('G', 14, AF11)>, /* ETH_RGMII_TXD1 */
> +				 <STM32_PINMUX('C', 2, AF11)>, /* ETH_RGMII_TXD2 */
> +				 <STM32_PINMUX('E', 2, AF11)>, /* ETH_RGMII_TXD3 */
> +				 <STM32_PINMUX('B', 11, AF11)>; /* ETH_RGMII_TX_CTL */
> +			bias-disable;
> +			drive-push-pull;
> +			slew-rate = <2>;
> +		};
> +		pins2 {
> +			pinmux = <STM32_PINMUX('C', 4, AF11)>, /* ETH_RGMII_RXD0 */
> +				 <STM32_PINMUX('C', 5, AF11)>, /* ETH_RGMII_RXD1 */
> +				 <STM32_PINMUX('H', 6, AF11)>, /* ETH_RGMII_RXD2 */
> +				 <STM32_PINMUX('H', 7, AF11)>, /* ETH_RGMII_RXD3 */
> +				 <STM32_PINMUX('A', 1, AF11)>, /* ETH_RGMII_RX_CLK */
> +				 <STM32_PINMUX('A', 7, AF11)>; /* ETH_RGMII_RX_CTL */
> +			bias-disable;
> +		};
> +	};
> +
> +	ethernet0_rgmii_sleep_pins_d: rgmii-sleep-1 {

xxx_pins_d is already defined for rgmii-3, it should be xxx_pins_e
rgmii-sleep-1 is already defined, it should be rgmii-sleep-4



> +		pins1 {
> +			pinmux = <STM32_PINMUX('G', 4, ANALOG)>, /* ETH_RGMII_GTX_CLK */
> +				 <STM32_PINMUX('G', 13, ANALOG)>, /* ETH_RGMII_TXD0 */
> +				 <STM32_PINMUX('G', 14, ANALOG)>, /* ETH_RGMII_TXD1 */
> +				 <STM32_PINMUX('C', 2, ANALOG)>, /* ETH_RGMII_TXD2 */
> +				 <STM32_PINMUX('E', 2, ANALOG)>, /* ETH_RGMII_TXD3 */
> +				 <STM32_PINMUX('B', 11, ANALOG)>, /* ETH_RGMII_TX_CTL */
> +				 <STM32_PINMUX('C', 4, ANALOG)>, /* ETH_RGMII_RXD0 */
> +				 <STM32_PINMUX('C', 5, ANALOG)>, /* ETH_RGMII_RXD1 */
> +				 <STM32_PINMUX('H', 6, ANALOG)>, /* ETH_RGMII_RXD2 */
> +				 <STM32_PINMUX('H', 7, ANALOG)>, /* ETH_RGMII_RXD3 */
> +				 <STM32_PINMUX('A', 1, ANALOG)>, /* ETH_RGMII_RX_CLK */
> +				 <STM32_PINMUX('A', 7, ANALOG)>; /* ETH_RGMII_RX_CTL */
> +		 };
> +	};
> +
>   	ethernet0_rmii_pins_a: rmii-0 {
>   		pins1 {
>   			pinmux = <STM32_PINMUX('G', 13, AF11)>, /* ETH1_RMII_TXD0 */
> @@ -1104,6 +1155,20 @@ pins {
>   		};
>   	};
>   
> +	pwm1_pins_c: pwm1-2 {
> +		pins {
> +			pinmux = <STM32_PINMUX('E', 11, AF1)>; /* TIM1_CH2 */
> +			drive-push-pull;
> +			slew-rate = <0>;
> +		};
> +	};
> +
> +	pwm1_sleep_pins_c: pwm1-sleep-2 {
> +		pins {
> +			pinmux = <STM32_PINMUX('E', 11, ANALOG)>; /* TIM1_CH2 */
> +		};
> +	};
> +
>   	pwm2_pins_a: pwm2-0 {
>   		pins {
>   			pinmux = <STM32_PINMUX('A', 3, AF1)>; /* TIM2_CH4 */
> @@ -1230,6 +1295,26 @@ pins {
>   		};
>   	};
>   
> +	pwm8_pins_b: pwm8-1 {
> +		pins {
> +			pinmux = <STM32_PINMUX('I', 5, AF3)>, /* TIM8_CH1 */
> +				 <STM32_PINMUX('I', 6, AF3)>, /* TIM8_CH2 */
> +				 <STM32_PINMUX('I', 7, AF3)>, /* TIM8_CH3 */
> +				 <STM32_PINMUX('C', 9, AF3)>; /* TIM8_CH4 */
> +			drive-push-pull;
> +			slew-rate = <0>;
> +		};
> +	};
> +
> +	pwm8_sleep_pins_b: pwm8-sleep-1 {
> +		pins {
> +			pinmux = <STM32_PINMUX('I', 5, ANALOG)>, /* TIM8_CH1 */
> +				 <STM32_PINMUX('I', 6, ANALOG)>, /* TIM8_CH2 */
> +				 <STM32_PINMUX('I', 7, ANALOG)>, /* TIM8_CH3 */
> +				 <STM32_PINMUX('C', 9, ANALOG)>; /* TIM8_CH4 */
> +		};
> +	};
> +
>   	pwm12_pins_a: pwm12-0 {
>   		pins {
>   			pinmux = <STM32_PINMUX('H', 6, AF2)>; /* TIM12_CH1 */
> @@ -1925,6 +2010,20 @@ pins2 {
>   		};
>   	};
>   
> +	spi2_pins_c: spi2-2 {
> +		pins1 {
> +			pinmux = <STM32_PINMUX('I', 1, AF5)>, /* SPI2_SCK */
> +				 <STM32_PINMUX('I', 3, AF5)>; /* SPI2_MOSI */
> +			bias-disable;
> +			drive-push-pull;
> +		};
> +
> +		pins2 {
> +			pinmux = <STM32_PINMUX('I', 2, AF5)>; /* SPI2_MISO */
> +			bias-pull-down;
> +		};
> +	};
> +
>   	spi4_pins_a: spi4-0 {
>   		pins {
>   			pinmux = <STM32_PINMUX('E', 12, AF5)>, /* SPI4_SCK */
> @@ -1939,6 +2038,21 @@ pins2 {
>   		};
>   	};
>   
> +	spi5_pins_a: spi5-0 {
> +		pins1 {
> +			pinmux = <STM32_PINMUX('F', 7, AF5)>, /* SPI5_SCK */
> +				 <STM32_PINMUX('F', 9, AF5)>; /* SPI5_MOSI */
> +			bias-disable;
> +			drive-push-pull;
> +			slew-rate = <1>;
> +		};
> +
> +		pins2 {
> +			pinmux = <STM32_PINMUX('F', 8, AF5)>; /* SPI5_MISO */
> +			bias-disable;
> +		};
> +	};
> +
>   	stusb1600_pins_a: stusb1600-0 {
>   		pins {
>   			pinmux = <STM32_PINMUX('I', 11, GPIO)>;
> @@ -2385,6 +2499,21 @@ pins {
>   		};
>   	};
>   
> +	usart3_pins_f: usart3-5 {
> +		pins1 {
> +			pinmux = <STM32_PINMUX('B', 10, AF7)>, /* USART3_TX */
> +				 <STM32_PINMUX('D', 12, AF7)>; /* USART3_RTS */
> +			bias-disable;
> +			drive-push-pull;
> +			slew-rate = <0>;
> +		};
> +		pins2 {
> +			pinmux = <STM32_PINMUX('B', 12, AF8)>, /* USART3_RX */
> +				 <STM32_PINMUX('D', 11, AF7)>; /* USART3_CTS_NSS */
> +			bias-disable;
> +		};
> +	};
> +
>   	usbotg_hs_pins_a: usbotg-hs-0 {
>   		pins {
>   			pinmux = <STM32_PINMUX('A', 10, ANALOG)>; /* OTG_ID */

