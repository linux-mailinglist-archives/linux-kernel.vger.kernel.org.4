Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB7FD6C90A7
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 21:16:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231822AbjCYUQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 16:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjCYUQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 16:16:26 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06A894680
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 13:16:24 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 6BD481C0AB2; Sat, 25 Mar 2023 21:16:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1679775383;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xqv+LYcfzddHbULRn10F7Da1YwCj3m98d7oAQjoYGQo=;
        b=B5AZEG43iNeUPKu79Eo0CyI08wIXEWhIqsBeBT8D/Izq7a3qF/JxexeD1HGPBp23uIqfM5
        pFwP/gCaqs2IO5IaSXoynKbGcwvjOF4N+5gRT3lwqd4gMW1TmShm+H1r4PI9pdqQHJOKyy
        FJFPY7MuiYNHvvUBmRScLVNbDrSz7Zs=
Date:   Sat, 25 Mar 2023 21:16:22 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc:     airlied@gmail.com, daniel@ffwll.ch, amd-gfx@lists.freedesktop.org,
        Anthony Koo <anthony.koo@amd.com>,
        Iswara Negulendran <iswara.nagulendran@amd.com>,
        Felipe Clark <felipe.clark@amd.com>,
        Harry Wentland <Harry.Wentland@amd.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/display: Add missing OLED Vesa brightnesses
 definitions
Message-ID: <ZB9Wltd9jiI7ktse@duo.ucw.cz>
References: <20230322160513.1438881-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="vZOsuThjzQLN1+xx"
Content-Disposition: inline
In-Reply-To: <20230322160513.1438881-1-Rodrigo.Siqueira@amd.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vZOsuThjzQLN1+xx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2023-03-22 10:05:13, Rodrigo Siqueira wrote:
> Cc: Anthony Koo <anthony.koo@amd.com>
> Cc: Iswara Negulendran <iswara.nagulendran@amd.com>
> Cc: Felipe Clark <felipe.clark@amd.com>
> Cc: Harry Wentland <Harry.Wentland@amd.com>
> Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

Some changelog would be useful.


> +++ b/include/drm/display/drm_dp.h
> @@ -977,6 +977,8 @@
>  # define DP_EDP_BACKLIGHT_FREQ_AUX_SET_CAP		(1 << 5)
>  # define DP_EDP_DYNAMIC_BACKLIGHT_CAP			(1 << 6)
>  # define DP_EDP_VBLANK_BACKLIGHT_UPDATE_CAP		(1 << 7)
> +#define DP_EDP_OLED_VESA_BRIGHTNESS_ON      0x80
> +# define DP_EDP_OLED_VESA_CAP				(1 << 4)
> =20

Are you fixing a compile problem? Otherwise this should go in with the
user...

BR,
							Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--vZOsuThjzQLN1+xx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZB9WlgAKCRAw5/Bqldv6
8hNeAJ9Z6iHpiX7M02eWAO5DogqxZDen0gCffJw9G0L8fNgcM6poGr+ycBvtTFw=
=pb8n
-----END PGP SIGNATURE-----

--vZOsuThjzQLN1+xx--
