Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D032E5FDE04
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 18:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbiJMQLP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 12:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiJMQLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 12:11:12 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CBC51D328
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 09:11:12 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 207so2621644ybn.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 09:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JbEHw5GFbGXxpSgTAnoCORfKnxkHkMtrjDyxiopNqeo=;
        b=Vs0zdDf+YlXV2kY/1lvhAR7EJT5XL2g6aiyRvdSoRRqIPc6GWZ7IV2xWwd8DXODgPC
         Blkggy4lFWwBBC0DhLn+p9UsZge/+ZIwBr7z4dZdyOdiqqolFFJu4HhAy7hBC0ZWqgDN
         ECifr1+KJDstL/uO5Oldb6Wf+PBKTAb6I9ilEdEQtB3rFy0U4EyUYiQN4iXAlsMwSCmT
         oR1d53wS87KXFRp4Btu6kctnLwQ7NTRNqk74dnqXHX1OcZSOKdV1lxCX44MVkoC7tJAu
         aFRBZ+hDYE+sXiR2hdJ/NkJmWl5OfRlSvTKJu2pDXDLxK0YCgiQ6q/Yc1hDE44fhvqLg
         f9oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JbEHw5GFbGXxpSgTAnoCORfKnxkHkMtrjDyxiopNqeo=;
        b=DKlLDce4AsBsBBrpLP6l3TWhTBrkX4S8Jov9WLBi4AIreoDv39RprsPUzNZsJgXOV7
         82OuM1z4cBKaEZvDrHe9DRlx5f9kW6B5kZnKwvlkTuRG6fc568lft2cYkDtUrzo0KIkQ
         6FoiJ8tK9vaRJs8FV9hMEZ220Wb6jza4J2csNNVJRbNBW5ZiZ4BPDWSErj0eI47+gBWG
         kNCBOjFFUOiKymDzjaVL/RFQN4DwVZmb+DYQ77t6TDDou1qBlLM7PDg6cRx3d51XRhJE
         0etblEEaVQpZOHhSZRgKy6ah29voo+GpI3fNqFB2FJoH1IZvohhWcpeU/WLN8SvZLLJq
         qr5A==
X-Gm-Message-State: ACrzQf190R3J3id2q0iS0yAIiBwuSaIsyxhnmgqRjonqGn3GIB8/Hp3c
        lCs7pKMdZcd0dT0cLeJ9ha4RLIsH13t6GmCdDyNTvA==
X-Google-Smtp-Source: AMsMyM4DmrkDR3btKtiIB+eg07zHuF3FShF5Ox2BA1d+GT0yoNZHKfD6ayR6dPAcFCco3XELADpbxUpPI6i0ccezdeg=
X-Received: by 2002:a25:e7c5:0:b0:6be:77c0:8830 with SMTP id
 e188-20020a25e7c5000000b006be77c08830mr679103ybh.340.1665677471018; Thu, 13
 Oct 2022 09:11:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220913140817.GA9091@hu-pkondeti-hyd.qualcomm.com>
 <20221010104206.12184-1-zhouchengming@bytedance.com> <CAJuCfpF7Z+CYhk-f_aaDTE232+m9z_n-QfjGfdLje7QrX9bFtw@mail.gmail.com>
 <a73f58a3-9f96-2ce5-38a0-8abab27a2260@bytedance.com> <CAJuCfpET+B3X-uX2vDp-2yH-+OVxOu3YXL7JWZrPuoh22P+5SQ@mail.gmail.com>
 <dea56c22-ab5b-25e2-9819-cc598f9aad80@bytedance.com> <CAJuCfpFTDyR1V+JYOY_uN6Xg1Nip5b=9dzkwm-CNd8vMWaQQFQ@mail.gmail.com>
 <46c6e1cc-77d3-eac1-fa18-deed2bac4a0e@bytedance.com> <Y0g0UAAJMhPczNm/@cmpxchg.org>
In-Reply-To: <Y0g0UAAJMhPczNm/@cmpxchg.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 13 Oct 2022 09:10:59 -0700
Message-ID: <CAJuCfpFo5EEEg24VLSmcPo=VDMszB9Q2a4L_Eq6E9VWnbsBJDQ@mail.gmail.com>
Subject: Re: [PATCH] sched/psi: Fix avgs_work re-arm in psi_avgs_work()
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Chengming Zhou <zhouchengming@bytedance.com>,
        quic_pkondeti@quicinc.com, peterz@infradead.org,
        quic_charante@quicinc.com, linux-kernel@vger.kernel.org
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

On Thu, Oct 13, 2022 at 8:52 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Thu, Oct 13, 2022 at 07:06:55PM +0800, Chengming Zhou wrote:
> > Should I still need to copy groupc->tasks[] out for the current_cpu as you
> > suggested before?
>
> It'd be my preference as well. This way the resched logic can be
> consolidated into a single block of comment + code at the end of the
> function.

Sounds good to me. If we are copying times in the retry loop then
let's move the `reschedule =` decision out of that loop completely. At
the end of get_recent_times we can do:

if (cpu == current_cpu)
    reschedule = tasks[NR_RUNNING] +
                            tasks[NR_IOWAIT] +
                            tasks[NR_MEMSTALL] > 1;
else
    reschedule = *pchanged_states & (1 << PSI_NONIDLE);


>
> > @@ -242,6 +242,8 @@ static void get_recent_times(struct psi_group *group, int cpu,
> >                              u32 *pchanged_states)
> >  {
> >         struct psi_group_cpu *groupc = per_cpu_ptr(group->pcpu, cpu);
> > +       int current_cpu = raw_smp_processor_id();
> > +       bool reschedule;
> >         u64 now, state_start;
> >         enum psi_states s;
> >         unsigned int seq;
> > @@ -256,6 +258,10 @@ static void get_recent_times(struct psi_group *group, int cpu,
> >                 memcpy(times, groupc->times, sizeof(groupc->times));
> >                 state_mask = groupc->state_mask;
> >                 state_start = groupc->state_start;
> > +               if (cpu == current_cpu)
> > +                       reschedule = groupc->tasks[NR_RUNNING] +
> > +                               groupc->tasks[NR_IOWAIT] +
> > +                               groupc->tasks[NR_MEMSTALL] > 1;
> >         } while (read_seqcount_retry(&groupc->seq, seq));
>
> This also matches psi_show() and the poll worker. They don't currently
> use the flag, but it's somewhat fragile and confusing. Add a test for
> current_work() == &group->avgs_work?

Good point. (tasks[NR_RUNNING] + tasks[NR_IOWAIT] + tasks[NR_MEMSTALL]
> 1) condition should also contain this check.
