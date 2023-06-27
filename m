Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3754373F5BB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 09:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbjF0Hal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 03:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231787AbjF0HaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 03:30:13 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 242591FC4
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 00:30:11 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id 2adb3069b0e04-4fb7b2e3dacso2149271e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 00:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687851010; x=1690443010;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2tGkXgqPnO73+Ge79y8eYh7hyEhs9j1/fEjMENH9dVw=;
        b=l/9PvrGnvCGdt67tEHQovr48fd+oAw102q/o6VU/akdHFNQJ0SGHwZNdJGwxIK3ih0
         D+AuXiZgTdtP8Tfy0Sb6Z+1y9LwUD5V+Gh+w+7SmyubuhNCY9QoVliGmAtGjBu1wT/Ry
         fYw6LxXLMEklFWdQuAcNYHJthLP66xf8Z0m5AoNRqY4JymlxDE5Ztw77JhWUlA6L21Gs
         n7gRzP0RH6b0x6QN1nFxoJjBhFPKTRNuDrtCZTCIm1gtPl02cgkErxECvySBtJSVITup
         W36H4GTB4nqqGMeRl+UGvIXzxYb5JJ4pPs9fEoZQj406Qn+BsCCzoV2pY50eAtxdH46e
         1X4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687851010; x=1690443010;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2tGkXgqPnO73+Ge79y8eYh7hyEhs9j1/fEjMENH9dVw=;
        b=GqGczZvDtejnByrvOpiL+91ESnKPUsBYsxTZPWTL7BTAwktXL1RPhsT7GZ6ZI/XlzO
         y80YDA0p3wcj/nVeFxtRhuJgqyXeMAxn4hfQEARmEY9HPr+qYhVo46YB1BLDTR0nCiRm
         nuuzcpUpo37fNDvtWomctHCdgvscYwFOBVxDlb4xEviP6CCoZ84j8NtuRbdVwkm9d6oN
         7OfCNDdwe+gQS79FQJV2QBWqzJHD7iwKW+jBxfILv3CJIIez40oQ5/k8qIRTO4FyCX4N
         rXkJNDKUj/pbBlkpMNCfhXiGjstNbPhlPac0FaMhU8yoAaGqcBGtV5EVAzyCzWCgJl5o
         EpBw==
X-Gm-Message-State: AC+VfDynbFy97cabPoth+v6juSlqcnop6w7hIEzGk7dad2ld0sR7CTkd
        kX9ozFTcSo8+9+RdZlP4MRU=
X-Google-Smtp-Source: ACHHUZ71r5/kDhdT11gZFM7z5vHTCReKWrlCcy770IWoTfq3m+v0hoMkISN2LAe0BwO1tDdKUt6riQ==
X-Received: by 2002:a05:6512:2824:b0:4fb:7888:7e6d with SMTP id cf36-20020a056512282400b004fb78887e6dmr3264331lfb.46.1687851009721;
        Tue, 27 Jun 2023 00:30:09 -0700 (PDT)
Received: from eldfell ([194.136.85.206])
        by smtp.gmail.com with ESMTPSA id b25-20020ac25e99000000b004fb85ffc82csm107306lfq.10.2023.06.27.00.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 00:30:09 -0700 (PDT)
Date:   Tue, 27 Jun 2023 10:29:55 +0300
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
Subject: Re: [PATCH v4 1/1] drm/doc: Document DRM device reset expectations
Message-ID: <20230627102955.6a2c5796@eldfell>
In-Reply-To: <20230626183347.55118-2-andrealmeid@igalia.com>
References: <20230626183347.55118-1-andrealmeid@igalia.com>
        <20230626183347.55118-2-andrealmeid@igalia.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/orsJdneEox0Kbc+g6Dj4_fM";
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

--Sig_/orsJdneEox0Kbc+g6Dj4_fM
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 26 Jun 2023 15:33:47 -0300
Andr=C3=A9 Almeida <andrealmeid@igalia.com> wrote:

> Create a section that specifies how to deal with DRM device resets for
> kernel and userspace drivers.
>=20
> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
> ---
>  Documentation/gpu/drm-uapi.rst | 68 ++++++++++++++++++++++++++++++++++
>  1 file changed, 68 insertions(+)

Hi,

grammar nitpicks notwithstanding, I'm happy with the contents now, so

Acked-by: Pekka Paalanen <pekka.paalanen@collabora.com>


Thanks,
pq

>=20
> diff --git a/Documentation/gpu/drm-uapi.rst b/Documentation/gpu/drm-uapi.=
rst
> index 65fb3036a580..25a11b9b98fa 100644
> --- a/Documentation/gpu/drm-uapi.rst
> +++ b/Documentation/gpu/drm-uapi.rst
> @@ -285,6 +285,74 @@ for GPU1 and GPU2 from different vendors, and a thir=
d handler for
>  mmapped regular files. Threads cause additional pain with signal
>  handling as well.
> =20
> +Device reset
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The GPU stack is really complex and is prone to errors, from hardware bu=
gs,
> +faulty applications and everything in between the many layers. Some erro=
rs
> +require resetting the device in order to make the device usable again. T=
his
> +section describes what is the expectations for DRM and usermode drivers =
when a
> +device resets and how to propagate the reset status.
> +
> +Kernel Mode Driver
> +------------------
> +
> +The KMD is responsible for checking if the device needs a reset, and to =
perform
> +it as needed. Usually a hang is detected when a job gets stuck executing=
. KMD
> +should keep track of resets, because userspace can query any time about =
the
> +reset stats for an specific context. This is needed to propagate to the =
rest of
> +the stack that a reset has happened. Currently, this is implemented by e=
ach
> +driver separately, with no common DRM interface.
> +
> +User Mode Driver
> +----------------
> +
> +The UMD should check before submitting new commands to the KMD if the de=
vice has
> +been reset, and this can be checked more often if it requires to. After
> +detecting a reset, UMD will then proceed to report it to the application=
 using
> +the appropriated API error code, as explained in the below section about
> +robustness.
> +
> +Robustness
> +----------
> +
> +The only way to try to keep an application working after a reset is if it
> +complies with the robustness aspects of the graphical API that it is usi=
ng.
> +
> +Graphical APIs provide ways to application to deal with device resets. H=
owever,
> +there is no guarantee that the app will be correctly using such features=
, and
> +UMD can implement policies to close the app if it is a repeating offende=
r,
> +likely in a broken loop. This is done to ensure that it does not keeps b=
locking
> +the user interface from being correctly displayed. This should be done e=
ven if
> +the app is correct but happens to trigger some bug in the hardware/drive=
r.
> +
> +OpenGL
> +~~~~~~
> +
> +Apps using OpenGL should use the available robust interfaces, like the
> +extension ``GL_ARB_robustness`` (or ``GL_EXT_robustness`` for OpenGL ES)=
. This
> +interface tells if a reset has happened, and if so, all the context stat=
e is
> +considered lost and the app proceeds by creating new ones. If is possibl=
e to
> +determine that robustness is not in use, UMD will terminate the app when=
 a reset
> +is detected, giving that the contexts are lost and the app won't be able=
 to
> +figure this out and recreate the contexts.
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


--Sig_/orsJdneEox0Kbc+g6Dj4_fM
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAmSaj/MACgkQI1/ltBGq
qqfDXRAAm2d0qCfUurM9gqoskeR0oqeuQx2qnSmrJ0JdOxYVwnhUgFa5jqiWP0Jt
15vwqIgqKkJTBaREdBZ0T3WeRZnm8DFWcol+qAwU1WV4rXzdjfAIwv0L4UjPDbBD
VDA2uAfrMYvoKApiuLCpleMbFnKD79nkWe/FDkrZksGTFmK/u2SDFFMJXAhEoy7s
3PwNvUbHijAeTgSwu68qJ4zMM1uLZI4ff6eWuS6GQKiLk8zCnZN+/6NmKk/pgVlo
Mr+1Br1/ZaHV78LQNZWyuq+njnyC7I2pyx3Qy/1X0Tka8PapG5V2QVZLMnnc4WI3
nSwCOYDMpQ8yGNRoSRZaNd9B88xTweKIpXrvIrJw3sBmfKRNTJcoTuBeiB32x1BO
Wm2f0v24lnc9tb3EYrhruAbmrofCHGUUD6Fd6cgbf938D4DaNrR6uhTJdEj8JDif
CcbnPgzR2pOg3gNOJ3va9QsSdInFwv2wYr4ftVh76O6hzCvuyMdsskxUwophl8x0
Vn0OQDrKfBoRacuHwOLgRlgI4SA/6TZ7SDyfHI+Uljg3tP49VPUji6oFyxljLccp
Qeq2vLtLbBDeY+68lUOXOMieC+D/FZlODi05gjfKLuhdNg4l4+VnDvSQN7Btb7DQ
WSS+I5IHK7yFXV1Y/N4DqWqGjSA9mEEc3CLDC50N4JF62/ri1FI=
=76Wv
-----END PGP SIGNATURE-----

--Sig_/orsJdneEox0Kbc+g6Dj4_fM--
