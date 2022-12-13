Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58ECB64B482
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 12:54:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235269AbiLMLxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 06:53:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235453AbiLMLxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 06:53:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCBEFE9E
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 03:52:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0669661136
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 11:52:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FDC7C433EF;
        Tue, 13 Dec 2022 11:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670932371;
        bh=ePJSkFmO7rTSCEsDmQ4u2sbhXqzJzgIxWRhCGwh+2to=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YNXDEZd0QsY7POQsItKKCAO3gzvIJyR//PBygrwiOrF7MvcuCu5Zo74NJDT+l2yyc
         TEoP6RL7CU6+jwlbdbMPJLzuUr6tWib3DRqVGJpw3bhB1nRG4rc7lU5h+UOb2z87A8
         DfzQpNYVjGfcq3FcpNL/TZboCMqv0oB9WqbhKg/qc9/FdKjUAx4bBz7SLghi00LDLz
         rF+IP9a9qaX8jXTEjtv3kkYCXYCfMkI+za2U/IBAW/2RDig1iCRys8Z/YfidjEV7Dv
         6FzOriCg1KxLP+VByFiKsi3OG013elgqov50weVoMzolLlGaJDe4gEadJAPRHIgpg+
         b6AMImGdMAGIA==
Date:   Tue, 13 Dec 2022 11:52:46 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Moises Cardona <moisesmcardona@gmail.com>
Cc:     perex@perex.cz, tiwai@suse.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add HP Stream 8 to bytcr_rt5640.c
Message-ID: <Y5hnjoK7eeQYj02z@sirena.org.uk>
References: <20221212205835.994911-1-moisesmcardona@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6sM7bFgILwBEtVx/"
Content-Disposition: inline
In-Reply-To: <20221212205835.994911-1-moisesmcardona@gmail.com>
X-Cookie: Edwin Meese made me wear CORDOVANS!!
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6sM7bFgILwBEtVx/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 12, 2022 at 03:58:35PM -0500, Moises Cardona wrote:
> The HP Stream 8 tablet is identical to the HP Stream 7 in terms of the PC=
B,
> with the exception of the added SIM Card Slot.=20
> Therefore, I'm submitting this patch which properly initializes the audio=
=20
> and enables the headphone jack to work, just like it does in the=20
> HP Stream 7.

As documented in submitting-patches.rst please send patches to the=20
maintainers for the code you would like to change.  The normal kernel
workflow is that people apply patches from their inboxes, if they aren't
copied they are likely to not see the patch at all and it is much more
difficult to apply patches.  You should include the maintainers for the
Intel drivers here.

--6sM7bFgILwBEtVx/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmOYZ44ACgkQJNaLcl1U
h9AE8gf+JOAFImuwurs/aXiS2ZGgrFNs1cD830pke47xzcK+ZRUodGD9+xI3epWs
UzRZroO6mWJ5BzGu4UHnVx5l59c7qxOCnDH6gvzMsE2pc+uvU1B8DNirnX+OHMwE
HGJlEeypHkf+yZUu/ix89v91TplD6E2xjDGG7yIBh2sG9OQpykY4OOdRzlS+lzR6
4fPVch0AAoTy5X/203Kmku89smTwNN0quBAVfIhey4XrZ1UA9UAtHMRZ5cwiztey
5BgRz0xX8c1w7AtVc2blg6TW4ls/BB+GfgcSDYKdODw1bhU7F4ADBn+vOsfzCpEx
VxuvaGZZ7thypqZzo55uV3QCo/GIoA==
=xopk
-----END PGP SIGNATURE-----

--6sM7bFgILwBEtVx/--
