Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC9169B927
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 10:41:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbjBRJlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 04:41:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBRJle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 04:41:34 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A3D131E1C;
        Sat, 18 Feb 2023 01:41:33 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id s22-20020a17090a075600b0023127b2d602so484732pje.2;
        Sat, 18 Feb 2023 01:41:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5rmDK72vZ8fQzEyhFyhgCxcJBJHFfRcwj3bVJdDU7WM=;
        b=asZwzgA3wjdnxVYvc7LzSxt8zYra6Rh/mddCKulD+zsSfNBr0E5MzT7wkMvF4o3e2S
         SMl6c9Gd3ktXVxl2xxL7iOe8Q5585ZX2gSTrHKWszV4w3PPamiwdAAmRucs8eav8mF0J
         U+ltA8a7J51xuv3n3O500sgYX93fg+AGRVEQzIwpurZG4XmWnnoK/hywpS7nIxlLU143
         RfF5eFcKAeQSoeiUMVW+YR0KrCbsy0edOgdYarS1mrNn/dU5WneOdgKrR6kodK+FcEJd
         m+gMFI/huEGmS8cu8BZZXj35T75gA3GLU9Ggt511f/Zjslyzisyxon3RvOaSygj2wNPD
         /pAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5rmDK72vZ8fQzEyhFyhgCxcJBJHFfRcwj3bVJdDU7WM=;
        b=64XNV9MyIaL9tHnkmZs2LTkOfbvxMN4v161LmUwZ23EwvKgkg32XH1n9TQzRynmkMd
         Ss87vlT1gCuwHCXLtHSs0Qud5BoXUkmB28iRSBDiieXlpnQzQBmz59ZOSQzwbfS8WvrY
         fDf9UuzWMDjp7P4Y12AOJ5li0QELCIZ5NB4kYsoTY8i6fKY2Mr0il+/V6mGU/y7/qWWj
         qiwfDjBOrTHanyLjLRUe92Qt3Bemr5JIa/4TneZ4PfKg8ugS0BTeE8l+keBpuFoj9/i9
         UFxsACBooz1SOOS8jwb6F/6xghawAorUguzyu/YSJsU39XHxd1JrCpdJhdL5iN5xVSb+
         r5sg==
X-Gm-Message-State: AO0yUKWStEy7EtzyhUtyo9eZ42e9kSnsNlPhkPCrm162bFuQ0HOrDczo
        +y3lMZR8lrpkuUxB/3RPMro=
X-Google-Smtp-Source: AK7set+3dG+Y+lb4W4nyypWiAZ/3FT/EnNIlAtkpQQT/0h8U6bYKOxgpxP5U7IiV0qgJr9lyry9BAg==
X-Received: by 2002:a17:902:d489:b0:196:40b1:3319 with SMTP id c9-20020a170902d48900b0019640b13319mr3453151plg.5.1676713292798;
        Sat, 18 Feb 2023 01:41:32 -0800 (PST)
Received: from debian.me (subs28-116-206-12-56.three.co.id. [116.206.12.56])
        by smtp.gmail.com with ESMTPSA id ji11-20020a170903324b00b0019afb7a02a1sm4055438plb.218.2023.02.18.01.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Feb 2023 01:41:32 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 4BA3F105E25; Sat, 18 Feb 2023 16:41:27 +0700 (WIB)
Date:   Sat, 18 Feb 2023 16:41:27 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Vishal Parmar <vishistriker@gmail.com>,
        laurent.pinchart@ideasonboard.com, mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] first patch test
Message-ID: <Y/CdR0oBttYV85Y8@debian.me>
References: <20230218031238.5747-1-vishistriker@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="MuVn2X80n6RyCgzD"
Content-Disposition: inline
In-Reply-To: <20230218031238.5747-1-vishistriker@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--MuVn2X80n6RyCgzD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 18, 2023 at 08:42:37AM +0530, Vishal Parmar wrote:
> Signed-off-by: Vishal Parmar <vishistriker@gmail.com>
> ---
>  drivers/media/usb/uvc/uvc_driver.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/u=
vc_driver.c
> index e4bcb5011360..c79dcee2213f 100644
> --- a/drivers/media/usb/uvc/uvc_driver.c
> +++ b/drivers/media/usb/uvc/uvc_driver.c
> @@ -2082,7 +2082,7 @@ static int uvc_probe(struct usb_interface *intf,
>  		(const struct uvc_device_info *)id->driver_info;
>  	int function;
>  	int ret;
> -
> +        pr_info("I changed uvcvideo driver in the Linux Kernel\n");
>  	/* Allocate memory for the device and initialize it. */
>  	dev =3D kzalloc(sizeof(*dev), GFP_KERNEL);
>  	if (dev =3D=3D NULL)

Hi and welcome to LKML!

As others has pointed, it seems like you had sent a patch which only
added noises to the ML. Also, I see that you send the similar change as
one in "Modifying a driver under the VM" section of kernelnewbies.org
[1].

If you'd like to submit patches, you can do so by contributing to
drivers/staging/ drivers first or documentation files at Documentation/.
It is not recommended to go outside of there until you've gained
experience and have several of your patches accepted and applied by
respective maintainers.

In any case, please read Documentation/process/submitting-patches.rst.

Thanks.

[1]: https://kernelnewbies.org/FirstKernelPatch


--=20
An old man doll... just what I always wanted! - Clara

--MuVn2X80n6RyCgzD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY/CdPQAKCRD2uYlJVVFO
o8nmAQCOnUwLyF4xac0EXIx2bpexRRQsQPgigBeGPCpbd9ux0gEAvPMd6NbkOaTQ
HGST2yZev1pmDiR0vxa7+re351sVGgU=
=bRrx
-----END PGP SIGNATURE-----

--MuVn2X80n6RyCgzD--
