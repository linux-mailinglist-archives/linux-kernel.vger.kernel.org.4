Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49FD870D32A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 07:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbjEWF3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 01:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231195AbjEWF3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 01:29:38 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40BE9109;
        Mon, 22 May 2023 22:29:36 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QQNDH00dRz4x49;
        Tue, 23 May 2023 15:29:34 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1684819775;
        bh=wZNEkAtDP2sUitESvCB5cU5bsOnaBaxjEBFpjdeFMVA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JSBU9K6lIhMAYHo+SQ9FcTt0qwGOeIx8nTLUncjkQXmLyqW0HH/rFa14eHgEN2jqJ
         TP0wpO/dXE0HiUyLIOJGx8FoHlKft+PetgvZYbpuQEVO2TsN9buF7klyXcq50Pojdr
         QN8PaegnQea8Z/NoG//77bAP+wIl/8aeIXhHMmV9n7ykvoU/+JxBhYN9ess3ez9jVF
         Hu4DgoIwpQjq7e7Z0/rXd3WHx2LCm8gTAJPmtoF3ZDh1styLtNTGaDsJPf1FPEVe8I
         InM7PzvXNf60Mca9BQ0CKCwbW4YkQwuh4C5iRzrC+LWqCa742DqMhzvG5MpbIGbtZ9
         Z9nkbeh/Pgftg==
Date:   Tue, 23 May 2023 15:29:32 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Tree for May 23
Message-ID: <20230523152932.13a6ed3a@canb.auug.org.au>
In-Reply-To: <20230523152743.52c91e24@canb.auug.org.au>
References: <20230523152743.52c91e24@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/HDUbgN1YZTmKft5JjKbYVQn";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/HDUbgN1YZTmKft5JjKbYVQn
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 23 May 2023 15:27:43 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Changes since 20230522:
>=20
> The crypto tree still had its build failure.
>=20
> The drm-misc tree gained a conflict against Linus' tree.
>=20
> The rcu tree still had its build failure so I again used the version
> from next-20230518.

This release also produces some boot time warnings from the sysctl changes.

--=20
Cheers,
Stephen Rothwell

--Sig_/HDUbgN1YZTmKft5JjKbYVQn
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmRsTzwACgkQAVBC80lX
0GzXigf+MzNs6fRa0zRUvjh/nIBr6TzjLbB03H/IZqfk9IHebXkZG48vvlsAl+lY
SuBgnueFbyk1FFeaDxQKFnclWaoJzVabkGwU18dIoNHAKNRAU7vrVr2vHGC4GnH8
kzb4Yd0w6zPEjD5x6wSW/a7jQOMEWSUsnH7Nu0HTNszx2gsrWFe+LKAjUf61Z9x6
ELXwBRQ5Kl/qu8pJudtxNHGXzurkd6gEzbGvDooEUTgUMon3nSFmQKXo2+gBi2qh
4zmgH+fdxenKLGDO3LXG3G/htlc3qIyRAeXvCvH/VaOCFNDtfA6RGCBCzhqJVE/f
F1dXW72RqrP/h5pkvfn3iG0xXeWiXQ==
=43Ex
-----END PGP SIGNATURE-----

--Sig_/HDUbgN1YZTmKft5JjKbYVQn--
