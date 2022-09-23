Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 604335E73A0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 08:02:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbiIWGCE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 02:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbiIWGCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 02:02:00 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82F68AA3F5
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 23:01:58 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id w8so18136884lft.12
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 23:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=yRmooU5ejMhVxWXvZlvaCuer/4vawdm8V4w452oYyqw=;
        b=gCRttd3uNDn3YPmzOyIE4muGeYOU9ed0g5ylA4QhcU/ezZiMZ49vHuHvlqa8pfetY6
         LzO9LxwrW10Qn0usX/E28pd5+IUXj9muAP5aa1NFQm80M8HIQexEcEm2Yi+49Wb1e0KE
         POhWCtEbqJwfxV0NUnJ/BNN6AHxJvnpqd9ZZEKzzTjuwJ27zApM2FzLODB/8lQqyEMC2
         o80P6zlP4XmaO5NT7AOkwSaafCKrvdDU6mAD7jf5R2trAPqDRW8e3Lj09CWvKAAp+u/j
         5JdKrytjjuD0WpyHS88BZDms18iNS8Of9+Y6wpQi9/o4IA57R9dQj+F7tNoLAE8MoZwg
         lMmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=yRmooU5ejMhVxWXvZlvaCuer/4vawdm8V4w452oYyqw=;
        b=Ck+U2uSNG8cpoYWd8/BOkt7IAFcpeXIRxhn6idHWcekeD3nw9wLKmZRm4c869Zn+7g
         LJ0rHZCfvoS4UnbdktfUoORqHu3Zdj+0QvH0xlFhe4ixzDcDYdLJZvdj8Ipxo5ydInfB
         LqopgnOeFemZLxSDIUrUWuel0Kt5M7ALKiRGGS5lasOR+WHJeHyemIbUlAPD1kbmsiuQ
         BpdEbsVn5Iq1iaCA9kyqFces3mS0w61ony0ct2u4VwFuuBLIgc3fqWK6/F/5Jxf1/vjM
         uj1I6CIg0QrSCQjsXrIBson9ZKFtd96c0xo/lemGzsVomS9dBTuLmra3eBi88AgA3aDR
         yV0A==
X-Gm-Message-State: ACrzQf11Kp/95EHdOzNcWtj7XuacO7LT2rLODPOzaejMSQaTyPbj2k3F
        Pj1YmKOf5iQqkb+MOa062asaEGUGk4Y2KEKo9xE9FQ==
X-Google-Smtp-Source: AMsMyM6kj+a4w/RFUb2jG6e9ZJiaPyCiYK2zQ+anwBfAFfMd4YuGqlxLCf9mBrBqctPHRV19RcMy0KkUSO5EQkqCmu8=
X-Received: by 2002:ac2:5107:0:b0:497:adac:7305 with SMTP id
 q7-20020ac25107000000b00497adac7305mr2649497lfb.32.1663912916506; Thu, 22 Sep
 2022 23:01:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220916080305.29574-1-vincent.guittot@linaro.org>
 <20220916080305.29574-6-vincent.guittot@linaro.org> <073938c4-ab23-2270-8e60-291f2901e230@arm.com>
 <CAKfTPtCWE5O4TeTBG8hgar8w56-WzvmX7aR9D7dXN_vJ5LCLyQ@mail.gmail.com>
 <b02452b2-900c-89da-c7b7-40a61268065e@arm.com> <CAKfTPtDvWsq8YUEzK=xm+S22p=f1kR87a4hT38Ni_t4ZfZ0Zag@mail.gmail.com>
 <04c65f4f-5072-2a07-cbe0-63046a7bc58f@arm.com> <CAKfTPtA1UFRGsDRVRNn_M2OEQ2G8A5MzWP_3GpmSsf1=B9+DdA@mail.gmail.com>
 <0a437c9e-299d-574e-a393-f589c78ba2c7@arm.com>
In-Reply-To: <0a437c9e-299d-574e-a393-f589c78ba2c7@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 23 Sep 2022 08:01:45 +0200
Message-ID: <CAKfTPtAHyfFvnBzYYws8ZhPsmGs8KPz_cmMx2apOS8ZaJA-7Bw@mail.gmail.com>
Subject: Re: [PATCH v4 5/8] sched/fair: Take into account latency priority at wakeup
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, parth@linux.ibm.com,
        qais.yousef@arm.com, chris.hyser@oracle.com,
        valentin.schneider@arm.com, patrick.bellasi@matbug.net,
        David.Laight@aculab.com, pjt@google.com, pavel@ucw.cz,
        tj@kernel.org, qperret@google.com, tim.c.chen@linux.intel.com,
        joshdon@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Sept 2022 at 18:50, Dietmar Eggemann
<dietmar.eggemann@arm.com> wrote:
>
> On 22/09/2022 09:12, Vincent Guittot wrote:
> > On Thu, 22 Sept 2022 at 00:41, Dietmar Eggemann
> > <dietmar.eggemann@arm.com> wrote:
> >>
> >> On 20/09/2022 17:49, Vincent Guittot wrote:
> >>> On Tue, 20 Sept 2022 at 15:18, Dietmar Eggemann
> >>> <dietmar.eggemann@arm.com> wrote:
> >>>>
> >>>> On 19/09/2022 17:39, Vincent Guittot wrote:
> >>>>> On Mon, 19 Sept 2022 at 12:05, Dietmar Eggemann
> >>>>> <dietmar.eggemann@arm.com> wrote:
> >>>>>>
> >>>>>> On 16/09/2022 10:03, Vincent Guittot wrote:
>
> [...]
>
> > I thought you were speaking about priority 0 vs [1..19] as you made a
> > difference in your previous comment below
> >
> >>
> >> (1) p = 10 curr =  19 -> wakeup_latency_gran() returns 12ms
> >>
> >> (2) p = 10 curr = -10 -> wakeup_latency_gran() returns 24ms
> >>
> >> In (1) only p's own latency counts whereas in (2) we take the diff,
> >
> > Yes because  curr is latency sensitive in (2) whereas it's not in (1)
> >
> >>
> >> In (A) we 'punish' p even though it competes against curr which has an
> >> even lower latency requirement than p,
> >
> > What is (A) ?  Assuming you meant (1), having a positive nice latency
>
> Sorry, yes I meant (1).
>
> > means that you don't have latency requirement but you are tolerant to
> > scheduling delay so we don't 'punish' p. P will preempt curr is we are
> > above the tolerance
>
> wakeup_preempt_entity() {
>
>     vdiff = curr->vruntime - se->vruntime
>
>     vdiff -= wakeup_latency_gran(curr, se)   <-- (3)
>
>     if (vdiff <= 0)
>         return -1;
>
>     ...
> }
>
> Wouldn't it be more suitable to return 0 from wakeup_latency_gran() if
> both have latency_nice >=0 in this case instead of se->latency_offset?

No because that defeats all the purpose of being tolerant to
scheduling delay and not trying to preempt the current as usual at
wakeup. In this case there would be not diff with not setting the
latency nice value.

>
> By `punish` I mean that vdiff (3) gets smaller in case we return (the
> positive) `se->latency_offset` even `latency nice of curr` > `latency
> nice of p`.
>
> [...]
>
> >> With p = -19 and curr = -19 we would take the diff, so 0ms.
> >>
> >> With p = 19 and curr = 19, if we would use `latency_offset -=
> >> curr->latency_offset` wakeup_latency_gran() would return 973/1024*24ms -
> >> 973/1024*24ms = 0ms and nothing will shift.
> >>
> >> OTHA, in case (1) wakeup_latency_gran() would return 512/1024*24ms -
> >> 973/1024*24ms = - 10.80ms. So p would gain an advantage here instead of
> >> a penalty.
> >
> > And that's all the point. A priority >= 0 means that you don't care
> > about scheduling delays so there is no reason to be more aggressive
> > with a task that is also latency tolerant. We only have to ensure that
> > the delay stays in the acceptable range
>
> OK, I understand you model here but I'm still not convinced. Might be
> interesting to hear what others think.
