Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8A1D5F0F2C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 17:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbiI3PpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 11:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231648AbiI3PpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 11:45:06 -0400
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 204CA67145
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 08:44:54 -0700 (PDT)
Received: by mail-vk1-xa34.google.com with SMTP id g85so2448977vkf.10
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 08:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=ZN18JmFgTARyMO3irUkH734KTn+WDrTqE1dWZkq8XaA=;
        b=Ue8KtT3pGQHW+NiXMnxHaVGH97PMTLBY46xYyeOdbedW/F6t5f1U5NMUyzfr9Wb9tI
         E8ecikEZAk9QtYX3dU4CbnsvYmQgrUuWOMSfCFGYqwHkZXTM1qpxboC6A2smbDggbEnt
         kx1QiaACxyxQS3CLePQx45VKskGoZFTYvZ9TnUYaIj7Y1X1av7UQsJu7GgEgBuDsbt36
         Pobom1DFwJ62OSWc+gnG1hOlaaYvCRkD+ivD4HZU89KOZ3V20NRwn7mEUW7QfHJISFIB
         i+xYe6xmdm/fP3Y+6zrzWU7cxRbyKWf3M+w6cpiVC/ITVt5LbFyyc8jRrKHH6RMU9Nw9
         AbcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=ZN18JmFgTARyMO3irUkH734KTn+WDrTqE1dWZkq8XaA=;
        b=3p9/TVvctfKNTL4vO2MeCfAZR2XBPPnyFPXMi38+kdAANf+O/5/O86hyxFhJgCYKPJ
         BMStVCI00T+sz7Y0FDfgnNZZJqm3iZQ0Vknu6GA9O5Tz/pqh0VCzTTdDpJMWULJgs3+6
         j/3ZiZwUBnEdCZ1RvST6NoR75Cvqzf04eOdGItjrRglDre6ZNctHLnItZHgFy5XETd4x
         Qrskl7lcEAECM467xlv7UcPgASDOQY+V4qAOxBvBAbNMO9ZjY8riwbq+l4ZDIj9tmxpA
         UiOm6nO0F76QkFyaAAmUHMAyV0WSQfFQOKbJhKbFimccLw2nfL6FbKtk1FYvqXeYeKBy
         9Cig==
X-Gm-Message-State: ACrzQf1pPVcTQ5S3Q7Q2vhPGdY2gUHcXbGF4car3TIcoYGbg4eQT25B1
        dUXvbxe8ZT0L5T3gntM3yfcIuTxkKr+tR0XmCrfWTQ==
X-Google-Smtp-Source: AMsMyM4HMU+mDMQJffsVerxyYAnpWB1EhxR4Jn1M/iptlsCIiyo69jXlBcdQPlISi9CZ4AD1BxxmGxl9jlRGtPSUzxw=
X-Received: by 2002:a1f:2ed8:0:b0:3a2:a7f:3e9e with SMTP id
 u207-20020a1f2ed8000000b003a20a7f3e9emr4727741vku.7.1664552690394; Fri, 30
 Sep 2022 08:44:50 -0700 (PDT)
MIME-Version: 1.0
References: <cb6c406e-1431-fcfd-ef82-87259760ead9@joelfernandes.org> <20220930134931.mpopdvri4xuponw2@wubuntu>
In-Reply-To: <20220930134931.mpopdvri4xuponw2@wubuntu>
From:   Youssef Esmat <youssefesmat@google.com>
Date:   Fri, 30 Sep 2022 10:44:39 -0500
Message-ID: <CALUeGD0yEimCRS2TQfZTUD2kwamyTZwM9Y9D7C=Xsd9t9mWsaw@mail.gmail.com>
Subject: Re: Sum of weights idea for CFS PI
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, juri.lelli@redhat.com,
        vincent.guittot@linaro.org,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
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

Hi Everyone!

I am not sure we should care about A's sleeping pattern. The case we
care about is when A is running or wants to run but can't because it
is blocked on C. In that case C should get the weight of A as if A was
running.

Ideally this is also a temporary boost since critical sections should
be relatively small, so erring on the side of giving C slightly more
runtime would be safe I think.

Thanks,
Youssef

On Fri, Sep 30, 2022 at 8:49 AM Qais Yousef <qais.yousef@arm.com> wrote:
>
> Hi Joel
>
> I'm interested in the topic, if I can be CCed in any future discussions I'd
> appreciate it :)
>
> On 09/29/22 16:38, Joel Fernandes wrote:
> > Hi Peter, all,
> >
> > Just following-up about the idea Peter suggested at LPC22 about sum of weights
> > to solve the CFS priority inversion issues using priority inheritance. I am not
> > sure if a straight forward summation of the weights of dependencies in the
> > chain, is sufficient (or may cause too much unfairness).
> >
> > I think it will work if all the tasks on CPU are 100% in utilization:
> >
> > Say if you have 4 tasks (A, B, C, D) running and each one has equal
> > weight (W) except for A which has twice the weight (2W).
> > So the CPU bandwidth distribution is (assuming all are running):
> > A:   2 / 5
> > B, C. D:  1 / 5
> >
> > Say out of the 4 tasks, 3 of them are a part of a classical priority
> > inversion scenario (A, B and C).
> >
> > Say now A blocks on a lock and that lock's owner C is running, however now
> > because A has blocked, B gets 1/3 bandwidth, where as it should have been
> > limited to 1/5. To remedy this, say you give C a weight of 2W. B gets 1/4
> > bandwidth - still not fair since B is eating away CPU bandwidth causing the
> > priority inversion we want to remedy.
> >
> > The correct bandwidth distribution should be (B and D should be unchanged):
> > B = 1/5
> > D = 1/5
> >
> > C = 3/5
> >
> > This means that C's weight should be 3W , and B and D should be W each
> > as before. So indeed, C's new weight is its original weight PLUS the
> > weight of the A - that's needed to keep the CPU usage of the other
> > tasks (B, D) in check so that C makes forward progress on behalf of A and the
> > other tasks don't eat into the CPU utilization.
> >
> > However, I think this will kinda fall apart if A is asleep 50% of the time
> > (assume the sleep is because of I/O and unrelated to the PI chain).
> >
> > Because now if all were running (and assume no PI dependencies), with A being
> > 50%, the bandwidth of B, C and D each would be divided into 2 components:
> >
> > a.  when A is running, it would be as above.
> > b.  but if A was sleeping, B, C, and D would get 1/3.
> >
> > So on average, B, C and D get:  (1/3 + 1/5) / 2 = 8/30. This gives A about 6/30
> > or 1/5 bandwidth.
>
> The average metric is interesting one. It can be confusing to reason about too.
>
> I think we have 3 events to take into account here, not 2:
>
> a. when A is running and NOT blocked on C.
> b. when A is running and BLOCKED on C.
> c. A is sleeping.
>
> This means A, B, C and D's shares will be:
>
>     A ,  B ,  C ,  D
> a. 2/5, 1/5, 1/5, 1/5
> b. -  , 3/5, 1/5, 1/5
> c. -  , 1/3, 1/3, 1/3
>
> Since A is sleeping for 50%, I don't think we can assume equal distribution for
> the 3 events (can't just divide by 3).
>
> I believe we can assume that
>
> a. occurs 25% of the time
> b. occurs 25% of the time
> c. occurs 50% of the time
>
> I *think* this should provide something more representative.
>
> >
> > But now say A happen to block on a lock that C is holding. You would boost C to
> > weight 3W which gives it 3/5 (or 18/30) as we saw above, which is more than what
> > C should actually get.
> >
> > C should get (8/30 + 6/30 = 14/30) AFAICS.
> >
> > Hopefully one can see that a straight summation of weights is not enough. It
> > needs to be something like:
> >
> > C's new weight = C's original weight + (A's weight) * (A's utilization)
> >
> > Or something, otherwise the inherited weight may be too much to properly solve it.
> >
> > Any thoughts on this? You mentioned you had some notes on this and/or proxy
> > execution, could you share it?
>
> I assume we'll be using rt-mutex inheritance property to handle this? If this
> was discussed during a talk, I'd appreciate a link to that.
>
> In the past in OSPM conference we brought up an issue with performance
> inversion where a task running on a smaller (slower to be more generic) CPU is
> holding the lock and causing massive delays for waiters. This is an artefact of
> DVFS. For HMP, there's an additional cause due to the unequal capacities of the
> CPUs.
>
> Proxy execution seems to be the nice solution to all of these problems, but
> it's a long way away. I'm interested to learn how this inheritance will be
> implemented. And whether there are any userspace conversion issues. i.e: do
> we need to convert all locks to rt-mutex locks?
>
>
> Thanks
>
> --
> Qais Yousef
