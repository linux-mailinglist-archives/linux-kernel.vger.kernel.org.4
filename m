Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36CD25F8A50
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 11:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbiJIJPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 05:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbiJIJPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 05:15:13 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C577222B2;
        Sun,  9 Oct 2022 02:15:11 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Mlbws4G2Tz4x1F;
        Sun,  9 Oct 2022 20:15:09 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1665306910;
        bh=PhMDw4subVzNzu3fEQcQZAcv/PUsdzeKoLJP70WWR6k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ICMLpKEJZRlk2cDptvTL8On4FAk7NmEkjHyGAJJgnO65rtfsiLwgrsSroD6llR7vu
         Jca1zhGwp+2d9D1Fa0BNMdJ9I7dkwyNzYcQXZyjb4wnoJ1mZAtjke3BHvx2CWPoNEl
         ZP+WYwflRqS0oggqKEmUR2neFQENaJmTVxit27GHjNFv9oKxqQ4mPf8+K7RC8qXB5c
         EJ57sTNe/LlLeoLwtr/hkNuT2+DNVFao/dxc2arzM+jLeIMs/OoY0qJQ+3D3dkr4PB
         tEPR5F5e+QVY0Ga56Cx2ZTdUjcX20EkgNzeiLz02Od4HWp3j5Wjtmj+g2FlVCfAP90
         /qBO4MadOKFfg==
Date:   Sun, 9 Oct 2022 20:15:04 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the mm-stable tree
Message-ID: <20221009201504.43d8c325@canb.auug.org.au>
In-Reply-To: <20221009193544.27055db5@canb.auug.org.au>
References: <20221009193544.27055db5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/LF9QSBH317wmy6MSF2itQE_";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/LF9QSBH317wmy6MSF2itQE_
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Sun, 9 Oct 2022 19:35:44 +1100 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>=20
> In commit
>=20
>   bbff39cc6cbc ("hugetlb: allocate vma lock for all sharable vmas")
>=20
> Fixes tag
>=20
>   Fixes: "hugetlb: clean up code checking for fault/truncation races"
>=20
> has these problem(s):
>=20
>   - No SHA1 recognised
>=20
> Maybe you meant
>=20
> Fixes: fa27759af4a6 ("hugetlb: clean up code checking for fault/truncatio=
n races")

Sorry, I accidentally sent this twice.

--=20
Cheers,
Stephen Rothwell

--Sig_/LF9QSBH317wmy6MSF2itQE_
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmNCkRgACgkQAVBC80lX
0Gy8Ewf+NX7Zfhmisuw4HtOWV4PT+52I+JWxspX3+iR+KdW/bq5DTWHzibqZ5TOx
kHevCShbfWkddTewo7mJs18DCaMnvY9He0Ng88cU7nlV1T7K0RuCukxrSl/KDWjC
doSz0oKxlL6a7MpPo6ZHupheySqflxY/Rb8LO3IAiAv1Eqja3IReX3+gBv17aA1e
GqMCtSqxaTNO3fc7OnT+G5tts/s7YfQ7k7EoNcANunsmT2SekaFuBuZ/raO0hK1j
M0ON+2eofAeTDjxbBmwVDZW5YOxcwSXdfY0NaGEW2VNIaolkjdQJjrZBvVEOJVOU
QA/LF7ZV1SapFmEex01Vkx5bas2CWA==
=oOaq
-----END PGP SIGNATURE-----

--Sig_/LF9QSBH317wmy6MSF2itQE_--
