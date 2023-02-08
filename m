Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD9468ECBA
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 11:24:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbjBHKYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 05:24:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbjBHKYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 05:24:01 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD2C93B3F7
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 02:23:59 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id j23so1036224wra.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 02:23:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hu5nkFim1hAIF+aeToLOna/YVBi/v7t0xGguJL3RQ0M=;
        b=mzkgQxJ3t5Ql9Y+Ng5kooyLTd2wve7vWgz05OygWNQEOf4E0RbbzeMXfzmlbS/UHuZ
         jdX2wCj7dBzJpoek6e8SQMHq0zEpF+TxXBPRt/8rsBS1v/1lFrS2/4TzwoxoHXhGp/CV
         coQjmu0YNN1LnPu+dt4i/463t8oQe1QDBzgohRM4DA98Yjxjx4xbTvEIuuUibl8xi0sJ
         a0G2Hk1mslK/Ys1Q6V8uZgnDgFOIxCMIxDYHZHr/vUMQPevbCAjoyk6OxxcvUIJpUk46
         ZsvwtQW4qZ7nEDB5IVS/JvBRXuMD9shmyYcflvMSFNqRXx0D9GYjURDlKGUT6Sur4adl
         uUxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hu5nkFim1hAIF+aeToLOna/YVBi/v7t0xGguJL3RQ0M=;
        b=ZYUEzH72kgOhtY+t7AM0fcQFKknBfsK/ExSPC6bvHXsReUA0hweooGZaHoOiDxRQ+6
         Gb289pqZhNoPFLXu2TfGUxPQ/zOH2H/rdYVM4rjIyG/fc21WweRHgq72PlpntVe7g4Ng
         pELTtmGxNfJHR244U9LkGaJR9zgrD9ZSHXqo3rdVHDes81+FjE4/72RSGiYCEjfQ3nbS
         WSxLBnyKqJf8hokau1rv+p2rzVwHwTqVT8Tp+6LADuZbomypJMP/JqpisKDZ9MrTS2R5
         5BA8k8hEeuuFOmMvHqCiHdHROueqhbxYUU3RpM53qQAUgNN/Ov2ogzDtpmq2QXIbUfAz
         UCUg==
X-Gm-Message-State: AO0yUKUMfIWf8e2YRDuomW5LzTxwoShnDuxKJiUT/nVSkgqLtma2fCTQ
        7O7SEd1Gxr6RNC1qY2mL3GuzYg==
X-Google-Smtp-Source: AK7set89QhkadYjIBmhhPsZgiHa8dL9PqiaGJhzXgvgfRZzRdqqx/tJ5HHLDKBAz+vb3Q+iYVfemQg==
X-Received: by 2002:adf:f5c5:0:b0:2bf:cbf0:e021 with SMTP id k5-20020adff5c5000000b002bfcbf0e021mr5897238wrp.71.1675851838423;
        Wed, 08 Feb 2023 02:23:58 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id d17-20020a5d4f91000000b002c3ec85285bsm6125567wru.70.2023.02.08.02.23.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Feb 2023 02:23:57 -0800 (PST)
Message-ID: <e7baedcb-0173-7603-9e51-99ead7001025@linaro.org>
Date:   Wed, 8 Feb 2023 11:23:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 2/2] Documentation: cs35l41: Shared boost properties
Content-Language: en-US
To:     lucas.tanure@collabora.com, David Rhodes <david.rhodes@cirrus.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org, kernel@collabora.com
References: <20230207104021.2842-1-lucas.tanure@collabora.com>
 <20230207104021.2842-3-lucas.tanure@collabora.com>
 <44faeca1-94c9-4423-d87a-03d80e286812@linaro.org>
 <e7257f9a-86c5-74e8-c538-6f6d2ba13274@collabora.com>
 <44c7274f-8a5e-0235-413a-6c3260018601@linaro.org>
 <4efe9796-6d3e-09d1-d5f7-cfb25a439061@collabora.com>
 <56ce2617-4fd1-d597-a4dc-918654cdd3f6@linaro.org>
 <e8aa571a-2d96-47da-34f0-47cc048dc655@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <e8aa571a-2d96-47da-34f0-47cc048dc655@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/02/2023 18:03, lucas.tanure@collabora.com wrote:
> On 2/7/23 4:48 PM, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
>> On 07/02/2023 17:34, Lucas Tanure wrote:
>>> On 07-02-2023 16:13, Krzysztof Kozlowski wrote:
>>>> On 07/02/2023 16:46, Lucas Tanure wrote:
>>>>>>> +      Shared boost allows two amplifiers to share a single boost circuit by
>>>>>>> +      communicating on the MDSYNC bus. The passive amplifier does not control
>>>>>>> +      the boost and receives data from the active amplifier. GPIO1 should be
>>>>>>> +      configured for Sync when shared boost is used. Shared boost is not
>>>>>>> +      compatible with External boost. Active amplifier requires
>>>>>>> +      boost-peak-milliamp, boost-ind-nanohenry and boost-cap-microfarad.
>>>>>>>           0 = Internal Boost
>>>>>>>           1 = External Boost
>>>>>>> +      2 = Reserved
>>>>>>
>>>>>> How binding can be reserved? For what and why? Drop. 2 is shared active,
>>>>>> 3 is shared passive.
>>>>> 2 Is shared boost without VSPK switch, a mode not supported for new
>>>>> system designs. But there is laptops using it, so we need to keep
>>>>> supporting in the driver.
>>>>
>>>> That's not the answer. 2 is nothing here, so it cannot be reserved.
>>>> Aren't you mixing now some register value with bindings?
>>>>
>>>> Best regards,
>>>> Krzysztof
>>>>
>>>>
>>> I have added a new patch with propper documentation.
>>> And I would like to use 3 and 4 for shared boost as
>>> CS35L41_EXT_BOOST_NO_VSPK_SWITCH already exist as 2 and is used in the
>>> current driver.
>>
>> I don't see CS35L41_EXT_BOOST_NO_VSPK_SWITCH in the bindings.
>>
>>> The laptop that uses CS35L41_EXT_BOOST_NO_VSPK_SWITCH doesn't have the
>>> property "cirrus,boost-type", but to make everything consistent I would
>>> prefer to use 3 and 4 for the new boost types.
>>> Is that ok with you?
>>
>> I don't see how it is related. The value does not exist, so whether
>> laptop has that property or not, is not really related, right?
>>
>> Best regards,
>> Krzysztof
>>
>>
> The value does exist in the code, but no device should have that in ACPI/DTB, so yes the value doesn't exist for ACPI/DTB purposes.
> I can change CS35L41_EXT_BOOST_NO_VSPK_SWITCH to another value, like 99, and use 2 and 3 for shared boost.
> I will re-submit that with v3.
> Is that ok with you?

I guess we still talk about different things. The code does not have a
binding for the boost, therefore it does not use boost binding. Whatever
it does with CS35L41_EXT_BOOST_NO_VSPK_SWITCH outside of DT, is not my
topic and I don't care.

That's why I asked folks to use strings for such enumerations, not
register values - to avoid any confusion between the code and bindings
(and also make it more readable for humans).

Best regards,
Krzysztof

