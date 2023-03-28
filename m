Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00CC56CCDDD
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 01:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbjC1XGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 19:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjC1XGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 19:06:20 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01D692683;
        Tue, 28 Mar 2023 16:06:18 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PmQKK5TkHz4x91;
        Wed, 29 Mar 2023 10:06:13 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1680044774;
        bh=KdJ09PCPVP0eDPbHTNgYmbVuTNoaWI35HTEXHBJ/wEg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ei1jh5oO6EnPPYZJplEvFCHTnqxa0Ixdj0nbH8fdGL95CFPZZbnNqYDu2leD5p6Hr
         17tTkJ+xRp33W7YONmM384zppHqrADDwbdxXpPT3LOR+0jb2Of5HS80GBRX453iDia
         nzwu2cYhYK2UJUEgvTQ4jpuS8ZlEre47QRQkSaqw/GJq+ClxCVp9mp9S87L6Ss/drJ
         KUFwrZ/Q11vOZAzQfIdn3ruuE6fiVJBN9/zA6AdfJgm+a4v3bU2G6bNcv3JueSjucP
         aZWHNA+VPM84OM8tUM45y+T04AOdUu7V9V5U1GjzDpm7N7f2ONWz+C/65pGxWqGHFS
         lkW3dJV+KM8zg==
Date:   Wed, 29 Mar 2023 10:06:12 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        namhyung@kernel.org
Subject: Re: linux-next: build failure after merge of the perf tree
Message-ID: <20230329100612.074b18d0@canb.auug.org.au>
In-Reply-To: <ZCNES6N7AkskjD0o@kernel.org>
References: <20230317095025.49aa34f9@canb.auug.org.au>
        <20230322083956.5c051777@canb.auug.org.au>
        <CAP-5=fUHqrQWPjk7QJB=r2Gzj7z5X3nL4bRuBAKzy2HvdSAr-A@mail.gmail.com>
        <20230323095437.1ecccec1@canb.auug.org.au>
        <ZBxTyLqkIaoVhIXU@kernel.org>
        <20230328123332.0a3e2b6d@canb.auug.org.au>
        <ZCNES6N7AkskjD0o@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/QFDnZ254T1RjKuMJrMf96jD";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/QFDnZ254T1RjKuMJrMf96jD
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Arnaldo,

On Tue, 28 Mar 2023 16:47:23 -0300 Arnaldo Carvalho de Melo <acme@kernel.or=
g> wrote:
>=20
> The config files you used don't match the running kernels

This is just the way Debian names its kernel packages.

> > $ uname -a
> > Linux zz1 6.0.0-5-powerpc64le #1 SMP Debian 6.0.10-2 (2022-12-01) ppc64=
le GNU/Linux
              ^^^^^^^^^^^^^^^^^^^
> > $ ls -l /sys/kernel/bpf/
> > ls: cannot access '/sys/kernel/bpf/': No such file or directory
> > $ grep CONFIG_DEBUG_INFO_BTF /boot/config-6.0.0-5-powerpc64le
                                              ^^^^^^^^^^^^^^^^^^^

And so on.  It just happens that this kernel is based on v6.0.10.

$ uname -r
6.0.0-5-powerpc64le

So they are the correct config files.

Also, the mail I replied to talked about checking /sys/kernel/bpf/ (not
btf) :-(

still on my build machine (of course):

$ ls -l /sys/kernel/btf/
ls: cannot access '/sys/kernel/btf/': No such file or directory

So it seems that Debian do not build their powerpcle kernels with
CONFIG_DEBUG_INFO_BTF. I don't know why not since all the dependencies
seem to be OK.

[On my arm64 machine:

$ ls -l /sys/kernel/btf/vmlinux
-r--r--r-- 1 root root 5209570 Mar 29 09:52 /sys/kernel/btf/vmlinux

and on my amd64 machine:

$ ls -l /sys/kernel/btf/vmlinux
-r--r--r-- 1 root root 8536946 Mar 29 10:04 /sys/kernel/btf/vmlinux
]
--=20
Cheers,
Stephen Rothwell

--Sig_/QFDnZ254T1RjKuMJrMf96jD
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQjcuQACgkQAVBC80lX
0GwpUgf+Lpof9NASqZYY8vuy/deXTNsOLMTTFp55sY3llg+DEiJhU74u3rfP8ia+
JUCqihqi7Q4T6P+U9oyut0br3iJecwLxYmSbYZoJaGu42o3k+1JM0V6SpWMFwxFU
dMNMSdaq0aTcszL9hj2n8ElHLBjmj550fwlxT9BwFvgcwfAvIq8BA05BE0v4+Lh2
9P0q/6F9UTrDIi9MMafkKi8jVTJjlM5hNayb48UoQUAI7QvfRgq/rT1bMKSY922a
4s3OWQEf5dT5IDlV6KjMkIMPVWwbZvp5w90kt6QK0EymKJKoUsag7oomBrDY5PsP
MO8AyJc8Btc7K9b7yQKoaEHcSHDhew==
=WZe8
-----END PGP SIGNATURE-----

--Sig_/QFDnZ254T1RjKuMJrMf96jD--
