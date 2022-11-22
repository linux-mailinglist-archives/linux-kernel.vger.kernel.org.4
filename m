Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B44F634221
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 18:03:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234442AbiKVRDh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 12:03:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233252AbiKVRDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 12:03:34 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7984A18F;
        Tue, 22 Nov 2022 09:03:33 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id p16so11183234wmc.3;
        Tue, 22 Nov 2022 09:03:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6nhEEaoh/VcXJH4n5hY98SxMNK4kG9V8xGcvOhwOUOA=;
        b=ey4I+T4vbFBZcvd6BvzRMjTIz59KfQQfa6B849ysx9rZqbkcIR0s8BJyLfeTNOLRU3
         BtUfba4qm1vJvxtixgSLo+oATBWNkSFax+j6HO1vUpzovNblxSuZt/tkPnFSbr3t1Poz
         rl9xRtU6HA1nWn7Y54XMDxlund8gOrmAVmndv4BjnZswrzDavoAt/rIEPcOGwRWTIKCm
         s5OrgAmWjOFVyNYgI+RhdxN1x808VrVMX/1AfZ/M71khiA7og+TzRUz2r0M4oCe2maFY
         7OPuCVn9IeVAToljsMqDxgXvE8PypYjPcoLtysfpQhPS0Q+gr0hql5O96lGoVP0EXAap
         IgfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6nhEEaoh/VcXJH4n5hY98SxMNK4kG9V8xGcvOhwOUOA=;
        b=6nDoETRhM3GwMYdtI3rYqD6pL8FhnG1X4zRvUsvpwQ1lFWuh208jwyUUgQPbjHnEwE
         GD2sK0No7wx8fPQJTlQAqp9AnB8LH1goZHiX1phjwDQthPknD4b0jOW9tYsgcYN8v/Em
         ebW2dFsb84aMQ9O7cznwI796hFVfoeEW3fQOekLJjPUDunJAnYNmQpvNwzuKTLPrwnJo
         vua9Brf5bulubCqC8JuS80BSMbIo4VAc3V5t08qhAZawKqoltOHkmHW+184jm2UxARDX
         F1JZQRMFAsrbifO4lS08pt1qoqLi/9TFi20fss8eYwQ2yz3Y1tNVZW6Vc0JWQXDM29Ww
         1cJw==
X-Gm-Message-State: ANoB5plMl+unTIOUNm0DnQbtOOSdQjXcNDO3p+fXrZxP0tSpixlUYQ3p
        TnBP6yg3iEF9loJzQjcQVLQ=
X-Google-Smtp-Source: AA0mqf5aTg8+S6uKEPj96utoXf8duBP36uWZVEQIF3e+FSkl7cFIK1CtvtjgkYxB8bZEzb9G39gmIA==
X-Received: by 2002:a1c:7513:0:b0:3cf:8896:e1c9 with SMTP id o19-20020a1c7513000000b003cf8896e1c9mr20286552wmc.119.1669136612325;
        Tue, 22 Nov 2022 09:03:32 -0800 (PST)
Received: from [192.168.0.25] ([37.222.251.204])
        by smtp.gmail.com with ESMTPSA id q3-20020adfcd83000000b0022eafed36ebsm14609696wrj.73.2022.11.22.09.03.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Nov 2022 09:03:31 -0800 (PST)
Message-ID: <992ba484-b1d3-4ea6-1904-78b0dd913380@gmail.com>
Date:   Tue, 22 Nov 2022 18:03:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 7/7] ARM: dts: stm32: Remove the pins-are-numbered
 property
Content-Language: en-US
To:     =?UTF-8?Q?Bernhard_Rosenkr=c3=a4nzer?= <bero@baylibre.com>,
        devicetree@vger.kernel.org
Cc:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
        krzysztof.kozlowski@linaro.org,
        angelogioacchino.delregno@collabora.com, khilman@baylibre.com
References: <20221122010753.3126828-1-bero@baylibre.com>
 <20221122010753.3126828-8-bero@baylibre.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20221122010753.3126828-8-bero@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22/11/2022 02:07, Bernhard Rosenkränzer wrote:
> Remove the pins-are-numbered property from STM32 DeviceTrees
> 
> Signed-off-by: Bernhard Rosenkränzer <bero@baylibre.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>   arch/arm/boot/dts/stm32f4-pinctrl.dtsi | 1 -
>   arch/arm/boot/dts/stm32f7-pinctrl.dtsi | 1 -
>   arch/arm/boot/dts/stm32h743.dtsi       | 1 -
>   arch/arm/boot/dts/stm32mp131.dtsi      | 1 -
>   arch/arm/boot/dts/stm32mp151.dtsi      | 2 --
>   5 files changed, 6 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/stm32f4-pinctrl.dtsi b/arch/arm/boot/dts/stm32f4-pinctrl.dtsi
> index 500bcc302d422..4523c63475e4c 100644
> --- a/arch/arm/boot/dts/stm32f4-pinctrl.dtsi
> +++ b/arch/arm/boot/dts/stm32f4-pinctrl.dtsi
> @@ -51,7 +51,6 @@ pinctrl: pinctrl@40020000 {
>   			ranges = <0 0x40020000 0x3000>;
>   			interrupt-parent = <&exti>;
>   			st,syscfg = <&syscfg 0x8>;
> -			pins-are-numbered;
>   
>   			gpioa: gpio@40020000 {
>   				gpio-controller;
> diff --git a/arch/arm/boot/dts/stm32f7-pinctrl.dtsi b/arch/arm/boot/dts/stm32f7-pinctrl.dtsi
> index 8f37aefa73150..c8e6c52fb248e 100644
> --- a/arch/arm/boot/dts/stm32f7-pinctrl.dtsi
> +++ b/arch/arm/boot/dts/stm32f7-pinctrl.dtsi
> @@ -15,7 +15,6 @@ pinctrl: pinctrl@40020000 {
>   			ranges = <0 0x40020000 0x3000>;
>   			interrupt-parent = <&exti>;
>   			st,syscfg = <&syscfg 0x8>;
> -			pins-are-numbered;
>   
>   			gpioa: gpio@40020000 {
>   				gpio-controller;
> diff --git a/arch/arm/boot/dts/stm32h743.dtsi b/arch/arm/boot/dts/stm32h743.dtsi
> index 28e3deb20e1e1..f30796f7adf36 100644
> --- a/arch/arm/boot/dts/stm32h743.dtsi
> +++ b/arch/arm/boot/dts/stm32h743.dtsi
> @@ -588,7 +588,6 @@ pinctrl: pinctrl@58020000 {
>   			ranges = <0 0x58020000 0x3000>;
>   			interrupt-parent = <&exti>;
>   			st,syscfg = <&syscfg 0x8>;
> -			pins-are-numbered;
>   
>   			gpioa: gpio@58020000 {
>   				gpio-controller;
> diff --git a/arch/arm/boot/dts/stm32mp131.dtsi b/arch/arm/boot/dts/stm32mp131.dtsi
> index 2a9b3a5bba830..adaee0f9e1263 100644
> --- a/arch/arm/boot/dts/stm32mp131.dtsi
> +++ b/arch/arm/boot/dts/stm32mp131.dtsi
> @@ -549,7 +549,6 @@ pinctrl: pinctrl@50002000 {
>   			ranges = <0 0x50002000 0x8400>;
>   			interrupt-parent = <&exti>;
>   			st,syscfg = <&exti 0x60 0xff>;
> -			pins-are-numbered;
>   
>   			gpioa: gpio@50002000 {
>   				gpio-controller;
> diff --git a/arch/arm/boot/dts/stm32mp151.dtsi b/arch/arm/boot/dts/stm32mp151.dtsi
> index 5491b6c4dec20..4e437d3f2ed66 100644
> --- a/arch/arm/boot/dts/stm32mp151.dtsi
> +++ b/arch/arm/boot/dts/stm32mp151.dtsi
> @@ -1660,7 +1660,6 @@ pinctrl: pinctrl@50002000 {
>   			ranges = <0 0x50002000 0xa400>;
>   			interrupt-parent = <&exti>;
>   			st,syscfg = <&exti 0x60 0xff>;
> -			pins-are-numbered;
>   
>   			gpioa: gpio@50002000 {
>   				gpio-controller;
> @@ -1789,7 +1788,6 @@ pinctrl_z: pinctrl@54004000 {
>   			#size-cells = <1>;
>   			compatible = "st,stm32mp157-z-pinctrl";
>   			ranges = <0 0x54004000 0x400>;
> -			pins-are-numbered;
>   			interrupt-parent = <&exti>;
>   			st,syscfg = <&exti 0x60 0xff>;
>   
