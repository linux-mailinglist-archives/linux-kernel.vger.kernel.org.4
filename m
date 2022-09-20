Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 754C45BED1A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 20:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbiITSui (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 14:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbiITSuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 14:50:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D9A060697
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 11:50:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A4E8062C5A
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 18:50:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92B5DC433D6;
        Tue, 20 Sep 2022 18:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663699812;
        bh=dOYzWRMQWTrZbt6u0ynOkDPBKV+hg47zMmG+PHOrkLw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KVbuXEeqQCjsPYr4c9Ry528aOYGUQGjvDXKCIx5VMK62fu3CmQKR6qNhFA2F1OwZP
         Lid16WWkb8EhJ5Bk+EjHqs2jILZqSKYFa1LJMaKBWJ2ITh8GTLYcCf9UaG9Uqj92Yb
         HA3rsYTEu61DYQUEu3a9VqOBDJdoQfIwBHUQ5XW5aFHKwHMEE5lA1bELKCQ/Mc8dBv
         CO5EDc+Z4yHHdA0w9ShA59XGpTPzasybk5vClgqiFMHKhhW/qBTAuvEAPkGEO8Miq7
         AxJrab5JSNX6GWhKyHYI4+0TJWYE+qfaH7uZCJ+t6RFTmk+kCTNvhRsciw+Vq323Jz
         JRblVB8kx5DDQ==
Date:   Tue, 20 Sep 2022 19:50:09 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "Limonciello, Mario" <mario.limonciello@amd.com>
Cc:     linux-kernel@vger.kernel.org, Xiaoyan Li <lxy.lixiaoyan@gmail.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        Sebastian S <iam@decentr.al>,
        Travis Glenn Hansen <travisghansen@yahoo.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Subject: Re: [PATCH] ASoC: amd: yc: Add Lenovo Yoga Slim 7 Pro X to quirks
 table
Message-ID: <YyoLYe9uGNnfl1iA@sirena.org.uk>
References: <20220920171320.7776-1-mario.limonciello@amd.com>
 <YyoBjHftjG/ACAuJ@sirena.org.uk>
 <f4fea2ca-00ae-ba85-b666-9fa267961add@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3GEW1jVz+nbFLVcE"
Content-Disposition: inline
In-Reply-To: <f4fea2ca-00ae-ba85-b666-9fa267961add@amd.com>
X-Cookie: One FISHWICH coming up!!
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3GEW1jVz+nbFLVcE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 20, 2022 at 01:09:45PM -0500, Limonciello, Mario wrote:

> As I mentioned below the cutline it's on top of the other commit on the list
> touching the same code:

> https://lore.kernel.org/alsa-devel/20220917070847.14346-1-lxy.lixiaoyan@gmail.com/

That looks like it's some patch which wasn't even sent to me...

Please include human readable descriptions of things like commits and
issues being discussed in e-mail in your mails, this makes them much
easier for humans to read especially when they have no internet access.
I do frequently catch up on my mail on flights or while otherwise
travelling so this is even more pressing for me than just being about
making things a bit easier to read.

--3GEW1jVz+nbFLVcE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmMqC2AACgkQJNaLcl1U
h9BA7Qf/fhD4DzTx3lYUaQtUnZc84inux3PG7lz1R+vDNWj72rYGyvR2xyT7CZuO
NRJ/twpIxq9Ny3+TofsUXVi4+h5BFpRx90mJEsvOeZZdCGLFSqxb1YuswBbGCXKQ
4T8ST7NPSdUChItvFW7ZpnaWKnT78WK2sxYrHTI3D7xkGk3XE7QV74gh0mjWIQqN
NIjybZCL2qmRnFWt1eYskWizgreuUT0VekJFacKl1SPMOUKABH695h1xlD1j46ym
G5vf5gWAclU0yXYgXGNyv27pPix/8YKB5yzgKKr5ZuDevrtqdvaw13/d9yXGdc/j
/paSqx8Z1xhM8e83eG+wxN0UJj5rJw==
=qdjQ
-----END PGP SIGNATURE-----

--3GEW1jVz+nbFLVcE--
