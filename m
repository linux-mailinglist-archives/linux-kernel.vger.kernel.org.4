Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 370056CF289
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 20:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbjC2SzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 14:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjC2SzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 14:55:12 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B0EA59C3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 11:55:11 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id bt19so10962368pfb.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 11:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680116111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s65pek4c9F8F1IUq6s0HRCrP/S2SEGnM8CsfinkVEW4=;
        b=lv2vUrI7LJeVwW/VIrOk784T7AInX2IXFdViL0IuIYnjQLEJCUAA0YSDTWscuK51xb
         l7nZ4HgWuLDBY9CJf+qyhqEEZbNf/TPWPGE08Jbj0sBbclT4NlceSxJRDFEsmp+1YSJO
         ZGGQsm/tgDHPDG/8xis1kBqZjBbTcfUZWaxFXJhG1qRRqF2n8ZBn3MIsVX/UiWtZFHb7
         cH4DIU5Fq1OejrXH6OGIByU3tcT3G9l6ffygFphkQJhdwJvFVS8azjcPjTWMxvNtkIN1
         6bD06ndF3Z/E7JSMo7InZIy2RFGm+eYUC5X0IVynXJqmhCAnLU5ldsG/6BT8aEQjTB02
         WWoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680116111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s65pek4c9F8F1IUq6s0HRCrP/S2SEGnM8CsfinkVEW4=;
        b=BrWnl7Fycl35lqSrQYEnLw/3y6eRU0fvcu+UmUSMpgLGeeMJnstichOMG6rtiVN2Ql
         nq90VAqx/Rl3TE6rzm9zjQsT7XebR0Hq1VFciZffLBfjAr9pHJyti9FSFfWmYEKajMG5
         2OI8cIs8tXKmdINhWAbUgVoqbpdM2jjXiyNW9O4lVmI/GVBi40C3Mg3Wdgazx/A6DeTq
         q/jB+LBTx2BGkFLbw5wNhJUyxRRYjRGRiS1tpvptKlLF9W9C2oGXvm8ay4ZMCkL33DXE
         IMyFJXtTV7GZKoH1G16QNw2aTkRVPrxYNCXxy28dEdqv+cdZRtDCkUhTKWmFmPoln/+N
         swyw==
X-Gm-Message-State: AAQBX9dXy+mWUSqJvvQ+gEoJ7q8530ilNK2f87a9btfOaz/L7qCNvDby
        rbWbEKIsWTRykJRW7+O76LjOlnp7fq3+xsaEiQEWag==
X-Google-Smtp-Source: AKy350a4RmG1zoCEmMfxRrf3HRTd4it+NhEceI4OkTUNS/O69iv3yNgR9x/qkvnTGuG1smvQOb/sweodkxCbTBpRdhs=
X-Received: by 2002:a05:6a00:1a03:b0:623:8990:4712 with SMTP id
 g3-20020a056a001a0300b0062389904712mr10777024pfv.1.1680116110606; Wed, 29 Mar
 2023 11:55:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230328092622.062917921@infradead.org> <20230328110354.141543852@infradead.org>
 <CABk29Nt4T67S+L9Qs1qeOUyo5gY1Qy5KuOwuCYNM74E58J81Eg@mail.gmail.com> <20230329081239.GM4253@hirez.programming.kicks-ass.net>
In-Reply-To: <20230329081239.GM4253@hirez.programming.kicks-ass.net>
From:   Josh Don <joshdon@google.com>
Date:   Wed, 29 Mar 2023 11:54:58 -0700
Message-ID: <CABk29Nud5dBo9ZdYhPLAPiVtQ9qh8aPOytydp7EXa-rYyYaMHA@mail.gmail.com>
Subject: Re: [PATCH 08/17] sched/fair: Implement an EEVDF like policy
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, corbet@lwn.net,
        qyousef@layalina.io, chris.hyser@oracle.com,
        patrick.bellasi@matbug.net, pjt@google.com, pavel@ucw.cz,
        qperret@google.com, tim.c.chen@linux.intel.com, timj@gnu.org,
        kprateek.nayak@amd.com, yu.c.chen@intel.com,
        youssefesmat@chromium.org, joel@joelfernandes.org, efault@gmx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2023 at 1:12=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Tue, Mar 28, 2023 at 06:26:51PM -0700, Josh Don wrote:
>
> > > @@ -5088,19 +5307,20 @@ dequeue_entity(struct cfs_rq *cfs_rq, st
> > >  static void
> > >  check_preempt_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr)
> > >  {
> > > -       unsigned long ideal_runtime, delta_exec;
> > > +       unsigned long delta_exec;
> > >         struct sched_entity *se;
> > >         s64 delta;
> > >
> > > -       /*
> > > -        * When many tasks blow up the sched_period; it is possible t=
hat
> > > -        * sched_slice() reports unusually large results (when many t=
asks are
> > > -        * very light for example). Therefore impose a maximum.
> > > -        */
> > > -       ideal_runtime =3D min_t(u64, sched_slice(cfs_rq, curr), sysct=
l_sched_latency);
> > > +       if (sched_feat(EEVDF)) {
> > > +               if (pick_eevdf(cfs_rq) !=3D curr)
> > > +                       goto preempt;
> >
> > This could shortcircuit the loop in pick_eevdf once we find a best
> > that has less vruntime and sooner deadline than curr, since we know
> > we'll never pick curr in that case. Might help performance when we
> > have a large tree for this cfs_rq.
>
> Yeah, one of the things I did consider was having this set cfs_rq->next
> such that the reschedule pick doesn't have to do the pick again. But I
> figured keep things simple for now.

Yea that makes sense. I was thinking something similar along the lines
of cfs_rq->next as another way to avoid duplicate computation. But
agreed this can be a future optimization.
