Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8FB68A108
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 18:58:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232815AbjBCR6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 12:58:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232491AbjBCR6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 12:58:22 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57CFFB75C
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 09:58:16 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id hn2-20020a05600ca38200b003dc5cb96d46so6551068wmb.4
        for <linux-kernel@vger.kernel.org>; Fri, 03 Feb 2023 09:58:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lN+M6aiUbCqF46CC1crDFxdVf7hLTQ+IRNqaZ978vd8=;
        b=S1EjWXdz//eVBIiu80y0i58Nwfp/vPB6JlRYf2vOiL5xiefMP2zINH+qTlJJbRKItY
         WPrNVD0VpVMglADIzRh8Ojmkhb+O/yZ6DvaCEfVRF7ZEnrTYtwIF13YFx5XNMFgIj8rE
         uWSA5IlhAOYI0mTPHGzK+xv/oXOiRT/JZGYpW3WMtyFcdn+ofmFkqIFIURJEvwE7FM7Q
         2TMKBxnxWIbBXDhy/h1s540I8b9ylHqaLRjlafMhockTDHZP+qIiT44NeP9mnh4zsA0s
         Xclq547eR3BpKU4H5GOz04EFZ1KWSUjYUabfKn1PAQqCB0mIirpl0MmXm/DFU5UC11ms
         1l5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lN+M6aiUbCqF46CC1crDFxdVf7hLTQ+IRNqaZ978vd8=;
        b=ecDBbR2CGGkqBYJiBuFbM4xdU9llmDVaZx4j6WcZ938bblnikSN9DQoyv5F50usKRY
         uhGkQbHxSSoMVfrP+OfX55xZfF13DchvY1Gltom7XvfLxtyRgGE4oN2JxHhNcY5dl69c
         MxOq7irXvLWPpn0fnwEMTUZjJthe7fMuQXnt6GMfk5kglKB73xgz7XLrN1PD6bNgu2G1
         OtNu0QpnOLhw2qKk0616eqaExpnw8cx8zh6saKcgfAgijjJxdqcVaR/yID3A+OHZroUV
         iAJqmxtaVebhghKNR0LGvbLeXm3m1LuuvvsDnKQqcylm9i9GCMzNspCn/WbLd/2EMiMs
         c7Og==
X-Gm-Message-State: AO0yUKVjzcHe0D7dfzhmHgBQB7OJi7fXV6CqUPmhP9CFV5fBju+5s5iV
        SDkCEyRkPLEBdgifeOiulAQRhw==
X-Google-Smtp-Source: AK7set/XQawmCDWrVyjPwzNZBBNVKsO+g4KUQAE8B9uS3eeB81KjPN+ttS8KXCXrBfkXJpYejKU66Q==
X-Received: by 2002:a05:600c:510e:b0:3dc:59e9:9285 with SMTP id o14-20020a05600c510e00b003dc59e99285mr11539024wms.18.1675447094889;
        Fri, 03 Feb 2023 09:58:14 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id p2-20020a05600c358200b003dc4ecfc4d7sm3609686wmq.29.2023.02.03.09.58.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Feb 2023 09:58:14 -0800 (PST)
Message-ID: <d72f2c93-934c-67fe-0afd-96bc52b12a9f@linaro.org>
Date:   Fri, 3 Feb 2023 18:58:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 6/9] ASoC: dt-bindings: meson: convert axg fifo to schema
Content-Language: en-US
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org
Cc:     linux-amlogic@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org
References: <20230202183653.486216-1-jbrunet@baylibre.com>
 <20230202183653.486216-7-jbrunet@baylibre.com>
 <6e6ed493-4748-46ca-7a26-fe9cf6e2377a@linaro.org>
 <1jmt5un9u4.fsf@starbuckisacylon.baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1jmt5un9u4.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/02/2023 14:27, Jerome Brunet wrote:
> 

>>> +  resets:
>>> +    items:
>>> +      - description: Memory ARB line
>>> +      - description: Dedicated device reset line
>>
>> This won't work without minItems and you should see errors on your DTS
>> or in dt_binding_check
>>
> 
> The example provided here worked but there is indeed a warning with the
> axg-frddr variant.
> 
> I'm adding a 2nd example so it does not happen again.

If the difference is only in one property, no need. If the difference is
in more properties - then could be. We do not keep examples for every
trivial change, because the assumption is that submitter tests DTS as well.

> 
>>> +
>>> +  reset-names: true
>>
>> minItems
>> maxItems
> 
> Adding this causes troubles with the reset-names definitions in the 'if'
> clause. If I put min: 1, max: 2 and min: 2 in the 'then' clause I get:
> 
>> Documentation/devicetree/bindings/sound/amlogic,axg-fifo.yaml: allOf:1:then:properties:reset-names: 'oneOf' conditional failed, one must be fixed:
>>        [{'const': 'arb'}, {'const': 'rst'}] is too long
>>        [{'const': 'arb'}, {'const': 'rst'}] is too short
>>        False schema does not allow 2
>>        1 was expected
>>        hint: "minItems" is only needed if less than the "items" list length
>>        from schema $id: http://devicetree.org/meta-schemas/items.yaml#

Probably because rest of binding does not match. One way is like this:

https://elixir.bootlin.com/linux/v5.19-rc6/source/Documentation/devicetree/bindings/clock/samsung,exynos7-clock.yaml#L57

> 
> The older devices just have the 'arb' reset.
> Newer devices have a 2nd reset line (called rst here)
> 
> If I just restrict the min and max, it would be valid for the older
> devices to have 'rst' only - but it is not valid.

How? Why would you define for old devices "rst" as one name if this is
not correct?

> 
> With just 'true', it works as expected (throw errors if an incorrect
> name or number of names is passed). Min and Max comes from the items list.

Because the rest is not in recommended way. Once you implement it in
recommended way, there will be no such...

> 
> Any suggestions ?

Implement rest of comments.


Best regards,
Krzysztof

