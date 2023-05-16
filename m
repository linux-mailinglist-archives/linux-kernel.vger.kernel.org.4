Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99A69705961
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 23:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbjEPVUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 17:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjEPVUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 17:20:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44CAB5FD6;
        Tue, 16 May 2023 14:20:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8CD576346E;
        Tue, 16 May 2023 21:20:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79A99C433EF;
        Tue, 16 May 2023 21:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684272010;
        bh=H1YErQrB2OPe1FfeXSRxx3wWyqVTS010quRPfHPe3gI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nmtPF+ak9OQ7xAYwrPvAF/Lbt2gCzoEXpg6ElguZiqjvaNd+Te9UdUuYtMy6lcSCb
         SPtCquzGTodeGjDNG4FSS8ybcXYgMAufIPxFP7CkcqY1fXiQhdT3kB9yl5HwiNiy4J
         Ve/6hFQOFFaG1nNECB6Uz4/S8s0XUa4mzmnSsp/f1/r0jLm59XPGokfuKjrR456hx/
         y5XtQMzfy0nU6vD8LTUnPyH9nG7uYMJbNGMO3QuJy4kKGF1PvWkQzPVOZx3sWZOejr
         4sV0K2An0Fk7t7FhkM6KildJ+eoI4ShPBMH2Liuvr2W6b4UAdx6ClRigo2cIMHgfRv
         TeOWT1uxW2Xkw==
Date:   Tue, 16 May 2023 22:20:06 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Li Yang <leoyang.li@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: mfd: gateworks-gsc: remove unnecessary
 fan-controller nodes
Message-ID: <20230516-onslaught-conceded-8e27b4bc7e4a@spud>
References: <20230516153314.453095-1-tharvey@gateworks.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2vYY8xRQ8w2qCcaa"
Content-Disposition: inline
In-Reply-To: <20230516153314.453095-1-tharvey@gateworks.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2vYY8xRQ8w2qCcaa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Tim,

On Tue, May 16, 2023 at 08:33:13AM -0700, Tim Harvey wrote:
> Remove the unnecessary #address-cells and #size-cells nodes from
> the fan-controller.

It'd be nice to mentioned _why_ they are redundant, since the diff
doesn't contain that context.
Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

>=20
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> ---
>  .../devicetree/bindings/mfd/gateworks-gsc.yaml         | 10 ----------
>  1 file changed, 10 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/mfd/gateworks-gsc.yaml b/D=
ocumentation/devicetree/bindings/mfd/gateworks-gsc.yaml
> index acb9c54942d9..dc379f3ebf24 100644
> --- a/Documentation/devicetree/bindings/mfd/gateworks-gsc.yaml
> +++ b/Documentation/devicetree/bindings/mfd/gateworks-gsc.yaml
> @@ -122,12 +122,6 @@ patternProperties:
>        compatible:
>          const: gw,gsc-fan
> =20
> -      "#address-cells":
> -        const: 1
> -
> -      "#size-cells":
> -        const: 0
> -
>        reg:
>          description: The fan controller base address
>          maxItems: 1
> @@ -135,8 +129,6 @@ patternProperties:
>      required:
>        - compatible
>        - reg
> -      - "#address-cells"
> -      - "#size-cells"
> =20
>  required:
>    - compatible
> @@ -194,8 +186,6 @@ examples:
>              };
> =20
>              fan-controller@2c {
> -                #address-cells =3D <1>;
> -                #size-cells =3D <0>;
>                  compatible =3D "gw,gsc-fan";
>                  reg =3D <0x2c>;
>              };
> --=20
> 2.25.1
>=20

--2vYY8xRQ8w2qCcaa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZGPzhQAKCRB4tDGHoIJi
0g7vAQC2xZTO+TZtO8DjPffaL8EfG/QO8jAFJt/LBh6nKxg41wEA5DEofeQH+8lG
P/VdTRctr2g/AN75AOOyEHrBg0UO+QY=
=zC6F
-----END PGP SIGNATURE-----

--2vYY8xRQ8w2qCcaa--
