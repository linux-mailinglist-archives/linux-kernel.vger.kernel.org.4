Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97D536B0D12
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 16:40:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbjCHPjo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 10:39:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231810AbjCHPjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 10:39:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05358C640F;
        Wed,  8 Mar 2023 07:38:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 08560B81D4E;
        Wed,  8 Mar 2023 15:38:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9851FC4339B;
        Wed,  8 Mar 2023 15:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678289918;
        bh=pOfVR7+MxMrqbi0+qUlLR9HciB6TD+Ey26pR8EmFIxQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GbauYbqNsnQIBfWU9R1+qOfY/R8dlGkI2adbqBs1ZPr0N06yB+ogkYwK4vWkPN9BK
         EImfvrHOvM0NkmskIE+najkvW2c5k1hn0Ior+NuYdaBIG+PuWoXtuQdkE1JqOBC79z
         IliDvcpcfg0jNJgauKarDaQqm3bhm/kSHgFKBOi9gOQ44cSSnOrh6aH4vxBN6ZCmLW
         /YS9+DMsyFXnKZMPE04hd5LWFpVxZJvmS0CYg6sWHfS5M7BmHocieo11W7GaG8TNyS
         2ehijWF+7IyR7CEFEaV/tmURDPMzoz8citvElyWH75JJx2+0F3fxc7+zJCIR0wH/PP
         Dg6o56G87nvPg==
Date:   Wed, 8 Mar 2023 15:38:31 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Walle <michael@walle.cc>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sebastian Reichel <sre@kernel.org>,
        Wolfram Sang <wsa@kernel.org>, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 03/20] of: Rename of_modalias_node()
Message-ID: <636296ae-299b-4bba-9e40-65ac538bac76@sirena.org.uk>
References: <20230308153200.682248-1-miquel.raynal@bootlin.com>
 <20230308153200.682248-4-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SYCyGWg4ADojR1Xd"
Content-Disposition: inline
In-Reply-To: <20230308153200.682248-4-miquel.raynal@bootlin.com>
X-Cookie: Minnie Mouse is a slow maze learner.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SYCyGWg4ADojR1Xd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 08, 2023 at 04:31:43PM +0100, Miquel Raynal wrote:
> This helper does not produce a real modalias, but tries to get the
> "product" compatible part of the "vendor,product" compatibles only. It
> is far from creating a purely useful modalias string and does not seem
> to be used like that directly anyway, so let's try to give this helper a
> more meaningful name before moving there a real modalias helper (already
> existing under of/device.c).

Acked-by: Mark Brown <broonie@kernel.org>

--SYCyGWg4ADojR1Xd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQIq/YACgkQJNaLcl1U
h9CoxAf+JDovQ0CruK6Kw1vn3Zom7AAcE8iCrp7bkKZriYYfpu4scbXWCmI3loo5
DFyGVRBQnqN04kZZyFGVSvZ5IP6BMZQE63/NQlhlNJeiX5yVK9jBbek5OH1Mn1an
fh5PkJ9k1cQvP/hZbSeBIgLKY95iQw5pGTn9SWKKJMvI42tKE6IgaArUYF4d3+2v
Pwvv6uQFwBZXl4NFt3NDLZV94g01znlEtqwZkWsz3gjeBwRIKAHeK+iS1yNRRH0o
SMHTo1qsZaCES0qFo8xtNjtsvjq1v2l2BGbBQN7KzCOAK2tnE9F1p3m0m+DrE+mL
7Bt0JC9pmAjd9TnIMJlD/FtKhThGnQ==
=V3F5
-----END PGP SIGNATURE-----

--SYCyGWg4ADojR1Xd--
