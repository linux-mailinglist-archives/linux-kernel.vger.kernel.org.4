Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAC1469D748
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 00:45:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232747AbjBTXph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 18:45:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbjBTXpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 18:45:34 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE07F1E9FD;
        Mon, 20 Feb 2023 15:45:32 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PLJvG5Bgwz4x1h;
        Tue, 21 Feb 2023 10:45:30 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1676936731;
        bh=JLytw3ranhc4JM8T9vusgGGu8sJVzGcLp30afq00hdo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=r3cgDiAoBWnvnMoPqX8BtV8KcqpHEYY8+Vi26MQ9vhpXHlh6yBmHebV+EKPRbgsM+
         k25qADToOvkakTcwSG5K3IuGWS1wioY6GAERz0RKOCt332cyNWggBJ0j1/T8wpa1aL
         4kHJ5KGZeee61GrrLXRkINXveGlrKI2UppxUDwQO1WCfMCgz1YFs+fDs6xzy2WPROX
         N4WJjjcPiOfCZTs+ToLCRGGfEMjs/hU0t9C7pvl2BR23pxRrUqJnghp/DgsE3DKXSC
         F9ma0ypqqftQhVWwC0gL/UxrXFGYA5hu4MzBWnFkI8S8HNbWSkA9/LUVLWMKLG2sVe
         sUCdDK4KdA6iA==
Date:   Tue, 21 Feb 2023 10:45:29 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jan Kara <jack@suse.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patch in the mm-nonmm-stable tree
Message-ID: <20230221104529.631ac4c9@canb.auug.org.au>
In-Reply-To: <20230220151211.1cdec7528db28a00320a855f@linux-foundation.org>
References: <20230221090827.16d1bf96@canb.auug.org.au>
        <20230220151211.1cdec7528db28a00320a855f@linux-foundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/DPNSBE/vYqU9CtRprg8ITkd";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/DPNSBE/vYqU9CtRprg8ITkd
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Mon, 20 Feb 2023 15:12:11 -0800 Andrew Morton <akpm@linux-foundation.org=
> wrote:
>
> On Tue, 21 Feb 2023 09:08:27 +1100 Stephen Rothwell <sfr@canb.auug.org.au=
> wrote:
>=20
> > The following commit is also in Linus Torvalds' tree as a different com=
mit
> > (but the same patch):
> >=20
> >   bf470202dd9f ("fs: gracefully handle ->get_block not mapping bh in __=
mpage_writepage") =20
>=20
> CommitDate: Thu Feb 2 22:50:07 2023 -0800
>=20
> > This is commit
> >=20
> >   7010839ccfd4 ("fs: gracefully handle ->get_block not mapping bh in __=
mpage_writepage")
> >=20
> > in Linus' tree. =20
>=20
> CommitDate: Thu Jan 26 16:46:35 2023 +0100
>=20
>=20
> So I'm wondering why this came to light on Feb 20?

Sorry about that, but I wouldn't worry about it too much as it doesn't
seem to be causing a conflict.

The latter commit was in the ext3 tree before being merged by Linus and
I guess I missed it initially because sometimes the check for
duplicates in the mm tree produces a longish list when the mm tree is
updated during the day and the mm-hotfixes tree has already been merged
(and gets rebased as part of the mm tree rebase).

It would have been put in the list of things to ignore until it turned
up in Linus's tree today (which is an earlier and check and has a
separate ignore list).

I'll try to be more careful.
--=20
Cheers,
Stephen Rothwell

--Sig_/DPNSBE/vYqU9CtRprg8ITkd
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmP0BhkACgkQAVBC80lX
0GzK1Af9FgqpE1E+x94od5TT0VytuWop7jJBqQCANZLCM/1XMA7U6m1fTg/NFoyz
BcZuzcAclD3dl9J2iKmW3giH8GV7pnk+B+nRZjpl9KfDxWN0IGEVkAkcKo3mNGvU
SHDbgsDwSgNX5wTfcwc0KOV2M7+rcqPC9hx4CHx+D3+kCcZkXiRc9XzFGTnyk54X
ix/hHeGJMic4dekljFKD2iCNCpTGouOHTCcK1bZlgVa1klOWskSTOrDbrBlmA74K
t+I7mXYpAGOSoFmEA43pyJBVGbvETCIAQITS6CMUZYaR8nFoRtPM+9f/aM2wYZUX
RX66WdnI9pInFOqoj+4dna0DgyJvAA==
=5T5G
-----END PGP SIGNATURE-----

--Sig_/DPNSBE/vYqU9CtRprg8ITkd--
