Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1350269F250
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 10:57:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231960AbjBVJ5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 04:57:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232321AbjBVJ5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 04:57:25 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 850EE30E3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 01:57:06 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id k14so8279324lfj.7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 01:57:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kuN6LRtkGhbHCZ4da3565uxXphJdjdeuFluVUGowqGg=;
        b=WzSI+KiBBC3jAwxezARla8d2Qgyg2/BCu7x2e1gD+5Jt4tRGT+idGqXhy0My7enpiR
         Ua1cAPdIZnzSId9ICavmEXeK8iFOw3DGaqW4OYkO7MDswSvgFUbxSV5RyQZBUp+NhAQb
         H8vdQ/F9CEAuJezxVXz04ov3TF2viRO4torx1qvHDQE0WJIRISPv+eh7cd1EN73lZA3n
         JsKEcGIsy4s/paQ5UYsH224lxsmc4QZADdOn9R7ZeTkiyYyiKRlo4rgXxuxUHS8TEYO9
         JGnAYqpnNnEwP51sp0CqYMxuLFILsepb4PCkI85v0dQmphKzAZ5kbMXyycVq4F1ixaVT
         5TAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kuN6LRtkGhbHCZ4da3565uxXphJdjdeuFluVUGowqGg=;
        b=6vxbfXi42WyNdYtBKg51pMPE98peNxeiNv+kYap1adbe/lI8X7cuPuwc9EE2w577Z7
         RMD1acPdYe2CGfrG7zsMy8ma04WwBMP8cl7NEC4GyvsgRiWm8uW5MCMxeFiyFBJtXUNT
         C9C7Q+LNmoKid0iymE6Id9l8vxOF0cNH1OJQHKwjvCHly8QbPXnPljD7+a4Da8LFy1s0
         kqoNaArsuwLTkeFmRBw0FSLmh3kGwHbIFcxBwUU4EHTucaa9winO11GeKI34BCOpytLr
         2FMxRAHnfO/paYjYKjxTXKO5XrWxZ3Hj1EH0OAENulTNGmvCOG4bD8GD6l4gmjZtqhLG
         Vwcg==
X-Gm-Message-State: AO0yUKUuXXtmErWj8VqcEfN02+mASaOsvAQ8/Eam6kicz8yjGp777bVJ
        mm76Bv0fWBjwYkiNVGPs+H4=
X-Google-Smtp-Source: AK7set9YnqmGQK8ML+0jSk2KZBE93SkmbSxyMIEtQf8JQcY7ljpNvNJihBoD9Rmdd2N6ye0t55trEg==
X-Received: by 2002:ac2:491d:0:b0:4c0:2ddc:4559 with SMTP id n29-20020ac2491d000000b004c02ddc4559mr2677307lfi.69.1677059824617;
        Wed, 22 Feb 2023 01:57:04 -0800 (PST)
Received: from eldfell ([194.136.85.206])
        by smtp.gmail.com with ESMTPSA id b14-20020ac25e8e000000b004cb1e2f8f4dsm292734lfq.152.2023.02.22.01.57.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 01:57:04 -0800 (PST)
Date:   Wed, 22 Feb 2023 11:57:00 +0200
From:   Pekka Paalanen <ppaalanen@gmail.com>
To:     Rob Clark <robdclark@gmail.com>
Cc:     Ville =?UTF-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Rob Clark <robdclark@chromium.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Christian =?UTF-8?B?S8O2bmln?= <ckoenig.leichtzumerken@gmail.com>,
        Michel =?UTF-8?B?RMOkbnplcg==?= <michel@daenzer.net>,
        open list <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        freedreno@lists.freedesktop.org
Subject: Re: [PATCH v4 10/14] drm/vblank: Add helper to get next vblank time
Message-ID: <20230222115700.138d824c@eldfell>
In-Reply-To: <CAF6AEGumfEeGQQaEoEm4hzJajCOBBTrWxPQ9MTh7jt-Mov2FEQ@mail.gmail.com>
References: <20230218211608.1630586-1-robdclark@gmail.com>
        <20230218211608.1630586-11-robdclark@gmail.com>
        <20230220110820.595cfa37@eldfell>
        <CAF6AEGuo-vmW4Va9=RH+kH9KgNvR2vzjJ8meO-oty56xjDhjgg@mail.gmail.com>
        <20230221104551.60d44d1c@eldfell>
        <Y/TAr64SpxO712RB@intel.com>
        <CAF6AEGumfEeGQQaEoEm4hzJajCOBBTrWxPQ9MTh7jt-Mov2FEQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/M7W=iwvhn=7CJcrxtPxEHVQ";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/M7W=iwvhn=7CJcrxtPxEHVQ
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 21 Feb 2023 09:50:20 -0800
Rob Clark <robdclark@gmail.com> wrote:

> On Tue, Feb 21, 2023 at 5:01 AM Ville Syrj=C3=A4l=C3=A4
> <ville.syrjala@linux.intel.com> wrote:
> >
> > On Tue, Feb 21, 2023 at 10:45:51AM +0200, Pekka Paalanen wrote: =20
> > > On Mon, 20 Feb 2023 07:55:41 -0800
> > > Rob Clark <robdclark@gmail.com> wrote:
> > > =20
> > > > On Mon, Feb 20, 2023 at 1:08 AM Pekka Paalanen <ppaalanen@gmail.com=
> wrote: =20
> > > > >
> > > > > On Sat, 18 Feb 2023 13:15:53 -0800
> > > > > Rob Clark <robdclark@gmail.com> wrote:
> > > > > =20
> > > > > > From: Rob Clark <robdclark@chromium.org>
> > > > > >
> > > > > > Will be used in the next commit to set a deadline on fences tha=
t an
> > > > > > atomic update is waiting on.
> > > > > >
> > > > > > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > > > > > ---
> > > > > >  drivers/gpu/drm/drm_vblank.c | 32 ++++++++++++++++++++++++++++=
++++
> > > > > >  include/drm/drm_vblank.h     |  1 +
> > > > > >  2 files changed, 33 insertions(+)
> > > > > >
> > > > > > diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm=
_vblank.c
> > > > > > index 2ff31717a3de..caf25ebb34c5 100644
> > > > > > --- a/drivers/gpu/drm/drm_vblank.c
> > > > > > +++ b/drivers/gpu/drm/drm_vblank.c
> > > > > > @@ -980,6 +980,38 @@ u64 drm_crtc_vblank_count_and_time(struct =
drm_crtc *crtc,
> > > > > >  }
> > > > > >  EXPORT_SYMBOL(drm_crtc_vblank_count_and_time);
> > > > > >
> > > > > > +/**
> > > > > > + * drm_crtc_next_vblank_time - calculate the time of the next =
vblank
> > > > > > + * @crtc: the crtc for which to calculate next vblank time
> > > > > > + * @vblanktime: pointer to time to receive the next vblank tim=
estamp.
> > > > > > + *
> > > > > > + * Calculate the expected time of the next vblank based on tim=
e of previous
> > > > > > + * vblank and frame duration =20
> > > > >
> > > > > Hi,
> > > > >
> > > > > for VRR this targets the highest frame rate possible for the curr=
ent
> > > > > VRR mode, right?
> > > > > =20
> > > >
> > > > It is based on vblank->framedur_ns which is in turn based on
> > > > mode->crtc_clock.  Presumably for VRR that ends up being a maximum?=
 =20
> > >
> > > I don't know. :-) =20
> >
> > At least for i915 this will give you the maximum frame
> > duration. =20
>=20
> I suppose one could argue that maximum frame duration is the actual
> deadline.  Anything less is just moar fps, but not going to involve
> stalling until vblank N+1, AFAIU
>=20
> > Also this does not calculate the the start of vblank, it
> > calculates the start of active video. =20
>=20
> Probably something like end of previous frame's video..  might not be
> _exactly_ correct (because some buffering involved), but OTOH on the
> GPU side, I expect the driver to set a timer for a few ms or so before
> the deadline.  So there is some wiggle room.

The vblank timestamp is defined to be the time of the first active
pixel of the frame in the video signal. At least that's the one that
UAPI carries (when not tearing?). It is not the start of vblank period.

With VRR, the front porch before the first active pixel can be multiple
milliseconds. The difference between 144 Hz and 60 Hz is 9.7 ms for
example.


Thanks,
pq

--Sig_/M7W=iwvhn=7CJcrxtPxEHVQ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAmP15uwACgkQI1/ltBGq
qqcTQQ/+JY9jIHrwOwFSVTo8dQnuLQIKytAtICMIYTksqoyp6zncsjOUCjcrwHT7
9y+inchbzV67ojc2FwtwSIy8VhprChwqYIWPIoHuEnqLWj5KWpTj6IDx3j1bYSS+
w5bNtoW5D3Uzqrh56wv9TatDde21d++KWQSIwsUqGIg1YGibTv6Kxq+aUqUrpOOx
wIWQ7vOW5NW7EHd++EoSy4k5hdpOfPeO+D2ioDDAepnSxz/KCImL5/RYcSNXV3Yn
hDrgIdV1wELvrqawBMdZMp2mg3fZlzD2j3uz3D98o4/KVqi6A9m8JdKqVlVVeBVq
R95ExwNR1qaLT9DXISJ94bN/SzKUXWKFKp0Ne0aDYbcOE4FnKL9Ue4/XHRen2Qnk
f9ElTe/gf837i5wcSMW2LR64x5rvXuDZacQTM3o2r79j+CgWq4DuLHMLaTqrSBKa
OP6+m6US4OuTW3/Dfhj/kFDDKPmb1LR7lOfzTMDc/E+mmr/7zr3idL9XKboW3gqN
eQeKLQKSPaGQvJe3QPadil2tKUuGHSZO5njCmPKkrs7IRF10GYvRtiD/qcgSC3kC
xIeniTr8MbNlUvJAlyWr1BB+Fqo6V7du0ZbBUAAatcvjEvSNkfbjxe/h2Oycavgq
pPTX7fqdv0T4bMdYa2pwrIUvqNM1CQyFL8h4PsjiX2nFQnJJ0sw=
=iEiR
-----END PGP SIGNATURE-----

--Sig_/M7W=iwvhn=7CJcrxtPxEHVQ--
