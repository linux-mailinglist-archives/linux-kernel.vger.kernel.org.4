Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCA475F751C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 10:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbiJGIQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 04:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiJGIQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 04:16:47 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A835A0244
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 01:16:42 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id x6-20020a4ac586000000b0047f8cc6dbe4so3040445oop.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Oct 2022 01:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Di7HyMkQ1E5qdHPfa+7YWbbUBvN3xbsSG/cDo7IAkDM=;
        b=MrjLo8ie8GdfLRNcCwYP5fd4Q8VT22NK7ZwfJ17iLQAZJ9+7gATFex7M0FKKDUuR3p
         HZ0+65Ulq5X9CkhVjYINZ3IBF2bxUszQxbX2jltmOe0Q1T2gQZU9tCILNTD04E5H24AA
         LZtUbWi6BPJgVwbdob0xrdtB2q7zk3bTa75xQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Di7HyMkQ1E5qdHPfa+7YWbbUBvN3xbsSG/cDo7IAkDM=;
        b=uy6Lg2t4kvOQw6ADdhQRnByX0esZY10X+8X6LxKMGYV2yj/xk4pf0tdBLlekqaaqoZ
         mWZ4QwwiNnngmT/H5HffmCBurAq+QmBhThkNUPU6KSlAKJhew38vk/32nPo+eYJmsLIV
         ZYYgPm4Yjb24m9Cm/Aq/eqs3wSgXFTnVybxAoPmvnSCUL2cWcyMiw6gKrJUVNsvQ0/PS
         rgOH2oL+uGdTKoX7suXaALlCLpsYv36x/7ahHDEsWUxU5DTf/DqjNboV05C/wr8lEJSf
         OLYQKZaUaelxmqQpP57JJMcGa/zHcI6AvT/O4ILMmfsl/3kzoyVPOsf4TAQmHbBd6hZx
         XWsQ==
X-Gm-Message-State: ACrzQf2NCrW/64zpIE1a/cuLGPJZCRmvJt4Vmax4sz4zZenr/Q+Fgm5W
        36cLPQaPZrAkdoYZSy7vZYJ1wjTgQq7ZH/OFUcWk7A==
X-Google-Smtp-Source: AMsMyM6D/ujZCVrCawKe24O9hlJkW/1k8D/yf07qQC8qmpaJMrLx21hxKX6v+Ob9BOFyfWPYZ+C5z3wKbop+/7TtMbo=
X-Received: by 2002:a9d:7f14:0:b0:659:2de8:2148 with SMTP id
 j20-20020a9d7f14000000b006592de82148mr1575777otq.321.1665130601752; Fri, 07
 Oct 2022 01:16:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9tzs4n8dDQ_XVVPS_5jrBgsNkhDQvf-B_XmUg+EG_M2i4Q@mail.gmail.com>
 <CAHk-=whUp5Ufur6Bmv=H-rDDTNJJ-KVqOKkL+5FmR01jp0dbcA@mail.gmail.com>
 <CADnq5_Of-8ZyBxee0fZ=0x-eV-2NX_+e9sd-9nmuHdLugSHp2g@mail.gmail.com>
 <CAHk-=wi43xD06UgO2McDT3R=ze_aHgOGjcDOoggSwmQRv2kA+A@mail.gmail.com>
 <CADnq5_N0Ef+1VUoDLdpHfJXqZFuPYbx5Lq+94NWciHcQC+VrMg@mail.gmail.com>
 <CAPM=9tyAOnzwXyyPuoceZ1mimAkzxR-63YmKfVtcQX=swywNvg@mail.gmail.com> <CAHk-=wgghR4N-4XWjoK18NDkvjBL7i00ab8+otQg955pNGG_dQ@mail.gmail.com>
In-Reply-To: <CAHk-=wgghR4N-4XWjoK18NDkvjBL7i00ab8+otQg955pNGG_dQ@mail.gmail.com>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Fri, 7 Oct 2022 10:16:30 +0200
Message-ID: <CAKMK7uF_fKs=Ge5b3sCxa3YgWFaJsLBdCQVj+fDn6ukh9GvKKA@mail.gmail.com>
Subject: Re: [git pull] drm for 6.1-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Dave Airlie <airlied@gmail.com>,
        Alex Deucher <alexdeucher@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Oct 2022 at 01:45, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, Oct 6, 2022 at 1:25 PM Dave Airlie <airlied@gmail.com> wrote:
> >
> >
> > [ 1234.778760] BUG: kernel NULL pointer dereference, address: 0000000000000088
> > [ 1234.778813] RIP: 0010:drm_sched_job_done.isra.0+0xc/0x140 [gpu_sched]
>
> As far as I can tell, that's the line
>
>         struct drm_gpu_scheduler *sched = s_fence->sched;
>
> where 's_fence' is NULL. The code is
>
>    0: 0f 1f 44 00 00        nopl   0x0(%rax,%rax,1)
>    5: 41 54                push   %r12
>    7: 55                    push   %rbp
>    8: 53                    push   %rbx
>    9: 48 89 fb              mov    %rdi,%rbx
>    c:* 48 8b af 88 00 00 00 mov    0x88(%rdi),%rbp <-- trapping instruction
>   13: f0 ff 8d f0 00 00 00 lock decl 0xf0(%rbp)
>   1a: 48 8b 85 80 01 00 00 mov    0x180(%rbp),%rax
>
> and that next 'lock decl' instruction would have been the
>
>         atomic_dec(&sched->hw_rq_count);
>
> at the top of drm_sched_job_done().
>
> Now, as to *why* you'd have a NULL s_fence, it would seem that
> drm_sched_job_cleanup() was called with an active job. Looking at that
> code, it does
>
>         if (kref_read(&job->s_fence->finished.refcount)) {
>                 /* drm_sched_job_arm() has been called */
>                 dma_fence_put(&job->s_fence->finished);
>         ...
>
> but then it does
>
>         job->s_fence = NULL;
>
> anyway, despite the job still being active. The logic of that kind of
> "fake refcount" escapes me. The above looks fundamentally racy, not to
> say pointless and wrong (a refcount is a _count_, not a flag, so there
> could be multiple references to it, what says that you can just
> decrement one of them and say "I'm done").

Just figured I'll clarify this, because it's indeed a bit wtf and the
comment doesn't explain much. drm_sched_job_cleanup can be called both
when a real job is being cleaned up (which holds a full reference on
job->s_fence and needs to drop it) and to simplify error path in job
constructions (and the "is this refcount initialized already" signals
what exactly needs to be cleaned up or not). So no race, because the
only times this check goes different is when job construction has
failed before the job struct is visible by any other thread.

But yeah the comment could actually explain what's going on here :-)

And yeah the patch Dave reverted screws up the cascade of references
that ensures this all stays alive until drm_sched_job_cleanup is
called on active jobs, so looks all reasonable to me. Some Kunit tests
maybe to exercise these corners? Not the first time pure scheduler
code blew up, so proably worth the effort.
-Daniel

>
> Now, _why_ any of that happens, I have no idea. I'm just looking at
> the immediate "that pointer is NULL" thing, and reacting to what looks
> like a completely bogus refcount pattern.
>
> But that odd refcount pattern isn't new, so it's presumably some user
> on the amd gpu side that changed.
>
> The problem hasn't happened again for me, but that's not saying a lot,
> since it was very random to begin with.
>
>                  Linus



-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
