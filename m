Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3B8B70B8CF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 11:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232812AbjEVJW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 05:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232450AbjEVJWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 05:22:22 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD25130;
        Mon, 22 May 2023 02:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1684747336; x=1716283336;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9wgoVQcS4YWLS1AIHBqlBKzD/FKjp01xpvNo+o/d9qY=;
  b=brXMHLFVk2X/tE0Gj1Nh1aAMbp5VwKq2O7pvizPk2xgp1laj71AlMH+n
   zw8q31Ik3swFQ3Es7l9fDeN/V/AztoPXVB1R1M2AQdsPWnm7eHxS+Mlqp
   XeL2txG0671A61xcVV7lwBLYxiVaZl0QT9gAXqXBQjrWTQo1THv6XFNWe
   tGZ/tJKEbA2kX1JaTQ75/wwsILMfzlwMpA2CGgJeSVO7YNE/h+PaJmUCq
   3zmPpjKNEbBp7kHFoe2sBautoIn34T5m5+Qs1alXKzVZT6KLOg9Y0GMCv
   UQtCo6x2uxFOAJIcyNtpTqw1bQQFVHo7NGCpCtgSegDM/ScIhOOBp+L09
   Q==;
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; 
   d="scan'208";a="212431537"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 May 2023 02:22:09 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 22 May 2023 02:22:08 -0700
Received: from [10.159.245.112] (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.21 via Frontend
 Transport; Mon, 22 May 2023 02:22:05 -0700
Message-ID: <8241a7ed-6c02-df96-fdcf-39339f50a6e0@microchip.com>
Date:   Mon, 22 May 2023 11:22:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 3/3] ARM: dts: at91: Return to boolean properties
Content-Language: en-US
To:     <Ryan.Wanner@microchip.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <alexandre.belloni@bootlin.com>, <claudiu.beznea@microchip.com>,
        <linus.walleij@linaro.org>, <ludovic.desroches@microchip.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>
References: <cover.1684313910.git.Ryan.Wanner@microchip.com>
 <6f06be9e393c02563bc877498c8af75daf3b47f8.1684313910.git.Ryan.Wanner@microchip.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <6f06be9e393c02563bc877498c8af75daf3b47f8.1684313910.git.Ryan.Wanner@microchip.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/05/2023 at 13:54, Ryan.Wanner@microchip.com wrote:
> From: Ryan Wanner <Ryan.Wanner@microchip.com>
> 
> Returning back to commit 0dc23d1a8e17
> ("arm: dts: at91: Fix boolean properties with values") as pinctrl driver no
> longer expects an integer value and expects a simple boolean property.
> 
> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>

Okay:
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Thanks for fixing this as well. Best regards,
   Nicolas

> ---
>   arch/arm/boot/dts/at91-kizbox3-hs.dts      | 2 +-
>   arch/arm/boot/dts/at91-kizbox3_common.dtsi | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/at91-kizbox3-hs.dts b/arch/arm/boot/dts/at91-kizbox3-hs.dts
> index 7075df6549e9..fec7269088d1 100644
> --- a/arch/arm/boot/dts/at91-kizbox3-hs.dts
> +++ b/arch/arm/boot/dts/at91-kizbox3-hs.dts
> @@ -225,7 +225,7 @@ pinctrl_pio_zbe_rst: gpio_zbe_rst {
>   		pinctrl_pio_io_reset: gpio_io_reset {
>   			pinmux = <PIN_PB30__GPIO>;
>   			bias-disable;
> -			drive-open-drain = <1>;
> +			drive-open-drain;
>   			output-low;
>   		};
>   		pinctrl_pio_input: gpio_input {
> diff --git a/arch/arm/boot/dts/at91-kizbox3_common.dtsi b/arch/arm/boot/dts/at91-kizbox3_common.dtsi
> index abe27adfa4d6..465664628419 100644
> --- a/arch/arm/boot/dts/at91-kizbox3_common.dtsi
> +++ b/arch/arm/boot/dts/at91-kizbox3_common.dtsi
> @@ -211,7 +211,7 @@ pinctrl_flx4_default: flx4_i2c6_default {
>   		pinmux = <PIN_PD12__FLEXCOM4_IO0>, //DATA
>   		<PIN_PD13__FLEXCOM4_IO1>; //CLK
>   		bias-disable;
> -		drive-open-drain = <1>;
> +		drive-open-drain;
>   	};
>   
>   	pinctrl_pwm0 {

-- 
Nicolas Ferre

