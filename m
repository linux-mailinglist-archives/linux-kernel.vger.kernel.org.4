Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 467F26F914A
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 12:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231949AbjEFKtp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 06:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjEFKtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 06:49:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C68E3A85;
        Sat,  6 May 2023 03:49:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2DEDF61A0A;
        Sat,  6 May 2023 10:49:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E23DC433EF;
        Sat,  6 May 2023 10:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683370181;
        bh=OlQOxYKW4SXZYcXypb34XxCl3+X160znYrTJbr+qWUM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MLl1/gdKFqK8ElwObuC+WmydhWi4GpDT7ht6fPKxoC6hAUDlfnZwMPHHpmiEKs0fx
         qsR6Wu5FitpadgxOoLkKSwVGXv7vEPiGm/tYXDQx2+cap8x77SaAZQFnmC5kJqUTrk
         54Br4GZfN6uo1v7JlHDWpBYqWbFBVpUqJtVWQKQRJAoLZDmQtkaP7AJa8bZFFQybge
         lBgOTEj82f2x0u2Ib0GpPib75XdT58vynnHnbbUY9Mt8SP3/lb050p+UvpQY/tf/kX
         NcPAyrhuNBcH0XoxXkAcS+/yLhROBcJgr+MFxaKMvBJ2w9uecCttj0VXZMLK/xnfGO
         y5lvhkTp5vC5Q==
Date:   Sat, 6 May 2023 11:49:35 +0100
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
        Maxime Ripard <mripard@kernel.org>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 5/6] dt-bindings: spi: sun6i: add DT bindings for
 Allwinner D1/R528/T113s SPI
Message-ID: <20230506-unfixable-lavish-eb7907a1a887@spud>
References: <20230506073018.1411583-1-bigunclemax@gmail.com>
 <20230506073018.1411583-6-bigunclemax@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5lAUstyTyaabrUyb"
Content-Disposition: inline
In-Reply-To: <20230506073018.1411583-6-bigunclemax@gmail.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5lAUstyTyaabrUyb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 06, 2023 at 10:30:13AM +0300, Maksim Kiselev wrote:
> Allwinner D1/R528/T113s SPI has the same as R329 controllers
>=20
> Add compatible string for this controller
>=20
> Signed-off-by: Maksim Kiselev <bigunclemax@gmail.com>
> ---
>  .../devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml      | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-sp=
i.yaml b/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml
> index 2c1b8da35339..164bd6af9299 100644
> --- a/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml
> +++ b/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml
> @@ -30,6 +30,10 @@ properties:
>                - allwinner,sun50i-h616-spi
>                - allwinner,suniv-f1c100s-spi
>            - const: allwinner,sun8i-h3-spi
> +      - items:
> +          - enum:
> +              - allwinner,sun20i-d1-spi

Yah, this one is more like it. The "allwinner,sun50i-r329-spi-dbi" one
should be done in the way too.

Cheers,
Conor.

> +          - const: allwinner,sun50i-r329-spi
> =20
>    reg:
>      maxItems: 1
> --=20
> 2.39.2
>=20

--5lAUstyTyaabrUyb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZFYwvwAKCRB4tDGHoIJi
0kJmAQDqt8aTRyBU1JudXMxWI7MO+3HuHjTKN+FXiHOxoEwPRAEA9d6bTe/01zz2
D1porgB5E8jZK3nBcEWbGNZ04hDmaQk=
=RXB8
-----END PGP SIGNATURE-----

--5lAUstyTyaabrUyb--
