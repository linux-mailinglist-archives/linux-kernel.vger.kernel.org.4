Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21A3D66C2D9
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 15:54:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232624AbjAPOyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 09:54:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232839AbjAPOxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 09:53:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 502382411F
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 06:42:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7E46960FE1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 14:42:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 142CCC433EF;
        Mon, 16 Jan 2023 14:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673880171;
        bh=WsxMDAcMokmx6RzIrfj36P59DWpr6wXA1tT6CKcmJc8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U6r42Alc2l2T5cKwSbqv6na/jzazfkyYVGADvym9G1TYLLX2u91g8F2hKNRvVlRfW
         3xSTAggV4mQYbnxebubOD41g1E8wIjkOnPOneFHEsD0cnZk74iv5Zf7tvXCuvr/MVv
         cwilIkUrFT97QwF5EQ7wgcH64ZY/vm93LhbWVoqwbjTiSh+fZ0CITb/BgmLY8HZIiO
         xpcrrH6qXkGWTUZ1erjW/ynoDxbJQ/wJfOUSpZRbP3L9yfwEmT1j4YsZRt/1S1SmhQ
         wNvIrua4gsGocsuLF7TUTv8I6aBKJva6tdSREPKR7cAfY+S3ZNgKasj6ebZImWC5ih
         cI6MLD+26BoLA==
Date:   Mon, 16 Jan 2023 14:42:47 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
        Lee Jones <lee@kernel.org>,
        Martin Botka <martin.botka@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        martin.botka1@gmail.com, Samuel Holland <samuel@sholland.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/3] mfd: axp20x: Add support for AXP313a PMIC
Message-ID: <Y8ViZ4iKQv0klglW@sirena.org.uk>
References: <20230116142501.767142-1-andre.przywara@arm.com>
 <20230116142501.767142-3-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="QyCk/zA30PD1sX6Q"
Content-Disposition: inline
In-Reply-To: <20230116142501.767142-3-andre.przywara@arm.com>
X-Cookie: Serving suggestion.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--QyCk/zA30PD1sX6Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 16, 2023 at 02:25:00PM +0000, Andre Przywara wrote:

>  static const struct of_device_id axp20x_i2c_of_match[] = {
>  	{ .compatible = "x-powers,axp152", .data = (void *)AXP152_ID },
> +	{ .compatible = "x-powers,axp313a", .data = (void *)AXP313A_ID},
>  	{ .compatible = "x-powers,axp202", .data = (void *)AXP202_ID },
>  	{ .compatible = "x-powers,axp209", .data = (void *)AXP209_ID },
>  	{ .compatible = "x-powers,axp221", .data = (void *)AXP221_ID },

The sorting isue applies to everything you added here too.

--QyCk/zA30PD1sX6Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmPFYmYACgkQJNaLcl1U
h9CBnwgAgvUptDHGDg2/WLI9gNlsapNSWrPGyjphXxWyhRFudRHFqmyuINwmxpmm
muYpJRGMe1Xz6vFAeWZbHlWZCCens9wCqryXqbtxwkCspGKinkoJVcx81gKCrvQX
F9SaPf6gnG4Pes7TPXaF2rgMioW2VlW5/6dzUzZAg+fxFnGcdhaaCMJqn3QEldPZ
aFbzNZUngVIFPY4ly5Idvr/lpiBzGlTJg2t3S2eLiwO1NNmMweiTWLySQS4VmuCE
5qCXd+WaZEHtas93nH0nxrFKvRqNLp2d23W9uIrDcdjwGqibG8fbUpaFdzd6Rd/F
YbcCzI2YVjwjPd25YocuoczgMb902A==
=s+w2
-----END PGP SIGNATURE-----

--QyCk/zA30PD1sX6Q--
