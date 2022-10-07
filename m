Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86B135F72E9
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 04:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbiJGCyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 22:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiJGCyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 22:54:17 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95097F250F
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 19:54:16 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id 13so8534120ejn.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 19:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7BJ07pRcl3Avz2E4m50XKKiT+ukopIQlySSEUmmOfEU=;
        b=ptsM2nV2M4uID1Lfj6HLPex4AKPvzirzSvIvIuKf+nyli2tnYh+udB9FoNMOv1etVN
         v8kor8R4nK3otQMxVyo8+jKzZQsE/ifap27c0dineLz4InDu1SBWKrDU5EuFQLxViQjt
         2Aylh3V2doU6WkCzn2D/lzqCuoe0EBLg3CE3zniPxSSSOLAK/ntE/NKF/KXwQSuRTBGB
         6BTkN12wO7t4J4Mra/7JX+hSnILW6al1e8yvNY9Wr/YURacTdG/qk58mKt49xuGrMMpY
         6aU+sjMxBbaM+nJOFg/Duvk5UuY+igj92zdWjtV39KptlF8SFSIpffLJpUAgGR2H9TMd
         eXfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7BJ07pRcl3Avz2E4m50XKKiT+ukopIQlySSEUmmOfEU=;
        b=zPtqUzzekoSaB4hg2LM5vAc8crkxaCghSXIZZRz+qG2JkW+ktSgk9r/EGpbFk8fD1B
         /lGaI98l9kkInHoCazqYKZbTA/7jzDzhnCfz9NHKZpaMerl37HYJK7dHfSYxUv2ToTXv
         8MbXIZcRw4OywWH8wtcL8eBYLW0W4mguJ4THgXV3BhUyRSKYLGmWXisjQVROzum8vx7h
         e+7lAoBmbSLUCJQIKvk0FARHfCg3XdXl3VP7XBdIr80TM4orUhJvz8FPCY2C3FopWcj0
         ZpcgWYg/PlHzShJ5gFCnVMsOZkyGypxtFU8JbTameKTFE2RM7UsgOcSHoDV2+HGap9tj
         +2vg==
X-Gm-Message-State: ACrzQf2mTdft1E1l+v/CXM6hNHntPyazehtBeQCIINUGmv+AXhWwtCm1
        Ne4vAlZskvrjcAjtSKa4mTUqn7HNyqJ69GpaVyg=
X-Google-Smtp-Source: AMsMyM7ZbtDGIl/pclBrS5W0uk2udidiYGccQscUBEzV8uZ78TM3vPDLITx95+JkHn4fc1iTqX2fczwY0EXHgbIkm94=
X-Received: by 2002:a17:906:eec7:b0:733:189f:b07a with SMTP id
 wu7-20020a170906eec700b00733189fb07amr2400505ejb.230.1665111254605; Thu, 06
 Oct 2022 19:54:14 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9tzs4n8dDQ_XVVPS_5jrBgsNkhDQvf-B_XmUg+EG_M2i4Q@mail.gmail.com>
 <CAHk-=whUp5Ufur6Bmv=H-rDDTNJJ-KVqOKkL+5FmR01jp0dbcA@mail.gmail.com>
 <CADnq5_Of-8ZyBxee0fZ=0x-eV-2NX_+e9sd-9nmuHdLugSHp2g@mail.gmail.com>
 <CAHk-=wi43xD06UgO2McDT3R=ze_aHgOGjcDOoggSwmQRv2kA+A@mail.gmail.com>
 <CADnq5_N0Ef+1VUoDLdpHfJXqZFuPYbx5Lq+94NWciHcQC+VrMg@mail.gmail.com>
 <CAPM=9tyAOnzwXyyPuoceZ1mimAkzxR-63YmKfVtcQX=swywNvg@mail.gmail.com>
 <CAHk-=wgghR4N-4XWjoK18NDkvjBL7i00ab8+otQg955pNGG_dQ@mail.gmail.com> <CAPM=9txE+0EH2Tv_0toDD52j0JO7iDZoJap6qmvMAnRaDRwJNg@mail.gmail.com>
In-Reply-To: <CAPM=9txE+0EH2Tv_0toDD52j0JO7iDZoJap6qmvMAnRaDRwJNg@mail.gmail.com>
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 7 Oct 2022 12:54:02 +1000
Message-ID: <CAPM=9tyjMUxAQnJJBVnXXc0tQTjywiK8PLxbJ_Jz4T_pcEospA@mail.gmail.com>
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

On Fri, 7 Oct 2022 at 12:45, Dave Airlie <airlied@gmail.com> wrote:
>
> On Fri, 7 Oct 2022 at 09:45, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Thu, Oct 6, 2022 at 1:25 PM Dave Airlie <airlied@gmail.com> wrote:
> > >
> > >
> > > [ 1234.778760] BUG: kernel NULL pointer dereference, address: 0000000=
000000088
> > > [ 1234.778813] RIP: 0010:drm_sched_job_done.isra.0+0xc/0x140 [gpu_sch=
ed]
> >
> > As far as I can tell, that's the line
> >
> >         struct drm_gpu_scheduler *sched =3D s_fence->sched;
> >
> > where 's_fence' is NULL. The code is
> >
> >    0: 0f 1f 44 00 00        nopl   0x0(%rax,%rax,1)
> >    5: 41 54                push   %r12
> >    7: 55                    push   %rbp
> >    8: 53                    push   %rbx
> >    9: 48 89 fb              mov    %rdi,%rbx
> >    c:* 48 8b af 88 00 00 00 mov    0x88(%rdi),%rbp <-- trapping instruc=
tion
> >   13: f0 ff 8d f0 00 00 00 lock decl 0xf0(%rbp)
> >   1a: 48 8b 85 80 01 00 00 mov    0x180(%rbp),%rax
> >
> > and that next 'lock decl' instruction would have been the
> >
> >         atomic_dec(&sched->hw_rq_count);
> >
> > at the top of drm_sched_job_done().
> >
> > Now, as to *why* you'd have a NULL s_fence, it would seem that
> > drm_sched_job_cleanup() was called with an active job. Looking at that
> > code, it does
> >
> >         if (kref_read(&job->s_fence->finished.refcount)) {
> >                 /* drm_sched_job_arm() has been called */
> >                 dma_fence_put(&job->s_fence->finished);
> >         ...
> >
> > but then it does
> >
> >         job->s_fence =3D NULL;
> >
> > anyway, despite the job still being active. The logic of that kind of
> > "fake refcount" escapes me. The above looks fundamentally racy, not to
> > say pointless and wrong (a refcount is a _count_, not a flag, so there
> > could be multiple references to it, what says that you can just
> > decrement one of them and say "I'm done").
> >
> > Now, _why_ any of that happens, I have no idea. I'm just looking at
> > the immediate "that pointer is NULL" thing, and reacting to what looks
> > like a completely bogus refcount pattern.
> >
> > But that odd refcount pattern isn't new, so it's presumably some user
> > on the amd gpu side that changed.
> >
> > The problem hasn't happened again for me, but that's not saying a lot,
> > since it was very random to begin with.
>
> I chased down the culprit to a drm sched patch, I'll send you a pull
> with a revert in it.
>
> commit e4dc45b1848bc6bcac31eb1b4ccdd7f6718b3c86
> Author: Arvind Yadav <Arvind.Yadav@amd.com>
> Date:   Wed Sep 14 22:13:20 2022 +0530
>
>     drm/sched: Use parent fence instead of finished
>
>     Using the parent fence instead of the finished fence
>     to get the job status. This change is to avoid GPU
>     scheduler timeout error which can cause GPU reset.
>
>     Signed-off-by: Arvind Yadav <Arvind.Yadav@amd.com>
>     Reviewed-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
>     Link: https://patchwork.freedesktop.org/patch/msgid/20220914164321.21=
56-6-Arvind.Yadav@amd.com
>     Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> I'll let Arvind and Christian maybe work out what is going wrong there.

I do spy two changes queued for -next that might be relevant, so I
might try just pulling those instead.

I'll send a PR in next hour once I test it.

Dave.
