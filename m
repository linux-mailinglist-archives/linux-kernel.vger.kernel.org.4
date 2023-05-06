Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B5D26F9141
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 12:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231857AbjEFKpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 06:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231286AbjEFKps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 06:45:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A1663C3B;
        Sat,  6 May 2023 03:45:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 541656179A;
        Sat,  6 May 2023 10:45:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74F0DC433D2;
        Sat,  6 May 2023 10:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683369945;
        bh=mdAeXvDvAsh4oPGhPgeDNTs48DKzuWnkMpws6AcGyeE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eGlRVoqEN1sSxivM1kUzgH5wR3j2dq3vSSXS1YcaQMh8lsuR40Zch7rxHIT1izzPa
         VxFMPZ1JVUXB35MCW7DFvTHjEFADBeOS+y7bnRDcyGhgy9o0lFi3wvzCTghCxxr6RO
         9QW1NTulQe4GSNXW1DJm71do0fOwnOLF2cq8tYdJucvh3ovnhtvR3rHCzXTOhPFcdU
         MrUSyIVBnn94efl0E5OL2i4EcjuzkIBlGmP/L90Ue4lJS/sZKS2BehNe1GnJgycIch
         JVl7fOXIYhrLh9MOdB6vx+pELbLdbgmDMEWK3zJ0eEPwJ4fTdhGX+jSrvS1CR3TW9w
         qmQbcB3i/j30Q==
Date:   Sat, 6 May 2023 11:45:38 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Maksim Kiselev <bigunclemax@gmail.com>
Cc:     Andre Przywara <andre.przywara@arm.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Maxime Ripard <mripard@kernel.org>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 1/6] dt-bindings: spi: sun6i: add DT bindings for
 Allwinner R329 SPI
Message-ID: <20230506-mobility-judge-11bf5e258c2e@spud>
References: <20230506073018.1411583-1-bigunclemax@gmail.com>
 <20230506073018.1411583-2-bigunclemax@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Eic5fH4KMQjsoFCn"
Content-Disposition: inline
In-Reply-To: <20230506073018.1411583-2-bigunclemax@gmail.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Eic5fH4KMQjsoFCn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Maksim,

On Sat, May 06, 2023 at 10:30:09AM +0300, Maksim Kiselev wrote:
> From: Icenowy Zheng <icenowy@aosc.io>
>=20
> Allwinner R329 SPI has two controllers, and the second one has helper
> functions for MIPI-DBI Type C.
>=20
> Add compatible strings for these controllers
>=20
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  .../devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml        | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-sp=
i.yaml b/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml
> index de36c6a34a0f..2c1b8da35339 100644
> --- a/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml
> +++ b/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml
> @@ -21,6 +21,8 @@ properties:
>      oneOf:
>        - const: allwinner,sun6i-a31-spi
>        - const: allwinner,sun8i-h3-spi
> +      - const: allwinner,sun50i-r329-spi
> +      - const: allwinner,sun50i-r329-spi-dbi

=46rom the driver patch:
"Add basical support for these controllers. As we're not going to
support the DBI functionality now, just implement the two kinds of
controllers as the same."

Should this not be set up as a fallback compatible, per Samuel's
suggestion here:
https://lore.kernel.org/lkml/9ae7d1ee-4e2d-f3c1-f55f-e96b0e449b63@sholland.=
org/

Thanks,
Conor.

>        - items:
>            - enum:
>                - allwinner,sun8i-r40-spi
> --=20
> 2.39.2
>=20

--Eic5fH4KMQjsoFCn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZFYv0gAKCRB4tDGHoIJi
0kNKAQCc6YXuweRIlRrDgRAXOJnIG0uN5R2tL/fxIzNV8q9KxQD9GRVzBGOPGztP
hupgvwOSJKKM5Q0DMouV7dpmWU5aZwk=
=btCb
-----END PGP SIGNATURE-----

--Eic5fH4KMQjsoFCn--
