Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B08463A4D8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 10:25:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbiK1JZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 04:25:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbiK1JZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 04:25:44 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7C39C59
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 01:25:42 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id r8so12407590ljn.8
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 01:25:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uAIPC07tkKT1kxd5XpJSQmp70fKjncfyfi/EEEgXF6g=;
        b=pAProB+Z3oUeTfnHu9qp3CFaM3gbxmMUFANsvRgZeh9xuKeuwNVPxKV/skRBSQqcKv
         NssMT+loAluypJOZ6qM2ORpK3AGfE/bwXHK8/KWTPU+aIJuRNZVOMZTN6kPfodZLQzJE
         xRySPZbZ4Q4fEgrldRv+hnVVG5k4RijAjrfhJ0h9ZHAbtOqjORLjjo1n3m+WAEdSMFnx
         un0jRXYBSg60EXwSTJl2nq+oIv+Wo+jvxBGf6dSItrgkoItAaW+VpzljtFTNAsyV0DjQ
         9s0fuqanAt6I1OoLrZM3/j7QnhCYv3AZWCkLDpLKxzxPWhuFfKSSZVSZc7i9Qdwxmr9s
         K2pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uAIPC07tkKT1kxd5XpJSQmp70fKjncfyfi/EEEgXF6g=;
        b=gfG71cbaCPeNqVrwK8+pUsyXkPdJ2Ny+J0y0Fp/bQ40Bz91ioOSL+QQj47Jzg1XtCt
         EPAXUynAZO2r3qW6e+CW1xLe0fPKc+uLEzMQCxGW8Gm8PGQjnk9jhq/3Q2dg5kdHrHcN
         YPOhlvP5MQStiDpcsRAmFXzamIPVBxWRVcM0WMXn9lgbdWRt/TYja9ezUBPzQy8T0fuo
         9TpmNahJ+NsXSsMNk1qmCpO1G1UThOgCZXDkFOvtvuN+SZRU5Jw5NGK2ksRZrhZVAZ5I
         oIv2gq+CoHo9Ci5BsMxLx7EW1IDSJzBQiPYM750HEmtG9nzAQVYPa2R/xu/YYJy7RGtS
         qutA==
X-Gm-Message-State: ANoB5pm9ZMV5KUoFPTatf7f0Ef7+XtpJvQ+gjRzTPHgKjQaKUWn+afH3
        OzS50MfsWEES+n0LhJ5IQic=
X-Google-Smtp-Source: AA0mqf6KuHnchOOf/tqwHS5axA5QeF/8gLY2iW9IsKnByXXJOWaWoqle4M9nSs+q18noeUDFC7fxJA==
X-Received: by 2002:a05:651c:198d:b0:278:eef5:8d16 with SMTP id bx13-20020a05651c198d00b00278eef58d16mr11721785ljb.220.1669627540929;
        Mon, 28 Nov 2022 01:25:40 -0800 (PST)
Received: from eldfell ([194.136.85.206])
        by smtp.gmail.com with ESMTPSA id a21-20020ac25e75000000b004ab4ebb5d92sm1646376lfr.5.2022.11.28.01.25.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 01:25:40 -0800 (PST)
Date:   Mon, 28 Nov 2022 11:25:28 +0200
From:   Pekka Paalanen <ppaalanen@gmail.com>
To:     =?UTF-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>
Cc:     dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, kernel-dev@igalia.com,
        alexander.deucher@amd.com, contactshashanksharma@gmail.com,
        amaranath.somalapuram@amd.com, christian.koenig@amd.com,
        pierre-eric.pelloux-prayer@amd.com,
        Simon Ser <contact@emersion.fr>,
        Rob Clark <robdclark@gmail.com>,
        Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Daniel Stone <daniel@fooishbar.org>,
        'Marek =?UTF-8?B?T2zFocOhayc=?= <maraeo@gmail.com>,
        Dave Airlie <airlied@gmail.com>,
        "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>
Subject: Re: [PATCH v3 0/2] drm: Add GPU reset sysfs
Message-ID: <20221128112528.1206b1f5@eldfell>
In-Reply-To: <20221125175203.52481-1-andrealmeid@igalia.com>
References: <20221125175203.52481-1-andrealmeid@igalia.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/j29UQcp8cD1U5AeBSxdSDmF";
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

--Sig_/j29UQcp8cD1U5AeBSxdSDmF
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 25 Nov 2022 14:52:01 -0300
Andr=C3=A9 Almeida <andrealmeid@igalia.com> wrote:

> This patchset adds a udev event for DRM device's resets.

Hi,

this seems a good idea to me.

> Userspace apps can trigger GPU resets by misuse of graphical APIs or driv=
er
> bugs. Either way, the GPU reset might lead the system to a broken state[1=
], that
> might be recovered if user has access to a tty or a remote shell. Arguabl=
y, this
> recovery could happen automatically by the system itself, thus this is th=
e goal
> of this patchset.
>=20
> For debugging and report purposes, device coredump support was already ad=
ded
> for amdgpu[2], but it's not suitable for programmatic usage like this one=
 given
> the uAPI not being stable and the need for parsing.
>=20
> GL/VK is out of scope for this use, giving that we are dealing with device
> resets regardless of API.

I see that the reported PID is intended to be the culprit, the process
that caused the GPU to crash or hang, if identified. Hence, killing
that process perhaps makes sense, even if it could recover on its own
through GL/VK "device lost" mechanism.

"VRAM lost" is interesting. Innocent processes essentially lost the GPU
in that case, I suppose, but that's no reason to kill them and restart
the whole graphics stack outright. Those that actually handle GL/VK
device lost should theoretically be fine, right?

Display servers can make more enlightened decisions on whether they
need to restart or not, if they are implemented to handle that.

The example gpu-resetd [3] behaviour in that case seems sub-optimal.
Could it do better? How would it know, or avoid knowing, which
processes handled the GPU reset fine and which need external restarting?

Maybe gpu-resetd should kill the culprit only if it causes resets
repeatedly? But if the culprit does not handle device lost and also
does not die... how do you know you need to kill it?


Thanks,
pq

>=20
> A basic userspace daemon is provided at [3] showing how the interface is =
used
> to recovery from resets.
>=20
> [1] A search for "reset" in DRM/AMD issue tracker shows reports of resets
> making the system unusable:
> https://gitlab.freedesktop.org/drm/amd/-/issues/?search=3Dreset
>=20
> [2] https://lore.kernel.org/amd-gfx/20220602081538.1652842-2-Amaranath.So=
malapuram@amd.com/
>=20
> [3] https://gitlab.freedesktop.org/andrealmeid/gpu-resetd
>=20
> v2: https://lore.kernel.org/dri-devel/20220308180403.75566-1-contactshash=
anksharma@gmail.com/
>=20
> Andr=C3=A9 Almeida (1):
>   drm/amdgpu: Add work function for GPU reset event
>=20
> Shashank Sharma (1):
>   drm: Add GPU reset sysfs event
>=20
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  4 +++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 30 ++++++++++++++++++++++
>  drivers/gpu/drm/drm_sysfs.c                | 26 +++++++++++++++++++
>  include/drm/drm_sysfs.h                    | 13 ++++++++++
>  4 files changed, 73 insertions(+)
>=20


--Sig_/j29UQcp8cD1U5AeBSxdSDmF
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAmOEfogACgkQI1/ltBGq
qqdHTBAAtPNGC5EntpMSAxvoB+an5jcdGflRL7GEC3ZhtzD9TY3kpnXDQmirAq2O
MYjXpb5VdG9xcLXk+FFSjUVuNSDdaZbyhobhsJswr6GMi5LyxIfvmdnFsGaq2+JR
84ST3YTc1eNY5lUKxhMK3YpvcFtvlnZ+D5P3JgIUGo86CeLzc5t1ipwC5e1RzdMj
nic+Mz6Yfk+aMKzle1yBRGWnALzRpGQo1eUTukYrkU76LEI4h+KGYV0Tru/6pbI4
1AVeIiZY38gga7scTpx94HKqiJBdWSZjvwb6zc1LdoCXShvU8bMjuDrI8qmOnYpB
G1TG8qOFed8dNFTfefIHHTouzgaKusQIjpwzq6d5x6jg5LTzhV5YnAyommuxr7+P
d38ASP3lUKgG5V+E+fM6piA2HW8+ec0r2kBBMaHFhjkXJ+mvfhO4m4PadA22JFkm
jgU7QFoXW1dXT/6isHfZHQgFCyxmLRbd4jHHCQCRuJqIBoJ951qopRkJTM3Xg5Uk
rlig5oGWhPGpTsHyIvc/Cqe7Z1L5M35TwidcJgDrekpPlb2TcZ4/keDLeJfYcPPt
FP2FJYfgAzovZnp+HQ+UBlQQvH2E57H4s9NlwQM+X2rMwKBOdoQ3ZDCdVcRgGSkl
qWfeAbQujQSiVBO0UqgHV2zDAZREd/+dLNEaZTsCOyK3uRnWlSs=
=RAkP
-----END PGP SIGNATURE-----

--Sig_/j29UQcp8cD1U5AeBSxdSDmF--
