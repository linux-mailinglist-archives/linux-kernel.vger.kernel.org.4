Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E08BC67EAA8
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 17:19:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234193AbjA0QTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 11:19:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234303AbjA0QTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 11:19:16 -0500
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36A1D7D6CF
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 08:19:11 -0800 (PST)
Received: by mail-ua1-x92a.google.com with SMTP id j21so1161355uap.5
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 08:19:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=btzXDkgY9zIV0E9s3BhkQX/D33sJFMFogaPzfTY6Ij8=;
        b=Uj35fujsymUNT+Dpx+NM/bZ/3HuCuDVI+F5ZEhFp8eN1O5gfh14fq5ulYBUs3aZ75R
         2VhyGEg77uD8gVsD3xTvTWEw4G6XbUGY91q7ADSjgxzjmvQDx+apZwE5JA+VF2d7SMu2
         r8Omlw3XgbhxWD8b93tvEo5JeMLDN9FxGbQD0M+/cSaMTYwRSxsLbn/yoUVLmyIv9Rml
         1f8vmWDqLLTqaFrag8e9xbKQALtsognLThGzMmefhfSHPygfhwhYw3XE1IIy2RYsotsX
         NgsUf5zcSvJzv0oPWWlG/5UvppfDi1jSCe+RfQlOKebHgFaazvo+sc3iva7viwWwmC3k
         7ctw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=btzXDkgY9zIV0E9s3BhkQX/D33sJFMFogaPzfTY6Ij8=;
        b=PFz632+soRV3j8cUtnc6ol5EOEJFilD/J4Xo9JlVuy8VaiGcYUplSI8t0lRGrlVuh/
         7rXOO8f9hrmqkXoV+HKv862YozU13bN1WrFLJ+P5OTdxpx8sE7xL1owGVaCL2kR0s/OC
         dP7JVlpgrEkCKiyD6Il8ywe2SeTWdfqRIo1FRexzIlmSf7oFU9P3fcpUS6RPK5Xw/4ga
         wb/Wan1GkVVkm4CAjVBo6YiTZLost57aGg8M53qjCd8tjOfILUB0k1NfCXP/FkYS54r3
         h2Nm9xrh6545qsmrb8MfwNC0Ush6B8QTNCUx9E7GL2rg3FgpSxdjnhBdqcUepRTDZJ3V
         5oTQ==
X-Gm-Message-State: AFqh2krRegp4I6fw+OJgE/BOpi6x7lr5BF1CbazVs3FtXPkNGsCcPTTQ
        uVMLib60rteY8cT8r+sWXm23Z+hGbftT7mZMgCj4eQ==
X-Google-Smtp-Source: AMrXdXtCXWoKvPOmh0hZEHZ3kKv8FTv1+y1qQCUCWWQ4uQ7FFsgLx7/6erIhMq355JCc2VYbRnNDs8/smpnNPXgV61o=
X-Received: by 2002:ab0:5550:0:b0:631:641a:ed3b with SMTP id
 u16-20020ab05550000000b00631641aed3bmr3572249uaa.13.1674836350255; Fri, 27
 Jan 2023 08:19:10 -0800 (PST)
MIME-Version: 1.0
References: <73e639d5-702b-0d03-16d9-a965b1963ef6@huawei.com>
 <Y6RRfF5yRew7rdCp@hirez.programming.kicks-ass.net> <Y9GG3N5ivVvyETa2@u40bc5e070a0153.ant.amazon.com>
 <Y9J25xMrItpeHIxD@hirez.programming.kicks-ass.net> <Y9LG5vkf/4ufJb35@u40bc5e070a0153.ant.amazon.com>
 <Y9O5Fwfib2CVAMwl@hirez.programming.kicks-ass.net>
In-Reply-To: <Y9O5Fwfib2CVAMwl@hirez.programming.kicks-ass.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 27 Jan 2023 17:18:56 +0100
Message-ID: <CAKfTPtBMSg2SDXq=sVt99TyM+tEXRFL74EQ57-t5uKYAXUUyLg@mail.gmail.com>
Subject: Re: [bug-report] possible s64 overflow in max_vruntime()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Roman Kagan <rkagan@amazon.de>,
        Zhang Qiao <zhangqiao22@huawei.com>,
        Waiman Long <longman@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Jan 2023 at 12:44, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Jan 26, 2023 at 07:31:02PM +0100, Roman Kagan wrote:
>
> > > All that only matters for small sleeps anyway.
> > >
> > > Something like:
> > >
> > >         sleep_time = U64_MAX;
> > >         if (se->avg.last_update_time)
> > >           sleep_time = cfs_rq_clock_pelt(cfs_rq) - se->avg.last_update_time;
> >
> > Interesting, why not rq_clock_task(rq_of(cfs_rq)) - se->exec_start, as
> > others were suggesting?  It appears to better match the notion of sleep
> > wall-time, no?
>
> Should also work I suppose. cfs_rq_clock takes throttling into account,
> but that should hopefully also not be *that* long, so either should
> work.

yes rq_clock_task(rq_of(cfs_rq)) should be fine too

Another thing to take into account is the sleeper credit that the
waking task deserves so the detection should be done once it has been
subtracted from vruntime.

Last point, when a nice -20 task runs on a rq, it will take a bit more
than 2 seconds for the vruntime to be increased by more than 24ms (the
maximum credit that a waking task can get) so threshold must be
significantly higher than 2 sec. On the opposite side, the lowest
possible weight of a cfs rq is 2 which means that the problem appears
for a sleep longer or equal to 2^54 = 2^63*2/1024. We should use this
value instead of an arbitrary 200 days
