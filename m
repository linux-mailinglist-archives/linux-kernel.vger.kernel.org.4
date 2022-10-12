Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F4375FCD8E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 23:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbiJLVxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 17:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbiJLVx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 17:53:27 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9DF9125006;
        Wed, 12 Oct 2022 14:53:23 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id w18so30834ejq.11;
        Wed, 12 Oct 2022 14:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7/UAQonY1jdtSDxe6mG/GSNINyt/UsNb0npebwXSigc=;
        b=JzgUWg8xRuGnBKhabW6f9oVrX/dtov7QQSv5AblnWE+IphRPFYyXHxp0aa1gj/sOjL
         jIj9NjDn+q1Vr7xgRyH9vi/O3ykh3aSmcVbziGCwsjs7ozBwMv1uKzvV1PRm0I/+r9xy
         H8rMl5j7umJzV3fdZB1IQRO6NFN1k7N/uewVl6JA1dKZaqgj3RPKiC/u8z62MrhdnbAL
         jDiG54Ryee+x/P6b1lfF7tVqBuOUvLm+c4xFioji0No37mAoNWifcy4FztJSSWLI+L3X
         CHzpg+NZ12LZxL88J0LQA0DI9kZRA4FUvvJLO7LTZQ3FrSJEeIE7hFigHGThq/oTv1Mz
         fPdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7/UAQonY1jdtSDxe6mG/GSNINyt/UsNb0npebwXSigc=;
        b=n7Qx5/FgdUSoMZLTvxj+w6K3HoDZ47GBdfGSyUiq72fWeDGMDWsJP7V2AIarJnY4b7
         Aq65cx89c1Xrg7uMtZFFLi6PBgLAkWwb6mr7QII6oS4FGZRD8JmidCmlgk+DHhglGqlk
         jxYMbEvisXqL1NCSqQWJwxI06FDjL0mVIyLHiDiO9wAZVPIAAPLxe1OhznkQCnrhD76j
         COyu7jrT9zTh1mbJA+5lbJBeg6H8Uvc4fE2H7crmWHWGTFf621iAAD5lTBaWn5IBVgJs
         ma6FYP3HwN4MVwKlovKj4I6MWq/2w5FbtYZ6vDC1iV102ugWS4HHPge9V1HHvQhH0W6O
         Dzlw==
X-Gm-Message-State: ACrzQf0LI+UhBUKp/O5ln7FL95caNxV8HlZzuvlBa7RVQzm+GX03f0F7
        YEJaMMaOzDd2D8gSNTy/Ays=
X-Google-Smtp-Source: AMsMyM5sK8vks8yeD99LKu/TvT/nZWJrqvIvXzWohkOK08pjY9d2ehQSA6pozuLJKbsjtBrx+kIZVw==
X-Received: by 2002:a17:907:7d8d:b0:78d:d467:dd3 with SMTP id oz13-20020a1709077d8d00b0078dd4670dd3mr8553455ejc.547.1665611601720;
        Wed, 12 Oct 2022 14:53:21 -0700 (PDT)
Received: from kista.localnet (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id ay8-20020a170906d28800b00788c622fa2csm1857593ejb.135.2022.10.12.14.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 14:53:21 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>
Cc:     Samuel Holland <samuel@sholland.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v3 2/2] ARM: dts: axp22x/axp809: Add GPIO controller nodes
Date:   Wed, 12 Oct 2022 23:53:20 +0200
Message-ID: <9053509.rMLUfLXkoz@kista>
In-Reply-To: <20220916042751.47906-3-samuel@sholland.org>
References: <20220916042751.47906-1-samuel@sholland.org> <20220916042751.47906-3-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Samuel,

Dne petek, 16. september 2022 ob 06:27:51 CEST je Samuel Holland napisal(a):
> These PMICs all contain a GPIO controller. Now that the binding for this
> variant is documented, wire up the controller in the device tree.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
> 
> Changes in v3:
>  - Remove "ldo" pinctrl children from new nodes
> 
>  arch/arm/boot/dts/axp22x.dtsi | 6 ++++++
>  arch/arm/boot/dts/axp809.dtsi | 7 +++++++
>  2 files changed, 13 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/axp22x.dtsi b/arch/arm/boot/dts/axp22x.dtsi
> index a020c12b2884..f79650afd0a7 100644
> --- a/arch/arm/boot/dts/axp22x.dtsi
> +++ b/arch/arm/boot/dts/axp22x.dtsi
> @@ -67,6 +67,12 @@ battery_power_supply: battery-power {
>  		status = "disabled";
>  	};
> 
> +	axp_gpio: gpio {
> +		compatible = "x-powers,axp221-gpio";
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +	};
> +
>  	regulators {
>  		/* Default work frequency for buck regulators */
>  		x-powers,dcdc-freq = <3000>;
> diff --git a/arch/arm/boot/dts/axp809.dtsi b/arch/arm/boot/dts/axp809.dtsi
> index ab8e5f2d9246..d134d4c00bd8 100644
> --- a/arch/arm/boot/dts/axp809.dtsi
> +++ b/arch/arm/boot/dts/axp809.dtsi
> @@ -50,4 +50,11 @@ &axp809 {
>  	compatible = "x-powers,axp809";
>  	interrupt-controller;
>  	#interrupt-cells = <1>;
> +
> +	axp_gpio: gpio {
> +		compatible = "x-powers,axp809-gpio",
> +			     "x-powers,axp221-gpio";
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +	};
>  };
> --
> 2.35.1


