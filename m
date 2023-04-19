Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88E406E78ED
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 13:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232930AbjDSLtD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 07:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231524AbjDSLtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 07:49:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 912AF196
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 04:49:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A25162CE7
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 11:49:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FA62C433D2;
        Wed, 19 Apr 2023 11:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681904939;
        bh=efh+5H8A8LPK5xRJMGyzwRgk6UCz+rOpyyurbUGxVnU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ueKXv7GCVt8yL+hR9TrL41ieTEw9EOTggudjpbcnvuGLR9PLQynL7SaF9EwgXvxwL
         B2tMPoV/4XZAdf2hsh+8Xb4vdN9y45oRydcsXweJYCOnZf+ccBsAyuzxqqbxp/YIT7
         xGBrrMt8UXImSd2e1+BBhSIKqz+CmLT5y8QI9I2ZdW1nvapmlWbjBllh4FEU6jOc7C
         67IKmTQee50YPDrZJMPJLK8dDcD7P+NC/UoXJQm/7qce0ZkUNyRYvAerucuGiExaDc
         4FPL0O2sRLYMaZAJQpLixvzpYoFVNEsKtnh+6KiA87oWL20wMBYXqYSsstNspu0pL7
         73j70xlOIUBRw==
Date:   Wed, 19 Apr 2023 12:48:52 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        David Lin <CTLIN0@nuvoton.com>, Arnd Bergmann <arnd@arndb.de>,
        Tom Rix <trix@redhat.com>, Peter Rosin <peda@axentia.se>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] ASoC: nau8825: fix delay time range check
Message-ID: <c6bc42c6-4a98-4bb6-9639-acf4c2010b68@sirena.org.uk>
References: <20230419114546.820921-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="J8zj3FY9iXJVyBa1"
Content-Disposition: inline
In-Reply-To: <20230419114546.820921-1-arnd@kernel.org>
X-Cookie: This is your fortune.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--J8zj3FY9iXJVyBa1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 19, 2023 at 01:45:39PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> clang points out that the recently added range check is nonsensical:

Someone already sent a patch for tihs.

--J8zj3FY9iXJVyBa1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQ/1SQACgkQJNaLcl1U
h9D4hgf+NsxxGD7IocXiGwI+ClPVOXKW4Sgiuh+nGdVi2M0/itthwOkgwRP43xZE
eQzzwnqIVyXsCjcBZemgyhbotowwatYmISqVBmscT8TwKLIwJw/lygPainFNqwIE
mhqR81sPysEJPJWFnlkSBpOoao5Cs6a5OqHQrogdiHKVg7OjYI3mGknP+x9mcwaB
wGJZ0u1hb7YyzH7rVN2mkdRC90hiCOm/30GsLQir5XEiSGTbJzUaaJ4BSqYpwD7C
E58q7UUnWI3ITddqAuUGU3W9rKppfHgIi766pw1u1jKxJeXbbqAbXfrMH/nfVBka
RCfCaY1J5pupmlUkUIynLuz6YLT4jw==
=Kwn5
-----END PGP SIGNATURE-----

--J8zj3FY9iXJVyBa1--
