Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA7C73BB2D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 17:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232555AbjFWPK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 11:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232023AbjFWPKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 11:10:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2544530D8
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 08:10:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6BB7C61A8E
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 15:10:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59C01C433C8;
        Fri, 23 Jun 2023 15:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687533009;
        bh=R4rREPl7M1d3ioFChOIWdLIDfVQY3LnF6Pcd9QI44rw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HeYR3jSLHJFXrwraFKlAIUy8AVU0ets41Eq1zl0o3XF3SzJIadmzOHzhEVE9Ih47t
         zUsPI06COdc+gKYKEnl81wYHxqkVI5sgi1Dz5xnWLocbq/tj+fPD2fHxAfIoZNxpt5
         fyHsHOUkD/HwIEyvUWDIDmsksoEnDAD4cIg7qkt2NmUZX6PlruAp3E4RHUmIDGXea0
         0Zu5iK+5e/uf55Ji8ZS22xdYWwtL424q7HkOtxBrtbe1NyCZu4fym/f5dTrGZHmjue
         RBUujpWdwP3n+MbwLRN2NXBGZdklu7uNkPGXnchreGBAdsWu67+BFuRmET02oE0bZN
         +4slzTRfAsC0Q==
Date:   Fri, 23 Jun 2023 16:10:06 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "Limonciello, Mario" <mario.limonciello@amd.com>
Cc:     Arun Gopal Kondaveeti <arungopal.kondaveeti@amd.com>,
        alsa-devel@alsa-project.org, Vijendar.Mukunda@amd.com,
        Basavaraj.Hiregoudar@amd.com, sunil-kumar.dommati@amd.com,
        venkataprasad.potturu@amd.com, syed.sabakareem@amd.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] ASoC: amd: update pm_runtime enable sequence
Message-ID: <ZJW1zjWMUYXP1XpH@finisterre.sirena.org.uk>
References: <20230623214150.4058721-1-arungopal.kondaveeti@amd.com>
 <80e86035-f6e5-3059-6cf9-7f6cd93fa2ee@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="eF6HMMrE3THkHzzf"
Content-Disposition: inline
In-Reply-To: <80e86035-f6e5-3059-6cf9-7f6cd93fa2ee@amd.com>
X-Cookie: Slow day.  Practice crawling.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--eF6HMMrE3THkHzzf
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 23, 2023 at 08:40:15AM -0500, Limonciello, Mario wrote:
> On 6/23/2023 4:41 PM, Arun Gopal Kondaveeti wrote:
> > pm_runtime_allow() is not needed for ACP child platform devices.
> > Replace pm_runtime_allow() with pm_runtime_mark_last_busy()
> > & pm_runtime_set_active() in pm_runtime enable sequence for
> > ACP child platform drivers.

> Can you explain what prompted this?

> Does this fix a particular bug, or is it just to correct
> things?=A0 If it fixes a particular bug; I think it should be
> split up across 5 patches (one for each APU) and then
> appropriate Fixes tags applied for each on the code they're
> fixing.

I had already gone ahead and applied this before your mail - it seemed
better to get it into 6.5 than leave it waiting longer.  If there's a
need for backports that can be handled through the stable process.

--eF6HMMrE3THkHzzf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSVtc0ACgkQJNaLcl1U
h9DojAf9Enm/l/OMrjMwbAPilcSH8mRifk/LU9KL085p1vG/y5Pt04uG0eKNREuD
NWq7OxHBKp4Ke93ww07AxVp4XuYWk8u662mhrQa/OuEIAjBQieXo38UuhqOF/nYS
DAmsidTC979HYQuMkl/jGLCldHBTZH1HQT64Gel2M+09T53x++KCbWqkXI0Alwlk
EAv/C7dFvW/+sDpMG1z1N4GdbJERdxLcffKv1CBBeyZOt4JyJOyxHCIQUsY4X6Tv
LNjAcZPXQ+V+IK24foeNiUzwwHX6n7/B7qK2kbnrWZO4+w7Cq8s6bKIJuI22jfax
4qACFcj2rdzPquxozbqxMOY3BXwnQQ==
=tt24
-----END PGP SIGNATURE-----

--eF6HMMrE3THkHzzf--
