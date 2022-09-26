Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CFC75EA94E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 16:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235475AbiIZO4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 10:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235254AbiIZO4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 10:56:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D92B375CF0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 06:27:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7057360DCC
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 13:27:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEE55C433D6;
        Mon, 26 Sep 2022 13:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664198830;
        bh=X4krFBdD4YBSMJWhMxVRmiJA8BmDJcxguLhvT2x7FMI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cyJIrULjx1jYP9GG6AwNB+942qX/pKwHpmXoEe1L7mu2qEhFvD82Izy2XNdbHH45G
         iiHPxGX4aKTRI4dmBvtj2bDcsPCcVPnSLHUl+pyXj9Dn1kQejiP+1RShvdxDzPbWfz
         CHnq1VjVrc8oOi4IRu6O9GSGRXL+l5x4HPwo+MD2b5V+OUiEB2D6jQ9aTlAIGQr0jw
         OB9S3DohbEhMfyDRrJ8jxUYhuoaYHa88yCrpQpwDBGa8M2zjLJnSfPBBNxebVDiJzh
         NsLqcgX3XXlQ5mMreiyvD/dLcbVyX2feVFNWYwmAMHsnDLge3nov1X2FDkpaVvzRdN
         kLUMefAQCMbBQ==
Date:   Mon, 26 Sep 2022 14:27:04 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Akihiko Odaki <akihiko.odaki@gmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        =?iso-8859-1?Q?N=EDcolas_F_=2E_R_=2E_A_=2E?= Prado 
        <nfraprado@collabora.com>
Subject: Re: [PATCH 1/2] ASoC: amd: acp3x-5682: Remove SND_JACK_LINEOUT
Message-ID: <YzGoqEFunlmj+kAn@sirena.org.uk>
References: <20220924095025.7778-1-akihiko.odaki@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ZQPBE47Sg1dDVZFM"
Content-Disposition: inline
In-Reply-To: <20220924095025.7778-1-akihiko.odaki@gmail.com>
X-Cookie: You may be recognized soon.  Hide.
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZQPBE47Sg1dDVZFM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Sep 24, 2022 at 06:50:24PM +0900, Akihiko Odaki wrote:

> RT5682 only has a headset jack.

>  	ret = snd_soc_card_jack_new(card, "Headset Jack",
> -				SND_JACK_HEADSET | SND_JACK_LINEOUT |
> +				SND_JACK_HEADSET |

Will the device by any chance happily drive this as a line output
(possibly even detect if it's a headphone or a line output device
attached)?  The CODEC hardware is often interchangable.

--ZQPBE47Sg1dDVZFM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmMxqKgACgkQJNaLcl1U
h9CgyQf/XdHOCs25OMxT+vFXwhG57sTC9SvLFRmQdU3/UrthbFtwSnjQ67s1gXeI
r9xy8U2nVaRVjC3aL/q6Gxhhhh4ofUV/rWs0FvCTk29dYQxDGWaD4kvo6A3F3TjS
fw0kF3fBGt4XT5/OP6Bn14BThrupUeVwKW1bIw4y/9KbR7lg5hL/ua4RszUFUsmv
0E3QuSLuz3PCfuUhC/H+5uyxTNwglwFnDq8fVVd0sbIFt79aZ9GkoY6I/PamIz2I
Cp6C1UCjDrx3KPeOi+OfE8+xK7Xm8CBD0TUvM2C2OytXSCgA+doqcW7RC+ZaSuvH
LJG72iyPpAtqquWuz/1zcpibi72eag==
=KGMW
-----END PGP SIGNATURE-----

--ZQPBE47Sg1dDVZFM--
