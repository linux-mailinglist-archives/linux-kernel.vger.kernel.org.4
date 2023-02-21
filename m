Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9426A69E9EA
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 23:12:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbjBUWM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 17:12:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjBUWM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 17:12:56 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD2F82D7E;
        Tue, 21 Feb 2023 14:12:54 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PLtnw0j7Sz4x7W;
        Wed, 22 Feb 2023 09:12:51 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1677017573;
        bh=JXKm606UeGmSE5OVHyTnS2WW48UKfGLPxaZoyV8nk9k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=n0BGuvJVSmubEn5DZUiRaEc9Rhgry8OELr39e/tffA0887vS+SWz4UOg01q9c1Ueh
         AwKnw0dP3jTv3t0FkqeCijGDwcYTp9yFS0Me15PpW5MSS20UuW1L/t1VyPICNkhI8N
         NQpYcuKjk/euYQNmjudl+Hq5Id/yh5Z8jxMMvZ5OCYCPCs5b2X9hF+a4zamXy+Q+vb
         yyHrJ9DmaMXwrxftSrnfVy/147uXWpavbnD0aKy/sA9R6jNEk8NQYGMXyBTkt52itR
         JbgXDXmxP5QI+zYZ3LIo4xMbvvSAJe1VtP9KXEQUwhU2rozOvnqhhpMgz1kQaGsS7i
         SLAqUDXlECEXg==
Date:   Wed, 22 Feb 2023 09:12:50 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>
Subject: Re: linux-next: manual merge of the sound tree with the arm-soc
 tree
Message-ID: <20230222091250.2593add3@canb.auug.org.au>
In-Reply-To: <20230221092759.34d35668@canb.auug.org.au>
References: <20230217112327.5697baab@canb.auug.org.au>
        <20230221092759.34d35668@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Vpo8bNqhSAAtL_b8iZyYPKY";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Vpo8bNqhSAAtL_b8iZyYPKY
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 21 Feb 2023 09:27:59 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>=20
> On Fri, 17 Feb 2023 11:23:27 +1100 Stephen Rothwell <sfr@canb.auug.org.au=
> wrote:
> >
> > Today's linux-next merge of the sound tree got conflicts in:
> >=20
> >   sound/soc/cirrus/ep93xx-ac97.c
> >   sound/soc/pxa/e740_wm9705.c
> >   sound/soc/pxa/e750_wm9705.c
> >   sound/soc/pxa/e800_wm9712.c
> >   sound/soc/ti/davinci-vcif.c
> >=20
> > between commits:
> >=20
> >   2b45e1fa9398 ("ASoC: remove unused ep93xx files")
> >   efe81e9a9273 ("ASoC: remove unused davinci support")
> >   b401d1fd8053 ("ASoC: pxa: remove unused board support")
> >=20
> > from the arm-soc tree and commits:
> >=20
> >   f2211ac36ab0 ("ASoC: pxa: e740_wm9705: Drop empty platform remove fun=
ction")
> >   4ed923e8076b ("ASoC: pxa: e750_wm9705: Drop empty platform remove fun=
ction")
> >   394296eee2c2 ("ASoC: pxa: e800_wm9712: Drop empty platform remove fun=
ction")
> >   0e478b88b257 ("ASoC: cirrus: use helper function")
> >   2abde57fb82b ("ASoC: ti: use helper function")
> >=20
> > from the sound tree.
> >=20
> > I fixed it up (I just removed the files) and can carry the fix as
> > necessary. This is now fixed as far as linux-next is concerned, but any
> > non trivial conflicts should be mentioned to your upstream maintainer
> > when your tree is submitted for merging.  You may also want to consider
> > cooperating with the maintainer of the conflicting tree to minimise any
> > particularly complex conflicts. =20
>=20
> This is now a conflict between the arm-soc tree and the
> sound-asoc-fixes tree.

This is now a conflict between the sound-asoc-fixes tree and Linus'
tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/Vpo8bNqhSAAtL_b8iZyYPKY
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmP1QeMACgkQAVBC80lX
0GyccggAoiqhC6sAKbQArlpjlPlaZLwBb4yD0E6MmQ/5JoQcN4FYFLOlgIdLbyyO
efma32SZmaBEY9ZyRtRVyklSp4xoy11Y6+XbDK5w1LeZfSZD4dIjkfL36xXs1Vw5
Exj4WWz8kTqwNMxlKzBiqBSiUCldUmvbbXY237oRAAIdsheVseY4KsylVz3Gb21I
jIrq2yg6k2nn/iT3SFDu107Xp0skgf3CiNSLKMgn/K4Mkcvz8m+YWuBNpim1nPd7
ytww34KfRDf5dQjKK/j8p9dOu/exK7zc4gq33zwtKJ5GCwnAKGw8Q9emEGYvp0+3
btvtm439ewDEomjRcpQejrJO3egjjA==
=0O2m
-----END PGP SIGNATURE-----

--Sig_/Vpo8bNqhSAAtL_b8iZyYPKY--
