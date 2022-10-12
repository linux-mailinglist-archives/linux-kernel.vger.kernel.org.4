Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 491055FCA5A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 20:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbiJLSQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 14:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbiJLSQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 14:16:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AA5F17A94;
        Wed, 12 Oct 2022 11:16:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BB08461596;
        Wed, 12 Oct 2022 18:16:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3302C433D6;
        Wed, 12 Oct 2022 18:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665598601;
        bh=njqsGfY/Ky3JVGMiS1t2SsK1cQbO3ajg+b5VYn5YLhg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JAxG+GqtIRT+kWAS9WEr6WzSOwCaFxCxO7b05swAq0QvhU1Ot2RXPgVPxgPnAboc6
         b0oiKsHhiPjh/TsvTlUUoVLosVFwEkvurobiMs+nBfYi3xKCsoqs6V9SlHl7NZ0RN0
         /0sRjojU9BR42RRTMrf3b2YRriB/u+zRMrkicOJp7BV1pLnHYAzGJnCdNiklM/Axgq
         JwWi5mGYGznLJemfk1nWyD8ZWMO9AmeaxplqCAcIH8YSfMss0HDfgmOUEW0Mb0pzWQ
         DekmCLsJzMrLi4rI3Rd/p792Cm8jPIUyLxrALVTz7jA/RmiARn4HASy/PYuJ0hs56m
         0WIlUaN1DadkQ==
Date:   Wed, 12 Oct 2022 19:16:36 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc:     linux-riscv@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Alexandre Ghiti <alexandre.ghiti@canonical.com>,
        Bin Meng <bin.meng@windriver.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] riscv: dts: sifive unleashed: Add PWM controlled LEDs
Message-ID: <Y0cEhK+oDPpLiaFJ@spud>
References: <20221012110928.352910-1-emil.renner.berthing@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221012110928.352910-1-emil.renner.berthing@canonical.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 12, 2022 at 01:09:28PM +0200, Emil Renner Berthing wrote:
> This adds the 4 PWM controlled green LEDs to the HiFive Unleashed device
> tree. The schematic doesn't specify any special function for the LEDs,
> so they're added here without any default triggers and named d1, d2, d3
> and d4 just like in the schematic.
> 
> Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
> ---
> 
> Yes this board is old, but I'm trying to get rid of custom riscv patches in
> the Ubuntu kernel.

Old maybe, but some of us still have them ;)
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Twiddled the sysfs knobs a bit too so:
Tested-by: Conor Dooley <conor.dooley@microchip.com>

> 
>  .../boot/dts/sifive/hifive-unleashed-a00.dts  | 38 +++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 
> diff --git a/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts b/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
> index ced0d4e47938..900a50526d77 100644
> --- a/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
> +++ b/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
> @@ -3,6 +3,8 @@
>  
>  #include "fu540-c000.dtsi"
>  #include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/leds/common.h>
> +#include <dt-bindings/pwm/pwm.h>
>  
>  /* Clock frequency (in Hz) of the PCB crystal for rtcclk */
>  #define RTCCLK_FREQ		1000000
> @@ -42,6 +44,42 @@ gpio-restart {
>  		compatible = "gpio-restart";
>  		gpios = <&gpio 10 GPIO_ACTIVE_LOW>;
>  	};
> +
> +	led-controller {
> +		compatible = "pwm-leds";
> +
> +		led-d1 {
> +			pwms = <&pwm0 0 7812500 PWM_POLARITY_INVERTED>;
> +			active-low;
> +			color = <LED_COLOR_ID_GREEN>;
> +			max-brightness = <255>;
> +			label = "d1";
> +		};
> +
> +		led-d2 {
> +			pwms = <&pwm0 1 7812500 PWM_POLARITY_INVERTED>;
> +			active-low;
> +			color = <LED_COLOR_ID_GREEN>;
> +			max-brightness = <255>;
> +			label = "d2";
> +		};
> +
> +		led-d3 {
> +			pwms = <&pwm0 2 7812500 PWM_POLARITY_INVERTED>;
> +			active-low;
> +			color = <LED_COLOR_ID_GREEN>;
> +			max-brightness = <255>;
> +			label = "d3";
> +		};
> +
> +		led-d4 {
> +			pwms = <&pwm0 3 7812500 PWM_POLARITY_INVERTED>;
> +			active-low;
> +			color = <LED_COLOR_ID_GREEN>;
> +			max-brightness = <255>;
> +			label = "d4";
> +		};
> +	};
>  };
>  
>  &uart0 {
> -- 
> 2.37.2
> 
