Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA116A4B98
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 20:51:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbjB0Tvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 14:51:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbjB0Tvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 14:51:39 -0500
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E8F9274B7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 11:51:38 -0800 (PST)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-536c2a1cc07so207877627b3.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 11:51:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lkevDn4DNYW/8YPDoKxyzBrLj3j2BowCepETKWCJ49o=;
        b=UypZLlK1wJzxwH10S2jYJInQ/vksgV4BR5VhyVRAxNqheIAftXCyONMXMn37xBwePM
         cwvjJtCiICsIwhkivabN8qCRWuPpVdSL/7Jy0O3ClAhfZoBtsoYDN3iLym4ifR9xOzox
         d0jSp5W5mbZ1pBmgbMOBTcBPOktUfd4rQD7XI3QNKy/Ap1fSN/itCFXsXVMqfmljHtMS
         2+whgIWL6PbW3mUjIbGhnJv/fBq0QKi8ORQSAxNNCvq1Mc2UyQfi4aGQGQIX1OEaX1WW
         gVTjaAuZJlL13Qf2nk3+kc2Y4W5yUx2e3wPaO9wpGJFmap/MvQWhC4w2/7DbInmojsg7
         6vJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lkevDn4DNYW/8YPDoKxyzBrLj3j2BowCepETKWCJ49o=;
        b=QYPx4u8+CII/I28HUea0ftgdjFAP3bsiJIOAPW7GiNh+baA/HS7vIXaiCiGOnWBpFj
         oLhrAE9/E1BxOBzT2souOa7WO8dzKB9G3HzKgfEk8qQXmAC35A3FRWilJorrgvOd2DFb
         JWHhG0Z6/rIsVMgzQQVzM84eMXP7SIDHWxEHtXRSjGSCUC5E+OkqHvmdFh/VF0yCorkC
         b9ATSXGrN2f3531HJXZ6P8gZY9hc84RbDTCWscrLUABtmM6uo/xzKv9yjv0x4022pF0e
         LJo3aHAZvvogaKvf23ZMu1AvoiaJlOeN7QO5WQ3mX0d6yLZ9zTBR0KDjLWG2RoTYvb3v
         eGUQ==
X-Gm-Message-State: AO0yUKXdFN5Ix6MEZYXCvwhEAhAZfoKpMG0aPxqHhvVNEeGiJ2t84vZM
        gk5gRGOMDfMDwnnN0bbVrpWGZvFg58o18ckLDbn61g==
X-Google-Smtp-Source: AK7set//uH0WcoiriDP0FpcwDBut7JGs7sxlL9JhfKEDBs8VuN7dLvEIaK1z0x6s2/pSCipMWNt/Ictwg7WDJiwzcqo=
X-Received: by 2002:a81:af52:0:b0:533:9d49:f9c9 with SMTP id
 x18-20020a81af52000000b005339d49f9c9mr692ywj.0.1677527496927; Mon, 27 Feb
 2023 11:51:36 -0800 (PST)
MIME-Version: 1.0
References: <cover.1676067791.git.quic_sudaraja@quicinc.com>
 <CAJuCfpHWQ8NV=iR3BN+pt1c8FynCnRqyyriHb1gLxFgiNVrwjA@mail.gmail.com>
 <e944536f-a04c-5528-601e-d7f505a761e8@quicinc.com> <CAJuCfpGLkkS2yx0d9+2nYtEtxANSH5H3EgCmWZax4N-ieEBG7g@mail.gmail.com>
 <15cd8816-b474-0535-d854-41982d3bbe5c@quicinc.com> <CAJuCfpHihLgHCcsAqMJ_o2u7Ux9B5HFGsV2y_L2_5GXYAGYLnw@mail.gmail.com>
 <82406da2-799e-f0b4-bce0-7d47486030d4@quicinc.com> <CAJuCfpHrhO7_fMwNuu2hdQob=MPjZTW8eaJpNhEhPmDMqz2qTA@mail.gmail.com>
 <Y/ix53x8i/ViuBXf@dhcp22.suse.cz> <CAJuCfpG1c5v6qOotPV6t-o1T1p7EbOLs90eFnoEBjts+gafovA@mail.gmail.com>
 <Y/yxSqhpQh9yR7L4@dhcp22.suse.cz> <CAJuCfpHXwbtjdhH_K9r28-LUYtzC6+NaZ+RrKCtiNBk8PfXhLw@mail.gmail.com>
 <d2a6b0ec-89a6-1a2f-d92e-c20a8d223d17@akamai.com>
In-Reply-To: <d2a6b0ec-89a6-1a2f-d92e-c20a8d223d17@akamai.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 27 Feb 2023 11:51:26 -0800
Message-ID: <CAJuCfpFNdhcVN66_j9J1s4GLjQ99t5mkQsWgOwmTPpzX9Ss=_g@mail.gmail.com>
Subject: Re: [PATCH] psi: reduce min window size to 50ms
To:     Josh Hunt <johunt@akamai.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>,
        David Hildenbrand <david@redhat.com>,
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
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 27, 2023 at 11:19 AM Josh Hunt <johunt@akamai.com> wrote:
>
>
>
> On 2/27/23 9:49 AM, Suren Baghdasaryan wrote:
> > On Mon, Feb 27, 2023 at 5:34 AM Michal Hocko <mhocko@suse.com> wrote:
> >>
> >> On Fri 24-02-23 13:07:57, Suren Baghdasaryan wrote:
> >>> On Fri, Feb 24, 2023 at 4:47 AM Michal Hocko <mhocko@suse.com> wrote:
> >>>>
> >>>> On Tue 14-02-23 11:34:30, Suren Baghdasaryan wrote:
> >>>> [...]
> >>>>> Your suggestion to have this limit configurable sounds like obvious
> >>>>> solution. I would like to get some opinions from other maintainers.
> >>>>> Johannes, WDYT? CC'ing Michal to chime in as well since this is mostly
> >>>>> related to memory stalls.
> >>>>
> >>>> I do not think that making this configurable helps much. Many users will
> >>>> be bound to distribution config and also it would be hard to experiment
> >>>> with a recompile cycle every time. This seems just too impractical.
> >>>>
> >>>> Is there any reason why we shouldn't allow any timeout? Shorter
> >>>> timeouts could be restricted to a priviledged context to avoid an easy
> >>>> way to swamp system by too frequent polling.
> >>>
> >>> Hmm, ok. Maybe then we just ensure that only privileged users can set
> >>> triggers and remove the min limit (use a >0 check)?
> >>
> >> This could break existing userspace which is not privileged. I would
> >> just go with CAP_SYS_NICE or similar with small (sub min) timeouts.
> >
> > Yeah, that's what I meant. /proc/pressure/* files already check for
> > CAP_SYS_RESOURCE
> > (https://urldefense.com/v3/__https://elixir.bootlin.com/linux/latest/source/kernel/sched/psi.c*L1440__;Iw!!GjvTz_vk!WtI61poYlZk9kg5P1sX19RdYnUNGvBJRjnOpu8hL6IOZ_NKhuw2qZ_tAdNRwzZoQVlO4jEObYN6x$ )
> > but per-cgroup pressure files do not have this check. I think the
> > original patch which added this check
> > (https://urldefense.com/v3/__https://lore.kernel.org/all/20210402025833.27599-1-johunt@akamai.com/__;!!GjvTz_vk!WtI61poYlZk9kg5P1sX19RdYnUNGvBJRjnOpu8hL6IOZ_NKhuw2qZ_tAdNRwzZoQVlO4jAVqIVDv$ )
> > missed the cgroup ones. This should be easy to add but I wonder if
> > that was left that way intentionally.
> >
> > CC'ing the author. Josh, Johannes is that inconsistency between system
> > pressure files and cgroup-specific ones intentional? Can we change
> > them all to check for CAP_SYS_RESOURCE?
>
> No, this was just an oversight in the original patch at least from my
> end, and did not come up during code review. Fine with me to change them
> all to use CAP_SYS_RESOURCE.

Thanks for the confirmation! Will get this fixed.

>
> Josh
>
> >
> >>
> >>>> Btw. it seems that there is is only a limit on a single trigger per fd
> >>>> but no limits per user so it doesn't sound too hard to end up with too
> >>>> much polling even with a larger timeouts. To me it seems like we need to
> >>>> contain the polling thread to be bound by the cpu controller.
> >>>
> >>> Hmm. We have one "psimon" thread per cgroup (+1 system-level one) and
> >>> poll_min_period for each thread is chosen as the min() of polling
> >>> periods between triggers created in that group. So, a bad trigger that
> >>> causes overly aggressive polling and polling thread being throttled,
> >>> might affect other triggers in that cgroup.
> >>
> >> Yes, and why that would be a problem?
> >
> > If unprivileged processes are allowed to add new triggers then a
> > malicious process can add a bad trigger and affect other legit
> > processes. That sounds like a problem to me.
> > Thanks,
> > Suren.
> >
> >> --
> >> Michal Hocko
> >> SUSE Labs
