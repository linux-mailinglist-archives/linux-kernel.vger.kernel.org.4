Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26C1F69536D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 22:55:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbjBMVzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 16:55:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjBMVy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 16:54:58 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B5DD1554D;
        Mon, 13 Feb 2023 13:54:55 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PFyms1GCPz4x1f;
        Tue, 14 Feb 2023 08:54:53 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1676325293;
        bh=uXTqYMcYh7Xi4vbU4tCul8N3yIIbso/hVsy17YGm2B8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=m2BMWa4qu2GUtJ2icEZtRBJ0LDeyJOsXUtBtKMAuQ7PfW2NZ+UpFdeZyh7IwVEy86
         gGytOK0qhVxRJenyRhCEGRyhFvnxs97W70x8DQV4orrQqz1PQyLG8pPShtWrGdcCdj
         DWHOJ/JU2DWFHpI8ODdgQjNGQgSDfOyh7hU7HXuPzfukqh3I9YqqGcb7U3bU0QTYTp
         5bV2gZgD5tAfsTS9h7u5VrDHe2X3IktDSpDOCFi/yJkbNJSfECxF30138PwVPix4rJ
         c2WN8sMgDpamjxWecJBCup8GuPX1dnXlBJ66OgRduGA8ffauLpWQ+EBm952Njru/2e
         F/u4YXB4Xs8Yw==
Date:   Tue, 14 Feb 2023 08:54:52 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Chunwei Chen <david.chen@nutanix.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patch in the mm-hotfixes tree
Message-ID: <20230214085452.03575f8b@canb.auug.org.au>
In-Reply-To: <20230213080052.296dddb0@canb.auug.org.au>
References: <20230213080052.296dddb0@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/XTRjSveIQRa7LxDb/.wgZ1J";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/XTRjSveIQRa7LxDb/.wgZ1J
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 13 Feb 2023 08:00:52 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> The following commit is also in Linus Torvalds' tree as a different commit
> (but the same patch):
>=20
>   c2d6ac6f92ac ("mm/page_alloc.c: fix page corruption caused by racy chec=
k in __free_pages")

This is now commit 1a520a4425b0.

> This is commit
>=20
>   462a8e08e0e6 ("Fix page corruption caused by racy check in __free_pages=
")
>=20
> in Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/XTRjSveIQRa7LxDb/.wgZ1J
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPqsawACgkQAVBC80lX
0GxtqAf/T1qp0Q0EVQANAWdqsxTp+XtX0D8MhzB5qRb7JnUpMJsaFqVwdwEsSWEy
c7fEgNZnH/hVWcrbmjUqUGBJLWAMUEu0YmtdZckYmquE35HrkwcdPJwaIpGTUAZ2
keYUBKErP7SJvWJQ/CQIULj8GWk3Gev4jSpG70RUOBim7+o0hoL1xPL6T7PW5FHF
lpXyw0aSKGUMYzaifazcXVpuUSaVgpQIQystl1eLrZIPII41PYbBL4u4gzcenRZI
9JY1v4zWUHCgnu+b1ZHsiu5t8BAdDNSFPinMD9/DNZjWqBR9ZI4IPDm0gKxjfMKf
Q+sj+HcH89expdOGyrQEiQT6a8QKAQ==
=/nJU
-----END PGP SIGNATURE-----

--Sig_/XTRjSveIQRa7LxDb/.wgZ1J--
