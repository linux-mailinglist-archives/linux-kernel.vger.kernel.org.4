Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D92925EBEBF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 11:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231573AbiI0JgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 05:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230428AbiI0JgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 05:36:15 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F021D97B25;
        Tue, 27 Sep 2022 02:36:13 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id b6so10238044ljr.10;
        Tue, 27 Sep 2022 02:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=7rf9Ys+9VaBrdkEvEFOBZQjuFYemnTKOVQw2tKXsTU4=;
        b=nsyT71pOMYHxMsWyrondnhrI08kLQBXmIJELLUIGUWqRr7ha2eh51i3e1DYkHAClSS
         Gpk027YCpFdgPC+geehXx6iAF4jFTYa17hoZ6wVlG0GRiYUyyUP0KamYUK9pcMCPydR0
         eeZLSNeMUVmE8HINaS8cXzIfqY4rpMljBkZD6diFD9OnSdFDNV/XaELwSJrJgzbbkom8
         N5iPR7OQ5GGNJyGOoNTn4HggAoysRC/b0TI1eJYmpvIPheVqy3430ebUmiwNIGJuRcV5
         qLnoOZ+u/seGEmOTzd8wI5CjgTQRqvah7iat+3RT3Y4y0kv3GQwCwcKx0qQqkANZPZc9
         4vgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=7rf9Ys+9VaBrdkEvEFOBZQjuFYemnTKOVQw2tKXsTU4=;
        b=RPaV1MCSPnr9Lk9k4G4IkJEcIPSR9hsOk5uQwU97mDQG8EIfH5EkQhdKArbRLzKY7a
         JJvv0MiokIUdNkU+1OGY0qacW85kwvaxjslFeQ3F8x/VfUrJezbNVSeyv7nUtu/jL/nP
         p3oypn1XtFF2hi7pU4UzsDElnMhqIIZDl9r+YOB+1ggUJpeNmUQ7qqexdtg78boCZhey
         kZ1fthzbWNDSCYNKwtyWls+mwatuwKHYLNRRwY1oP9PRVhookVjwggqkTMz64PentzVR
         2J2rydDOwKx17xju3IVzC14Bz1Ng+wv63dt2Xq/NmvIdlZm32lEbhmqpc8vFzVflVOGv
         q+Vw==
X-Gm-Message-State: ACrzQf3hU2O20GRmYLvAsimYrEvcAm/YTcozZMKk0MVlOh2QMcwiDUdH
        TVCxXUPACbgeAz8NKA90d8s=
X-Google-Smtp-Source: AMsMyM5cirhcq/uq1a8BqHQW+U5L7RWk6SDLgy46ekhRrAO3sjI3XSV8t5PU6mZq0kJcuHbEXaF1qw==
X-Received: by 2002:a2e:ba08:0:b0:26c:e72:5e44 with SMTP id p8-20020a2eba08000000b0026c0e725e44mr9643309lja.138.1664271372210;
        Tue, 27 Sep 2022 02:36:12 -0700 (PDT)
Received: from gmail.com (82-209-154-112.cust.bredband2.com. [82.209.154.112])
        by smtp.gmail.com with ESMTPSA id q6-20020a2eb4a6000000b00264b292232asm106513ljm.63.2022.09.27.02.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 02:36:11 -0700 (PDT)
Date:   Tue, 27 Sep 2022 11:42:33 +0200
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH] HID: hid-cmedia: use device managed resources
Message-ID: <YzLFieUC3UmJolvn@gmail.com>
References: <20220915123422.520721-1-marcus.folkesson@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Zwkxz08vvL+oB5bB"
Content-Disposition: inline
In-Reply-To: <20220915123422.520721-1-marcus.folkesson@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Zwkxz08vvL+oB5bB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Do you pick up this (and the similiar
[PATCH] HID: hid-alps: use default remove for hid device
[PATCH] HID: hid-elan: use default remove for hid device
)
patch as well?


On Thu, Sep 15, 2022 at 02:34:22PM +0200, Marcus Folkesson wrote:
> When we do not need to free() any memory in .remove, we can remove
> cmhid_remove as well.
> hid_device_remove() will call hid_hw_stop() as default .remove function
> if no function is specified.
>=20
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> ---
>  drivers/hid/hid-cmedia.c | 25 +++++--------------------
>  1 file changed, 5 insertions(+), 20 deletions(-)
>=20
> diff --git a/drivers/hid/hid-cmedia.c b/drivers/hid/hid-cmedia.c
> index cab42047bc99..87786a88b119 100644
> --- a/drivers/hid/hid-cmedia.c
> +++ b/drivers/hid/hid-cmedia.c
> @@ -145,11 +145,9 @@ static int cmhid_probe(struct hid_device *hid, const=
 struct hid_device_id *id)
>  	int ret;
>  	struct cmhid *cm;
> =20
> -	cm =3D kzalloc(sizeof(struct cmhid), GFP_KERNEL);
> -	if (!cm) {
> -		ret =3D -ENOMEM;
> -		goto allocfail;
> -	}
> +	cm =3D devm_kzalloc(&hid->dev, sizeof(struct cmhid), GFP_KERNEL);
> +	if (!cm)
> +		return -ENOMEM;
> =20
>  	cm->hid =3D hid;
> =20
> @@ -159,28 +157,16 @@ static int cmhid_probe(struct hid_device *hid, cons=
t struct hid_device_id *id)
>  	ret =3D hid_parse(hid);
>  	if (ret) {
>  		hid_err(hid, "parse failed\n");
> -		goto fail;
> +		return ret;
>  	}
> =20
>  	ret =3D hid_hw_start(hid, HID_CONNECT_DEFAULT | HID_CONNECT_HIDDEV_FORC=
E);
>  	if (ret) {
>  		hid_err(hid, "hw start failed\n");
> -		goto fail;
> +		return ret;
>  	}
> =20
>  	return 0;

Outch, I just saw that we should just return ret here. IOW

  	if (ret)
  		hid_err(hid, "hw start failed\n");

    return ret;

Do you want me to send v2 or do you fix that when applying?

Thanks,
Marcus Folkesson


--Zwkxz08vvL+oB5bB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAmMyxYQACgkQiIBOb1ld
UjJbWw/9HY12MnpVvwj0+jkSVpcFvUH2VZwbyfFLLK7Hgsw8V7X2MQ6cV6BkVF6l
swjIMNrRt6Gm5z535Nd7+0TLkbl2dlY0p5V8Hu8F71NBXKd6oA8GxuFmmLdblg92
09eX0ocE4z779WIrVeIcP+/qsb97BH9gcB8AKO2rQ9CJCuT0GSEl/QXqtKBNbaSJ
Kp05SWC/yL/tzPhylYXqkr57C3/ZYrYPwkObc8gUCG07J9Pw8LwXavo8O6QC00Ic
1qto1W55lWKOuCZ+UboQ/c+vSX8FdQt/xwbtw6nv1WAGfKTtIzrJ73BHgRM5XAm+
aEhahOffwQNfOoPJcGUiWNpJwsAAIITVkaK9UljhKwSUUmhaaFSBQYibvp7XykL6
0TrsbqjZ0fGsyXBA/R4xCpCNH9O64CUgSJYTXWY7YtDIs3+V81n7VCtikDk/2pmm
GHDUzPmUGQwYGX41++dhf5MjPV4Wc+qeUbOudXb1AFgtMNOAXNSb6zrYqAl4J3bW
FT9OYIhxc7wv9O9jGTFN+/L+htOOCKyYbxnVyTORproVrJB+o26DwKBSvRHbCU2x
jJyHBGk+0+cyKtptZP3eMHWFPThCDqNzMhOPIzhSC/2OdZ5o/455QE6c1OU8uMhU
WDh4/Gr3IXDmqNzHUPrQySWa3AS3oK3aq8Oa8whPM1T5IVc1Fwg=
=qdh9
-----END PGP SIGNATURE-----

--Zwkxz08vvL+oB5bB--
