Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98F386A019A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 04:47:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232788AbjBWDrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 22:47:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230412AbjBWDru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 22:47:50 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B6FA2CC46;
        Wed, 22 Feb 2023 19:47:47 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PMf9n6YFdz4x7s;
        Thu, 23 Feb 2023 14:47:41 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1677124062;
        bh=qh5OKshcNENkBWhRvJdOjGZQdwgyHk3KfwbjJb1kZFk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=a0OnEUsNFuvHM+fj2DAE0CA7PLAHPTnJrUK9tvwkXMeR6SMmmbRhd1bgHKP7fM4O9
         q+tXDU3vlliM6rHWzJJjSTgI3fkTX22u6yg4lbTNIB6Vt3ZWZd8NKJONf6YAGvJxDH
         d5lsEWuJxNCtyk3KlXroRFbD3bBB3Kfp298qvSmDcQhsZpPuYeWY4EWlsF3CJvzq0X
         abzmMdbM7bWgTTM31EzaFzv6cvOFTbS4YJbjf9kgOEsRo7iSYN7YG3IvntqhAPeZEn
         g5CDfdpAjwq0YG2JgSMl8xS4J415SGLWRH7tfYnJEoyttsTpebFReuh4LeYuV/miq2
         s8n5rn/oRsEhg==
Date:   Thu, 23 Feb 2023 14:47:22 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Theodore Ts'o <tytso@mit.edu>
Cc:     Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: linux-next: manual merge of the mm-stable tree with the ext4
 tree
Message-ID: <20230223144722.635ab483@canb.auug.org.au>
In-Reply-To: <20230221175436.599166f9@canb.auug.org.au>
References: <20230220152938.45f62d5a@canb.auug.org.au>
        <Y/ODNJ3MfoD6dUru@casper.infradead.org>
        <20230221175436.599166f9@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/eWRXW5OJlOcuX.QMv2J1f+=";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/eWRXW5OJlOcuX.QMv2J1f+=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 21 Feb 2023 17:54:36 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> On Mon, 20 Feb 2023 14:27:00 +0000 Matthew Wilcox <willy@infradead.org> w=
rote:
> >
> > On Mon, Feb 20, 2023 at 03:29:38PM +1100, Stephen Rothwell wrote: =20
> > >=20
> > > Today's linux-next merge of the mm-stable tree got a conflict in:
> > >=20
> > >   fs/ext4/inode.c
> > >=20
> > > between commits:
> > >=20
> > >   726432969963 ("ext4: use nr_to_write directly in mpage_prepare_exte=
nt_to_map()")
> > >   9ff6a9153c8f ("ext4: move page unlocking out of mpage_submit_page()=
")
> > >   b4d26e70a755 ("ext4: move mpage_page_done() calls after error handl=
ing")
> > >   9b18c23c131a ("ext4: convert data=3Djournal writeback to use ext4_w=
ritepages()")
> > >=20
> > > from the ext4 tree and commits:
> > >=20
> > >   50ead2537441 ("ext4: convert mpage_prepare_extent_to_map() to use f=
ilemap_get_folios_tag()")
> > >   d585bdbeb79a ("fs: convert writepage_t callback to pass a folio")
> > >=20
> > > from the mm-stable tree.
> > >=20
> > > I have no idea how to fix this up, so I have used the ext4 tree from
> > > next-20230217 for today.   =20
> >=20
> > Yeah, this one's a mess.  Probably the easiest solution is for Ted to
> > pull in 247f9e1feef4 and 50ead2537441 and then redo Jan's patches on
> > top of them. =20
>=20
> I am still using the ext4 tree from next-20230217 (which was empty
> relative to Linus' tree).
>=20
> So, I have to ask why all these commits were only published to
> linux-next over the weekend?

I still have not been able to figure out a merge resolution for this,
so the ext4 tree still has had no testing in linux-next and the merge
window is progressing.  Does anyone want to help with this?

--=20
Cheers,
Stephen Rothwell

--Sig_/eWRXW5OJlOcuX.QMv2J1f+=
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmP24coACgkQAVBC80lX
0GypqQf+PIi0cmCr6h401CaWIBwMYGN4QwhYA7SZST9SSaCjhcx1r7AJOT+uAf4l
d9vQZvTh85wINBXjEzR3A7CVDEmA5aUv9P9/8f/nW6NCQZJVGJdfrscy0iIJJyUQ
BsHxJ8fEsGEKjDE8WYi8kRHhe+C7tqFkwqLRArSA59zxyJ/7qSo7D0UmCEMJmQmj
RKLeBENaeLArA5DH2B4w3b/NWf0IG6baGPBMb/uP3wTJnbTgCQBjAaQV2vvyJqfK
bfTkPk12b6Hr3yNfzOkNqMoJC0UXtUa75FhzOCJEA517mVm0WsyYze+dWpvi3Pu+
97BTm+2sQpBRUhRDOXwIo9xjSkPWng==
=yems
-----END PGP SIGNATURE-----

--Sig_/eWRXW5OJlOcuX.QMv2J1f+=--
