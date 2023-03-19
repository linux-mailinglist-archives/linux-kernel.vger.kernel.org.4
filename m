Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 460AE6C0120
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 12:53:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbjCSLxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 07:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230360AbjCSLxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 07:53:44 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA54E23A4B
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 04:53:00 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id eh3so36637768edb.11
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 04:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679226760;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZLj0P1lq2bvFo+/6zRlEm0LLZrtFvTkebdhPbz6tAow=;
        b=RF3a/GCx8fBvZKTPgsUV9XVNsAJagR0XmHOKMLH2StTNeRbv7PAry1esWVwyj7Se9T
         +GbeuXz4rDcnxFRQ0ifEtFNi4SpGrzAoB3bpSgPJwEOqGY0tTTMd35kRSm1+1c7GKq3y
         Jh2ImdKHcRbqYZnSOdsTMYpq7WltsBVpxxXu2dC+n7zycw27CYXu9tZV1J/sMKHbccec
         XlvsZq9FZ3ByGW9L/KVF1DXWMQcAfUm2l5ZHZBvet3Z6sKAMrN95wPeK/Agdohdd7B9m
         Xa2u8aEVBsIKxN3tVJ8f4o/qE4vRTTV20C0OonkYqLet9VphEZfTkiLXg0SEL2VnPxXN
         8ytg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679226760;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZLj0P1lq2bvFo+/6zRlEm0LLZrtFvTkebdhPbz6tAow=;
        b=cb0PKIPe6JMAlA3LTCK6Zdng7+oI+7xY0dDjKvvpzxEWBknA2+t3QHzAH38RDS6iG9
         aJRfhPDmP8QmAeuuemFnJVpmnqw2rhth0afA5Ecjn26jYdCCOxcLk08FXcPDYMcZz+Sz
         GHPflg4aggSXeeIbsKVhNilb8JZDQG4kO6N7JCI9vM9+F1NBxrt7gOpbRSjD4UQsJjVo
         /QGwMAe2S7HTTJRjR5BkUyE6+u00SwTsmt2wuyrJjlEsLdYgPpc/ZxF6wCKK9oUxljps
         3GfyyatyFKwI4uqdiItiARuN1uR6Hz+CVdllc4+63EkCcUHyoW8eTkgvl22hYxf2/P80
         RHPg==
X-Gm-Message-State: AO0yUKWmPFCAyHYyJ+GIEBicnD6O266PzAOpmq+gLSMXBfbXXprQtYzf
        cTLnUXqbTiEtIhhxGkbcS0E=
X-Google-Smtp-Source: AK7set9h4sX9QnfNlzB8p4fQlOOvU+gnT/OTj9SGs/mAADG3tXujvXMnY8dX/DqRFM5xOPh71P9wGw==
X-Received: by 2002:aa7:d48b:0:b0:4ac:bcf9:6d6c with SMTP id b11-20020aa7d48b000000b004acbcf96d6cmr8217438edr.36.1679226759954;
        Sun, 19 Mar 2023 04:52:39 -0700 (PDT)
Received: from [192.168.1.16] ([41.42.177.251])
        by smtp.gmail.com with ESMTPSA id v6-20020a50d086000000b004fb00831851sm3379178edd.66.2023.03.19.04.52.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Mar 2023 04:52:39 -0700 (PDT)
Message-ID: <c82427af-dc37-734b-348c-371103a4ff90@gmail.com>
Date:   Sun, 19 Mar 2023 13:52:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] staging: greybus: add blank line after struct
Content-Language: en-US
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     gregkh@linuxfoundation.org, outreachy@lists.linux.dev,
        johan@kernel.org, elder@kernel.org, greybus-dev@lists.linaro.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
References: <20230319110831.39931-1-eng.mennamahmoud.mm@gmail.com>
 <alpine.DEB.2.22.394.2303191216240.2867@hadrien>
 <15e81411-e40f-43c5-bb7f-907d6d5f93c5@gmail.com>
 <alpine.DEB.2.22.394.2303191235580.2867@hadrien>
 <6cc1e2f7-e971-b195-acba-9b4c136aa16b@gmail.com>
 <alpine.DEB.2.22.394.2303191246190.2867@hadrien>
From:   Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
In-Reply-To: <alpine.DEB.2.22.394.2303191246190.2867@hadrien>
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


On ١٩‏/٣‏/٢٠٢٣ ١٣:٤٦, Julia Lawall wrote:
>
> On Sun, 19 Mar 2023, Menna Mahmoud wrote:
>
>> On ١٩/٣/٢٠٢٣ ١٣:٣٦, Julia Lawall wrote:
>>> On Sun, 19 Mar 2023, Menna Mahmoud wrote:
>>>
>>>> On ١٩/٣/٢٠٢٣ ١٣:١٩, Julia Lawall wrote:
>>>>> On Sun, 19 Mar 2023, Menna Mahmoud wrote:
>>>>>
>>>>>> add blank line after struct for readability as
>>>>> The log message should start with a capital letter, so "Add".
>>>> Okay, I will fix it.
>>>>
>>>>>> reported by checkpatch script
>>>>> "reported by checkpatch" or "reported by the checkpatch script".
>>>>> The first is more concise, and it doesn't really matter whether
>>>>> checkpatch
>>>>> is a script or something else.
>>>> got it.
>>>>
>>>>>> " CHECK: Please use a blank line after function/struct/union/enum
>>>>>> declarations"
>>>>> I guess the #define was concatenated to the end of the definition to
>>>>> show
>>>>> that it is closely related to the definition.  With the #define, it
>>>>> seems
>>>>> rather natural, but the better soltution would be to make a static
>>>>> inline
>>>>> function in both cases.  There would naturally be a blank line before a
>>>>> function definition as well.
>>>> got your point, so, should i ignore this?
>>> Not sure what you mean by ignore.  If you rewrite the #define as a
>>> function, an use the natural placement for a function definition, then the
>>> checkpatch warning will go away as a side effect.
>>
>> I mean ignore this patch and make another patch with rewrite #define as you
>> suggested.
> Yes :)  That's fine ("drop" would be better than "ignore").
>
> julia
>
Okay :D, Thanks Julia.

Menna

>>
>> Menna
>>
>>> julia
>>>
>>>> Menna
>>>>
>>>>> julia
>>>>>
>>>>>> Signed-off-by: Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
>>>>>> ---
>>>>>>     drivers/staging/greybus/gbphy.h | 2 ++
>>>>>>     1 file changed, 2 insertions(+)
>>>>>>
>>>>>> diff --git a/drivers/staging/greybus/gbphy.h
>>>>>> b/drivers/staging/greybus/gbphy.h
>>>>>> index d4a225b76338..1de510499480 100644
>>>>>> --- a/drivers/staging/greybus/gbphy.h
>>>>>> +++ b/drivers/staging/greybus/gbphy.h
>>>>>> @@ -15,6 +15,7 @@ struct gbphy_device {
>>>>>>     	struct list_head list;
>>>>>>     	struct device dev;
>>>>>>     };
>>>>>> +
>>>>>>     #define to_gbphy_dev(d) container_of(d, struct gbphy_device, dev)
>>>>>>
>>>>>>     static inline void *gb_gbphy_get_data(struct gbphy_device *gdev)
>>>>>> @@ -43,6 +44,7 @@ struct gbphy_driver {
>>>>>>
>>>>>>     	struct device_driver driver;
>>>>>>     };
>>>>>> +
>>>>>>     #define to_gbphy_driver(d) container_of(d, struct gbphy_driver,
>>>>>> driver)
>>>>>>
>>>>>>     int gb_gbphy_register_driver(struct gbphy_driver *driver,
>>>>>> --
>>>>>> 2.34.1
>>>>>>
>>>>>>
>>>>>>
> >
