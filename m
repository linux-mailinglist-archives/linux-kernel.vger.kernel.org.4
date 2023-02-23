Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C58266A04C0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 10:26:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233938AbjBWJ0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 04:26:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233456AbjBWJ0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 04:26:11 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA42F4FCB5
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 01:26:06 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id ee7so24732830edb.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 01:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HTPqrdza57b/i0tF7P2H8m7ScdoQn+qvmHPmvgYAlqM=;
        b=Kpl3Odd4DfBUatb+oUK4znvf4vqZg3bbXOmt3y7b/E+DPaI/gE12tUOCiR/FjbV5JJ
         6w6RXUF7W2FciZwCyPDh7smq2MG4bag+omm7dbln5jie3+XiohRPegmJPOPAqfAlDDhf
         HV1omLLRQdKooO2h2AG52SBuE9oa0AD5G9LhvBFgL4Hm6sCgkFy/UmpBNUKAgnSODv3t
         okWqDePClnW0n8/aNof0A57v2RhzS2M5Ub3VluMjEJ1paLklRK1x9FN3RvHvefTY9S29
         GBq6F0zB3TD3ooncvX50e4+b9kjdrG5Yeg/sMS/30l/gH9PvuRTQzR0SXezQ59siL4j5
         QTLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HTPqrdza57b/i0tF7P2H8m7ScdoQn+qvmHPmvgYAlqM=;
        b=wUNSotCw4SiBbJzOOcylyQTFcBLRzb/6GzOorI71faMpFfBcZT1RgwFFi7iNGp8KG1
         Ubfm5/UBpWuxE5nxhs5FE2oJ7qr5Gb+9GR75G6i5tHHF4o3lTcsHClB5VkjcpbPBA03k
         xkF1JOJ4nLzqy64cQuhFW6BhuEv0dBoEzEqobH7m2RC0bx4blk9/0zQNoMvFxJ0xrq0s
         XtJhkC8e6l+joYjugFH9RfSLmo+5edZrOL6DGjIPqGMDIpsQv21iPML0+BRLXNGnaQma
         2NlFxdC6+OAQ8hUNBR/InLC+0iJs7GE8nvzXxrgK3Wivv9tttcvWPWe0Oin8wwBZQNTv
         7cEA==
X-Gm-Message-State: AO0yUKXiqFNqlUcCLi8V0JWfFdk2u9ppBkqhaCvDLVN19EuGoNJyaHuP
        h+id0ts/5D864PheZjMxuTsEEQ==
X-Google-Smtp-Source: AK7set/3HmjmvJmIpPFWFLcD2qUG14pxGYDBL5y9WyM5aGAIcsmY6YRkED/94Lksw1wMaVEbv9pNVg==
X-Received: by 2002:a05:6402:31ee:b0:4ae:eae1:1458 with SMTP id dy14-20020a05640231ee00b004aeeae11458mr11824256edb.31.1677144365246;
        Thu, 23 Feb 2023 01:26:05 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id gk7-20020a17090790c700b008c673cd9ba2sm6230616ejb.126.2023.02.23.01.26.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Feb 2023 01:26:04 -0800 (PST)
Message-ID: <33abc8a3-39f7-af7c-9676-723228624b0f@linaro.org>
Date:   Thu, 23 Feb 2023 10:26:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [RFC PATCH 1/6] dt-bindings: iio: light: Support ROHM BU27034
Content-Language: en-US
To:     "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Liam Beguin <liambeguin@gmail.com>,
        Peter Rosin <peda@axentia.se>,
        Randy Dunlap <rdunlap@infradead.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <cover.1677080089.git.mazziesaccount@gmail.com>
 <af211ec180d91a13862630e635019ebe03d4be31.1677080089.git.mazziesaccount@gmail.com>
 <e6b2a6f4-d710-7f74-e85d-1cd3f5b96460@linaro.org>
 <101db5e2-e878-b751-9679-6ea45eb24c26@fi.rohmeurope.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <101db5e2-e878-b751-9679-6ea45eb24c26@fi.rohmeurope.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/02/2023 07:20, Vaittinen, Matti wrote:
> Hi dee Ho Krzysztof,
> 
> Thanks for the review! It's nice you had the time to take a look on RFC :)
> 
> On 2/22/23 20:57, Krzysztof Kozlowski wrote:
>> On 22/02/2023 17:14, Matti Vaittinen wrote:
>>> ROHM BU27034 is an ambient light sesnor with 3 channels and 3 photo diodes
>>> capable of detecting a very wide range of illuminance. Typical application
>>> is adjusting LCD and backlight power of TVs and mobile phones.
>>>
>>> Add initial dt-bindings.
>>
>> Driver can be "initial", but bindings better to be closer to complete,
>> even if not used by the driver currently.
> 
> Out of the curiosity - why is that? (Please, don't take me wrong, I am 
> not trying to argue against this - just learn the reason behind). I 
> can't immediately see the harm caused by adding new properties later 
> when we learn more of hardware. (and no, I don't expect this simple IC 
> to gain at least many properties).

Linux drivers change, but the hardware does not, thus DTS, which
describes the hardware, can be complete. It should be written based on
the hardware, not based on Linux drivers. If you add incomplete
bindings, this suggests you wrote them to match your driver, not to
match hardware. This in turn (adjusting bindings to driver) makes them
less portable, narrowed to one specific driver implementation and more
ABI-break-prone later.

Imagine you that clock inputs, which you skipped in the binding, were
actually needed but on your board they were enabled by bootloader. The
binding is then used on other systems or by out of tree users. On your
new system the clocks are not enabled by bootloader anymore, thus you
add them to the binding. They are actually required for device to work,
so you make them required. But all these other users cannot be fixed...

What's more, incomplete binding/DTS is then used together with other
pieces - DTS and driver, e.g. via some graphs or other
phandles/supplies/pinctrl. So some other DTS or driver code might rely
on your particular binding. Imagine you had only vdd-supply regulator,
but no reset pins, so the only way to power-cycle device was to turn
off/on regulator supply. Then you figure out that you have reset pins
and it would be useful to add and use it. But already drivers are
written to power cycle via regulator... or even someone wrote new driver
regulator-pwrseq to power cycle your device due to missing reset GPIOs...


Best regards,
Krzysztof

