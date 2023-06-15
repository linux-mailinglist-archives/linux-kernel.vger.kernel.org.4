Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D07687321A3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 23:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236838AbjFOVZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 17:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbjFOVZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 17:25:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 656782D54;
        Thu, 15 Jun 2023 14:25:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 29820620E7;
        Thu, 15 Jun 2023 21:25:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0E29C433C0;
        Thu, 15 Jun 2023 21:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686864315;
        bh=K6X6+yGOr0u4jtpNY3QmWXJpnuR1wcGYkKplOkZdv6o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Cc+cTxEe5oICYytKicVq9pzda7yeU4KddYdS8fSb2Oi1XhZc2cGaXcscQEP4VA0jd
         jUUeNFXN21SnexMeqLy+oVfYCAwqfjSWM6nfq60VTvpl/FCjipcKBFc1+ZTP3neWbE
         fat+4QMusVTAJW9eBVn7NryEUHl+lZIU8YGybvWMjG44U1y5DD2aZyw7HRkh+5xA2w
         QNocs42p9GQ/4O3Ry3gIOg4lwC6A6ax4u7+rOhLBo0q/4hKYimcX7OQN4/n+J/4CFf
         f/sTAHSFmECPhs3KKsBjkIbsO3g5sPAV9/0erYlm4XphWBlpbWxS8a6+uogMjEqhVX
         NFAzMnHBWqTgQ==
Date:   Thu, 15 Jun 2023 22:25:09 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Lucas Tanure <tanure@linux.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nick <nick@khadas.com>, Artem <art@khadas.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH 4/6] dt-bindings: serial: amlogic, meson-uart: support T7
Message-ID: <20230615-mushroom-numeric-3a4c03f2204b@spud>
References: <20230615182938.18487-1-tanure@linux.com>
 <20230615182938.18487-5-tanure@linux.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="9PPwfx0Ri3V89v+e"
Content-Disposition: inline
In-Reply-To: <20230615182938.18487-5-tanure@linux.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9PPwfx0Ri3V89v+e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 15, 2023 at 07:29:36PM +0100, Lucas Tanure wrote:
> Add serial bindings support menson T7 SoC family.
>=20
> Signed-off-by: Lucas Tanure <tanure@linux.com>
> ---
>  Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/serial/amlogic,meson-uart.=
yaml b/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
> index 01ec45b3b406..01b01f8840ea 100644
> --- a/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
> +++ b/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
> @@ -46,6 +46,7 @@ properties:
>            - amlogic,meson8b-uart
>            - amlogic,meson-gx-uart
>            - amlogic,meson-s4-uart
> +          - amlogic,meson-t7-uart

| diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_u=
art.c
| index 2501db5a7aaf..0208f9a6ba7e 100644
| --- a/drivers/tty/serial/meson_uart.c
| +++ b/drivers/tty/serial/meson_uart.c
| @@ -796,6 +796,10 @@ static const struct of_device_id meson_uart_dt_match=
[] =3D {
|                 .compatible =3D "amlogic,meson-s4-uart",
|                 .data =3D (void *)&meson_g12a_uart_data,
|         },
| +       {
| +               .compatible =3D "amlogic,meson-t7-uart",
| +               .data =3D (void *)&meson_g12a_uart_data,
| +       },
|         { /* sentinel */ },
|  };
|  MODULE_DEVICE_TABLE(of, meson_uart_dt_match);

You're adding another element to this enum, but the driver change
implies compatibility with the s4 uart. Should you not set this up with
fallback compatibles?

Cheers,
Conor.

>        - description: Everything-Else power domain UART controller on G12=
A SoCs
>          items:
>            - const: amlogic,meson-g12a-uart
> --
> 2.41.0
>=20

--9PPwfx0Ri3V89v+e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZIuBtQAKCRB4tDGHoIJi
0sHiAQDxClAxWU17Rv+IGrk8hN8JM+3GVl4CnDAYfxMkZkygFwD+PxzMGG5D/hOb
Zr3S3egxrhFO4FzDUeuZrAUorATL1wc=
=B/NH
-----END PGP SIGNATURE-----

--9PPwfx0Ri3V89v+e--
