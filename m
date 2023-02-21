Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A34E69DAD1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 07:54:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233387AbjBUGym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 01:54:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232813AbjBUGyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 01:54:40 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5546610A94;
        Mon, 20 Feb 2023 22:54:39 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PLVQP0gHCz4x7y;
        Tue, 21 Feb 2023 17:54:37 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1676962478;
        bh=G8olMEdik0DV14GvEjp3yAT6sZDj7bSrz5TYC0i36M4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TdxxTI+2WbIVVYd9B/s0PSUahGguGd60/Pr/XtrjfRtFWgzxR3KdBclxm18l8ZcTQ
         cMN2G6a/yZWh9fBI/y1tp/xSMHi27wrnaYzd/pDhBRm1+NxXH8RcfsKrpU5xwXtn+I
         /gR1ih26bd8EB84yOaclTlzz/1rz09wTZB6de518hPuvkZyNgnvA1t9QPO7hb4PfDQ
         cE0BdePN7u3joro0yzC2/rhhXN55S9PLF7WuJ8TscVOm9kAZP1uf2n6jWN/5dshP8f
         DB/M8hRnXf6trQcqm8Ci2xFewHg0PI7jbDv4rayvYp13fWWpwITFBgb8qJx5eBGh61
         zsZY8Q3DcwGcw==
Date:   Tue, 21 Feb 2023 17:54:36 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Theodore Ts'o <tytso@mit.edu>
Cc:     Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: Re: linux-next: manual merge of the mm-stable tree with the ext4
 tree
Message-ID: <20230221175436.599166f9@canb.auug.org.au>
In-Reply-To: <Y/ODNJ3MfoD6dUru@casper.infradead.org>
References: <20230220152938.45f62d5a@canb.auug.org.au>
        <Y/ODNJ3MfoD6dUru@casper.infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/1R0P7KsQsElWG=mbcRYf/DB";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/1R0P7KsQsElWG=mbcRYf/DB
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 20 Feb 2023 14:27:00 +0000 Matthew Wilcox <willy@infradead.org> wro=
te:
>
> On Mon, Feb 20, 2023 at 03:29:38PM +1100, Stephen Rothwell wrote:
> > Hi all,
> >=20
> > Today's linux-next merge of the mm-stable tree got a conflict in:
> >=20
> >   fs/ext4/inode.c
> >=20
> > between commits:
> >=20
> >   726432969963 ("ext4: use nr_to_write directly in mpage_prepare_extent=
_to_map()")
> >   9ff6a9153c8f ("ext4: move page unlocking out of mpage_submit_page()")
> >   b4d26e70a755 ("ext4: move mpage_page_done() calls after error handlin=
g")
> >   9b18c23c131a ("ext4: convert data=3Djournal writeback to use ext4_wri=
tepages()")
> >=20
> > from the ext4 tree and commits:
> >=20
> >   50ead2537441 ("ext4: convert mpage_prepare_extent_to_map() to use fil=
emap_get_folios_tag()")
> >   d585bdbeb79a ("fs: convert writepage_t callback to pass a folio")
> >=20
> > from the mm-stable tree.
> >=20
> > I have no idea how to fix this up, so I have used the ext4 tree from
> > next-20230217 for today. =20
>=20
> Yeah, this one's a mess.  Probably the easiest solution is for Ted to
> pull in 247f9e1feef4 and 50ead2537441 and then redo Jan's patches on
> top of them.

I am still using the ext4 tree from next-20230217 (which was empty
relative to Linus' tree).

So, I have to ask why all these commits were only published to
linux-next over the weekend?

--=20
Cheers,
Stephen Rothwell

--Sig_/1R0P7KsQsElWG=mbcRYf/DB
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmP0aqwACgkQAVBC80lX
0Gz3IQf/fIehq13N+cYwUhgaVJex9+WYP7YNREEKObBRbAEQsMk8G4H759Cz+ZQr
29CWAX8tYxecRhSE+6yVUO3Qsu1n/5ev7znMgbf9AGdjOLRp5CySnH55QPas2Xk3
VsZO4FqhKamrapa282RJ3ltgaBVmgqfFICZxKnmrwTy1H0jgZ+AiqGiGY8E0ysds
O5kYTAo8QGkgVYSf/uiRalXnTQQJJ9vu3fu4wC8tg4TG9zTgWJvFEGQFSdL9vp+L
Tu7o/TdjTGj048cxUa2IngrT49/g3pZQFPZ/a6cXgtsl/Yts8q2sRVlbw5woNQeD
PTbdUZAw/DBZwJdxKSw9+pPf8ExK2w==
=yC5D
-----END PGP SIGNATURE-----

--Sig_/1R0P7KsQsElWG=mbcRYf/DB--
