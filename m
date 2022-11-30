Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 620CF63D8B2
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 16:01:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbiK3PBc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 10:01:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbiK3PB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 10:01:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA8884044F;
        Wed, 30 Nov 2022 07:01:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8F7B7B81B91;
        Wed, 30 Nov 2022 15:01:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCCEDC433C1;
        Wed, 30 Nov 2022 15:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669820481;
        bh=f7k5+MwLhnv0w4aj9oGyn+xDnTRTARWIm2GpQWgV4sk=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=ouYuIP0lUO6Wn3Y1klaSrWtBr14U++DFmKw7pseor/vLPa7q0fCV19WJC2SUipdwm
         PRLIUjZNbk2qFvj9cVbT91z4i0koEOpYPB16G4ffzCtt0p7k9BE1S3w0AFLLfA54ne
         V5u2We8K9TtYPJqYU7+LYil0Hk0oxhXpuvB+zvDRTXhDovHlVadiqXkLO6rAIZePw0
         c7/7jiU9wZ8ErIL3qctvGFhJvjH/cwZjo2RO/Q/vFaHWgxrf+u6FOEoglRQNxAD8YK
         QKouDh9m4fFUR/gveQNYIB65fsdDycw7PoaW/UPZVIuguFgqcLipLVfh5Z18l2PvvF
         REpGJDvd0/VLg==
Message-ID: <720cae36-ce6a-eec3-7d19-1f4ebca1b3ab@kernel.org>
Date:   Wed, 30 Nov 2022 09:01:19 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 2/2] ARM: dts: socfpga: align LED node names with dtschema
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221125144236.477416-1-krzysztof.kozlowski@linaro.org>
 <20221125144236.477416-2-krzysztof.kozlowski@linaro.org>
From:   Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <20221125144236.477416-2-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/25/22 08:42, Krzysztof Kozlowski wrote:
> The node names should be generic and DT schema expects certain pattern:
> 
>    socfpga_arria5_socdk.dtb: leds: 'hps0', 'hps1', 'hps2', 'hps3' do not match any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   arch/arm/boot/dts/socfpga_arria5_socdk.dts          | 8 ++++----
>   arch/arm/boot/dts/socfpga_cyclone5_de0_nano_soc.dts | 2 +-
>   arch/arm/boot/dts/socfpga_cyclone5_socdk.dts        | 8 ++++----
>   3 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/socfpga_arria5_socdk.dts b/arch/arm/boot/dts/socfpga_arria5_socdk.dts
> index 7f5458d8fccc..c48385702a85 100644
> --- a/arch/arm/boot/dts/socfpga_arria5_socdk.dts
> +++ b/arch/arm/boot/dts/socfpga_arria5_socdk.dts
> @@ -29,22 +29,22 @@ aliases {
>   
>   	leds {
>   		compatible = "gpio-leds";
> -		hps0 {
> +		led-hps0 {
>   			label = "hps_led0";
>   			gpios = <&porta 0 1>;
>   		};
>   
> -		hps1 {
> +		led-hps1 {
>   			label = "hps_led1";
>   			gpios = <&portb 11 1>;
>   		};
>   
> -		hps2 {
> +		led-hps2 {
>   			label = "hps_led2";
>   			gpios = <&porta 17 1>;
>   		};
>   
> -		hps3 {
> +		led-hps3 {
>   			label = "hps_led3";
>   			gpios = <&porta 18 1>;
>   		};
> diff --git a/arch/arm/boot/dts/socfpga_cyclone5_de0_nano_soc.dts b/arch/arm/boot/dts/socfpga_cyclone5_de0_nano_soc.dts
> index c8f051fb2bf6..bedf577cb056 100644
> --- a/arch/arm/boot/dts/socfpga_cyclone5_de0_nano_soc.dts
> +++ b/arch/arm/boot/dts/socfpga_cyclone5_de0_nano_soc.dts
> @@ -33,7 +33,7 @@ regulator_3_3v: regulator {
>   
>   	leds {
>   		compatible = "gpio-leds";
> -		hps0 {
> +		led-hps0 {
>   			label = "hps_led0";
>   			gpios = <&portb 24 0>;
>   			linux,default-trigger = "heartbeat";
> diff --git a/arch/arm/boot/dts/socfpga_cyclone5_socdk.dts b/arch/arm/boot/dts/socfpga_cyclone5_socdk.dts
> index b2241205c7a9..c7f5fa0ba0f2 100644
> --- a/arch/arm/boot/dts/socfpga_cyclone5_socdk.dts
> +++ b/arch/arm/boot/dts/socfpga_cyclone5_socdk.dts
> @@ -29,22 +29,22 @@ aliases {
>   
>   	leds {
>   		compatible = "gpio-leds";
> -		hps0 {
> +		led-hps0 {
>   			label = "hps_led0";
>   			gpios = <&portb 15 1>;
>   		};
>   
> -		hps1 {
> +		led-hps1 {
>   			label = "hps_led1";
>   			gpios = <&portb 14 1>;
>   		};
>   
> -		hps2 {
> +		led-hps2 {
>   			label = "hps_led2";
>   			gpios = <&portb 13 1>;
>   		};
>   
> -		hps3 {
> +		led-hps3 {
>   			label = "hps_led3";
>   			gpios = <&portb 12 1>;
>   		};


Both patches applied!

Thanks,
Dinh
