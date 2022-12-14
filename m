Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5360D64C2BE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 04:23:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236941AbiLNDXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 22:23:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237247AbiLNDXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 22:23:44 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3166A201B7;
        Tue, 13 Dec 2022 19:23:42 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id hd14-20020a17090b458e00b0021909875bccso2751096pjb.1;
        Tue, 13 Dec 2022 19:23:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5yGUeywFIfhfjfxIX9USrHFHb67BMZ0a0rJ9P+bxw1U=;
        b=CPFgVoTnhSfvAm3IStMi6qj/VBBTDC1AoYMvuwlsJiZ84AAxzUi0f7sVO+I9PFpk51
         Fw0sXp/cSsuxF57uXjQZKJ4isRdiOUU2jF9NJdaXrps0drOvacEvE+TdnWLPLgvnVMek
         QPh5sQZctYnJOeYQ4RZhlcup+g9h2CXsYyRkFQLwDVwr/oGX1CLAGh7PU91cNnfnw9+B
         /ds6XWfTDt7Snp4t7CGG+YweNdZ/08OFaTMpD9jzHDOgqmxHaKrm54r890SM7+WRiyV5
         RC7gqrdC39sssJecunnTcqZKdP+lYUQAHCwAIPTAazMI+5bc+iusgQxuFdOox4A8BX4B
         lz6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5yGUeywFIfhfjfxIX9USrHFHb67BMZ0a0rJ9P+bxw1U=;
        b=tUfyeuU0VwgVJEZuH8wP5Fr72ygza3xboVfpqC85Uox3qwQsj6J1kwl9amHJuGmufp
         ZDZ/gnnbqkPckeUwnQS4DFvzhsU369vlyhJ1QcbselA/B5BOKFKutmnrT5aYu+XVwN3z
         jvyU0Ysmpd0mqtFQIAehxUsYkJOtnJA2Yf2ArCzmwosNc7PkakYpDTE90R/Xjb8AThmE
         +rKRVZDbmrDzkLyj0FLvsSlAwO08SKxlNKF2JqZKRRfXzQ6qzXLYNSfw7cWAbUrhsNwh
         YvhoKBIas0kLNK8WDp7k0zF33m8exwiLS/oSFJF7P4uCeQT1rSKTppj96FgTWS5fBRU8
         u0pA==
X-Gm-Message-State: ANoB5pkFXtfrPSybwdNCZnZu9u01qGx0vJnDLhAa4XvcqDfE0H0hUd9L
        ZbJIciMGBvJhO3xMf7q0ecI=
X-Google-Smtp-Source: AA0mqf6vyDaBVou6wponF5I0BA0YeNyoWdiJjXRJkhtR58bPIUVx2G7A4tJCblN7lx2KD7RAFUxi+Q==
X-Received: by 2002:a05:6a20:2aa4:b0:ad:d982:5c0 with SMTP id v36-20020a056a202aa400b000add98205c0mr6600552pzh.44.1670988221935;
        Tue, 13 Dec 2022 19:23:41 -0800 (PST)
Received: from debian.me (subs03-180-214-233-75.three.co.id. [180.214.233.75])
        by smtp.gmail.com with ESMTPSA id u192-20020a6279c9000000b00575bab45644sm8392725pfc.61.2022.12.13.19.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 19:23:41 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 938D31038B6; Wed, 14 Dec 2022 10:23:37 +0700 (WIB)
Date:   Wed, 14 Dec 2022 10:23:37 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     "Derek J. Clark" <derekjohn.clark@gmail.com>
Cc:     linux@roeck-us.net, Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>,
        =?utf-8?Q?Joaqu=C3=ADn_Ignacio_Aramend=C3=ADa?= 
        <samsagax@gmail.com>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (oxp-sensors) Add AYANEO AIR and AIR Pro
Message-ID: <Y5lBue87IXkhNs42@debian.me>
References: <20221213225511.77442-1-derekjohn.clark@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="RgS/zDzB4VTPWHzp"
Content-Disposition: inline
In-Reply-To: <20221213225511.77442-1-derekjohn.clark@gmail.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RgS/zDzB4VTPWHzp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 13, 2022 at 02:55:11PM -0800, Derek J. Clark wrote:
> Adds support for the AYANEO AIR and AYANEO AIR Pro models of handheld
s/Adds/Add/
> devices. These devices use the same EC registers and logic as the One X
> Player mini AMD. Previous AYANEO models are not supported as they use a
> different EC and do not have the necessary fan speed write enable and
> setting registers. Tested on Aya Neo AIR. AIR Pro model EC functionality
"The driver is tested on ..., while ..."
> and DMI data were verified using command line tools by another user.
>=20
> The added devices are:
> - AYANEO AIR (AMD 5560U)
> - AYANEO AIR Pro (AMD 5560U)
> - AYANEO AIR Pro (AMD 5825U)
>=20
> Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
> ---
>  Documentation/hwmon/oxp-sensors.rst | 17 +++++----
>  MAINTAINERS                         |  6 ++++
>  drivers/hwmon/oxp-sensors.c         | 54 ++++++++++++++++++++++++-----
>  3 files changed, 63 insertions(+), 14 deletions(-)
>=20
> diff --git a/Documentation/hwmon/oxp-sensors.rst b/Documentation/hwmon/ox=
p-sensors.rst
> index 39c588ec5c50..b93892c892c5 100644
> --- a/Documentation/hwmon/oxp-sensors.rst
> +++ b/Documentation/hwmon/oxp-sensors.rst
> @@ -3,18 +3,21 @@
>  Kernel driver oxp-sensors
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> =20
> -Author:
> +Authors:
> +    - Derek John Clark <derekjohn.clark@gmail.com>
>      - Joaqu=C3=ADn Ignacio Aramend=C3=ADa <samsagax@gmail.com>
> =20
>  Description:
>  ------------

Trim the trailing colon as it is not needed for section title.

> =20
> -One X Player devices from One Netbook provide fan readings and fan contr=
ol
> -through its Embedded Controller.
> +Handheld devices from One Netbook and Aya Neo provide fan readings and f=
an
> +control through their Embedded Controllers.

s/Embedded Controllers/embedded controllers/

> =20
> -Currently only supports AMD boards from the One X Player and AOK ZOE lin=
eup.
> -Intel boards could be supported if we could figure out the EC registers =
and
> -values to write to since the EC layout and model is different.
> +Currently only supports AMD boards from One X Player, AOK ZOE, and some =
Aya
> +Neo devices. One X PLayer Intel boards could be supported if we could fi=
gure
> +out the EC registers and values to write to since the EC layout and mode=
l is
> +different. Aya Neo devices preceding the AIR may not be usable as the EC=
 model
> +is different and do not appear to have manual control capabiltities.
> =20
>  Supported devices
>  -----------------
> @@ -22,6 +25,8 @@ Supported devices
>  Currently the driver supports the following handhelds:
> =20
>   - AOK ZOE A1
> + - Aya Neo AIR
> + - Aya Neo AIR Pro
>   - OneXPlayer AMD
>   - OneXPlayer mini AMD
>   - OneXPlayer mini AMD PRO

Otherwise LGTM, thanks.

--=20
An old man doll... just what I always wanted! - Clara

--RgS/zDzB4VTPWHzp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY5lBtAAKCRD2uYlJVVFO
o7LuAP41lOEEBtUdIbqsqp8XNq1N4hXdExfsPLKTJStBNtt3twD/WD3IPJAKdmNM
butxrHEN/axvjVAhMzPAWXAp9pSnSAY=
=cHGG
-----END PGP SIGNATURE-----

--RgS/zDzB4VTPWHzp--
