Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2964A6F8A29
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 22:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232946AbjEEU2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 16:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbjEEU2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 16:28:44 -0400
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 011D040FB;
        Fri,  5 May 2023 13:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1683318523;
        bh=lOJceDItkMuBUJjwo0/e9SQZdXHqosSpw9xAH6N0hSM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=IIcIIZrYQo99YktN7rvaAwW/GoJRUepRYirU5YqtkVo6qWs3SMFtZtUxh7Eq6E6dm
         r+kzwA8jLWUce/l5P6XRVYkTMPGShiuwgRTIfEjcyOc1o6nur/dnB6g3kitT0PtSts
         dnoBFz3lXu8THYVBa1DaOT7fw9ts3f7cppPd3BYiOPVpkQmxiGZcNYtKPxvIB0ymDX
         KtycY6HDS14VG7/nw4MeIkwqDwL2kRt6SniOB9bsKKooiS+vl30WuLc+AVA2HpxTh7
         CzL+Zi0yff5UwKXR1LjYjfZOlx8lbcUtFWfrWCCXeCPK34xSVw+IJKpHrd+qRZHpgU
         b+TdzSqZzqTgQ==
Received: from [172.16.0.99] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4QCj231CCcz125Q;
        Fri,  5 May 2023 16:28:43 -0400 (EDT)
Message-ID: <322d22f5-7ab0-adbd-45a0-879364d79ce8@efficios.com>
Date:   Fri, 5 May 2023 16:28:47 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC PATCH 12/13] blk-mq.h: Fix parentheses around macro
 parameter use
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
References: <20230504200527.1935944-1-mathieu.desnoyers@efficios.com>
 <20230504200527.1935944-13-mathieu.desnoyers@efficios.com>
 <3b017a9f-220d-4da8-2cf6-7f0d6175b30c@efficios.com>
 <CAHk-=wjzpHjqhybyEhkTzGgTdBP3LZ1FmOw8=1MMXr=-j5OPxQ@mail.gmail.com>
 <3cc72a67-d648-0040-6f60-37663797e360@efficios.com>
 <CAHk-=wh-x1PL=UUGD__Dv6kd+kyCHjNF-TCHGG9ayLnysf-PdQ@mail.gmail.com>
 <d8dfd1af-5b82-ddd8-24f5-fa9dfbb4b1fb@efficios.com>
 <CAHk-=wg27iiFZWYmjKmULxwkXisOHuAXq=vbiazBabgh9M1rqg@mail.gmail.com>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <CAHk-=wg27iiFZWYmjKmULxwkXisOHuAXq=vbiazBabgh9M1rqg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-05-05 16:22, Linus Torvalds wrote:
> On Fri, May 5, 2023 at 1:08 PM Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
>>
>> The reason why I think the lvalue of a "=" operator can be argued to be
>> "special" is because it is simply invalid to apply many of the C
>> operators to an lvalue (e.g. +, -, /, ...),
> 
> Mathieu, you are simply objectively wrong.
> 
> See here:
> 
>    #define m1(x) (x = 2)
>    #define m2(x) ((x) = 2)
> 
> and then try using the argument "a = b" to those macros.
> 
> Guess which one flags it as an error ("lvalue required") and which one does not?

I'm glad you are proving me wrong. So it was just a lack of imagination 
on my end.

> 
> m2 is the only "good" one. Yes, m1 works in 99% of all cases in
> practice, but if you want a safer macro, you *will* add the
> parentheses.
> 
> So *STOP*ARGUING* based on an incorrect "lowest precedence" basis.
> Even for the "lowest precedence" case, you have the *same* precedence.

Yes, your example clearly shows it.

> The fact is, assignment is not in any way special operation in macros,
> and does not deserve - and should absolutely not have - any special
> "doesn't need parentheses around argument" rules.

Good point. You are right. So that strongly supports the parentheses 
around use of parameters as lvalues. One less special-case to care 
about, which is great.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

