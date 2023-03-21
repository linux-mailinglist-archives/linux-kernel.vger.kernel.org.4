Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E019B6C3EDB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 00:55:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbjCUXz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 19:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjCUXzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 19:55:25 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A350113C2;
        Tue, 21 Mar 2023 16:55:24 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Ph7lB6Bt9z4xDr;
        Wed, 22 Mar 2023 10:55:18 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1679442919;
        bh=mUZ3M2bpMU+bvypHCX8Kj2BpUXnJw5dxNVVsIajAHz8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RmhNl8yTQkIRAz7FFrmfI8nk/FiTkzq3fSe4PeU5vJNETI6Nubx7u/QW+KffiobZh
         4SyMi+l0v20SbkoZhFC5S69EWJzav4OVq+JppjQP2UvpR++TJXOi1wU0jFwGOue+CB
         hkDQwrsC5q7+uf0OvmQwlGLLbmb1psZcKo809D2v5DoMH2ol32H1oCIsNCgQGy6LUK
         rp/Fqblic8ATRSYeYSHICtJWkj+d8TVquI3LuItC4+2mQzZ+QjJqHlAhpyTf0iYz4v
         SVEZXioyPeXlSwoSY/3WOKG8OLjMyof+IEot3Uw638OA+hJudI3gR6Bd2iwyuXysWC
         NlS4GXPVlBXFA==
Date:   Wed, 22 Mar 2023 10:55:17 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Lee Jones <lee@kernel.org>
Cc:     Alice Chen <alice_chen@richtek.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the leds-lj tree
Message-ID: <20230322105517.06e4508a@canb.auug.org.au>
In-Reply-To: <20230320114816.2abe5751@canb.auug.org.au>
References: <20230320114816.2abe5751@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/xF/4jJx+3oj2OoeJyS.mcEl";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/xF/4jJx+3oj2OoeJyS.mcEl
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 20 Mar 2023 11:48:16 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> After merging the leds-lj tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
>=20
> drivers/leds/rgb/leds-mt6370-rgb.c: In function 'mt6370_check_vendor_info=
':
> drivers/leds/rgb/leds-mt6370-rgb.c:889:15: error: implicit declaration of=
 function 'FIELD_GET' [-Werror=3Dimplicit-function-declaration]
>   889 |         vid =3D FIELD_GET(MT6370_VENDOR_ID_MASK, devinfo);
>       |               ^~~~~~~~~
>=20
> Caused by commit
>=20
>   55a8a5c16eb3 ("leds: rgb: mt6370: Add MediaTek MT6370 current sink type=
 LED Indicator support")
>=20
> I have used the leds-lj tree from next-20230317 for today.

I am still getting this build failure.

--=20
Cheers,
Stephen Rothwell

--Sig_/xF/4jJx+3oj2OoeJyS.mcEl
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQaQ+UACgkQAVBC80lX
0Gzcywf6AquCNI4sWapHNlYKAUkcp9IrpLuppWouNTtaYMFQ8q4EvZ7WmMKjf+Um
m/5g+7LrkWmOcUbj/15TdPaWKT2gpk5Itte3vLs3MXXM3R9CZI1B4YJu9gKqRJCB
epcfP5KNjtGUUooWkCLCUYPlcwXyBaBVPnGlBgDO54lymjneE3ebfqU6boe9nfZ4
0ZwSk1OrVGgXn8YBTvbfhT91ChvHiUs7jpr01vD/A1fX7j53H23J6Me+xZwQt+Et
qM7+nFGa8fhoK+ZSF+Yosh5WtIAglNnRwYDTAYTL1kvs2ceyBEvYYpH3IRDtjudv
6hk/QcpsWjUEQMLmLX3VB+dunqfJIw==
=oEwC
-----END PGP SIGNATURE-----

--Sig_/xF/4jJx+3oj2OoeJyS.mcEl--
