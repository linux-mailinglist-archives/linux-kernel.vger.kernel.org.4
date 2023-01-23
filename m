Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F6716780AB
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 16:59:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232987AbjAWP7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 10:59:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232173AbjAWP7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 10:59:14 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1773CDEB
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 07:59:10 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id s124so10763591oif.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 07:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aUZYmJYPBDT8Wyv5UcJ1yX5++DEGFOoqfzxsdG0LmBA=;
        b=pAOdauD9WVpAWwXOtO8bIKRDuOqOVCm184VA/V5T0V3EMBq4A+31sfFrrEl5A5Sm4Z
         j3XlNgZT6Skx/RXQI9ZrUGWYWw612JCfhfGYVCi5rz5bx5seG45Anxc1lxA5ak12hEL4
         9+wt2ldcDFQ41ifbhDOxIgAOr3GYYtbEBg0HqM4qeJQsjORgkrtsdkdfz1bnfF8WXE8D
         VYmCq52qV7nMhZJQiDuT2wykRAMT+Cjmp1jVo98HyGP5ub1EsZ33Zy5d6DAxxjQ++oRW
         wJ9r2lPWbNPJRS8tUBIE0yjZN/i+xfqSoM88xVZ7aCToxWEcjrFNrbI5nWuQWNNyc86d
         P/Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aUZYmJYPBDT8Wyv5UcJ1yX5++DEGFOoqfzxsdG0LmBA=;
        b=XAUfe9OUJD7YAjLzSPHrf7Jsihq+9HaQ6g5YbIUxJaFbDCaOhm3YPA+d1fXdZDvQIT
         OZd1mKycl1nGU4kTVNVAIV+PQRfW2Ce20WMdGrpll0CH3FNcZ304NymwlibGwaN9EFnp
         c9acWLeGwlU12xFMdkFoYFvJPcBIEZqQPfvi57rDw79NbzfI/4iA0ThhAJ4DgCtxni35
         WvEo1apvViSrAT7yAKblZqf3BQxIs64ELxkvoMpsborCZbR+Y2M98AoZLFNXcMDPWNjD
         YAHJYOhEy0pfAX4tk5ycN+znO9efQLEK9CpRYvYEvzEbgydsDuEVLtdKA45T3GiuxoXD
         UZfQ==
X-Gm-Message-State: AFqh2krAz+MM7fLxlmnGhLV9MX8V1zVCirYqY91f13NFlh0B3OkDXXw4
        S/MnIOSkHiOu7AzQjtjU8hx/XDcdnkrKb2ZoQYIfYHYl
X-Google-Smtp-Source: AMrXdXvFVOJNlaw396koDq5Av/FmR+dukkKi9ZMuCa7/PvdTHwp69COm9xEx+k/SRM9W41mNj+gjvGluheOkPcADVt8=
X-Received: by 2002:aca:2107:0:b0:365:64a:b3a1 with SMTP id
 7-20020aca2107000000b00365064ab3a1mr952659oiz.81.1674489549995; Mon, 23 Jan
 2023 07:59:09 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a8a:ad6:0:b0:49c:e11d:f815 with HTTP; Mon, 23 Jan 2023
 07:59:09 -0800 (PST)
In-Reply-To: <CAFULd4aDORSrq7zf_LcAZRP8HOHcrq2-rGMaroKyG2zQDHNpOA@mail.gmail.com>
References: <20230118150703.4024-1-ubizjak@gmail.com> <20230118131825.c6daea81ea1e2dc6aa014f38@linux-foundation.org>
 <CAFULd4ZQGG+N3f7xDuoiNG1jY128pqaH0F4eLKO+fhvSNAbKfA@mail.gmail.com>
 <CAFULd4b5szcTHTVbGJ9WiciG_+8kANiPZYP_pkEZUhnz_HHy-g@mail.gmail.com>
 <913c01d41f824fa8b3400384437fa0d8@AcuMS.aculab.com> <CAFULd4aDORSrq7zf_LcAZRP8HOHcrq2-rGMaroKyG2zQDHNpOA@mail.gmail.com>
From:   Mateusz Guzik <mjguzik@gmail.com>
Date:   Mon, 23 Jan 2023 16:59:09 +0100
Message-ID: <CAGudoHF6zbyzza6xysuCjcxjHAUgeAVvgW0sqxDAFQNwz9u7wg@mail.gmail.com>
Subject: Re: [PATCH] lib/genalloc: use try_cmpxchg in {set,clear}_bits_ll
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     David Laight <David.Laight@aculab.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/23/23, Uros Bizjak <ubizjak@gmail.com> wrote:
> On Thu, Jan 19, 2023 at 1:47 PM David Laight <David.Laight@aculab.com>
> wrote:
>>
>> > BTW: Recently, it was determined [1] that the usage of cpu_relax()
>> > inside the cmpxchg loop can be harmful for performance. We actually
>> > have the same situation here, so perhaps cpu_relax() should be removed
>> > in the same way it was removed from the lockref.
>>
>> I'm not sure you can ever want a cpu_relax() in a loop that
>> is implementing an atomic operation.
>> Even the ia64 (die...) issue was with a loop that was waiting
>> for another cpu to change the location (eg a spinlock).
>>
>> For an atomic operation an immediate retry is likely to succeed.
>> Any kind of deferral to an another cpu can only make it worse.
>>
>> Clearly if you have 100s of cpu looping doing atomic operation
>> on the same cache line it is likely that some get starved.
>> But to fix that you need to increase the time between successful
>> operations, not delay on failure.
>
> I would like to point out that the wikipedia article on
> compare-and-swap claims [1] that:
>
> Instead of immediately retrying after a CAS operation fails,
> researchers have found that total system performance can be improved
> in multiprocessor systems=E2=80=94where many threads constantly update so=
me
> particular shared variable=E2=80=94if threads that see their CAS fail use
> exponential backoff=E2=80=94in other words, wait a little before retrying=
 the
> CAS [2].
>
> [1] https://en.wikipedia.org/wiki/Compare-and-swap#Overview
> [2] https://arxiv.org/pdf/1305.5800.pdf
>

I skimmed the paper and I think I got the gist of it, which boils down
to a very common idea concerning damage control of multiple CPUs
modifying the same thing.

The idea boils down to making some of the contending CPUs bugger off
for a time. How to specifically do it is another matter. Key problem
with it is that CPUs which already failed to make any progress now
artificially delay the entire thing even more.

Fundamental observation is that 2 or more CPUs rolling with an atomic
op on the same cacheline are going to interfere with each other and
that effect is only going to get worse as you keep adding more of them.
If you can make some of them temporarily bugger off, that is a win in
the sense that the ping-pong is reduced. If this is finely tuned, you
may get an overall win with by achieving better throughput while
maintaining acceptable worst case latency. Otherwise you are starving
other participants which is not acceptable. tl;dr you are walking a very
right rope here and I'm not sure it is worth it.

For a toy example one can imagine 2 CPUs running code to do an op n
times. If they both do it in a tight loop there is plenty of ping-pong,
but if one is simply made to wait until the other one is finished with
all the iterations, you register much shorter total real time. But then
again everything happening on the other CPU had to wait so much longer.

I don't know why but many people love to throw away the value returned
by CAS and instead do another plain access. While I don't see actual
code used, the description in the paper matches this problematic
behavior and I guarantee it artificially makes a tight CAS loop appear
worse than it is.

My own numbers from the cpu_relax removal commit show that throughput
flattens very early, and all the extra computing power thrown at it
simply goes to waste.

All that said. Is a plain cpu_relax in the loop good? Definitely not on
x86-64. Is something more elaborate going to be good? Maybe, highly
depends on CPUs at hand and the workload, and if you mess it up some of
them get starved. This in turn can degrade performance elsewhere if the
starved thread is holding a lock waited on by someone else, and so on.
I would definitely not play any games of the sort in the code at hand.

In that case what about lockref? It definitely is not the fastest it
can be, for one some provisions could be made for NUMA-aware handling.
Basic idea would be to have competing CPUs aggregate the total change
on the lock and then have one of them make it happen across the
interconnect -- so instead of add/sub 1 you would add/sub n, where n
can very well be quite big.

Personally, for lockref, I think the way to go forward is to use it less
to begin with and to look for ways to convert it into a lock xadd-able
primitive instead. The "doing it less thing" could be done by
implementing a RCU-only mode for select syscalls, which defaults to
opportunistically avoid refing squat. If the caller manages to do what
it needed to do, that is a massive win; otherwise refs get taken. This
could work well in the common case for syscalls like statx and access,
but would not for open. Frankly I'm surprised something like this is
not already implemented (maybe I missed a major showstopper?).

--=20
Mateusz Guzik <mjguzik gmail.com>
