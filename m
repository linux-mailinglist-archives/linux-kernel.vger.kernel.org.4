Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC5C56A5634
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 11:02:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbjB1KCM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 05:02:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjB1KCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 05:02:09 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6199A2B2B1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 02:02:07 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id t11so12436641lfr.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 02:02:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677578525;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=G8hhzXkZOya5l1+2gQHv4ogw/z8WojXSIvbDiC05eoE=;
        b=MYWMJTBduZDw1oZjUVYJ/Gx62kZCfsAKH+pKZl72VmRybCPdz8c0+c9XuI5HU9LyZI
         8p4sLulTSpLvCL640MexO1H6khHPs8ZopBAOP21RNCQnlrIeOaDao3tfZQioSYCNidbg
         8222/93iiHba5q6Xn2rjD7CGiR8fBhzT/LzQzpwu4uIItCYV8Sti9Ku74AHCsyv3U+UK
         HMeu3cDOgIEyBVc76U/MeNHo7pHdBhmfXkCIeFZxWpyXvAeauEC0tOBfdsxyGOfYRtfm
         FdrbdfKTYql8RVT1XtprfNgPZ/ECufwQzmc8kRYmiACgPkeHQqphN5YQr/d4LSOZISOm
         I8pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677578525;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G8hhzXkZOya5l1+2gQHv4ogw/z8WojXSIvbDiC05eoE=;
        b=jYPaHvbx6zK0KgI243BUhbcI50Pn5bjviB6ACpy7oY1pHxbg9yVF9/Gn1rmLNnYu3x
         EcFhbENL0lgFy4nQm8GyiBfDLfbbZw7AHhZp+1xB85BBuYDP9BMGlFk7/xrDSq8S2uUf
         xgOwkOyDVTOUR94V7p+QkT92ILh+ZWfEqOrZJ+xHolsM3jMmD0WyYHn58/fM/As7X+7a
         w0kJTP3OFgGJtIXKRQ8rmgO8kX4aT1YHuIzjO2NHj1+8LjxY+OQd2HWqxRbDb8sK0bMr
         Zutd0TFhRbpG6Wi9IXud8p9aJKj++eUaS1ecQwAk91lK0PjBTFV6BjzPRxlgYQzhCR08
         vkmA==
X-Gm-Message-State: AO0yUKVOL/EnfAaodCjsbs0yBB60EytOT60WE0+mWmhzycfhOl+92TH8
        yVw7tZ/sLHbucKI45Agt83E=
X-Google-Smtp-Source: AK7set9kOzDNcpy7n8owlmf75WwP/agrXt+BlAo3GZFtShfHQENo9cFf98g4cf/XBAOfbuqCzIOskw==
X-Received: by 2002:ac2:5119:0:b0:4db:405f:d5c0 with SMTP id q25-20020ac25119000000b004db405fd5c0mr472382lfb.48.1677578525436;
        Tue, 28 Feb 2023 02:02:05 -0800 (PST)
Received: from eldfell ([194.136.85.206])
        by smtp.gmail.com with ESMTPSA id q2-20020ac25a02000000b004dd6c325311sm1253952lfn.248.2023.02.28.02.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 02:02:04 -0800 (PST)
Date:   Tue, 28 Feb 2023 12:02:01 +0200
From:   Pekka Paalanen <ppaalanen@gmail.com>
To:     =?UTF-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>
Cc:     dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, kernel-dev@igalia.com,
        alexander.deucher@amd.com, contactshashanksharma@gmail.com,
        amaranath.somalapuram@amd.com, christian.koenig@amd.com,
        pierre-eric.pelloux-prayer@amd.com,
        "Simon Ser" <contact@emersion.fr>,
        "Rob Clark" <robdclark@gmail.com>,
        "Daniel Vetter" <daniel@ffwll.ch>,
        "Daniel Stone" <daniel@fooishbar.org>,
        Marek =?UTF-8?B?T2zFocOhaw==?= <maraeo@gmail.com>,
        "Dave Airlie" <airlied@gmail.com>
Subject: Re: [PATCH v2 1/1] drm/doc: Document DRM device reset expectations
Message-ID: <20230228120201.7b20519a@eldfell>
In-Reply-To: <20230227204000.56787-2-andrealmeid@igalia.com>
References: <20230227204000.56787-1-andrealmeid@igalia.com>
        <20230227204000.56787-2-andrealmeid@igalia.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/WWSRvI8mNtp3sX1sMaJYoVm";
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

--Sig_/WWSRvI8mNtp3sX1sMaJYoVm
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 27 Feb 2023 15:40:00 -0500
Andr=C3=A9 Almeida <andrealmeid@igalia.com> wrote:

> Create a section that specifies how to deal with DRM device resets for
> kernel and userspace drivers.
>=20
> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
> ---
>  Documentation/gpu/drm-uapi.rst | 51 ++++++++++++++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
>=20
> diff --git a/Documentation/gpu/drm-uapi.rst b/Documentation/gpu/drm-uapi.=
rst
> index 65fb3036a580..3d6c3ed392ea 100644
> --- a/Documentation/gpu/drm-uapi.rst
> +++ b/Documentation/gpu/drm-uapi.rst
> @@ -285,6 +285,57 @@ for GPU1 and GPU2 from different vendors, and a thir=
d handler for
>  mmapped regular files. Threads cause additional pain with signal
>  handling as well.
> =20
> +Device reset
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The GPU stack is really complex and is prone to errors, from hardware bu=
gs,
> +faulty applications and everything in the many layers in between. To rec=
over
> +from this kind of state, sometimes is needed to reset the GPU. Unproper =
handling
> +of GPU resets can lead to an unstable userspace. This section describes =
what's
> +the expected behaviour from DRM drivers to do in those situations, from =
usermode
> +drivers and compositors as well. The end goal is to have a seamless expe=
rience
> +as possible, either the stack being able to recover itself or resetting =
to a new
> +stable state.
> +
> +Robustness
> +----------
> +
> +First of all, application robust APIs, when available, should be used. T=
his
> +allows the application to correctly recover and continue to run after a =
reset.
> +Apps that doesn't use this should be promptly killed when the kernel dri=
ver
> +detects that it's in broken state. Specifically guidelines for some APIs:

Hi,

the "kill" wording is still here. It feels too harsh to me, like I say
in my comments below, but let's see what others think.

Even the device hot-unplug guide above this does not call for killing
anything and is prepared for userspace to keep going indefinitely if
userspace is broken enough.

> +
> +- OpenGL: KMD signals the abortion of submitted commands and the UMD sho=
uld then
> +  react accordingly and abort the application.

No, not abort. Just return failures and make sure no API call will
block indefinitely.

> +
> +- Vulkan: Assumes that every app is able to deal with ``VK_ERROR_DEVICE_=
LOST``.
> +  If it doesn't do it right, it's considered a broken application and UM=
D will
> +  deal with it, aborting it.

Is it even possible to detect if an app does it right?

What if the app does do it right, but not before it attempts to hammer
a few more jobs in?

> +
> +Kernel mode driver
> +------------------
> +
> +The KMD must be able to detect that something is wrong with the applicat=
ion
> +and that a reset is needed to take place to recover the device (e.g. an =
endless
> +wait). It needs to properly track the context that is broken and mark it=
 as
> +dead, so any other syscalls to that context should be further rejected. =
The
> +other contexts should be preserved when possible, avoid crashing the res=
t of
> +userspace. KMD can ban a file descriptor that keeps causing resets, as i=
t's
> +likely in a broken loop.

If userspace is in a broken loop repeatedly causing GPU reset, would it
keep using the same (render node) fd? To me it would be more likely to
close the fd and open a new one, then crash again. Robust or not, the
gfx library API would probably require tearing everything down and
starting from scratch. In fact, only robust apps would likely exhibit
this behaviour, and non-robust just get stuck or quit themselves.

I suppose in e.g. EGL, it is possible to just create a new context
instead of a new EGLDisplay, so both re-using and not using the old fd
are possible.

The process identity would usually remain, I believe, except in cases
like Chromium with its separate rendering processes, but then, would
you really want to ban whole Chromium in that case...

> +

Another thing for the kernel mode driver maybe worth mentioning is that
the driver could also pretend a hot-unplug if the GPU crash is so bad
that everything is at risk being lost or corrupted.

> +User mode driver
> +----------------
> +
> +During a reset, UMD should be aware that rejected syscalls indicates tha=
t the
> +context is broken and for robust apps the recovery should happen for the
> +context. Non-robust apps must be terminated.

I think the termination thing probably needs to be much more nuanced,
and also interact with the repeat-offender policy.

Repeat-offender policy could be implemented in userspace too,
especially if userspace keeps using the same device fd which is likely
hidden by the gfx API.

> +
> +Compositors
> +-----------
> +
> +Compositors should be robust as well to properly deal with its errors.

What is the worth of this note? To me as a compositor developer it is
obvious.


Thanks,
pq

> +
> +
>  .. _drm_driver_ioctl:
> =20
>  IOCTL Support on Device Nodes


--Sig_/WWSRvI8mNtp3sX1sMaJYoVm
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAmP90RkACgkQI1/ltBGq
qqcuAw//VeEiTkS/jsh5b8dSbIL6C2WakLcErXAtEo65dLIwOdyxueFIAIRzM14K
9SRGg34hvSfmug/0Kqo/0FugRwMfhVxhJ147fZIioQl/VNqEIfHqb480hc7COSG3
BW+FARtBM9k3ZA885aD7pV///+VnxjKCs+0D8gCj7o8jt/SzNGFAAEbB1RohC7kN
9/3kbT7l2K2oIxgEI1uqt5AD4cfLOHO8aR+omS8QBi9q77kjii+XWlwGclmo4tzq
W+HTY9esbbMBLDDIXgc3T2fiC0uWmyK+CWzKD1B6whfkDm+nH5sDxmdfuMAxan3T
Hf7YFgQLRI1WwJ0xQupzrJG+znjJW5M6TpaGh72dFyncCYwB1M8lNVXkzr5QKfWX
ieu2pI8b8iakYlAuBrStO4pQwShK7h5LIXXXJR7R2hhX53pbJ5yPGJZNSYr5mGw7
/PWgbmTW1LkUBzpJauKwEBn8v7aWy4A/ZoJM6/hBGAoy4CoUAsx//kRVaw8LjWQN
feQ1SDEOB8xlQPevx6/1nv7Sv3toZhzkVIpXf7r2guXLD0q5HZYa5PY/7EVT5Xsh
6xqBMZK7blgAXWqKS0eb90bM1iLRKpfHstOni6p65ec4zPZX1UemX+3VMUEPKlxO
dxTNRj6q4IFz7kgEMwY/gMaceHGbHJqxc32WrbiQ9crQ0LEHsaM=
=J8hB
-----END PGP SIGNATURE-----

--Sig_/WWSRvI8mNtp3sX1sMaJYoVm--
