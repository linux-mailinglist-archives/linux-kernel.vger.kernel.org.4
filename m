Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31C1563135D
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Nov 2022 11:40:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbiKTKkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 05:40:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiKTKkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 05:40:11 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB06776DD
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 02:40:10 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id p8so14892470lfu.11
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 02:40:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6I/Z/D+bfI5rpoGK4pCb1Y+E9eMHCV51iKQUL8lPZc0=;
        b=bjf3d2XJA3mpzYV8yNz6tmkpXTOu9TbqM0pYlTCxxM4PDnrCnmbZGYEvbsd8SX9Lp+
         sy7gko4NuhDtFiWM6jDQKHMVnSf3Kh8dJOPwGlUy3R/v0js1OZYNfGAQeWR8Apk/D5gu
         PmdTqSZqPneghE6OF6e0lJaT+jCDUCex2TqrN+S+uGkMV8/Gcn5UPNIkFJOgoIWUP56N
         j0S2pTdxvg1fE6rKaYzwJDqNqIuPujONqSXQNLSSQxrBurfYdBsi9hff9ThJHznwWb0O
         XMsKuTp2B+OYnHyvT1M3JYyFeubXw9AB/Nc3M5FU/8naBaDF9FXJCB6gSvOFZ2FBmUFc
         AAgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6I/Z/D+bfI5rpoGK4pCb1Y+E9eMHCV51iKQUL8lPZc0=;
        b=U7cTMgHc5NPFYSKr9DurYZBtwVBbk7oxEdCWQQzNiVmrrxWPzuwqfq0UCAhfwjI8AT
         Qvip9olX8k3vZB/Q/Yrq6PBDJjkKAFoSHiQNffwzxBS3M8X7/v37CF1O61ffjVtEFUpz
         k3SbXs3+///QQmW2IZF8rAhQirSWsaBn1HOInBQTCpscQqjm0i9Vu5kOJ+OGcs4tfmWf
         KoI5t6Viyk8ZGZsmpEKGI0YK1M1SAD8t7qmdvRBCD3SW4bUWXt9iTA2ACjf8otK5i9Hw
         ItYTmX3JvRwh19wP20aMb99bafucIYGA3PQdkOtaasRA01k7hBxmYDktD0qesWLEv82o
         J/tQ==
X-Gm-Message-State: ANoB5pnP9r/Dlzhq8D/kJ9vWBQGAnGVf9kcvrCIMQSAM3akJbx7XvsX7
        F6GJsWGoC6xzwkXR2EIM0d4XXQ==
X-Google-Smtp-Source: AA0mqf4GJTVZ6oOy/tG1Y2xUN3IM+SCcLz2+qe3xY1TglkFbGHfu9W873n2qi+HObj1karKVyGKUUQ==
X-Received: by 2002:ac2:43b0:0:b0:4a4:719a:19ed with SMTP id t16-20020ac243b0000000b004a4719a19edmr5135600lfl.356.1668940808593;
        Sun, 20 Nov 2022 02:40:08 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id k21-20020a05651239d500b00494618889c0sm1488288lfu.42.2022.11.20.02.40.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Nov 2022 02:40:08 -0800 (PST)
Message-ID: <76cae9bf-c81a-684a-c22b-9548dd82c8d4@linaro.org>
Date:   Sun, 20 Nov 2022 11:40:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v3 4/7] dt-bindings: pinctrl: add bindings for Mediatek
 MT8365 SoC
Content-Language: en-US
To:     Kevin Hilman <khilman@baylibre.com>,
        =?UTF-8?Q?Bernhard_Rosenkr=c3=a4nzer?= <bero@baylibre.com>,
        linux-mediatek@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        angelogiocchino.delregno@collabora.com
References: <20221117210356.3178578-1-bero@baylibre.com>
 <20221117210356.3178578-5-bero@baylibre.com>
 <06e916b7-f8f2-6de5-f86e-7b020c052451@linaro.org>
 <7ha64o9h1d.fsf@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <7ha64o9h1d.fsf@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/11/2022 20:52, Kevin Hilman wrote:
> Hi Krzysztof,
> 
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> writes:
> 
>> On 17/11/2022 22:03, Bernhard Rosenkränzer wrote:
>>> Add devicetree bindings for Mediatek MT8365 pinctrl driver.
>>>
>>> Signed-off-by: Bernhard Rosenkränzer <bero@baylibre.com>
>>
>> Thank you for your patch. There is something to discuss/improve.
>>
>>> +
>>> +  pins-are-numbered:
>>> +    $ref: /schemas/types.yaml#/definitions/flag
>>> +    description: |
>>> +      Specify the subnodes are using numbered pinmux to specify pins.
>>
>> Why would you name pins differently per board? And why this different
>> naming of the same pins is a property of hardware?
>>
>> This looks like something to drop.
> 
> Yeah, having this as a flag kind of implies that this could be present
> for some boards but not others.  But in practice, the driver requires it
> to be present or just fails[1].  What's the right way to describe that?
> We're just trying to add a binding that reflects the existing driver.

Uh, what an interesting property. What's the point of it then? Why
failing to probe on a missing property which does nothing else?

The solution is also to drop that property from the driver.

> We also noticed that there's another documented binding with this
> same flag[2] where similiarily, the driver simply requires it to be
> present[2].
> 
> So is the way this flag is documented in the stm32 binding OK for the
> mediatek one also?  If not, what would you suggest?

I would like to understand why do we need this property and what is
described by it. Because if it's purpose is only to fail or not fail
driver probe, then we should just drop it everywhere.


> 

Best regards,
Krzysztof

