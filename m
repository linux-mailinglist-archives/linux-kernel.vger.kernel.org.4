Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E068E67DE10
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 07:59:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231972AbjA0G7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 01:59:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231767AbjA0G7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 01:59:06 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEDA029177
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 22:58:53 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id f34so6688512lfv.10
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 22:58:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8WCgizZfT3yoGO+GYCgj+PgReZhP+Yfp87mpDwfRLzU=;
        b=kFeTVN5wS6wRKITnxJnZGjfSRmIkkSHlKETp2oVwFVmyIUgbeqmf7NiMIl+w4U5tqw
         xo0T172KRnJN1jFWZenIFTQhbtKB6KDUP85P7DqFZKE3f2Nr1LKAuU8gBX5fVbzDqea3
         2sfCqsY51z4RLNLheVTCC2jm9a1zz2Dp8hV0A55SQvFEa/QvneCSsh0ExkwTcCr5ApXb
         H2IYhqlmJdEZ8F/TmBetzxmK/UjdTeVHI6/DoCaVOdyuPnh5kT9oJDjrvbCV/+w0+7Rq
         A6p8YQOcVHQJt58Mf4sNdnv9ETszlw43Z1X8oY1wPCBoxqzJUOLBzkAEjEGosDSdCAhw
         Y8sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8WCgizZfT3yoGO+GYCgj+PgReZhP+Yfp87mpDwfRLzU=;
        b=M49huxV1bi9alR744uiITcdqRDYUHbaSviQzGzABVWg5vwfdSuNZQw0l3JzyDtyYKi
         /0pBoyotdVoavNJIdpxZwV/s/zU35f2Hltz+EDCp8nOesESzobqVXy7r5utKcKfYlSiH
         wlT+vW8CjtzTf37otqTeEyW01hPJntDSUh6DmhBsWWrpEmpecr6xmu6NCqJAioYS1zjA
         hUI8DrTRAUMKJdeoFyjy3Lg9TmkdWzJWVntuZnzI0xWZVjMNDAMnZo3LBmuqSAUvjnOW
         I4MJLckNvk2w/bfZ8lBjnq+6HT9rvGpNfd6phGF11OcTVeiKS6qW96WRMuv9qjvXNzqC
         k0rQ==
X-Gm-Message-State: AFqh2kpn9mYcx/wCIFkpTEFd/heKYeVLH589YXW5Dvqi3YMlePp1JH87
        kJmW4dElfbKLfioAdOaJxU2sN7M43UmwYio7MuTFSfncVKLvu1eMK6w=
X-Google-Smtp-Source: AMrXdXuDqJhLflIXt8tmkzM/wowN80kk9vheLxAF/PK+ri7IEWG5zqq8M1NihxnpVDQnoFnxJgulmoWXrCjmfejm7sI=
X-Received: by 2002:a05:6512:401b:b0:4cc:7222:74f5 with SMTP id
 br27-20020a056512401b00b004cc722274f5mr4523511lfb.371.1674802731723; Thu, 26
 Jan 2023 22:58:51 -0800 (PST)
MIME-Version: 1.0
References: <20230126105128.2249938-1-dvyukov@google.com> <20230126154118.2393850-1-dvyukov@google.com>
 <CANpmjNM=PVigDZKu-H_-cLECUJKSx7TH+kxSjfF=4UHdrGBj+g@mail.gmail.com> <87o7qlgjce.ffs@tglx>
In-Reply-To: <87o7qlgjce.ffs@tglx>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 27 Jan 2023 07:58:39 +0100
Message-ID: <CACT4Y+aMLeCo9+nwXrFWo8FLG8rKHDe8v2ppkZ+mOaKAF6qtgw@mail.gmail.com>
Subject: Re: [PATCH v4] posix-timers: Prefer delivery of signals to the
 current thread
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Marco Elver <elver@google.com>, oleg@redhat.com,
        linux-kernel@vger.kernel.org,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Frederic Weisbecker <frederic@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Jan 2023 at 20:57, Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Thu, Jan 26 2023 at 18:51, Marco Elver wrote:
> > On Thu, 26 Jan 2023 at 16:41, Dmitry Vyukov <dvyukov@google.com> wrote:
> >>
> >> Prefer to deliver signals to the current thread if SIGEV_THREAD_ID
> >> is not set. We used to prefer the main thread, but delivering
> >> to the current thread is both faster, and allows to sample actual thread
> >> activity for CLOCK_PROCESS_CPUTIME_ID timers, and does not change
> >> the semantics (since we queue into shared_pending, all thread may
> >> receive the signal in both cases).
> >
> > Reviewed-by: Marco Elver <elver@google.com>
> >
> > Nice - and and given the test, hopefully this behaviour won't regress in future.
>
> The test does not tell much. It just waits until each thread got a
> signal once, which can take quite a while. It does not tell about the
> distribution of the signals, which can be completely randomly skewed
> towards a few threads.
>
> Also for real world use cases where you have multiple threads with
> different periods and runtime per period I have a hard time to
> understand how that signal measures anything useful.
>
> The most time consuming thread might actually trigger rarely while other
> short threads end up being the ones which cause the timer to fire.
>
> What's the usefulness of this information?
>
> Thanks,
>
>         tglx

Hi Thomas,

Our goal is to sample what threads are doing in production with low
frequency and low overhead. We did not find any reasonable existing
way of doing it on Linux today, as outlined in the RFC version of the
patch (other solutions are either much more complex and/or incur
higher memory and/or CPU overheads):
https://lore.kernel.org/all/20221216171807.760147-1-dvyukov@google.com/

This sampling does not need to be 100% precise as CPU profilers would
require, getting high precision generally requires more complexity and
overheads. The accent is on use in production and low overhead.
Consider we sample with O(seconds) interval, so some activities can
still be unsampled whatever we do here (if they take <second). But on
the other hand the intention is to use this over billions of CPU
hours. So on the global scale we still observe more-or-less
everything.

Currently all signals are practically delivered to the main thread and
the added test does not pass (at least I couldn't wait long enough).
After this change the test passes quickly (within a second for me).
Testing the actual distribution without flaky failures is very hard in
unit tests. After rounds of complaints and deflaking they usually
transform into roughly what this test is doing -- all threads are
getting at least something.
If we want to test ultimate fairness, we would need to start with the
scheduler itself. If threads don't get fair fractions, then signals
won't be evenly distributed as well. I am not sure if there are unit
tests for the scheduler that ensure this in all configurations (e.g.
uneven ratio of runnable threads to CPUs, running in VMs, etc).
I agree this test is not perfect, but as I said, it does not pass now.
So it is useful and will detect a future regression in this logic. It
ensures that running threads eventually get signals.

But regardless of our motivation, this change looks like an
improvement in general. Consider performance alone (why would we wake
another thread, maybe send an IPI, evict caches). Sending the signal
to the thread that overflowed the counter also looks reasonable. For
some programs it may actually give a good picture. Say thread A is
running for a prolonged time, then thread B is running. The program
will first get signals in thread A and then in thread B (instead of
getting them on an unrelated thread).
