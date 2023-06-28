Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54A90741C42
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 01:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231494AbjF1XOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 19:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbjF1XON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 19:14:13 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AA98199B
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 16:14:12 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-66872dbc2efso23987b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 16:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1687994052; x=1690586052;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FRp/oTwvO4xx7VyDnhljSxsWgPI0D07uffAn8Q/zad4=;
        b=QUqbR8S/puhSxXQLyEOg/bBvp2fKCUSvNzpBRSfT9sB8hoah/LkVwiK8ojyYyoxmgR
         eZXcyL+9R0an4ndA8rIwGRT7r6pyL5WGvgXg9BP4vlzhVndGbowT17T+wBVVd45rpr/K
         i0JJoo0MDTVNCI0uwxeV3c4whA1SBpXNKrQKjyZrpcvarUZnX/h6SkPMI9vT7qk7BjOf
         fUCksez0P8F9qdT9bPG6q918t/NiutN1e5aqiCFXEsH6Y5cDzcZnWmm85iAYKsVTpm7T
         MtGr4+QH0lCnh4WA4sNr4oFGBp5JUkdn72PJX4g8FDY7rxGhMTu+NLS7Wb3Km6+i6ZN9
         rMsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687994052; x=1690586052;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FRp/oTwvO4xx7VyDnhljSxsWgPI0D07uffAn8Q/zad4=;
        b=c6QAu1Sry5vVkhVYfJ11q5wvqNOmYB/VRftiPcZkQRAvxLuWhgwlYL1SMOqanUr99U
         GhqMla94h2e+KnJSMZfZpWlwCt6o9AtJiSyuvATfHNnQJXbDzQH7j8bbtPIQxJtABIOq
         J0YPsCC/T9wpKSDBTzbKSPLug36eZo7wY70MsgBKJSkaY8SUKG9qvEDe9ibWk7MKr3rM
         cXt06nKaMjiJtovFJT9purPfUso8jKqh+2ILR8i6+Q6jqrrPjko1H6rA7jPIeDMqqC9I
         oN9BmVtG5e6Gd6mjaghfQcSc+T5emYte4vu3P7Hbl0uFkR1NyC7IFl9Tte3rXldUJvta
         5UDA==
X-Gm-Message-State: AC+VfDx87cdQcFPZkwIT5TeC0Lq6vH835XGi3Khj+FgpqD+VE1bcHlDl
        ZvlBWhywENecG0EO+TmvMlmHhA==
X-Google-Smtp-Source: ACHHUZ7V1wAALvw6LqsIJ3FHJRlGSW0WNvgM8BceTeHl0jhJcJjcA5TiU64W85zUYMTaZzCsn0IAcw==
X-Received: by 2002:a05:6a20:6a27:b0:11a:dbb3:703b with SMTP id p39-20020a056a206a2700b0011adbb3703bmr1220409pzk.6.1687994051858;
        Wed, 28 Jun 2023 16:14:11 -0700 (PDT)
Received: from ?IPV6:2620:10d:c085:21e8::106b? ([2620:10d:c090:400::5:e20])
        by smtp.gmail.com with ESMTPSA id b5-20020aa78705000000b0064f7c56d8b7sm5880131pfo.219.2023.06.28.16.14.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jun 2023 16:14:11 -0700 (PDT)
Message-ID: <1e2134f1-f48b-1459-a38e-eac9597cd64a@kernel.dk>
Date:   Wed, 28 Jun 2023 17:14:09 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [GIT PULL] bcachefs
Content-Language: en-US
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-bcachefs@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
References: <20230627201524.ool73bps2lre2tsz@moria.home.lan>
 <c06a9e0b-8f3e-4e47-53d0-b4854a98cc44@kernel.dk>
 <20230628040114.oz46icbsjpa4egpp@moria.home.lan>
 <b02657af-5bbb-b46b-cea0-ee89f385f3c1@kernel.dk>
 <4b863e62-4406-53e4-f96a-f4d1daf098ab@kernel.dk>
 <20230628175204.oeek4nnqx7ltlqmg@moria.home.lan>
 <e1570c46-68da-22b7-5322-f34f3c2958d9@kernel.dk>
 <2e635579-37ba-ddfc-a2ab-e6c080ab4971@kernel.dk>
 <20230628221342.4j3gr3zscnsu366p@moria.home.lan>
 <d697ec27-8008-2eb6-0950-f612a602dcf5@kernel.dk>
 <20230628225514.n3xtlgmjkgapgnrd@moria.home.lan>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230628225514.n3xtlgmjkgapgnrd@moria.home.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/28/23 4:55?PM, Kent Overstreet wrote:
>> But it's not aio (or io_uring or whatever), it's simply the fact that
>> doing an fput() from an exiting task (for example) will end up being
>> done async. And hence waiting for task exits is NOT enough to ensure
>> that all file references have been released.
>>
>> Since there are a variety of other reasons why a mount may be pinned and
>> fail to umount, perhaps it's worth considering that changing this
>> behavior won't buy us that much. Especially since it's been around for
>> more than 10 years:
> 
> Because it seems that before io_uring the race was quite a bit harder to
> hit - I only started seeing it when things started switching over to
> io_uring. generic/388 used to pass reliably for me (pre backpointers),
> now it doesn't.

I literally just pasted a script that hits it in one second with aio. So
maybe generic/388 doesn't hit it as easily, but it's surely TRIVIAL to
hit with aio. As demonstrated. The io_uring is not hard to bring into
parity on that front, here's one I posted earlier today for 6.5:

https://lore.kernel.org/io-uring/20230628170953.952923-4-axboe@kernel.dk/

Doesn't change the fact that you can easily hit this with io_uring or
aio, and probably more things too (didn't look any further). Is it a
realistic thing outside of funky tests? Probably not really, or at least
if those guys hit it they'd probably have the work-around hack in place
in their script already.

But the fact is that it's been around for a decade. It's somehow a lot
easier to hit with bcachefs than XFS, which may just be because the
former has a bunch of workers and this may be deferring the delayed fput
work more. Just hand waving.

>> then we'd probably want to move that deferred fput list to the
>> task_struct and ensure that it gets run if the task exits rather than
>> have a global deferred list. Currently we have:
>>
>>
>> 1) If kthread or in interrupt
>> 	1a) add to global fput list
>> 2) task_work_add if not. If that fails, goto 1a.
>>
>> which would then become:
>>
>> 1) If kthread or in interrupt
>> 	1a) add to global fput list
>> 2) task_work_add if not. If that fails, we know task is existing. add to
>>    per-task defer list to be run at a convenient time before task has
>>    exited.
> 
> no, it becomes:
>  if we're running in a user task, or if we're doing an operation on
>  behalf of a user task, add to the user task's deferred list: otherwise
>  add to global deferred list.

And how would the "on behalf of a user task" work in terms of being
in_interrupt()?

-- 
Jens Axboe

