Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8474E5F7304
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 05:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbiJGDEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 23:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbiJGDE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 23:04:27 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93482183EE3
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 20:04:14 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id m3so5248350eda.12
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 20:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zlufUvcTl53m53oE5xB5PXOllaUOdrwjgIC90thE/io=;
        b=LVnU3UlAR3DYyoQd/CiOz5ecP6dygUnUf69JNNWH9PnL2BiVyhKuDpabNGCrz9Kca/
         MFjKllaXfvETU8gyvXQTkWLxtbfqPJWaHKk6o5G9PkPFLQXJLOOzhvQMgczdg8sf4zZA
         t4dlqOTGNtcKNR976BgvdMJJDkzxr891JDfJiR6dFarLDkZgKrypFyufcyRtHfl2DYnb
         ZI789Tz0TwJDoahmyGR3f1xbofKgEBxbyhxkpDnjk9lGHurHTCKDSt3z3fntmp0ImLWr
         66jakitSLQByExrx3RJVjG9vxZPxo7KaQ2/W84t3341/GJYtbG8OymB+NoO8ntkUUkb7
         bBQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zlufUvcTl53m53oE5xB5PXOllaUOdrwjgIC90thE/io=;
        b=fDB2nHMYSbgWZP0k479xiRNVcEQ/be1BAjNaNfzH8pk7w1dMbjBk72w0GbrSxkndbd
         NGE1aZNMbeXLH5f/9wkKKBQ9Fpnj2H36XShwC2pgu8FPPfvUZGSD0B7arFCTTJU+6oAH
         XTLPOist1hfkssKI5NBc+xE0CPvTNz+eS5S4oK/fs4940jRfAbH0itcY8mDPGOZYgdnM
         LPK8e63aVMe0Fz1QMxyO4cuoqzc9c+xZda+hLl6mf+v0cJy8ROqW1o8xt7L61pE6H0jS
         dyhr0RoRBHR0Fbgetg/m897foQOPUTQWLt7PNTROQIrQibR/4laLjmGdyrIHpBqQLln6
         zD0A==
X-Gm-Message-State: ACrzQf0YOBcOegcINK4tlkesKPjEdeRSNGXqNgr+Cnhf4vRSlEFQ2SfB
        Ube4GIxIq8xiZzjBENW6LiSMxJZ8UPSMRShQSi0=
X-Google-Smtp-Source: AMsMyM47XAQlYaLZcsDsLfx56FRWaRBrhWuNzasfS+m/yCUUe14POUIaVrTgrfmWQL66UFJVrsn/1BudHqzfng9nv0U=
X-Received: by 2002:a05:6402:51cb:b0:459:f3f9:2a20 with SMTP id
 r11-20020a05640251cb00b00459f3f92a20mr2534176edd.74.1665111852653; Thu, 06
 Oct 2022 20:04:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9tzs4n8dDQ_XVVPS_5jrBgsNkhDQvf-B_XmUg+EG_M2i4Q@mail.gmail.com>
 <CAHk-=whUp5Ufur6Bmv=H-rDDTNJJ-KVqOKkL+5FmR01jp0dbcA@mail.gmail.com>
 <CADnq5_Of-8ZyBxee0fZ=0x-eV-2NX_+e9sd-9nmuHdLugSHp2g@mail.gmail.com>
 <CAHk-=wi43xD06UgO2McDT3R=ze_aHgOGjcDOoggSwmQRv2kA+A@mail.gmail.com>
 <CADnq5_N0Ef+1VUoDLdpHfJXqZFuPYbx5Lq+94NWciHcQC+VrMg@mail.gmail.com>
 <CAPM=9tyAOnzwXyyPuoceZ1mimAkzxR-63YmKfVtcQX=swywNvg@mail.gmail.com>
 <CAHk-=wgghR4N-4XWjoK18NDkvjBL7i00ab8+otQg955pNGG_dQ@mail.gmail.com>
 <CAPM=9txE+0EH2Tv_0toDD52j0JO7iDZoJap6qmvMAnRaDRwJNg@mail.gmail.com> <CAPM=9tyjMUxAQnJJBVnXXc0tQTjywiK8PLxbJ_Jz4T_pcEospA@mail.gmail.com>
In-Reply-To: <CAPM=9tyjMUxAQnJJBVnXXc0tQTjywiK8PLxbJ_Jz4T_pcEospA@mail.gmail.com>
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 7 Oct 2022 13:03:59 +1000
Message-ID: <CAPM=9tx+mxGphfr7TuUtXz_YgcFDrRi1oq0EhNU+UdmPPGDdUQ@mail.gmail.com>
Subject: Re: [git pull] drm for 6.1-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Arvind.Yadav@amd.com
Cc:     Alex Deucher <alexdeucher@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Oct 2022 at 12:54, Dave Airlie <airlied@gmail.com> wrote:
>
> On Fri, 7 Oct 2022 at 12:45, Dave Airlie <airlied@gmail.com> wrote:
> >
> > On Fri, 7 Oct 2022 at 09:45, Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> > >
> > > On Thu, Oct 6, 2022 at 1:25 PM Dave Airlie <airlied@gmail.com> wrote:
> > > >
> > > >
> > > > [ 1234.778760] BUG: kernel NULL pointer dereference, address: 00000=
00000000088
> > > > [ 1234.778813] RIP: 0010:drm_sched_job_done.isra.0+0xc/0x140 [gpu_s=
ched]
> > >
> > > As far as I can tell, that's the line
> > >
> > >         struct drm_gpu_scheduler *sched =3D s_fence->sched;
> > >
> > > where 's_fence' is NULL. The code is
> > >
> > >    0: 0f 1f 44 00 00        nopl   0x0(%rax,%rax,1)
> > >    5: 41 54                push   %r12
> > >    7: 55                    push   %rbp
> > >    8: 53                    push   %rbx
> > >    9: 48 89 fb              mov    %rdi,%rbx
> > >    c:* 48 8b af 88 00 00 00 mov    0x88(%rdi),%rbp <-- trapping instr=
uction
> > >   13: f0 ff 8d f0 00 00 00 lock decl 0xf0(%rbp)
> > >   1a: 48 8b 85 80 01 00 00 mov    0x180(%rbp),%rax
> > >
> > > and that next 'lock decl' instruction would have been the
> > >
> > >         atomic_dec(&sched->hw_rq_count);
> > >
> > > at the top of drm_sched_job_done().
> > >
> > > Now, as to *why* you'd have a NULL s_fence, it would seem that
> > > drm_sched_job_cleanup() was called with an active job. Looking at tha=
t
> > > code, it does
> > >
> > >         if (kref_read(&job->s_fence->finished.refcount)) {
> > >                 /* drm_sched_job_arm() has been called */
> > >                 dma_fence_put(&job->s_fence->finished);
> > >         ...
> > >
> > > but then it does
> > >
> > >         job->s_fence =3D NULL;
> > >
> > > anyway, despite the job still being active. The logic of that kind of
> > > "fake refcount" escapes me. The above looks fundamentally racy, not t=
o
> > > say pointless and wrong (a refcount is a _count_, not a flag, so ther=
e
> > > could be multiple references to it, what says that you can just
> > > decrement one of them and say "I'm done").
> > >
> > > Now, _why_ any of that happens, I have no idea. I'm just looking at
> > > the immediate "that pointer is NULL" thing, and reacting to what look=
s
> > > like a completely bogus refcount pattern.
> > >
> > > But that odd refcount pattern isn't new, so it's presumably some user
> > > on the amd gpu side that changed.
> > >
> > > The problem hasn't happened again for me, but that's not saying a lot=
,
> > > since it was very random to begin with.
> >
> > I chased down the culprit to a drm sched patch, I'll send you a pull
> > with a revert in it.
> >
> > commit e4dc45b1848bc6bcac31eb1b4ccdd7f6718b3c86
> > Author: Arvind Yadav <Arvind.Yadav@amd.com>
> > Date:   Wed Sep 14 22:13:20 2022 +0530
> >
> >     drm/sched: Use parent fence instead of finished
> >
> >     Using the parent fence instead of the finished fence
> >     to get the job status. This change is to avoid GPU
> >     scheduler timeout error which can cause GPU reset.
> >
> >     Signed-off-by: Arvind Yadav <Arvind.Yadav@amd.com>
> >     Reviewed-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> >     Link: https://patchwork.freedesktop.org/patch/msgid/20220914164321.=
2156-6-Arvind.Yadav@amd.com
> >     Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> >
> > I'll let Arvind and Christian maybe work out what is going wrong there.
>
> I do spy two changes queued for -next that might be relevant, so I
> might try just pulling those instead.
>
> I'll send a PR in next hour once I test it.

Okay sent, let me know if you see any further problems.

Dave.
