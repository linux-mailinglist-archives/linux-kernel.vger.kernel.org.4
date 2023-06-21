Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57800737DAD
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 10:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbjFUIJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 04:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjFUIJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 04:09:39 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E9BFE
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 01:09:37 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b470330145so53767061fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 01:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687334975; x=1689926975;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=y3IfFQYVdXyBU5zHSeHmh3RKbksxmzcltLrgdQI4MpQ=;
        b=LmD2wc+/cgtkYn8IiW4I5+TDur1d3SseAxxKBx6YmN63b9QTOc3v3d+7RQOYtfSXvW
         iI57Y7Wfa6Lthow+bgJYm/px8JOQ06b6aHK3GKbqy6hR9k+vAI8NCywoijvJXXq8MVwC
         kNleQraRdG4keof53rPE4usruTmscSm+YfLGyeAVMvsNDLJbR1B0nTP2u12+DHT4S0YU
         gH4CKbljDOlnvj4AxMkVlzefV/50TYJZovURYv0q7A9FnC4wj6yyruNrMV/QT3fMlxlo
         kg/I55XqzTCIoy/QnkjOAJeIaxn8dyOkPBYM9Lsb+GbPuknk52WbWX8LR9QlS6svgYge
         gHCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687334975; x=1689926975;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y3IfFQYVdXyBU5zHSeHmh3RKbksxmzcltLrgdQI4MpQ=;
        b=OUmoxyW6sJEyq6a6N0C5LHeGF2uYYKbdbcZ2g0H7w6iMigFLrQsxcKRIwVGWZHAZej
         YHNLM3nElcu8QLtu4zNgrM5MiLcbidF0Ne7FToaAsP+874W3S3gpFQxuoNiH79V2aM/u
         BMrNwiMTTM+7ePhjl/Ixv+WwpGeEKdSRw7Jd2P9VumGnhfXXhzS5RhIut6YkvC4rUt0t
         3Gx1kJw2EkY+9eg8kIddAb2gzLZ4muGI7Ul3KsKnLyJ/w+5CzO6auFbuP0KmPG8jjgbM
         4AymsmFZG0fag+AxOIPbqKNxSZPzCisYv1zh90UsNu8AdFLql3bX9zkIjN4ZPPhREGup
         xuwA==
X-Gm-Message-State: AC+VfDytET4Ibh2DBZRppoXmb4c+fMwVdcLxnXKx1Ty6ZMEzpniM01fJ
        VIrv2YngE2HBUNFrK/dGvlM=
X-Google-Smtp-Source: ACHHUZ4Hb3scbHBR2Qg4xyeKNalilWruB0NUIlOVoSYzrmnEue5WT+zhczNzI4GnkJsJ0SHCA9jzUQ==
X-Received: by 2002:a05:651c:91:b0:2b4:6b64:6860 with SMTP id 17-20020a05651c009100b002b46b646860mr6422393ljq.25.1687334975336;
        Wed, 21 Jun 2023 01:09:35 -0700 (PDT)
Received: from eldfell ([194.136.85.206])
        by smtp.gmail.com with ESMTPSA id d5-20020a2e3305000000b002b1ac2bcf99sm783919ljc.120.2023.06.21.01.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 01:09:34 -0700 (PDT)
Date:   Wed, 21 Jun 2023 11:09:31 +0300
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
Message-ID: <20230621110931.6f3c8914@eldfell>
In-Reply-To: <20230621005719.836857-3-andrealmeid@igalia.com>
References: <20230621005719.836857-1-andrealmeid@igalia.com>
        <20230621005719.836857-3-andrealmeid@igalia.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ATv9R6N/IyatZ_qIv8rdPJF";
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

--Sig_/ATv9R6N/IyatZ_qIv8rdPJF
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 20 Jun 2023 21:57:17 -0300
Andr=C3=A9 Almeida <andrealmeid@igalia.com> wrote:

> Create a new DRM ioctl operation to get the numbers of resets for a
> given context. The numbers reflect just the resets that happened after
> the context was created, and not since the machine was booted.
>=20
> Create a debugfs interface to make easier to test the API without real
> resets.
>=20
> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
> ---
>  drivers/gpu/drm/drm_debugfs.c |  2 ++
>  drivers/gpu/drm/drm_ioctl.c   | 58 +++++++++++++++++++++++++++++++++++
>  include/drm/drm_device.h      |  3 ++
>  include/drm/drm_drv.h         |  3 ++
>  include/uapi/drm/drm.h        | 21 +++++++++++++
>  include/uapi/drm/drm_mode.h   | 15 +++++++++
>  6 files changed, 102 insertions(+)

...

> diff --git a/include/uapi/drm/drm.h b/include/uapi/drm/drm.h
> index a87bbbbca2d4..a84559aa0d77 100644
> --- a/include/uapi/drm/drm.h
> +++ b/include/uapi/drm/drm.h
> @@ -1169,6 +1169,27 @@ extern "C" {
>   */
>  #define DRM_IOCTL_MODE_GETFB2		DRM_IOWR(0xCE, struct drm_mode_fb_cmd2)
> =20
> +/**
> + * DRM_IOCTL_GET_RESET - Get information about device resets
> + *
> + * This operation requests from the device information about resets. It =
should
> + * consider only resets that happens after the context is created, there=
fore,
> + * the counter should be zero during context creation.
> + *
> + * dev_reset_count tells how many resets have happened on this device, a=
nd
> + * ctx_reset_count tells how many of such resets were caused by this con=
text.
> + *
> + * Flags can be used to tell if a reset is in progress, and userspace sh=
ould
> + * wait until it's not in progress anymore to be able to create a new co=
ntext;
> + * and to tell if the VRAM is considered lost. There's no safe way to cl=
ean this
> + * flag so if a context see this flag set, it should be like that until =
the end
> + * of the context.

Is "this flag" the VRAM_LOST? Or any flag?

Does this mean that not all resets are fatal to the context? Is there
any kind of reset that should not be fatal to a context? All the
rendering APIs seem to assume that any reset is fatal and the context
must be destroyed.

> + */
> +#define DRM_IOCTL_GET_RESET		DRM_IOWR(0xCF, struct drm_get_reset)
> +
> +#define DRM_RESET_IN_PROGRESS	0x1
> +#define DRM_RESET_VRAM_LOST	0x2

Ok, so the dmabuf lost is being communicated here, but how would a
userspace process know on which device a dmabuf resides on?

Let's assume process A uses device 1 to draw, exports a dmabuf, sends
it to process B which imports it to device 2. Device 1 resets and loses
VRAM contents. How would process B notice that the dmabuf is lost when
it never touches device 1 itself?

> +
>  /*
>   * Device specific ioctls should only be in their respective headers
>   * The device specific ioctl range is from 0x40 to 0x9f.
> diff --git a/include/uapi/drm/drm_mode.h b/include/uapi/drm/drm_mode.h
> index 43691058d28f..c3257bd1af9c 100644
> --- a/include/uapi/drm/drm_mode.h
> +++ b/include/uapi/drm/drm_mode.h
> @@ -1308,6 +1308,21 @@ struct drm_mode_rect {
>  	__s32 y2;
>  };
> =20
> +/**
> + * struct drm_get_reset - Get information about a DRM device resets
> + * @ctx_id: the context id to be queried about resets
> + * @flags: flags
> + * @dev_reset_count: global counter of resets for a given DRM device
> + * @ctx_reset_count: of all the resets counted by this device, how many =
were
> + * caused by this context.
> + */
> +struct drm_get_reset {
> +	__u32 ctx_id;
> +	__u32 flags;
> +	__u64 dev_reset_count;
> +	__u64 ctx_reset_count;
> +};
> +
>  #if defined(__cplusplus)
>  }
>  #endif

Thanks,
pq

--Sig_/ATv9R6N/IyatZ_qIv8rdPJF
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAmSSsDsACgkQI1/ltBGq
qqfn+Q//SNCwyNu1uoLUvuP9SdsIToY76Ebck8cgr/wxhOOv2NFDulfmpaMKW9X2
Skf4kC+BJNM/myZhtmQ3iOJz7AdefkFAcScATWdGpjbs4pEqJxhNeNoV0UpMl3mt
yHcqFXLtPI4ofsrwGNeQeuVVUPRVWnO3RgN4I3j5egmBj4QJtW57atw60PxNBAmj
qakSMLdfhW7K148tOX5AMbxDJ1wnQctGAEV79TBzH7N9iacRR7AwpFyhho7T71ho
ll8NnWBEdabmPqpV29ewuY+2pqXepdxRdIXaoHA5WLffk8wB2muwPsyRdB3CmQh1
NcfUOBc6/pOlTxCwRgriHd7Scff76gGnJhdis06AHgfVIofRiPLbLSr518elLioO
a4B5LYPLbZY/p328pD7aW9bJTodQ514RL0YhI7D1z01KQR/FZ2/h4WdOQHSnm6Rg
UDzUGEoqTNseyFNwpwbJneY2jMnS3HpgWf7i5gmOTLCwize8g/8jNU+HL5kz/u5+
tarXS+WB0eQy5mmJFdgQ+om8XJpFnfAJqc4jU3fU3qsKro6l72BSek4YvSQNoJdc
ajVaQOgNqK2+V/Y5/6tH+OhoADRfvJ/YrUupVdydNr7Kc+ff+kwRDOH0IHOEwMK6
eafZ1GWhCEmoiqzXRFvNkcaLegQSoFECKsZfZ63Vnz8/RJTz7q0=
=DOkA
-----END PGP SIGNATURE-----

--Sig_/ATv9R6N/IyatZ_qIv8rdPJF--
