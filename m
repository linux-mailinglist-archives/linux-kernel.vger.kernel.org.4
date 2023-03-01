Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C45DC6A6917
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 09:48:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjCAIsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 03:48:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjCAIsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 03:48:01 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F2E45B84
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 00:47:59 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id y14so13164712ljq.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 00:47:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677660477;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DEgoReXVBB8pt9nqoOD2wmwuAKgg/svj7GF67Xv+CIw=;
        b=SIS6qIUIBG9Xjt5qepOUXnm6NtGzCgL7JQtqtF5CaALzPAzyEbLIodIEoMVb4fJ2Pa
         9lR7uFB9/Ye0RDNIId+EeLNpk3t5zZ1ZFDQcBBAD/ePuOg86wj5mUpgXPCJCmscTn7/k
         hwmOHpcEKZjTdUV7leKygCIHYljq5Sz4RanvHoC/ZhPG0bJX5po/NZk82cW8JwHXdOi2
         h9Jt9KqWVOtmj3RMGawNh3x308LZwyBdK3L1Rbv+a/cA/vPjwDkERP0xvY9cI+rDq6ha
         eBpVrHGcQVKalcI3IKk+Qv69Ivw5Wx1EGeb9aa+wowkOeBBjUQa/PlWdCa405Seuehbz
         Ztyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677660477;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DEgoReXVBB8pt9nqoOD2wmwuAKgg/svj7GF67Xv+CIw=;
        b=W6y4pgCawD5leA8oEnBZJ9Qcq6zWD652qqfiR+gmzxxKjK1d54fjf3qax5Zllsv5IS
         vW3b3fhtMFFBHU54x5vVuOpGNs39R4a8yZ6bKk7SwkmPmgGTKx4SkkzCwHAOkc/Qjmsq
         g/C8OHVpIdCupvCA5wWnYjSJpC4TJ8T3sM9f917pkQe4i5wHt58MKy0Ozl7ZErRNNaT5
         34I+PTBAZIdxk9sDt6PypE5ivHU7sLTdwE5zi8ynnoRZvVprI0470PqF/Knb6XKvxC/f
         8Th801ylBqJPVo8AxJ3ZBesOzw6pQr0A7Sw8l2hiqAcU0Vj9mG1WleVbO5LrsZQVov7N
         RM8w==
X-Gm-Message-State: AO0yUKXqfJ85Xc7bmyH+XSMuDq/U0bf7Gj0A0ue8Q7wPrkJTzxvgNSAn
        2F5EmKXi+nNdhXEGNcYpOPU=
X-Google-Smtp-Source: AK7set84qBX1YSCTqmDEdm80a4oiqFXTIrxAcMlZJCziOLLRN1uGe2AsbUO3owIID4ObB8MLgy2/Iw==
X-Received: by 2002:a2e:9415:0:b0:291:90bf:1cc4 with SMTP id i21-20020a2e9415000000b0029190bf1cc4mr1590970ljh.26.1677660477238;
        Wed, 01 Mar 2023 00:47:57 -0800 (PST)
Received: from eldfell ([194.136.85.206])
        by smtp.gmail.com with ESMTPSA id k22-20020a05651c10b600b002934e1407desm1583618ljn.43.2023.03.01.00.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 00:47:56 -0800 (PST)
Date:   Wed, 1 Mar 2023 10:47:46 +0200
From:   Pekka Paalanen <ppaalanen@gmail.com>
To:     =?UTF-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>
Cc:     dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, kernel-dev@igalia.com,
        alexander.deucher@amd.com, contactshashanksharma@gmail.com,
        amaranath.somalapuram@amd.com, christian.koenig@amd.com,
        pierre-eric.pelloux-prayer@amd.com,
        Simon Ser <contact@emersion.fr>,
        Rob Clark <robdclark@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Daniel Stone <daniel@fooishbar.org>,
        Marek =?UTF-8?B?T2zFocOhaw==?= <maraeo@gmail.com>,
        Dave Airlie <airlied@gmail.com>
Subject: Re: [PATCH v2 1/1] drm/doc: Document DRM device reset expectations
Message-ID: <20230301104746.57b8e32d@eldfell>
In-Reply-To: <0d38d76f-77b4-ec14-fbc3-9c7eee6ce58b@igalia.com>
References: <20230227204000.56787-1-andrealmeid@igalia.com>
        <20230227204000.56787-2-andrealmeid@igalia.com>
        <20230228120201.7b20519a@eldfell>
        <0d38d76f-77b4-ec14-fbc3-9c7eee6ce58b@igalia.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/W9wGaEnleE7BNva3dnHRzKN";
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

--Sig_/W9wGaEnleE7BNva3dnHRzKN
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 28 Feb 2023 10:26:04 -0500
Andr=C3=A9 Almeida <andrealmeid@igalia.com> wrote:

> Hi Pekka,
>=20
> Thank you for your feedback,
>=20
> On 2/28/23 05:02, Pekka Paalanen wrote:
> > On Mon, 27 Feb 2023 15:40:00 -0500
> > Andr=C3=A9 Almeida <andrealmeid@igalia.com> wrote:
> > =20
> >> Create a section that specifies how to deal with DRM device resets for
> >> kernel and userspace drivers.
> >>
> >> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
> >> ---
> >>   Documentation/gpu/drm-uapi.rst | 51 ++++++++++++++++++++++++++++++++=
++
> >>   1 file changed, 51 insertions(+)
> >>
> >> diff --git a/Documentation/gpu/drm-uapi.rst b/Documentation/gpu/drm-ua=
pi.rst
> >> index 65fb3036a580..3d6c3ed392ea 100644
> >> --- a/Documentation/gpu/drm-uapi.rst
> >> +++ b/Documentation/gpu/drm-uapi.rst
> >> @@ -285,6 +285,57 @@ for GPU1 and GPU2 from different vendors, and a t=
hird handler for
> >>   mmapped regular files. Threads cause additional pain with signal
> >>   handling as well.
> >>  =20
> >> +Device reset
> >> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> +
> >> +The GPU stack is really complex and is prone to errors, from hardware=
 bugs,
> >> +faulty applications and everything in the many layers in between. To =
recover
> >> +from this kind of state, sometimes is needed to reset the GPU. Unprop=
er handling
> >> +of GPU resets can lead to an unstable userspace. This section describ=
es what's
> >> +the expected behaviour from DRM drivers to do in those situations, fr=
om usermode
> >> +drivers and compositors as well. The end goal is to have a seamless e=
xperience
> >> +as possible, either the stack being able to recover itself or resetti=
ng to a new
> >> +stable state.
> >> +
> >> +Robustness
> >> +----------
> >> +
> >> +First of all, application robust APIs, when available, should be used=
. This
> >> +allows the application to correctly recover and continue to run after=
 a reset.
> >> +Apps that doesn't use this should be promptly killed when the kernel =
driver
> >> +detects that it's in broken state. Specifically guidelines for some A=
PIs: =20
> > Hi,
> >
> > the "kill" wording is still here. It feels too harsh to me, like I say
> > in my comments below, but let's see what others think.
> >
> > Even the device hot-unplug guide above this does not call for killing
> > anything and is prepared for userspace to keep going indefinitely if
> > userspace is broken enough. =20
>=20
> If I understood correctly, you don't think that neither KMD or UMD=20
> should terminate apps that hangs the GPU, right? Should those apps run=20
> indefinitely until the user decides to do something about it?

I suspect it depends on what exactly is happening. I do think a policy
to do something harsh to repeat offenders would be a good idea, because
they might prevent the end user from breaking out of the situation, but
it needs a definition of what a "repeat offender" is, and from that it
should be possible to say what to do with it.

But yes, I do think that killing anything should not be the first and
immediate reaction. It's not like OOM that hurts everything in the
system, it's just the app itself. It may mean the user may be staring
at a broken screen (app was fullscreen), but then they should be able
to get out of it with Alt+Tab or whatever their window system normally
offers as soon as the GPU reset is done if not immediately.

It is much more likely that arbitrary apps crash a GPU than, say, the
display server (compositor). If a display server causes a reset, there
should be a very high threshold to kill it in any case, because killing
it may mean other applications cannot save their work (there is no
reason why apps would need a display server to do an emergency save,
but not everything implements an emergency save, and maybe that will
cause a logout too).

Telling the difference between applications and display servers is
likely going to be a problem, so I would not even try.

IOW, significant timeouts (several seconds) would also be a usable tool
in the toolbox to return system control back to the end user.

> At least on Intel GPUs, if I run an OpenGL infinite loop the app will be=
=20
> terminated in a few moments, and the rest of userspace is preserved.=20
> There's an app that just do that if you want to have a look on how it=20
> works: https://gitlab.freedesktop.org/andrealmeid/gpu-timeout

How exactly does the app get terminated? An abort in some library? A
signal from the kernel?

I do recall a type of DRM fences guarantee that the fence will signal,
and if it doesn't, the kernel will force-signal it to unblock dependent
work and do something to the job that failed to complete. This kind of
fences are routinely used with KMS and with "naive" display servers,
which means that any application that has a long running GPU job (even
if just for 20 ms) will stall all desktop updates on screen, possibly
even mouse pointer. 20 ms jobs will make the whole desktop feel jerky.
5 second jobs will make the desktop completely unusable.

In that case, to give system control back to the end user, it is not
enough to force-signal fence, because the app will just submit another
one, and your desktop would update once every few seconds - the user
cannot realistically kill the offender, if they even realise which app
it is. So in that case, terminating at least the GPU context is a good
idea. Terminating the process that owned the GPU context is up for
debate.

This situation will change radically, when display servers start
inspecting application fences and postpone using application provided
buffers until the related fence has signalled. Then no app can stall
the whole desktop by simply having long running GPU jobs (assuming
those jobs can be pre-empted). Then none of the force signalling or
terminating will be necessary to survive a broken application.

>=20
> > =20
> >> +
> >> +- OpenGL: KMD signals the abortion of submitted commands and the UMD =
should then
> >> +  react accordingly and abort the application. =20
> > No, not abort. Just return failures and make sure no API call will
> > block indefinitely.
> > =20
> >> +
> >> +- Vulkan: Assumes that every app is able to deal with ``VK_ERROR_DEVI=
CE_LOST``.
> >> +  If it doesn't do it right, it's considered a broken application and=
 UMD will
> >> +  deal with it, aborting it. =20
> > Is it even possible to detect if an app does it right?
> >
> > What if the app does do it right, but not before it attempts to hammer
> > a few more jobs in? =20
>=20
> I think what I meant was
>=20
> + If it doesn't support VK_ERROR_DEVICE_LOST, it's considered a broken=20
> app [...]
>=20
> In the sense that if it doesn't support this, it is impossible for the=20
> app to recovery gracefully from a reset so it's considered broken

What does it mean to support VK_ERROR_DEVICE_LOST?

What if the app does support and react to VK_ERROR_DEVICE_LOST, but not
on the first API call that returns it? What about API calls that cannot
return it? Where do you draw the line?

> >> +
> >> +Kernel mode driver
> >> +------------------
> >> +
> >> +The KMD must be able to detect that something is wrong with the appli=
cation
> >> +and that a reset is needed to take place to recover the device (e.g. =
an endless
> >> +wait). It needs to properly track the context that is broken and mark=
 it as
> >> +dead, so any other syscalls to that context should be further rejecte=
d. The
> >> +other contexts should be preserved when possible, avoid crashing the =
rest of
> >> +userspace. KMD can ban a file descriptor that keeps causing resets, a=
s it's
> >> +likely in a broken loop. =20
> > If userspace is in a broken loop repeatedly causing GPU reset, would it
> > keep using the same (render node) fd? To me it would be more likely to
> > close the fd and open a new one, then crash again. Robust or not, the
> > gfx library API would probably require tearing everything down and
> > starting from scratch. In fact, only robust apps would likely exhibit
> > this behaviour, and non-robust just get stuck or quit themselves.
> >
> > I suppose in e.g. EGL, it is possible to just create a new context
> > instead of a new EGLDisplay, so both re-using and not using the old fd
> > are possible.
> >
> > The process identity would usually remain, I believe, except in cases
> > like Chromium with its separate rendering processes, but then, would
> > you really want to ban whole Chromium in that case...
> > =20
> Right, so userspace is the right place to implement the repeat-offender=20
> policy, as you noted below.

I think it probably depends... if userspace could do it, it is likely
the right place.


Thanks,
pq

> >> + =20
> > Another thing for the kernel mode driver maybe worth mentioning is that
> > the driver could also pretend a hot-unplug if the GPU crash is so bad
> > that everything is at risk being lost or corrupted. =20
>=20
> Ack, I'll add that
>=20
> > =20
> >> +User mode driver
> >> +----------------
> >> +
> >> +During a reset, UMD should be aware that rejected syscalls indicates =
that the
> >> +context is broken and for robust apps the recovery should happen for =
the
> >> +context. Non-robust apps must be terminated. =20
> > I think the termination thing probably needs to be much more nuanced,
> > and also interact with the repeat-offender policy.
> >
> > Repeat-offender policy could be implemented in userspace too,
> > especially if userspace keeps using the same device fd which is likely
> > hidden by the gfx API.
> > =20
> >> +
> >> +Compositors
> >> +-----------
> >> +
> >> +Compositors should be robust as well to properly deal with its errors=
. =20
> > What is the worth of this note? To me as a compositor developer it is
> > obvious. =20
>=20
> As it is it doesn't says much indeed, I think Christian suggestion adds=20
> something more meaningful to this part.
>=20
> >
> > Thanks,
> > pq
> > =20
> >> +
> >> +
> >>   .. _drm_driver_ioctl:
> >>  =20
> >>   IOCTL Support on Device Nodes =20


--Sig_/W9wGaEnleE7BNva3dnHRzKN
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAmP/ETIACgkQI1/ltBGq
qqdkSBAAtEH0R2+Ki6JavJ3hYp4i5N6nOlYfpFyaPIXYHQ8DgLAWi9oj3C6wtOmp
tPypIyBGZW8ie0R3QvBvuaiHN9mfRuIR4CIPVPLGKF3KyAbakVstqD5BNBDhldx3
k6mwPRGMjIJ7X7UgGIGUI8F1sQNjST9cMsMxqTw2kO6qMuRUH57fkGCKi/+wevmr
XStoESI9cdWQvYaNuoQPov0sHqOkcWeBqcDf/ijDkwkf55JZOvh6LLKHLV0EcxNr
bjWFUbhexd7TTAn7xO+S2s99UWoIyyUfapHdHOcFcCBT1wZyNols8RqqtVBgvL05
hqXvuu7hV/FBxSAoWKsOQ5aaHjhjgD0MQY2dlfOTHNL636RG/4l3SEOWsFsxu6dE
x8Sy3APPC4aStsYEC45ovyKDQDl1q9Esw7d5NShLXSaLC+ztNrpNx3jTN0BVYXCI
3dImpFct/1I8aA77QesFfFIjQhFGLSiOt1QJa8IBvyZaeEedF17xxQEzF7har+5F
8i4hEyykDIVte0Wvh18bnyR+zT03R9YL+eAnEBEufi0LzYPK2Po+q6bfdYo8seM8
4tDjQP7qchmOLw3Ee2e91d8Xrmn3wrpHW7ad8HUNqCxHydGdXF1zM+dUeche2kqR
KalqyZ9Ns4qJV3veK5cjVAZV6t/MtkEbPNypdcc+hpbH+xDH03A=
=Nwl2
-----END PGP SIGNATURE-----

--Sig_/W9wGaEnleE7BNva3dnHRzKN--
