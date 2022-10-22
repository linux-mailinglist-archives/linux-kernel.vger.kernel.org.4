Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F022608D29
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 14:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbiJVMXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 08:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbiJVMXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 08:23:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93E032A5237;
        Sat, 22 Oct 2022 05:23:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3B86BB82EFA;
        Sat, 22 Oct 2022 12:23:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE888C433C1;
        Sat, 22 Oct 2022 12:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666441413;
        bh=32yzXNpBtDdt3SRjly46VTH7IAm6cK3dN6rsTopAPks=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Dx60zoKiuo/+OPUi7OaO2iRz26IKWTwOvCuxtSKKG23C8hVeP3YshJEUgYDFW1mIn
         EZv7I7dEIUuxZnTJmTXa7nlOx7cfavpApmeGzyw/zpQ/prP4GTH1O9vJP1X4uDx9qL
         OdnhKdh9HTz787XTxO9lMoSHBPtrsUy6Ye7TyCpyFcKTS7C4HBm1mKxCsGmorOxx/H
         A/H0UBChqQ0AzmtCEiIQqZxoooVjJcplzUOoFtOztbhnGjgR5vC+HpgGapUiHY4Iug
         MiNqlpUFRlUZO/TXgZfYdNTIkwpKB0mFB7wOOBYkeLVDZEnCmaR+GZqYLxrLJjEHvU
         QvvcQgicz/QrQ==
Date:   Sat, 22 Oct 2022 13:23:28 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] riscv: dts: icicle: Add GPIO controlled LEDs
Message-ID: <Y1PgwLMbZAr7hOhq@spud>
References: <20221020083854.1127643-1-emil.renner.berthing@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221020083854.1127643-1-emil.renner.berthing@canonical.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 10:38:54AM +0200, Emil Renner Berthing wrote:
> This adds the 4 GPIO controlled LEDs to the Microchip PolarFire-SoC
> Icicle Kit device tree. The schematic doesn't specify any special
> function for the LEDs, so they're added here without any default
> triggers and named led1, led2, led3 and led4 just like in the schematic.
> 
> Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>

Hey Emil,

I applied this with a a minor modification to the subject & a
s/This adds/Add/. Messing w/ my setup so no b4-ty mail, but it should be
here:
https://git.kernel.org/conor/c/0d814000ad3589bf4f69c9cb25a3b77bbd55ffec

Thanks,
Conor.

> ---
>  .../boot/dts/microchip/mpfs-icicle-kit.dts    | 30 +++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/arch/riscv/boot/dts/microchip/mpfs-icicle-kit.dts b/arch/riscv/boot/dts/microchip/mpfs-icicle-kit.dts
> index ec7b7c2a3ce2..11ba4417f11a 100644
> --- a/arch/riscv/boot/dts/microchip/mpfs-icicle-kit.dts
> +++ b/arch/riscv/boot/dts/microchip/mpfs-icicle-kit.dts
> @@ -5,6 +5,8 @@
>  
>  #include "mpfs.dtsi"
>  #include "mpfs-icicle-kit-fabric.dtsi"
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/leds/common.h>
>  
>  /* Clock frequency (in Hz) of the rtcclk */
>  #define RTCCLK_FREQ		1000000
> @@ -31,6 +33,34 @@ cpus {
>  		timebase-frequency = <RTCCLK_FREQ>;
>  	};
>  
> +	leds {
> +		compatible = "gpio-leds";
> +
> +		led-1 {
> +			gpios = <&gpio2 16 GPIO_ACTIVE_HIGH>;
> +			color = <LED_COLOR_ID_RED>;
> +			label = "led1";
> +		};
> +
> +		led-2 {
> +			gpios = <&gpio2 17 GPIO_ACTIVE_HIGH>;
> +			color = <LED_COLOR_ID_RED>;
> +			label = "led2";
> +		};
> +
> +		led-3 {
> +			gpios = <&gpio2 18 GPIO_ACTIVE_HIGH>;
> +			color = <LED_COLOR_ID_AMBER>;
> +			label = "led3";
> +		};
> +
> +		led-4 {
> +			gpios = <&gpio2 19 GPIO_ACTIVE_HIGH>;
> +			color = <LED_COLOR_ID_AMBER>;
> +			label = "led4";
> +		};
> +	};
> +
>  	ddrc_cache_lo: memory@80000000 {
>  		device_type = "memory";
>  		reg = <0x0 0x80000000 0x0 0x40000000>;
> -- 
> 2.37.2
> 
