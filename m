Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B00E56C05DC
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 23:01:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbjCSWB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 18:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbjCSWBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 18:01:07 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B031E9E5
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 15:00:50 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id eh3so39802539edb.11
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 15:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679263249;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NULSAvt2YzBh6lP0BNk8cY+8SBmxzmD4mCQqM4dUJg0=;
        b=H3YYF1rEuwy8WOMGKzr51JAF5yYy37eN8tSNMKueUYtXQZnKHLbveORxQVe4m4xJnH
         Yt+PVIKT6lDmAh2Hyh7zray9EHduqHqTGGW1NWWVAuYNiAza4CDeKH+CDhMZ0qYJG8ok
         wo6H7grLla8l/0L2FmvWR9Y9Lb8rUJRoSb3zG3o3VP5jiiadaRql8MisnUdYTNcOBgP8
         mjwMdCGkMZNtsMgbhsBadkb52+KOZEYQLP88N71HX+HSVGw1jvck1LMwBNwMzwCsm/yc
         pozbLONBFrg8YlSDazdakNEliRcmVlkkVn6vf4rAfoPMOTLlKowIxgcRH8BdfIxH9MY8
         jbNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679263249;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NULSAvt2YzBh6lP0BNk8cY+8SBmxzmD4mCQqM4dUJg0=;
        b=0sG6pXAov1+j0kQqz4Wpj6Pg/LBPbuun55CCt4/AenoG6K1nUtSqPpy58EJr1KlngB
         B/PyCeCQ6fDxYmkkBLVCK1zXSN1VMk90ofeIQcgZ2cXSlRctZ9HjuCtfMe/3/RzkJSNt
         Ph7mwXEPTb4uPBpj/N94IFnaveCUhLy7GMLkIgc8mt4ztR/v9uHEAsJYhD7qmJjjnbvH
         esw+BEZyQ2nelkNsqvTjv99zXu4kRfN3Kqg1+BnfTjpHtBsewWkkLtCfSD0+xZ2STMkf
         tKOGaUkhYUfe324UtsBoMMUUBVOpaVFh3fu6TgEpdSqFoKD1G/8vor22odQQ+zYcjkkR
         z8gQ==
X-Gm-Message-State: AO0yUKUJrlrESzFIMcnVKYT8Q3vj9lwEfEc8bw/cMaXSLqbRfLQZlrH8
        JhfsJD3PKOonh8fY/h72gzI=
X-Google-Smtp-Source: AK7set/+CoCykZ/G5h6xBt5rQd+nSOJZ65+nwHZCWk+pU/qnv2eboeiEpC65VBV4ATKcfviQbZ9aqA==
X-Received: by 2002:a17:907:b9d0:b0:878:955e:b4a4 with SMTP id xa16-20020a170907b9d000b00878955eb4a4mr8696293ejc.33.1679263248928;
        Sun, 19 Mar 2023 15:00:48 -0700 (PDT)
Received: from [192.168.1.16] ([41.42.177.251])
        by smtp.gmail.com with ESMTPSA id d19-20020a1709061f5300b0093198b00fd6sm3606550ejk.189.2023.03.19.15.00.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Mar 2023 15:00:48 -0700 (PDT)
Message-ID: <649afe06-e069-e046-21ec-0d86243a4bfa@gmail.com>
Date:   Mon, 20 Mar 2023 00:00:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] staging: greybus: use inline function for macros
Content-Language: en-US
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     gregkh@linuxfoundation.org, outreachy@lists.linux.dev,
        johan@kernel.org, elder@kernel.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
References: <20230319201324.253874-1-eng.mennamahmoud.mm@gmail.com>
 <alpine.DEB.2.22.394.2303192121170.2867@hadrien>
 <0f02a3ff-801b-1e1f-5c03-009a05708709@gmail.com>
 <alpine.DEB.2.22.394.2303192151330.2867@hadrien>
 <402ffcbe-bb29-7035-68f4-2741532a6d67@gmail.com>
 <alpine.DEB.2.22.394.2303192225590.2867@hadrien>
From:   Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
In-Reply-To: <alpine.DEB.2.22.394.2303192225590.2867@hadrien>
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


On ١٩‏/٣‏/٢٠٢٣ ٢٣:٢٦, Julia Lawall wrote:
>
> On Sun, 19 Mar 2023, Menna Mahmoud wrote:
>
>> On ١٩/٣/٢٠٢٣ ٢٢:٥٥, Julia Lawall wrote:
>>> On Sun, 19 Mar 2023, Menna Mahmoud wrote:
>>>
>>>> On ١٩/٣/٢٠٢٣ ٢٢:٢١, Julia Lawall wrote:
>>>>> On Sun, 19 Mar 2023, Menna Mahmoud wrote:
>>>>>
>>>>>> Convert `to_gbphy_dev` and `to_gbphy_driver` macros into a
>>>>>> static inline functions.
>>>>>>
>>>>>> it is not great to have macro that use `container_of` macro,
>>>>>> because from looking at the definition one cannot tell what type
>>>>>> it applies to.
>>>>>>
>>>>>> One can get the same benefit from an efficiency point of view
>>>>>> by making an inline function.
>>>>>>
>>>>>> Suggested-by: Julia Lawall <julia.lawall@inria.fr>
>>>>>> Signed-off-by: Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
>>>>>> ---
>>>>>>     drivers/staging/greybus/gbphy.h | 10 ++++++++--
>>>>>>     1 file changed, 8 insertions(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/staging/greybus/gbphy.h
>>>>>> b/drivers/staging/greybus/gbphy.h
>>>>>> index 1de510499480..42c4e3fe307c 100644
>>>>>> --- a/drivers/staging/greybus/gbphy.h
>>>>>> +++ b/drivers/staging/greybus/gbphy.h
>>>>>> @@ -16,7 +16,10 @@ struct gbphy_device {
>>>>>>     	struct device dev;
>>>>>>     };
>>>>>>
>>>>> You have made the patch against your previous patch that added a newline
>>>>> here.  It should be against Greg's tree.
>>>>>
>>>>> julia
>>>> you mean I should remove this newline, right?
>>> You should apply your change to the state of Greg's tree, not the state
>>> after your patch.
>>>
>>> Assuming that you have committed both the patch adding the new line and
>>> the patch changing the macro to a function, and have made no other
>>> changes, you can do git rebase -i HEAD~2 and the put a d at the beginning
>>> of the line related to the patch adding the newline.
>>
>> you mean drop this patch "staging: greybus: remove unnecessary blank line"?
> No, the one that removes the blank line looks fine.
>
> At some point, you added a blank line below the two structure definitions.
> That blank line is not in Greg's tree, so you shoulsn't send a patch that
> assumes that it is there.


I'm sorry I mean this patch "staging: greybus: add blank line after 
struct", Julia I understood the issue

but I am confused about how to fix it, should I drop the patch that 
added the newline? then what should I do?

and version that I have submitted, should I do anything about it as you 
said it is wrong solution?


Menna

> julia
>
>> Menna
>>
>>
>>> If you have made
>>> more changes, you can adapt the HEAD~ part accordingly.
>>>
>>> julia
>>>
>>>
>>>> Menna
>>>>
>>>>>> -#define to_gbphy_dev(d) container_of(d, struct gbphy_device, dev)
>>>>>> +static inline struct gbphy_device *to_gbphy_dev(const struct device
>>>>>> *d)
>>>>>> +{
>>>>>> +	return container_of(d, struct gbphy_device, dev);
>>>>>> +}
>>>>>>
>>>>>>     static inline void *gb_gbphy_get_data(struct gbphy_device *gdev)
>>>>>>     {
>>>>>> @@ -45,7 +48,10 @@ struct gbphy_driver {
>>>>>>     	struct device_driver driver;
>>>>>>     };
>>>>>>
>>>>>> -#define to_gbphy_driver(d) container_of(d, struct gbphy_driver,
>>>>>> driver)
>>>>>> +static inline struct gbphy_driver *to_gbphy_driver(struct
>>>>>> device_driver
>>>>>> *d)
>>>>>> +{
>>>>>> +	return container_of(d, struct gbphy_driver, driver);
>>>>>> +}
>>>>>>
>>>>>>     int gb_gbphy_register_driver(struct gbphy_driver *driver,
>>>>>>     			     struct module *owner, const char
>>>>>> *mod_name);
>>>>>> --
>>>>>> 2.34.1
>>>>>>
>>>>>>
> >
