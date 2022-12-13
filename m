Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67BB564B4BD
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 13:04:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235486AbiLMMEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 07:04:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234703AbiLMMEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 07:04:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF48715A26
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 04:04:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B750614B3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 12:04:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9346C433D2;
        Tue, 13 Dec 2022 12:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670933076;
        bh=PPHuWE4XkstXrom2xaRiEphZZiBoxWs7d6Ao/vsKC+s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uwTIiPuU7JeBUvPvgQBH94owxmCf6mPQZD5/lNCQfrdyMM3pHq6GeBC5YCi2tWQrt
         Vr6YgRAAWYCakDYorT4zNNDLfOvlOyCNvB7YyznYwu0zLCECTHB/X8Ldl4xEf8uuWa
         cTced4Vwr/AFNwwIPGmrA1hryVgJiwtf/nhGBjEVph1fabgoFPPwOM4jxjHasQ/znN
         wVJGI7ynbaRR9TWAqQzZavHlk40PYWMfuHLkDu9G0ocBmAeNL4FhAmjNGReBYZmZcS
         b8LFTr5dXCBJRsb8moLMUqiEpJXo+QmpvpUpDK97NzkVipZJ8rSc3e/AzJaj2536IV
         C3RPAvCLxx9Yw==
Date:   Tue, 13 Dec 2022 12:04:31 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Rouven Czerwinski <r.czerwinski@pengutronix.de>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, kernel@pengutronix.de,
        Marco Felsch <m.felsch@pengutronix.de>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] ASoC: max98088: fix dai1/2_hw_params access
Message-ID: <Y5hqT3KL0+XENJcj@sirena.org.uk>
References: <20221213095328.122309-1-r.czerwinski@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HgDPkyQ14qG89rof"
Content-Disposition: inline
In-Reply-To: <20221213095328.122309-1-r.czerwinski@pengutronix.de>
X-Cookie: Edwin Meese made me wear CORDOVANS!!
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HgDPkyQ14qG89rof
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 13, 2022 at 10:53:27AM +0100, Rouven Czerwinski wrote:
> From: Marco Felsch <m.felsch@pengutronix.de>
>=20
> According the reference manuals [1], [2] updating register 0x14/1c
> should only be done after #shdn bit is set to 0.
>=20
> [1] https://datasheets.maximintegrated.com/en/ds/MAX98089.pdf
> [2] https://datasheets.maximintegrated.com/en/ds/MAX98088.pdf
>=20
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> ---
>  sound/soc/codecs/max98088.c | 8 ++++----

You've not provided a Signed-off-by for this so I can't do anything with
it, please see Documentation/process/submitting-patches.rst for details
on what this is and why it's important.

--HgDPkyQ14qG89rof
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmOYak4ACgkQJNaLcl1U
h9Ad4gf9GB01gs7BPIzFvCH25I5aQlpvYWfjZX6pVoRy6gCVh+0zqbmH3XoyBHim
ieacSU9N2nGG48HkUKlQXsOb5/QXde45Gh8T9s4xwV5YdvM0TF1o9+jNE2uGEOgC
CnMcUt4AZl73ihJi8NqiqHYa7Rg5p3rFDgoe4mmCn9M4br5Rd8fKyCgeQnzqSGa7
xzkvruCaOWI0sJ6OCfFbIkKq2G2yO+3Z5uSMBR41+eiFyDBHfy2bGLckJ9GLeEDm
sg7O3NeMki2GEbctfGemG2Oa1JHVB0Qq+1AoHu6Jp0xzfsUDZjwRtxU/b+I2J2c1
a3ooBqIuJ9tmSI4cw6vnWYuTpOkhrw==
=hmG0
-----END PGP SIGNATURE-----

--HgDPkyQ14qG89rof--
