Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE8B5F7550
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 10:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbiJGI3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 04:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbiJGI3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 04:29:08 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A841FDB59
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 01:29:07 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id y5so6260586lfl.4
        for <linux-kernel@vger.kernel.org>; Fri, 07 Oct 2022 01:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=BO9hdTt5nvKjhGy1cXaOnGxbQ6UWl/ky+S+9OZ0HfrA=;
        b=o08Og5qlTtYfp/u6lS6HbQTZdMLg0W8CzhKvTcdHPn5TyiER0syLTIcaPh3G9XP/9f
         PQvug7kd7xD5GEA/f1xmDBOxkFXEEOnR2a5yMS2yWISeNKTrvXzxW65YDoaWkl50SkP0
         fJTkk87HC0fZ5L0QBdUB4/wU33rQcfbbeHDvsGfNk+WClV17a/ydFrD/ElMwC6bWIVB/
         XAcHg8KZ6PyI2AYyRmzmWP5CVoz+GD91Yjckb4LIEvmmPotE3tbQBBk4vmHdW38n6OTE
         Y8eKSU9PsXR9dVQBaJkDziGkeSFxwb+2MXoCwdYHpqc0guyVEcGhYM46/3DAVHTCKO/n
         xhHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=BO9hdTt5nvKjhGy1cXaOnGxbQ6UWl/ky+S+9OZ0HfrA=;
        b=UI9NPWDXTsrVKyAcJICer/BabJd12IsyyMvKrlmUAxpyjyW5QVQ6+0qNcj2JY8JWSt
         Fnkjy6pERYrB+wmVDica8y4xJB3q0jhQbC6kS/f64gi5WZRv4O48qyZHeYtfqQq2PjHd
         /EwMrz1gtJhrGGAwxC5C7amvSFZg71cqRQarTwY1SDielPsev+XW7KAvYcCZhKhXoJ0y
         lCHfOYSJcTrA5iC30ywsgS3jawoxtxPO74Bg6R6szQyY462Ip4sB39z+3k2HWb+D8M+3
         KiYhOckVPUkWdWRyQuas46Pq7PjfXjGhzZb6dq6Lr0K5U7SnrvEuPrxiOvrKs8SenIrZ
         WrRQ==
X-Gm-Message-State: ACrzQf1el9bnBnUNuyLM82DALrLP4bxWf06rmc3tO1hL+dmJjbLVS7sy
        wOvTfeI12ZSqhYaoDvZ+Zew2XQ==
X-Google-Smtp-Source: AMsMyM7vWzOxGsjOmR3cZCcTn9Qll28t8XMFFQdeN4ltEYMtUP3ZwKze6OCsBUnmY9nhQH2UMx3/Fw==
X-Received: by 2002:a05:6512:1108:b0:4a2:504f:b3f with SMTP id l8-20020a056512110800b004a2504f0b3fmr1406995lfg.169.1665131345549;
        Fri, 07 Oct 2022 01:29:05 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id c19-20020ac25f73000000b00499fe9ce5f2sm204326lfc.175.2022.10.07.01.29.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Oct 2022 01:29:05 -0700 (PDT)
Message-ID: <41bc017c-5ef5-b2ac-86bb-510651064f05@linaro.org>
Date:   Fri, 7 Oct 2022 10:29:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v2 1/2] spi: dt-bindings: amlogic, meson-gx-spicc: Add
 pinctrl names for SPI signal states
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     neil.armstrong@linaro.org,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Da Xue <da@libre.computer>, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-amlogic@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20221004-up-aml-fix-spi-v2-0-3e8ae91a1925@baylibre.com>
 <20221004-up-aml-fix-spi-v2-1-3e8ae91a1925@baylibre.com>
 <d2ce98d7-1025-9c6e-e207-00e91942077a@linaro.org>
 <fb2706e3-f758-a0b0-d595-75ef362a853e@baylibre.com>
 <7bcb9ef1-6b56-2f5f-3ac9-acc9ed9370df@linaro.org>
 <2c22e3b9-3da4-78c4-e068-78b84e24b2c3@linaro.org>
 <83649505-d8eb-b0b5-da9d-4536f58a7daa@linaro.org>
 <96160129-e9a0-ec0f-20d9-c92d1487eac6@linaro.org>
 <dbc3bcbf-cc46-79a3-8ce6-2d981d9e7d05@linaro.org>
In-Reply-To: <dbc3bcbf-cc46-79a3-8ce6-2d981d9e7d05@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/10/2022 10:17, Krzysztof Kozlowski wrote:
>>>
>>>> There's some bindings with pinctrl-names for specific states like rockchip/rockchip,dw-hdmi.yaml,
>>>> mediatek/mediatek,dpi.yaml, mmc/mtk-sd.yaml or mmc/fsl-imx-esdhc.yaml
>>>
>>> And? Just because someone did something is not itself an argument. They
>>> might have their reasons. If their reasons are applicable here, please
>>> state them.
>>
>> OK, I thought the reason was explicit, we find it worth documenting
>> those optional pinctrl states for when the spi lines are in idle state.
>>
>> If it's not an enough good reason, we'll drop this patch.
> 
> No one wrote here any reason... The post from Amjad was about DTS usage,
> yours about other bindings. Neither of them are reasons.
> 
> Core schema already documents pinctrl states. This can be documented if
> it is different than what core checks for, e.g. required or some
> specific names are being enforced.

Looking at your driver, these seems required. I missed that part in
commit msg, because it actually explains these are needed. Then it seems
fine, but they should be made required in the bindings.

Best regards,
Krzysztof

