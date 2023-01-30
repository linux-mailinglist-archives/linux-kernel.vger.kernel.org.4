Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73B046803A1
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 03:01:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235056AbjA3CBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 21:01:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjA3CA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 21:00:59 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1C761C59C;
        Sun, 29 Jan 2023 18:00:56 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id e10so6628358pgc.9;
        Sun, 29 Jan 2023 18:00:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8kDOke4LN7w6fpBsUtOXo8T0Zvp1z998++I9bqEffZY=;
        b=mS5KkcO7nR0TP6WHwPu9Nm1d00AEizhWsYErnNqbAlVIBAnQzHDgll8fIgxQ/fv2dl
         EbFiq5YBUycRKvtCPeAfPEFHccpC1b/IPAKpX/nizqtR5yCpddO0Ie9KG8zoOmu0nYgq
         loaudRNi/uIfMujdiAgAzzU5DRcNE0iurLhMdu38Hrk8KBzIwb2QSdYEjpuqPzUXydZx
         PD2+f8S5gClkR1qY3gKF2yoUj++p+V2gjz2tfDG/MJ+JpUORJa8BcXodIBytkVKBWdnf
         2MCxI8dviae0v+hzi2OwMVjIp3Y6h9KIVyIPBySagKSAiRZmX3CpwZsRhTiz/WYxzCAY
         pNxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8kDOke4LN7w6fpBsUtOXo8T0Zvp1z998++I9bqEffZY=;
        b=hkRZvibpnTg0XYeSD3is2PUQzeq3XkQOdbbV3ZftcWzH3DEblCr4a4BLQ7OtWnVAq6
         aez830mOTB1lrQYYOV/KUz23PhRJOY4kZIEu69Ig4XJs2OQvf8VRnmAR3kN6DYjblw4o
         7vXM4RMcl1zRv/Qb9+c8nkmcn1pR/29DoS0cWVkYlyXT9c8dUpPtKAHxJQsPTqt6q0cX
         zG8OJKYRCvohKNAoDhbqxzJjzcEBpd3tSfmbcv5NOsSfhF6om27sAGUacTOA2cYN8clB
         QoG78msGKqPWjfNBJkCmOSRQ+LaUogHnfylNvd81f6E37E8IXF2ji8uZzMXztUWLAF7K
         8O3Q==
X-Gm-Message-State: AO0yUKUTd2us8zB1x9Tgw+pCti2uLzKplZ2OQsdaoF4ct4lZmD0tMoyB
        9LgwtE/sXkwi8OeFpiZeetrvM3ITt1E=
X-Google-Smtp-Source: AK7set8QmFISUvk/cmZd+I0vBk9Qx+kmhNcsXx4nKJIiH75seIIq9S4BwtNRaEmkNUti/Gz0eYaBkA==
X-Received: by 2002:aa7:8fb8:0:b0:593:8539:beea with SMTP id t56-20020aa78fb8000000b005938539beeamr7179445pfs.3.1675044055901;
        Sun, 29 Jan 2023 18:00:55 -0800 (PST)
Received: from debian.me (subs28-116-206-12-34.three.co.id. [116.206.12.34])
        by smtp.gmail.com with ESMTPSA id 26-20020aa7915a000000b0058d99337381sm6312608pfi.172.2023.01.29.18.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jan 2023 18:00:54 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 9D84610555F; Mon, 30 Jan 2023 09:00:45 +0700 (WIB)
Date:   Mon, 30 Jan 2023 09:00:42 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        linux-doc@vger.kernel.org
Cc:     Julia Lawall <Julia.Lawall@inria.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Jonathan Corbet <corbet@lwn.net>, cocci@inria.fr,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: coccinelle: Escape --options to fix
 Sphinx output
Message-ID: <Y9ckylqsgCDsZ/RQ@debian.me>
References: <20230129151408.1525324-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ZjUcdI54Zb96UmuA"
Content-Disposition: inline
In-Reply-To: <20230129151408.1525324-1-j.neuschaefer@gmx.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZjUcdI54Zb96UmuA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 29, 2023 at 04:14:08PM +0100, Jonathan Neusch=C3=A4fer wrote:
> Without such escaping, -- is rendered as =E2=80=93 (en dash).

Well, the diff below is not what escaping means (to escape dashes is to
prepend each of them with a backslash, i.e. \-\-)

>=20
> Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
> ---
>  Documentation/dev-tools/coccinelle.rst | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/Documentation/dev-tools/coccinelle.rst b/Documentation/dev-t=
ools/coccinelle.rst
> index d9976069ed126..535ce126fb4fa 100644
> --- a/Documentation/dev-tools/coccinelle.rst
> +++ b/Documentation/dev-tools/coccinelle.rst
> @@ -219,7 +219,7 @@ instance::
>      cat cocci.err
>=20
>  You can use SPFLAGS to add debugging flags; for instance you may want to
> -add both --profile --show-trying to SPFLAGS when debugging. For example
> +add both ``--profile --show-trying`` to SPFLAGS when debugging. For exam=
ple
>  you may want to use::
>=20
>      rm -f err.log
> @@ -248,7 +248,7 @@ variables for .cocciconfig is as follows:
>=20
>  - Your current user's home directory is processed first
>  - Your directory from which spatch is called is processed next
> -- The directory provided with the --dir option is processed last, if used
> +- The directory provided with the ``--dir`` option is processed last, if=
 used
>=20
>  Since coccicheck runs through make, it naturally runs from the kernel
>  proper dir; as such the second rule above would be implied for picking u=
p a
> @@ -265,8 +265,8 @@ The kernel coccicheck script has::
>      fi
>=20
>  KBUILD_EXTMOD is set when an explicit target with M=3D is used. For both=
 cases
> -the spatch --dir argument is used, as such third rule applies when wheth=
er M=3D
> -is used or not, and when M=3D is used the target directory can have its =
own
> +the spatch ``--dir`` argument is used, as such third rule applies when w=
hether
> +M=3D is used or not, and when M=3D is used the target directory can have=
 its own
>  .cocciconfig file. When M=3D is not passed as an argument to coccicheck =
the
>  target directory is the same as the directory from where spatch was call=
ed.
>=20
=20
You inline (wrap within inline code markup) these option keywords to match
other keywords.

Regardless, LGTM, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--ZjUcdI54Zb96UmuA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY9ckqwAKCRD2uYlJVVFO
oyiBAP0aa1/RSNCNahSW+EK6BW1iHcAY44D1wW6DUsAm/3Bo4gD9Gwm7Ygsfm5Rh
01WKHlO/JZInQUNJr0U7/2mlfSvJFgg=
=4V+F
-----END PGP SIGNATURE-----

--ZjUcdI54Zb96UmuA--
