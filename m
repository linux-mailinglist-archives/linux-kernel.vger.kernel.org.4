Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB0A469EB21
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 00:21:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbjBUXVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 18:21:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjBUXVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 18:21:07 -0500
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC32A2A145
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 15:21:05 -0800 (PST)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-17227cba608so4922460fac.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 15:21:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HUQ2r3lvTkcmdh0t4kUOtFRrp5CeR8IXsIIn8yz2gQM=;
        b=nWYuBedzqvx3dUp/zI9I9j7ABHOPtg5U155roZuiA3OHvLKQz6fkqmAc35/WjFq4gv
         E/AzwQmgbgh+D7ujeR0Cf38muE5sZLnPdk8m9fVDl17BcWJnu4mFLdI4r/oArOe6WXJF
         rIH2lc53EoM/DyNhFbRSSg7qj0snCLmXicqkPtoGkRkDNXmfANYMb+Cg/+ZiRGatEyue
         tf6xoGfPM3CbYcDt9fmdT7+F6J5Mhiy4zf06pWNWmjD19ujp+eAZTEDGaZEnJiLpdisq
         khdJsQNvNyRPSC9aaIYV9np9W349Ul9ftcjKnyu+KxS4qU+8LTK8AApvH7Z7kcYS0ahX
         GE9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HUQ2r3lvTkcmdh0t4kUOtFRrp5CeR8IXsIIn8yz2gQM=;
        b=Xro8OtjgI+40hDyJMThe/JUKunZdDPS8X26gRysAGXJocSLt0IIn7QsJIJaQcptjh+
         gTAYhEIw9SjYsoie+C/8fHfKjHwbpEECXBSW/b/2h6n+rPzElivafFtUolStt8oJe2VU
         6Z57cU40sR/4yRQsX2gLxuC0JAwtZXTfCH9cR+9JKjJij5Z978Xolv4Wpylbr/L/1hoV
         iuYUSar4Fsbwf+DXP+HUgZNfEvImuLsgrcBmFwrkIGJndnXj/ZNVgtdAwoKtMOAkVzAl
         gd84lAC3HTXhJUe2rsWvM5Dvb3EEk0kIA74znWujT8ZWVEnOOa7IMvaaxd9erVJ+XR0t
         HWWw==
X-Gm-Message-State: AO0yUKVHJK/hI3Bw8iqyT3Ae0llqsg506G0dwhU98Wjgi1B2nGUoIaSn
        bXOGoUN7fYt8grTm09XXlvgCAavXNiNwSBnqQpY=
X-Google-Smtp-Source: AK7set82PLQ6nNpMh4lV1CZO5fnJKE+HvbFUS4b+yKz0hDN3EHZI0qUn4phXxximwxnKnzYpJ2AJ9P0ZQtMnhG6/Qbk=
X-Received: by 2002:a05:6870:808d:b0:16e:8a56:d0d2 with SMTP id
 q13-20020a056870808d00b0016e8a56d0d2mr1198136oab.38.1677021664566; Tue, 21
 Feb 2023 15:21:04 -0800 (PST)
MIME-Version: 1.0
References: <20230218211608.1630586-1-robdclark@gmail.com> <20230218211608.1630586-11-robdclark@gmail.com>
 <20230220110820.595cfa37@eldfell> <CAF6AEGuo-vmW4Va9=RH+kH9KgNvR2vzjJ8meO-oty56xjDhjgg@mail.gmail.com>
 <20230221104551.60d44d1c@eldfell> <Y/TAr64SpxO712RB@intel.com>
 <CAJs_Fx7n3QrzusdX5yD=39YZ8MzjuwZTriWz8hVxNYGHO=sJ_Q@mail.gmail.com>
 <Y/U6HKD2hbH4Sx1G@intel.com> <Y/U8FcU4SXsJu1/q@intel.com> <CAF6AEGtkgDNZTr-NS_rUuEDxPy5aoMycPDn2RXFEXfAiA7=E9A@mail.gmail.com>
 <Y/VJrNPX8EiwEyYt@intel.com>
In-Reply-To: <Y/VJrNPX8EiwEyYt@intel.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Tue, 21 Feb 2023 15:20:53 -0800
Message-ID: <CAF6AEGua7JfqDJE-pYCDspDAKErCf1cXiUQBfp2RHhANaB0yKA@mail.gmail.com>
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

On Tue, Feb 21, 2023 at 2:46 PM Ville Syrj=C3=A4l=C3=A4
<ville.syrjala@linux.intel.com> wrote:
>
> On Tue, Feb 21, 2023 at 02:28:10PM -0800, Rob Clark wrote:
> > On Tue, Feb 21, 2023 at 1:48 PM Ville Syrj=C3=A4l=C3=A4
> > <ville.syrjala@linux.intel.com> wrote:
> > >
> > > On Tue, Feb 21, 2023 at 11:39:40PM +0200, Ville Syrj=C3=A4l=C3=A4 wro=
te:
> > > > On Tue, Feb 21, 2023 at 11:54:55AM -0800, Rob Clark wrote:
> > > > > On Tue, Feb 21, 2023 at 5:01 AM Ville Syrj=C3=A4l=C3=A4
> > > > > <ville.syrjala@linux.intel.com> wrote:
> > > > > >
> > > > > > On Tue, Feb 21, 2023 at 10:45:51AM +0200, Pekka Paalanen wrote:
> > > > > > > On Mon, 20 Feb 2023 07:55:41 -0800
> > > > > > > Rob Clark <robdclark@gmail.com> wrote:
> > > > > > >
> > > > > > > > On Mon, Feb 20, 2023 at 1:08 AM Pekka Paalanen <ppaalanen@g=
mail.com> wrote:
> > > > > > > > >
> > > > > > > > > On Sat, 18 Feb 2023 13:15:53 -0800
> > > > > > > > > Rob Clark <robdclark@gmail.com> wrote:
> > > > > > > > >
> > > > > > > > > > From: Rob Clark <robdclark@chromium.org>
> > > > > > > > > >
> > > > > > > > > > Will be used in the next commit to set a deadline on fe=
nces that an
> > > > > > > > > > atomic update is waiting on.
> > > > > > > > > >
> > > > > > > > > > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > > > > > > > > > ---
> > > > > > > > > >  drivers/gpu/drm/drm_vblank.c | 32 ++++++++++++++++++++=
++++++++++++
> > > > > > > > > >  include/drm/drm_vblank.h     |  1 +
> > > > > > > > > >  2 files changed, 33 insertions(+)
> > > > > > > > > >
> > > > > > > > > > diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu=
/drm/drm_vblank.c
> > > > > > > > > > index 2ff31717a3de..caf25ebb34c5 100644
> > > > > > > > > > --- a/drivers/gpu/drm/drm_vblank.c
> > > > > > > > > > +++ b/drivers/gpu/drm/drm_vblank.c
> > > > > > > > > > @@ -980,6 +980,38 @@ u64 drm_crtc_vblank_count_and_time=
(struct drm_crtc *crtc,
> > > > > > > > > >  }
> > > > > > > > > >  EXPORT_SYMBOL(drm_crtc_vblank_count_and_time);
> > > > > > > > > >
> > > > > > > > > > +/**
> > > > > > > > > > + * drm_crtc_next_vblank_time - calculate the time of t=
he next vblank
> > > > > > > > > > + * @crtc: the crtc for which to calculate next vblank =
time
> > > > > > > > > > + * @vblanktime: pointer to time to receive the next vb=
lank timestamp.
> > > > > > > > > > + *
> > > > > > > > > > + * Calculate the expected time of the next vblank base=
d on time of previous
> > > > > > > > > > + * vblank and frame duration
> > > > > > > > >
> > > > > > > > > Hi,
> > > > > > > > >
> > > > > > > > > for VRR this targets the highest frame rate possible for =
the current
> > > > > > > > > VRR mode, right?
> > > > > > > > >
> > > > > > > >
> > > > > > > > It is based on vblank->framedur_ns which is in turn based o=
n
> > > > > > > > mode->crtc_clock.  Presumably for VRR that ends up being a =
maximum?
> > > > > > >
> > > > > > > I don't know. :-)
> > > > > >
> > > > > > At least for i915 this will give you the maximum frame
> > > > > > duration.
> > > > > >
> > > > > > Also this does not calculate the the start of vblank, it
> > > > > > calculates the start of active video.
> > > > >
> > > > > AFAIU, vsync_end/vsync_start are in units of line, so I could do =
something like:
> > > > >
> > > > >   vsync_lines =3D vblank->hwmode.vsync_end - vblank->hwmode.vsync=
_start;
> > > > >   vsyncdur =3D ns_to_ktime(vblank->linedur_ns * vsync_lines);
> > > > >   framedur =3D ns_to_ktime(vblank->framedur_ns);
> > > > >   *vblanktime =3D ktime_add(*vblanktime, ktime_sub(framedur, vsyn=
cdur));
> > > >
> > > > Something like this should work:
> > > >  vblank_start =3D framedur_ns * crtc_vblank_start / crtc_vtotal
> > > >  deadline =3D vblanktime + vblank_start
> > > >
> > > > That would be the expected time when the next start of vblank
> > > > happens.
> > >
> > > Except that drm_vblank_count_and_time() will give you the last
> > > sampled timestamp, which may be long ago in the past. Would
> > > need to add an _accurate version of that if we want to be
> > > guaranteed a fresh sample.
> >
> > IIRC the only time we wouldn't have a fresh sample is if the screen
> > has been idle for some time?
>
> IIRC "some time" =3D=3D 1 idle frame, for any driver that sets
> vblank_disable_immediate.
>

hmm, ok so it should be still good down to 30fps ;-)

I thought we calculated based on frame # and line # on hw that
supported that?  But it's been a while since looking at vblank code

BR,
-R

> > In which case, I think that doesn't
> > matter.
> >
> > BR,
> > -R
> >
> > >
> > > --
> > > Ville Syrj=C3=A4l=C3=A4
> > > Intel
>
> --
> Ville Syrj=C3=A4l=C3=A4
> Intel
