Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63E9464A846
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 20:48:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233382AbiLLTsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 14:48:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233372AbiLLTsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 14:48:11 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18B0A165A4
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 11:48:10 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id y3so2350934ilq.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 11:48:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XGkt3MqMLMCVIAcGCL47Wsoi0oRBxQskoWJ63t7sQ14=;
        b=XBTla/mqsuo2JcTsPvok7E6MxNomtTAINwN9q8RUyelgKY50HwRq+dPyQ/27kWnQev
         W9komVUTNRFZWR+hgiPXBaNTZmm7ckbe5eravJNJGV0YJ87NjRH0yOcUJN0NhgvSd5SL
         fa3j2iisLnq2VFU3nR9toL5Ny+uSiCi29+sb8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XGkt3MqMLMCVIAcGCL47Wsoi0oRBxQskoWJ63t7sQ14=;
        b=d/IcNPGi8tjwfF6mPgMU1RGo0D9pIgnq5rDRmQZE3oH4Fh8kRtD57tl5TIzj03qKHi
         WVPIWBp9N2vacamIENsYghRYqQwca4izl7T9V8zZytLtmnJYM9ws+d77t+/psQnvjvK9
         daeQ/kVVPl2y6bT+uHvyk6qs4apAjncnDfShGPwZMtQeQy/I34RbWzCTtnfoyy6cRq+u
         3FEDhUrbbDK9VGvUq23/tIvlcyr2NA2pwFjLcViiN1cXf39nz8Xp0jAheDwJQelfnUSK
         Q+3nZOZfJkpT5oGxgq1FhLSC8JP6W84zyRIy8JmwGbifiqoNNiFhTrP/+0226Aj+HL7O
         ABjQ==
X-Gm-Message-State: ANoB5plyF9Qf1aK48uZB69AsYD0k6RESMs7/8K31/dNqbAGiUPG+cF/L
        inXBdDaRb1+kXhjkXizR8zgRIw==
X-Google-Smtp-Source: AA0mqf6Nk84wi59ext7mxtR5c4Dh2bH1HAVzZBUxXR2qUg87ATjihN6MM6jnTJ17XlY+qTbttAMlsQ==
X-Received: by 2002:a92:cd4e:0:b0:303:1141:1044 with SMTP id v14-20020a92cd4e000000b0030311411044mr1927562ilq.1.1670874489365;
        Mon, 12 Dec 2022 11:48:09 -0800 (PST)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id v13-20020a02b08d000000b0038a3cc44e36sm210240jah.14.2022.12.12.11.48.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Dec 2022 11:48:08 -0800 (PST)
Message-ID: <fa9145fe-9815-900f-6dd0-bf80019a319e@linuxfoundation.org>
Date:   Mon, 12 Dec 2022 12:48:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: linux-next: manual merge of the kunit-next tree with the apparmor
 tree
Content-Language: en-US
To:     John Johansen <john.johansen@canonical.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Rae Moar <rmoar@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20221208135327.01364529@canb.auug.org.au>
 <bff89220-df3a-a148-2ba4-6aad3874f322@canonical.com>
 <8e82905f-8bdf-05de-2e6a-d8b896d75910@linuxfoundation.org>
 <0e678eb2-455c-88f5-6732-2e8701ebb6e6@linuxfoundation.org>
 <9b21c055-4e1a-2c34-281c-39af7d73fe80@canonical.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <9b21c055-4e1a-2c34-281c-39af7d73fe80@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12/22 12:20, John Johansen wrote:
> On 12/12/22 10:03, Shuah Khan wrote:
>> On 12/12/22 10:52, Shuah Khan wrote:
>>> Hi David,
>>>
>>> On 12/8/22 13:10, John Johansen wrote:
>>>> On 12/7/22 18:53, Stephen Rothwell wrote:
>>>>> Hi all,
>>>>>
>>>>> Today's linux-next merge of the kunit-next tree got a conflict in:
>>>>>
>>>>>    security/apparmor/policy_unpack.c
>>>>>
>>>>> between commits:
>>>>>
>>>>>    371e50a0b19f ("apparmor: make unpack_array return a trianary value")
>>>>>    73c7e91c8bc9 ("apparmor: Remove unnecessary size check when unpacking trans_table")
>>>>>    217af7e2f4de ("apparmor: refactor profile rules and attachments")
>>>>> (and probably others)
>>>>>
>>>>> from the apparmor tree and commit:
>>>>>
>>>>>    2c92044683f5 ("apparmor: test: make static symbols visible during kunit testing")
>>>>>
>>>>> from the kunit-next tree.
>>>>>
>>>>> This is somewhat of a mess ... pity there is not a shared branch (or
>>>>> better routing if the patches).
>>>>>
>>>> sorry, there was a miscommunication/misunderstanding, probably all on me, I
>>>> thought the kunit stuff that is conflicting here was going to merge next
>>>> cycle.
>>>>
>>>
>>
>> How about I just drop the following for now and handle this in the next cycle?
> 
> if you want, the other way to handle it is we coordinate our pull requests.
> You go first. And then I will submit a little later in the week, with the
> references to the merge conflict and a pointer to a branch with it resolved.
> This isn't even a particularly tricky merge conflict, it just has the little
> subtly around making sure the include symbols are conditional.
> 

I assume Linus will not see any problems without your pull requests. In which
case we can do this:

- I send my pull request today
- You can follow with yours with the fixes later on this week

> This doesn't affect me much as there is already another merge conflict with
> the security tree that I need to deal with.
> 


>> I think it might be least confusing option. Let me know. I can just do that
>> and then send pull request in a day or tow once things settle down in next.
>>
>> 2c92044683f5 ("apparmor: test: make static symbols visible during kunit testing")
>>
> 
> that is the other option. If you go that route I can help you do the rebase/merge
> fix.
> 

Let's go with your earlier suggestion.

> looking back at this, there wasn't anything explicit about this not going upstream
> this cycle, I must have just assumed as the final version came about after rc7. So
> my bad.
> 

Right - I ended up taking this as it looked like a patch if included could
enable other changes to follow without being blocked. Also rc8 was in plan.

thanks,
-- Shuah
