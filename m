Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9A32672CBE
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 00:43:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbjARXnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 18:43:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbjARXnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 18:43:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D41E656C3;
        Wed, 18 Jan 2023 15:43:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4589D61AC2;
        Wed, 18 Jan 2023 23:43:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 403F0C433EF;
        Wed, 18 Jan 2023 23:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674085386;
        bh=Okd6MIEI+bnAJs2p19rWhJG6+ljN8iX62czvy5e5c4o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FMWFJvg3ySJH0/xRmzFgX4ei12XCJ5lb0Yl/JzgdDT7Zm6buaZShV2CeaPY8LpDpY
         8VOatkM9mAFJLZXAODl1O3ey0EzSTLWATSDKVJzes85RwWWLSnIompE0k5DP0Evk7n
         rK9ErPDnQ+pEdhJBRWeDhGMyyMRWSXaGj9jNVT7wTRzWDaJZy/dIpaq+sm/5EuvpQf
         y+wAYGHrI4ndrhR420aWYE1sXSPeU8zIlKWm6MkudIP9XTT4nXM/aG05Qv5sdOKkmm
         czKMDGGowcBcNBvlsiErUA1e6EyVhYUclEFL8GRh/6HjroEMeuh7nCUPrbJO/CbZ6Y
         S7HryQL2hYdcQ==
Date:   Wed, 18 Jan 2023 23:43:00 +0000
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
Subject: Re: [PATCH v3 7/7] riscv: dts: starfive: Add StarFive JH7110
 VisionFive 2 board device tree
Message-ID: <Y8iEBOjLthlNX/xy@spud>
References: <20221220011247.35560-1-hal.feng@starfivetech.com>
 <20221220011247.35560-8-hal.feng@starfivetech.com>
 <Y72nbfJxYdO2AojI@spud>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Ck4pvxVOY1Kfvyhk"
Content-Disposition: inline
In-Reply-To: <Y72nbfJxYdO2AojI@spud>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Ck4pvxVOY1Kfvyhk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 10, 2023 at 05:59:09PM +0000, Conor Dooley wrote:
> On Tue, Dec 20, 2022 at 09:12:47AM +0800, Hal Feng wrote:
>=20
> > +	aliases {
> > +		serial0 =3D &uart0;
> > +	};
> > +
> > +	chosen {
> > +		stdout-path =3D "serial0:115200n8";
> > +	};
>=20
> So I think this is wrong, and the stdout-path should be uart3 instead.
> Per the QSG [0], GPIO5/6 are the suggested UART Tx/Rx to use.
> This appears to map to uart3 rather than uart0.
> FWIW, uart3 is also the stdout-path for the v1, see:
> arch/riscv/boot/dts/starfive/jh7100-common.dtsi
>=20
> At least, that change is what I needed to do in order to use the
> JH7110_VisionFive2_upstream branch, AFAICT matches what you've got in
> this series.

I went and re-tried things again today, but with the clk & pinctrl series
=66rom the ML instead of that branch.
I'd gone and used that branch instead of the patches, as there were some
build issues with the pinctrl driver from the patches.
I fixed the build issues in the pinctrl driver and now uart0 works.

Looking at it again, it makes sense for uart0 to be serial0, given
there's pinconf stuff being done in this DT for pins 5 & 6 for uart0.

Perhaps by using that branch, I was using some older drivers etc given
it seems to mostly contain commits dating from November?
I'm still a bit confused about the whole thing, given I tried out a
whole load of branches to get something booting with ethernet support
that day!

Since this seems to work with the fixed pinctrl driver, I don't think
you need to change anything here.

Apologies for the noise!
Conor.


--Ck4pvxVOY1Kfvyhk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY8iEBAAKCRB4tDGHoIJi
0ui9AQCEj0sA+NvX+A6mlsoSkQPrEOSs990I2Ni0LtP1f+xkRAEAw6Srrmpajmp3
i9HfNdFUU1MPc0SrwlyKgR5faz0F7AU=
=vX2v
-----END PGP SIGNATURE-----

--Ck4pvxVOY1Kfvyhk--
