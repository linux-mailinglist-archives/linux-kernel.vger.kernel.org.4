Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A718F6F246D
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 13:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbjD2LOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 07:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjD2LOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 07:14:17 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C22731998;
        Sat, 29 Apr 2023 04:14:15 -0700 (PDT)
Received: from g550jk.localnet (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 9293DC76D6;
        Sat, 29 Apr 2023 11:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1682766853; bh=A8QySs6SKhnXKBxkO0+a10Q3xy1UQlrC6oSknuRX0p0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=U7zokl7PwDhkg2mUuKqWuwfT1MxrzqVZ/5hi6RDzgNWum9wURWdBcStFGLcfBVMY8
         UaDtySh/ktQAX2Bj61orQkqqmlcte/2DFaVZsjjcp4LVEPFIEio70LtCzx+VEJ1/eZ
         gUtBK5DhbsU6wGkMv9uelFv8KytbxGpGtKzr0API=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        ~postmarketos/upstreaming@lists.sr.ht
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@ucw.cz>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Helge Deller <deller@gmx.de>,
        Uwe =?ISO-8859-1?Q?Kleine=2DK=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Artur Weber <aweber.kernel@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-fbdev@vger.kernel.org, linux-pwm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Artur Weber <aweber.kernel@gmail.com>
Subject: Re: [PATCH 3/4] ARM: dts: adapt to LP855X bindings changes
Date:   Sat, 29 Apr 2023 13:14:12 +0200
Message-ID: <3414865.QJadu78ljV@z3ntu.xyz>
In-Reply-To: <20230429104534.28943-4-aweber.kernel@gmail.com>
References: <20230429104534.28943-1-aweber.kernel@gmail.com>
 <20230429104534.28943-4-aweber.kernel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Samstag, 29. April 2023 12:45:33 CEST Artur Weber wrote:
> Change underscores in ROM node names to dashes, and remove deprecated
> pwm-period property.
> 
> Signed-off-by: Artur Weber <aweber.kernel@gmail.com>

Reviewed-by: Luca Weiss <luca@z3ntu.xyz>

> ---
>  .../dts/qcom-apq8026-samsung-matisse-wifi.dts |  1 -
>  ...-msm8974pro-sony-xperia-shinano-castor.dts | 23 ++++++++++---------
>  2 files changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/qcom-apq8026-samsung-matisse-wifi.dts
> b/arch/arm/boot/dts/qcom-apq8026-samsung-matisse-wifi.dts index
> 91b860e24681..884d99297d4c 100644
> --- a/arch/arm/boot/dts/qcom-apq8026-samsung-matisse-wifi.dts
> +++ b/arch/arm/boot/dts/qcom-apq8026-samsung-matisse-wifi.dts
> @@ -99,7 +99,6 @@ backlight@2c {
> 
>  			dev-ctrl = /bits/ 8 <0x80>;
>  			init-brt = /bits/ 8 <0x3f>;
> -			pwm-period = <100000>;
> 
>  			pwms = <&backlight_pwm 0 100000>;
>  			pwm-names = "lp8556";
> diff --git
> a/arch/arm/boot/dts/qcom-msm8974pro-sony-xperia-shinano-castor.dts
> b/arch/arm/boot/dts/qcom-msm8974pro-sony-xperia-shinano-castor.dts index
> 04bc58d87abf..2396253f953a 100644
> --- a/arch/arm/boot/dts/qcom-msm8974pro-sony-xperia-shinano-castor.dts
> +++ b/arch/arm/boot/dts/qcom-msm8974pro-sony-xperia-shinano-castor.dts
> @@ -150,47 +150,48 @@ lp8566_wled: backlight@2c {
>  		bl-name = "backlight";
>  		dev-ctrl = /bits/ 8 <0x05>;
>  		init-brt = /bits/ 8 <0x3f>;
> -		rom_a0h {
> +
> +		rom-a0h {
>  			rom-addr = /bits/ 8 <0xa0>;
>  			rom-val = /bits/ 8 <0xff>;
>  		};
> -		rom_a1h {
> +		rom-a1h {
>  			rom-addr = /bits/ 8 <0xa1>;
>  			rom-val = /bits/ 8 <0x3f>;
>  		};
> -		rom_a2h {
> +		rom-a2h {
>  			rom-addr = /bits/ 8 <0xa2>;
>  			rom-val = /bits/ 8 <0x20>;
>  		};
> -		rom_a3h {
> +		rom-a3h {
>  			rom-addr = /bits/ 8 <0xa3>;
>  			rom-val = /bits/ 8 <0x5e>;
>  		};
> -		rom_a4h {
> +		rom-a4h {
>  			rom-addr = /bits/ 8 <0xa4>;
>  			rom-val = /bits/ 8 <0x02>;
>  		};
> -		rom_a5h {
> +		rom-a5h {
>  			rom-addr = /bits/ 8 <0xa5>;
>  			rom-val = /bits/ 8 <0x04>;
>  		};
> -		rom_a6h {
> +		rom-a6h {
>  			rom-addr = /bits/ 8 <0xa6>;
>  			rom-val = /bits/ 8 <0x80>;
>  		};
> -		rom_a7h {
> +		rom-a7h {
>  			rom-addr = /bits/ 8 <0xa7>;
>  			rom-val = /bits/ 8 <0xf7>;
>  		};
> -		rom_a9h {
> +		rom-a9h {
>  			rom-addr = /bits/ 8 <0xa9>;
>  			rom-val = /bits/ 8 <0x80>;
>  		};
> -		rom_aah {
> +		rom-aah {
>  			rom-addr = /bits/ 8 <0xaa>;
>  			rom-val = /bits/ 8 <0x0f>;
>  		};
> -		rom_aeh {
> +		rom-aeh {
>  			rom-addr = /bits/ 8 <0xae>;
>  			rom-val = /bits/ 8 <0x0f>;
>  		};




