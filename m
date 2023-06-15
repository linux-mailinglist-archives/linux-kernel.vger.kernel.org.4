Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 061037321D1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 23:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232438AbjFOVlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 17:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjFOVlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 17:41:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CE142965;
        Thu, 15 Jun 2023 14:41:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B69E862555;
        Thu, 15 Jun 2023 21:41:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 680E7C433C0;
        Thu, 15 Jun 2023 21:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686865281;
        bh=ibe6xPHLBcLxNFtNb0w+96phSH7k0kf3L48cjxxfkFY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e0DsSRYxVNw3RC4s5aTpwUo2nJhvKNEZFmLXH8b19eVJW1k1Fz/32x2WVOgdlpXT8
         7W7sj3rYFGLbD3ifXl2/PZiKoBx0fOZCS29Q7ds/I5AQx/WK3i0AlyWXzMJlZK+8MI
         E253E+5ha7pGNabPZBUziP65gTxRuc6M4isf5tK7IVWsP35m0RwPBQ60Am5EPaAsJT
         K6nKGrTmS67N0psBqQiAD+P73QjAOL+uPbb4nMqbtTVKuFgeD16+lXMBfodLNMSyf+
         GpLVohdnxH9869f5DU4RO29+WX/2OvWocx4sfmYLUKKoo5WkagcTdvyVvag8/5UZ0T
         AZXLnUchr4b0Q==
Date:   Thu, 15 Jun 2023 22:41:14 +0100
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
Subject: Re: [PATCH 2/6] dt-bindings: clock: Bindings for Meson T7 clock
 controller
Message-ID: <20230615-capable-implicit-90a8f0265616@spud>
References: <20230615182938.18487-1-tanure@linux.com>
 <20230615182938.18487-3-tanure@linux.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="NRQ6YkLfrJJ+BPCc"
Content-Disposition: inline
In-Reply-To: <20230615182938.18487-3-tanure@linux.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NRQ6YkLfrJJ+BPCc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Lucas,

On Thu, Jun 15, 2023 at 07:29:34PM +0100, Lucas Tanure wrote:
> Add documentation for T7 the clock controller.

Other than the bot's complaint, few comments for ya.

> Signed-off-by: Lucas Tanure <tanure@linux.com>
> ---
>  .../bindings/clock/amlogic,mesont7.yaml       |  69 +++
>  include/dt-bindings/clock/mesont7-clkc.h      | 487 ++++++++++++++++++
>  2 files changed, 556 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/amlogic,meson=
t7.yaml
>  create mode 100644 include/dt-bindings/clock/mesont7-clkc.h
>=20
> diff --git a/Documentation/devicetree/bindings/clock/amlogic,mesont7.yaml=
 b/Documentation/devicetree/bindings/clock/amlogic,mesont7.yaml
> new file mode 100644
> index 000000000000..18e7cca0c0e1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/amlogic,mesont7.yaml

The filename should match the compatible - please test the bindings,
dt_binding_check will complain.

> @@ -0,0 +1,69 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/amlogic,mesont7-clk.yaml#

and this should match the filename

> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Amlogic Meson T7 Clock Controller
> +
> +maintainers:
> +  - Lucas Tanure <tanure@linux.com>
> +
> +description: |
> +  The Amlogic Meson T7 clock controller generates and supplies clock to
> +  various peripherals within the SoC.
> +
> +  This binding uses common clock bindings
> +  [1] Documentation/devicetree/bindings/clock/clock-bindings.txt

This doesn't add anything as you're adding a yaml binding. I'd drop it
(and the | from description: since you would no longer have formatting
to preserve).

> +
> +properties:
> +  compatible:
> +    const: amlogic,t7-clkc
> +
> +  reg:
> +    items:
> +      - description: basic registers

What does "basic registers" mean? I think you should be more specific in
your description.

> +      - description: pll registers
> +      - description: cpu_clk registers
> +
> +  reg-names:
> +    items:
> +      - const: basic
> +      - const: pll
> +      - const: cpu_clk
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    const: xtal
> +
> +  '#clock-cells':
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - clocks
> +  - clock-names
> +  - '#clock-cells'
> +
> +additionalProperties: false
> +
> +examples:
> +  # Clock controller node:
> +  - |
> +    clkc: clock-controller {

The comment above and the node name here can be dropped.
You do however need to change "clock-controller" to
"clock-controller@<addr>".

> +        compatible =3D "amlogic,t7-clkc";
> +        #clock-cells =3D <1>;
> +        reg =3D <0x0 0x0000 0x00 0x49c>,
> +              <0x0 0x8000 0x00 0x320>,
> +              <0x0 0xe040 0x00 0x0bc>;

Drop the 0x0 stuff from here.

> +        reg-names =3D "basic", "pll", "cpu_clk";
> +        clocks =3D <&xtal>;
> +        clock-names =3D "xtal";
> +        status =3D "okay";

status can be dropped, okay is the default.

Cheers,
Conor.


--NRQ6YkLfrJJ+BPCc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZIuFegAKCRB4tDGHoIJi
0mUxAP9ShdlKESvS50Rnxb4CiIV85tEhZyQW1e3NkPLeyyz/4AD+K7Z6X+DakiwB
ZfTy2FkoldmsKqtK8Hiebfh+jTUmbwM=
=WfiC
-----END PGP SIGNATURE-----

--NRQ6YkLfrJJ+BPCc--
