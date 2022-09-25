Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 287FE5E90EB
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 05:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbiIYDyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 23:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbiIYDyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 23:54:21 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 559D029804;
        Sat, 24 Sep 2022 20:54:20 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d11so3469834pll.8;
        Sat, 24 Sep 2022 20:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=aFaN8NcfRpobbIHExA/Rky3fMWo3aA5jQQgTJ5qtoI4=;
        b=dlbNbxMVsra3/12R+SGJCpwRE6AucEpmhepW/1NZvwidYB7/hBbmxKZh8TtI2pMvmM
         WHuXrOVVkTvUf4lCSEWdttcF/wxhBGLnMoA3m9zktCOOLwV8z3EcIiGXNnCg3HQzOj9e
         bJTww932DcRHj5MyyvoeMBwrNNB1+vKO+/73cK0Z/1L3yJa9/OpOi5rPqqfNAfTXPmQ9
         aMmafc/9prfZJHqh2aoBLJ9ZlzEYUv23uENzh8/HmNX6KmD5hkoifouaXzFifiOSJUzK
         eg6CboTD9y+WMdAoVL/Nv7SYEgzi3ch0xT+bTUQu0I+R1G+MZ8u38beA3Y/oerwEThsY
         6rqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=aFaN8NcfRpobbIHExA/Rky3fMWo3aA5jQQgTJ5qtoI4=;
        b=7WTbuzhbo++TgE+th+D4CsqTfakLcPEOMmcFO3F+TC8HxjnPHWcctJExHi+sIfv2t2
         qQwrWtNws0aIRkmUgCWdQ7ny85XkhMcDMXAEwpK2O9D0B/RMY/DZCHdht2NNL2Pcv5xD
         A7tRp0bK0YiFXXIEL8wRMYnx0onBu18iIkG8jx3SZ7kXgF0612AMJwXI72yOzNkBXaFI
         WLabxVgjkSFnx93LN9prTkx9BIUb2rZ3ZFi4vDmmePciwR5QJ/W5IiYdlKK93mnOK57M
         iTlW4LSzm3QVhWEkrjSSaGLnj3OvHez24BP7S3Jd0Iv53RBIa8L3gHFzODQL760A8xS5
         J2kw==
X-Gm-Message-State: ACrzQf19A3aHe6zFeEBMhs3YLlmfm5iUUEhHCuFR34BUr7durcCe+QAF
        yorTe1wIdezh12QFVSfjyXI=
X-Google-Smtp-Source: AMsMyM7PqQHIqiNzvjRfHR31TquvU7+drjnsZSGV2P8wd3GE+8c639RBVAGVuSkHo2WXvBcprxLD4g==
X-Received: by 2002:a17:90b:1c09:b0:203:af4d:ed6 with SMTP id oc9-20020a17090b1c0900b00203af4d0ed6mr29329956pjb.243.1664078059806;
        Sat, 24 Sep 2022 20:54:19 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-10.three.co.id. [180.214.232.10])
        by smtp.gmail.com with ESMTPSA id nh23-20020a17090b365700b00202fbd9c21dsm4039275pjb.48.2022.09.24.20.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Sep 2022 20:54:19 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 5B2F5101C72; Sun, 25 Sep 2022 10:54:15 +0700 (WIB)
Date:   Sun, 25 Sep 2022 10:54:14 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linux MM and miscellaneous subsystems list 
        <linux-mm@kvack.org>, Thorsten Leemhuis <linux@leemhuis.info>,
        Kees Cook <keescook@chromium.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: Re: [PATCH v2 5/7] docs: move asm-annotations.rst into core-api
Message-ID: <Yy/Q5lcP127z8p3S@debian.me>
References: <20220922204138.153146-1-corbet@lwn.net>
 <20220922204138.153146-6-corbet@lwn.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="OTixsmsn8fwN+mIX"
Content-Disposition: inline
In-Reply-To: <20220922204138.153146-6-corbet@lwn.net>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OTixsmsn8fwN+mIX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 22, 2022 at 02:41:36PM -0600, Jonathan Corbet wrote:
> diff --git a/Documentation/asm-annotations.rst b/Documentation/core-api/a=
sm-annotations.rst
> similarity index 97%
> rename from Documentation/asm-annotations.rst
> rename to Documentation/core-api/asm-annotations.rst
> index a64f2ca469d4..bc514ed59887 100644
> --- a/Documentation/asm-annotations.rst
> +++ b/Documentation/core-api/asm-annotations.rst
> @@ -43,10 +43,11 @@ annotated objects like this, tools can be run on them=
 to generate more useful
>  information. In particular, on properly annotated objects, ``objtool`` c=
an be
>  run to check and fix the object if needed. Currently, ``objtool`` can re=
port
>  missing frame pointer setup/destruction in functions. It can also
> -automatically generate annotations for :doc:`ORC unwinder <x86/orc-unwin=
der>`
> +automatically generate annotations for the ORC unwinder
> +(Documentation/x86/orc-unwinder.rst)
>  for most code. Both of these are especially important to support reliable
> -stack traces which are in turn necessary for :doc:`Kernel live patching
> -<livepatch/livepatch>`.
> +stack traces which are in turn necessary for kernel live patching
> +(Documentation/livepatch/livepatch.rst).
> =20

Hi jon,

kernel test robot reported non-existent reference ([1]), so I have
applied the fixup:

---- >8 ----

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 79e759aac543b8..812af52f97d2cf 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3751,7 +3751,7 @@ sub process {
 		if ($realfile =3D~ /\.S$/ &&
 		    $line =3D~ /^\+\s*(?:[A-Z]+_)?SYM_[A-Z]+_(?:START|END)(?:_[A-Z_]+)?\=
s*\(\s*\.L/) {
 			WARN("AVOID_L_PREFIX",
-			     "Avoid using '.L' prefixed local symbol names for denoting a range=
 of code via 'SYM_*_START/END' annotations; see Documentation/asm-annotatio=
ns.rst\n" . $herecurr);
+			     "Avoid using '.L' prefixed local symbol names for denoting a range=
 of code via 'SYM_*_START/END' annotations; see Documentation/core-api/asm-=
annotations.rst\n" . $herecurr);
 		}
=20
 # check we are in a valid source file C or perl if not then ignore this hu=
nk

Thanks.

[1]: https://lore.kernel.org/linux-doc/202209240904.XQP4YAP7-lkp@intel.com/

--=20
An old man doll... just what I always wanted! - Clara

--OTixsmsn8fwN+mIX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCYy/Q4gAKCRD2uYlJVVFO
o7MPAQDujup0SzeW5zTycZQtQZgsmzjQSDKiWIxeAuIIqTQbhQEA7ZTsHRac1o7+
Va39BSNqoDYZwCmSS//CGkRf0kYTAAM=
=9WuZ
-----END PGP SIGNATURE-----

--OTixsmsn8fwN+mIX--
