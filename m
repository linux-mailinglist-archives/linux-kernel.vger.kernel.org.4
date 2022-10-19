Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FC4660461D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 14:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbiJSM62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 08:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231823AbiJSM6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 08:58:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE358A7E2;
        Wed, 19 Oct 2022 05:41:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C5E8C6186D;
        Wed, 19 Oct 2022 12:40:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 247A9C433D6;
        Wed, 19 Oct 2022 12:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666183206;
        bh=8d6CdrccoT97cECfxO7g6a1f4262AbKj4LgQxlbZkwU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SK8O4ky0fQMSolFb3X8ZM7WVIicmqRC7UhjbaecIOdbxO+xNDylUl3MU1PJ/Di9K+
         kcE5wyJk1zQlNK9EV98lwe9t+ZYnJCxPo5ff8moOPMCaIjhiDE+Na+XeYLfMbyvGK+
         Gqi9JoEV1JBL7hjIMIQsTjX532US5gfOGtf4EIMfIrQj00cBxsLuAHY1D0/524sg2i
         0xEWu1eyNZjxkU21pnwACWTN9jk+5dii9c/af14bIjb3YO2hnsDTU9Q06M0Q/I1etB
         2d3svVuKFbybaONqrM/zas28bHssLFMgP2+kKkV3JLPeJe6LuhG1Q5s0QnVFLbRwst
         E/MhU1I/LumDQ==
Date:   Wed, 19 Oct 2022 13:40:00 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Colin Ian King <colin.i.king@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-mips@vger.kernel.org,
        alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next][V2] ASoC: codecs: jz4725b: Fix spelling mistake
 "Sourc" -> "Source", "Routee" -> "Route"
Message-ID: <Y0/wIPFAWH3cLQzx@sirena.org.uk>
References: <20221019071639.1003730-1-colin.i.king@gmail.com>
 <Y0/pSVbueZYXBsmA@sirena.org.uk>
 <S820KR.GPNPWZ8QG3PG3@crapouillou.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="BarSh9pR8ITjJrt2"
Content-Disposition: inline
In-Reply-To: <S820KR.GPNPWZ8QG3PG3@crapouillou.net>
X-Cookie: I like your SNOOPY POSTER!!
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--BarSh9pR8ITjJrt2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 19, 2022 at 01:19:40PM +0100, Paul Cercueil wrote:
> Le mer., oct. 19 2022 at 13:10:49 +0100, Mark Brown <broonie@kernel.org> a
> > On Wed, Oct 19, 2022 at 08:16:39AM +0100, Colin Ian King wrote:

> > >  There are two spelling mistakes in codec routing description. Fix
> > > it.

> > Bit disappionting that people didn't notice the errors during boot
> > there...

> Well that's on you. You merged the patchset before anybody could review.

That includes whoever wrote the code in the first place, and I do note
that I applied version 3 of the series.

--BarSh9pR8ITjJrt2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmNP8CAACgkQJNaLcl1U
h9Dvzgf/UwmdmQxOamn+37JPevW80uGyuE3ITBXUK9gT2Rb2ow1M8Bdm1QmlUjTx
OImxIOYNNXJ+DZ4Tec4ybjtwlB0EaUvXRiw8TWePLZKwRDDrYoVSSyBfagTYSchD
OUOIGJgifR/ECR15TApRJX2CyGCeoe0V31Vz0IkQD12a7xbVvdg8+3AbTp8+yQvD
IJJTM0S/HUn07KktLl2xDFNvtSdPOekZE1Ju6sBd6i8ByNUcvOqGCp0pXUZnbTXy
2LuOq+9qdh5PngUcDjlQ90B2sh5fIYJEu2hM+xRuLPbW0ENzS7pm9DNuvuIvTGYL
BiboNnUF477UdJpVstIMKfqk6YIT5g==
=fKUT
-----END PGP SIGNATURE-----

--BarSh9pR8ITjJrt2--
