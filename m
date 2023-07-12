Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46EA674FE70
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 06:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231615AbjGLEo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 00:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231532AbjGLEoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 00:44:54 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 896F21FD3;
        Tue, 11 Jul 2023 21:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1689137067;
        bh=rw3WWcnTMJo4BKbXZh62ceygOHfFFWww9ewGAjhUXtM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cNjMVZeXSJrM7SSL3fxpbp4VT/zwphjx79pdGg6pGeHRLt0zrKOeW9cTcjmxMjgui
         HPE0UQVzvWOXDybIg6a4FD9KfAVD+DWC90XjlQZmJQUJ4YYUXhMFvaKjiW4QD7qy1s
         fD9BH22CjmTKvnrgODSG7jcZYcbmzR9909utAAYzxD1v0BoUw9TDw4hcnGjwP7ixl1
         kPGqhIud8cvvrsWjsMwjOwFNYQ2wIPbMN0xHQ1YqrT/5Rl5NTaBYqkqQAaQSacT9WN
         I0xIBfUl0/WPnH3Eu7bpRoClEdY/r5p9zTZHlIIe8i6EPUwekYZEYnqSsZmjR4wpCg
         wRSMV76XKrI0A==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4R14s70rbwz4wZt;
        Wed, 12 Jul 2023 14:44:26 +1000 (AEST)
Date:   Wed, 12 Jul 2023 14:44:24 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: linux-next: branches to be removed
Message-ID: <20230712144424.57ab0009@canb.auug.org.au>
In-Reply-To: <40fad90a-551e-e66b-f225-8add53b417e0@ti.com>
References: <20230710172602.05d32c03@canb.auug.org.au>
        <40fad90a-551e-e66b-f225-8add53b417e0@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/gMSS5uw9Z1PpviGF3kRMf0M";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/gMSS5uw9Z1PpviGF3kRMf0M
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Vignesh,

On Wed, 12 Jul 2023 09:28:41 +0530 Vignesh Raghavendra <vigneshr@ti.com> wr=
ote:
>
> + Miquel
>=20
> On 10/07/23 12:56, Stephen Rothwell wrote:
> >=20
> > I will remove the following branches from linux-next tomorrow as they h=
ave
> > not been updated in over a year.  If you want your branch retained or
> > reinstated, please just send me an email letting me know.
> >  =20
>=20
> [...]
>=20
> >   git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git     cfi/n=
ext =20
>=20
> [...]
>=20
> > These branches are all empty except the last which just contains a
> > commit that is the same patch of a commit in Linus' tree.
> >  =20
>=20
> Development on CFI + Hyperbus has slowed down a bit, apart from odd
> fixes every now and then which I have been asking Miquel to directly
> apply to mtd/fixes. I do expect odd patches/improvements over next few
> months, would it be possible to keep this tree included in linux-next if
> its not too much of a burden?

Done starting tomorrow.

--=20
Cheers,
Stephen Rothwell

--Sig_/gMSS5uw9Z1PpviGF3kRMf0M
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSuL6gACgkQAVBC80lX
0GwO8Qf/Vw6j0sUOpsWe6G5VJecfO9/jQq9Znhmk5d5kKRJKR6zq7Tx9lyLY4f/1
zXJZSBUA5CYbDw24kTlTriiXzhbL5ayAFmitmYz/OA8kC9cE+qOxvXOnvpxl2w29
3m6kXanvhWPFx8N3+avw8/uBf6FG3ET9gkMPF/rfhQC9D30i5iQJ0A/f+tpwUN3m
szDJgruUKvOgBo9BZtwoQdDG8Rv7FY55EDt+NeqZiad0YpZd4C6b8w+SgIcHHz8d
R3FIS+5dcuGnL5wGKZPcq/oPg9pPJi+mfEX9eRUi3cAwYr++sll3PAnYXKJMisSR
/IHL4nU/+uI6JK1T4QeIsdp/A3XA7g==
=m8Wk
-----END PGP SIGNATURE-----

--Sig_/gMSS5uw9Z1PpviGF3kRMf0M--
