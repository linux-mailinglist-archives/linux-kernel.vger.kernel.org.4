Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CCFF69E67F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 18:55:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232787AbjBURzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 12:55:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbjBURzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 12:55:52 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D79792DE66;
        Tue, 21 Feb 2023 09:55:29 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id e21so5397324oie.1;
        Tue, 21 Feb 2023 09:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xv2uXYHt3XeROXyJVL9lk52fVmsfLTFU5mqvJC9GYu4=;
        b=MhVB0NJNs21YP6mxc5cr02QCii/6IswZclKK87JSAP6SkTvs9pBd4T1VG0NGWeKOqn
         khNHQFzG9sv5NWCllEUe045lNPhbXKoS5hJpFJEOw0pb/hb9rxIOY5mdDfr95+wZJoKJ
         wdkFsLjnOsG5IzJO6BFsGAfqli+GQYGm5jfBJCtSIeTNWhtsTelZ1FZzANQX5TuFfI5b
         uRtl4Q9C7kbV5tR7hBfdO9f4th/zmVjuvbBgCh9zAwAPHmb68tnTuBFWDHtJlkQtMN2e
         u/NqNnndQi2evJpRyuAgtqBxtD7jsrq1LpjnfjcXkEHq9eWAdvGyaWRWWiLlUMKq0HWD
         8mVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xv2uXYHt3XeROXyJVL9lk52fVmsfLTFU5mqvJC9GYu4=;
        b=ahRznUbEphdl/T+AnXSmH6d9lksn0g9aRnlWOtjJwcy5tffQBylWrMyofnB1eDwx0O
         myHWwfaiwslPpPs4R0dseSJoIAGu/AFnPvY5+vOrI7Mrcf8/lHLDepu87Lcn/tXzmssI
         +zMLncOuUDftefTrOlgr2jXfDUDAfVn4Xz1BlKfmOvYAVOhpjTK2b7Qyzb8RAmIKFEE5
         T7YRr/KxrqIKCq+6UPifdof/ChudM5ueAXVHfwhZZm2Sm2341UVnxOT1raXlqCjxRzCQ
         Sl+GxddQ6IGCFwc4MofZLyLEpFmVi8Vs4yOA0volJxdboKvO7O+VUgYOhDDjDtO4L54W
         Wpbg==
X-Gm-Message-State: AO0yUKWnsOCHG72Q57j8J0sIui6KMKykUHjh/p49slwspRN0JlWPfMNP
        QmVcVndBXp+x43B1wrWavfH9iJn0CeuoMT597pc=
X-Google-Smtp-Source: AK7set+3plPstNNrlEwndFRmB7Ghv+pP145J/q5VwaYQKMVG1IyDbrvqIsIdzdj2oJvtdlMI0LV5ATP51GZWdQwW8zg=
X-Received: by 2002:a05:6808:ec7:b0:364:c0a5:1fcf with SMTP id
 q7-20020a0568080ec700b00364c0a51fcfmr1405745oiv.58.1677002122311; Tue, 21 Feb
 2023 09:55:22 -0800 (PST)
MIME-Version: 1.0
References: <20230218211608.1630586-1-robdclark@gmail.com> <20230218211608.1630586-7-robdclark@gmail.com>
 <20230220105345.70e46fa5@eldfell> <CAF6AEGv9fLQCD65ytRTGp=EkNB1QoZYH5ArphgGQALV9J08Cmw@mail.gmail.com>
 <20230221103753.205082d3@eldfell> <CA+hFU4xexaHAYsbGm6PdNfVFHBgOS4WiMo=AU0Gi5cYt566aTg@mail.gmail.com>
In-Reply-To: <CA+hFU4xexaHAYsbGm6PdNfVFHBgOS4WiMo=AU0Gi5cYt566aTg@mail.gmail.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Tue, 21 Feb 2023 09:55:12 -0800
Message-ID: <CAF6AEGvXJkmwn8M6ThCx0bLwDFqqHmjp5fkDuDa7g2e8i3eM_w@mail.gmail.com>
Subject: Re: [PATCH v4 06/14] dma-buf/sync_file: Support (E)POLLPRI
To:     Sebastian Wick <sebastian.wick@redhat.com>
Cc:     Pekka Paalanen <ppaalanen@gmail.com>,
        Rob Clark <robdclark@chromium.org>,
        Gustavo Padovan <gustavo@padovan.org>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
        =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>,
        open list <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        freedreno@lists.freedesktop.org,
        Sumit Semwal <sumit.semwal@linaro.org>,
        "open list:SYNC FILE FRAMEWORK" <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2023 at 8:01 AM Sebastian Wick
<sebastian.wick@redhat.com> wrote:
>
> On Tue, Feb 21, 2023 at 9:38 AM Pekka Paalanen <ppaalanen@gmail.com> wrote:
> >
> > On Mon, 20 Feb 2023 08:14:47 -0800
> > Rob Clark <robdclark@gmail.com> wrote:
> >
> > > On Mon, Feb 20, 2023 at 12:53 AM Pekka Paalanen <ppaalanen@gmail.com> wrote:
> > > >
> > > > On Sat, 18 Feb 2023 13:15:49 -0800
> > > > Rob Clark <robdclark@gmail.com> wrote:
> > > >
> > > > > From: Rob Clark <robdclark@chromium.org>
> > > > >
> > > > > Allow userspace to use the EPOLLPRI/POLLPRI flag to indicate an urgent
> > > > > wait (as opposed to a "housekeeping" wait to know when to cleanup after
> > > > > some work has completed).  Usermode components of GPU driver stacks
> > > > > often poll() on fence fd's to know when it is safe to do things like
> > > > > free or reuse a buffer, but they can also poll() on a fence fd when
> > > > > waiting to read back results from the GPU.  The EPOLLPRI/POLLPRI flag
> > > > > lets the kernel differentiate these two cases.
> > > > >
> > > > > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > > >
> > > > Hi,
> > > >
> > > > where would the UAPI documentation of this go?
> > > > It seems to be missing.
> > >
> > > Good question, I am not sure.  The poll() man page has a description,
> > > but my usage doesn't fit that _exactly_ (but OTOH the description is a
> > > bit vague).
> > >
> > > > If a Wayland compositor is polling application fences to know which
> > > > client buffer to use in its rendering, should the compositor poll with
> > > > PRI or not? If a compositor polls with PRI, then all fences from all
> > > > applications would always be PRI. Would that be harmful somehow or
> > > > would it be beneficial?
> > >
> > > I think a compositor would rather use the deadline ioctl and then poll
> > > without PRI.  Otherwise you are giving an urgency signal to the fence
> > > signaller which might not necessarily be needed.
> > >
> > > The places where I expect PRI to be useful is more in mesa (things
> > > like glFinish(), readpix, and other similar sorts of blocking APIs)
> >
> > Sounds good. Docs... ;-)
> >
> > Hmm, so a compositor should set the deadline when it processes the
> > wl_surface.commit, and not when it actually starts repainting, to give
> > time for the driver to react and the GPU to do some more work. The
> > deadline would be the time when the compositor starts its repaint, so
> > it knows if the buffer is ready or not.
>
> Technically we don't know when the commit is supposed to be shown.
> Just passing a deadline of the next possible deadline however is
> probably a good enough guess for this feature to be useful.
>
> One thing that neither API allows us to do is tell the kernel in
> advance when we're going to submit work and what the deadline for it
> is and unfortunately that work is the most timing sensitive.

Presumably you are talking about the final compositing step?
Elsewhere in this series that atomic wait-for-fences step sets the
deadline hint.

BR,
-R

> >
> >
> > Thanks,
> > pq
> >
> >
> > >
> > > BR,
> > > -R
> > >
> > > >
> > > >
> > > > Thanks,
> > > > pq
> > > >
> > > > > ---
> > > > >  drivers/dma-buf/sync_file.c | 8 ++++++++
> > > > >  1 file changed, 8 insertions(+)
> > > > >
> > > > > diff --git a/drivers/dma-buf/sync_file.c b/drivers/dma-buf/sync_file.c
> > > > > index fb6ca1032885..c30b2085ee0a 100644
> > > > > --- a/drivers/dma-buf/sync_file.c
> > > > > +++ b/drivers/dma-buf/sync_file.c
> > > > > @@ -192,6 +192,14 @@ static __poll_t sync_file_poll(struct file *file, poll_table *wait)
> > > > >  {
> > > > >       struct sync_file *sync_file = file->private_data;
> > > > >
> > > > > +     /*
> > > > > +      * The POLLPRI/EPOLLPRI flag can be used to signal that
> > > > > +      * userspace wants the fence to signal ASAP, express this
> > > > > +      * as an immediate deadline.
> > > > > +      */
> > > > > +     if (poll_requested_events(wait) & EPOLLPRI)
> > > > > +             dma_fence_set_deadline(sync_file->fence, ktime_get());
> > > > > +
> > > > >       poll_wait(file, &sync_file->wq, wait);
> > > > >
> > > > >       if (list_empty(&sync_file->cb.node) &&
> > > >
> >
>
