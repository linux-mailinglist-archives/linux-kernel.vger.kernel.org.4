Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87CD869EA28
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 23:28:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbjBUW20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 17:28:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjBUW2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 17:28:24 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40E1E23C67
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 14:28:23 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id be35so5880838oib.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 14:28:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F4Iy6VrXhR9K+HbN5pwicMX3S23KY9nb4sxLhyP475c=;
        b=EAMohaBrf4/49QfiHQliMmnD6WIeq5tih3fsYkBw5/nmNBAj/yjkoaGALhnpCg+ekP
         PTYfkXGOKDbKn93+PV6YidAic7uLouqpdj5dlL7uZw/0RnQrEa1WCUNxeRShth8K9wiG
         KEayT+gPNtLanm7G2nr8X0d+LpPicJF7pGo9Fg8kJTkfY8Bx4KntKT6WyiY7uPdaJta9
         5mTRGWRpZl+mTuy6+7+gT2hL2cetLtQk/oJ7ETVwEEYlnTyNFgyfgywtA79yMY6041ld
         iJ+jgolxbPhhVOJCptycI9LC7XzSlaGIvnM9sJMVhRv23k+lG0LJfcgl9XzZn1iNfOmv
         i6Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F4Iy6VrXhR9K+HbN5pwicMX3S23KY9nb4sxLhyP475c=;
        b=m7VTpuxqIwFyU5AVffpBCMF/kOiYT6X1RND0T6ChIHS98NzwemJLDHo/hQJiyD5yt3
         qE3dmb3nOQBW2Inm++K0avDy5EFFG7B/JEUVBNe2MZ0KDWgxtH1/RW2/QzVFJvcQ1nmX
         c2IS91upnvS2fxdk2Ix9DYLot3k53BAdND3HMC7uUltRjjQBgIfeeZx948niV69pzo5z
         SqZ9jnXn7wSwbYwj1IYF/dC8+v5XiG9VWKNvQQPS2oUmKcE67oTPqQR/sgShTkDSB4jE
         qKE1JDUPs5z/qJMATM2Cyi54jy1x155GLDrVF2SH6XmZ990up5fLREkB8R2Gq32+AKQM
         ewWA==
X-Gm-Message-State: AO0yUKWuZIm/xgVcE088UJaa31Z8BoXVOXQUMF74i9nf2tgFzVYkRwai
        uDQsWPRLhAjHEhOY0mYSd/XqTIBrkkvTIpy+fE8=
X-Google-Smtp-Source: AK7set+9/3FhxoWnPD78RDowrXAKIqtKTbXhGG18S7omg7H9Cfu+lhZ3mvky+r6iZNT3oTMiCi24+S+oAo3ij8ohP+w=
X-Received: by 2002:a05:6808:16ab:b0:37d:81a9:5103 with SMTP id
 bb43-20020a05680816ab00b0037d81a95103mr1261248oib.38.1677018502383; Tue, 21
 Feb 2023 14:28:22 -0800 (PST)
MIME-Version: 1.0
References: <20230218211608.1630586-1-robdclark@gmail.com> <20230218211608.1630586-11-robdclark@gmail.com>
 <20230220110820.595cfa37@eldfell> <CAF6AEGuo-vmW4Va9=RH+kH9KgNvR2vzjJ8meO-oty56xjDhjgg@mail.gmail.com>
 <20230221104551.60d44d1c@eldfell> <Y/TAr64SpxO712RB@intel.com>
 <CAJs_Fx7n3QrzusdX5yD=39YZ8MzjuwZTriWz8hVxNYGHO=sJ_Q@mail.gmail.com>
 <Y/U6HKD2hbH4Sx1G@intel.com> <Y/U8FcU4SXsJu1/q@intel.com>
In-Reply-To: <Y/U8FcU4SXsJu1/q@intel.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Tue, 21 Feb 2023 14:28:10 -0800
Message-ID: <CAF6AEGtkgDNZTr-NS_rUuEDxPy5aoMycPDn2RXFEXfAiA7=E9A@mail.gmail.com>
Subject: Re: [Freedreno] [PATCH v4 10/14] drm/vblank: Add helper to get next
 vblank time
To:     =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc:     Rob Clark <robdclark@chromium.org>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
        =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>,
        open list <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org,
        Pekka Paalanen <ppaalanen@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        freedreno@lists.freedesktop.org
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

On Tue, Feb 21, 2023 at 1:48 PM Ville Syrj=C3=A4l=C3=A4
<ville.syrjala@linux.intel.com> wrote:
>
> On Tue, Feb 21, 2023 at 11:39:40PM +0200, Ville Syrj=C3=A4l=C3=A4 wrote:
> > On Tue, Feb 21, 2023 at 11:54:55AM -0800, Rob Clark wrote:
> > > On Tue, Feb 21, 2023 at 5:01 AM Ville Syrj=C3=A4l=C3=A4
> > > <ville.syrjala@linux.intel.com> wrote:
> > > >
> > > > On Tue, Feb 21, 2023 at 10:45:51AM +0200, Pekka Paalanen wrote:
> > > > > On Mon, 20 Feb 2023 07:55:41 -0800
> > > > > Rob Clark <robdclark@gmail.com> wrote:
> > > > >
> > > > > > On Mon, Feb 20, 2023 at 1:08 AM Pekka Paalanen <ppaalanen@gmail=
.com> wrote:
> > > > > > >
> > > > > > > On Sat, 18 Feb 2023 13:15:53 -0800
> > > > > > > Rob Clark <robdclark@gmail.com> wrote:
> > > > > > >
> > > > > > > > From: Rob Clark <robdclark@chromium.org>
> > > > > > > >
> > > > > > > > Will be used in the next commit to set a deadline on fences=
 that an
> > > > > > > > atomic update is waiting on.
> > > > > > > >
> > > > > > > > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > > > > > > > ---
> > > > > > > >  drivers/gpu/drm/drm_vblank.c | 32 ++++++++++++++++++++++++=
++++++++
> > > > > > > >  include/drm/drm_vblank.h     |  1 +
> > > > > > > >  2 files changed, 33 insertions(+)
> > > > > > > >
> > > > > > > > diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm=
/drm_vblank.c
> > > > > > > > index 2ff31717a3de..caf25ebb34c5 100644
> > > > > > > > --- a/drivers/gpu/drm/drm_vblank.c
> > > > > > > > +++ b/drivers/gpu/drm/drm_vblank.c
> > > > > > > > @@ -980,6 +980,38 @@ u64 drm_crtc_vblank_count_and_time(str=
uct drm_crtc *crtc,
> > > > > > > >  }
> > > > > > > >  EXPORT_SYMBOL(drm_crtc_vblank_count_and_time);
> > > > > > > >
> > > > > > > > +/**
> > > > > > > > + * drm_crtc_next_vblank_time - calculate the time of the n=
ext vblank
> > > > > > > > + * @crtc: the crtc for which to calculate next vblank time
> > > > > > > > + * @vblanktime: pointer to time to receive the next vblank=
 timestamp.
> > > > > > > > + *
> > > > > > > > + * Calculate the expected time of the next vblank based on=
 time of previous
> > > > > > > > + * vblank and frame duration
> > > > > > >
> > > > > > > Hi,
> > > > > > >
> > > > > > > for VRR this targets the highest frame rate possible for the =
current
> > > > > > > VRR mode, right?
> > > > > > >
> > > > > >
> > > > > > It is based on vblank->framedur_ns which is in turn based on
> > > > > > mode->crtc_clock.  Presumably for VRR that ends up being a maxi=
mum?
> > > > >
> > > > > I don't know. :-)
> > > >
> > > > At least for i915 this will give you the maximum frame
> > > > duration.
> > > >
> > > > Also this does not calculate the the start of vblank, it
> > > > calculates the start of active video.
> > >
> > > AFAIU, vsync_end/vsync_start are in units of line, so I could do some=
thing like:
> > >
> > >   vsync_lines =3D vblank->hwmode.vsync_end - vblank->hwmode.vsync_sta=
rt;
> > >   vsyncdur =3D ns_to_ktime(vblank->linedur_ns * vsync_lines);
> > >   framedur =3D ns_to_ktime(vblank->framedur_ns);
> > >   *vblanktime =3D ktime_add(*vblanktime, ktime_sub(framedur, vsyncdur=
));
> >
> > Something like this should work:
> >  vblank_start =3D framedur_ns * crtc_vblank_start / crtc_vtotal
> >  deadline =3D vblanktime + vblank_start
> >
> > That would be the expected time when the next start of vblank
> > happens.
>
> Except that drm_vblank_count_and_time() will give you the last
> sampled timestamp, which may be long ago in the past. Would
> need to add an _accurate version of that if we want to be
> guaranteed a fresh sample.

IIRC the only time we wouldn't have a fresh sample is if the screen
has been idle for some time?  In which case, I think that doesn't
matter.

BR,
-R

>
> --
> Ville Syrj=C3=A4l=C3=A4
> Intel
