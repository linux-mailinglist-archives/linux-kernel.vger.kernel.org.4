Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61D87720CF6
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 03:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237096AbjFCBUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 21:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236639AbjFCBUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 21:20:50 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B4D7D3;
        Fri,  2 Jun 2023 18:20:49 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-53482b44007so1582152a12.2;
        Fri, 02 Jun 2023 18:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685755249; x=1688347249;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3Y8G14r0YKKL8+n+kxnv7WBaleE87AmdN5aEH7tTSD0=;
        b=GE4o4UgrHnVuBjbHYjL70FiW0mNsGq7LMqCYTiXoyni/vx2kywW1gnRzT4PSyG98in
         G6fQ7rhf4vu5kMFeka/ZnQoRZeWpKEFIXDEwxuPpb6ixK15sH2NIDEngx+qhdf7FTROy
         uS0Egk7/Odr4K9WyRbpEXvjbgTwe/T5dQ9rzwq1SeslQTjQxoSDFxMrSiDa7m3Y/9Ub1
         9c8Y8y/g/1rnNvWtCZhmosgezdT2iArDpxvpi8BqcmIgzz9gGcVu5giQUgkYVDSJDbUq
         p72/eazhxsfZvLmb5/EIkvHw0nbNZrJFFac6vjis3D5d5m4zTaeeFNgzv9GjFHEm0CgD
         zKMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685755249; x=1688347249;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Y8G14r0YKKL8+n+kxnv7WBaleE87AmdN5aEH7tTSD0=;
        b=kbtDvkZoaPDYSo4r/somBUYLt0eejETUX0sfeBTRcqCibD6zQHSspb9B+Csd5ToGvj
         m64pQSacni5QAnO+WO8u9/vCSyyYKz4qI+Zbc3qxgc4Fid/wVGVEpsKm4QMfmxqfCCxI
         s6XXtdA6mZAf6jrWOmVdLxKWfrvO8GQHGTvjDHUwBYimSAUvL4B4Vply+0yLFQxILQk4
         3YzzGrf6/LWIWIMik46fD6P2hG0fF7+u2987DSR4bCwoapMEPN6NiUwGrPF2445wTCiD
         gPwOX+PILkCI8biShVQUGYWZD/f1AlYVQYFKxzFSYcCbap+9iiggwJputpDXC2RJjY4+
         j8VA==
X-Gm-Message-State: AC+VfDz+5nJbrcERpB2bctLNpiu3aO5aQoBrb/1N3My7PJ3segTLqTz1
        iB8dUmnq0Jh+NKbrBh6SJC5hDe9D22U=
X-Google-Smtp-Source: ACHHUZ7LmVwCwsURitbtWYQSwB8mFwNeU2UJxFwVrfjzu6MUO9S7a1WjVJoOeSUzyHLEBBLxgtL0hw==
X-Received: by 2002:a17:90b:374a:b0:256:23f:abc5 with SMTP id ne10-20020a17090b374a00b00256023fabc5mr904687pjb.10.1685755248530;
        Fri, 02 Jun 2023 18:20:48 -0700 (PDT)
Received: from debian.me (subs28-116-206-12-37.three.co.id. [116.206.12.37])
        by smtp.gmail.com with ESMTPSA id t8-20020a17090a3b4800b00246cc751c6bsm3880815pjf.46.2023.06.02.18.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 18:20:48 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id B97121069ED; Sat,  3 Jun 2023 08:20:44 +0700 (WIB)
Date:   Sat, 3 Jun 2023 08:20:44 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Madhumitha Prabakaran <madhumithabiw@gmail.com>, rafael@kernel.org,
        lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
        Linux Documentation <linux-doc@vger.kernel.org>
Cc:     ivan.orlov0322@gmail.com
Subject: Re: [PATCH] docs: Fix warning:Error in "code-block" directive
Message-ID: <ZHqVbIouMkvM4OAs@debian.me>
References: <20230602215102.GA220958@madhu-kernel>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="TMDPLLkdIOvqcUM1"
Content-Disposition: inline
In-Reply-To: <20230602215102.GA220958@madhu-kernel>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--TMDPLLkdIOvqcUM1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 02, 2023 at 04:51:02PM -0500, Madhumitha Prabakaran wrote:
> Fix the error in "code-block" directive by providing the
> argument as "text".
>=20
> <snipped> ...
>  Result code:
>  ------------
> =20
> -.. code-block::
> +.. code-block:: text

Nope.

I don't see error you mention in this patch when making htmldocs on my
computer (my setup is pretty standard: see
Documentation/doc-guide/sphinx.rst). This patch is unneccessary, though,
unless you have code snippets in some language (e.g. C, where passing
language name to code-block:: syntax-highlight it). Result code outputs,
on the other hand, are generic text with no definitive syntax, hence
you can omit language name.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--TMDPLLkdIOvqcUM1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZHqVZgAKCRD2uYlJVVFO
o+pPAQC1MK/h/J4QW3qWmnbpauQ0Cr0k33lf8QV+hDnWKCkEpQD/QTYX820N+B3c
/0rBRMzVYbE7FluBIIK+7tJ0f+ahswg=
=JKVF
-----END PGP SIGNATURE-----

--TMDPLLkdIOvqcUM1--
