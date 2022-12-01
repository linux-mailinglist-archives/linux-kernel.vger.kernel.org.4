Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E679D63EF0F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 12:14:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbiLALO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 06:14:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbiLALNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 06:13:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A66CD9A6;
        Thu,  1 Dec 2022 03:08:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 43EB3B81EA5;
        Thu,  1 Dec 2022 11:08:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BFE3C433C1;
        Thu,  1 Dec 2022 11:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669892889;
        bh=PahB8+mPXd0jsxi+GkOWIVJ003B6bh7/zfcYA2Nb474=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TOXsRcytQw8HTt9oXcQMY8JFsEdYbz4MI33trwwdN9MwwXpPMuuTN7UFwx5IkgWqV
         78sTqZsILPY8i1tILbPhwhjYQXviU5NAtkOgYvd9HDdbix/o+yEUbJDTnRmnseJ1Gt
         JRdsVyXu6rFCvVose6s59i9pq3SACvMIfgilGkHmJV42nJX+QcBQWEOgOa1fMw3K5d
         GJfxmWu3YnzdRtWPeAqdBn+osvR72wELKJGlfEz4sHmIzDFrexuJWWYkfX4iQ/NYBb
         LyK1I4M0Pwlmx2BGB8dr4NXFDTPO0iu0sJ72djqEHU89Ttozq3qzad0a5CCdhudegl
         qgth3OOmK1I/Q==
Date:   Thu, 1 Dec 2022 11:08:02 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee@kernel.org>, Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Markus Laine <markus.laine@fi.rohmeurope.com>,
        Mikko Mutanen <mikko.mutanen@fi.rohmeurope.com>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: Fix maintainer email for a few ROHM ICs
Message-ID: <Y4iLEuIyVSC7Hy/Y@sirena.org.uk>
References: <7986d30480df6179a3989fba4cd13817738635c5.1669877740.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hqmJWUz+ZDX1x8fK"
Content-Disposition: inline
In-Reply-To: <7986d30480df6179a3989fba4cd13817738635c5.1669877740.git.mazziesaccount@gmail.com>
X-Cookie: Isn't this my STOP?!
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hqmJWUz+ZDX1x8fK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 01, 2022 at 08:57:52AM +0200, Matti Vaittinen wrote:
> The email backend used by ROHM keeps labeling patches as spam. This can
> result to missing the patches.

Acked-by: Mark Brown <broonie@kernel.org>

--hqmJWUz+ZDX1x8fK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmOIixIACgkQJNaLcl1U
h9A/Tgf/bpeGcIzcYVBcPE53GXu5EXCZponWfaEDafOEcyM2WhTfxmR1IbSUzJoh
d5aDrZxfxUIyJquLZoLSlh768KGinztSczsl+rQUFQ/qoxzCKz7W6LilqWnetcKp
8ErCZz+M0rlQsPrs5v1BsQfmlfVEiI1iABAWcfWTbTMpd73Urzi1nt/nYXoK+epY
E5UkrYBO5eiE89Tm995DLMHMtidg0dT2O0K1cZg6I9SdCZrzVDoM7yyVBUSJEAXM
J8votxt1hLgNkofUtqAWGxR6cv6+e0ZP7i/yDLOFbIRh5mBiygN4nDbHwtHSOqA2
Lol4wBb8dBmt5IMeOF/pge7nTKfyKg==
=OCH/
-----END PGP SIGNATURE-----

--hqmJWUz+ZDX1x8fK--
