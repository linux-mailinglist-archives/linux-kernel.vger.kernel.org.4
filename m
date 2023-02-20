Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC2B369C43D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 03:50:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbjBTCuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 21:50:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjBTCuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 21:50:01 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A17CD509;
        Sun, 19 Feb 2023 18:50:00 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PKn2W51wrz4x5Y;
        Mon, 20 Feb 2023 13:49:55 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1676861395;
        bh=9eSY6o2ILY8CmBVhSmnUdXeHBS6sR8zEiUxlUbJhq64=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FoEkA/XaKXzp3TpYEc8oTb4SceF+OScLWR0VKXUxWu/CZuDExWAGRYP16cslZCOId
         EuwzxsHk5wYv9HK8BYlh3b2bySyCxn+hrso+heXtjA+zCJnNKXv7zcHx1WLSbMfNIa
         t/f9qvRZr83nEAyKfGtM5ZmLNHhJBVxHuyuX1H3p1dPWISk+jNwRQlXK23qODC2psU
         jSDAQsma3S+H3lUWNDAGWezhaPwTN30HDOvdjhq2jCP+jt5nXcl2vg578HD8ryHchz
         K7YllhIYY6+TKjKnaz2eRudLIUc1oDeowNChYX4Vs4pfaRNNhflc00uQecBQUIreNW
         GyKJolIXme6eQ==
Date:   Mon, 20 Feb 2023 13:49:54 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Howells <dhowells@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Steve French <smfrench@gmail.com>,
        CIFS <linux-cifs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patches in the block tree
Message-ID: <20230220134954.7b57b6d7@canb.auug.org.au>
In-Reply-To: <1214277.1676857660@warthog.procyon.org.uk>
References: <20230220120234.161a6002@canb.auug.org.au>
        <1214277.1676857660@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/YZap3Z58ufl5T5GIB+/jv/a";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/YZap3Z58ufl5T5GIB+/jv/a
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi David,

On Mon, 20 Feb 2023 01:47:40 +0000 David Howells <dhowells@redhat.com> wrot=
e:
>
> Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>=20
> > The following commits are also in Linus Torvalds' tree as different
> > commits (but the same patches):
> >=20
> >   78e11ab5adf7 ("mm: Pass info, not iter, into filemap_get_pages()")
> >   a53cad008099 ("splice: Add a func to do a splice from a buffered file=
 without ITER_PIPE")
> >   f2aa2c5707ac ("splice: Add a func to do a splice from an O_DIRECT fil=
e without ITER_PIPE")
> >   51e851b5d16f ("iov_iter: Define flags to qualify page extraction.")
> >   0fff5a38a770 ("iov_iter: Add a function to extract a page list from a=
n iterator") =20
>=20
> In Linus's tree?  Did you mean the block tree?

Oops, actually they are in the block tree and the cifs tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/YZap3Z58ufl5T5GIB+/jv/a
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPy39IACgkQAVBC80lX
0GwGPQf9F8XGoMi2HRt3A1/BRk/PKKr0aTAzVJU5Lro/UKDQcLT92j+Gr5PCSjmP
KjBB2G6tvteEl3bniGYfWanmBTyB/hH8dAcdfV+BnxshAM6Q279gp6paAQrggip3
2RMG0vnbM6VDfIGXMEJgbt8RLRF0SjYAo8bMlZGpbL6ZLHfAR4qZMuEWOqZ4klBn
MrtWKiTvq0Ub4DjcIxQibSjG6m1tuTV+HzBh5yyxCHF5VXlzDgJKoMwlk5fIz6jv
Ps1/5e4QgNCPEgrP5AeEg+qG6R06APu3eVIaKp3gutECc7HlpLHsZ2nHvQQFY2hg
7BRGeLWc6TeYHOyFXkSutNrdOeb33A==
=uBgP
-----END PGP SIGNATURE-----

--Sig_/YZap3Z58ufl5T5GIB+/jv/a--
