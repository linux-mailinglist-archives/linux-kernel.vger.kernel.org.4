Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7141D68F698
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 19:09:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231708AbjBHSJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 13:09:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231341AbjBHSJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 13:09:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 611CE1BED;
        Wed,  8 Feb 2023 10:09:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F04DAB81EFF;
        Wed,  8 Feb 2023 18:09:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E028BC433D2;
        Wed,  8 Feb 2023 18:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675879767;
        bh=fvO4kfoXCO71nXATxc5DoBEa0pGGL3+VW8TCkPSaDoU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CrHSSqzB0ssgQeJG5GnfaHJDTA3e1R+AXMoX3G322Oq7S5lgTdozDhfcE0kCdo+Wq
         Us2ycozQvS+Z3C3P3MFk2zq7ifskn3QLMR2vRTbULADXEh6L77KS46FHvPuzQ4yyYJ
         ux4V7JqcWXZ8aEukrIk470NVEircHoE72sGAhl14pVNEjEeKcytmzLyFmGV2Y36jlS
         ya++j4uy3mOgukYIP06A+tIFvxrCY7HNM/6poQbytOsTEcU+lbSzfUgxPlHwhYvE+y
         AGsX3SuaZMb1sA7JuWUpWF813tXJRqv5FYTpscwFpftlPZd04vJhaZOgofEFdr9ifp
         0cWm4ZZS5SLCQ==
Date:   Wed, 8 Feb 2023 18:09:22 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        - <patches@opensource.cirrus.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: dt-bindings: wlf,wm8994: Convert to dtschema
Message-ID: <Y+PlUtAmbl5TJq6z@sirena.org.uk>
References: <20230208172552.404324-1-krzysztof.kozlowski@linaro.org>
 <Y+PeR4EFfcVDbUfV@sirena.org.uk>
 <51e8e157-3f60-1731-a8ca-4a678c8eafd6@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7tf0mCliiDHI8Xod"
Content-Disposition: inline
In-Reply-To: <51e8e157-3f60-1731-a8ca-4a678c8eafd6@linaro.org>
X-Cookie: Walk softly and carry a megawatt laser.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7tf0mCliiDHI8Xod
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 08, 2023 at 06:50:56PM +0100, Krzysztof Kozlowski wrote:
> On 08/02/2023 18:39, Mark Brown wrote:
> > On Wed, Feb 08, 2023 at 06:25:52PM +0100, Krzysztof Kozlowski wrote:

> >> 1. Add missing LDO1VDD-supply for WM1811.

> > Both LDOs are present on all variants.

> The schematics for Arndale with WM1811 and WM1811 datasheet I found in
> internet say there is only LDO1VDD pin, thus "both" does not look
> correct at least for wm1811.

> But if you meant that this should be for WM8994 as well, then sure, I
> can change it.

Ah, now I think about it IIRC LDO2 uses one of the other digital input
supplies rather than a distinct supply so there's nothing for the DT.

> >> 2. Use "gpios" suffix for wlf,ldo1ena and wlf,ldo2ena (Linux kernel's
> >>    gpiolib already looks for both variants).
> >> 3. Do not require AVDD1-supply and DCVDD-supply, because at least on
> >>    Arndale board with Exynos5250 these are grounded.

> > Are you *sure* they are grounded and not supplied from the LDOs?

> That's what I have on schematics (attached), if I got it right.

You'll notice that they've got decoupling caps on rather than being
grounded - there's an internal connection to the LDO output so if the
LDOs are in use that's all that's required, while if the LDOs are not in
use for some reason then an external supply is connected there.

--7tf0mCliiDHI8Xod
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmPj5VEACgkQJNaLcl1U
h9B7aAf9Hx8NjZmQgmtfHsesBJ4m8zmqXIwFx7YPJGi1x4w2OjQE+cF7Drn/UtuW
LqosJbw4u6yCvrq5gKerLywWR/wW3noJoD3gfor1EYDlUgUd8CyRwH+ZD5KBL1oQ
89gb3O/ZHEgC5iaVN3KkUooWRu3+KhDHljeiHgWio0dDqhkDbB6BdO6GaCP/byWm
Mx9rK1bUGI9TWTfl3ny9l0bL6VwWHsrjDgQP1XToOUDY523di/RqCNxrbL43DRUB
0Pgqgcn3ZTGsFp+Lq+SH0AvmiVgZu/1SMiXzYci1AIWvDyK39WRT7T82fRgyEnBb
LnuxrO3XDkxFFzFc4iSIYLnSTNtf9A==
=PceK
-----END PGP SIGNATURE-----

--7tf0mCliiDHI8Xod--
