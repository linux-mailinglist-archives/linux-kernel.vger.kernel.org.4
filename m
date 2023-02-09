Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30721690116
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 08:18:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbjBIHSR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 02:18:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbjBIHSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 02:18:01 -0500
Received: from out-68.mta1.migadu.com (out-68.mta1.migadu.com [IPv6:2001:41d0:203:375::44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A8DE4B778
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 23:17:14 -0800 (PST)
Date:   Thu, 9 Feb 2023 08:14:37 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grimler.se; s=key1;
        t=1675926881;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aDefePb9DzE68gMvRuH6VgPExZBXi4eiCm1B5eLWrq4=;
        b=HmcDohBMTsSZToZvxKzDdIAGZRS9A7jNchA6rtcqby/5wjGIifQzTcJ1VkifmfF9E5Pnc5
        pJdn94Xd0Q50BGvPXnGofxexQeIdDD38C0HwrFUFIev+pWBPvFGgjLR0I+J+gH1EH7bHsq
        EZ8Mfx1DgYeRmEv8d1aHfUCUFVysdUE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Henrik Grimler <henrik@grimler.se>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        replicant@osuosl.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Martin =?iso-8859-1?Q?J=FCcker?= <martin.juecker@gmail.com>
Subject: Re: [RFT PATCH 1/3] ARM: dts: exynos: add "gpios" suffix to
 wlf,ldo1ena on Midas
Message-ID: <Y+SdXZpJbm+7+SPp@L14.lan>
References: <20230208172634.404452-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230208172634.404452-1-krzysztof.kozlowski@linaro.org>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2023 at 06:26:32PM +0100, Krzysztof Kozlowski wrote:
> The GPIOs properties should end with "gpios" suffix and Linux gpiolib
> already handles both names, so switch to preferred one.
> 
> While touching the lines, replace open-coded GPIO_ACTIVE_HIGH flag.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Tested-by: Henrik Grimler <henrik@grimler.se>

Audio still works fine on i9300, and there are no new warnings/errors
in dmesg.

Best regards,
Henrik Grimler

> ---
>  arch/arm/boot/dts/exynos4412-midas.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/exynos4412-midas.dtsi b/arch/arm/boot/dts/exynos4412-midas.dtsi
> index d5074fa57142..525f945c4b91 100644
> --- a/arch/arm/boot/dts/exynos4412-midas.dtsi
> +++ b/arch/arm/boot/dts/exynos4412-midas.dtsi
> @@ -653,8 +653,8 @@ wm1811: audio-codec@1a {
>  		CPVDD-supply = <&vbatt_reg>;
>  		SPKVDD1-supply = <&vbatt_reg>;
>  		SPKVDD2-supply = <&vbatt_reg>;
> -		wlf,ldo1ena = <&gpj0 4 0>;
> -		wlf,ldo2ena = <&gpj0 4 0>;
> +		wlf,ldo1ena-gpios = <&gpj0 4 GPIO_ACTIVE_HIGH>;
> +		wlf,ldo2ena-gpios = <&gpj0 4 GPIO_ACTIVE_HIGH>;
>  	};
>  };
>  
> -- 
> 2.34.1
> 
