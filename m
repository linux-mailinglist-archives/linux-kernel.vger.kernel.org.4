Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9077D65EF4A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 15:51:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233530AbjAEOv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 09:51:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234211AbjAEOvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 09:51:09 -0500
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DCDBE50;
        Thu,  5 Jan 2023 06:51:08 -0800 (PST)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-15085b8a2f7so18364562fac.2;
        Thu, 05 Jan 2023 06:51:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=24UNF4Nyk0Kbxc7GRNV5skO81MTN7TJ8OcXlAfM9Q8g=;
        b=iAyGq3FS9YpAvZ2C88B0Xfx5QtyULHmECESrxMpN5n2oRbK33Q73iZsy6WcBEZDNAU
         9hmnDzdNgdXQYXVfhmDHLzcAo/bAYrkN2LpE6rI7mK8XIsB9sNL+dkcsg/zXC7vr4WjS
         ylVsRYApEkcBDxBKhIYFVg3zRdVXROy06qvtHk283x2ephk9aWZItZnc7lJ+7PEV2QKp
         uQP6vGOS6mw7w0mcxNOyBuJQhEONZ6cHU/z7kOlc9i6ws130exGe801fhkQJfER0Sgwd
         giEDRmOw8SdRINDhUzAX1q5ViIvvMRSBgHNRfHmwAj59kk/cMXRt8JAuPYch8TNt9HVJ
         FiJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=24UNF4Nyk0Kbxc7GRNV5skO81MTN7TJ8OcXlAfM9Q8g=;
        b=oI8MbQOzKkTl4Lat6udmykfaHP1QpObQ8T5kzBTSiG+HlLTwTkIZpFLJZVrqDXTWwD
         4SaX5sfY0Rb7ErZe8TNlj9EZIooPMyRuLlnGC6X4l76ioejAI+/usJ91qC5iSs+7VkF8
         3fZaNikhdEZT0BelmA9ErgHX9FfNLG0Yq26u5GJnUJcjrALLHCKxAvQVgM8zJe2AMhfw
         ptrFcifhEAJ7PfmHO4pv9xv/RL0nNs01n9bJf6xxIPLL4Ee5NejU4MeVim7CUC2pvkYQ
         AFHLN5zA1mhJdONCCZBjHbWeMy4mefJmjet1c624Km030xKODOBOwnytPvR6Y0MeTEfQ
         UiJw==
X-Gm-Message-State: AFqh2kptOMzuTKjv6KO013lTTBUNpO2flsMAot6dKNO5XC7d2NAC74we
        BjHWWppUQ3K0Po9uE3mNc6HGni9WYoWz5YPscwU=
X-Google-Smtp-Source: AMrXdXuIzYO6DzzH3XiiBRSxjygf86gCUAQbJkE0kNfiuo/1yB3J6EBHAWs3Jfj71oNMOMaXjfucPY5hpgX25+tmEPE=
X-Received: by 2002:a05:6870:513:b0:13d:51fe:3404 with SMTP id
 j19-20020a056870051300b0013d51fe3404mr3053712oao.183.1672930267752; Thu, 05
 Jan 2023 06:51:07 -0800 (PST)
MIME-Version: 1.0
References: <20221206192123.661448-1-robdclark@gmail.com> <Y7bHcRAvk6GgMi5F@phenom.ffwll.local>
In-Reply-To: <Y7bHcRAvk6GgMi5F@phenom.ffwll.local>
From:   Rob Clark <robdclark@gmail.com>
Date:   Thu, 5 Jan 2023 06:51:01 -0800
Message-ID: <CAF6AEGsB=ngkTDCUoFo5anZaFMswArpe-Uzt0j+Dcm1F7RFbGA@mail.gmail.com>
Subject: Re: [PATCH] drm/msm: Add MSM_SUBMIT_BO_NO_IMPLICIT
To:     Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Chia-I Wu <olvaffe@gmail.com>,
        Rob Clark <robdclark@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        open list <linux-kernel@vger.kernel.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 5, 2023 at 4:49 AM Daniel Vetter <daniel@ffwll.ch> wrote:
>
> On Tue, Dec 06, 2022 at 11:21:23AM -0800, Rob Clark wrote:
> > From: Rob Clark <robdclark@chromium.org>
> >
> > In cases where implicit sync is used, it is still useful (for things
> > like sub-allocation, etc) to allow userspace to opt-out of implicit
> > sync on per-BO basis.
> >
> > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > ---
> >  drivers/gpu/drm/msm/msm_drv.c        |  3 ++-
> >  drivers/gpu/drm/msm/msm_gem_submit.c | 11 +++++++++++
> >  include/uapi/drm/msm_drm.h           |  4 +++-
> >  3 files changed, 16 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
> > index 017a512982a2..e0e1199a822f 100644
> > --- a/drivers/gpu/drm/msm/msm_drv.c
> > +++ b/drivers/gpu/drm/msm/msm_drv.c
> > @@ -45,9 +45,10 @@
> >   * - 1.7.0 - Add MSM_PARAM_SUSPENDS to access suspend count
> >   * - 1.8.0 - Add MSM_BO_CACHED_COHERENT for supported GPUs (a6xx)
> >   * - 1.9.0 - Add MSM_SUBMIT_FENCE_SN_IN
> > + * - 1.10.0 - Add MSM_SUBMIT_BO_NO_IMPLICIT
> >   */
> >  #define MSM_VERSION_MAJOR    1
> > -#define MSM_VERSION_MINOR    9
> > +#define MSM_VERSION_MINOR    10
> >  #define MSM_VERSION_PATCHLEVEL       0
> >
> >  static const struct drm_mode_config_funcs mode_config_funcs = {
> > diff --git a/drivers/gpu/drm/msm/msm_gem_submit.c b/drivers/gpu/drm/msm/msm_gem_submit.c
> > index eb3536e3d66a..8bad07a04f85 100644
> > --- a/drivers/gpu/drm/msm/msm_gem_submit.c
> > +++ b/drivers/gpu/drm/msm/msm_gem_submit.c
> > @@ -334,9 +334,20 @@ static int submit_fence_sync(struct msm_gem_submit *submit, bool no_implicit)
> >               if (ret)
> >                       return ret;
> >
> > +             /* If userspace has determined that explicit fencing is
> > +              * used, it can disable implicit sync on the entire
> > +              * submit:
> > +              */
> >               if (no_implicit)
> >                       continue;
> >
> > +             /* Otherwise userspace can ask for implicit sync to be
> > +              * disabled on specific buffers.  This is useful for internal
> > +              * usermode driver managed buffers, suballocation, etc.
> > +              */
> > +             if (submit->bos[i].flags & MSM_SUBMIT_BO_NO_IMPLICIT)
> > +                     continue;
> > +
> >               ret = drm_sched_job_add_implicit_dependencies(&submit->base,
>
> Won't this break shrinkers and fun stuff like that? It's why we added the
> new USAGE_OTHER fence slot at least, and also why I wonder whether we

Only if the entire explicit sync path was busted.. My daily driver for
email/docs/meet/chat/corpstuff is a 4G device and CrOS is all explicit
sync.. I would have found out rapidly and dramatically if it was
busted :-P

But seriously, this doesn't change what fences we attach to buffers,
only what the sched job waits on

> shouldn't push this into the helper to make the right call. Every driver
> kinda needs the same wheel.

We kinda already have moved everything we can (with the current
driver-specific-uabi model) to helpers, what is left is driver
specific ioctl parsing.  We absolutely should take a step back and
re-evaluate this before anyone else adds a new submit/execbuf ioctl.
For example, the driver specific ioctl could just have a pointer to a
drm_gem_submit_bo_table type structure, and then we could move the
whole thing to a helper.  Short of breaking the submit ioctl up (which
a uring type uabi would let us do), I think the next best thing is to
split out common cross-driver structs for common parts of
submit/execbuf.

BR,
-R

> -Daniel
>
> >                                                             obj,
> >                                                             write);
> > diff --git a/include/uapi/drm/msm_drm.h b/include/uapi/drm/msm_drm.h
> > index f54b48ef6a2d..329100016e7c 100644
> > --- a/include/uapi/drm/msm_drm.h
> > +++ b/include/uapi/drm/msm_drm.h
> > @@ -222,10 +222,12 @@ struct drm_msm_gem_submit_cmd {
> >  #define MSM_SUBMIT_BO_READ             0x0001
> >  #define MSM_SUBMIT_BO_WRITE            0x0002
> >  #define MSM_SUBMIT_BO_DUMP             0x0004
> > +#define MSM_SUBMIT_BO_NO_IMPLICIT      0x0008
> >
> >  #define MSM_SUBMIT_BO_FLAGS            (MSM_SUBMIT_BO_READ | \
> >                                       MSM_SUBMIT_BO_WRITE | \
> > -                                     MSM_SUBMIT_BO_DUMP)
> > +                                     MSM_SUBMIT_BO_DUMP | \
> > +                                     MSM_SUBMIT_BO_NO_IMPLICIT)
> >
> >  struct drm_msm_gem_submit_bo {
> >       __u32 flags;          /* in, mask of MSM_SUBMIT_BO_x */
> > --
> > 2.38.1
> >
>
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch
