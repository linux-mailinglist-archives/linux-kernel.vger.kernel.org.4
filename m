Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B90D69D64C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 23:28:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232692AbjBTW2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 17:28:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231993AbjBTW2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 17:28:10 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A0939004;
        Mon, 20 Feb 2023 14:28:08 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PLH9r6Yynz4x7j;
        Tue, 21 Feb 2023 09:28:00 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1676932083;
        bh=LfM79R5l6Up6AYvdPXoq8V/IPITK46aLrtumWLcu5xo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZadCDyJBRSkhe4vj51ltILbtDCgnFxb7OuBQ4AbHMAgKp5P/smz9wvID4I2NbfHqu
         f7sat1KBaFUqw8CThLWZ+TIeK93OyZWBAnkCGEljqQMw6FLDWV9ZRe6lWQV/hcL3Qu
         1aHXBcUNCeBmWikOhxMRbwNTov0r9J6APBkAPpW957g1qHL9hDq7hNw31OZGMN1IZo
         IvKnJ8xX7u+9rO0HExmaX2RgtFuVHdsJcri6IbmYmGONprBZ+KrvGEYaeKf/2aacjS
         qJCXJlenw4mrtZ0oiqfBYfP7wyOmAC2S71dgxHpNYowbFbL2qvnn2CR6fE4OWaKwlu
         itJznWQrgWpdQ==
Date:   Tue, 21 Feb 2023 09:27:59 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Takashi Iwai <tiwai@suse.de>, Olof Johansson <olof@lixom.net>,
        Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     ARM <linux-arm-kernel@lists.infradead.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>
Subject: Re: linux-next: manual merge of the sound tree with the arm-soc
 tree
Message-ID: <20230221092759.34d35668@canb.auug.org.au>
In-Reply-To: <20230217112327.5697baab@canb.auug.org.au>
References: <20230217112327.5697baab@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/G9GqYEWgnLxW54HK481dSCq";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/G9GqYEWgnLxW54HK481dSCq
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Fri, 17 Feb 2023 11:23:27 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Today's linux-next merge of the sound tree got conflicts in:
>=20
>   sound/soc/cirrus/ep93xx-ac97.c
>   sound/soc/pxa/e740_wm9705.c
>   sound/soc/pxa/e750_wm9705.c
>   sound/soc/pxa/e800_wm9712.c
>   sound/soc/ti/davinci-vcif.c
>=20
> between commits:
>=20
>   2b45e1fa9398 ("ASoC: remove unused ep93xx files")
>   efe81e9a9273 ("ASoC: remove unused davinci support")
>   b401d1fd8053 ("ASoC: pxa: remove unused board support")
>=20
> from the arm-soc tree and commits:
>=20
>   f2211ac36ab0 ("ASoC: pxa: e740_wm9705: Drop empty platform remove funct=
ion")
>   4ed923e8076b ("ASoC: pxa: e750_wm9705: Drop empty platform remove funct=
ion")
>   394296eee2c2 ("ASoC: pxa: e800_wm9712: Drop empty platform remove funct=
ion")
>   0e478b88b257 ("ASoC: cirrus: use helper function")
>   2abde57fb82b ("ASoC: ti: use helper function")
>=20
> from the sound tree.
>=20
> I fixed it up (I just removed the files) and can carry the fix as
> necessary. This is now fixed as far as linux-next is concerned, but any
> non trivial conflicts should be mentioned to your upstream maintainer
> when your tree is submitted for merging.  You may also want to consider
> cooperating with the maintainer of the conflicting tree to minimise any
> particularly complex conflicts.

This is now a conflict between the arm-soc tree and the
sound-asoc-fixes tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/G9GqYEWgnLxW54HK481dSCq
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPz8+8ACgkQAVBC80lX
0GyjIAf/T0nLVRIxIikfyv33h0hCxcePNyv2Ub1Ja2xKbpbBUNjBozPWTdDgpBKS
dMz6RLbtBeVMMY5lm3fUmobrWx2DIbJZFulCwyuqJRao/TwNrUtuWQTmGNlwysHN
WMji6trgtl9Pocm/uddEHBZshKDMG7dmgvk0jVZaqFeC00+WVIQaFhpQ52DbeG6o
WrHScnTBrL6mxLp08aFUDa0ZKRoXS6px0UPvt019yGeBy+5uJVXQFKd5eQzKbuyU
l1chDpZFWoVIWEN5CAltXmuF1Z6oX91yQB4zSiamu+b3FIdk9qwtjdp6SIOLuOVV
NOzqDAcaD0L1ZVr9/xoJfr79CS2SeQ==
=4vHZ
-----END PGP SIGNATURE-----

--Sig_/G9GqYEWgnLxW54HK481dSCq--
