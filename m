Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7578269A2E9
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 01:23:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbjBQAXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 19:23:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjBQAXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 19:23:34 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E99453B0ED;
        Thu, 16 Feb 2023 16:23:31 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PHsww2pLNz4x5X;
        Fri, 17 Feb 2023 11:23:27 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1676593410;
        bh=fteKVRXA2Rfl7+Yd+j8rdrzjkIkb9XfcvUiaHcVHB0E=;
        h=Date:From:To:Cc:Subject:From;
        b=qzGBqak0ynmE9QH8MrUNNMjlgFRMF9j3LYyg4o5Cx2a3a6FDyEIWEfQYABdvq9xE6
         cWeysu5OXrFGMd558pNtCQuwBR6QqGna09MxYV1aJ+ytZHvcA1WSCwDfr6nzzfPXjy
         BczFNoPJkPFzHbUaP+zrCNGEKVy1ISvPeHhUCTHe/v2OiOWBKZOgi9fhmeyhr0cVCL
         wDGgNZcXH1Xe7Z2cwT9ELMPXmAwVxJeXAVJoxOpgVbsZ7eDXtEYyIaLB8pYEs3U241
         4CFYYKQMIo6E/MLy92yE9Oe2IMBs2g5wyoU2ZlR6tChLGtPmoX6cFqeS+o/dzJkytu
         zWCUdyahHL3vA==
Date:   Fri, 17 Feb 2023 11:23:27 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Takashi Iwai <tiwai@suse.de>, Olof Johansson <olof@lixom.net>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     ARM <linux-arm-kernel@lists.infradead.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>
Subject: linux-next: manual merge of the sound tree with the arm-soc tree
Message-ID: <20230217112327.5697baab@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/4TaH3F.GABl9I135i5olB7h";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/4TaH3F.GABl9I135i5olB7h
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the sound tree got conflicts in:

  sound/soc/cirrus/ep93xx-ac97.c
  sound/soc/pxa/e740_wm9705.c
  sound/soc/pxa/e750_wm9705.c
  sound/soc/pxa/e800_wm9712.c
  sound/soc/ti/davinci-vcif.c

between commits:

  2b45e1fa9398 ("ASoC: remove unused ep93xx files")
  efe81e9a9273 ("ASoC: remove unused davinci support")
  b401d1fd8053 ("ASoC: pxa: remove unused board support")

from the arm-soc tree and commits:

  f2211ac36ab0 ("ASoC: pxa: e740_wm9705: Drop empty platform remove functio=
n")
  4ed923e8076b ("ASoC: pxa: e750_wm9705: Drop empty platform remove functio=
n")
  394296eee2c2 ("ASoC: pxa: e800_wm9712: Drop empty platform remove functio=
n")
  0e478b88b257 ("ASoC: cirrus: use helper function")
  2abde57fb82b ("ASoC: ti: use helper function")

from the sound tree.

I fixed it up (I just removed the files) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/4TaH3F.GABl9I135i5olB7h
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPuyP8ACgkQAVBC80lX
0GxW7AgAgIaVDgdc78UKu5+53ivzK8wc5dDF3ci7iiaOkpcETzTr5KlwmB+o0FdR
gpc2/GwLeKDlZo+84H+lf37UgkSEdF2zNeHFa8YHpKt5K1cjizVwPW7GEP8FFWxE
/reGv7C29xXTufAyBuyvhuRCSSlrY8f+2W39+y9dJCviiE2SCjUkBN/AXufVKWIm
gpDIllRf3G7wv4HUuMiaKxAEmhUbtyRRZgjoqEeegxoQoLASNYMvOrRQPpPpiRqH
hgfHb+C16+36JLQnvxaGQwg7lCeBoCmkC7VLQS1EQtRuir7nMlHkxwe3jvdeOWXo
mJ4pFjK4AlnhvkcZufwi5Idt5HsMxQ==
=WASK
-----END PGP SIGNATURE-----

--Sig_/4TaH3F.GABl9I135i5olB7h--
