Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64ADB6730FA
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 06:08:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbjASFIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 00:08:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbjASFHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 00:07:02 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B285A717A3;
        Wed, 18 Jan 2023 21:02:08 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Ny9Tl1DYrz4xG5;
        Thu, 19 Jan 2023 16:02:03 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1674104524;
        bh=tqd9hANaxCXELym6FOuTV7hFuiVG2HzesCewelOsJeo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GYDm1gXfNxYPjmBdJICTbUmKuRDWOUUFeuHFh4mNdSMqmBHh9skOGmB9EtjvFhC1o
         ekUN1EhEOVJvnL2jLdsCLkFbMA3wINgpknvzLjQhbXgNTcXb/icJpet0PVUGUnvDdT
         gAuxU4cHAmuwCloYfrEaUIdy9TN9i/3+bpACQ4MQ34w7gsIFgW1GexBY+wrPW6s0ye
         Dck3NLakO8NPjGcxKp7Cbx7Jsg13L6Tp6kA8GVJJ+tBPQ43zXGkcNKfn2Wni4YZuQt
         HkoIk1IPr+AIHCa9tDatIrmKvOTT+hfeh+vYjHc02mO5AdfC1PfqVheNRHpQgbUsYY
         +Ew5vlU3GCJPw==
Date:   Thu, 19 Jan 2023 16:02:02 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Eric Biggers <ebiggers@kernel.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Eric Biggers <ebiggers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: Re: linux-next: manual merge of the mm tree with the fsverity tree
Message-ID: <20230119160202.3de5506f@canb.auug.org.au>
In-Reply-To: <20230110132519.72181341@canb.auug.org.au>
References: <20230110132519.72181341@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/CBYgbE9blIfxqCA.BjX8Yn4";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/CBYgbE9blIfxqCA.BjX8Yn4
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 10 Jan 2023 13:25:19 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Today's linux-next merge of the mm tree got a conflict in:
>=20
>   fs/buffer.c
>=20
> between commit:
>=20
>   2a042de143b2 ("fs/buffer.c: support fsverity in block_read_full_folio()=
")

this is now commit

  4fa512ce7051 ("fs/buffer.c: support fsverity in block_read_full_folio()")

> from the fsverity tree and commit:
>=20
>   a0ab20df28e6 ("buffer: replace obvious uses of b_page with b_folio")

this is now commit

  abc8a8a2c7dc ("buffer: replace obvious uses of b_page with b_folio")

> from the mm tree.

from the mm-stable tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/CBYgbE9blIfxqCA.BjX8Yn4
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPIzsoACgkQAVBC80lX
0GxPXAf+MdulrdCs0wxQwAdWc4jV/sirxg+TtGVLkPqEK/M04PXthX6E/ICkJN66
jfU2rTKSiHLrr72COtWKnN/UJBfTN5LoaOtyovoH7HTWlGl06HP2hOEsF1QANIfk
uqA8Ls5M49krsTdqhYeb8k3d27NjUgkf2c6DBeeTNJQhBarKs2q7xQzWSaembk5K
r+SUviG1ee6+8tTLpWk1i5F9cVw3f6qN4SduKBHhXm3eiJ8sOFC0ou5UzGrvENbT
q9GSXxUoQ0DLfSgvb7DPHmLcQZ6pbkWQG04SeeExgZmuiWQZpg1JQrOayMUKeUch
fAcCX+l2+thmj6muaemH7Q1eQyQsQw==
=EtZX
-----END PGP SIGNATURE-----

--Sig_/CBYgbE9blIfxqCA.BjX8Yn4--
