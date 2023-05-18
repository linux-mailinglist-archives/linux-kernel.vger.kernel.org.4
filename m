Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE36770885F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 21:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbjERTfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 15:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjERTfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 15:35:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A704CB5;
        Thu, 18 May 2023 12:34:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4494B6147B;
        Thu, 18 May 2023 19:34:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 566DAC433D2;
        Thu, 18 May 2023 19:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684438498;
        bh=7ujIWrAt84CAZqQbL29G5T7eA+bKtP7cAoWHbXBRRSA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KMQutcyQydYIMUy+S4sHDOHbFI3j3EoUAuB0fK97AryoNM3b2FTsoc0xFzqMB4OPw
         OhEDOzmqLZ+Rl4EHLUYB6geNVB2QAj9vaODRla6CGbujnpL9629f14msjWwjvoGbVb
         A9XwhsBdQmI34fbiR/TQ5SD0ZuK8F8XpTA3HPVhhVFqvkkXf1WrJhrpmukZT5U0DQe
         w5V9rY6TAvkqOjpUDupOXGC74qLFnUm6zrnlPnH44eHFegwsZyflWQkJFgonXSHrrH
         Jlro1LIyXFu60QWNyci6+URTT4xuHAkmO4AJFk8wvkn9ty0rgTuyT24aCNGHtnjw1U
         opZOZ5LleonIQ==
Date:   Thu, 18 May 2023 20:34:52 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: Re: [PATCH v4 03/10] dt-bindings: serial: add documentation for
 Bouffalolab UART Driver
Message-ID: <20230518-wish-duplicity-a280b19d9dcf@spud>
References: <20230518152244.2178-1-jszhang@kernel.org>
 <20230518152244.2178-4-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rVUuxQlCNvY2DQNY"
Content-Disposition: inline
In-Reply-To: <20230518152244.2178-4-jszhang@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rVUuxQlCNvY2DQNY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 18, 2023 at 11:22:37PM +0800, Jisheng Zhang wrote:
> Add bindings doc for Bouffalolab UART Driver
>=20
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

As I said previously, happy to grab the non-serial parts of the series
once Greg (or Jiri?) pick the serial bits.

Cheers,
Conor.

> ---
>  .../serial/bouffalolab,bl808-uart.yaml        | 47 +++++++++++++++++++
>  1 file changed, 47 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/serial/bouffalolab,=
bl808-uart.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/serial/bouffalolab,bl808-u=
art.yaml b/Documentation/devicetree/bindings/serial/bouffalolab,bl808-uart.=
yaml
> new file mode 100644
> index 000000000000..0ef858e50efb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/serial/bouffalolab,bl808-uart.yaml
> @@ -0,0 +1,47 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) 2022 Jisheng Zhang <jszhang@kernel.org>
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/serial/bouffalolab,bl808-uart.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Bouffalolab UART Controller
> +
> +maintainers:
> +  - Jisheng Zhang <jszhang@kernel.org>
> +
> +allOf:
> +  - $ref: serial.yaml#
> +
> +properties:
> +  compatible:
> +    const: bouffalolab,bl808-uart
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    uart0: serial@30002000 {
> +        compatible =3D "bouffalolab,bl808-uart";
> +        reg =3D <0x30002000 0x1000>;
> +        interrupts =3D <53 IRQ_TYPE_LEVEL_HIGH>;
> +        clocks =3D <&xtal>;
> +    };
> +...
> --=20
> 2.40.0
>=20

--rVUuxQlCNvY2DQNY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZGZ93AAKCRB4tDGHoIJi
0teFAP46CSNElMa0c7OcjRrJ/GQ7TOxHpbogOcpZFdwwTXKeNgEAzNPSSkAc4/dK
dd5WbA7VZXyjq0zpoa8VCbEssGLkTQY=
=T+6e
-----END PGP SIGNATURE-----

--rVUuxQlCNvY2DQNY--
