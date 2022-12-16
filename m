Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34F4E64EC31
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 14:42:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbiLPNmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 08:42:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiLPNmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 08:42:06 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADE32167E7;
        Fri, 16 Dec 2022 05:42:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 08554CE1E58;
        Fri, 16 Dec 2022 13:42:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AB36C433EF;
        Fri, 16 Dec 2022 13:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671198122;
        bh=2ta2ZSy/1DnFNJh/pelUUCAUc6BGdkCTfxCfkwD0h90=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kQN0C0k8g3tw/U2Df1O4kusm7rjJC90FfErN6s9R7utn3dzkZ/ZaadgST7NvTr2aD
         W4jcRD/OR/rAKVunSkwqDzBOT7+hck23uKNJTnJN2KD3UcolrP1VlUTeEzmGn34qZL
         AyJcfP9pEHN84Zw59XPGo0AzQzXUqPQkaBYDcrliM061gIqqbHWxnqlsXqatLpx4Yp
         rmxQFjI6/LG0/YsIfjo8EdQHnf6i8v8TFUWXehnDK3YeCm0FS7FF4U4/sNQ7QdxLqL
         TtDu8w+VeQBeOPBsHxftA/ZdUFgebSbJX72vpRPAzNBu4xp9LhRt6jJ95mCh/3+DkJ
         L+m/1JjE2pABQ==
Date:   Fri, 16 Dec 2022 13:41:52 +0000
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
Message-ID: <Y5x1oAzezZGqyZSx@sirena.org.uk>
References: <20221104152311.1098603-1-jneanne@baylibre.com>
 <20221104152311.1098603-2-jneanne@baylibre.com>
 <d0d7e315-ce86-0420-8ef5-fe2e4aefd5b4@phytec.de>
 <e2bc53fe-3a0c-cf24-8b29-ca377aba3721@baylibre.com>
 <Y5tGzjgcAWPqdFNE@sirena.org.uk>
 <20221215175411.znxy3d6ussq2iq5h@grieving>
 <Y5tl3+2pJispcXy6@sirena.org.uk>
 <20221215214149.whcjdphxxvvedrih@affront>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="VapHQVuQho8X7pjH"
Content-Disposition: inline
In-Reply-To: <20221215214149.whcjdphxxvvedrih@affront>
X-Cookie: No passing.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VapHQVuQho8X7pjH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 15, 2022 at 03:41:49PM -0600, Nishanth Menon wrote:

> Yeah - this happens to be SDcard supply (at least in my case).. I'd
> rather not change the mmc host or core layer to handle a case where
> LDO happened to be in bypass. it is a regulator driver's problem, IMHO
> how to provide the stated voltage OR fail to transition the voltage.

Well, if the regulator is in bypass mode then it is by definition not
regulating and so it's like programming the voltage while switched off,
setting the target for when it starts regulating again.  It's a weirder
use case but it does feel like the consistent thing to do at least.
The driver shouldn't enter/leave bypass without being explicitly told to
so since there'll be a performance impact.

> b) If I wanted the LDO to poweroff the bypass bit at start (define the
>    startup hardware condition), I dont seem to have a description for
>    that either.

That's something we could add in constraints, though the actual process
of implementing it might get messy if there's restrictions like having
to power off (though from further down the thread I see that might not
apply to this device).

--VapHQVuQho8X7pjH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmOcdaAACgkQJNaLcl1U
h9Dq1Af/ddHVFwSXOlqEfFOhIBYoXPlYIzskhgSQ37/fzbM3GgG8OYyBV3+uzWg7
UDcaFwuPoRpQs2FLQ69ODsy1PueJJoZw2O3yJ2684T+TYQzS9CKGkRx2VcbAWJVp
719ILyvgo0ZAHQD8Hl/jJgl1+at59wyTBaSNdtGC1HP68SpvPwrg2Iwh2yElD/IR
bO6qHZmL1MqJi5YMfjpHtwpH7Wg5NSfBkIm0B7jAcltYMG9e1DYfF6NxtZe5HFx9
LPo/V+Y6UkgqI5/yTdxF6VtHfMiLxBUfwnQM4YynGmfLb1hId9JU7UBLVB7JScxW
wkKBppC21IAR9aRDl9C8lsnbXE2FIg==
=h3Av
-----END PGP SIGNATURE-----

--VapHQVuQho8X7pjH--
