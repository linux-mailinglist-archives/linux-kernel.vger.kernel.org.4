Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5564724215
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 14:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236860AbjFFM3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 08:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbjFFM26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 08:28:58 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A4610C6;
        Tue,  6 Jun 2023 05:28:57 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-256712e2be3so5215523a91.2;
        Tue, 06 Jun 2023 05:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686054537; x=1688646537;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jbiTAIYeS++2LppYqgSVrfeOsxiqOUBI8osgLm56Dv0=;
        b=FnE/Zamn77Vig5Yr2oqA5unkxfY5m6dJ56sq36UqQwKjl6qVm7ITyij6rcc4e/Xfk4
         mvYnf6OnND+mFNhZ7GoyPesjK0uKogvOjjwyKFiccKwO68VslhSHPk2cENpqhCaUMSNf
         volx8teW26nHO5vIXBfJJgrvtzfdvFuc8OtwiFRgYuu2SXYO5QH13GRnzBWwg8iW5pcS
         3JDVCCgzDjIPhWLDH+I3+cmDAnJIYa9GTsoKE+MIlEgepraHSLYjE4d3bIT4pUpwpBaS
         zhfLXHzxI8VWcwNT6/a3xVwlw1wf9QmszrLfMZRmQ91JIxBgC0qnqEgcy2Q2uxV0BIXW
         Ymkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686054537; x=1688646537;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jbiTAIYeS++2LppYqgSVrfeOsxiqOUBI8osgLm56Dv0=;
        b=QkdOGLXDlHHfquf0HG88dOuWrqZ27kUP+U5lJcWzLVw0sSiKGTzhLgWDvYUdpY1ckQ
         ZHt3wpUzRJVE6jUmVKcLyCtNGXPUeP6XLNNrSEf3O4OI+7cGGB+T8s2I8M63MX5WGRWs
         1BE4RDoZU1a+GPkSoP66osood5NaW+3X+6xXTjQv2TF4J1sivAqQ0xEm5qASQ0cJyJxh
         0ADIMyJENI8U0Z4Dj2Kv3oCy9Kt1F9GifvwZBZ5o7mLm6qxmAee4bClfsCebehQy3mFr
         dxT6wL3OstqKC6f79R/3ckz10xX+Ybw7HdNd0GyZUg9LHAJYI+PIFyPAiw5WzQQaGBAo
         brhQ==
X-Gm-Message-State: AC+VfDxOmilegN2llgkHhQrj7TqQlaMrHsGS+MtSkwG/7qaI3kIcdtZL
        mrqqGQEffHnBN3XotEqhbP8=
X-Google-Smtp-Source: ACHHUZ5sC3Omwc1R9R2oXPq0XI1qpnOev0hSECau3himiunIJyVu8ZNRdiH50H85OmdAZCN1CkxmDA==
X-Received: by 2002:a17:90a:ac10:b0:24e:4b1c:74d2 with SMTP id o16-20020a17090aac1000b0024e4b1c74d2mr1989660pjq.32.1686054536842;
        Tue, 06 Jun 2023 05:28:56 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-93.three.co.id. [180.214.232.93])
        by smtp.gmail.com with ESMTPSA id 8-20020a17090a018800b002565d52a781sm10003076pjc.40.2023.06.06.05.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 05:28:56 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 16921106A3A; Tue,  6 Jun 2023 19:28:53 +0700 (WIB)
Date:   Tue, 6 Jun 2023 19:28:52 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Franziska Naepelt <franziska.naepelt@googlemail.com>,
        keyrings@vger.kernel.org
Cc:     dhowells@redhat.com, dwmw2@infradead.org,
        linux-kernel@vger.kernel.org,
        Franziska Naepelt <franziska.naepelt@gmail.com>,
        kernel test robot <lkp@intel.com>,
        Linux SPDX Licenses <linux-spdx@vger.kernel.org>,
        Linux Kernel Janitors <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH v2] certs/extract-cert: Fix checkpatch issues
Message-ID: <ZH8mhIrjyBvTF4oZ@debian.me>
References: <20230601190508.56610-1-franziska.naepelt@gmail.com>
 <20230602085902.59006-1-franziska.naepelt@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+OePT+3E67BsBt+t"
Content-Disposition: inline
In-Reply-To: <20230602085902.59006-1-franziska.naepelt@gmail.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+OePT+3E67BsBt+t
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 02, 2023 at 10:59:02AM +0200, Franziska Naepelt wrote:
> The following issues are fixed:
> - WARNING: Missing or malformed SPDX-License-Identifier tag
> - ERROR: trailing statements should be on next line
> - WARNING: braces {} are not necessary for single statement blocks
> - ERROR: space required before the open parenthesis '('
> - ERROR: code indent should use tabs where possible
> - WARNING: please, no spaces at the start of a line
> - WARNING: Missing a blank line after declarations

Again, write the patch description in imperative mood (e.g. "Do foo").

> +// SPDX-License-Identifier: LGPL-2.1
>  /* Extract X.509 certificate in DER form from PKCS#11 or PEM.
>   *
>   * Copyright =C2=A9 2014-2015 Red Hat, Inc. All Rights Reserved.

Nope.

The license boilerplate says LGPL 2.1 or any later version, so the
corresponding SPDX tag should have been:

```
// SPDX-License-Identifier: LGPL-2.1-or-later
```

And please also delete the boilerplate and separate this SPDX conversion
into its own patch.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--+OePT+3E67BsBt+t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZH8mhAAKCRD2uYlJVVFO
o+2GAQDDLgr8oszJB+8rAWiEsN6nJLAcdRgzDbzCRdRvu/jzkQD/YhWHhyg4B6BZ
V1cTo1nnDJXZBlVj3cbYz+7f9fVqZgo=
=87Gb
-----END PGP SIGNATURE-----

--+OePT+3E67BsBt+t--
