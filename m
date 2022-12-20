Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D34D665286E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 22:31:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234154AbiLTVbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 16:31:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233890AbiLTVbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 16:31:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E1501EC68;
        Tue, 20 Dec 2022 13:31:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2439661530;
        Tue, 20 Dec 2022 21:31:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1241EC433EF;
        Tue, 20 Dec 2022 21:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671571909;
        bh=4guvi9YPGFRvRQkeTTfj8xKEOlTkQRxYmYlBnGBXEX0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ASxomZZ51mjz4Jo/cYvbgQ8eSBD4Tn8igs2KbvX90bcV+batkM9mcEcqR6yEFxKaL
         m6eRlqXxtHZR8VhA5kAbbr6LjbEcjO+RPq6+oqD1yGOzrZDgu59kpEPGA2T1xLz01B
         jdlJk4CJCkE4Y+wRWhotjfCFXnlT1GyfNF0oj10fMTQ/p5TOpWLG81hoUgxBnmWWNd
         lGjeJUQS05LoIFGXZqnUHE2AnoB/bWI/ARiD9MGFabxR5csrcyp2L3u8bmIIBJ26L3
         yMO8Zmm0BAMkrZ6YcY7IA90xnO2ufKbygNruyugkqY/3jfgdEW9VPeZ1boHijaWKt9
         0M+sYe8B4HrnA==
Date:   Tue, 20 Dec 2022 21:31:43 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Hal Feng <hal.feng@starfivetech.com>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ben Dooks <ben.dooks@sifive.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 6/7] riscv: dts: starfive: Add initial StarFive JH7110
 device tree
Message-ID: <Y6Ipv0BUummgqNaw@spud>
References: <20221220011247.35560-1-hal.feng@starfivetech.com>
 <20221220011247.35560-7-hal.feng@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ObhNkYFiXiedhNNQ"
Content-Disposition: inline
In-Reply-To: <20221220011247.35560-7-hal.feng@starfivetech.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ObhNkYFiXiedhNNQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 20, 2022 at 09:12:46AM +0800, Hal Feng wrote:
> From: Emil Renner Berthing <kernel@esmil.dk>
>=20
> Add initial device tree for the JH7110 RISC-V SoC by StarFive
> Technology Ltd.
>=20
> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> Co-developed-by: Jianlong Huang <jianlong.huang@starfivetech.com>
> Signed-off-by: Jianlong Huang <jianlong.huang@starfivetech.com>
> Co-developed-by: Hal Feng <hal.feng@starfivetech.com>
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> ---

FWIW, this cpu-map is now the default in linux, so you no longer *need*
to add it for that purpose - but there's obviously no harm in being
explicit for other operating systems etc. (IOW, don't remove it!)

> +		cpu-map {
> +			cluster0 {
> +				core0 {
> +					cpu =3D <&S76_0>;
> +				};
> +
> +				core1 {
> +					cpu =3D <&U74_1>;
> +				};
> +
> +				core2 {
> +					cpu =3D <&U74_2>;
> +				};
> +
> +				core3 {
> +					cpu =3D <&U74_3>;
> +				};
> +
> +				core4 {
> +					cpu =3D <&U74_4>;
> +				};
> +			};
> +		};
> +	};

> +		syscrg: clock-controller@13020000 {

For obvious reasons, I cannot apply this until both the clock & pinctrl
bindings are in my tree - but you know that already.

> +			compatible =3D "starfive,jh7110-syscrg";
> +			reg =3D <0x0 0x13020000 0x0 0x10000>;
> +			clocks =3D <&osc>, <&gmac1_rmii_refin>,
> +				 <&gmac1_rgmii_rxin>,
> +				 <&i2stx_bclk_ext>, <&i2stx_lrck_ext>,
> +				 <&i2srx_bclk_ext>, <&i2srx_lrck_ext>,
> +				 <&tdm_ext>, <&mclk_ext>;

As Krzk asked - are these clocks really all inputs to the SoC?

> +			clock-names =3D "osc", "gmac1_rmii_refin",
> +				      "gmac1_rgmii_rxin",
> +				      "i2stx_bclk_ext", "i2stx_lrck_ext",
> +				      "i2srx_bclk_ext", "i2srx_lrck_ext",
> +				      "tdm_ext", "mclk_ext";
> +			#clock-cells =3D <1>;
> +			#reset-cells =3D <1>;
> +		};
> +
> +		gpio: gpio@13040000 {

> +		gpioa: gpio@17020000 {

Out of curiousity, why gpio & gpioa?

Thanks,
Conor.


--ObhNkYFiXiedhNNQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY6IpvwAKCRB4tDGHoIJi
0rWYAQDTig/t+OM+9hgBx8d3GAyl2YXKCY8myegiWUBmFC6xAQD/aQpZ/dHH5sUO
IXoDliLR2oe/z45FzDkNU6ZSUhqQEAA=
=U8m6
-----END PGP SIGNATURE-----

--ObhNkYFiXiedhNNQ--
