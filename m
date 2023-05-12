Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BCB66FFE65
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 03:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239742AbjELBZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 21:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239738AbjELBZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 21:25:16 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF89559C4;
        Thu, 11 May 2023 18:25:08 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QHWKG2VQgz4x3d;
        Fri, 12 May 2023 11:25:06 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1683854707;
        bh=WJA3LTnEaIh1XHW+cYAfyf0qqGsenct9dIejsgfE41A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JC3wUAbw8bM8Tdd/t2QYgz6WZIVcO+lwEuOSYD97oZLaHVJ8we3I4HVM6q+umiGVR
         xc2FJv6pEl79hgmAP1GFJcIDT9abS6wyzGi6Ltdv6F4hMTBq+LK7/GvXQYmUw30d5z
         mbz769SwSlx3VhUlmHlYpl2hVCTJQxYzsFHxVMgYKwD3er+hYCvH4ITP9S9djZfaYc
         wt2q+nI5Sweac1AwckgfNzS/KIW/MV4dEdv1i0CijqlLowTGZqqJb7BGkdV7n3yA0a
         vMIbt4o0r7ZmWeV1sBljIqHrEkWVAazaRXVHX/GocDk8qkIAUt/0Aw7oWzq4elf69r
         0JiBfIZeb5ZXA==
Date:   Fri, 12 May 2023 11:25:04 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the rcu tree with the rdma tree
Message-ID: <20230512112504.65b39539@canb.auug.org.au>
In-Reply-To: <CAEXW_YRMjXpRoss_cgF_mghseZbY-86UouDmcLbVW-oOpZ_D2A@mail.gmail.com>
References: <20230328121609.68105dd5@canb.auug.org.au>
        <4fd06223-e307-50e6-f4ec-40ca34fc1a4b@gmail.com>
        <CAEXW_YRMjXpRoss_cgF_mghseZbY-86UouDmcLbVW-oOpZ_D2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/HYDV9521Pv2iJK=ypAWmtE4";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/HYDV9521Pv2iJK=ypAWmtE4
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi all,

On Wed, 29 Mar 2023 15:58:20 -0400 Joel Fernandes <joel@joelfernandes.org> =
wrote:
>
> On Tue, Mar 28, 2023 at 12:38=E2=80=AFPM Bob Pearson <rpearsonhpe@gmail.c=
om> wrote:
> >
> > On 3/27/23 20:16, Stephen Rothwell wrote: =20
> > >
> > > Today's linux-next merge of the rcu tree got a conflict in:
> > >
> > >   drivers/infiniband/sw/rxe/rxe_mr.c
> > >
> > > between commit:
> > >
> > >   5bf944f24129 ("RDMA/rxe: Add error messages")
> > >
> > > from the rdma tree and commit:
> > >
> > >   330f72b82ab0 ("RDMA/rxe: Rename kfree_rcu() to kvfree_rcu_mightslee=
p()")
> > >
> > > from the rcu tree.
> > >
> > > I fixed it up (the code modified by the latter was moved by the forme=
r,
> > > so I used this files from the former and applied the following merge =
fix
> > > patch) and can carry the fix as necessary. This is now fixed as far as
> > > linux-next is concerned, but any non trivial conflicts should be ment=
ioned
> > > to your upstream maintainer when your tree is submitted for merging.
> > > You may also want to consider cooperating with the maintainer of the
> > > conflicting tree to minimise any particularly complex conflicts.
> > >
> > > From: Stephen Rothwell <sfr@canb.auug.org.au>
> > > Date: Tue, 28 Mar 2023 12:12:24 +1100
> > > Subject: [PATCH] fixup for "RDMA/rxe: Add error messages"
> > >
> > > interacting with "RDMA/rxe: Rename kfree_rcu() to kvfree_rcu_mightsle=
ep()"
> > >
> > > Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > > ---
> > >  drivers/infiniband/sw/rxe/rxe_verbs.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniba=
nd/sw/rxe/rxe_verbs.c
> > > index 84b53c070fc5..bbdfbff5c752 100644
> > > --- a/drivers/infiniband/sw/rxe/rxe_verbs.c
> > > +++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
> > > @@ -1341,7 +1341,7 @@ static int rxe_dereg_mr(struct ib_mr *ibmr, str=
uct ib_udata *udata)
> > >       if (cleanup_err)
> > >               rxe_err_mr(mr, "cleanup failed, err =3D %d", cleanup_er=
r);
> > >
> > > -     kfree_rcu(mr);
> > > +     kfree(mr);
> > >       return 0;
> > >
> > >  err_out: =20
> >
> > Thanks, I thought we had already done this. If not then we should. This=
 is the correct fix
> > for that rcu mightsleep business.
> >
> > Reviewed-by: Bob Pearson <rpearsonhpe@gmail.com>
> > =20
>=20
> Bob, could you please squash Jon's diff into your original patch
> ("RDMA/rxe: Add error messages".) before you send your pull request
> for 6.4? Then I can just drop my patch.
>=20
> That will be best. WDYT?
>=20
> thanks,

I am still applying this fix up patch to the merge of the rcu tree ...

--=20
Cheers,
Stephen Rothwell

--Sig_/HYDV9521Pv2iJK=ypAWmtE4
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmRdlXAACgkQAVBC80lX
0Gxv7Qf/VMU/HU/m2sCyN3x1j+Xsophk3Yr/LdzQEZcMF1DP4lDQkn2qFveEpZB5
NyipcJHHvZu0bE9aJo9bzIhZnX1PQNJZus7x+EsfR7HOsZC7nDG7bcq8EDdpBt+I
xujXTwpzgm0Ai21RPNPeeY1QNC8h9NoW8l33/uptUfrzXSSqtCWUW9lTwzgh9aMt
mQpKgFPNAVRwZzT3vPXEaNFo0ZflndRlvWsEx0RC1cFJXKL+LFzh6Bur3wv2RMqA
bgjWRYzgPX/z8oHazKNdsv+Ib22OxC//SUCtKd0PpMx5SaQyQhg8MQxdonuROiUv
EGFt5OoD4zIVskAhApONUfwCZd/Mfw==
=8jP8
-----END PGP SIGNATURE-----

--Sig_/HYDV9521Pv2iJK=ypAWmtE4--
