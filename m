Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE8D660CFFD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 17:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232835AbiJYPIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 11:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232853AbiJYPIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 11:08:51 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD66D144E2E;
        Tue, 25 Oct 2022 08:08:50 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id DE3A560006;
        Tue, 25 Oct 2022 15:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1666710529;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=otc5BmO7YavK1XeoKHLh2SnG7hoJS0ceAy/xUyY0Iig=;
        b=Db2rUta7STHje1jdNLDLvqjb6rV04sh67IGiDoubvfJqtwVNnF+pguPUyeemGqlB2ItVwi
        jHyDxmSleyPAtFRFfvRrqm4TXLcQTz7/e+Q6hiHWobAtLHMoR003lr6ta6IXMtpAD2ksVU
        WQwMgSdECMn3gnU6LmdU/i3C9hIdzVKHe+H4IaQeCicfv644cILBv/5DwPPsWYxXQlMkrP
        EYHYHe302CD+e2J99YooWjUO3eCvbyZzDjdTlJlboa04cpNW9WwBLuXbXsKxgS8Sm+Xb7p
        582nlNJEjSNofrS+BJl0eVIJaVLuXCFrBOU4y1jUBxhyLG41lzPoH3V3MEBV9w==
Date:   Tue, 25 Oct 2022 17:08:47 +0200
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     mripard@kernel.org, mchehab@kernel.org, gregkh@linuxfoundation.org,
        wens@csie.org, samuel@sholland.org, hverkuil-cisco@xs4all.nl,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/11] media: cedrus: remove superfluous call
Message-ID: <Y1f7/5qMT+lWVvLI@aptenodytes>
References: <20221024201515.34129-1-jernej.skrabec@gmail.com>
 <20221024201515.34129-2-jernej.skrabec@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="NI4vdU0zrYI0R1CK"
Content-Disposition: inline
In-Reply-To: <20221024201515.34129-2-jernej.skrabec@gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NI4vdU0zrYI0R1CK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jernej,

On Mon 24 Oct 22, 22:15, Jernej Skrabec wrote:
> cedrus_try_fmt_vid_out() is called two times inside
> cedrus_s_fmt_vid_out(), but nothing changes between calls which would
> influence output format. Remove first call, which was added later.

Thanks for the cleanup!

Acked-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Cheers,

Paul

> Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> ---
>  drivers/staging/media/sunxi/cedrus/cedrus_video.c | 4 ----
>  1 file changed, 4 deletions(-)
>=20
> diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_video.c b/drivers/=
staging/media/sunxi/cedrus/cedrus_video.c
> index 33726175d980..1c3c1d080d31 100644
> --- a/drivers/staging/media/sunxi/cedrus/cedrus_video.c
> +++ b/drivers/staging/media/sunxi/cedrus/cedrus_video.c
> @@ -309,10 +309,6 @@ static int cedrus_s_fmt_vid_out(struct file *file, v=
oid *priv,
>  	struct vb2_queue *peer_vq;
>  	int ret;
> =20
> -	ret =3D cedrus_try_fmt_vid_out(file, priv, f);
> -	if (ret)
> -		return ret;
> -
>  	vq =3D v4l2_m2m_get_vq(ctx->fh.m2m_ctx, f->type);
>  	/*
>  	 * In order to support dynamic resolution change,
> --=20
> 2.38.1
>=20

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--NI4vdU0zrYI0R1CK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmNX+/8ACgkQ3cLmz3+f
v9Hk1Qf/ZEwFpMg0O3EC4UOnrETBs2glXtCKLAm1H4CUXbed05+lyQt20S2RNyas
0sos6GKz9sJWc0AacqFOjcLga8J2f2wc3wKq2hL2+sBpFyrD6ujlmtkvmV3sw0b4
xhszpElxJ2fs+lKc2cJ6nmJLmimTjjs5gQZ7sI/aZ1yPvCQysFYPVMSzME7iaBJd
wNwSfE7Btmx7NBoU4ksPi7EaKYgEzWr0oPToBlTfEHEUC+S/mEAwD9dZJSbmeopU
0nfzubYctuEXLs5wwpfQIRT6O/SSJ9msWfOEIjVfsUI/j7lGQtDfoH80TZkfGRjT
aU6X3+qJFu9SH332xhQctO4+BY4/RA==
=sXIU
-----END PGP SIGNATURE-----

--NI4vdU0zrYI0R1CK--
