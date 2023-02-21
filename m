Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96D5D69E64F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 18:50:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234632AbjBURuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 12:50:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233945AbjBURuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 12:50:32 -0500
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23C5B2D178
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 09:50:31 -0800 (PST)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-1720887dfcdso6411137fac.6
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 09:50:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O5Jqc/YZjZyQYqTXnIf8R98ssXuoqvkdUho65IcZjEA=;
        b=lbqDpLvU7c7eLGnGV9F/nEWZ38S8/eURJS12sQQcMSScoQAxnnaBIlqOgM3yW7/U76
         6IZohiU14lbEEt/DRE1VxjjUXZUKHqHFK+CMSJHHk134QvN+sWSHHSdMB4/ApZ8s6RlD
         1xxadoYMiXtzhhB2Jj/DjoBnrxVflrMBRZG/+APjGhSGZE9+k/17e3QR7bujIxJoVAK9
         jdpV5zFTnBEKYV4f/VWQIBTioCRMs9FnKuShRRuTwUakq5aEBxrKOZwxAXXI/7XBwyYE
         Sjqbj7UIuxYsNu5P546GsW8Ph8AKK0AHdL0CZsgFtaUJFTNLJrVnhCfgvQDei9oU0KO9
         i/Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O5Jqc/YZjZyQYqTXnIf8R98ssXuoqvkdUho65IcZjEA=;
        b=tKJZ0lDKY9m8wL4hI0ob9+QYdk2i175Tb1l6DyIUsrDCrfmCfTb+gj+iK77aALxhn+
         Z3q/C0sdwQhBATCmjWboErPoYog0e6ErW70jNBXMy/FUsmcVdxIVxmzNt5iJT2RP+WwU
         HGHoCL12hfdm6OuJBODQrk3xqEqrcApDO9zd0fVfz9+6+lbmeyFgOoLZ5YYyNyDd2i1W
         27mwu8icqgzqvscZkJB7Unw2P4qgjtocQpNHUZ6I3J+P+BiKaMWi9Nb2/1JoUS1UbS6i
         TM71vJx8hxnMwKd+3+c+jkzkxkaiNF1ur4x+25LsfnwBd5VHnjG9I6L2umEvQeWzUS9j
         b6+w==
X-Gm-Message-State: AO0yUKVTMBDW14J6v9ekBb21SvmbAoWZ/rqD06axO6FPKubh70bP5IJt
        61d/1ooLJNa4/BzYUeEN+v9oCGO6dZ/zUyMkl8U=
X-Google-Smtp-Source: AK7set+C8udISyRUP8+aDUE3orCb6yoqc4T3+xIJp+MByhgBco1zccJSqc5WaC0GBnmbCmGM2wG5NoptBUQRgq6lnlk=
X-Received: by 2002:a05:6870:32d4:b0:16e:5e5a:49da with SMTP id
 r20-20020a05687032d400b0016e5e5a49damr1495979oac.58.1677001830435; Tue, 21
 Feb 2023 09:50:30 -0800 (PST)
MIME-Version: 1.0
References: <20230218211608.1630586-1-robdclark@gmail.com> <20230218211608.1630586-11-robdclark@gmail.com>
 <20230220110820.595cfa37@eldfell> <CAF6AEGuo-vmW4Va9=RH+kH9KgNvR2vzjJ8meO-oty56xjDhjgg@mail.gmail.com>
 <20230221104551.60d44d1c@eldfell> <Y/TAr64SpxO712RB@intel.com>
In-Reply-To: <Y/TAr64SpxO712RB@intel.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Tue, 21 Feb 2023 09:50:20 -0800
Message-ID: <CAF6AEGumfEeGQQaEoEm4hzJajCOBBTrWxPQ9MTh7jt-Mov2FEQ@mail.gmail.com>
Subject: Re: [PATCH v4 10/14] drm/vblank: Add helper to get next vblank time
To:     =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc:     Pekka Paalanen <ppaalanen@gmail.com>,
        Rob Clark <robdclark@chromium.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
        =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>,
        open list <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org,
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

On Tue, Feb 21, 2023 at 5:01 AM Ville Syrj=C3=A4l=C3=A4
<ville.syrjala@linux.intel.com> wrote:
>
> On Tue, Feb 21, 2023 at 10:45:51AM +0200, Pekka Paalanen wrote:
> > On Mon, 20 Feb 2023 07:55:41 -0800
> > Rob Clark <robdclark@gmail.com> wrote:
> >
> > > On Mon, Feb 20, 2023 at 1:08 AM Pekka Paalanen <ppaalanen@gmail.com> =
wrote:
> > > >
> > > > On Sat, 18 Feb 2023 13:15:53 -0800
> > > > Rob Clark <robdclark@gmail.com> wrote:
> > > >
> > > > > From: Rob Clark <robdclark@chromium.org>
> > > > >
> > > > > Will be used in the next commit to set a deadline on fences that =
an
> > > > > atomic update is waiting on.
> > > > >
> > > > > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > > > > ---
> > > > >  drivers/gpu/drm/drm_vblank.c | 32 ++++++++++++++++++++++++++++++=
++
> > > > >  include/drm/drm_vblank.h     |  1 +
> > > > >  2 files changed, 33 insertions(+)
> > > > >
> > > > > diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_v=
blank.c
> > > > > index 2ff31717a3de..caf25ebb34c5 100644
> > > > > --- a/drivers/gpu/drm/drm_vblank.c
> > > > > +++ b/drivers/gpu/drm/drm_vblank.c
> > > > > @@ -980,6 +980,38 @@ u64 drm_crtc_vblank_count_and_time(struct dr=
m_crtc *crtc,
> > > > >  }
> > > > >  EXPORT_SYMBOL(drm_crtc_vblank_count_and_time);
> > > > >
> > > > > +/**
> > > > > + * drm_crtc_next_vblank_time - calculate the time of the next vb=
lank
> > > > > + * @crtc: the crtc for which to calculate next vblank time
> > > > > + * @vblanktime: pointer to time to receive the next vblank times=
tamp.
> > > > > + *
> > > > > + * Calculate the expected time of the next vblank based on time =
of previous
> > > > > + * vblank and frame duration
> > > >
> > > > Hi,
> > > >
> > > > for VRR this targets the highest frame rate possible for the curren=
t
> > > > VRR mode, right?
> > > >
> > >
> > > It is based on vblank->framedur_ns which is in turn based on
> > > mode->crtc_clock.  Presumably for VRR that ends up being a maximum?
> >
> > I don't know. :-)
>
> At least for i915 this will give you the maximum frame
> duration.

I suppose one could argue that maximum frame duration is the actual
deadline.  Anything less is just moar fps, but not going to involve
stalling until vblank N+1, AFAIU

> Also this does not calculate the the start of vblank, it
> calculates the start of active video.

Probably something like end of previous frame's video..  might not be
_exactly_ correct (because some buffering involved), but OTOH on the
GPU side, I expect the driver to set a timer for a few ms or so before
the deadline.  So there is some wiggle room.

BR,
-R

> >
> > You need a number of clock cycles in addition to the clock frequency,
> > and that could still be minimum, maximum, the last realized one, ...
> >
> > VRR works by adjusting the front porch length IIRC.
> >
> >
> > Thanks,
> > pq
> >
> > > BR,
> > > -R
> > >
> > >
> > > >
> > > > Thanks,
> > > > pq
> > > >
> > > > > + */
> > > > > +int drm_crtc_next_vblank_time(struct drm_crtc *crtc, ktime_t *vb=
lanktime)
> > > > > +{
> > > > > +     unsigned int pipe =3D drm_crtc_index(crtc);
> > > > > +     struct drm_vblank_crtc *vblank =3D &crtc->dev->vblank[pipe]=
;
> > > > > +     u64 count;
> > > > > +
> > > > > +     if (!vblank->framedur_ns)
> > > > > +             return -EINVAL;
> > > > > +
> > > > > +     count =3D drm_vblank_count_and_time(crtc->dev, pipe, vblank=
time);
> > > > > +
> > > > > +     /*
> > > > > +      * If we don't get a valid count, then we probably also don=
't
> > > > > +      * have a valid time:
> > > > > +      */
> > > > > +     if (!count)
> > > > > +             return -EINVAL;
> > > > > +
> > > > > +     *vblanktime =3D ktime_add(*vblanktime, ns_to_ktime(vblank->=
framedur_ns));
> > > > > +
> > > > > +     return 0;
> > > > > +}
> > > > > +EXPORT_SYMBOL(drm_crtc_next_vblank_time);
> > > > > +
> > > > >  static void send_vblank_event(struct drm_device *dev,
> > > > >               struct drm_pending_vblank_event *e,
> > > > >               u64 seq, ktime_t now)
> > > > > diff --git a/include/drm/drm_vblank.h b/include/drm/drm_vblank.h
> > > > > index 733a3e2d1d10..a63bc2c92f3c 100644
> > > > > --- a/include/drm/drm_vblank.h
> > > > > +++ b/include/drm/drm_vblank.h
> > > > > @@ -230,6 +230,7 @@ bool drm_dev_has_vblank(const struct drm_devi=
ce *dev);
> > > > >  u64 drm_crtc_vblank_count(struct drm_crtc *crtc);
> > > > >  u64 drm_crtc_vblank_count_and_time(struct drm_crtc *crtc,
> > > > >                                  ktime_t *vblanktime);
> > > > > +int drm_crtc_next_vblank_time(struct drm_crtc *crtc, ktime_t *vb=
lanktime);
> > > > >  void drm_crtc_send_vblank_event(struct drm_crtc *crtc,
> > > > >                              struct drm_pending_vblank_event *e);
> > > > >  void drm_crtc_arm_vblank_event(struct drm_crtc *crtc,
> > > >
> >
>
>
>
> --
> Ville Syrj=C3=A4l=C3=A4
> Intel
