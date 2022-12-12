Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C650A64AB7B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 00:19:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233693AbiLLXTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 18:19:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbiLLXTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 18:19:04 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A51B1C109
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 15:19:03 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id i83so847600ioa.11
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 15:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WkpQCN5mKfNvNkgy40wCy1sH1Bpo4in6NPsoEBjZknc=;
        b=MtQwofhI4jKH8Ram4EX0F52D5bPmzKC4aoYpXmHoc5HFc3ZZkDITGfBo1fBRN6rEWz
         8l92iMnWF7CpIUhgQGFvCOVKTa+6DXFVaNGROEtZ9mQtF6FFzy4pHhV+x6UXuOPdn3Mi
         hAOxofQqoCKZD3o4bAJnLx68qb8sc08xdxzi8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WkpQCN5mKfNvNkgy40wCy1sH1Bpo4in6NPsoEBjZknc=;
        b=iq/qD7I9xc1WGx2L0PSuEUn+CZXsA6q7yDRusZx2zNakIvqFLfS+LcZkBsb/KC6XxB
         wOmmEC7Hk5l9zBS02RCjW7s91enGUmTKs42jcRI3F/mKGcvFmLjcfEiQysDB8trEaMFi
         GbnRvlPRdSZYop/JKZnp47pvPjlWbVc2pU4ukpkjp8xR1Wn9KHTy9F2AOxwdUKctt2sC
         4GEsyAPdWvE9HSlY8UDtPGd/2EM5UKstbl+vuRYdU6qLx1srZEL3TjbiVu9xbjOB2Fhp
         uuuecUdwA5yltwTwDk7NxyntrR4K8XWVT/y+fxrjh9wopbvdZ7GiwbcLG6Yvjf3EBXrn
         P/NQ==
X-Gm-Message-State: ANoB5plcTgyeNsxpTPCDbaXIuz47zFMtM3bNWDQQw8KqoacIwYz2rkbn
        QFaqaLM05yZaCvJKuKJRiphm+A==
X-Google-Smtp-Source: AA0mqf4Ppkd+xCnV95v8ipzZ4L9ywn/vFPptElVZl80pZntWElatvsr9RMj/4Dx+zjpqDTi1o3WWuw==
X-Received: by 2002:a6b:4916:0:b0:6dd:7096:d9bc with SMTP id u22-20020a6b4916000000b006dd7096d9bcmr1898863iob.2.1670887142377;
        Mon, 12 Dec 2022 15:19:02 -0800 (PST)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id m19-20020a026a53000000b0038a5b8d79basm336764jaf.106.2022.12.12.15.19.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Dec 2022 15:19:01 -0800 (PST)
Message-ID: <a116990c-f544-9dce-0ee5-ab7fbe2601ca@linuxfoundation.org>
Date:   Mon, 12 Dec 2022 16:19:00 -0700
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
 <fa9145fe-9815-900f-6dd0-bf80019a319e@linuxfoundation.org>
 <c4560ccd-fad4-ecb9-4d57-64d94b5ebf30@canonical.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <c4560ccd-fad4-ecb9-4d57-64d94b5ebf30@canonical.com>
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

On 12/12/22 12:53, John Johansen wrote:
> On 12/12/22 11:48, Shuah Khan wrote:
>> On 12/12/22 12:20, John Johansen wrote:
>>> On 12/12/22 10:03, Shuah Khan wrote:
>>>> On 12/12/22 10:52, Shuah Khan wrote:
>>>>> Hi David,
>>>>>
>>>>> On 12/8/22 13:10, John Johansen wrote:
>>>>>> On 12/7/22 18:53, Stephen Rothwell wrote:
>>>>>>> Hi all,
>>>>>>>
>>>>>>> Today's linux-next merge of the kunit-next tree got a conflict in:
>>>>>>>
>>>>>>>    security/apparmor/policy_unpack.c
>>>>>>>
>>>>>>> between commits:
>>>>>>>
>>>>>>>    371e50a0b19f ("apparmor: make unpack_array return a trianary value")
>>>>>>>    73c7e91c8bc9 ("apparmor: Remove unnecessary size check when unpacking trans_table")
>>>>>>>    217af7e2f4de ("apparmor: refactor profile rules and attachments")
>>>>>>> (and probably others)
>>>>>>>
>>>>>>> from the apparmor tree and commit:
>>>>>>>
>>>>>>>    2c92044683f5 ("apparmor: test: make static symbols visible during kunit testing")
>>>>>>>
>>>>>>> from the kunit-next tree.
>>>>>>>
>>>>>>> This is somewhat of a mess ... pity there is not a shared branch (or
>>>>>>> better routing if the patches).
>>>>>>>
>>>>>> sorry, there was a miscommunication/misunderstanding, probably all on me, I
>>>>>> thought the kunit stuff that is conflicting here was going to merge next
>>>>>> cycle.
>>>>>>
>>>>>
>>>>
>>>> How about I just drop the following for now and handle this in the next cycle?
>>>
>>> if you want, the other way to handle it is we coordinate our pull requests.
>>> You go first. And then I will submit a little later in the week, with the
>>> references to the merge conflict and a pointer to a branch with it resolved.
>>> This isn't even a particularly tricky merge conflict, it just has the little
>>> subtly around making sure the include symbols are conditional.
>>>
>>
>> I assume Linus will not see any problems without your pull requests. In which
>> case we can do this:
>>
>> - I send my pull request today
>> - You can follow with yours with the fixes later on this week
>>
> 
> okay
> 
>>> This doesn't affect me much as there is already another merge conflict with
>>> the security tree that I need to deal with.
>>>
>>
>>
>>>> I think it might be least confusing option. Let me know. I can just do that
>>>> and then send pull request in a day or tow once things settle down in next.
>>>>
>>>> 2c92044683f5 ("apparmor: test: make static symbols visible during kunit testing")
>>>>
>>>
>>> that is the other option. If you go that route I can help you do the rebase/merge
>>> fix.
>>>
>>
>> Let's go with your earlier suggestion.
>>
> 
> ack
> 
>>> looking back at this, there wasn't anything explicit about this not going upstream
>>> this cycle, I must have just assumed as the final version came about after rc7. So
>>> my bad.
>>>
>>
>> Right - I ended up taking this as it looked like a patch if included could
>> enable other changes to follow without being blocked. Also rc8 was in plan.
>>
> 
> yeah, my bad
> 

No worries. Sent pull request with a note about apparmor and our
coordinated pull requests with you on the cc.

thanks,
-- Shuah

