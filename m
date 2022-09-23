Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD2975E751C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 09:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbiIWHqu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 03:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiIWHqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 03:46:24 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C31B12CCB7;
        Fri, 23 Sep 2022 00:45:54 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id p1-20020a17090a2d8100b0020040a3f75eso4613914pjd.4;
        Fri, 23 Sep 2022 00:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=aW76gmW+Z5hGGf3FjMaj197LqqVcbY4HHUFygvXrzUA=;
        b=h1Anx/e+40quCUEE9ycjrVAHM57MhJA71U/Re2pB7wtxs4ZMpzqynxCPwQt67zQtJK
         22UOjlbXgygfYyj/+w60swmIgl4V4Ca7t3JzfUnLX59IqSne7zPqVwzWDTSFDor+Dobp
         Hn+PrVqeg9+TacjmbTzNXcwSU4ue8KaTkHvranUB+H/P15PlalEHTLrfuTPePP08RbBA
         CbMRLV8c1El6Iqa4dcypl1M5f7rAmLMcxRW9OPQnKovXtLKh0rb9EA2JslfmsoX4VwmB
         w6LciDrccFaR+PJZUEb8flOF5JVl1E0CKGjEP7bLoAmx/6BJ3IWW7hCbfnOGj2mPMTnq
         d2HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=aW76gmW+Z5hGGf3FjMaj197LqqVcbY4HHUFygvXrzUA=;
        b=FoXe2U86faa1WbJSJndwXHwsbCS77nUpeInq6PcHpM+7Qr9kdcW/32ygJO1jX+yu1m
         mVeBmLtfHAkdXF7r9ihQXAUdnQ7vycHdp/dJ0R9XH2dDRAcKxRdgIzO87IimoOHEm6za
         VztjnR5JubVMW0enzwTxG2byOaTrkQ/HUN7u2vx2Cf/fjZQylpBGgmHojDm1AsARN/zW
         a303bHQ9mM3SasefaxRolDz0HuV7AMCWQAjyYzVA2d26KsfEyomhD2NO4gR0ZFk6VTp1
         t7qvP4ZcZLhiQoJVnIqiJb6U2acWzFXGqAjV9DYgs97RTXu3Y5Ra7niZct33JiHcOcCu
         mDhA==
X-Gm-Message-State: ACrzQf0EwWrGC/J6eNm6m1zTIb/QVnp2njMcFvk9DpMT+q60LFL1hLTj
        0KCmzx874wHaeO5kdPxhv64=
X-Google-Smtp-Source: AMsMyM71WeCrPnQNhXCWkVmdt5T5edtpWR1oa3FeGb/YIU4JETsDGn0kB1fH/4YJ5z6byQmddCzVuw==
X-Received: by 2002:a17:902:720b:b0:178:83e9:11ec with SMTP id ba11-20020a170902720b00b0017883e911ecmr7052576plb.34.1663919142618;
        Fri, 23 Sep 2022 00:45:42 -0700 (PDT)
Received: from debian.me (subs03-180-214-233-67.three.co.id. [180.214.233.67])
        by smtp.gmail.com with ESMTPSA id w68-20020a628247000000b0053e75395705sm5780233pfd.127.2022.09.23.00.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 00:45:41 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id B596E1037D4; Fri, 23 Sep 2022 14:45:34 +0700 (WIB)
Date:   Fri, 23 Sep 2022 14:45:34 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Kees Cook <keescook@chromium.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v2 5/7] docs: move asm-annotations.rst into core-api
Message-ID: <Yy1kHrS7ieq1VCqw@debian.me>
References: <20220922204138.153146-1-corbet@lwn.net>
 <20220922204138.153146-6-corbet@lwn.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mx4ZK54fQt2or+1d"
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


--mx4ZK54fQt2or+1d
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 22, 2022 at 02:41:36PM -0600, Jonathan Corbet wrote:
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

Hi jon,

I think Sphinx internal references are better fit for these links:

---- >8 ----

diff --git a/Documentation/core-api/asm-annotations.rst b/Documentation/cor=
e-api/asm-annotations.rst
index bc514ed598870c..d3071f131dad73 100644
--- a/Documentation/core-api/asm-annotations.rst
+++ b/Documentation/core-api/asm-annotations.rst
@@ -43,11 +43,10 @@ annotated objects like this, tools can be run on them t=
o generate more useful
 information. In particular, on properly annotated objects, ``objtool`` can=
 be
 run to check and fix the object if needed. Currently, ``objtool`` can repo=
rt
 missing frame pointer setup/destruction in functions. It can also
-automatically generate annotations for the ORC unwinder
-(Documentation/x86/orc-unwinder.rst)
+automatically generate annotations for the :ref:`ORC unwinder <orc-unwinde=
r>`
 for most code. Both of these are especially important to support reliable
-stack traces which are in turn necessary for kernel live patching
-(Documentation/livepatch/livepatch.rst).
+stack traces which are in turn necessary for :ref:`kernel live patching
+<kernel-livepatch>`.
=20
 Caveat and Discussion
 ---------------------
diff --git a/Documentation/livepatch/livepatch.rst b/Documentation/livepatc=
h/livepatch.rst
index 68e3651e8af925..ebb8b05a9b0d3e 100644
--- a/Documentation/livepatch/livepatch.rst
+++ b/Documentation/livepatch/livepatch.rst
@@ -1,3 +1,5 @@
+.. _kernel-livepatch:
+
 =3D=3D=3D=3D=3D=3D=3D=3D=3D
 Livepatch
 =3D=3D=3D=3D=3D=3D=3D=3D=3D
diff --git a/Documentation/x86/orc-unwinder.rst b/Documentation/x86/orc-unw=
inder.rst
index cdb257015bd9e8..b26368c3892d3d 100644
--- a/Documentation/x86/orc-unwinder.rst
+++ b/Documentation/x86/orc-unwinder.rst
@@ -1,5 +1,7 @@
 .. SPDX-License-Identifier: GPL-2.0
=20
+.. _orc-unwinder:
+
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 ORC unwinder
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--mx4ZK54fQt2or+1d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCYy1kFAAKCRD2uYlJVVFO
o0KWAP9jzvP4ppaXJOFGMQh19B6PfDGQfLT5QMGsWxf7kAGfjgD9G6np/5Q3JDdz
Jen+9y5W1RBiByedHFXTIZ/nPiafNQA=
=PCxc
-----END PGP SIGNATURE-----

--mx4ZK54fQt2or+1d--
