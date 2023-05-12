Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA41701167
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 23:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239906AbjELVfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 17:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239867AbjELVfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 17:35:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53EFE9ECA;
        Fri, 12 May 2023 14:35:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E49C361C11;
        Fri, 12 May 2023 21:35:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 011DCC433D2;
        Fri, 12 May 2023 21:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683927308;
        bh=ssPoigezhCRrDjg7mcA2KStxlVolfI3YMYndQSDR72E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rnWJ+EWH6NpSxhEi+rjIYtoO0FVqUzj+M2yz0JL6ra6laKLTgsewUkAJGF7WDI7db
         kAMtFsNX2vDmy63695efG66uBHWQLnMGPinOgtPVd4knXqdExsA3zrvoIoHRB9lb3N
         BZbZhqEV6/kl0ZSGozTekrAacngCLqYGsopfJKkPhpkK3k0l4lptSMdDGS1i0q7+9S
         mBVdrlmEhvFX8CPNgd3rLUSR8GlL+RyA/vXFDMydaftSdcXg+KMQHW/qjGqbgz+tz9
         uFBcTtAVC8QM0LM2G+BJxUJQlPEcJrlZmaEPJOxoR7zQtletlJG8vCQCsIyDpc7AeY
         HFIAh5kfx00+w==
Date:   Fri, 12 May 2023 22:35:01 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Nicolas Belin <nbelin@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-phy@lists.infradead.org
Subject: Re: [PATCH v4 04/13] dt-bindings: display: add Amlogic MIPI DSI Host
 Controller bindings
Message-ID: <20230512-elevation-stream-8acf60905d6b@spud>
References: <20230512-amlogic-v6-4-upstream-dsi-ccf-vim3-v4-0-2592c29ea263@linaro.org>
 <20230512-amlogic-v6-4-upstream-dsi-ccf-vim3-v4-4-2592c29ea263@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="s/aEe9Onk7m7s45t"
Content-Disposition: inline
In-Reply-To: <20230512-amlogic-v6-4-upstream-dsi-ccf-vim3-v4-4-2592c29ea263@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--s/aEe9Onk7m7s45t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 12, 2023 at 03:11:35PM +0200, Neil Armstrong wrote:
> The Amlogic G12A, G12B & SM1 SoCs embeds a Synopsys DW-MIPI-DSI transceiv=
er (ver 1.21a),
> with a custom glue managing the IP resets, clock and data input similar t=
o the DW-HDMI Glue
> on the same Amlogic SoCs.
>=20
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

This looks fine to me,
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
but I would like Krzysztof to take a look too to be on the safe side!

Cheers,
Conor.

> ---
>  .../display/amlogic,meson-g12a-dw-mipi-dsi.yaml    | 117 +++++++++++++++=
++++++
>  1 file changed, 117 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/display/amlogic,meson-g12a=
-dw-mipi-dsi.yaml b/Documentation/devicetree/bindings/display/amlogic,meson=
-g12a-dw-mipi-dsi.yaml
> new file mode 100644
> index 000000000000..8169c7e93ff5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/amlogic,meson-g12a-dw-mip=
i-dsi.yaml
> @@ -0,0 +1,117 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright 2020 BayLibre, SAS
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/amlogic,meson-g12a-dw-mipi-ds=
i.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Amlogic specific extensions to the Synopsys Designware MIPI DSI H=
ost Controller
> +
> +maintainers:
> +  - Neil Armstrong <neil.armstrong@linaro.org>
> +
> +description: |
> +  The Amlogic Meson Synopsys Designware Integration is composed of
> +  - A Synopsys DesignWare MIPI DSI Host Controller IP
> +  - A TOP control block controlling the Clocks & Resets of the IP
> +
> +allOf:
> +  - $ref: dsi-controller.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - amlogic,meson-g12a-dw-mipi-dsi
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    minItems: 3
> +
> +  clock-names:
> +    minItems: 3
> +    items:
> +      - const: pclk
> +      - const: bit_clk
> +      - const: px_clk
> +      - const: meas_clk
> +
> +  resets:
> +    minItems: 1
> +
> +  reset-names:
> +    items:
> +      - const: top
> +
> +  phys:
> +    minItems: 1
> +
> +  phy-names:
> +    items:
> +      - const: dphy
> +
> +  ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +
> +    properties:
> +      port@0:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description: Input node to receive pixel data.
> +
> +      port@1:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description: DSI output node to panel.
> +
> +    required:
> +      - port@0
> +      - port@1
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - resets
> +  - reset-names
> +  - phys
> +  - phy-names
> +  - ports
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    dsi@7000 {
> +          compatible =3D "amlogic,meson-g12a-dw-mipi-dsi";
> +          reg =3D <0x6000 0x400>;
> +          resets =3D <&reset_top>;
> +          reset-names =3D "top";
> +          clocks =3D <&clk_pclk>, <&bit_clk>, <&clk_px>;
> +          clock-names =3D "pclk", "bit_clk", "px_clk";
> +          phys =3D <&mipi_dphy>;
> +          phy-names =3D "dphy";
> +
> +          ports {
> +              #address-cells =3D <1>;
> +              #size-cells =3D <0>;
> +
> +              /* VPU VENC Input */
> +              mipi_dsi_venc_port: port@0 {
> +                  reg =3D <0>;
> +
> +                  mipi_dsi_in: endpoint {
> +                       remote-endpoint =3D <&dpi_out>;
> +                  };
> +              };
> +
> +              /* DSI Output */
> +              mipi_dsi_panel_port: port@1 {
> +                  reg =3D <1>;
> +
> +                  mipi_out_panel: endpoint {
> +                      remote-endpoint =3D <&mipi_in_panel>;
> +                  };
> +              };
> +          };
> +    };
>=20
> --=20
> 2.34.1
>=20

--s/aEe9Onk7m7s45t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZF6xBQAKCRB4tDGHoIJi
0lkLAP9aw2fomhWlSF6eQEZVTD8Xm33bApDDIK5TJfpd9yZupQD8DFLo/uqOZeTX
Sifp4pc02lgSSSXPXhf84CIoaGUoHAU=
=h7tW
-----END PGP SIGNATURE-----

--s/aEe9Onk7m7s45t--
