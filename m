Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDC9669DC6A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 09:53:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233819AbjBUIxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 03:53:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231546AbjBUIxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 03:53:14 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC16786AF
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 00:53:12 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id a10so3599326ljq.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 00:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AEjLrRbU07wQYZ0ZI67ekCMILBl/5v5EYiKgA6Atj1I=;
        b=OVcGbtcbYkdrGKtGhQBFsP0w5w/MddBCfR+Oi+1FcIh2wngBwYVt6+VXfhsLFM1sxa
         OxQje6gm9Px25K0Rq3g1iRha+Eg2g7KL4mM//Ue2pFmIeCKMtjiEsBZSJAI5i8EkbF32
         XvH22XwW+lzji4G3uwAJ+JNW3vyChKVaJ5Ko2Oezv9pDpOsAymoNmU2oUgXEEnIFzj/P
         YnqKognbT6DjykjRfmP/dmNa3rYzWzSZ56IZQi173OzomQThTRHlfpshNAoej1uTGqzy
         UVUpLghCWlg6o82EIf4RRSjZ58QYUuO6X0O3A6YdBMXwIwdJ51xJHVriUbpbwvDtN5Bk
         MgBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AEjLrRbU07wQYZ0ZI67ekCMILBl/5v5EYiKgA6Atj1I=;
        b=stpZBh5u29xU4ahkQReK/JfbAyKvHGvtW18Nqap4hiIyxM2j3uYo2dEUEjMOJY6/BT
         FvHKzzZjDwRjOc6KB9TGdkdFLppPQiuDPgmu95A+NiQod/swHSOKaBQMWcjKa9eRvuop
         yk09TlNH4i4I+BLDFg+I6oLVTcdQ2J2Zy1BMiuofzR5bFcIq/Gw78opr7dtuI/R+UWlP
         gKpCmoORssnDlJ0hvxbsrK7ey2qalIZpWbhXE4ekEFngcwIoovqdeqwWFn9Z7+a5aUiW
         uQ6xU5aLr97sZWBonvQ65+c9fVn3xiEwotWl6Ff9c+7ZcgsXT+zqRVoqHSnPlZlZDh4C
         p/Zg==
X-Gm-Message-State: AO0yUKUfhA8HJq66JrbnkY6uKQO2YyHMzkqyDPBp3bDbEfmycXuqEaD7
        1efpkb3iOYMpc1msb+Wes6k=
X-Google-Smtp-Source: AK7set8nMhagnPVfESv/9ZlPIxiZKwBCDck0xrEjqBAmURev2zAHQajnYN10WtnCqkHPBcVmZFZvOg==
X-Received: by 2002:a2e:8e72:0:b0:293:5c90:8517 with SMTP id t18-20020a2e8e72000000b002935c908517mr1246405ljk.15.1676969590834;
        Tue, 21 Feb 2023 00:53:10 -0800 (PST)
Received: from eldfell ([194.136.85.206])
        by smtp.gmail.com with ESMTPSA id d17-20020a2e3611000000b00293524fb6b1sm355733lja.74.2023.02.21.00.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 00:53:10 -0800 (PST)
Date:   Tue, 21 Feb 2023 10:53:07 +0200
From:   Pekka Paalanen <ppaalanen@gmail.com>
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        Daniel Vetter <daniel@ffwll.ch>,
        Christian =?UTF-8?B?S8O2bmln?= <ckoenig.leichtzumerken@gmail.com>,
        Michel =?UTF-8?B?RMOkbnplcg==?= <michel@daenzer.net>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Simon Ser <contact@emersion.fr>,
        Rob Clark <robdclark@chromium.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH v5 09/14] drm/syncobj: Add deadline support for syncobj
 waits
Message-ID: <20230221105307.7430c301@eldfell>
In-Reply-To: <20230220201916.1822214-10-robdclark@gmail.com>
References: <20230220201916.1822214-1-robdclark@gmail.com>
        <20230220201916.1822214-10-robdclark@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/VSEM3Sqv+X/GOgQntXXiV/x";
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

--Sig_/VSEM3Sqv+X/GOgQntXXiV/x
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 20 Feb 2023 12:18:56 -0800
Rob Clark <robdclark@gmail.com> wrote:

> From: Rob Clark <robdclark@chromium.org>
>=20
> Add a new flag to let userspace provide a deadline as a hint for syncobj
> and timeline waits.  This gives a hint to the driver signaling the
> backing fences about how soon userspace needs it to compete work, so it
> can addjust GPU frequency accordingly.  An immediate deadline can be
> given to provide something equivalent to i915 "wait boost".
>=20
> v2: Use absolute u64 ns value for deadline hint, drop cap and driver
>     feature flag in favor of allowing count_handles=3D=3D0 as a way for
>     userspace to probe kernel for support of new flag
>=20
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>  drivers/gpu/drm/drm_syncobj.c | 59 +++++++++++++++++++++++++++--------
>  include/uapi/drm/drm.h        |  5 +++
>  2 files changed, 51 insertions(+), 13 deletions(-)

...

> diff --git a/include/uapi/drm/drm.h b/include/uapi/drm/drm.h
> index 642808520d92..aefc8cc743e0 100644
> --- a/include/uapi/drm/drm.h
> +++ b/include/uapi/drm/drm.h
> @@ -887,6 +887,7 @@ struct drm_syncobj_transfer {
>  #define DRM_SYNCOBJ_WAIT_FLAGS_WAIT_ALL (1 << 0)
>  #define DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT (1 << 1)
>  #define DRM_SYNCOBJ_WAIT_FLAGS_WAIT_AVAILABLE (1 << 2) /* wait for time =
point to become available */
> +#define DRM_SYNCOBJ_WAIT_FLAGS_WAIT_DEADLINE (1 << 3) /* set fence deadl=
ine based to deadline_nsec/sec */

Hi,

where is the UAPI documentation explaining what is a "fence deadline"
and what setting it does here?

btw. no nsec/sec anymore.


Thanks,
pq


>  struct drm_syncobj_wait {
>  	__u64 handles;
>  	/* absolute timeout */
> @@ -895,6 +896,8 @@ struct drm_syncobj_wait {
>  	__u32 flags;
>  	__u32 first_signaled; /* only valid when not waiting all */
>  	__u32 pad;
> +	/* Deadline hint to set on backing fence(s) in CLOCK_MONOTONIC: */
> +	__u64 deadline_ns;
>  };
> =20
>  struct drm_syncobj_timeline_wait {
> @@ -907,6 +910,8 @@ struct drm_syncobj_timeline_wait {
>  	__u32 flags;
>  	__u32 first_signaled; /* only valid when not waiting all */
>  	__u32 pad;
> +	/* Deadline hint to set on backing fence(s) in CLOCK_MONOTONIC: */
> +	__u64 deadline_ns;
>  };
> =20
> =20


--Sig_/VSEM3Sqv+X/GOgQntXXiV/x
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAmP0hnMACgkQI1/ltBGq
qqfUUw//XVeqgeDOtw8oq6xuKdBjOAqnRwLjkzvWi/88co80qy2LH+hR4CUskUUz
G28RzH6tjsu2yM/WTAs2zpzFWmTC5R0d5pfQytNoqPwXpWsjE3AJdDeT5DYI2b6N
HTy3B1G23/CmVdky2sl29T/ZUGNXHZdOiZMTEa6pve9l6XGVa3vhZD8+ezOkSTHB
B8DGAkFnkSXcIaAB9Cr0TBhWvh/vbGhvlcal2WTBJEdD29miP+s1G3GCwCckJ8Ul
Ruj9+Sj8UjgytllWZld0iIcptQnf2yOrjb2vHb5G5chCHXe4sSDJZJvo3FxV0tdp
6qMmV7ECTTyX4IJDxU1l0FY6NZLIUV1HYsjRfj3sNKbbJOh4BBWss8dLl3nfiUtF
4TOqxDohFjaI1EroIrTzmreN5qtDEFEkWc+Kg+0z8qTQXeSWxXn8yAj8AZpoEtZP
eRm372Z2c0PGjXKIE5PZ5W/KtDaD5JynRHI3ZsK777qkDYzqopuD3/TcC0AU5VyP
XtFEbUsm9yRGCQNR2qwJrFxDrgKIoHRC2fmAvLxjGK37XtsVD1XYSX0cBWsOqw2s
jzguoe3iTuwH9o/1fqXvCNzyCtuRB3KsdioQHfxsPr4JulocwkAdwFatQQA9n90v
kwOZoREmqbO1h1/V1+jz0/Ta7ExkSQdZYZgBaG2u0aeDRHfI6L8=
=hlmI
-----END PGP SIGNATURE-----

--Sig_/VSEM3Sqv+X/GOgQntXXiV/x--
