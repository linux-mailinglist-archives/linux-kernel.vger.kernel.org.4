Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3DE764CCBA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 15:56:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238557AbiLNO4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 09:56:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238267AbiLNO4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 09:56:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A15119C38
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 06:56:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DB2F661807
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 14:56:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F822C433F0;
        Wed, 14 Dec 2022 14:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671029777;
        bh=yZdmbCXTWUddvVBEZHmeG2z9NI9Lx2d7dIQudtCYe74=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JPGSqz1KYnRvZzGrfNEcaYJlisk1nWUqray5NbRVq9cd4j3AJ0xN0D2rUJp4emJkF
         2ujcrlyUkh/F52zgC7YB1Wf7Ljx7xQX2j6q4Rd+wBFExEpyvDC/5Uj7NVe0FoBvtlq
         NkCXYh9VE2G4+IOLHhQY/0Brs4V68VY4BcTBaHwFv6jy+xdndUX9OHs7Q1UyFP1P13
         dzuRu+P160rGM/iGGhJrn7o10xNwkha99J6+hDfa2AE/AGg3l8jD9F4oDzDcdp0JX5
         mtuh2zMDbBC9CSzr4lVREVt99RE1viOYiuVSY2mX1J7aOEkDxt2XlpSj4WjMpuBSig
         DdahU8XY7t85w==
Date:   Wed, 14 Dec 2022 14:56:12 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
Cc:     David Rau <David.Rau.opensource@dm.renesas.com>, tiwai@suse.com,
        perex@perex.cz, support.opensource@diasemi.com,
        lgirdwood@gmail.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ASoC: da7213: Add support for mono, set frame width
 to 32 when possible
Message-ID: <Y5nkDEcgbZ2vNEsK@sirena.org.uk>
References: <20221214044058.6289-1-David.Rau.opensource@dm.renesas.com>
 <Y5nb7ik1cCKo+FlR@sirena.org.uk>
 <CAG+cZ07erTzV8Re-xo8GixpsEhK28Q6wHxQeE0co+sWgQAFgGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9H/SuYdosBTIY+zW"
Content-Disposition: inline
In-Reply-To: <CAG+cZ07erTzV8Re-xo8GixpsEhK28Q6wHxQeE0co+sWgQAFgGA@mail.gmail.com>
X-Cookie: I disagree with unanimity.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9H/SuYdosBTIY+zW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 14, 2022 at 03:31:26PM +0100, Piotr Wojtaszczyk wrote:
> It was a single patch, with no deps.
>=20

It's flagged as patch 2/2?

> On Wed, Dec 14, 2022 at 3:21 PM Mark Brown <broonie@kernel.org> wrote:

Please don't top post, reply in line with needed context.  This allows
readers to readily follow the flow of conversation and understand what
you are talking about and also helps ensure that everything in the
discussion is being addressed.

--9H/SuYdosBTIY+zW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmOZ5AsACgkQJNaLcl1U
h9Bd4Af+LPQLMTNkvKgvj0m+xCZebSX/5SfFCTHBQ6rwcogNbgHy+suNi+8WHRKs
O9qU8gKEshxtUqyh9qG1GmIYJZ4gtbKHxBnjAeMPTTFQPc4a4ehxwKbOJgDizMmo
/vHWERfBZ562FGUDVGHzOSWsffAAvJLg42t9yatHJlYV/88q84VVq1enDd6uu5EM
u4QdIjqjtjgoGFqsF/Xc+5Xyq3C8d2evmjdlXO5/hnCuplgWrsJXn5+JY3yuOfVj
WzDuuPZ5GZoc84Nnvsd1ltTjOMcuJkVjkno5dqrVVUQ/aB1uZHanDw+9ClFqbC7z
25FSe85pqkPp5cyN7MGbqsX/NKAYeQ==
=Kpy7
-----END PGP SIGNATURE-----

--9H/SuYdosBTIY+zW--
