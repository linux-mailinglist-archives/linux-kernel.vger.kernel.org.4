Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDB1169D573
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 21:58:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232143AbjBTU6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 15:58:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjBTU6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 15:58:03 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76FC2BDF2;
        Mon, 20 Feb 2023 12:58:02 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PLFB06BlWz4x1R;
        Tue, 21 Feb 2023 07:58:00 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1676926681;
        bh=fjl7Sq7lh7+rwBgYb1dUIlexcmRQSJ2tmb+eCOJT+wE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=krjeEwh1m6C738MNUeVHeOfZZlEjpfkwUznvqsbAD8cf1J6UL5QQ1y23vyWr4Myj2
         9qlRseRBPkCQIO/89n0iGQVXC9wa/g5PFaU8e90hqVFHv/Rpd1oFIKX998qotauCGK
         jPrny6yUPoq/1mIBSgcQBF+BeDDHULvxpShF9QdaCRW9cjSumNF1X6IEmp9vAL/kXM
         LxwnYEU7EUz9y1grqWzus/MlEpoBk3XeZx+PmY8AaX++SI2zIfQGxP7mL7wDsB3Xth
         u43mo5KRYvXiWcc8qk/OHS6Xzx6Fe+AV7HRlEAElyP7QE/yQPRRu2fPHvaIxv5c/99
         s7OVfHWgXl3vQ==
Date:   Mon, 20 Feb 2023 19:05:09 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     David Howells <dhowells@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steve French <smfrench@gmail.com>,
        CIFS <linux-cifs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Steve French <stfrench@microsoft.com>,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: Re: linux-next: manual merge of the mm-stable tree with the cifs
 tree
Message-ID: <20230220190509.06e9a3cb@canb.auug.org.au>
In-Reply-To: <Y/ON+ugfcFBdeZ4i@casper.infradead.org>
References: <Y/N8hVWeR3AjssUC@casper.infradead.org>
        <20230220152933.1ab8fa4a@canb.auug.org.au>
        <1676391.1676903381@warthog.procyon.org.uk>
        <Y/ON+ugfcFBdeZ4i@casper.infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/3TCpOURP6L_/Swc0Tm5qjLy";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/3TCpOURP6L_/Swc0Tm5qjLy
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Matthew,

On Mon, 20 Feb 2023 15:12:58 +0000 Matthew Wilcox <willy@infradead.org> wro=
te:
>
> On Mon, Feb 20, 2023 at 02:29:41PM +0000, David Howells wrote:
> > Matthew Wilcox <willy@infradead.org> wrote:
> >  =20
> > > Doesn't look too bad to me.  Dave's commit is just removing the
> > > functions, so it doesn't matter how they're being changed.
> > >=20
> > > The real question in my mind is why for-next is being updated two days
> > > before the merge window with new patches.  What's the point in -next
> > > if patches are being added at this late point? =20
> >=20
> > It's more of a transfer of a subset of my iov/splice patches from the
> > linux-block tree to the cifs tree.  I thought Jens would've dropped my =
branch
> > from his tree for the moment. =20
>=20
> Your iov/splice patches don't conflict.  The part that you snipped says
> it's c8859bc0c129 ("cifs: Remove unused code")

That is just the immediate conflict. See my other reply.

--=20
Cheers,
Stephen Rothwell

--Sig_/3TCpOURP6L_/Swc0Tm5qjLy
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPzKbUACgkQAVBC80lX
0Gx2Lgf/UklYtwpTkibZrdi2GXNRjV4CPSeWRUgBw2f7YTVudivI04tHFO3/nXOi
WmRkLZ6zKfJjtEzR8dyPe8DrcUk8u4CybWe4m3PVpm5yFg+rhtNRfzIwHKbLxOZ/
i65foCtqRO57V/ZbphgzqxeeUy6shSc7N1Xo4HFlUqJbyCvAPoO05DH8szcg+nQV
z1tVRzTYZiHc+PC9ugjEmkboMLYBvwP5iLjrc46PsjBXDzDtPBWHRks0Yl/PIokh
6pK0IMx7uF3KkSryeGauUOs9tLTrmPqLjJzX5viCVf9BWHELv4MRuDTjipk4yKL9
nEgxY3aWjNb0aEhkeOm59AhRsSDRCA==
=YeX2
-----END PGP SIGNATURE-----

--Sig_/3TCpOURP6L_/Swc0Tm5qjLy--
