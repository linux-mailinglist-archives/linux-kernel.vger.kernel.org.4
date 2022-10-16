Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6850B5FFD18
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 05:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbiJPDAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Oct 2022 23:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbiJPDAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Oct 2022 23:00:49 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1178330F78;
        Sat, 15 Oct 2022 20:00:47 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id f140so8300119pfa.1;
        Sat, 15 Oct 2022 20:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wlvcEO+9PuSxbYdnGHPlMieasZnmCuZRr7tjo+EUTZ4=;
        b=P7NF8G5OgZyMs2lCZSBkOvR/NVRTzKz1T2eYLDHuKbhwtjwonlgFMFWUpADU1c/mMi
         JGHGKgG2aQagSs4iMMMDWtXoq3M+vrk4ushuFj4L+7MS21sD39vtKXBYu8rJ1vkbR5Jn
         wTF8hpWtkaB3aU2ruPg1bWgT4S7nQjbjd72zCYDoUgXuQdffGdKaF5bsUaBfI8Igt2Fo
         oxwBr46LzB845bqeGzK5hxZva1MFWCigVKJ36zMO3/1TN+KmWbOsr7IaKZyttcQ/kBxQ
         c5ZFTn5UPG3AngP+ADZkP3iRlXl8i7MC7HC7ae4T9TD6QE5XeFXeJZTzmN7ioYdurNdN
         hZ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wlvcEO+9PuSxbYdnGHPlMieasZnmCuZRr7tjo+EUTZ4=;
        b=Vv2wlhkxeh2rGVWbXCYKqE1Po0DyMJkgdV4A/VSCa25csBgomGszMZLcvYEwSAukbn
         6lfyk4CikmNRDCY7WuplCEOOjxEDVLN2oYfvK4n8+d1oAw7fsl3eHtIcjqvYVM3Q8o3y
         vD33y5juOFiA+lPxp4DNzdWWCrI4W+y77iQUY/EZYu+bZPqcifZURHbYpx27gjdg+548
         G9irr4PNMhwmz6yZqD8zyq7cfmCWkMMkWiNcGJThFaFCsJo2SOkN5q+e9fwiDgjOybuU
         niL96TAO/TFueC+e3cHzdctq/ejKypQLncIfrm4c3oj8dFxQFYUxzkJvmtFTnmuCxJb9
         Zj2A==
X-Gm-Message-State: ACrzQf2GInYH8ukxKEV+8jXt+dKhyl2V/LWLLhuPSk7K7DR/3eNfIdVg
        UOhvAB2QH1BTFVpXhsu3PzSHRKAwEcmJ/PiL
X-Google-Smtp-Source: AMsMyM42HQvhN4Qf6kQM8OJ+sUZIakw4oPOV1cPWpFPNK5DdKUsuaswK+xNBZONlOJxGf19T61mezw==
X-Received: by 2002:a63:4426:0:b0:464:4e1d:80e3 with SMTP id r38-20020a634426000000b004644e1d80e3mr5006879pga.106.1665889246467;
        Sat, 15 Oct 2022 20:00:46 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-3.three.co.id. [180.214.232.3])
        by smtp.gmail.com with ESMTPSA id g3-20020a656cc3000000b004588814ca73sm3684189pgw.21.2022.10.15.20.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Oct 2022 20:00:45 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 3853010026B; Sun, 16 Oct 2022 10:00:39 +0700 (WIB)
Date:   Sun, 16 Oct 2022 10:00:39 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, luto@kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org, kernel-dev@igalia.com,
        kernel@gpiccoli.net, Andre Almeida <andrealmeid@igalia.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Joshua Ashton <joshua@froggi.es>,
        Melissa Wen <mwen@igalia.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Pavel Machek <pavel@denx.de>,
        Pierre-Loup Griffais <pgriffais@valvesoftware.com>,
        Tony Luck <tony.luck@intel.com>,
        Zebediah Figura <zfigura@codeweavers.com>
Subject: Re: [PATCH V2] x86/split_lock: Add sysctl to control the misery mode
Message-ID: <Y0tz1/pR/s7+j6s+@debian.me>
References: <20221014180506.211592-1-gpiccoli@igalia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="he7fAmT252Uv1Vmd"
Content-Disposition: inline
In-Reply-To: <20221014180506.211592-1-gpiccoli@igalia.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--he7fAmT252Uv1Vmd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 14, 2022 at 03:05:06PM -0300, Guilherme G. Piccoli wrote:
> diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/=
admin-guide/sysctl/kernel.rst
> index ee6572b1edad..508952e42914 100644
> --- a/Documentation/admin-guide/sysctl/kernel.rst
> +++ b/Documentation/admin-guide/sysctl/kernel.rst
> @@ -1298,6 +1298,24 @@ watchdog work to be queued by the watchdog timer f=
unction, otherwise the NMI
>  watchdog =E2=80=94 if enabled =E2=80=94 can detect a hard lockup conditi=
on.
> =20
> =20
> +split_lock_mitigate (x86 only)
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +

The heading underline above is too short (doesn't cover the whole text
length), so I have applied the fixup:

---- >8 ----

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/ad=
min-guide/sysctl/kernel.rst
index c733d424d4e830..4824cfed71ab31 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -1315,7 +1315,7 @@ watchdog =E2=80=94 if enabled =E2=80=94 can detect a =
hard lockup condition.
=20
=20
 split_lock_mitigate (x86 only)
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
=20
 For x86 CPUs supporting the split lock detection mechanism, this parameter
 allows the users to turn off what is called "the misery mode", which

> +For x86 CPUs supporting the split lock detection mechanism, this paramet=
er
> +allows the users to turn off what is called "the misery mode", which
> +introduces intentional delay in userspace applications that split locks.
> +The goal of the misery mode is to prevent using such unaligned access to
> +DoS the system dropping the performance overall, but some of these split
> +locking programs are legacy and/or proprietary software that cannot be f=
ixed,
> +so using this sysctl is a way to allow them to run with a decent perform=
ance.
> +
> +=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +0 Disables the misery mode - just warns the split lock on kernel log.
> +1 Enables the misery mode (this is the default) - penalizes the split
> +  lockers with intentional performance degradation.
> +=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +
>  stack_erasing
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =20

The wording can be improved:

---- >8 ----

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/ad=
min-guide/sysctl/kernel.rst
index 4824cfed71ab31..961c19f4beae51 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -1320,15 +1320,15 @@ split_lock_mitigate (x86 only)
 For x86 CPUs supporting the split lock detection mechanism, this parameter
 allows the users to turn off what is called "the misery mode", which
 introduces intentional delay in userspace applications that split locks.
-The goal of the misery mode is to prevent using such unaligned access to
-DoS the system dropping the performance overall, but some of these split
-locking programs are legacy and/or proprietary software that cannot be fix=
ed,
-so using this sysctl is a way to allow them to run with a decent performan=
ce.
+The goal of this mode is to prevent using such unaligned access to
+drop the overall performance (and DoS the system). However, some of progra=
ms
+which uses split locking are legacy and/or proprietary software that cannot
+be fixed, so disabling this sysctl can allow them to run with a decent
+performance.
=20
 =3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 0 Disables the misery mode - just warns the split lock on kernel log.
-1 Enables the misery mode (this is the default) - penalizes the split
-  lockers with intentional performance degradation.
+1 Enables the misery mode (default)
 =3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
=20
Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--he7fAmT252Uv1Vmd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY0tzzgAKCRD2uYlJVVFO
o1cgAQDd/HW8c+Qs9uusV20c8oAtnOt6/XUnT+jKgpaIiu/fCAEAmcW8ipB1AlKn
0Hgwi+pK4l9GDZm9Y85pbhEVqk+mVwQ=
=fqhd
-----END PGP SIGNATURE-----

--he7fAmT252Uv1Vmd--
