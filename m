Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1720563BE3F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 11:49:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232146AbiK2Ktb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 05:49:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231354AbiK2KtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 05:49:16 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5833F2AC6D;
        Tue, 29 Nov 2022 02:49:15 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id s8so21850465lfc.8;
        Tue, 29 Nov 2022 02:49:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5j3+iUuyMtRi4wQ9/V6gCvkYe/j/BJZzTlBQitRgNPk=;
        b=iq+gayHBILRtlHdTmW5Wg+dwe80TR83Mqwlg/gHUYomZG1pW3lTQme32mbbfqUs2/V
         Q5tTKBmst8PbGNLi+tQpZA4opTj8NIB5vH67lbIdq0lyzvf49Ie1tufS0fOnyrxpUmDv
         J5BR705i2i758K6RvMO9n31SgzgQN+GREwM8MD8Q1BzArJR091eo7Fp+JxRpSIsMRgJJ
         uXxvLWZImWNpPof7U2JEh8vtjV0yV9mTcoLwxCqxSp0jUOr/VkoybPKtcSh3CXoTjCel
         fU22Gu4OcM9TcDRmDHhauEBENZfVo5lIYaA8pY6UAVIgFcXJhW0vyLY2Rzw0XFhDBSNP
         3FwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5j3+iUuyMtRi4wQ9/V6gCvkYe/j/BJZzTlBQitRgNPk=;
        b=SKeNWQmVDMEoH6Zm7NOwUfHA9f5RPnnBjtrgWhYpkUoDMNMoW39yujadgiHy9WFOAi
         0/P8Cuh3kekY4TNmkF/xouTg7ASiP44wOWAIz/lBksfFJFEtBSxwSgRQqpQyV19zqTGU
         t5Ffh7dNPIwV7nVjW61Q9aZsjMdBMdGDc22jINGmLonbFXevrJntXOqN8j7iG3iYSgHU
         cyGnkV5xL7a/qObW+Njm0DOM0OoCbOuYBuvi1LO5ldxHlqhqiYI73hDWek3/ZKdYPnWz
         UstCCt13DFNJ8u1sG9+4BReO8MZeqkgCzOVwMrJ3+JrKmSyAqDTJ+Rybp269RpncovwE
         qyIw==
X-Gm-Message-State: ANoB5pmALm/MleQ52QVow/bC3udc8uk5EuhWnUKnWjrLH+7PI4QQJQYb
        71R19z18HpdtOSgP4p0KJW4=
X-Google-Smtp-Source: AA0mqf54s5SX/22leNnVyt0ysKpjY7T98d4Y5NGp3vJqE4X1I3ztAfykmXoPESz6jH9Q8gfTb/gVRw==
X-Received: by 2002:a19:4f02:0:b0:4a2:1d18:45d8 with SMTP id d2-20020a194f02000000b004a21d1845d8mr18378313lfb.330.1669718953496;
        Tue, 29 Nov 2022 02:49:13 -0800 (PST)
Received: from eldfell ([194.136.85.206])
        by smtp.gmail.com with ESMTPSA id c3-20020a056512074300b004aa0870b5e5sm2152106lfs.147.2022.11.29.02.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 02:49:13 -0800 (PST)
Date:   Tue, 29 Nov 2022 12:48:59 +0200
From:   Pekka Paalanen <ppaalanen@gmail.com>
To:     Hsia-Jun Li <randy.li@synaptics.com>
Cc:     dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        hverkuil@xs4all.nl, tfiga@chromium.org, nicolas@ndufresne.ca,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
        linux-kernel@vger.kernel.org, ayaka@soulik.info
Subject: Re: [RFC] drm/fourcc: Add a modifier for contiguous memory
Message-ID: <20221129124859.6aa3ff00@eldfell>
In-Reply-To: <20221129101030.57499-1-randy.li@synaptics.com>
References: <20221129101030.57499-1-randy.li@synaptics.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/CjiU_jGWnjlPQD5JQ_UkV.O";
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

--Sig_/CjiU_jGWnjlPQD5JQ_UkV.O
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 29 Nov 2022 18:10:30 +0800
Hsia-Jun Li <randy.li@synaptics.com> wrote:

> From: "Hsia-Jun(Randy) Li" <randy.li@synaptics.com>
>=20
> Hello All
>=20
> Currently, we assume all the pixel formats are multiple planes,

Hi,

that's not true for any definition of "multiple planes" that I know of.

For example, DRM_FORMAT_XRGB8888 is a single-plane format by definition.

=46rom below it sounds like you mean "physically non-contiguous". But no,
pixel formats make no such assumption at all. Contiguous or not is
independent of pixel formats.

> devices
> could support each component has its own memory plane.
> But that may not apply for any device in the world. We could have a
> device without IOMMU then this is not impossible.
>=20
> Besides, when we export an handle through the PRIME, the upstream
> device(likes a capture card or camera) may not support non-contiguous
> memory. It would be better to allocate the handle in contiguous memory
> at the first time.
>=20
> We may think the memory allocation is done in user space, we could do
> the trick there. But the dumb_create() sometimes is not the right API
> for that.
>=20
> "Note that userspace is not allowed to use such objects for render
> acceleration - drivers must create their own private ioctls for such a
> use case."
> "Note that dumb objects may not be used for gpu acceleration, as has
> been attempted on some ARM embedded platforms. Such drivers really must
> have a hardware-specific ioctl to allocate suitable buffer objects."
>=20
> We need to relay on those device custom APIs then. It would be helpful
> for their library to calculate the right size for contiguous memory. It
> would be useful for the driver supports rendering dumb buffer as well.
>=20
> Signed-off-by: Hsia-Jun(Randy) Li <randy.li@synaptics.com>
> ---
>  include/uapi/drm/drm_fourcc.h | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
> index bc056f2d537d..ec039ced8257 100644
> --- a/include/uapi/drm/drm_fourcc.h
> +++ b/include/uapi/drm/drm_fourcc.h
> @@ -473,6 +473,11 @@ extern "C" {
>   */
>  #define DRM_FORMAT_MOD_LINEAR	fourcc_mod_code(NONE, 0)
> =20
> +/*
> + * Contiguous memory
> + */
> +#define DRM_FORMAT_MOD_CONTIG_MEM	fourcc_mod_code(NONE, 1)

NAK. This is not what modifiers are for.

This also would not work in practise, because if this was a modifier,
you would not be able to use the actual modifiers.


Thanks,
pq

> +
>  /*
>   * Deprecated: use DRM_FORMAT_MOD_LINEAR instead
>   *


--Sig_/CjiU_jGWnjlPQD5JQ_UkV.O
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAmOF45sACgkQI1/ltBGq
qqcRPQ//TKyVghVjJvbngGkpqrp0wLr2vTN2hZZNRZ+2ZW7siUbaHrDk7D88M4S5
oLOBZRm6RSgiarBfHpOIJ9xIbmjM+QbxzGeJeU2a0OgMYc9zMkfi3ohLmOjARq8u
4EZUGCEDUxUKmA1Z8mBTePUHJ1aEPeEqxIv3oy6ewNFHEzP2h9G4G8s09eFvBlzo
K8bdZuuVrsssxt+1jN1pQpVGCOXNVewyT2kwDjR5ZEBfEn4sxDiiB2cYpBBOqx5A
xymiID7dF8qvilEWUfYrJZJAKyJ372z3PozQ18pHOezEoiN+fRJoJRRuUt0r3nWh
QGZskfdWSWBKAZ5AFzmdb2dBpXX78M7KmmcjMVgTeM7ML81SCx5Sb2gHkXTctJYA
Aujwu+q++Q+nZlNCaOMV3C7eCEnSiIERaPV518Hm4Po3WU3qSRM1Wat3bTSA9R3E
FIwq+PRb7tM4BwsyQefdg8pVOsZ45yfSHNdQft1dKLVfIIm7pE2F4C5mc+i8lynr
IaGxWGXmUPVop2kUBW+cfBRu1qzvg9SGQEmuwfeNkfeAr8e1tWlcHTERuAn/LQGT
SgvogKeSqufFArePHMxM6ajE+sIXZOJlD7Tc1RisQrNkzre3Hr6L5xN7OE5jlfg2
wKhgc8n5o4C4gT6cK5XMuDm81aFV0wrMtT6t0jOeyA+qNaGvdHE=
=QEkC
-----END PGP SIGNATURE-----

--Sig_/CjiU_jGWnjlPQD5JQ_UkV.O--
