Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF7345FF941
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 10:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiJOI52 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Oct 2022 04:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiJOI50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Oct 2022 04:57:26 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7C9D54CBC;
        Sat, 15 Oct 2022 01:57:24 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MqHFW1DWGz4x1G;
        Sat, 15 Oct 2022 19:57:19 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1665824239;
        bh=Z+Cm4OSKTMYcx+jbO9yJV4HYENOCOJSA99IDlVEkr3k=;
        h=Date:From:To:Cc:Subject:From;
        b=CpcIcoPVkc5gJlhOvcA8psu9YHgWLeBsocU3WF4hCXFOLIMJxG3Ls/WlPF6TSXdNt
         Nevk3O8Z/aHiz51uECDf1MyxOsC2gNQRQrLNsEag/bbJO6lMvJTPIahe8GvD41okCt
         Q+Ppvlest//ZWN7CX4qmpMc24379wI2zwUTgNw/txhKlYtcrxQDuSlgOsVS/IUlVRI
         NlYaqMksEvjNrc22UmCx1J7ZoIW8u0KVOtHhxAv1I3rQCRzldmUqVrUkDD3xHrfxI+
         5Wk340putvBiesifc7RXNw/HTsliGx0Mczt1fdVPmWMqOjGtvYvbNyXEeV3xkPkrdO
         A0Trq2F0V0AYw==
Date:   Sat, 15 Oct 2022 19:57:01 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Steve French <smfrench@gmail.com>
Cc:     CIFS <linux-cifs@vger.kernel.org>, Paulo Alcantara <pc@cjr.nz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the cifs tree
Message-ID: <20221015195701.4bdbe46d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/AbU8qbtj53YY0x13ricTMH_";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/AbU8qbtj53YY0x13ricTMH_
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  ddf95e7d5a81 ("cifs: fix double-fault crash during ntlmssp")

Fixes tag

  Fixes: d867d4ae29c7 ("cifs: replace kfree() with kfree_sensitive() for se=
nsitive data")

has these problem(s):

  - Target SHA1 does not exist

Maybe you meant

Fixes: a4e430c8c8ba ("cifs: replace kfree() with kfree_sensitive() for sens=
itive data")

--=20
Cheers,
Stephen Rothwell

--Sig_/AbU8qbtj53YY0x13ricTMH_
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmNKdd0ACgkQAVBC80lX
0Gx68wf9GPZQDvnEjIdMbxf0UEtmVRc/l/D1p0q8LVYuDDTi1i980Puu9QOZbl77
rk0tWYffClO9JivcUbaEBDE0B9Gy6caAn4Ta1MJ2NkJG504L+OdHdJ0X0z1qgmuG
132Ce2bzGTRJYqL7b4W88qVRTliV7MdksT7eMaXYK1zRFbnZCTbFIEzKVQgDsiHZ
OO2lJYH7TyJADEWOYBnKVXRf00dfCrXB3hWyDyNhua7xy8wxBvNyqLHkysZRozOl
FzC7kTig1xSqUvY7RbNtFomQodrLCgbgg6YZXx9bENHcXHrxRHr1FcWDGVUPgdfm
jY1U1ntWJd0jltgSnyWf9VqyrtROsg==
=Pwnm
-----END PGP SIGNATURE-----

--Sig_/AbU8qbtj53YY0x13ricTMH_--
