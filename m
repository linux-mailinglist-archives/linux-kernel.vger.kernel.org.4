Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D177869F818
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 16:34:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232588AbjBVPe1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 10:34:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232573AbjBVPeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 10:34:22 -0500
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B240E34308
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 07:33:49 -0800 (PST)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-172094e10e3so10170125fac.10
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 07:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1nu6rCRx8BzPVvb2CWdzEElkPQah8+J88HELeld+YLA=;
        b=Wphc6qJobqFKX/R9hxLWSRqUYLqCIkBJ9BNT3j7BIJPCaqPpD5iqF5q7gBYESFDmuR
         P4KfGycReyfa77pDknmdWebo6pO0H7/1JnxEDMRkVyAPcoRzQeVfulTcTdKnSVkngPiD
         m0fUIhEw1wgJ0kPtkA7ciybkV8eLzNr06i+6SMV/vfhkGh8bvq2ScmkXqtinejdaywaa
         Exr121oKnAUI1x74ead9IgiWgAz8wXpubPB41OqBPLCWW6yxqb3qG/2J+1RK/Cd8hDEY
         D1w2Wow+hBkgqI5vsVbuC+ee/gAET+FqqAM6SFOl0Gl4EMDbQfQB3l/4POydv0aeQW5i
         utdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1nu6rCRx8BzPVvb2CWdzEElkPQah8+J88HELeld+YLA=;
        b=alYa/4am0BEQPbj3mjPcHtT3PTkC/nySsIp53Gu/EDWpss+9WkfNhAAku2uZyyjRiN
         CKqDn6R7yI4fas5HTx0Lsbv3LCIKraQ0cTjSSu6XhN8tZ38HI7XhSCevCEUUaHN6kclw
         CykxYlMs5DNXJQTzlNZh0zeTYXT/5+ucPU8hfDt9F4obQ+vSGcHYIJcKiiBj6p6MIjcw
         2lDnZAV7IhhQc/a+qZCEkK8Go8kODzQqQqKqiP4lyTbrAwn93gyoM2LdLOIXMB3W21rM
         WSIbaPNGNBOZef3n1EINshP/R+Be3RYUxoTfEKdFQgBOrPROapAvi0TMgFYlrq5UqYP9
         C79w==
X-Gm-Message-State: AO0yUKXWeGSMhE+uerncxUgKjiHNAqlh7Mk/rIT/WaVzcv8U8WGAAWo0
        IgirDIlcmdOrSSzFsyjhCvKviC8piBPdys9F+dg=
X-Google-Smtp-Source: AK7set+gQuDbWafhDm7u6AliJCO35H5q1p5/4Hk9MdyuvDjF06gmwwiuIqwaHVjevQFkdWNAtpfBcKvLTxoDDkTiGfM=
X-Received: by 2002:a05:6870:808d:b0:16e:8a56:d0d2 with SMTP id
 q13-20020a056870808d00b0016e8a56d0d2mr1360092oab.38.1677080028314; Wed, 22
 Feb 2023 07:33:48 -0800 (PST)
MIME-Version: 1.0
References: <20230220201916.1822214-1-robdclark@gmail.com> <20230220201916.1822214-10-robdclark@gmail.com>
 <20230221105307.7430c301@eldfell> <CAF6AEGtd_9JYtPU-AGmZY0My_d48rSSWQiD-efbR2KFxD-+tTA@mail.gmail.com>
 <20230222120904.5c281652@eldfell> <Y/YhKiuOHiX2LcyL@intel.com>
In-Reply-To: <Y/YhKiuOHiX2LcyL@intel.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Wed, 22 Feb 2023 07:33:37 -0800
Message-ID: <CAF6AEGsEVFPTfUWQtw1B=QgdusgdqhsU+neShgT5iQn-UrdwjA@mail.gmail.com>
Subject: Re: [PATCH v5 09/14] drm/syncobj: Add deadline support for syncobj waits
To:     Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc:     Pekka Paalanen <ppaalanen@gmail.com>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
        =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Simon Ser <contact@emersion.fr>,
        Rob Clark <robdclark@chromium.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        open list <linux-kernel@vger.kernel.org>
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

On Wed, Feb 22, 2023 at 6:06 AM Rodrigo Vivi <rodrigo.vivi@intel.com> wrote:
>
> On Wed, Feb 22, 2023 at 12:09:04PM +0200, Pekka Paalanen wrote:
> > On Tue, 21 Feb 2023 09:25:18 -0800
> > Rob Clark <robdclark@gmail.com> wrote:
> >
> > > On Tue, Feb 21, 2023 at 12:53 AM Pekka Paalanen <ppaalanen@gmail.com> wrote:
> > > >
> > > > On Mon, 20 Feb 2023 12:18:56 -0800
> > > > Rob Clark <robdclark@gmail.com> wrote:
> > > >
> > > > > From: Rob Clark <robdclark@chromium.org>
> > > > >
> > > > > Add a new flag to let userspace provide a deadline as a hint for syncobj
> > > > > and timeline waits.  This gives a hint to the driver signaling the
> > > > > backing fences about how soon userspace needs it to compete work, so it
> > > > > can addjust GPU frequency accordingly.  An immediate deadline can be
> > > > > given to provide something equivalent to i915 "wait boost".
> > > > >
> > > > > v2: Use absolute u64 ns value for deadline hint, drop cap and driver
> > > > >     feature flag in favor of allowing count_handles==0 as a way for
> > > > >     userspace to probe kernel for support of new flag
> > > > >
> > > > > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > > > > ---
> > > > >  drivers/gpu/drm/drm_syncobj.c | 59 +++++++++++++++++++++++++++--------
> > > > >  include/uapi/drm/drm.h        |  5 +++
> > > > >  2 files changed, 51 insertions(+), 13 deletions(-)
> > > >
> > > > ...
> > > >
> > > > > diff --git a/include/uapi/drm/drm.h b/include/uapi/drm/drm.h
> > > > > index 642808520d92..aefc8cc743e0 100644
> > > > > --- a/include/uapi/drm/drm.h
> > > > > +++ b/include/uapi/drm/drm.h
> > > > > @@ -887,6 +887,7 @@ struct drm_syncobj_transfer {
> > > > >  #define DRM_SYNCOBJ_WAIT_FLAGS_WAIT_ALL (1 << 0)
> > > > >  #define DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT (1 << 1)
> > > > >  #define DRM_SYNCOBJ_WAIT_FLAGS_WAIT_AVAILABLE (1 << 2) /* wait for time point to become available */
> > > > > +#define DRM_SYNCOBJ_WAIT_FLAGS_WAIT_DEADLINE (1 << 3) /* set fence deadline based to deadline_nsec/sec */
> > > >
> > > > Hi,
> > > >
> > > > where is the UAPI documentation explaining what is a "fence deadline"
> > > > and what setting it does here?
> > >
> > > It's with the rest of the drm_syncobj UAPI docs ;-)
> >
> > Is that https://www.kernel.org/doc/html/latest/driver-api/dma-buf.html#dma-fence-uabi-sync-file ?
> >
> > That whole page never mentions e.g. WAIT_AVAILABLE, so at least the
> > flags are not there. Does not mention syncobj_wait either.

Sorry, that was a snarky reference to thin UABI docs about syncobj.
The kernel side of it is better documented.

> probably this:
> https://docs.kernel.org/gpu/drm-mm.html
>
> the new one needs to be added there as well.
>
> >
> > I could ask where the real non-IGT userspace is or the plan for it,
> > too, since this is new DRM UAPI.
>
> yeap, it looks like we need to close on this...
> https://gitlab.freedesktop.org/drm/intel/-/issues/8014
>
> I confess I got lost on the many discussions and on how this will
> be used. Is mesa going to set the deadline based on the vk priority?
>
> Will this continue to be internal? I didn't get the broader picture
> I'm afraid...

Yes, the plan is to use it from mesa vk-common helpers (and elsewhere
in mesa if needed).  There is a separate discussion[1] about
limiting/allowing boost (perhaps based on ctx flag or cgroups) but
that is more about how drivers react to the deadline hint.  The
immediate goal of this patch is just to fix the regression mentioned
in that gitlab issue when using syncobj waits instead of
DRM_IOCTL_I915_GEM_WAIT

BR,
-R

[1] https://www.spinics.net/lists/dri-devel/msg383075.html

> >
> >
> > Thanks,
> > pq
> >
> > >
> > > BR,
> > > -R
> > >
> > > > btw. no nsec/sec anymore.
> > > >
> > > >
> > > > Thanks,
> > > > pq
> > > >
> > > >
> > > > >  struct drm_syncobj_wait {
> > > > >       __u64 handles;
> > > > >       /* absolute timeout */
> > > > > @@ -895,6 +896,8 @@ struct drm_syncobj_wait {
> > > > >       __u32 flags;
> > > > >       __u32 first_signaled; /* only valid when not waiting all */
> > > > >       __u32 pad;
> > > > > +     /* Deadline hint to set on backing fence(s) in CLOCK_MONOTONIC: */
> > > > > +     __u64 deadline_ns;
> > > > >  };
> > > > >
> > > > >  struct drm_syncobj_timeline_wait {
> > > > > @@ -907,6 +910,8 @@ struct drm_syncobj_timeline_wait {
> > > > >       __u32 flags;
> > > > >       __u32 first_signaled; /* only valid when not waiting all */
> > > > >       __u32 pad;
> > > > > +     /* Deadline hint to set on backing fence(s) in CLOCK_MONOTONIC: */
> > > > > +     __u64 deadline_ns;
> > > > >  };
> > > > >
> > > > >
> > > >
> >
>
>
