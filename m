Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE8A7476F7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 18:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbjGDQlQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 12:41:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230452AbjGDQlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 12:41:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8185010C8;
        Tue,  4 Jul 2023 09:41:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1294B61306;
        Tue,  4 Jul 2023 16:41:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E826C433C7;
        Tue,  4 Jul 2023 16:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688488872;
        bh=uZGcW+BNNYPiMMqm5ClacCxmoqVyCYuJ9CXWf3fmoAU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sSg/a38ehv1r51sCngNXAKyvtYUXf7mwmLlZAFHvmK403Rd1HupZMxojj1RSFPkWd
         LpJhHeXARr+R1+9T4HCQXk3/BCFimstSWzVrFhbnQlq3FsP/Fe9kIdTgxHRmaU/Zqc
         M5ppjPkzdtfwNxKsT5jFh1H6x34hC+/VWKJccJXfbkAxX5pbvVZvxfJ/malAtvbD9e
         eR69KV2qo7YYmyy4Lwz7nqbEkuFmPQpAjFK41cFQgG99zUVvo92mNHTfnHfj4qO2xP
         OFubV6WVMtVyEjI7RZpq4t1Oca/bp4Rr+ajPEWKdE6HX6Hl0iNfwnSDoxVUR1H9GpR
         S6G9q4b8aqCxg==
Date:   Tue, 4 Jul 2023 17:41:07 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        William Qiu <william.qiu@starfivetech.com>,
        devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [RESEND v1 2/2] riscv: dts: starfive: Add spi node for JH7110 SoC
Message-ID: <20230704-commute-grape-38ded99556d5@spud>
References: <20230704092200.85401-1-william.qiu@starfivetech.com>
 <20230704092200.85401-3-william.qiu@starfivetech.com>
 <7f3b600d-d315-22d6-b987-eabfe1b04fdf@linaro.org>
 <eba1e868-6371-42fe-91be-bcbee54d1aff@sirena.org.uk>
 <4afd90d9-f1bd-f40d-1c79-50fef1406ab7@linaro.org>
 <6307c5b2-64d2-405f-b1a5-696d4184f6a0@sirena.org.uk>
 <a8c1a5e7-9938-bf6c-6bb7-6c1e4d8ce08b@linaro.org>
 <41c905da-ae3e-4acb-bbfa-d33d3306824d@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="DKLfejsgq4GdSLTL"
Content-Disposition: inline
In-Reply-To: <41c905da-ae3e-4acb-bbfa-d33d3306824d@sirena.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--DKLfejsgq4GdSLTL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 04, 2023 at 03:13:17PM +0100, Mark Brown wrote:
> On Tue, Jul 04, 2023 at 03:21:30PM +0200, Krzysztof Kozlowski wrote:
> > On 04/07/2023 15:16, Mark Brown wrote:
> > > On Tue, Jul 04, 2023 at 02:27:57PM +0200, Krzysztof Kozlowski wrote:
>=20
> > >> Also see:
> > >> "every Co-developed-by: must be immediately
> > >> followed by a Signed-off-by: of the associated co-author."
>=20
> > >> https://elixir.bootlin.com/linux/v6.4/source/Documentation/process/s=
ubmitting-patches.rst#L467
>=20
> > > Oh, that seems unhelpful especially with it not lining up with the DC=
O.
>=20
> > I assume the intention was here that if I attribute some co-author with
> > Co-developed-by, then I know that author, therefore I expect author to
> > explicitly participate in DCO chain.
>=20
> Why?  They're not the one sending the patch out, nor are they relying on
> someone else having certified anything.

It's probably safe to say that StarFive owns the contributions anyway,
so I doubt adding really makes a difference here.

> > Otherwise, just drop the Co-developed-by.
>=20
> It seems separately useful.

Yup, I'd rather have the people there if I ever have to run `git blame`
on whatever commit this becomes.

--DKLfejsgq4GdSLTL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZKRLowAKCRB4tDGHoIJi
0mz6AP4jqMUl/YN3mJ7p0cJwVO9EB2gCXcFLthrQYmpc03uuVgD+MdDmxiZC8PpO
NdZlsf5LpDIVnRlklVh8c1gWkrHdwAk=
=uQV7
-----END PGP SIGNATURE-----

--DKLfejsgq4GdSLTL--
