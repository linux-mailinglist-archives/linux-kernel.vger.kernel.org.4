Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65852737CC2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 10:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbjFUH7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 03:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbjFUH66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 03:58:58 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF6D81710
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 00:58:56 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id 2adb3069b0e04-4f86e6e4038so4005701e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 00:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687334335; x=1689926335;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BmSAygbD6EkvA7GUqb4P6MJxCnbur3C+bOMnOpd/iwA=;
        b=h5G23CqXtIzoETQo3ZtLgU/wkbsxiL/IsiEnhzoYosvK4h6Bux3nb4EBn1rn3/Hc32
         1T+lQGRghHW/oK7nBJMIvfzvAJoBi7AI3l3Fme/NqFHqWWR3a49mNXs3qhkI1qQL9uyV
         H6o8+DFOn0oXpEoeZ5U50CDC29ltHffL+oghIu5YffFjxULaBWPCtN4BwoynRBYetZ/9
         730n9A4X3b9mEoF+O+bvWBsZOeiMLJSYLZUWQgYkDOgTzgluZkmxJVQjuIyohdfBh8wt
         XScuF9RHOuw+JSKCxof6tyTfSdNAXXGnxwx152LUVwKefhrWTed0570+R0mL0g/1i/zT
         UNng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687334335; x=1689926335;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BmSAygbD6EkvA7GUqb4P6MJxCnbur3C+bOMnOpd/iwA=;
        b=d9HIKWLDcMXeAfJXr4jbSUzWeGzjPZICNltsN5GsD0a6WCdOPqC3UD2X7wRqu3gxQp
         izz7If8ehIGYeAUIzDBhsSBE5/vFhmm+wySay8ycdZo6o8gJ8e4LOBD3hDeU7ai8LWMl
         AjygQmFJCcZkmzkCUeAY562A8uYndNe+hm6sUhmDkrvPpImwIlDbs7+yM9ldYA36V9/6
         019x3qUrCUQDJQBvkxv1l50bs2JveDE3jM/S9y7iI69ZTPm36iJR1fa7DnQnByxwcwuq
         icrqzPyhfANInDJTY3Y8eKDGPLScWSw+O7JAwc1uBMfSZGCc/AeigWEHfhyV1zfmUQUv
         j0Cg==
X-Gm-Message-State: AC+VfDxpSy1Ve5KrT0EcIexnVeVeIW40YMadkwSrvulCe+uGn8jE8rA4
        2Zkn90zVoJRgngMprrv1ymI=
X-Google-Smtp-Source: ACHHUZ6Rm8f0B26LStUq0S8qtHVX19aMsfJ9JXuoOUX+FCfueErTvuX4lpavQ/n/G7WLyMd8n8wupg==
X-Received: by 2002:a05:6512:31c9:b0:4f8:5e4e:52ad with SMTP id j9-20020a05651231c900b004f85e4e52admr3962783lfe.23.1687334334741;
        Wed, 21 Jun 2023 00:58:54 -0700 (PDT)
Received: from eldfell ([194.136.85.206])
        by smtp.gmail.com with ESMTPSA id a12-20020a19f80c000000b004f8653b60e3sm677012lff.97.2023.06.21.00.58.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 00:58:54 -0700 (PDT)
Date:   Wed, 21 Jun 2023 10:58:42 +0300
From:   Pekka Paalanen <ppaalanen@gmail.com>
To:     =?UTF-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>
Cc:     dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, kernel-dev@igalia.com,
        alexander.deucher@amd.com, christian.koenig@amd.com,
        pierre-eric.pelloux-prayer@amd.com,
        Simon Ser <contact@emersion.fr>,
        Rob Clark <robdclark@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Daniel Stone <daniel@fooishbar.org>,
        'Marek =?UTF-8?B?T2zFocOhayc=?= <maraeo@gmail.com>,
        Dave Airlie <airlied@gmail.com>,
        Michel =?UTF-8?B?RMOkbnplcg==?= <michel.daenzer@mailbox.org>,
        Samuel Pitoiset <samuel.pitoiset@gmail.com>,
        Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>,
        Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Subject: Re: [RFC PATCH v3 1/4] drm/doc: Document DRM device reset
 expectations
Message-ID: <20230621105842.0c21b161@eldfell>
In-Reply-To: <20230621005719.836857-2-andrealmeid@igalia.com>
References: <20230621005719.836857-1-andrealmeid@igalia.com>
        <20230621005719.836857-2-andrealmeid@igalia.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/yw0Fy1hd4X=X9eo17=PTM8B";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/yw0Fy1hd4X=X9eo17=PTM8B
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 20 Jun 2023 21:57:16 -0300
Andr=C3=A9 Almeida <andrealmeid@igalia.com> wrote:

> Create a section that specifies how to deal with DRM device resets for
> kernel and userspace drivers.
>=20
> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>

Hi Andr=C3=A9,

nice to see this! I ended up giving lots of grammar comments, but I'm
not a native speaker. Generally it looks good to me.

> ---
>  Documentation/gpu/drm-uapi.rst | 65 ++++++++++++++++++++++++++++++++++
>  1 file changed, 65 insertions(+)
>=20
> diff --git a/Documentation/gpu/drm-uapi.rst b/Documentation/gpu/drm-uapi.=
rst
> index 65fb3036a580..da4f8a694d8d 100644
> --- a/Documentation/gpu/drm-uapi.rst
> +++ b/Documentation/gpu/drm-uapi.rst
> @@ -285,6 +285,71 @@ for GPU1 and GPU2 from different vendors, and a thir=
d handler for
>  mmapped regular files. Threads cause additional pain with signal
>  handling as well.
> =20
> +Device reset
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The GPU stack is really complex and is prone to errors, from hardware bu=
gs,
> +faulty applications and everything in between the many layers. To recover
> +from this kind of state, sometimes is needed to reset the device. This s=
ection

It seems unclear what "this kind of state" refers to, so maybe just write "=
errors"?

Maybe:

	Some errors require resetting the device in order to make the
	device usable again.

I presume that recovery does not mean that the failed job could recover.

> +describes what's the expectations for DRM and usermode drivers when a de=
vice
> +resets and how to propagate the reset status.
> +
> +Kernel Mode Driver
> +------------------
> +
> +The KMD is responsible for checking if the device needs a reset, and to =
perform
> +it as needed. Usually a hung is detected when a job gets stuck executing=
. KMD

s/hung/hang/ ?

> +then update it's internal reset tracking to be ready when userspace asks=
 the

updates its

"update reset tracking"... do you mean that KMD records information
about the reset in case userspace asks for it later?

> +kernel about reset information. Drivers should implement the DRM_IOCTL_G=
ET_RESET
> +for that.

At this point, I'm not sure what "reset tracking" or "reset
information" entails. Could something be said about those?

> +
> +User Mode Driver
> +----------------
> +
> +The UMD should check before submitting new commands to the KMD if the de=
vice has
> +been reset, and this can be checked more often if it requires to. The
> +DRM_IOCTL_GET_RESET is the default interface for those kind of checks. A=
fter
> +detecting a reset, UMD will then proceed to report it to the application=
 using
> +the appropriated API error code, as explained in the bellow section about

s/bellow/below/

> +robustness.
> +
> +Robustness
> +----------
> +
> +The only way to try to keep an application working after a reset is if it
> +complies with the robustness aspects of the graphical API that is using.

that it is using.

> +
> +Graphical APIs provide ways to application to deal with device resets. H=
owever,

provide ways for applications to deal with

> +there's no guarantee that the app will be correctly using such features,=
 and UMD
> +can implement policies to close the app if it's a repeating offender, li=
kely in
> +a broken loop. This is done to ensure that it doesn't keeps blocking the=
 user

does not keep

I think contractions are usually avoided in documents, but I'm not
bothering to flag them all.

> +interface to be correctly displayed.

interface from being correctly displayed.

> +
> +OpenGL
> +~~~~~~
> +
> +Apps using OpenGL can rely on ``GL_ARB_robustness`` to be robust. This e=
xtension
> +tells if a reset has happened, and if so, all the context state is consi=
dered
> +lost and the app proceeds by creating new ones. If robustness isn't in u=
se, UMD
> +will terminate the app when a reset is detected, giving that the context=
s are
> +lost and the app won't be able to figure this out and recreate the conte=
xts.

What about GL ES? Is GL_ARB_robustness implemented or even defined there?

What about EGL returning errors like EGL_CONTEXT_LOST, would handling that =
not
be enough from the app? The documented expectation is: "The application
must destroy all contexts and reinitialise OpenGL ES state and objects
to continue rendering."

> +
> +Vulkan
> +~~~~~~
> +
> +Apps using Vulkan should check for ``VK_ERROR_DEVICE_LOST`` for submissi=
ons.
> +This error code means, among other things, that a device reset has happe=
ned and
> +it needs to recreate the contexts to keep going.
> +
> +Reporting resets causes
> +-----------------------
> +
> +Apart from propagating the reset through the stack so apps can recover, =
it's
> +really useful for driver developers to learn more about what caused the =
reset in
> +first place. DRM devices should make use of devcoredump to store relevant
> +information about the reset, so this information can be added to user bug
> +reports.
> +
>  .. _drm_driver_ioctl:
> =20
>  IOCTL Support on Device Nodes

What about VRAM contents? If userspace holds a dmabuf handle, can a GPU
reset wipe that buffer? How would that be communicated?

The dmabuf may have originated in another process.


Thanks,
pq

--Sig_/yw0Fy1hd4X=X9eo17=PTM8B
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAmSSrbIACgkQI1/ltBGq
qqfUxg/+I3wOv/XPHKZJEqpufj4W77iXEA4ac4TE2nP4n9D7+gcGnEJcgrEIAa09
qIc+XxW4Q81X+lT67qQx/D1P/oJcgVqM5u0Qw63QIUSAlKNekN3oHwjBxccsoUd8
LLKdk+rpf8234kMZ8bK0OOaTV/LsB1VJ4VMUeTMdVXURsjt5pGLZce6/JXAkDN3t
ggQDwHOKTDJefMdMe4PmF8dIMrlPSxn3DNL/T1mMI0lB1pMTEpD6RwYmfg2UXg7T
/WtgfBgWMf8ReqFL5rzJCNUSLmN4kqHVbZe6Qg1RHfYYQkQm5Pr283UydGGly8pg
jxyniEHmUGIHFpYuww+bRwSNOCPuib1Kx9yuS7ECjKYf5mSe+fmP6oUAxSw92yyi
9AtKRBku4XdpuxJHczys5zYUPPhsSfuvKw34d+WaTC/3PNL044cAdmAKHOV8yhci
nLzrOeodcUopMsEnYJeCX0zLcaP1LfWjNjr9yvl0KDYwO/cp7rmGVnRCOorTwh8s
ABfldUX/B0AqskhsQwatX5iY2QDHxSu+KtJEAGMSixrMz/sRbjMWl07qwNofFdL9
iF8SZOBmZYXk6fU1qfxDQBb4eL0sV3xiV8f+Vbb8yOuKU8VDo2fcZaZQeetIzrUR
C+ErvyoXta31AkD+HPRh5Py4vEhmcwMbJMDGd3QQsxpF+6KUGPQ=
=AnIf
-----END PGP SIGNATURE-----

--Sig_/yw0Fy1hd4X=X9eo17=PTM8B--
