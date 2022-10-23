Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79236609203
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 11:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbiJWJaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 05:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbiJWJa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 05:30:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5944060E9D;
        Sun, 23 Oct 2022 02:30:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 69A5A60AF7;
        Sun, 23 Oct 2022 09:30:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3444FC433D6;
        Sun, 23 Oct 2022 09:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666517422;
        bh=SvZU34knkzTksbDV9/R1UQaBdQ4Vp+P93Kb6ii8rmFI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IdS3KcbBazezxh9b26kfs977M6yjyqN0x7jvtpV3Q5ywMUbCdObrVuPS0OEKBg6Up
         AUbvS3j2LuHGFqAvJMcaHQaOpw26+XGcU328Q4qn9Jg9EfQohWWl7Cl21AcBj8sF3z
         vbyTl8JsU+nEBOS49rJMLoQk67n/0NUUGT+CLpZU4ZNYqgu79QgzbPhIAs6TmWqWkS
         V5SyNz6DTXrvgtVqrAPVxeWnU5q9pGsokJSGRSMfu5s1IDTTac76H+C9kV65xs90bL
         HxOkVbw/nqYM9QSy9hTkL1a8XdqxMc5qCyUl9cnw6d+6xKW6EjF8iaG5qpi60GXnfH
         AHwXX9o8pr9Vg==
Date:   Sun, 23 Oct 2022 17:30:16 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>, linux-input@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] ARM: dts: imx6qdl-sabre*: fix Egalax touchscreen
 properties
Message-ID: <20221023093016.GC125525@dragon>
References: <20220920042608.1865560-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220920042608.1865560-1-dmitry.torokhov@gmail.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 19, 2022 at 09:26:05PM -0700, Dmitry Torokhov wrote:
> This patch fixes interrupt trigger (should be level low as that is what the
> driver is always using), the GPIO that is the interrupt source that is also
> used to wake up chip by driving the line low.
> 
> The proper polarity is be needed for converting the driver to gpiod API.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Looks good to me.  Let me know if you want me to pick it up.  Otherwise,

Acked-by: Shawn Guo <shawnguo@kernel.org>

Shawn

> ---
>  arch/arm/boot/dts/imx6qdl-sabreauto.dtsi | 4 ++--
>  arch/arm/boot/dts/imx6qdl-sabresd.dtsi   | 8 ++++----
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
> index 1368a4762037..1883350d004e 100644
> --- a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
> @@ -451,8 +451,8 @@ touchscreen@4 {
>  		pinctrl-names = "default";
>  		pinctrl-0 = <&pinctrl_egalax_int>;
>  		interrupt-parent = <&gpio2>;
> -		interrupts = <28 IRQ_TYPE_EDGE_FALLING>;
> -		wakeup-gpios = <&gpio2 28 GPIO_ACTIVE_HIGH>;
> +		interrupts = <28 IRQ_TYPE_LEVEL_LOW>;
> +		wakeup-gpios = <&gpio2 28 GPIO_ACTIVE_LOW>;
>  	};
>  };
>  
> diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
> index 37482a9023fc..09f4c2fa3ad6 100644
> --- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
> @@ -311,8 +311,8 @@ touchscreen@4 {
>  		pinctrl-names = "default";
>  		pinctrl-0 = <&pinctrl_i2c2_egalax_int>;
>  		interrupt-parent = <&gpio6>;
> -		interrupts = <8 IRQ_TYPE_EDGE_FALLING>;
> -		wakeup-gpios = <&gpio6 8 GPIO_ACTIVE_HIGH>;
> +		interrupts = <8 IRQ_TYPE_LEVEL_LOW>;
> +		wakeup-gpios = <&gpio6 8 GPIO_ACTIVE_LOW>;
>  	};
>  
>  	ov5640: camera@3c {
> @@ -450,8 +450,8 @@ egalax_ts@4 {
>  		compatible = "eeti,egalax_ts";
>  		reg = <0x04>;
>  		interrupt-parent = <&gpio6>;
> -		interrupts = <7 2>;
> -		wakeup-gpios = <&gpio6 7 0>;
> +		interrupts = <7 IRQ_TYPE_LEVEL_LOW>;
> +		wakeup-gpios = <&gpio6 7 GPIO_ACTIVE_LOW>;
>  	};
>  
>  	magnetometer@e {
> -- 
> 2.37.3.968.ga6b4b080e4-goog
> 
