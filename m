Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC4386FD95E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 10:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236411AbjEJIbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 04:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236096AbjEJIay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 04:30:54 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D40430DA
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 01:30:53 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-50bc37e1525so13226634a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 01:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683707452; x=1686299452;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ycVbFDvJKMn/ZQ/Sjxa4EA026DOMmlduluDtzGBRPK8=;
        b=jbw+ByzEda9BliMbGY9HEq5I/RrhS6mjA5ZAszCbu34H0KfK6/qm14nYYc69sxKGej
         ssRbmkfsRxyavVVVyzETV+5pgOSh0hUmgMeT48fZcT8jXCsOHozyMdUcLJtSnwdDmC7x
         9at0/CMH10PidpH9LSeZkOnhtYZ4PQVtS1vBT3rMwY2FdGixiur9vygWFs2E3hcpZC8m
         2GUmcFx0P1Z5fOPxPVIJ/WaBT8kTAMc0Z7zXnnMyV4X5VoWBZNx/Br3hHiGP5Rl4/5q6
         8OKF3GKxh+yRYeg/HoPC7J6EI1F/Ul2imJkcZbmV1smSuAljge7u10FJbDt8iqlLc73H
         Z2yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683707452; x=1686299452;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ycVbFDvJKMn/ZQ/Sjxa4EA026DOMmlduluDtzGBRPK8=;
        b=NnzwEYWgVqwsf8NzHkIcs589spBcOhkvaruUgX0eJrVOaeJkhJnOFZNa4pY1LIe7Fh
         g5knDHmW7GT4mjFcIg5b+LDa1DeYyMzI6dxIqDCnKnyu5EUz9yJ//86vdtn4sfJRfFqq
         WFESym8SmSk/t4zvWBQ2SutX7VDaJE2GtHJZCWDNSQEKmxkqLHAWJoGrcOVqswPAxWbk
         fYji3yo0o2gi6BzaAjz7qGN4q+gNwZqg+BQJk7+AhZgBX4192wYfOYE+0bC27e+4Ek83
         KGIisNN9a9wMQb6hRxjXfUDppuAa54TFxQXxhXgyoZpxI2/H0cv30UpKDKKOxtL6wwxb
         19hw==
X-Gm-Message-State: AC+VfDyLYkOokqzPik0LYRtirmS2sGGJymarnWzLgse4c3HJMVVZb9fP
        jclQaaIAVImWXLci23sIQPxcCA==
X-Google-Smtp-Source: ACHHUZ7F+ZXWaQdztu2Ta5OaQNG0xil5uAK5Tm4AyA6F7SoxpLJulLwH2YMvCEfUBS6Yo/M4ELlyOQ==
X-Received: by 2002:a17:906:fd8e:b0:961:a67:28d with SMTP id xa14-20020a170906fd8e00b009610a67028dmr14295990ejb.22.1683707451838;
        Wed, 10 May 2023 01:30:51 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:c175:a0f9:6928:8c9d? ([2a02:810d:15c0:828:c175:a0f9:6928:8c9d])
        by smtp.gmail.com with ESMTPSA id x4-20020a1709060a4400b0095ed3befbedsm2379116ejf.54.2023.05.10.01.30.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 May 2023 01:30:51 -0700 (PDT)
Message-ID: <0fcc4617-e706-8743-e65d-1ff99f38ddac@linaro.org>
Date:   Wed, 10 May 2023 10:30:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/2] ASoC: dt-bindings: Add adi,ssm3515 amp schema
Content-Language: en-US
To:     =?UTF-8?Q?Martin_Povi=c5=a1er?= <povik+lin@cutebit.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        =?UTF-8?Q?Nuno_S=c3=a1?= <nuno.sa@analog.com>,
        asahi@lists.linux.dev, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230509163828.86003-1-povik+lin@cutebit.org>
 <7b8c22e3-75c1-8803-fb32-097d12fbde78@linaro.org>
 <04BB0158-6C7B-400C-A87A-6E9B2835FDC7@cutebit.org>
 <627f1739-98b4-9576-4b11-887c8f7e0c52@linaro.org>
 <5FC57F67-CC16-4DA4-9A0D-9F9A0539EE67@cutebit.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <5FC57F67-CC16-4DA4-9A0D-9F9A0539EE67@cutebit.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/05/2023 10:29, Martin Povišer wrote:
> 
> 
>> On 10. 5. 2023, at 10:23, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 10/05/2023 10:15, Martin Povišer wrote:
>>>
>>>> On 10. 5. 2023, at 9:51, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
>>>>
>>>> On 09/05/2023 18:38, Martin Povišer wrote:
>>>>> Add a DT schema for the SSM3515 amp by Analog Devices. It's a simple
>>>>> mono amplifier with digital input.
>>>>>
>>>>> Signed-off-by: Martin Povišer <povik+lin@cutebit.org>
> 
>>>>> +additionalProperties: true
>>>>
>>>> uinevaluatedProperties: false instead, so users can have name-prefix.
>>>
>>> I actually tweaked this to have the example passing, which has sound-name-prefix,
>>
>> true is not allowed anyway - it makes your schema simply not effective
>> almost at all as it allows anything...
> 
> That makes sense.
> 
>>> which I guess is what you have in mind. Not that I exactly understand what these
>>> options do (both additionalProperties and unevaluatedProperties), the schema docs
>>> didn’t enlighten me right away when I looked into it.
>>
>> The way to go and to start always is to look at example-schema. It tells
>> you explicitly to use additionalProperties:false and switch to
>> unevaluated "If and only if another schema is referenced".
> 
> OK. While I have you on the line, what does unevaluated do? In what sense are props
> unevaluated?

Properties can be evaluated by some other referenced schema (e.g.
dai-common.yaml). If nothing evaluated them, they are unevaluated, thus
unknown and not allowed.

Best regards,
Krzysztof

