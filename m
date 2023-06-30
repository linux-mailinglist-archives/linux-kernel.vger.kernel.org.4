Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1C47441D6
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 20:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232672AbjF3SHB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 14:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232347AbjF3SG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 14:06:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFEE81FC0;
        Fri, 30 Jun 2023 11:06:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 633AF617E0;
        Fri, 30 Jun 2023 18:06:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44654C433CC;
        Fri, 30 Jun 2023 18:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688148415;
        bh=yz5t1GiipNFNh1NtxgqisnUQ1CD8Mwvmr2prkm+aqsw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h8BVS2sR9N6T9w9CrLbGEkLtZUN8hymR5Yfqq38a/aJIH/8+cN3LhWC1qe0ABBgYh
         +WqBRGYdoQU6Nt3Hxgu274LZGxuj3dXTjUFC0gpadKnR24KWnwNss6TUOYs5HzPAgL
         69DWTSkPmvlyIGijGGtVsdNgq93wlUFCgrMlNUyUbtwMMbYkbBTmdNaNRMd8a9wsOh
         HHDYDzKOmi2CTL7ac6HlH4x3ONaT6UQE/kzzOtQfsAzzW63ScznY5jFrNSUqpfzIhG
         AoZkWNd9IQDpbsm4pGf/Gu3vudY9yeH3x7B7zrg0vngrABIfRCyWMgg5e+S/ARWYIe
         MIrXoY3Cv3KjA==
Date:   Fri, 30 Jun 2023 19:06:46 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mtd@lists.infradead.org, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-oxnas@groups.io,
        Arnd Bergmann <arnd@arndb.de>,
        Daniel Golle <daniel@makrotopia.org>
Subject: Re: [PATCH v2 08/15] dt-bindings: net: oxnas-dwmac: remove obsolete
 bindings
Message-ID: <20230630-oppressor-circulate-1a2e5631d0dc@spud>
References: <20230630-topic-oxnas-upstream-remove-v2-0-fb6ab3dea87c@linaro.org>
 <20230630-topic-oxnas-upstream-remove-v2-8-fb6ab3dea87c@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="BvTA36mVIWDn/yrV"
Content-Disposition: inline
In-Reply-To: <20230630-topic-oxnas-upstream-remove-v2-8-fb6ab3dea87c@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--BvTA36mVIWDn/yrV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 30, 2023 at 06:58:33PM +0200, Neil Armstrong wrote:
> Due to lack of maintenance and stall of development for a few years now,
> and since no new features will ever be added upstream, remove the
> OX810 and OX820 dwmac glue.
>=20
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Acked-by: Daniel Golle <daniel@makrotopia.org>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--BvTA36mVIWDn/yrV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZJ8ZtgAKCRB4tDGHoIJi
0n34AQCaqt+oiyrpU/1VK5nJptp1QM1CruwCYZ4Kyxm+cqFlRAEA/3ZXE+gSBEOw
+/4RXjuoc0d0lEczRHPZqKqBpZdabgU=
=8KMl
-----END PGP SIGNATURE-----

--BvTA36mVIWDn/yrV--
