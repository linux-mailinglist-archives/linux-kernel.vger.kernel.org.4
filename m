Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA148634DDF
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 03:28:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235324AbiKWC2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 21:28:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234023AbiKWC2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 21:28:45 -0500
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A942CE0688;
        Tue, 22 Nov 2022 18:28:44 -0800 (PST)
Received: by mail-io1-f48.google.com with SMTP id d123so12304692iof.7;
        Tue, 22 Nov 2022 18:28:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zj/cHXoWYv8o+sJtjgpTEuZhl2QFJwpoNEmZc0bJX4o=;
        b=LZNzM8+JJ7lrE8r/ulXIQJp0xYR08MeWSqUzfe0HPVcyZbTRP13D56g80prls5L+Dt
         GyF2RoXg7N8ev+YzmiyP0E34kFpJZtGJGH3dAuYAtt/5IWLF7SeGIUL/L48hnPW6qFnP
         4J5hIloqlrJAdbvbOEbmyHkvKBqIDwW0h0Duj6eNV0orhooPktoM5rq9BgqZCFnWJoSh
         mnnW9lAyQ4kqbHLuzixcapcQTdIMsX2EH89g+zCFOqkfVHDWh+y8lBer/pKlfnGNWmfg
         dAuULYayAVzIOapTgiTWOw+8FabAIE+QkyOB8RhS1h/nyG4jaKtz4YmDsZVTfKTuciWB
         cahQ==
X-Gm-Message-State: ANoB5plsG92ku+NJK5jOll8RJlFo//25b07YHYMuuwaIvjhQfKEHnGZX
        CFoY1IpLFX1puuH/qfw2HA==
X-Google-Smtp-Source: AA0mqf5ZqoZAZyZrDERM++koEMloL+V38iwkLLRL0dZkuFkaBLcJ31HFzf+6xYoJWh5V3n3G2HUkzQ==
X-Received: by 2002:a05:6638:440f:b0:375:1820:bb85 with SMTP id bp15-20020a056638440f00b003751820bb85mr11758692jab.46.1669170523964;
        Tue, 22 Nov 2022 18:28:43 -0800 (PST)
Received: from robh_at_kernel.org ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id l18-20020a02a892000000b003636cb862d0sm5949379jam.42.2022.11.22.18.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 18:28:43 -0800 (PST)
Received: (nullmailer pid 1022635 invoked by uid 1000);
        Wed, 23 Nov 2022 02:28:45 -0000
Date:   Tue, 22 Nov 2022 20:28:45 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sasha Finkelstein <fnkl.kernel@gmail.com>
Cc:     thierry.reding@gmail.com, krzysztof.kozlowski+dt@linaro.org,
        marcan@marcan.st, sven@svenpeter.dev, alyssa@rosenzweig.io,
        asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v3 3/4] arm64: dts: apple: t8103: Add PWM
 controller
Message-ID: <20221123022845.GB1006695-robh@kernel.org>
References: <20221121174228.93670-1-fnkl.kernel@gmail.com>
 <20221121174228.93670-4-fnkl.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221121174228.93670-4-fnkl.kernel@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2022 at 08:42:27PM +0300, Sasha Finkelstein wrote:
> Adds PWM controller and keyboard backlight bindings for M1 MacBooks
> 
> Signed-off-by: Sasha Finkelstein <fnkl.kernel@gmail.com>
> Acked-by: Sven Peter <sven@svenpeter.dev>
> ---
>  arch/arm64/boot/dts/apple/t8103-j293.dts | 20 ++++++++++++++++++++
>  arch/arm64/boot/dts/apple/t8103-j313.dts | 20 ++++++++++++++++++++
>  arch/arm64/boot/dts/apple/t8103.dtsi     |  9 +++++++++
>  3 files changed, 49 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/apple/t8103-j293.dts b/arch/arm64/boot/dts/apple/t8103-j293.dts
> index ecb10d237a05..0b4b7e8e0726 100644
> --- a/arch/arm64/boot/dts/apple/t8103-j293.dts
> +++ b/arch/arm64/boot/dts/apple/t8103-j293.dts
> @@ -11,6 +11,7 @@
>  
>  #include "t8103.dtsi"
>  #include "t8103-jxxx.dtsi"
> +#include <dt-bindings/leds/common.h>
>  
>  / {
>  	compatible = "apple,j293", "apple,t8103", "apple,arm-platform";
> @@ -43,3 +44,22 @@ &i2c2 {
>  &i2c4 {
>  	status = "okay";
>  };
> +
> +/ {
> +	led-controller {
> +		compatible = "pwm-leds";
> +		led-0 {
> +			pwms = <&fpwm1 0 40000>;
> +			pwm-names = "kbd-backlight";

While allowed pwm-names isn't really needed here as there is only ever 1 
PWM and it is redundant with 'label'.

> +			label = "kbd_backlight";
> +			function = LED_FUNCTION_KBD_BACKLIGHT;
> +			color = <LED_COLOR_ID_WHITE>;
> +			max-brightness = <255>;
> +			default-state = "keep";
> +		};
> +	};
> +};
> +
> +&fpwm1 {
> +	status = "okay";
> +};
> diff --git a/arch/arm64/boot/dts/apple/t8103-j313.dts b/arch/arm64/boot/dts/apple/t8103-j313.dts
> index df741737b8e6..0e0f57dee96b 100644
> --- a/arch/arm64/boot/dts/apple/t8103-j313.dts
> +++ b/arch/arm64/boot/dts/apple/t8103-j313.dts
> @@ -11,6 +11,7 @@
>  
>  #include "t8103.dtsi"
>  #include "t8103-jxxx.dtsi"
> +#include <dt-bindings/leds/common.h>
>  
>  / {
>  	compatible = "apple,j313", "apple,t8103", "apple,arm-platform";
> @@ -35,3 +36,22 @@ &pcie0_dart_2 {
>  
>  /delete-node/ &port01;
>  /delete-node/ &port02;
> +
> +/ {
> +	led-controller {
> +		compatible = "pwm-leds";
> +		led-0 {
> +			pwms = <&fpwm1 0 40000>;
> +			pwm-names = "kbd-backlight";
> +			label = "kbd_backlight";
> +			function = LED_FUNCTION_KBD_BACKLIGHT;
> +			color = <LED_COLOR_ID_WHITE>;
> +			max-brightness = <255>;
> +			default-state = "keep";
> +		};
> +	};
> +};
> +
> +&fpwm1 {
> +	status = "okay";
> +};
> diff --git a/arch/arm64/boot/dts/apple/t8103.dtsi b/arch/arm64/boot/dts/apple/t8103.dtsi
> index 51a63b29d404..ccdb26ef6b22 100644
> --- a/arch/arm64/boot/dts/apple/t8103.dtsi
> +++ b/arch/arm64/boot/dts/apple/t8103.dtsi
> @@ -191,6 +191,15 @@ i2c4: i2c@235020000 {
>  			status = "disabled"; /* only used in J293 */
>  		};
>  
> +		fpwm1: pwm@235044000 {
> +			compatible = "apple,t8103-fpwm", "apple,s5l-fpwm";
> +			reg = <0x2 0x35044000 0x0 0x4000>;
> +			power-domains = <&ps_fpwm1>;
> +			clocks = <&clkref>;
> +			#pwm-cells = <2>;
> +			status = "disabled";
> +		};
> +
>  		serial0: serial@235200000 {
>  			compatible = "apple,s5l-uart";
>  			reg = <0x2 0x35200000 0x0 0x1000>;
> -- 
> 2.38.1
> 
> 
