Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A34461A348
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 22:25:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbiKDVZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 17:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiKDVZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 17:25:31 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A9AC42F59
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 14:25:30 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id d20so8103515ljc.12
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 14:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=f40ycD3M0cPuCeorIP+f303JznbkUgxerT50R4qgQuE=;
        b=Oyy4gprWjs4sKqpFVDor4ri+tgZ8y6TQIyss6JtexWEiNeFvTEU+A2SgglGHNZLTLb
         EGJWLyuRoJwi+jl3eQ2539UjeOmytoqTmlFddtFfTLMz2jTansO3d51tYRhEeVQ3aYSb
         RbletDj0Hh0DhA4XMwCE8Rq54dbLnvcnEqxzaHQ+IEPSmpCPomHr6rh4SfkM86ol3SLF
         0pv+ied5MxKTZw+5oSDh1IgqOD5iQ/qvLvG+cYVjvCqZ015EGI5AY9UCoZF7OShttEA5
         dXNl1jOT9TnoECnkc1cplfVvIUkLnAJd/KiRif40FgPm8eQrXOP20mQ5A2ILR5giqEG7
         qjFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f40ycD3M0cPuCeorIP+f303JznbkUgxerT50R4qgQuE=;
        b=dHlTVqvzXOXSDsFyMo67B8kKIdHQv9agA+Kft4sMjpjMahUoxpUaHvGsZl4s8455l1
         SPAA9KkO2vXtwGOod8ehQ7gm2xuxI0PyWvTVgueJBds6l4TAvEvsUtrRJeLMmkyaSaF1
         FdIor/iYn5Zx+ca93L/Gi+eXabCzzuiVmVnYr63XfXTakv8SWLFESQ9mKDi66SF291c0
         pJvlgYRN1jB2CTSrF8WHFIjg/2GtW92HR2JC09lYDHElwGHnb1Lk1JNEUBxQksFxQBgj
         9pR//hGWzKz6Ymm8iGgvNcYa8chY9rC2P15gkOWBCp8RFno5NpmlfFsQADlqeJSQ80ps
         5EHg==
X-Gm-Message-State: ACrzQf0Ylvgs47swV3WK/C7WWUw4GXPuLwMv9IMjmRzqBZIluDArRXyC
        aiay0nBdVO8w3vVcXSi2xtVMS+TOPE+K5z8xHTLbrmyoCrE=
X-Google-Smtp-Source: AMsMyM6Y2iyFH+N8Tc4W3XR3HmW6gfgYx+6L23yBCQX7u1wdrhJvIxxs01Cc+u+1cqZOF/g4eMbqoDaJVM+EKItQFbE=
X-Received: by 2002:a2e:3e14:0:b0:277:a3b:49dd with SMTP id
 l20-20020a2e3e14000000b002770a3b49ddmr13041085lja.342.1667597128622; Fri, 04
 Nov 2022 14:25:28 -0700 (PDT)
MIME-Version: 1.0
References: <20221027081630.34081-1-zhouchuyi@bytedance.com>
 <CABk29NtDny9qKZbZZ_i8Brwjtqs5GA0G4_SffzK4HzG3RrXVhQ@mail.gmail.com>
 <64d963b6-2d9c-3f93-d427-a1ff705fb65a@bytedance.com> <CABk29NsbGuMPcA8NJagMfPyHij3864F3DVQ6wpCj3UAo8tbFNQ@mail.gmail.com>
 <5af26ac9-3bdb-32d2-77a7-6cd8feca97aa@bytedance.com> <CABk29Nt38d31LnazbcSVB036jUYemC1KRpR2Dn7YgLmXkp-QBQ@mail.gmail.com>
 <8142b5db-f543-57e6-0f68-f62274c0e379@bytedance.com> <CABk29Nsnx=PfeLMEsD0qsnh5-QTHLT4xVB3HmBgGAqqmWnkmvg@mail.gmail.com>
 <eae73b1a-cd28-e87a-e487-bd0d95b5655e@bytedance.com>
In-Reply-To: <eae73b1a-cd28-e87a-e487-bd0d95b5655e@bytedance.com>
From:   Josh Don <joshdon@google.com>
Date:   Fri, 4 Nov 2022 14:25:16 -0700
Message-ID: <CABk29Nuy553ns58g32vvjEXeDNbnv=zq87qPrdyKDOAnjMGVmg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] sched/fair: favor non-idle group in tick preemption
To:     Hao Jia <jiahao.os@bytedance.com>
Cc:     Chuyi Zhou <zhouchuyi@bytedance.com>, peterz@infradead.org,
        juri.lelli@redhat.com, mingo@redhat.com,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        Abel Wu <wuyun.abel@bytedance.com>
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

On Thu, Nov 3, 2022 at 8:49 PM Hao Jia <jiahao.os@bytedance.com> wrote:
>
>
>
> On 2022/11/2 Josh Don wrote:
> >>> Some weirdness about this change though, is that if there is a
> >>> non-idle current entity, and the two next entities on the cfs_rq are
> >>> idle and non-idle respectively, we'll now take longer to preempt the
> >>> on-cpu non-idle entity, because the non-idle entity on the cfs_rq is
> >>> 'hidden' by the idle 'first' entity. Wakeup preemption is different
> >>> because we're always directly comparing the current entity with the
> >>> newly woken entity.
> >>>
> >> You are right, this can happen with high probability.
> >> This patch just compared the curr with the first entity in
> >> the tick, and it seems hard to consider all the other entity
> >> in cfs_rq.
> >>
> >> So, what specific negative effects this situation would cause?
> >> For example, the "hidden" non-idle entity's latency will be worse
> >> than before?
> >
> > As Abel points out in his email, it can push out the time it'll take
> > to switch to the other non-idle entity. The change might boost some
> > benchmarks numbers, but I don't think it is conclusive enough to say
> > it is a generically beneficial improvement that should be integrated.
> >
> > By the way, I'm curious if you modified any of the sched_idle_cpu()
> > and related load balancing around idle entities given that you've made
> > it so that idle entities can have arbitrary weight (since, as I
> > described in my prior email, this can otherwise cause issues there).
>
> If we want to make it easier for non-idle tasks to preempt idle tasks in
> tick, maybe we can consider lowering sysctl_sched_idle_min_granularity.
> Of course this may not ensure that non-idle tasks successfully preempt
> idle tasks every time, but it seems to be more beneficial for non-idle
> tasks.
>
> IMHO, even if it is allowed to increase the weight of non-idle, it seems
> that we can make it easier for non-idle tasks to preempt idle tasks by
> lowering sysctl_sched_idle_min_granularity.

Yep, although the effectiveness is partially limited by whatever the
HZ is set to for the scheduling tick.

>
> Thanks,
> Hao
