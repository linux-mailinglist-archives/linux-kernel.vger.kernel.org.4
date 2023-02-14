Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3A76696DFC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 20:34:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbjBNTes (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 14:34:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232589AbjBNTep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 14:34:45 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23DCC2CC74
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 11:34:42 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id o66so13543837ybc.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 11:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HoF4B0nW5aO8UrsssolMPa2IhHYXwyFPiviSp599dnk=;
        b=ZzoL1jZ2f2QxKPrRF591xcQkBsvRf4EilCMHiRJrhMVKzWjV9l7W3aDjs6llMxV1Fv
         DjfPwMV5ZVhO1sOgYKAupFJ6NWToiaCnfI82qHZBmyjIzbN+V68xidHYqRPvtOndWDjd
         nFpGUmx+3WTm5OHznrRuXng3wqlf8KM8ZNCdKZJyPP7o+cMHiXyHjsfyb7P1wbOxSrhF
         qLUTzrwuc5mrcFhs6uPOk+tky8GWgMbulkqkBTIoT2R4SuzOliVHDAxjTpPE2LiX1OeV
         C/MjhT0k5kTcFB3BFlcsZ+tU8DK0jB2K1RnG/a7KEWsc4aplkymwg74JmrAHwiUC9aFq
         AVZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HoF4B0nW5aO8UrsssolMPa2IhHYXwyFPiviSp599dnk=;
        b=WtgmG0497kcPecP6JNQuZLBovjNNTo6FID3KXCF9WysJOH9Xfln1IMBsQKYeJa5aUe
         xSN5G14KhfP7foZIAMCo97sG189I4Hk/rgvar62ZHeclDMY2aQCOlGyJfXSgqnR/JP2n
         xdoImgyRgdzJN6SRjtZe8z5gU36C8176bzsmz9w8LMx0OEEQD7nw/CUEud6mAMPUoW0G
         E1VVdNn8zYGxebdPB346OzHpIelZcm8dkXGO00OXzANfR2VDi3nbe6z+u3AfdYKC6o6B
         pBOdXQmmMzrLB2PQxGR9cOgn4Hegnrq0yj1R1mEFH/JtldZEOTf7V4jZhPTk+LMEgimB
         fkPg==
X-Gm-Message-State: AO0yUKXE0iRSLr7Jtnv0WhGIOwWQaYyp4GGskc0vuIsE2wGUPwJJvKoj
        6ezarB0C8XtvoAGRHxlah7PdUWuGj1hsYwbsLR3Qcg==
X-Google-Smtp-Source: AK7set/9xO0nUKjUT9lEnxqyWJaV/7bxF9VWlatrh38b8lmzFc1SRHOKTWz+ti1JdOIZDAO8Msy50SnOZjbryEyAG5k=
X-Received: by 2002:a05:6902:52a:b0:900:c3fd:a078 with SMTP id
 y10-20020a056902052a00b00900c3fda078mr473723ybs.657.1676403281056; Tue, 14
 Feb 2023 11:34:41 -0800 (PST)
MIME-Version: 1.0
References: <cover.1676067791.git.quic_sudaraja@quicinc.com>
 <CAJuCfpHWQ8NV=iR3BN+pt1c8FynCnRqyyriHb1gLxFgiNVrwjA@mail.gmail.com>
 <e944536f-a04c-5528-601e-d7f505a761e8@quicinc.com> <CAJuCfpGLkkS2yx0d9+2nYtEtxANSH5H3EgCmWZax4N-ieEBG7g@mail.gmail.com>
 <15cd8816-b474-0535-d854-41982d3bbe5c@quicinc.com> <CAJuCfpHihLgHCcsAqMJ_o2u7Ux9B5HFGsV2y_L2_5GXYAGYLnw@mail.gmail.com>
 <82406da2-799e-f0b4-bce0-7d47486030d4@quicinc.com>
In-Reply-To: <82406da2-799e-f0b4-bce0-7d47486030d4@quicinc.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 14 Feb 2023 11:34:30 -0800
Message-ID: <CAJuCfpHrhO7_fMwNuu2hdQob=MPjZTW8eaJpNhEhPmDMqz2qTA@mail.gmail.com>
Subject: Re: [PATCH] psi: reduce min window size to 50ms
To:     Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mike Rapoport <rppt@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        mark.rutland@arm.com, will@kernel.org,
        virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Sukadev Bhattiprolu <quic_sukadev@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Patrick Daly <quic_pdaly@quicinc.com>,
        Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2023 at 6:12 PM Sudarshan Rajagopalan
<quic_sudaraja@quicinc.com> wrote:
>
>
> On 2/10/2023 6:13 PM, Suren Baghdasaryan wrote:
> > On Fri, Feb 10, 2023 at 5:46 PM Sudarshan Rajagopalan
> > <quic_sudaraja@quicinc.com> wrote:
> >>
> >> On 2/10/2023 5:09 PM, Suren Baghdasaryan wrote:
> >>> On Fri, Feb 10, 2023 at 4:45 PM Sudarshan Rajagopalan
> >>> <quic_sudaraja@quicinc.com> wrote:
> >>>> On 2/10/2023 3:03 PM, Suren Baghdasaryan wrote:
> >>>>> On Fri, Feb 10, 2023 at 2:31 PM Sudarshan Rajagopalan
> >>>>> <quic_sudaraja@quicinc.com> wrote:
> >>>>>> The PSI mechanism is useful tool to monitor pressure stall
> >>>>>> information in the system. Currently, the minimum window size
> >>>>>> is set to 500ms. May we know what is the rationale for this?
> >>>>> The limit was set to avoid regressions in performance and power
> >>>>> consumption if the window is set too small and the system ends up
> >>>>> polling too frequently. That said, the limit was chosen based on
> >>>>> results of specific experiments which might not represent all
> >>>> Rightly as you said, the effect on power and performance depends on type
> >>>> of the system - embedded systems, or Android mobile, or commercial VMs
> >>>> or servers. With higher PSI sampling, it may not be much of power impact
> >>>> to embedded systems with low-tier chipsets or performance impact to
> >>>> powerful servers.
> >>>>
> >>>>> usecases. If you want to change this limit, you would need to describe
> >>>>> why the new limit is inherently better than the current one (why not
> >>>>> higher, why not lower).
> >>>> This is in regards to the userspace daemon [1] that we are working on,
> >>>> that dynamically resizes the VM memory based on PSI memory pressure
> >>>> events. With current min window size of 500ms, the PSI monitor sampling
> >>>> period would be 50ms. So to detect increase in memory demand in system
> >>>> and plug-in memory into VM when pressure goes up, the minimum time the
> >>>> process needs to stall for is 50ms before a event can be generated and
> >>>> sent out to userspace and the daemon can do actions.
> >>>>
> >>>> This again I'm talking w.r.t. lightweight embedded systems, where even
> >>>> background kswapd/kcompd (which I'm calling it as natural memory
> >>>> pressure) in the system would be less than 5-10ms stall. So any stall
> >>>> more than 5-10ms would "hint" us that a memory consuming usecase has
> >>>> ranB  and memory may need to be plugged in.
> >>>>
> >>>> So in these cases, having as low as 5ms psimon sampling time would give
> >>>> us faster reaction time and daemon can be responsive more quickly. In
> >>>> general, this will reduce the malloc latencies significantly.
> >>>>
> >>>> Pasting here the same excerpt I mentioned in [1].
> >>> My question is: why do you think 5ms is the optimal limit here? I want
> >>> to avoid a race to the bottom where next time someone can argue that
> >>> they would like to detect a stall within a lower period than 5ms.
> >>> Technically the limit can be as small as one wants but at some point I
> >>> think we should consider the possibility of this being used for a DoS
> >>> attack.
> >> Well the optimal limit should be something which is least destructive? I
> >> do understand about possibility of DoS attacks, but wouldn't that still
> >> be possible with 500ms window today? Which will atleast be 1/10th less
> >> severe compared to 50ms window. The way I see it is - min pressure
> >> sampling should be such that even the least pressure stall which we
> >> think is significant should be captured (this could be 5ms or 50ms at
> >> present) while balancing the power and performance impact across all
> >> usecases.
> >>
> >> At present, Android's LMKD sets 1000ms as window for which it considers
> >> 100ms sampling to be significant. And here, with psi_daemon usecase we
> >> are saying 5ms sampling would be significant. So there's no actual
> >> optimal limit, but we must limit as much possible without effecting
> >> power or performance as a whole. Also, this is just the "minimum
> >> allowable" window, and system admins can configure it as per the system
> >> type/requirement.
> > Ok, let me ask you another way which might be more productive. What
> > caused you to choose 5ms as the time you care to react to a stall
> > buildup?
>
> We basically want to capture any stalls caused by direct reclaim. And
> ignore any stalls caused by indirect reclaim and alloc retries. Stalls
> due to direct reclaim is what indicates that memory pressure is building
> up in system and memory needs to be free'd (by oom-killer or LMKD
> killing apps) or made available (by plugin-in any available memory or
> requesting memory from Primary host). We see that any stalls above 5ms
> is significant enough that alloc request would've invoked direct
> reclaim, hinting that
> memory pressure is starting to build up.
>
> Keeping the 5ms and other numbers aside, lets see what is smallest
> pressure that is of significance to be captured.
>
> A PSI memory stall is wholly comprised of: compaction (kcompactd),
> thrashing, kswapd, direct compaction and direct reclaim. Out of these,
> compaction, thrashing and kswapd stalls may not necessarily give
> significance towards memory demand building up (i.e. system is in need
> of more memory). Direct compaction stall would indicate memory is
> fragmented. But a significant direct reclaim stall would indicate that
> system is in memory pressure. Usually, direct compaction and direct
> reclaim are the smallest in an aggregated PSI memory stall.
>
> So now the question - what is the smallest direct reclaim stall that we
> should capture, which would be significant to us? Now this depends on
> system type and configuration and the nature of work loads. For Android
> mobile maybe 100ms (lmkd), and for servers maybe 1s (because max window
> is 10s?). For Linux Embedded Systems, this would be even smaller. From
> our experiments, we observed that 5ms stall would be significant to
> capture direct reclaim stalls that would indicate pressure build up.
>
> I think the min window size should be set such that even the smallest
> pressure stall that we think is significant should be be captured.
> Rather than hard-coding min window to 500ms, let the system admin choose
> what's best? We anyway have bigger cap set for max window of 10s (though
> I hardly doubt one would think 1s is the least pressure that they care
> of for cpu/io/memory). Also these window thresholds have never changed
> since psi monitor was introduced in kernel.org, and are based on
> previous experiments which may not have represented all workloads.
>
> Finding the true bottom of the well would be hard. But to keep things in
> ms range, we can define range 1ms-500ms in Kconfig:
>
> --- a/init/Kconfig
> +++ b/init/Kconfig
>
> +config PSI_MIN_WINDOW_MS
> +B B B B B B  int "Minimum PSI window (ms)"
> +B B B B B B  range 1 500
> +B B B B B B  default 500
> +
> +
>
> With PSI mechanism finding more of its uses, the same requirement might
> be applicable for io and cpu as well. Giving more flexibility in setting
> window size and sampling period would be beneficial.

Hmm. I understand the need and I still don't see a definite answer why
5ms minimum is optimal. The above description argues that 5ms is
indicative of direct reclaim but if some kernel internals change and
system stalls less during direct reclaim (for example, experimenting
with MGLRU we see less stalls), 5ms might end up being too high. You
would need to adjust the limit again.
Your suggestion to have this limit configurable sounds like obvious
solution. I would like to get some opinions from other maintainers.
Johannes, WDYT? CC'ing Michal to chime in as well since this is mostly
related to memory stalls.


>
> >> Also, about possible DoS attacks - file permissions for
> >> /proc/pressure/... can be set such that not any random user can register
> >> to psi events right?
> > True. We have a CAP_SYS_RESOURCE check for the writers of these files.
> >
> >>>> "
> >>>>
> >>>> 4. Detecting increase in memory demand b   when a certain usecase starts
> >>>> in VM that does memory allocations, it will stall causing PSI mechanism
> >>>> to generate a memory pressure event to userspace. To simply put, when
> >>>> pressure increases certain set threshold, it can make educated guess
> >>>> that a memory requiring usecase has ran and VM system needs memory to be
> >>>> added.
> >>>>
> >>>> "
> >>>>
> >>>> [1]
> >>>> https://lore.kernel.org/linux-arm-kernel/1bf30145-22a5-cc46-e583-25053460b105@redhat.com/T/#m95ccf038c568271e759a277a08b8e44e51e8f90b
> >>>>
> >>>>> Thanks,
> >>>>> Suren.
> >>>>>
> >>>>>> For lightweight systems such as Linux Embedded Systems, PSI
> >>>>>> can be used to monitor and track memory pressure building up
> >>>>>> in the system and respond quickly to such memory demands.
> >>>>>> Example, the Linux Embedded Systems could be a secondary VM
> >>>>>> system which requests for memory from Primary host. With 500ms
> >>>>>> window size, the sampling period is 50ms (one-tenth of windwo
> >>>>>> size). So the minimum amount of time the process needs to stall,
> >>>>>> so that a PSI event can be generated and actions can be done
> >>>>>> is 50ms. This reaction time can be much reduced by reducing the
> >>>>>> sampling time (by reducing window size), so that responses to
> >>>>>> such memory pressures in system can be serviced much quicker.
> >>>>>>
> >>>>>> Please let us know your thoughts on reducing window size to 50ms.
> >>>>>>
> >>>>>> Sudarshan Rajagopalan (1):
> >>>>>>      psi: reduce min window size to 50ms
> >>>>>>
> >>>>>>     kernel/sched/psi.c | 2 +-
> >>>>>>     1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>>>
> >>>>>> --
> >>>>>> 2.7.4
> >>>>>>
