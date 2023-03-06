Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B00136AB596
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 05:20:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbjCFEUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 23:20:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbjCFET7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 23:19:59 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D561A26F;
        Sun,  5 Mar 2023 20:19:58 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id cp7-20020a17090afb8700b0023756229427so11924784pjb.1;
        Sun, 05 Mar 2023 20:19:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678076398;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xeEjG9qQfN4HurN7R54SerXBeT3Wfu1COvtor1oGcTU=;
        b=bJdobVfbZ/JtEbgfUe3fgjUR0an6hBlkhNfdz+/BmompPoJ8pXdG68bHxH1W3a321z
         4gCAjiUgYHWhsE25xcWMRXayRkIdQh1xOmOJnHEGVRTxN8TJRy9/lLTkzFpgn1BlZl0s
         hOhhRP8sB0sNLfplTHiS8cTIpnf+qcWoGjXsAGQAWwCywQ8GnQJhiT4KCUs8WCW/NbYq
         nKE4DSS6IWWlOefzMbuiMzqOKE8uRjFh2TEWGnHiYnqqTPAhuovOfUDjwqiMMDUfgYBV
         lLQmo0MQ/Ug7Wwrz1Z97fuCaynIA02+z54g20fNIaipS2XAB76FTn17eLYs/PMZ07gde
         zA7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678076398;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xeEjG9qQfN4HurN7R54SerXBeT3Wfu1COvtor1oGcTU=;
        b=6xKp42aY1ka1Ry/SWgNlnuUV11nZhR0BgqbX7UskbGgMvqq9OfNXMT8f9JaQxUf5Lx
         o0OGVziVXNqG4K6GqO4VXGESDC6QEbeLzBYYrS/MjNv25BTKLaemX/4Td5EjtgNPRTgD
         T2DwfwZWzgSROuCr005vRyymqulefCB4pi4s3SIdWdvqwM1PnMjygz38zucYYVIrH/wg
         VIxVrE6vRA7zg+c7GYtjrwr1i7nSdMiPF79YSOzCSMGAV5CeJp0Fi/lz0fmiwZWY5stD
         1Rpu5thVwfLxS+TC55ccfiSK2lrMWQSwdvPEuvWU3NSGoJXIclDvVLUivY8fGobdQ5rW
         sQnA==
X-Gm-Message-State: AO0yUKURilnSdFZPZ+edOJts3m4JI+6daakQbDIodHpdpg1+/bQ4e7FB
        FtJNO48Zt9dZEEDBE6iD7zE=
X-Google-Smtp-Source: AK7set9JlEwPBlqALSpRV6c8jrwcUt2XEbmfkdnOj+j7NNUMSjUZ+WbkdDXSfOA930RbhN+kZ6GYrA==
X-Received: by 2002:a17:903:187:b0:19c:dc38:3eb5 with SMTP id z7-20020a170903018700b0019cdc383eb5mr13005836plg.14.1678076397861;
        Sun, 05 Mar 2023 20:19:57 -0800 (PST)
Received: from debian.me (subs03-180-214-233-84.three.co.id. [180.214.233.84])
        by smtp.gmail.com with ESMTPSA id p3-20020a170902bd0300b0019a96a6543esm5465926pls.184.2023.03.05.20.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Mar 2023 20:19:57 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id B3E621062B3; Mon,  6 Mar 2023 11:19:54 +0700 (WIB)
Date:   Mon, 6 Mar 2023 11:19:54 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Thorsten Leemhuis <linux@leemhuis.info>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        regressions@lists.linux.dev
Subject: Re: [PATCH v3] docs: describe how to quickly build a trimmed kernel
Message-ID: <ZAVp6jdeWzYcisUO@debian.me>
References: <1a788a8e7ba8a2063df08668f565efa832016032.1678021408.git.linux@leemhuis.info>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qYTifO9MShStiXxN"
Content-Disposition: inline
In-Reply-To: <1a788a8e7ba8a2063df08668f565efa832016032.1678021408.git.linux@leemhuis.info>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qYTifO9MShStiXxN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 05, 2023 at 02:04:44PM +0100, Thorsten Leemhuis wrote:
> + * Create the build configuration for your kernel based on an existing
> +   configuration.
> +
> +   If you already prepared such a '.config' file yourself, copy it to
> +   ~/linux/ and run ``make olddefconfig``.
> +
> +   Use the same command, if your distribution or somebody else already t=
ailored
> +   your running kernel to your or your hardware's needs: the make target
> +   'olddefconfig' will then try to use that kernel's .config as base.
> +
> +   Using this make target is fine for everybody else, too -- but you oft=
en can
> +   save a lot of time by using this command instead::
> +
> +     yes "" | make localmodconfig
> +
> +   This will try to pick your distribution's kernel as base, but then di=
sable
> +   modules for any features apparently superfluous for your setup. This =
will
> +   reduce the compile time enormously, especially if you are running an
> +   universal kernel from a commodity Linux distribution.
> +
> +   There is a catch: the make target 'localmodconfig' will disable kernel
> +   features you have not directly or indirectly through some program uti=
lized
> +   since you booted the system. You can reduce or nearly eliminate that =
risk by
> +   using tricks outlined in the reference section; for quick testing pur=
poses
> +   that risk is often negligible, but it is an aspect you want to keep i=
n mind
> +   in case your kernel behaves oddly.

If your distro config have ``CONFIG_IKCONFIG=3Dy``, you can copy from
procfs::

    zcat /proc/config.gz > .config

If it isn't the case, you may want to enable the aforementioned config
option.

Thanks.=20

--=20
An old man doll... just what I always wanted! - Clara

--qYTifO9MShStiXxN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZAVp6gAKCRD2uYlJVVFO
o5N/AP9JIudqWFfpP3JkGugq4+NddtOMNbJA6AwZ9DiejYitqAD/emGfPGzV8r9o
956SQlBEkmphV6I72CgsXWG+jD/EOgo=
=KKNk
-----END PGP SIGNATURE-----

--qYTifO9MShStiXxN--
