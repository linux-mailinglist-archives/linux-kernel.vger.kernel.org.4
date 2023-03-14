Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E60946B9BC3
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 17:37:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbjCNQhp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 12:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbjCNQhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 12:37:36 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF513B5B7B
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 09:37:07 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id o12so64461144edb.9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 09:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678811826;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jlGiPxrBuoe9rTT5t5btZfai4+ZRhJj1KWzKF0d0HFU=;
        b=FQ/jOD6i4QQu8oqCAAp5ZGGmktZ2aOz+YkkM8ZFiMxN80MnfYP1emmP8nM7ymFNpyz
         xJYIYUbYxnc/7QnSfRk+sVAS5KzuNa1L9hqn6KyvE9zOYh8H7LmYy+MNSAYfs7zgPj7L
         ot4J620sW+6KSVfw/+kaYfsoRHI4CtDy1s+MhMyVSSiD7LAKyFmclBYkGDCow1kjyr+l
         pOYoc4R100uTMGMrnrvA0Pcjft9D+KQ+PMzbPUGaUzG5Zwby6NcEPLrPJ2ph2XhgceH3
         MktBbOUBaSfdw8pYBQWXQjU33gj+DMnjBRG87wKxifJcbEL8sl3s74LurRBgV1YcSC4D
         D64g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678811826;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jlGiPxrBuoe9rTT5t5btZfai4+ZRhJj1KWzKF0d0HFU=;
        b=fLcgMmXe7ZNTdTg7zklHgIXsPBg5m7FO7xhMj42B8F6fWwP2UUqqjJtHx3AHQ4AU5c
         b32j2aKQ9c2zndJU7Bk4fzkQoR/UJT/FdO+Ld8z3l2nD4rrooTnPWQbFgwiNcVwLKxUL
         14BkBZi5l6ta2r79+E6/CFz1BH6cABW3sRXZGisU+XP7Fu1nKDvS0B95NfH0onthPYhF
         8S350vT3HsdEzbNsQYo57M4biYN6uoK1Bhe5lWr+6ZrhASNWXSl6BRdpy2JAi1rOfPZI
         LAboItgv1dBETxZ+HO6KqlypBoxSymgfupK+RfnK6lqlqSVg9i/GxCHWslLLeKqadmel
         vUMw==
X-Gm-Message-State: AO0yUKXMJpdIvgd5hQ408XBhaAA19ZfBaiOfdgFimZoptqmCKw2NlR88
        ao2zaxkNmUP2a1j25L/lhNHPDw==
X-Google-Smtp-Source: AK7set9lnU/c+UFm9vu8VIT38DOdPTI3d2yJvUCDcnXWxLpHH00EYbhYjyI9vtClCCGH+kKcraHy5w==
X-Received: by 2002:a17:906:950a:b0:92a:32ac:8f3d with SMTP id u10-20020a170906950a00b0092a32ac8f3dmr2935863ejx.66.1678811825873;
        Tue, 14 Mar 2023 09:37:05 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:59be:4b3f:994b:e78c? ([2a02:810d:15c0:828:59be:4b3f:994b:e78c])
        by smtp.gmail.com with ESMTPSA id mh1-20020a170906eb8100b008eddbd46d7esm1358056ejb.31.2023.03.14.09.37.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Mar 2023 09:37:05 -0700 (PDT)
Message-ID: <b9b4d33d-f325-6437-4f4d-f051d2455e2d@linaro.org>
Date:   Tue, 14 Mar 2023 17:37:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v10 3/5] dt-bindings: clock: meson: add A1 PLL and
 Peripherals clkcs bindings
Content-Language: en-US
To:     Dmitry Rokosov <ddrokosov@sberdevices.ru>,
        neil.armstrong@linaro.org
Cc:     jbrunet@baylibre.com, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        khilman@baylibre.com, martin.blumenstingl@googlemail.com,
        jian.hu@amlogic.com, kernel@sberdevices.ru, rockosov@gmail.com,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230313201259.19998-1-ddrokosov@sberdevices.ru>
 <20230313201259.19998-4-ddrokosov@sberdevices.ru>
 <ffebef1d-8447-181b-1890-3e638d399c62@linaro.org>
 <20230314114825.yiv4vcszr6b7m45w@CAB-WSD-L081021>
 <2d9297e9-dab7-9615-3859-79b3b2980d9a@linaro.org>
 <20230314150107.mwcglcu2jv4ixy3r@CAB-WSD-L081021>
 <9d176288-cd7c-7107-e180-761e372a2b6e@linaro.org>
 <c8fecf94-2581-6cc9-955c-324efdc7c70a@linaro.org>
 <21add21d-4afe-7840-6c49-3786f82761d9@linaro.org>
 <6b7ae52c-d84d-8d08-139c-5c67ec363e85@linaro.org>
 <20230314155641.6iw5vgkrrqcx22n6@CAB-WSD-L081021>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230314155641.6iw5vgkrrqcx22n6@CAB-WSD-L081021>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/03/2023 16:56, Dmitry Rokosov wrote:
> On Tue, Mar 14, 2023 at 04:40:19PM +0100, neil.armstrong@linaro.org wrote:
>> On 14/03/2023 16:37, Krzysztof Kozlowski wrote:
>>> On 14/03/2023 16:33, neil.armstrong@linaro.org wrote:
>>>>> There are many ways - depend on your driver. For example like this:
>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/clk/samsung/clk-exynos5420.c#n975
>>>>>
>>>>> The first argument is the clock ID (or ignore).
>>>>>
>>>>> BTW, quite likely the problem is generic to all Meson clock drivers.
>>>>
>>>> This issue about "public" non-continuous defined was already discussed at https://lore.kernel.org/all/c088e01c-0714-82be-8347-6140daf56640@linaro.org/
>>>>
>>>> I don't see what's different with this one.
>>>
>>> So you are aware that all undocumented clock IDs are still allowed to
>>> use in DTS and they are ABI? Changing them will be an ABI break.
>>
>> Yes of course.
>>
>> Neil
>>
>>>
>>> Best regards,
>>> Krzysztof
>>>
>>
> 
> Sorry, guys, I'm little bit confused.
> In the discussion pointed by Neil not-by-one-increment ID with public and
> private parts are acked by Krzysztof due to explicit explanation in the
> gxbb header. Have I to comment out my situation and stay it as is?

I did not NAK your solution here. I just pointed my usual remarks that
it has certain outcome and minuses (undocumented ABI). But it is OK.

> 
> BTW, I think changing IDs value would not affect logic, because
> it's not connected to driver logic 'by values', but 'by constants

You cannot change the IDs, neither their values nor the names (with
exceptions). IDs - so the numbers - are ABI.

"Constant names" - I assume you mean the names of defines - do not exist
after preprocessing, so also not really relevant here...

> names'. We can expose/hide anything from device tree bindings, it will
> not change the clk driver logic.


Best regards,
Krzysztof

