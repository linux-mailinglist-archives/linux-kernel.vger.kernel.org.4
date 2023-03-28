Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF396CBB3F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 11:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232590AbjC1JkD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 05:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230511AbjC1Jjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 05:39:44 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 536C05FF9;
        Tue, 28 Mar 2023 02:39:33 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32S8TEUR024888;
        Tue, 28 Mar 2023 11:39:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=0RJ1bAOEsbrbBUbktgDCARu+ofitrNwEQZP29DHw0Xc=;
 b=FclllhCUSri2Sw8fWEu0rOCbbZELP+Wy/xR6/0eWvq4Q/agWyfx2GZEh5kMzDX3xvo/W
 /V/OA2zJQYmJvEiCVTuza6/33lH4ND65i75ZWVj36rHJvP15PLOM+2Vj4uOfmoE9RP2f
 zxNkgrXmSVRCcf4skHXVmRofVhDg0Qn1wHhFHAf3JhBBWgEw3B9RC56LgO398QXP8cSD
 oG0LCCT5jWKnk/hJoxi1ZVPbVWwg4xRu3g77ZkQihSuI/dC8sEAx9MxrH1XlON2RwADG
 r8GSuebN4fW5SKtpY2ZpILEAsXULJ20g7c3rzSl3evTOoP2hV/wqU0mzm1NdJvHFCbq2 bw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3pkvs4rhjk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Mar 2023 11:39:21 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id DCE9C10002A;
        Tue, 28 Mar 2023 11:39:20 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D2B1521160B;
        Tue, 28 Mar 2023 11:39:20 +0200 (CEST)
Received: from [10.201.21.93] (10.201.21.93) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Tue, 28 Mar
 2023 11:39:20 +0200
Message-ID: <30a9f919-ff6b-57cf-de34-e145a4474643@foss.st.com>
Date:   Tue, 28 Mar 2023 11:39:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] ARM: dts: stm32: fix spi1 pin assignment on stm32mp15
Content-Language: en-US
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <linux@rempel-privat.de>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-kernel@vger.kernel.org>
References: <20230320171123.6263-1-alexandre.torgue@foss.st.com>
From:   Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20230320171123.6263-1-alexandre.torgue@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.21.93]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-27_02,2023-02-09_01
X-Spam-Status: No, score=-0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/20/23 18:11, Alexandre Torgue wrote:
> Bank A and B IOs can't be handled by the pin controller 'Z'. This patch
> assign spi1 pin definition to the correct controller.
> 
> Fixes: 9ad65d245b7b ("ARM: dts: stm32: stm32mp15-pinctrl: add spi1-1 pinmux group")
> 
> Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>
> 
> diff --git a/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi b/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi
> index a9d2bec99014..e15a3b2a9b39 100644
> --- a/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi
> +++ b/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi
> @@ -1880,6 +1880,21 @@
>   		};
>   	};
>   
> +	spi1_pins_b: spi1-1 {
> +		pins1 {
> +			pinmux = <STM32_PINMUX('A', 5, AF5)>, /* SPI1_SCK */
> +				 <STM32_PINMUX('B', 5, AF5)>; /* SPI1_MOSI */
> +			bias-disable;
> +			drive-push-pull;
> +			slew-rate = <1>;
> +		};
> +
> +		pins2 {
> +			pinmux = <STM32_PINMUX('A', 6, AF5)>; /* SPI1_MISO */
> +			bias-disable;
> +		};
> +	};
> +
>   	spi2_pins_a: spi2-0 {
>   		pins1 {
>   			pinmux = <STM32_PINMUX('B', 10, AF5)>, /* SPI2_SCK */
> @@ -2448,19 +2463,4 @@
>   			bias-disable;
>   		};
>   	};
> -
> -	spi1_pins_b: spi1-1 {
> -		pins1 {
> -			pinmux = <STM32_PINMUX('A', 5, AF5)>, /* SPI1_SCK */
> -				 <STM32_PINMUX('B', 5, AF5)>; /* SPI1_MOSI */
> -			bias-disable;
> -			drive-push-pull;
> -			slew-rate = <1>;
> -		};
> -
> -		pins2 {
> -			pinmux = <STM32_PINMUX('A', 6, AF5)>; /* SPI1_MISO */
> -			bias-disable;
> -		};
> -	};
>   };

Applied on stm32-next.

Thanks.
Alex
