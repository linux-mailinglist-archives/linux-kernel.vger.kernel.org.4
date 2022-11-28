Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 235A4639FB0
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 03:49:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbiK1CtL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 21:49:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbiK1Csz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 21:48:55 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C704B12082;
        Sun, 27 Nov 2022 18:48:01 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NL8yl5XG3z4wgv;
        Mon, 28 Nov 2022 13:47:42 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1669603664;
        bh=cygpdUJpbGd5CDPNELRdUlMkQYIt+vhJa3RkI+JJvcU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oNpmEdhL7wtVEEBZX4jjDlomIKkOfa7Lt+1vQjiibmL+zP0v3sSQXQgwVbOWhxGPT
         NaTY5X5z/NzZdSCZz4m6znVFub6ZXLFyihOxD6Wg91lrAb2saLDbaop+v5w17V7hm9
         fqVHZBusTtr+0riiAZwMIM1LDS3Y8ClvIlnVl6NOXK4+sA5LQB1Yx7wWNer4/nH7hr
         iQ+EOZJLxe9TMLXB2our53hCzUb1xT+EO1N7I2NhCjOHUTtuXACdzgctcli5qrJ5iR
         DR9Pe33VzypyWvi+pYeom8MJvqEX6zu2LOoL6w8hGYoaw3v/D+bKJFMeGjWavCw3GE
         xgt3F24r6pq8Q==
Date:   Mon, 28 Nov 2022 13:47:41 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Rob Herring <robherring2@gmail.com>, Greg KH <greg@kroah.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Rob Herring <robh@kernel.org>
Subject: Re: linux-next: manual merge of the iio tree with the devicetree
 tree
Message-ID: <20221128134741.668fe1b7@canb.auug.org.au>
In-Reply-To: <20221104124922.499bdece@canb.auug.org.au>
References: <20221104124922.499bdece@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/0HV0lmNPHeUV0Dliy9rLb9D";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/0HV0lmNPHeUV0Dliy9rLb9D
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Fri, 4 Nov 2022 12:49:22 +1100 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>=20
> Today's linux-next merge of the iio tree got a conflict in:
>=20
>   Documentation/devicetree/bindings/iio/addac/adi,ad74413r.yaml
>=20
> between commit:
>=20
>   c9adc3bd1180 ("dt-bindings: Remove "status" from schema examples, again=
")
>=20
> from the devicetree tree and commit:
>=20
>   a4728fe6b58b ("dt-bindings: iio: addac: adi,ad74413r: improve example")
>=20
> from the iio tree.
>=20
> I fixed it up (I just used the latter whic included the former change
> to this file) and can carry the fix as necessary. This is now fixed as
> far as linux-next is concerned, but any non trivial conflicts should be
> mentioned to your upstream maintainer when your tree is submitted for
> merging.  You may also want to consider cooperating with the maintainer
> of the conflicting tree to minimise any particularly complex conflicts.

This is now a conflict between the char-misc tree and the devicetree
tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/0HV0lmNPHeUV0Dliy9rLb9D
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmOEIU0ACgkQAVBC80lX
0GwzLAf/QsZL5lJ+gC33XHcH4CF+/NxmzSanJaYjPMkwpFlJQPn2j9K9Pou4eRTT
JiN5zyaNwDMSp576vBbDgGQcsnMt60EwqvmhLck3YEPHOXHgvweA8/3FqM50nA0E
SiFDYAokkLMLIBPgmZJywUQNXTtneuoYe/LF7POfwdIT511arwPQn7XExiR5cbx0
0em6/Z06LOzYQHw2VHDBoSqry1PAD3i7+QKwpk7zZP1MibK4Ga5vPe7EBNx8ly2b
4NJssB0g1FxtzX5RWwKO8YBchjhjAoGsFi8tywUjJnWAO2QoQHwqNbACnPdN+zIp
0mt6tXqiN4hWDczISguHhrE5xVM7+A==
=D9tB
-----END PGP SIGNATURE-----

--Sig_/0HV0lmNPHeUV0Dliy9rLb9D--
