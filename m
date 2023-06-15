Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9850731004
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 09:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244307AbjFOHAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 03:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244203AbjFOHAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 03:00:47 -0400
X-Greylist: delayed 599 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 15 Jun 2023 00:00:45 PDT
Received: from pokefinder.org (pokefinder.org [135.181.139.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1BAC818D;
        Thu, 15 Jun 2023 00:00:45 -0700 (PDT)
Received: from localhost (120-123-142-46.pool.kielnet.net [46.142.123.120])
        by pokefinder.org (Postfix) with ESMTPSA id 92B2BA407D9;
        Thu, 15 Jun 2023 08:42:26 +0200 (CEST)
Date:   Thu, 15 Jun 2023 08:42:26 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Greg KH <greg@kroah.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patch in the usb tree
Message-ID: <ZIqy0mLPipq2p/N8@ninjato>
Mail-Followup-To: Wolfram Sang <wsa@the-dreams.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>, Greg KH <greg@kroah.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20230615151958.46746fe8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="XAanWRaf47t3F/aG"
Content-Disposition: inline
In-Reply-To: <20230615151958.46746fe8@canb.auug.org.au>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XAanWRaf47t3F/aG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

> The following commit is also in the i2c tree as a different commit
> (but the same patch):

thank you for the pointer!

>=20
>   7b7efc925042 ("usb: typec: ucsi: Mark dGPUs as DEVICE scope")
>=20
> This is commit
>=20
>   a7fbfd44c020 ("usb: typec: ucsi: Mark dGPUs as DEVICE scope")
>=20
> in the ic2 tree.

Oh, sorry, I didn't get a mail that it was already applied to the
usb-tree. Maybe I accidently erased it. What is the procedure now? I
guess I revert the version in the i2c tree?

All the best,

   Wolfram


--XAanWRaf47t3F/aG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmSKstEACgkQFA3kzBSg
KbZaBg/+IXkvqVhVAQJ/koIVjSg8MI/sPly7KInY++YwLdA+gDvyqTR0h6zza2YN
bQWtiVCLxH5gEcA6UmIZ0qPvrf/oDs66rDlSJUzDXCaaCoj8BUOSZ0o0J/COX8yq
icEnyxW6Xr2K3/oFgPuyblaklCtkQMwOLi8XwNCCniV4zj2i2fTx5cCjST1Zqmgz
XoRzeLQZdxpIliGqoDf60ZccKe69IxAbcxN7+JnTtSP5gwkFuc95EgwgChGd3fWi
hA5uNgIYHxr1vNaUyxFT15LUBm9k+R805rX3amC9ekJKekplYJMTY9CrwXqQGTCV
OKyIx3u3FdqpmfB1NTx3ZtxM8tj0YAhB19KMjaa1KjF/u6T6jZ8tKXVAni6foWU7
1oDt0ZJrYfUb0Yy3lhrzZPbDz6oTb+KfhT/3Gtjyf6dkO45WARKLfQJLWSf9qE8C
0b6WJ/8l0tbCLSy1cT1aKoWYAo4e0n2Lvsv6Or117gCHxdzmkxpAWRX4Mg4skpxN
kt/6nEziJf+/zEim1FCQchQM2/JpT4c0gAF3IUPCSwN4gR/3crN8xOT6nRJVtkL+
Zczu1ov3x7ifrvDpWyymHIFinpvqHpb9PgPgBsZA7ClYr8LcQKvzF2P11zXaqVcq
Yn5Jjq/9ub6NqFmLDXDLYXZp8Sg23aVQNXdliNS2oTfyHEBrt1w=
=MfZ1
-----END PGP SIGNATURE-----

--XAanWRaf47t3F/aG--
