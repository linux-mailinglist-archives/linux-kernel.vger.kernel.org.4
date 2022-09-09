Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DCED5B31AD
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 10:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbiIII01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 04:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbiIII0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 04:26:23 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 951861282E5;
        Fri,  9 Sep 2022 01:26:22 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MP8GP0B6qz4xPB;
        Fri,  9 Sep 2022 18:26:20 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1662711981;
        bh=bwrIORF/AtRjaLf9xPfPXgnz5crku/Tbu2ksFz07DUk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=P8TIbeV9zhCAichVK//+wgALZhYfhoCJAUMIVqjTlUH/ECgK4WpftP5X6uQCn3HnG
         p9y0z/HzqPaAEX0IJwlhgp7TgrUQRWzRjKewuhsKYaJXZZfOHtSYw4eubcSbslL0Vr
         agC8T+/bdj9ToZ9p5D0LsjhBk7MwdAcAA5I2ddGVLOnWJ0dsC/4VKGP6JkStbBsxhi
         3sAzEFB31UcSVbFLIUX90DR+vv3k0xXBAgAZN+kbxQufTmRBl2rpiXmUPGOvJ69LA+
         yfR2FD6DnhGZXWCIvrmOTiQp8lUCFzzPTwqqkXagatjggJ2IeippYlsLa9j1XC+y4y
         7vXq24gnok33A==
Date:   Fri, 9 Sep 2022 18:26:19 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the kbuild tree
Message-ID: <20220909182619.4e66cb5c@canb.auug.org.au>
In-Reply-To: <CAK7LNATR0-Y_yHTcD62J4N36T-_4G=-N1me8EWYNTNYbwXerDw@mail.gmail.com>
References: <20220909090024.47458048@canb.auug.org.au>
        <CAK7LNARPX2Ov-nLAT6mPWbgqQMDCuoW84VN_C2sS1CJkR_n8YQ@mail.gmail.com>
        <20220909152453.5400cf7e@canb.auug.org.au>
        <20220909161354.2c94a495@canb.auug.org.au>
        <CAK7LNATR0-Y_yHTcD62J4N36T-_4G=-N1me8EWYNTNYbwXerDw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/bSUUPCxNGxaSRkN.HfOHQDM";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/bSUUPCxNGxaSRkN.HfOHQDM
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, 9 Sep 2022 15:48:55 +0900 Masahiro Yamada <masahiroy@kernel.org> wr=
ote:
>
> > $ make ARCH=3Dx86_64 CROSS_COMPILE=3Dx86_64-linux-gnu- O=3D../obj -j15 =
-O
> > make[1]: Entering directory '/home/sfr/kernels/obj'
> >   GEN     Makefile
> > make[1]: Leaving directory '/home/sfr/kernels/obj'
> > make[1]: Entering directory '/home/sfr/kernels/obj'
> >   UPD     include/generated/compile.h
> > make[1]: Leaving directory '/home/sfr/kernels/obj' =20
>=20
>=20
> Weird 'Entering/Leaving directory' logs.

That is because I pass -O to make.

Without -O, I get:

$ make ARCH=3Dx86_64 CROSS_COMPILE=3Dx86_64-linux-gnu- O=3D../obj -j15
make[1]: Entering directory '/home/sfr/kernels/obj'
  GEN     Makefile
  DESCEND objtool
make[2]: *** No rule to make target 'objtool/objtool'.  Stop.
make[1]: *** [/home/sfr/kernels/test/Makefile:1351: tools/objtool/objtool] =
Error 2
make[1]: *** Waiting for unfinished jobs....
make[1]: Leaving directory '/home/sfr/kernels/obj'
make: *** [Makefile:222: __sub-make] Error 2

--=20
Cheers,
Stephen Rothwell

--Sig_/bSUUPCxNGxaSRkN.HfOHQDM
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmMa+KsACgkQAVBC80lX
0GyyBQf/eLkBIl5Z5SRSqcM3RTbXjyqxuFjR2bXSOSTa15XPO3zmOZg8e4/VsPin
v8SpEqEQ4T/t6FKhtGpSwFjOu9VR84ERXBvGaVicYcDslXPnnP29yVldgQsNtRag
hvTL+yp1XFaKTVi3aNWA6nhV5fZEK5ZuQ3xcNa1hbNqH7TyYyMciFA68Pcb6qdkN
GQih13yTr8H6EEFidLWKcYGVhNwIgOvaLZzaVrZeU26Ixex6ql5fVqfylYNMngnD
PgoqLPCQy+KaBioSgWEC2e+VpehR2yE50a3GjkBmOHa8yRwZV6FYmAzXed3Chur0
vgDlHSbdTEHHGpBDyfI7zCHf6A7T8g==
=Qc9m
-----END PGP SIGNATURE-----

--Sig_/bSUUPCxNGxaSRkN.HfOHQDM--
