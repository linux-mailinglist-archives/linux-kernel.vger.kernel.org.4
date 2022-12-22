Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73F54653F2F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 12:43:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235264AbiLVLnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 06:43:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235169AbiLVLnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 06:43:04 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C9A428779
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 03:43:02 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id bf43so2338999lfb.6
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 03:43:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uBssYKk9hpir98GZNc3X97bkakcTPDPCU4naoK/NGGo=;
        b=XR2eZCbx4dsgBUb6vwlxECw+klSMHSrF09709Wo7wjpVKkuCubKGWmwzrxVQ+Se/8H
         Vfu/0HrD3BqhP4cZere5W/wA33Lkt7qDSY/+IYZoIurqWZ0bMcsqL+XChiHBXj2MqGe3
         LJ3tlZvyoE2QfEgli6XACN/GDykZNIYy4zk2IU7NqyLvb7snekSe0BE2njGJtnu61rmD
         fLBI50uWm7dg5+EuIVQunAnGwGi3SJA12epLTz1y6Za9HxwKChoRlLZKadj2Zy9A6kS8
         gdiMeZUiPFBrqWzi5nmO0BZM1/L/be6tcvXh+vTc2jdz7p9GnIZvoSNJVKj8U/g59NNv
         TrDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uBssYKk9hpir98GZNc3X97bkakcTPDPCU4naoK/NGGo=;
        b=bJbbf1Ugmvals4RDf0ODET8rubr0Br++78+WueaMcORKtKcoeL97eKHplfufFbyrT8
         2SVny2K/X0fRu67V4uDxhzjp/qYoftt94ANKhnajGHGWPlJwnVnmd1mZ1DzCHiHxnXYj
         c6upcZmFtOY/KlRfK372kdAC3ic+D7Thw6W853Rvwnbnv4hV2Phuyaor5s8q0aodxrTp
         0NE+UE3t3jGpoWXBUvwNN+yPFmdvAHNa8jBuKrwE6qTRGwogFNybdKhuBmX8XpLPlmP3
         Jp7Vh85OjImZA/tYGhVwpPBRlCTHCDhJBeJ5fBghpDVO1+Sb13zuggeM88eTLl/u0jBS
         xnmw==
X-Gm-Message-State: AFqh2kru+Pp7iK5EiLIef2STVCqRjw1nMxs14SpsiZiJ4VTuUnizVSi/
        o4pMaMx+3ICNPmVFYPlWGQiqzg==
X-Google-Smtp-Source: AMrXdXvLfKc+k8RmiuBHFNyAQ524e5bDOX3M+swEQ1cHK4veuXqknCBBo60j48VHboDSr5k1MJkAhg==
X-Received: by 2002:a05:6512:b9d:b0:4b9:e305:90eb with SMTP id b29-20020a0565120b9d00b004b9e30590ebmr2140888lfv.13.1671709380951;
        Thu, 22 Dec 2022 03:43:00 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id z1-20020a0565120c0100b004b4b600c093sm45535lfu.92.2022.12.22.03.42.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Dec 2022 03:43:00 -0800 (PST)
Message-ID: <abeb6ee7-9771-ea0c-fdf8-71f50bd8ac5b@linaro.org>
Date:   Thu, 22 Dec 2022 12:42:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v5 3/4] arm64: dts: apple: t8103: Add PWM controller
Content-Language: en-US
To:     Sasha Finkelstein <fnkl.kernel@gmail.com>,
        u.kleine-koenig@pengutronix.de, thierry.reding@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     marcan@marcan.st, sven@svenpeter.dev, alyssa@rosenzweig.io,
        asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221221210648.2735-1-fnkl.kernel@gmail.com>
 <20221221210648.2735-4-fnkl.kernel@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221221210648.2735-4-fnkl.kernel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/12/2022 22:06, Sasha Finkelstein wrote:
> Adds PWM controller and keyboard backlight bindings for M1 MacBooks
> 
> Signed-off-by: Sasha Finkelstein <fnkl.kernel@gmail.com>
> Acked-by: Sven Peter <sven@svenpeter.dev>
> ---
>  arch/arm64/boot/dts/apple/t8103-j293.dts | 19 +++++++++++++++++++
>  arch/arm64/boot/dts/apple/t8103-j313.dts | 19 +++++++++++++++++++
>  arch/arm64/boot/dts/apple/t8103.dtsi     |  9 +++++++++
>  3 files changed, 47 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/apple/t8103-j293.dts b/arch/arm64/boot/dts/apple/t8103-j293.dts
> index ecb10d237a05..43f79570b458 100644
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
> @@ -43,3 +44,21 @@ &i2c2 {
>  &i2c4 {
>  	status = "okay";
>  };
> +
> +/ {
> +	led-controller {
> +		compatible = "pwm-leds";
> +		led-0 {
> +			pwms = <&fpwm1 0 40000>;
> +			label = "kbd_backlight";
> +			function = LED_FUNCTION_KBD_BACKLIGHT;
> +			color = <LED_COLOR_ID_WHITE>;
> +			max-brightness = <255>;
> +			default-state = "keep";
> +		};
> +	};
> +};
{ goes to the top, not in the middle of DTS. Don't add stuff at the end
of DTS.

Best regards,
Krzysztof

