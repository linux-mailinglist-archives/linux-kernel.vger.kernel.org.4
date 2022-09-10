Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 039255B4807
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 21:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbiIJTPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 15:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiIJTPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 15:15:11 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D050030568
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 12:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=mi5tMl5llXPqSnbARt1sp187AcnGOe1n3F5czBOvw7I=; b=WF/AYOHrn51JFM1HMGOSbJxlVb
        HqOkskoSYBL0XmNOEvPadNR80ZLrqBQqUAUje6EGRlsX8QoLLu3PK1tOtj0NMZh8aNacfYu+6UGGy
        S+Cbvmi6Z0sM7MUSiO5//TzzcuRLZA/nEZXXJxdq+yE07RBBOOvYPsoOzEHFqqr3/YtLIQSCjKUVb
        GRFHEX6JYVrAyT+N0zQq1Zbhk7xEr5Sc53DJcQMwnWpNfvqhbC+Jq7Gtez+R4bCWIdjIn5BaHQyyx
        a/1DrgtNNEIf96IUepujhWXKtVIN2Bc3ioQIWJCcfLQhJZ+LwBoiRn8Z/SZ+Xosop6jM0uZTwDss6
        A3vjogJg==;
Received: from [38.44.74.92] (helo=mail.igalia.com)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1oX5wZ-00EgwB-0w; Sat, 10 Sep 2022 21:15:06 +0200
Date:   Sat, 10 Sep 2022 18:14:45 -0100
From:   Melissa Wen <mwen@igalia.com>
To:     Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc:     Haneen Mohammed <hamohammed.sa@gmail.com>,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Melissa Wen <melissa.srw@gmail.com>, dan.carpenter@oracle.com,
        Igor Torrente <igormtorrente@gmail.com>
Subject: Re: [PATCH] drm/vkms: fix variable dereferenced before check warning
Message-ID: <20220910191429.ifyzdp54due3u7it@mail.igalia.com>
References: <20220908105623.72777-1-harshit.m.mogalapalli@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6fojimcctpqsegyg"
Content-Disposition: inline
In-Reply-To: <20220908105623.72777-1-harshit.m.mogalapalli@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6fojimcctpqsegyg
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hyryti2dsyxhpc6x"
Content-Disposition: inline


--hyryti2dsyxhpc6x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 09/08, Harshit Mogalapalli wrote:
> Smatch warns:
>=20
> drivers/gpu/drm/vkms/vkms_plane.c:110 vkms_plane_atomic_update() warn:
>  variable dereferenced before check 'fb' (see line 108)
>=20
> Fix the warning by moving the dereference after the NULL check.
>=20
> Fixes: 8ba1648567e2 ("drm: vkms: Refactor the plane composer to accept ne=
w formats")
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> ---
>  drivers/gpu/drm/vkms/vkms_plane.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/vkms/vkms_plane.c b/drivers/gpu/drm/vkms/vkm=
s_plane.c
> index f4319066adcc..c3a845220e10 100644
> --- a/drivers/gpu/drm/vkms/vkms_plane.c
> +++ b/drivers/gpu/drm/vkms/vkms_plane.c
> @@ -105,11 +105,12 @@ static void vkms_plane_atomic_update(struct drm_pla=
ne *plane,
>  	struct drm_shadow_plane_state *shadow_plane_state;
>  	struct drm_framebuffer *fb =3D new_state->fb;
>  	struct vkms_frame_info *frame_info;
> -	u32 fmt =3D fb->format->format;
> +	u32 fmt;
> =20
>  	if (!new_state->crtc || !fb)
>  		return;
> =20
> +	fmt =3D fb->format->format;

Hi Harshit,

Nice catch.

Thanks,

Reviewed-by: Melissa Wen <mwen@igalia.com>

>  	vkms_plane_state =3D to_vkms_plane_state(new_state);
>  	shadow_plane_state =3D &vkms_plane_state->base;
> =20
> --=20
> 2.31.1
>=20

--hyryti2dsyxhpc6x--

--6fojimcctpqsegyg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEd8WOo/JViG+Tu+XIwqF3j0dLehwFAmMc4iUACgkQwqF3j0dL
ehyifxAAitrII/y8aIWr7dd+Uvz0yDndOZdorbbng2eGS0qEb/ZM4A5RdUOwYCjC
XWQmWc47NKSB4f6B1IH2E00L0uTv3BITQQBVPx2IcG7eUA2qEjmRUwVh3nWauu2z
y6Og021jdhMLZtRd5rxm5eQsTnOGXkOSBdYwU+BhuO7IDNdJYcqC4e6lfe+Cb1Nu
NNHHpftjCeh3lbW8R78dXHQXjjkqBEQJDwWX8gRHICs9g5F0qaQWfjMcxeaqETOj
oq9VpKdOOmvuN7j5fvh9n818cQ162BKicKCnxyaV4Jcx0UoUU4SIu9u+QZjZJxYz
XzV9DIWTQZCr0KhTgkYkSW+x4ZXOGm+Kt5erIvp7xes9hviyIBgaTnFDVk0dmYCX
MA+7bgTbo9lX6iITdM9fVyFCBrc/+FRcxQ8+gpBaRpD6Wlj74X+GmFc9FrMtEZWz
oHxjf2/1JyIF/vBb1rvxkdKfOggkLfGl9jkLpq3GUfqH165ac29Tj68rVxvMxK92
m7cbw7y1Reg5oge8DjQgViDQzflQNngCPDGpXbtjJIzKMwZJzgrFwgg3pZut2SJ4
tEhrRvgwso0xktk7FIypTBinPmB5HOZy9SG7nRLG2nMe9UldpiVmQ+Ouu2HpppRM
IrBRhs7AW11OJw2hb9RIZRKby5RxfpaquNRyRA06R5Kk91TbPVg=
=jIi+
-----END PGP SIGNATURE-----

--6fojimcctpqsegyg--
