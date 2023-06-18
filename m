Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 268B77347F2
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 21:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbjFRTSN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 15:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjFRTSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 15:18:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68078FC;
        Sun, 18 Jun 2023 12:18:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ED67E60C91;
        Sun, 18 Jun 2023 19:18:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF233C433C8;
        Sun, 18 Jun 2023 19:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687115890;
        bh=/vS2RnSOJk0DnospOK4BfOYwwbxR6nlM/Q7dvGK/FTQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jZFv52WuCzEwuk4QP8lx6cwSDc7mFFmDfvm5z5jr32GHXC0EnkI1AiW5A67RhchT2
         bEKKFKdX+wys/vD/MVI9c5CPUHKQSwjFexot7zNQ3aC34wSVbXsUpqU+fNBL1VcQmf
         +omPHhTF1BQNJfR746/ZpPUX3AtzVRo9hRfnQ0kvJa+NOJyyH8cXS8KNuyG8I6CMQw
         lOcBuxVGanIn5qh91fR6Issb7i5mRLmOLjQMJW9Lb4BI2OR5aI/nRbwg33zRPDa1g6
         DepmsnuXaXlAtjh9jTDR9y3ZyzuY9R6eznGecH9j5zFFAC6nUv3x5M+zGNGibaX2xH
         lgQVFyALfxoYw==
Date:   Sun, 18 Jun 2023 20:18:04 +0100
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
Message-ID: <20230618-ammonium-scratch-2990eb8c3ac7@spud>
References: <20230615182938.18487-1-tanure@linux.com>
 <20230615182938.18487-5-tanure@linux.com>
 <20230615-mushroom-numeric-3a4c03f2204b@spud>
 <CAJX_Q+2ND=GJEEXdLLpEWoecN5gtZm-1i92pAgi+eQocSRUVqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gLIFy3noUErwq6fk"
Content-Disposition: inline
In-Reply-To: <CAJX_Q+2ND=GJEEXdLLpEWoecN5gtZm-1i92pAgi+eQocSRUVqw@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gLIFy3noUErwq6fk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 18, 2023 at 06:37:40PM +0100, Lucas Tanure wrote:
> On Thu, Jun 15, 2023 at 10:25=E2=80=AFPM Conor Dooley <conor@kernel.org> =
wrote:
> >
> > On Thu, Jun 15, 2023 at 07:29:36PM +0100, Lucas Tanure wrote:
> > > Add serial bindings support menson T7 SoC family.
> > >
> > > Signed-off-by: Lucas Tanure <tanure@linux.com>
> > > ---
> > >  Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml | 1=
 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/serial/amlogic,meson-u=
art.yaml b/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
> > > index 01ec45b3b406..01b01f8840ea 100644
> > > --- a/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
> > > +++ b/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
> > > @@ -46,6 +46,7 @@ properties:
> > >            - amlogic,meson8b-uart
> > >            - amlogic,meson-gx-uart
> > >            - amlogic,meson-s4-uart
> > > +          - amlogic,meson-t7-uart
> >
> > | diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/mes=
on_uart.c
> > | index 2501db5a7aaf..0208f9a6ba7e 100644
> > | --- a/drivers/tty/serial/meson_uart.c
> > | +++ b/drivers/tty/serial/meson_uart.c
> > | @@ -796,6 +796,10 @@ static const struct of_device_id meson_uart_dt_m=
atch[] =3D {
> > |                 .compatible =3D "amlogic,meson-s4-uart",
> > |                 .data =3D (void *)&meson_g12a_uart_data,
> > |         },
> > | +       {
> > | +               .compatible =3D "amlogic,meson-t7-uart",
> > | +               .data =3D (void *)&meson_g12a_uart_data,
> > | +       },
> > |         { /* sentinel */ },
> > |  };
> > |  MODULE_DEVICE_TABLE(of, meson_uart_dt_match);
> >
> > You're adding another element to this enum, but the driver change
> > implies compatibility with the s4 uart. Should you not set this up with
> > fallback compatibles?
>=20
> I will drop this patch and use the s4 and g12a compatible strings.

You still need to add a compatible for the t7, just let it fall back to
one of the others. Eg:
compatible =3D "amlogic,meson-t7-uart", "amlogic,meson-s4-uart";

Cheers,
Conor.

--gLIFy3noUErwq6fk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZI9YbAAKCRB4tDGHoIJi
0pSJAP4pCeRXWnB2Azet+8vaCW46xvhOyL8mjbZXG+XvzEZAEwD/TE2Nc5oOrKfm
tgEfqnMjGs3egm4P1F5l0K+qluDHmgM=
=1dUJ
-----END PGP SIGNATURE-----

--gLIFy3noUErwq6fk--
