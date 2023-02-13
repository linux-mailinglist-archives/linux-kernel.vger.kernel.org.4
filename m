Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB3A5694052
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 10:03:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbjBMJDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 04:03:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbjBMJDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 04:03:52 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2846B764
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 01:03:50 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id hn2-20020a05600ca38200b003dc5cb96d46so10711503wmb.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 01:03:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8LLsoA+/jnvLY03SW/3CjxjxLr0O2vRnD+Q4dMXdO08=;
        b=d9L+fxYR7KB8U8abH0LHizef71A51RSbQtEJmV3+KUUPEEK3LFApM8JEQ6vr36/zz+
         i0F7jZHmtWnG0hTG53tudXdzCvyPct0YUIPCeBrVM/4KIxsM4bDN/UzlIMUUzOrHtXnc
         t96FoSEhOdtKoeKRRlAnPFxbhknCTeAjmn4wdxn/OVhroR3REoL+mKO5xSdEUhsQApdo
         Uw2MmSK2mNr9FrOhtiamQKAyNMG6wvWQPPSHXBAWRucpgw3UJk78rTzNFBnJjoD0V6Vd
         6OnQ6/8U+etKIZTubFV+z3DTMv8GES8Mwx07LXsgg+Yd/RE/Vi98G8MO2JZmZHaobA9I
         ok8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8LLsoA+/jnvLY03SW/3CjxjxLr0O2vRnD+Q4dMXdO08=;
        b=q0/I4P/c2NwQpIHwlsjYlCCBAj4/2hsT3Y/2krTvrs15N/jLAh3zGxfa5R5wShXS/S
         MCIlIWb42Tq41BdV/E/XeThMD9mKk2vlBv91UL7LYQOqMNaFI2LecyhzBeQjKlpdOlur
         M+WaB3IrC/0+qvaPulKyETcC9O6nnwe0fo4SwE89FT+5dBIsDvQXsYTdWwJm1Yrmrjm8
         /eb2eKc7vZ3YWOThQA81XgovqjkD9DBGBQ4p31k78m379UkqXPhh8JWMT39N2ReVXCha
         AppdLrwuE/fvvvTtzzTB0SXflwbkUxQNzj7wFZqPVH5dyyrgvWyIVPYl/GEx0y+r5Qc+
         B85g==
X-Gm-Message-State: AO0yUKUKyKgIlQl5rVoEb3qW47D0+cIxBpo2m4dOxGB3MlPoO4Wjn0YY
        jnrllsg9o1Snc8gC+2KemIz3Xg==
X-Google-Smtp-Source: AK7set+WaRt1w4kdWfiJ5KNpyq0QpLKtRxhAntGuIXlyAGmg0Y62u8QFkuWKubj9B+NUHiK5Pv1CJA==
X-Received: by 2002:a05:600c:2e95:b0:3da:50b0:e96a with SMTP id p21-20020a05600c2e9500b003da50b0e96amr18319399wmn.29.1676279029525;
        Mon, 13 Feb 2023 01:03:49 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:6e1e:131f:8bc1:aad8? ([2a01:e0a:982:cbb0:6e1e:131f:8bc1:aad8])
        by smtp.gmail.com with ESMTPSA id m23-20020a7bca57000000b003de8a1b06c0sm16306361wml.7.2023.02.13.01.03.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 01:03:49 -0800 (PST)
Message-ID: <e0d71204-87f3-1d07-3927-909d09d39000@linaro.org>
Date:   Mon, 13 Feb 2023 10:03:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 5/8] arm64: dts: amlogic: meson-g12b-odroid-go-ultra:
 rename keypad-gpio pinctrl node
Content-Language: en-US
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Christian Hewitt <christianshewitt@gmail.com>,
        Yuntian Zhang <yt@radxa.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230207-b4-amlogic-bindings-fixups-v2-v1-0-93b7e50286e7@linaro.org>
 <20230207-b4-amlogic-bindings-fixups-v2-v1-5-93b7e50286e7@linaro.org>
 <CAFBinCC1O52eraLJ=GoZVM0fM0zVyqdDrkP3RCjNQ=KaqhByLQ@mail.gmail.com>
Organization: Linaro Developer Services
In-Reply-To: <CAFBinCC1O52eraLJ=GoZVM0fM0zVyqdDrkP3RCjNQ=KaqhByLQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/02/2023 21:04, Martin Blumenstingl wrote:
> On Tue, Feb 7, 2023 at 4:08 PM Neil Armstrong <neil.armstrong@linaro.org> wrote:
>>
>> Fixes the following bindings check error:
>> pinctrl@40: keypad-gpio: {...} is not of type 'array'
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> 
> [...]
>>   &periphs_pinctrl {
>> -       keypad_gpio_pins: keypad-gpio {
>> +       keypad_gpio_pins: keypad-gpio-state {
>>                  mux {
>>                          groups = "GPIOX_0", "GPIOX_1", "GPIOX_2", "GPIOX_3",
>>                                   "GPIOX_4", "GPIOX_5", "GPIOX_6", "GPIOX_7",
> I'm wondering whether we make the keys work without having to specify
> a pinmux configuration for them separately.
> Our pinctrl driver already sets:
>     pc->chip.set_config = gpiochip_generic_config;
> So you should be able to use the GPIO_PULL_UP flag for these GPIOs in
> device-tree instead of specifying bias-pull-up here, for example:
>     gpios = <&gpio GPIOX_0 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>;
> 
> output-disable is managed by the direction of the GPIO anyways.
> pinmux_ops.gpio_request_enable is also implemented by our pinctrl driver.
> 
> This is not urgent - I am just curious as always :-)

I didn't know we supported this, this is only a bindings check fix, but yeah at
some point this should be moved to (GPIO_ACTIVE_LOW | GPIO_PULL_UP).

Neil

> 
> 
> Best regards,
> Martin

