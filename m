Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1F1A7293A1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 10:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239380AbjFIItF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 04:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239070AbjFIIss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 04:48:48 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E018D95;
        Fri,  9 Jun 2023 01:48:46 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3597Yl8X001707;
        Fri, 9 Jun 2023 10:48:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=WGDsEtUbQjsFvu7ULw3SCAN8yQ9+asPwuUzhHmCHuYc=;
 b=Dgq4AotzIwyeLTgkdSSO3dIVUrJ6wBZpQWY+JET8WQjE6qMNvbnz7G1hfin3AEOFxHx8
 TU/sCueaQESuo3KblLYJRXHYhXshOFsoeJ2PPIMH8DmuDKZ1cOpag5GkXaHwHOnv3wG2
 mnwVHsRkYmfl0yDDAcwM3/y3jUINPPL9bMARX24yMXLPFxOVQvTpNKZzgp2DRfk7bVgo
 lGncF0yF8RNbs0x3deMn8HHhDbXaeP5NpK6673XeBjTNEwv6QilFv7Fngms7piJ9VJOB
 zhkOlNXKA5j2Mi2oZSPyxBqnGoYu0gxQWyp8FwuoCEMnD/dd+v33Sc59CYc7HQii9QNx UA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3r3tkttgh3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Jun 2023 10:48:18 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4379810002A;
        Fri,  9 Jun 2023 10:48:17 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 35F7B21A204;
        Fri,  9 Jun 2023 10:48:17 +0200 (CEST)
Received: from [10.252.21.206] (10.252.21.206) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Fri, 9 Jun
 2023 10:48:16 +0200
Message-ID: <1b8e744f-96e7-4f36-68da-9e82d3f8d0c5@foss.st.com>
Date:   Fri, 9 Jun 2023 10:48:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [Linux-stm32] [RFC PATCH 1/5] ARM: dts: stm32: Add alternate
 pinmux for i2s pins
To:     Sean Nyekjaer <sean@geanix.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dantuguf14105@gmail.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230606145555.2155664-1-sean@geanix.com>
Content-Language: en-US
From:   Olivier MOYSAN <olivier.moysan@foss.st.com>
In-Reply-To: <20230606145555.2155664-1-sean@geanix.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.252.21.206]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-09_06,2023-06-08_01,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sean,

You can add my:
Reviewed-by: Olivier Moysan <olivier.moysan@foss.st.com>

Thanks
Olivier

On 6/6/23 16:55, Sean Nyekjaer wrote:
> Add another mux option for i2s pins, this is used on Octavo OSD32MP1-RED board.
> 
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> ---
>   arch/arm/boot/dts/stm32mp15-pinctrl.dtsi | 19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi b/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi
> index e86d989dd351..d79f89f37bc7 100644
> --- a/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi
> +++ b/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi
> @@ -686,6 +686,25 @@ pins {
>   		};
>   	};
>   
> +	i2s2_pins_b: i2s2-1 {
> +		pins {
> +			pinmux = <STM32_PINMUX('C',  3, AF5)>, /* I2S2_SDO */
> +				 <STM32_PINMUX('B', 12, AF5)>, /* I2S2_WS */
> +				 <STM32_PINMUX('B', 13, AF5)>; /* I2S2_CK */
> +			bias-disable;
> +			drive-push-pull;
> +			slew-rate = <1>;
> +		};
> +	};
> +
> +	i2s2_sleep_pins_b: i2s2-sleep-1 {
> +		pins {
> +			pinmux = <STM32_PINMUX('C', 3, ANALOG)>, /* I2S2_SDO */
> +				 <STM32_PINMUX('B', 12, ANALOG)>, /* I2S2_WS */
> +				 <STM32_PINMUX('B', 13, ANALOG)>; /* I2S2_CK */
> +		};
> +	};
> +
>   	ltdc_pins_a: ltdc-0 {
>   		pins {
>   			pinmux = <STM32_PINMUX('G',  7, AF14)>, /* LCD_CLK */
