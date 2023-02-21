Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FDF269D796
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 01:39:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232682AbjBUAjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 19:39:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232049AbjBUAjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 19:39:14 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED2221A94E;
        Mon, 20 Feb 2023 16:38:59 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PLL4x6x37z4x7y;
        Tue, 21 Feb 2023 11:38:57 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1676939938;
        bh=54VT3hi54+xU3hQ7hjDVm+uWPqukW7UO4f0zUcMWF3Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VQdF0oc2cjjRtQ0/bAmXXnodaWI/p12SfaYonPofC6N6c1I/DnRmXFNKfUdBliUQV
         r0UOZ+AOZ9UjaiaxQUayIf0GjUKDCCYDtL1zvXLwzP4BXL3EwKJcopOE9sP3y6RKMd
         R5WeBvJGi3WmrksKtSUsJ01mCRYzLO38TR0by66W4EBG8IzwEZ/kxfnrsJwJPVz2e9
         WlU4dqrxxQf4cJ5Qn1rqBRVOR+rQa6OC1/nSolBFGtQwijsXuOroGM/Bk39HaHmAjb
         K6ZA2OdVMN3B3K+gM8Mep8qkwx6LlckDVAZaHmUBqiV+hNJl4CCbjiSihLFBzprewx
         O2++lxbaI7Brg==
Date:   Tue, 21 Feb 2023 11:38:57 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Steve French <smfrench@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, CIFS <linux-cifs@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        David Howells <dhowells@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Steve French <stfrench@microsoft.com>
Subject: Re: linux-next: manual merge of the block tree with the cifs tree
Message-ID: <20230221113857.770c6328@canb.auug.org.au>
In-Reply-To: <20230220114644.72387d19@canb.auug.org.au>
References: <20230220114644.72387d19@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/+Eh/0akKgz3jJ9FklBJhYjL";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/+Eh/0akKgz3jJ9FklBJhYjL
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 20 Feb 2023 11:46:44 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Today's linux-next merge of the block tree got a conflict in:
>=20
>   fs/cifs/misc.c
>=20
> between commit:
>=20
>   8378eea2e41f ("cifs: Change the I/O paths to use an iterator rather tha=
n a page list")
>=20
> from the cifs tree and commit:
>=20
>   220ae4a5c2ba ("cifs: use bvec_set_page to initialize bvecs")
>=20
> from the block tree.
>=20
> I fixed it up (the former removed the code update by the latter) and
> can carry the fix as necessary. This is now fixed as far as linux-next
> is concerned, but any non trivial conflicts should be mentioned to your
> upstream maintainer when your tree is submitted for merging.  You may
> also want to consider cooperating with the maintainer of the conflicting
> tree to minimise any particularly complex conflicts.

This is now a conflict between the cifs tree and Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/+Eh/0akKgz3jJ9FklBJhYjL
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmP0EqEACgkQAVBC80lX
0GwWKwf/WzeNxNX/Rtl2p/43jTR18l0hN2zO51fpIA1proaRgHDvUywoxUrp5wzF
lJ/86/mmeBMpnC+2yoc3y1xim8s3CM/NMdgVxnBtOCHLL9nBjVTpRQ42XGZPAzzp
ajWsKKW3LymFf8WLDwIxbmx4gCNaubduvbjQUfcWXpuRzhOXckYxgxDtTSawS1Pb
La3nfZ4xu8hflW1nYsIQw34awT3gZDW+oCmfwvjcLqdsnKZKDDyuvg8mvPID9DXc
wDTenS1nrDDX0JzDzgDvkorexCZb5wRHzrUUtRLTm//+u669YPSaeQy+rmFlZAaP
jx0MB3vA3sdkqObdGLN9ElSAbVa1eg==
=r1oU
-----END PGP SIGNATURE-----

--Sig_/+Eh/0akKgz3jJ9FklBJhYjL--
