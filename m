Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 157E264E09A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 19:22:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbiLOSWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 13:22:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiLOSWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 13:22:36 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB8284667B;
        Thu, 15 Dec 2022 10:22:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 66E76B81C37;
        Thu, 15 Dec 2022 18:22:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17311C433D2;
        Thu, 15 Dec 2022 18:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671128553;
        bh=dAaOdWTPCc7tzr5zLW6fD/haLwLpJykRK4uPP26zcfE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ovOmvcVJK+pbxmzyzMfETbt5Usv3hISJzTZuEcW6r2mdgU2XcS3x12pTd4d0PlVRU
         9DBk+sUxP3gx5LgyKL2Tr2mzDMr3O816aAGA5Xzi6ZcTcsnh58amiUMPtZ+IBk10hY
         cbPLO4nb695Dz84nkN9F7A443FHrzxWaqxrZ8/Ve91MpHB1j8kQPpOriaGjZ0YxglU
         NFZ1BPt5mKyVOkXqDkvARlu2vJEENCGr5fuWuu7alGuBOq6pINzLnBNAP74aX7kwRY
         ysZqnH0fNwe5fz4G5u5d0GP6MO0+6DQpxNMB6DAc3ymieYUFXHwqSVKgPuFIJEoLlB
         xn7MuS3Ca33Jw==
Date:   Thu, 15 Dec 2022 18:22:23 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Nishanth Menon <nm@ti.com>
Cc:     jerome Neanne <jneanne@baylibre.com>,
        Wadim Egorov <W.Egorov@phytec.de>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "kristo@kernel.org" <kristo@kernel.org>,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "lee@kernel.org" <lee@kernel.org>,
        "tony@atomide.com" <tony@atomide.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "geert+renesas@glider.be" <geert+renesas@glider.be>,
        "dmitry.baryshkov@linaro.org" <dmitry.baryshkov@linaro.org>,
        "marcel.ziswiler@toradex.com" <marcel.ziswiler@toradex.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "biju.das.jz@bp.renesas.com" <biju.das.jz@bp.renesas.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "jeff@labundy.com" <jeff@labundy.com>, "afd@ti.com" <afd@ti.com>,
        "khilman@baylibre.com" <khilman@baylibre.com>,
        "narmstrong@baylibre.com" <narmstrong@baylibre.com>,
        "msp@baylibre.com" <msp@baylibre.com>,
        "j-keerthy@ti.com" <j-keerthy@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Subject: Re: [PATCH v7 1/6] DONOTMERGE: arm64: dts: ti: Add TI TPS65219 PMIC
 support for AM642 SK board.
Message-ID: <Y5tl3+2pJispcXy6@sirena.org.uk>
References: <20221104152311.1098603-1-jneanne@baylibre.com>
 <20221104152311.1098603-2-jneanne@baylibre.com>
 <d0d7e315-ce86-0420-8ef5-fe2e4aefd5b4@phytec.de>
 <e2bc53fe-3a0c-cf24-8b29-ca377aba3721@baylibre.com>
 <Y5tGzjgcAWPqdFNE@sirena.org.uk>
 <20221215175411.znxy3d6ussq2iq5h@grieving>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Ou+aT4tEkmn4+pSU"
Content-Disposition: inline
In-Reply-To: <20221215175411.znxy3d6ussq2iq5h@grieving>
X-Cookie: Today is what happened to yesterday.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Ou+aT4tEkmn4+pSU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 15, 2022 at 11:54:11AM -0600, Nishanth Menon wrote:
> On 16:09-20221215, Mark Brown wrote:

> > That proposal looks really non-idiomatic and quite unusual, if there's a
> > fixed voltage supply to the LDO I'd expect to see it modeled as a fixed
> > voltage regulator.  I'm not sure what the use of bypass here is trying
> > to accomplish TBH.

> The problem is this - the default NVM in the PMIC is setup such that
> VSET value =3.3v and bypass bit set (makes sense since the vin=3.3v).

This implies no voltage drop over the LDO?  Sounds a bit suspect.

> Now the constraint is bypass bit cannot be changed without the LDO
> being switched off.

> regulator-allow-bypass property allows us to control bypass bit, but we
> should'nt toggle it when LDO is active. Not providing the property
> implies the bit wont be toggled by regulator core either.

> What we need is a scheme that will disable the bypass bit with the
> intent of operating the LDO with just the vset field. I did'nt find it
> possible atm.. unless I am mistaken..

Can the consumer just disable the supply as part of startup?  Though
that's starting to feel rather board specific.  There's not really a
good place to put a board specific setup process like that in the kernel
at the minute, you'd ideally want the firmware to leave the device at
least disabled if not actually out of bypass on startup so we don't have
to deal with this.  Ugh...

--Ou+aT4tEkmn4+pSU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmObZd8ACgkQJNaLcl1U
h9BH+QgAgXSqInlA7GNyvDv3vqe3E5eleoOCrAa5Ti6K31e7Nvrrr1eDU3YoFQHF
T1gPkwcmB8T5CvtTK7gWQi5Yv8HAXerZRJXZHYw3cm682lyi+FDUUtq6nAU9Py0G
wKuNxyD0r5s4VU0IEKMq3AmxpfpDAR1O1X+J17M1qpA7hRTWS2gOvtdFp9f5Qv6M
7DcL8RN3/kL8lbypTL4D2gFAmxcDSStYOtbNYzzf+ScPXb3FJp0lqn5oFuQzjRuv
GbcR1e9FRnMNGVZAUfmY8vhSICzHLwMzHZMLZhgNqR20tNc5NrVhEGFfb3BWxU8Q
9SSKv8RBqU1QqLYxzYC6GkpsKtNcVw==
=rWw5
-----END PGP SIGNATURE-----

--Ou+aT4tEkmn4+pSU--
