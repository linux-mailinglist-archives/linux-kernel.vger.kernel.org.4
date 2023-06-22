Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D72D773A8D8
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 21:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231433AbjFVTPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 15:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjFVTO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 15:14:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CFF51BCC;
        Thu, 22 Jun 2023 12:14:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E4602618D3;
        Thu, 22 Jun 2023 19:14:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86F4EC433C8;
        Thu, 22 Jun 2023 19:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687461297;
        bh=4EW1Ml3YU0WnjIOVFscwVZgqX5mvKNaJ7fqog18xT1c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YrnHEgTeoXJnBrFFDgZ1T53J06iS1RnplxEV19yb9S8xCOmWYwsnVl1xa5GRKCo5s
         bzo+OCSOzHFiksI0AaJRhcGczb3AKDZwQhDunAw4N9SFv3pM3woUKSF9HycL+RfHu+
         lhq2W5xz3T67p3KfknWBd8EIiBr9DX9LWq6zd/NY1b+iU8RqfFxOSyoZ7my4Qu9d9Q
         5EFCYygwYJVp5TmexQ5lb7dLCaQnmk1TmkAswlaZplJqB+ZSfRuC6nLYNH3NNDFjri
         st4ImEIoZBHHlcinYQrGZUfIPemsJNsKqK2qtg3Wl08s/Garj/pOXI0ZM9liByvz23
         ozPapxMH8nhpg==
Date:   Thu, 22 Jun 2023 20:14:53 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     devicetree@vger.kernel.org, tglx@linutronix.de, maz@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: interrupt-controller: add Ralink SoCs
 interrupt controller
Message-ID: <20230622-algebra-superglue-40955b223774@spud>
References: <20230622110451.1504823-1-sergio.paracuellos@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="QXySfpWsCJAcdqLS"
Content-Disposition: inline
In-Reply-To: <20230622110451.1504823-1-sergio.paracuellos@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--QXySfpWsCJAcdqLS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 22, 2023 at 01:04:51PM +0200, Sergio Paracuellos wrote:
> Add YAML doc for the interrupt controller which is present on Ralink SoCs.
>=20
> Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> ---
> Changes in v2:
>  - Drop label from the example.
>=20
>  .../ralink,rt2880-intc.yaml                   | 54 +++++++++++++++++++
>  1 file changed, 54 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controlle=
r/ralink,rt2880-intc.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/ralin=
k,rt2880-intc.yaml b/Documentation/devicetree/bindings/interrupt-controller=
/ralink,rt2880-intc.yaml
> new file mode 100644
> index 000000000000..533d6d03aa75
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/ralink,rt288=
0-intc.yaml
> @@ -0,0 +1,54 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/interrupt-controller/ralink,rt2880-in=
tc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Ralink SoCs Interrupt Controller
> +
> +maintainers:
> +  - Sergio Paracuellos <sergio.paracuellos@gmail.com>
> +
> +allOf:
> +  - $ref: /schemas/interrupt-controller.yaml#
> +
> +description: |

FWIW, you don't need a | unless you have some formatting to preserve.

> +  This interrupt controller support a central point for interrupt aggreg=
ation
> +  for platform related blocks.
> +
> +properties:
> +  compatible:
> +    const: ralink,rt2880-intc
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  interrupt-controller: true
> +
> +  '#interrupt-cells':
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - interrupt-controller
> +  - '#interrupt-cells'
> +
> +unevaluatedProperties: false

You explicitly allow two properties from interrupt-controller.yaml, so
it seems like this should actually be additionalProperties: false to
block things like interrupt-map etc?

If your intention was only to allow interrupt-controller, with
s/unevaluated/additional/ you can add
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> +
> +examples:
> +  - |
> +    interrupt-controller@200 {
> +      compatible =3D "ralink,rt2880-intc";
> +      reg =3D <0x200 0x100>;
> +      interrupt-controller;
> +      #interrupt-cells =3D <1>;
> +
> +      interrupt-parent =3D <&cpuintc>;
> +      interrupts =3D <2>;
> +    };
> +...
> --=20
> 2.25.1
>=20

--QXySfpWsCJAcdqLS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZJSdrQAKCRB4tDGHoIJi
0uqDAQCcgFbS7S9oLnnfQqMN3+amaFefAoNne1acSsTviyeCJwD/TSQTo0ZuxjUK
2lewMQmES4YW/S7KigE/HufFPK5FGQ4=
=qUnP
-----END PGP SIGNATURE-----

--QXySfpWsCJAcdqLS--
