Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18FCF64C0F8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 00:58:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234027AbiLMX6n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 18:58:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236598AbiLMX6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 18:58:41 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4219622281;
        Tue, 13 Dec 2022 15:58:38 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NWwS84z60z4xMy;
        Wed, 14 Dec 2022 10:58:32 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1670975913;
        bh=bZ4RGyeJh2RXyjyUYY1LvU8RneVn5tnBRWeGuh+hOKI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pZAj3xJh96hLjNNhYK1lrRyrmLhh2LzRyWCP8SOHLnNJ8Vgw8ECXX/zivIVIaR6ae
         1xo2ZXiRjcVp+NN7PdDjq3lrQma6qxzgc13cs5NCulLw9hoYYwCYsKdPjVnl35lZxL
         lCy9jtdcbZ2FQE+37AOJ4yrGrCQ3Q1f4dKO2Bv7GDK3uHb9Oib4xIZ25cvOrHEwgGD
         nlvtQYAe05T7DTIDiRh5VIWZHfklkxJ34+geSCR51/kOoKiarWxwpMkc+I8EbJsjjm
         1zw0824YK6/TzZedlnOIPyGmQ65g95Q3UexefcVswpTkhEvJAaL5+m6aEmRat5WblU
         0O2UkH4JytwZw==
Date:   Wed, 14 Dec 2022 10:58:30 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     John Johansen <john.johansen@canonical.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Rae Moar <rmoar@google.com>
Subject: Re: linux-next: manual merge of the kunit-next tree with the
 apparmor tree
Message-ID: <20221214105830.3bde0179@canb.auug.org.au>
In-Reply-To: <20221208124653.71ba9491@canb.auug.org.au>
References: <20221208124653.71ba9491@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/+O0ZxHU/rk0+ec2g2d+N/6m";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/+O0ZxHU/rk0+ec2g2d+N/6m
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Thu, 8 Dec 2022 12:46:53 +1100 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> Today's linux-next merge of the kunit-next tree got a conflict in:
>=20
>   security/apparmor/policy_unpack_test.c
>=20
> between commits:
>=20
>   371e50a0b19f ("apparmor: make unpack_array return a trianary value")
>   32490541682b ("apparmor: Fix kunit test for out of bounds array")
>=20
> from the apparmor tree and commit:
>=20
>   2c92044683f5 ("apparmor: test: make static symbols visible during kunit=
 testing")
>=20
> from the kunit-next tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>=20
> --=20
> Cheers,
> Stephen Rothwell
>=20
> diff --cc security/apparmor/policy_unpack_test.c
> index 7465da42492d,f25cf2a023d5..000000000000
> --- a/security/apparmor/policy_unpack_test.c
> +++ b/security/apparmor/policy_unpack_test.c
> @@@ -144,8 -147,8 +147,8 @@@ static void policy_unpack_test_unpack_a
>  =20
>   	puf->e->pos +=3D TEST_ARRAY_BUF_OFFSET;
>  =20
> - 	KUNIT_EXPECT_EQ(test, unpack_array(puf->e, NULL, &array_size),
>  -	array_size =3D aa_unpack_array(puf->e, NULL);
>  -
> ++	KUNIT_EXPECT_EQ(test, aa_unpack_array(puf->e, NULL, &array_size),
>  +			TRI_TRUE);
>   	KUNIT_EXPECT_EQ(test, array_size, (u16)TEST_ARRAY_SIZE);
>   	KUNIT_EXPECT_PTR_EQ(test, puf->e->pos,
>   		puf->e->start + TEST_ARRAY_BUF_OFFSET + sizeof(u16) + 1);
> @@@ -159,8 -162,8 +162,8 @@@ static void policy_unpack_test_unpack_a
>  =20
>   	puf->e->pos +=3D TEST_NAMED_ARRAY_BUF_OFFSET;
>  =20
> - 	KUNIT_EXPECT_EQ(test, unpack_array(puf->e, name, &array_size),
>  -	array_size =3D aa_unpack_array(puf->e, name);
>  -
> ++	KUNIT_EXPECT_EQ(test, aa_unpack_array(puf->e, name, &array_size),
>  +			TRI_TRUE);
>   	KUNIT_EXPECT_EQ(test, array_size, (u16)TEST_ARRAY_SIZE);
>   	KUNIT_EXPECT_PTR_EQ(test, puf->e->pos,
>   		puf->e->start + TEST_ARRAY_BUF_OFFSET + sizeof(u16) + 1);
> @@@ -175,8 -178,9 +178,8 @@@ static void policy_unpack_test_unpack_a
>   	puf->e->pos +=3D TEST_NAMED_ARRAY_BUF_OFFSET;
>   	puf->e->end =3D puf->e->start + TEST_ARRAY_BUF_OFFSET + sizeof(u16);
>  =20
> - 	KUNIT_EXPECT_EQ(test, unpack_array(puf->e, name, &array_size),
>  -	array_size =3D aa_unpack_array(puf->e, name);
>  -
>  -	KUNIT_EXPECT_EQ(test, array_size, 0);
> ++	KUNIT_EXPECT_EQ(test, aa_unpack_array(puf->e, name, &array_size),
>  +			TRI_FALSE);
>   	KUNIT_EXPECT_PTR_EQ(test, puf->e->pos,
>   		puf->e->start + TEST_NAMED_ARRAY_BUF_OFFSET);
>   }

This is now a conflict between the apparmor tree and Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/+O0ZxHU/rk0+ec2g2d+N/6m
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmOZEaYACgkQAVBC80lX
0Gx/ewf/cLWHgqmcA4c51sliHeP5JvxIYLWcLY2ZlKhvYnfQykGyxueyI3/gc7k8
Ez/9TGq+/R86jodzaGTCQYrXEWe7IpmkV7UuCDCAQVne8O6XWUNG+o6dJaop9Teu
E+XYT+C9mXgI17wV2YJAHdqcAq7fG6979e6wvFDAYLpl8ZA6e0+WUpr5LcCp3FFr
vEpba2ulXSaxGsawUnIDghDEAWCT3zK0F71PzRpks2B7OaoF0r5yod2QI9I8zdHt
9/Ucm0yMRdu8zIACz54z/omVsN9IuMJDsW92MqnD4P6eDHtQRB/Mj+tInoJXQpqD
7QEEcL3ImePrpJVbNNSo8x693NGAXA==
=/nMs
-----END PGP SIGNATURE-----

--Sig_/+O0ZxHU/rk0+ec2g2d+N/6m--
