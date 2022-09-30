Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 567D05F16B1
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 01:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbiI3XfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 19:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbiI3Xe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 19:34:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67FE84598C;
        Fri, 30 Sep 2022 16:34:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 043BE62574;
        Fri, 30 Sep 2022 23:34:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34B79C433D6;
        Fri, 30 Sep 2022 23:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664580897;
        bh=3HSYva6mMzbFyG8Wkh1iYMj2pbX0qr9TkSQ05ARFVBA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eEZnpKcBFTwnJ2saoMsNJQBVLsMS8r8zherEhnXjFx2TEZ3j3E9nmGks+P9i5Mvpd
         I31FBiXqmaESGWdIXp2gWfm1jNoq9WJ6/uW82Q/IrDQ43jXPKn77Ro4Y9ka3De5D/o
         EEh6SBdNcHoYXZgqDtVzNGdb7OLxE7Emu8zPTR9gzy0U9jmd2C6vAP5ZYdvp0Q7p7i
         l3+DqRmWUgblgNDXRNnbfbakRrI49mD+wZkR2pGLsXY7PVlsNtzDzzlOgXHPPzNYlA
         FVSkjyLqMx5kupTetWll4ljB95Y5Fds5fX/mvODUQBwk/UA/gxPrNT6ly6HN2D2x8e
         Mu/1fgvdhsjCA==
Received: by pali.im (Postfix)
        id AFB4793F; Sat,  1 Oct 2022 01:34:53 +0200 (CEST)
Date:   Sat, 1 Oct 2022 01:34:53 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Gregory Clement <gregory.clement@bootlin.com>
Cc:     linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 3/4] ARM: dts: armada-38x: Fix compatible string for
 gpios
Message-ID: <20220930233453.ixfj7ps2fo2jukjp@pali>
References: <20220714115515.5748-1-pali@kernel.org>
 <20220714183328.4137-1-pali@kernel.org>
 <20220714183328.4137-3-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220714183328.4137-3-pali@kernel.org>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gregory: ping

On Thursday 14 July 2022 20:33:27 Pali Rohár wrote:
> Armada 38x supports per CPU interrupts for gpios, like Armada XP. Pre-XP
> variants like Armada 370 do not support per CPU interrupts for gpios.
> 
> So change compatible string for Armada 38x from "marvell,armada-370-gpio"
> which indicates pre-XP variant to "marvell,armadaxp-gpio" which indicates
> XP variant or new.
> 
> Driver gpio-mvebu.c which handles both pre-XP and XP variants already
> provides support for per CPU interrupts on XP and newer variants.
> 
> Signed-off-by: Pali Rohár <pali@kernel.org>
> Fixes: 7cb2acb3fbae ("ARM: dts: mvebu: Add PWM properties for armada-38x")
> ---
>  arch/arm/boot/dts/armada-38x.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/armada-38x.dtsi b/arch/arm/boot/dts/armada-38x.dtsi
> index df3c8d1d8f64..9343de6947b3 100644
> --- a/arch/arm/boot/dts/armada-38x.dtsi
> +++ b/arch/arm/boot/dts/armada-38x.dtsi
> @@ -292,7 +292,7 @@
>  			};
>  
>  			gpio0: gpio@18100 {
> -				compatible = "marvell,armada-370-gpio",
> +				compatible = "marvell,armadaxp-gpio",
>  					     "marvell,orion-gpio";
>  				reg = <0x18100 0x40>, <0x181c0 0x08>;
>  				reg-names = "gpio", "pwm";
> @@ -310,7 +310,7 @@
>  			};
>  
>  			gpio1: gpio@18140 {
> -				compatible = "marvell,armada-370-gpio",
> +				compatible = "marvell,armadaxp-gpio",
>  					     "marvell,orion-gpio";
>  				reg = <0x18140 0x40>, <0x181c8 0x08>;
>  				reg-names = "gpio", "pwm";
> -- 
> 2.20.1
> 
