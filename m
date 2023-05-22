Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF1170C703
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 21:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234582AbjEVTYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 15:24:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234591AbjEVTYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 15:24:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD6D9CF;
        Mon, 22 May 2023 12:24:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3A3576287A;
        Mon, 22 May 2023 19:24:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA9C2C4339B;
        Mon, 22 May 2023 19:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684783485;
        bh=RSKvD+Gg0X0tn8/0dtsFGEkG2OQ9a7Azcy+M2cqCDiw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jXOEwZO7yCqNHHQ+wkO8E6g3WIXsWRU3srInmTFq8BCIGKR6udYIPuoEiRw8PZQKd
         jKND4lNpZDcbU+a0u6vsqN/62wK5cUl+kdUtxpETwgnR54a1P65aCh+1QZQxbZNsXZ
         kbTNnbD7SpeOWKPqks2ewaxWsE6DGAWKZgSuD78phXDfug7yEXYKznHTdAlN8ncTGI
         uKI6MabT3RF9B4kbAxS1o07SnD/ICx+IgVKcPmVzdXoLgGjJclbpdoITAz+DgbkTO9
         oZ8Sk5dAooYC+KCW4CpTQf907LF+ffSaJys863uMg2iGzHNZpNqv4wy9nCy7Om6m+h
         4Fq9Sxi5oPKLQ==
Date:   Mon, 22 May 2023 20:24:40 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-ide@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH v2 4/6] dt-bindings: phy: rockchip: rk3588 has two reset
 lines
Message-ID: <20230522-blanching-unfiled-b89a4378622e@spud>
References: <20230522173423.64691-1-sebastian.reichel@collabora.com>
 <20230522173423.64691-5-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="XlKnjVVIuNeAc4md"
Content-Disposition: inline
In-Reply-To: <20230522173423.64691-5-sebastian.reichel@collabora.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XlKnjVVIuNeAc4md
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Sebastian,

On Mon, May 22, 2023 at 07:34:21PM +0200, Sebastian Reichel wrote:
> The RK3588 has two reset lines for the combphy. One for the
> APB interface and one for the actual PHY.

But the 68 only has one? Should per-compatible enforcement be added
like you added for the clocks?

> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  .../bindings/phy/phy-rockchip-naneng-combphy.yaml         | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/phy/phy-rockchip-naneng-co=
mbphy.yaml b/Documentation/devicetree/bindings/phy/phy-rockchip-naneng-comb=
phy.yaml
> index 9ae514fa7533..82550a5c2ed5 100644
> --- a/Documentation/devicetree/bindings/phy/phy-rockchip-naneng-combphy.y=
aml
> +++ b/Documentation/devicetree/bindings/phy/phy-rockchip-naneng-combphy.y=
aml
> @@ -31,8 +31,14 @@ properties:
>        - const: pipe
> =20
>    resets:
> +    minItems: 1
> +    maxItems: 2
> +
> +  reset-names:
> +    minItems: 1
>      items:
> -      - description: exclusive PHY reset line
> +      - const: phy
> +      - const: apb
> =20
>    rockchip,enable-ssc:
>      type: boolean
> --=20
> 2.39.2
>=20

--XlKnjVVIuNeAc4md
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZGvBeAAKCRB4tDGHoIJi
0ulrAQDdVYZ0XlkyJr9Pk+AzBZf9DYBqLoF3J5agxBBphJ/icAD+Ps9MqBbyxLxN
Wtkf7n3izQhheQvLbTM0gYlDXt8TzgU=
=I8fK
-----END PGP SIGNATURE-----

--XlKnjVVIuNeAc4md--
