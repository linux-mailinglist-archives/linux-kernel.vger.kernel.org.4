Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A581C73995B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 10:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbjFVIW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 04:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbjFVIWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 04:22:54 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5A96A4
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 01:22:47 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4f957a45b10so2560258e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 01:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687422166; x=1690014166;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BWWJ5mCxzvhA8c7lR6uzF03qO4Q/gDSBdD/wAoQDu+M=;
        b=ZyojS6QuKSA9auGsWYdMWEIInsnFyIkfmjq7lItpRW2jr7DB/XsKJz1OQc0HZnkKiM
         P4kJDhmk44VGx7oQcbA/cUAZBAz2Dtxo6FxacklhVaAby0fVC7CcnxOFQ0pljkRDIC4+
         XG/aRXEcRSlLFgzGkj1MIVv/qspRsgt/gtEpko4eh90jluAYXvYCq2ILnr84hWFSdKeM
         h/BaqsRa0NtVN+MmQceprrfdYVHJ84qO5NsQJyiw3bTgmq8imFLdsuNPDQNsY/bgi6T0
         IooCuF/4J1gDsk3vS+J7qRCZG190twazhntsDZimK77cBgH2XOdXooLhgZbnJoq8hkXB
         O9YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687422166; x=1690014166;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BWWJ5mCxzvhA8c7lR6uzF03qO4Q/gDSBdD/wAoQDu+M=;
        b=deLi/e6xwYMU67ZlPzQyysqvQTI8y312TETfg8ygwN+8nVc6rCI2lIj212iwjsGqRU
         z6a8N6K4i+5A85K0YtuUIFuM4J5hsNTQyGHtb39QkVEVRdgXuV5stUb1qJ31zICpBUTQ
         PcJJ/Tq0Y3kxA5Ck3/DhcyANWM9kYf6dLUIzNo5wObqp1gg9yjomIgDMLmia6KhympHs
         9ZLZI5inYTujFm5bKAE9MS57yiqsnXSoDY+PuFZmeQcnONL3k/y9jP5JhYEaVCAEf8Bw
         kraAJk3K08Pr5STnSCWHhs8AXrhaMB2QVXo1lvo4oSOhfejK3gJI1CSgXnzwVxzU/RRB
         VHMg==
X-Gm-Message-State: AC+VfDxnY+P6kd+JBIC7W+G7c9koLQoqb7I/+OoRca9iGtKgp99w0Do9
        /S58cKIValWYVugzIlCTnH8=
X-Google-Smtp-Source: ACHHUZ5ya1+M2t9pTmTqq6kEPZRAEwdayD44K8Z/vmH3Om2/imVNHB9gCNOq+qUgP6JiUoiVTnx7Tw==
X-Received: by 2002:a19:6d0e:0:b0:4f6:520d:6b9b with SMTP id i14-20020a196d0e000000b004f6520d6b9bmr9103054lfc.60.1687422165682;
        Thu, 22 Jun 2023 01:22:45 -0700 (PDT)
Received: from eldfell ([194.136.85.206])
        by smtp.gmail.com with ESMTPSA id k11-20020ac2456b000000b004f6150e0899sm1011093lfm.290.2023.06.22.01.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 01:22:45 -0700 (PDT)
Date:   Thu, 22 Jun 2023 11:22:41 +0300
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
Subject: Re: [RFC PATCH v3 2/4] drm: Create DRM_IOCTL_GET_RESET
Message-ID: <20230622112241.70d4e941@eldfell>
In-Reply-To: <ab9ebe98-f583-234d-4901-ae570fb89d9f@igalia.com>
References: <20230621005719.836857-1-andrealmeid@igalia.com>
        <20230621005719.836857-3-andrealmeid@igalia.com>
        <20230621110931.6f3c8914@eldfell>
        <ab9ebe98-f583-234d-4901-ae570fb89d9f@igalia.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/3jFCMXZINee0lyRZG4tx5pz";
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

--Sig_/3jFCMXZINee0lyRZG4tx5pz
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 21 Jun 2023 13:33:56 -0300
Andr=C3=A9 Almeida <andrealmeid@igalia.com> wrote:

> Em 21/06/2023 05:09, Pekka Paalanen escreveu:
> > On Tue, 20 Jun 2023 21:57:17 -0300
> > Andr=C3=A9 Almeida <andrealmeid@igalia.com> wrote:
> >  =20
> >> Create a new DRM ioctl operation to get the numbers of resets for a
> >> given context. The numbers reflect just the resets that happened after
> >> the context was created, and not since the machine was booted.
> >>
> >> Create a debugfs interface to make easier to test the API without real
> >> resets.
> >>
> >> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
> >> ---
> >>   drivers/gpu/drm/drm_debugfs.c |  2 ++
> >>   drivers/gpu/drm/drm_ioctl.c   | 58 +++++++++++++++++++++++++++++++++=
++
> >>   include/drm/drm_device.h      |  3 ++
> >>   include/drm/drm_drv.h         |  3 ++
> >>   include/uapi/drm/drm.h        | 21 +++++++++++++
> >>   include/uapi/drm/drm_mode.h   | 15 +++++++++
> >>   6 files changed, 102 insertions(+) =20
> >=20
> > ...
> >  =20
> >> diff --git a/include/uapi/drm/drm.h b/include/uapi/drm/drm.h
> >> index a87bbbbca2d4..a84559aa0d77 100644
> >> --- a/include/uapi/drm/drm.h
> >> +++ b/include/uapi/drm/drm.h
> >> @@ -1169,6 +1169,27 @@ extern "C" {
> >>    */
> >>   #define DRM_IOCTL_MODE_GETFB2		DRM_IOWR(0xCE, struct drm_mode_fb_cmd=
2)
> >>  =20
> >> +/**
> >> + * DRM_IOCTL_GET_RESET - Get information about device resets
> >> + *
> >> + * This operation requests from the device information about resets. =
It should
> >> + * consider only resets that happens after the context is created, th=
erefore,
> >> + * the counter should be zero during context creation.
> >> + *
> >> + * dev_reset_count tells how many resets have happened on this device=
, and
> >> + * ctx_reset_count tells how many of such resets were caused by this =
context.
> >> + *
> >> + * Flags can be used to tell if a reset is in progress, and userspace=
 should
> >> + * wait until it's not in progress anymore to be able to create a new=
 context;
> >> + * and to tell if the VRAM is considered lost. There's no safe way to=
 clean this
> >> + * flag so if a context see this flag set, it should be like that unt=
il the end
> >> + * of the context. =20
> >=20
> > Is "this flag" the VRAM_LOST? Or any flag?
> >=20
> > Does this mean that not all resets are fatal to the context? Is there
> > any kind of reset that should not be fatal to a context? All the
> > rendering APIs seem to assume that any reset is fatal and the context
> > must be destroyed. =20
>=20
> I got this flag from the `AMDGPU_CTX_OP_QUERY_STATE2` operation, and=20
> it's used to notify that the reset was fatal for a giving context,=20
> although the idea of non-fatal resets seems to be a bit controversial=20
> for now, so I think it will be better if I leave this flag for latter=20
> improvements of the API.

Which flag is "this flag"? There are RESET_IN_PROGRESS and VRAM_LOST.
Both are fine by me to exist.

I think I made a wrong conclusion here. Somehow I read that it would be
possible to have a reset happen, and if VRAM is not lost, then the
context could work again.

Should there be some wording added to say the context is permanently
broken on any kind of reset? Or is that for UMD to decide?


Thanks,
pq

> >  =20
> >> + */
> >> +#define DRM_IOCTL_GET_RESET		DRM_IOWR(0xCF, struct drm_get_reset)
> >> +
> >> +#define DRM_RESET_IN_PROGRESS	0x1
> >> +#define DRM_RESET_VRAM_LOST	0x2 =20
> >=20
> > Ok, so the dmabuf lost is being communicated here, but how would a
> > userspace process know on which device a dmabuf resides on?
> >=20
> > Let's assume process A uses device 1 to draw, exports a dmabuf, sends
> > it to process B which imports it to device 2. Device 1 resets and loses
> > VRAM contents. How would process B notice that the dmabuf is lost when
> > it never touches device 1 itself?
> >  =20
> >> +
> >>   /*
> >>    * Device specific ioctls should only be in their respective headers
> >>    * The device specific ioctl range is from 0x40 to 0x9f.
> >> diff --git a/include/uapi/drm/drm_mode.h b/include/uapi/drm/drm_mode.h
> >> index 43691058d28f..c3257bd1af9c 100644
> >> --- a/include/uapi/drm/drm_mode.h
> >> +++ b/include/uapi/drm/drm_mode.h
> >> @@ -1308,6 +1308,21 @@ struct drm_mode_rect {
> >>   	__s32 y2;
> >>   };
> >>  =20
> >> +/**
> >> + * struct drm_get_reset - Get information about a DRM device resets
> >> + * @ctx_id: the context id to be queried about resets
> >> + * @flags: flags
> >> + * @dev_reset_count: global counter of resets for a given DRM device
> >> + * @ctx_reset_count: of all the resets counted by this device, how ma=
ny were
> >> + * caused by this context.
> >> + */
> >> +struct drm_get_reset {
> >> +	__u32 ctx_id;
> >> +	__u32 flags;
> >> +	__u64 dev_reset_count;
> >> +	__u64 ctx_reset_count;
> >> +};
> >> +
> >>   #if defined(__cplusplus)
> >>   }
> >>   #endif =20
> >=20
> > Thanks,
> > pq =20


--Sig_/3jFCMXZINee0lyRZG4tx5pz
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAmSUBNEACgkQI1/ltBGq
qqdjoA/9GT+l9T5suQZtlvGC1fGcbW8PXhRzhk7AGMWx6O1IyikY/WoA7uDT7Lkw
5o1tzI9g8zYHyRtxy3e6G1ZkiCbQGR2+Q6hki97WHunBZMvSz/GLtMU4/u/QbxZ3
RTmm3A3wkUBtFV/LCJ7eU9tQSgy4HK7zrLCNeLM2ASch0a6gK5OncQe7XQ80cc0p
DRNBT1BhDEMQBmvv3C7oDeQGrySAkWcIqJMOchtKvAnJLdTxYUCAAmgGog+Aku7K
S0UGkcjqTjrdYx89W/y8l+Fd94UsmMhoDC+Lqey7rPydg5HOQDtp9NQ+iPmSikhf
ffvF3p7VdIRfovd7RPGrm1lWhtS6rX1techog3ZZtk9uGcPUaMQRRYBm45SdGbIL
a2mAi84ZKOlf4WeUDjsVnEy7c9HBrHjytPPz0AoJfoHEAZjERHReDuCXB6sEOwy9
JRxvmG36rnzXC77pSFFn/G2merMOxmS0irXEBE/Cy3t7gJk884CTht0/S1mMoguq
dbNHF0sni/ZyM061AhjEycPm0TNnjEXD5nviC5hxugzMfcL2Cw67dkNiYUJXuafa
fKpoLJLlrh4xisTtjOmIMHvHAUEIs8BobazLyyF/tl/C0lUr+9Mqau4FMFhDnw/W
T7OeXGxWV5Dni7SMkQIMINcYyJwcf/xX/nhtxUO2JUIwNbvoWiU=
=RLZf
-----END PGP SIGNATURE-----

--Sig_/3jFCMXZINee0lyRZG4tx5pz--
