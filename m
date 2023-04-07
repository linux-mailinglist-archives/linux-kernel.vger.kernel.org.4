Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 854CA6DAF6D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 17:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbjDGPJt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 11:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240810AbjDGPJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 11:09:35 -0400
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45FB6BDC2;
        Fri,  7 Apr 2023 08:08:52 -0700 (PDT)
Received: (Authenticated sender: gregory.clement@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 2E5A6240009;
        Fri,  7 Apr 2023 15:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1680880099;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=awkG7CmSV47sET8HTUdOciqfb49ZHV8Xd6B3HElfp0o=;
        b=il0n6whRM8u73rhxrKcKVw/mconjh/Hjeeb4v04ymp3gUTv5ZxtdAJsJylWvtBkPDdcO9J
        u64eK5vsgPIviWYaLsJkLRrqDFcu+V+6+GkOFr64ZTdCi1ulZnVNsEHzrz6sbQFiCRhNVU
        VjxWRUV6jHGZK8zmiXCWO+gork8R+Dv9qM2GgYAmzDMrRiq5Jl6kTI1uhoF9v7QWhcAYFr
        CvQ12GE73lvEejzAPjhkoYSaIySBt5uNLKKamB2oWLLFceZqG3pazBUmIrqA1ojEo2B036
        yteAwhUdxnV4gIvZLtYucBpSw/bGUoVVGqHMRNuwNNLqFxEE/yTuYnkDg60Dpg==
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] arm64: dts: marvell: align thermal node names with
 bindings
In-Reply-To: <20230312201313.498434-1-krzysztof.kozlowski@linaro.org>
References: <20230312201313.498434-1-krzysztof.kozlowski@linaro.org>
Date:   Fri, 07 Apr 2023 17:08:16 +0200
Message-ID: <87y1n33f33.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> writes:

> Bindings expect thermal node names to end with '-thermal':
>
>   armada-8040-db.dtb: thermal-zones: 'ap-thermal-cpu0', ... do not match any of the regexes: '^[a-zA-Z][a-zA-Z0-9\\-]{1,12}-thermal$', 'pinctrl-[0-9]+'

Applied on mvebu/dt64

Thanks,

Gregory


>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  arch/arm64/boot/dts/marvell/armada-ap80x.dtsi | 10 +++++-----
>  arch/arm64/boot/dts/marvell/armada-cp11x.dtsi |  2 +-
>  2 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-ap80x.dtsi b/arch/arm64/boot/dts/marvell/armada-ap80x.dtsi
> index 4e6d29ad32eb..2c920e22cec2 100644
> --- a/arch/arm64/boot/dts/marvell/armada-ap80x.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-ap80x.dtsi
> @@ -317,7 +317,7 @@ ap_thermal: thermal-sensor@80 {
>  	 * first one that will have a critical trip point will be chosen.
>  	 */
>  	thermal-zones {
> -		ap_thermal_ic: ap-thermal-ic {
> +		ap_thermal_ic: ap-ic-thermal {
>  			polling-delay-passive = <0>; /* Interrupt driven */
>  			polling-delay = <0>; /* Interrupt driven */
>  
> @@ -334,7 +334,7 @@ ap_crit: ap-crit {
>  			cooling-maps { };
>  		};
>  
> -		ap_thermal_cpu0: ap-thermal-cpu0 {
> +		ap_thermal_cpu0: ap-cpu0-thermal {
>  			polling-delay-passive = <1000>;
>  			polling-delay = <1000>;
>  
> @@ -367,7 +367,7 @@ map0_emerg: map0-ermerg {
>  			};
>  		};
>  
> -		ap_thermal_cpu1: ap-thermal-cpu1 {
> +		ap_thermal_cpu1: ap-cpu1-thermal {
>  			polling-delay-passive = <1000>;
>  			polling-delay = <1000>;
>  
> @@ -400,7 +400,7 @@ map1_emerg: map1-emerg {
>  			};
>  		};
>  
> -		ap_thermal_cpu2: ap-thermal-cpu2 {
> +		ap_thermal_cpu2: ap-cpu2-thermal {
>  			polling-delay-passive = <1000>;
>  			polling-delay = <1000>;
>  
> @@ -433,7 +433,7 @@ map2_emerg: map2-emerg {
>  			};
>  		};
>  
> -		ap_thermal_cpu3: ap-thermal-cpu3 {
> +		ap_thermal_cpu3: ap-cpu3-thermal {
>  			polling-delay-passive = <1000>;
>  			polling-delay = <1000>;
>  
> diff --git a/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi b/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi
> index 7d0043824f2a..0cc9ee9871e7 100644
> --- a/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi
> @@ -25,7 +25,7 @@ / {
>  	 * The cooling maps are empty as there are no cooling devices.
>  	 */
>  	thermal-zones {
> -		CP11X_LABEL(thermal_ic): CP11X_NODE_NAME(thermal-ic) {
> +		CP11X_LABEL(thermal_ic): CP11X_NODE_NAME(ic-thermal) {
>  			polling-delay-passive = <0>; /* Interrupt driven */
>  			polling-delay = <0>; /* Interrupt driven */
>  
> -- 
> 2.34.1
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
