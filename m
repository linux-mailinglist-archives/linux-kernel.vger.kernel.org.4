Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB36A5E932A
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 14:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232159AbiIYMkE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 08:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbiIYMkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 08:40:01 -0400
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C76E20F79;
        Sun, 25 Sep 2022 05:39:57 -0700 (PDT)
Message-ID: <ce61fb9a-dcf4-27a2-ac03-62060a1512f9@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
        t=1664109595;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OXUDIYwGS8VQVu3j8KhtahQQnFOQ52Ygtum7FlzQF2Q=;
        b=eOF+RH4Gwk0Wt8HCyeyTDsQaH9OC+2fvvQtX/WG/mqdKDEO1c5HVQiAtdL1ahS+olMee36
        Xt280jYvWK1ZDTUr13B0zYE2TVKgmgS9JH5ojzFrsUVupBzOoli90t+MZlUOX5BJcRKbfc
        gqpOKDifPJO6HYTYe8QYMifHMdFkna8Zs1VyMY9CG3oKQCgtm2e9wy5pLKD7YIdXP5nk0V
        1Ua4wKOlgHOP6FG/UyWp83qie5+8z0Y0HFKZzOQZVT3cUsQOV/CN4wa4hr9f9SSkCMwgZu
        XbcFVY9x9wBaFNSigtTDjhf1tc+YEUt1dTBYTLwevb4C8Lzz1JPIcye5v7iwSA==
Date:   Sun, 25 Sep 2022 14:39:54 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] arm64: dts: rockchip: fix quartz64-a bluetooth
 configuration
To:     Lev Popov <leo@nabam.net>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Peter Geis <pgwipeout@gmail.com>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220925123144.70639-1-leo@nabam.net>
Content-Language: da-DK
From:   Dan Johansen <strit@manjaro.org>
Organization: Manjaro ARM
In-Reply-To: <20220925123144.70639-1-leo@nabam.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
        auth=pass smtp.auth=strit@manjaro.org smtp.mailfrom=strit@manjaro.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Den 25.09.2022 kl. 14.31 skrev Lev Popov:
> For "Quartz64 Model A" add missing RTS line to the UART interface used by
> bluetooth and swap bluetooth host-wakeup and device-wakeup gpio pins to
> match the boards physical layout. This changes are necessary to make
> bluetooth provided by the wireless module work.
You should add
Fixes:  cd414d5ac1fdeecf0617737e688a1af00858253a (arm64: dts: rockchip: 
rename Quartz64-A bluetooth gpios)
I think, as that was the last commit that touched the gpio lines.
> Signed-off-by: Lev Popov <leo@nabam.net>
> ---
>   arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
> index a05460b92415..91908081c5ed 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
> @@ -740,7 +740,7 @@ &uart0 {
>   
>   &uart1 {
>   	pinctrl-names = "default";
> -	pinctrl-0 = <&uart1m0_xfer &uart1m0_ctsn>;
> +	pinctrl-0 = <&uart1m0_xfer &uart1m0_ctsn &uart1m0_rtsn>;
>   	status = "okay";
>   	uart-has-rtscts;
>   
> @@ -748,8 +748,8 @@ bluetooth {
>   		compatible = "brcm,bcm43438-bt";
>   		clocks = <&rk817 1>;
>   		clock-names = "lpo";
> -		device-wakeup-gpios = <&gpio2 RK_PC1 GPIO_ACTIVE_HIGH>;
> -		host-wakeup-gpios = <&gpio2 RK_PC0 GPIO_ACTIVE_HIGH>;
> +		host-wakeup-gpios = <&gpio2 RK_PC1 GPIO_ACTIVE_HIGH>;
> +		device-wakeup-gpios = <&gpio2 RK_PC0 GPIO_ACTIVE_HIGH>;
>   		shutdown-gpios = <&gpio2 RK_PB7 GPIO_ACTIVE_HIGH>;
>   		pinctrl-names = "default";
>   		pinctrl-0 = <&bt_host_wake_l &bt_wake_l &bt_enable_h>;
-- 
Kind regards
*Dan Johansen*
Project lead of the *Manjaro ARM* project
Manjaro-ARM <https://manjaro.org>
