Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 487E9692D49
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 03:14:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjBKCNx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 21:13:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjBKCNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 21:13:51 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A843A749A8
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 18:13:50 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id t1so8494013ybd.4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 18:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AVP4LC3gxGWSgfBKADHFIlAxBAsTci144FYv9y485hg=;
        b=NPI837DV4EdaoeNJsQeGxGiORVPx5kAQoNueJgiD1XlDEvkL9LVfAu7g3ZGGyS2doo
         9Bq1oBX5y/YPpS9ZrpUunYyN+Xf8nMnvZ2NizCyftSOeC5K86feu6z58rTOc/+fowTIQ
         vhFpdKzZ8TEHx+/CEj1PuP1piN8qezpPEWCjcrLJjkOqDZi4I9ECxLWeilbpYRv9DrbX
         +2CLc7jkXjeuF4sSaZGeDFLtLIHb3eFqaC5BoEOP4RUEoS8nMtDxR9kByfgXTEtRa7PV
         qYAcc1DMFmNJX9QkrCx1RTtCFSWIKDVZw7YwjPaB3LKXHZI/2WI82Ahf9j5iT45u0pET
         /v8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AVP4LC3gxGWSgfBKADHFIlAxBAsTci144FYv9y485hg=;
        b=X5Of8lRzSOgqDnU3jS8ZsTenPE8XEg5RPSjbZX5NvXXklmmXq8SQLP/1ZI5k/fqVYk
         bMK1Uq/I+ZaSahDdRTAPboY1ymlmslmtfOshN6M31D6IRNFirZy3O5D+cWa9tBZw1002
         XMV+tQE1mk3BoVqcJDtYYOXIXXeVMp3+nKi1k4iAjOG/oGec9YxNXaRWvzqcOLeWaXev
         z85p6NHuf1m6IlIvRMTCbno78eU5uzjykIuoFUriUAF4B/SJ/qLAKGAdepjKAnVzLTHR
         6/HtxRs1y+8pyPg3lK9SWxvGIjMhv3af2E/EHAOkWJxUBukS9MzexzQayCiqR9rye8Ah
         xz2g==
X-Gm-Message-State: AO0yUKXm1eLT1OZvQD2vG546YVNtC+NM5aYOO7IW6edwX5K91Lcsi5og
        3c6y3dqqBcmBzLiKTEWdzl0fw6Zcdd0vmReO//DKRw==
X-Google-Smtp-Source: AK7set+3gfrSyBe2ekI0j3jHxJx6O06Jkj6lGbli3p2gDEex73DfaLxJS9IdJnjitOuP+Gh+sLvcheeC4VLot30O7pM=
X-Received: by 2002:a25:eb0f:0:b0:8ef:c897:33aa with SMTP id
 d15-20020a25eb0f000000b008efc89733aamr373455ybs.288.1676081629619; Fri, 10
 Feb 2023 18:13:49 -0800 (PST)
MIME-Version: 1.0
References: <cover.1676067791.git.quic_sudaraja@quicinc.com>
 <CAJuCfpHWQ8NV=iR3BN+pt1c8FynCnRqyyriHb1gLxFgiNVrwjA@mail.gmail.com>
 <e944536f-a04c-5528-601e-d7f505a761e8@quicinc.com> <CAJuCfpGLkkS2yx0d9+2nYtEtxANSH5H3EgCmWZax4N-ieEBG7g@mail.gmail.com>
 <15cd8816-b474-0535-d854-41982d3bbe5c@quicinc.com>
In-Reply-To: <15cd8816-b474-0535-d854-41982d3bbe5c@quicinc.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 10 Feb 2023 18:13:38 -0800
Message-ID: <CAJuCfpHihLgHCcsAqMJ_o2u7Ux9B5HFGsV2y_L2_5GXYAGYLnw@mail.gmail.com>
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
        Patrick Daly <quic_pdaly@quicinc.com>
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

On Fri, Feb 10, 2023 at 5:46 PM Sudarshan Rajagopalan
<quic_sudaraja@quicinc.com> wrote:
>
>
> On 2/10/2023 5:09 PM, Suren Baghdasaryan wrote:
> > On Fri, Feb 10, 2023 at 4:45 PM Sudarshan Rajagopalan
> > <quic_sudaraja@quicinc.com> wrote:
> >>
> >> On 2/10/2023 3:03 PM, Suren Baghdasaryan wrote:
> >>> On Fri, Feb 10, 2023 at 2:31 PM Sudarshan Rajagopalan
> >>> <quic_sudaraja@quicinc.com> wrote:
> >>>> The PSI mechanism is useful tool to monitor pressure stall
> >>>> information in the system. Currently, the minimum window size
> >>>> is set to 500ms. May we know what is the rationale for this?
> >>> The limit was set to avoid regressions in performance and power
> >>> consumption if the window is set too small and the system ends up
> >>> polling too frequently. That said, the limit was chosen based on
> >>> results of specific experiments which might not represent all
> >> Rightly as you said, the effect on power and performance depends on type
> >> of the system - embedded systems, or Android mobile, or commercial VMs
> >> or servers. With higher PSI sampling, it may not be much of power impact
> >> to embedded systems with low-tier chipsets or performance impact to
> >> powerful servers.
> >>
> >>> usecases. If you want to change this limit, you would need to describe
> >>> why the new limit is inherently better than the current one (why not
> >>> higher, why not lower).
> >> This is in regards to the userspace daemon [1] that we are working on,
> >> that dynamically resizes the VM memory based on PSI memory pressure
> >> events. With current min window size of 500ms, the PSI monitor sampling
> >> period would be 50ms. So to detect increase in memory demand in system
> >> and plug-in memory into VM when pressure goes up, the minimum time the
> >> process needs to stall for is 50ms before a event can be generated and
> >> sent out to userspace and the daemon can do actions.
> >>
> >> This again I'm talking w.r.t. lightweight embedded systems, where even
> >> background kswapd/kcompd (which I'm calling it as natural memory
> >> pressure) in the system would be less than 5-10ms stall. So any stall
> >> more than 5-10ms would "hint" us that a memory consuming usecase has
> >> ranB  and memory may need to be plugged in.
> >>
> >> So in these cases, having as low as 5ms psimon sampling time would give
> >> us faster reaction time and daemon can be responsive more quickly. In
> >> general, this will reduce the malloc latencies significantly.
> >>
> >> Pasting here the same excerpt I mentioned in [1].
> > My question is: why do you think 5ms is the optimal limit here? I want
> > to avoid a race to the bottom where next time someone can argue that
> > they would like to detect a stall within a lower period than 5ms.
> > Technically the limit can be as small as one wants but at some point I
> > think we should consider the possibility of this being used for a DoS
> > attack.
>
> Well the optimal limit should be something which is least destructive? I
> do understand about possibility of DoS attacks, but wouldn't that still
> be possible with 500ms window today? Which will atleast be 1/10th less
> severe compared to 50ms window. The way I see it is - min pressure
> sampling should be such that even the least pressure stall which we
> think is significant should be captured (this could be 5ms or 50ms at
> present) while balancing the power and performance impact across all
> usecases.
>
> At present, Android's LMKD sets 1000ms as window for which it considers
> 100ms sampling to be significant. And here, with psi_daemon usecase we
> are saying 5ms sampling would be significant. So there's no actual
> optimal limit, but we must limit as much possible without effecting
> power or performance as a whole. Also, this is just the "minimum
> allowable" window, and system admins can configure it as per the system
> type/requirement.

Ok, let me ask you another way which might be more productive. What
caused you to choose 5ms as the time you care to react to a stall
buildup?

>
> Also, about possible DoS attacks - file permissions for
> /proc/pressure/... can be set such that not any random user can register
> to psi events right?

True. We have a CAP_SYS_RESOURCE check for the writers of these files.

>
> >
> >> "
> >>
> >> 4. Detecting increase in memory demand b   when a certain usecase starts
> >> in VM that does memory allocations, it will stall causing PSI mechanism
> >> to generate a memory pressure event to userspace. To simply put, when
> >> pressure increases certain set threshold, it can make educated guess
> >> that a memory requiring usecase has ran and VM system needs memory to be
> >> added.
> >>
> >> "
> >>
> >> [1]
> >> https://lore.kernel.org/linux-arm-kernel/1bf30145-22a5-cc46-e583-25053460b105@redhat.com/T/#m95ccf038c568271e759a277a08b8e44e51e8f90b
> >>
> >>> Thanks,
> >>> Suren.
> >>>
> >>>> For lightweight systems such as Linux Embedded Systems, PSI
> >>>> can be used to monitor and track memory pressure building up
> >>>> in the system and respond quickly to such memory demands.
> >>>> Example, the Linux Embedded Systems could be a secondary VM
> >>>> system which requests for memory from Primary host. With 500ms
> >>>> window size, the sampling period is 50ms (one-tenth of windwo
> >>>> size). So the minimum amount of time the process needs to stall,
> >>>> so that a PSI event can be generated and actions can be done
> >>>> is 50ms. This reaction time can be much reduced by reducing the
> >>>> sampling time (by reducing window size), so that responses to
> >>>> such memory pressures in system can be serviced much quicker.
> >>>>
> >>>> Please let us know your thoughts on reducing window size to 50ms.
> >>>>
> >>>> Sudarshan Rajagopalan (1):
> >>>>     psi: reduce min window size to 50ms
> >>>>
> >>>>    kernel/sched/psi.c | 2 +-
> >>>>    1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>
> >>>> --
> >>>> 2.7.4
> >>>>
