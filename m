Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF0662D845
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 11:41:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234569AbiKQKlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 05:41:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232918AbiKQKlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 05:41:07 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AE3DD8F
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 02:41:06 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id u11so2162568ljk.6
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 02:41:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YaIoPEw50t/WnUVDQR7OpPSHvfe9ZA8zd1uZiMhTfVs=;
        b=aPeuNckmtl5EB/l+0Qale09NLiNdChQfebcy4/BvqLQEWkKt6+qqyqo9aFR4/60ryB
         5stGSPj95r5pywiQvYVBiu4rRG7Df7TshFubUoVtJUiTrclc2/yRnc0GtUscauLByE9t
         jf2NweY5ROB3AY6ZW2Hpt49eejWPUjif/yIYLwlS6esHt3hlMqqgiFlDRrMHtzIE2514
         j2eQO7jAmb2ot030R148X+w64MkeMgSext2zFi5/j3bz7hN/8N+vn6s5L5H0M9vN1+HH
         43MnnCx/eAP+Ay7gPaG7Waq/qZInnv57tUgsCQuoxgbwpHmRJcTr24nSuZtCaYV9uGnZ
         hNcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YaIoPEw50t/WnUVDQR7OpPSHvfe9ZA8zd1uZiMhTfVs=;
        b=quNRBJ3OOc84e1UKqsb5Zerm0GjNPE12izxDMa1djFjp/07MzBcsIzsc01q/SIWqwW
         PDpvXmnXWzY840yWKKdwrtF7w8tC2aWRyO2POKLOGREiNWBugQYxpLM2tABom/OV47hp
         MyPJYNQpXAMq4t5jOkqX2WmHV9X1/YO0uzdWaNvDaR7yGckCWfA0VICjMDxdkWOUcro5
         n1bUDfQFDYc8wwV8dCiJFnQiVXjJvTngJswrrgTHpyLuNPN+SOdsyKyXiUIM7bi5KPqm
         jZeAeAAuEBYpH3EKU3vFartxBhOj5oBgrEByErJhDI2XO4OmpSEVk7KXeXAznnAmI+KH
         LRpA==
X-Gm-Message-State: ANoB5pkr3DOBFawP13gctx3JakJYfwMtYqWIMTL0DuwdKztGQErR/v5K
        ySi9vG+mhw7EGMlU0rEgQ/4fhA==
X-Google-Smtp-Source: AA0mqf4z2oP3JjGAWN93rZG5cxw7xFixqf6bHZNRbG5efsjg1g6+wHUM+FNDDRDmlqcs4lWO2Oczrw==
X-Received: by 2002:a2e:350d:0:b0:277:10b2:47e5 with SMTP id z13-20020a2e350d000000b0027710b247e5mr728289ljz.502.1668681664835;
        Thu, 17 Nov 2022 02:41:04 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id z8-20020ac25de8000000b004946bb30469sm88934lfq.82.2022.11.17.02.41.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Nov 2022 02:41:04 -0800 (PST)
Message-ID: <5a986cd4-12fe-a9f9-51f2-844fa6989bc8@linaro.org>
Date:   Thu, 17 Nov 2022 11:41:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 1/2] dtbindings: clock: Add bindings for Renesas PhiClock
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Alex Helms <alexander.helms.jy@renesas.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, sboyd@kernel.org, mturquette@baylibre.com,
        geert+renesas@glider.be
References: <20221115192625.9410-1-alexander.helms.jy@renesas.com>
 <20221115192625.9410-2-alexander.helms.jy@renesas.com>
 <e9fd112f-0fd2-e833-8687-9a256c307842@linaro.org>
 <9231404a-85b2-9a9f-f040-f97615bf8ec0@renesas.com>
 <6dc67c30-d9c3-5906-a2bc-263ac83df051@linaro.org>
 <CAMuHMdVoCVz7zyWvAbCydSGQ6RnRxH2kBFDyu-M-Fn8h_XicLQ@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAMuHMdVoCVz7zyWvAbCydSGQ6RnRxH2kBFDyu-M-Fn8h_XicLQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/11/2022 09:11, Geert Uytterhoeven wrote:
>>>>> +
>>>>> +  renesas,ss-amount-percent:
>>>>> +    description: Spread spectrum absolute amount as hundredths of a percent, e.g. 150 is 1.50%.
>>>>
>>>> What? If this is percent then it cannot be hundreds of percent. Percent
>>>> is percent. Use appropriate units.
>>>> https://jpn01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2Fdevicetree-org%2Fdt-schema%2Fblob%2Fmain%2Fdtschema%2Fschemas%2Fproperty-units.yaml&amp;data=05%7C01%7Calexander.helms.jy%40renesas.com%7C9c13a32848f3434e217108dac7ab69f6%7C53d82571da1947e49cb4625a166a4a2a%7C0%7C0%7C638041836281252737%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=6MULpJhPyyjWSo1SvPCrz6KidE1VEtiiNYk1O5wS1vI%3D&amp;reserved=0
>>>>
>>>
>>> Values like 0.5% or 2.5% must be representable which is why this
>>> property is an integer of hundredths of percent. How else would you
>>> represent a non-integer percent?
>>
>> With an appropriate unit.
> 
> Krzysztof really means the property should be named e.g.
> "renesas,ss-amount-centipercent" instead.
> 

I provided an URL to document with units, so I was hoping Alex will take
a bit of effort to open it. Hundredths of percent sounds like basis
point... If it is not basis point, maybe it could be made such?

Best regards,
Krzysztof

