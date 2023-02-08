Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD34268F962
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 22:02:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232103AbjBHVCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 16:02:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231980AbjBHVCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 16:02:25 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 285EB421D;
        Wed,  8 Feb 2023 13:01:48 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PBspX5Nbhz4wgv;
        Thu,  9 Feb 2023 08:00:36 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1675890037;
        bh=EFRAZSbSC8jtmC11DWaRGRZsgWkqZAgkJ/0A8RaQgXA=;
        h=Date:From:To:Cc:Subject:From;
        b=RqxdxAMcIbxz3y94mijgQxOYZpy2pxhe2oypK4KvZI/OV1ZW6Jg1p8PNShZi9Vltw
         oaz+GwConbr/t37IUoeognFmHA2dhanPP+FMh7QFEHl77vpCqJAm4g+5j+kPw5CDRJ
         P1FJauA+Rwa2XdInkyxPydkqH8dG5RDsTs8dPY4KW3RjaBzAgCl2mafn9COlk/m5p0
         4Oe5GGfSPVpP9xvxY5WRTxXWhpB6iWIT7qkA1vFyu13NHZHcZRHRez1YVebMbeFzZr
         5wmXraaULGCBNU4s87opoE+V7fl/NxkdbiM/UYL7x0HZ3y8izMdGxV0e5eGSMhdUTa
         FWhO/7FN4FNPw==
Date:   Thu, 9 Feb 2023 08:00:35 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the v4l-dvb-next tree
Message-ID: <20230209080035.096345d3@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/2UnC6ZsPh2spF1WqFlC3HWv";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/2UnC6ZsPh2spF1WqFlC3HWv
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in Linus Torvalds' tree as a different commit
(but the same patch):

  5fcc87c68e69 ("media: v4l2-ctrls-api.c: move ctrl->is_new =3D 1 to the co=
rrect line")

This is commit

  a1550700629f ("media: v4l2-ctrls-api.c: move ctrl->is_new =3D 1 to the co=
rrect line")

in Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/2UnC6ZsPh2spF1WqFlC3HWv
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPkDXQACgkQAVBC80lX
0GxQBgf/UgxP8UQqWWXk+w8/I5t2pC9pULaRS/6lh9zR2A5xsZpRps1pRjsCePYp
2BEdszBTZXu907JM3I/NM4u0qr5y/dEhSORsabtbe3l3P+1FAt3gyX7WAcgCEYcQ
Kr3RPAJ/E1uB9zUS0RfWqTa5/cGvKtLXjzL1opDSbu5kkSDCKJTwLh9y/uic+T5L
HdCaJegjQrrr/AMlVlbSPjRVdyqdeuifLMjFOk0UIz+7WutyLr6gVgshs5emPele
Nq2V5yUf2pmDyguDx8UlZHYjlryR0uGqoUlcXLyte4GVrV/ydUwdCG2Z7GBlEofs
hPkpxU6W8a+V/G6Wfwi/nmV0L75VPA==
=lBtV
-----END PGP SIGNATURE-----

--Sig_/2UnC6ZsPh2spF1WqFlC3HWv--
