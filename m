Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B089E70E143
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 18:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237658AbjEWQAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 12:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232553AbjEWQAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 12:00:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 703988E;
        Tue, 23 May 2023 09:00:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F28DF616E6;
        Tue, 23 May 2023 16:00:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CE9CC433EF;
        Tue, 23 May 2023 16:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684857609;
        bh=VhIJtH0CStctkYKs7h8Niqg9083/AhuT40hMxgVFyEU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tfNbmkYxuR7o0qDMfQM/KoyniSVjO+t2naa7G6EZbkHJr0W6Bf93K99i5JzyuWCe6
         JDwmDDoMgY5YlPgEDuRO+lCVu2Fh8FZU7dBQ85UGrUqmZQ8c4q2AZycUyShFET1k1/
         O8p2k3SFfCmPkccdiPN7zeJyreYaGLOR23AyUVLVNTW7jq7chQK014jOPqWwoedB6U
         E+0KCozfRUhvj96XpdAWPTgX2EeQr3dK28xhKf4k0MwYeKXLoaQ3fngiSPb5U7nOw2
         TEuy1CVaGimU8hjjTL1MgtV+BH4aeaek4TIPaDEnrPngjiKCp2epLzt6rFp27U0tc/
         ivH/oQ0mMGrFw==
Date:   Tue, 23 May 2023 17:00:04 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Mike Looijmans <mike.looijmans@topic.nl>
Cc:     devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        Puranjay Mohan <puranjay12@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: Add microchip MCP3561/2/4R
 devices
Message-ID: <20230523-panning-surplus-b9072e18905b@spud>
References: <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.5ebab164-53fc-4492-bb76-5cc2d7b3f4f0@emailsignatures365.codetwo.com>
 <20230523124354.24294-1-mike.looijmans@topic.nl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lH5VOB7Wy4hdAnbH"
Content-Disposition: inline
In-Reply-To: <20230523124354.24294-1-mike.looijmans@topic.nl>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lH5VOB7Wy4hdAnbH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 23, 2023 at 02:43:53PM +0200, Mike Looijmans wrote:
> The MCP3564R is a 24-bit ADC with 8 multiplexed inputs. The MCP3561R is
> the same device with 2 inputs, the MCP3562R has 4 inputs. The device
> contains one ADC and a multiplexer to select the inputs to the ADC.

My favourite - nothing for a while & then two come along almost at once!
https://lore.kernel.org/all/20230519160145.44208-2-marius.cristea@microchip=
=2Ecom/

Would you mind, since he seems to have sent it first, reviewing his
series?

Cheers,
Conor.

>=20
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
>=20
> ---
>=20
>  .../bindings/iio/adc/microchip,mcp356xr.yaml  | 84 +++++++++++++++++++
>  1 file changed, 84 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/microchip,m=
cp356xr.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/microchip,mcp356xr=
=2Eyaml b/Documentation/devicetree/bindings/iio/adc/microchip,mcp356xr.yaml
> new file mode 100644
> index 000000000000..4aef166894c8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/microchip,mcp356xr.yaml
> @@ -0,0 +1,84 @@
> +# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
> +# Copyright 2023 Topic Embedded Systems
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/microchip,mcp356xr.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Microchip MCP3561R/MCP3562R/MCP3564R ADC
> +
> +maintainers:
> +  - Mike Looijmans <mike.looijmans@topic.nl>
> +
> +description: |
> +  Bindings for the Microchip MCP356xR 8-channel ADC devices. Datasheet a=
nd info
> +  can be found at: https://www.microchip.com/en-us/product/MCP3564R
> +
> +properties:
> +  compatible:
> +    enum:
> +      - microchip,mcp3561r
> +      - microchip,mcp3562r
> +      - microchip,mcp3564r
> +
> +  reg:
> +    maxItems: 1
> +
> +  spi-max-frequency:
> +    maximum: 20000000
> +
> +  clocks:
> +    description:
> +      Phandle and clock identifier for external sampling clock.
> +      If not specified, the internal crystal oscillator will be used.
> +    maxItems: 1
> +
> +  interrupts:
> +    description: IRQ line of the ADC
> +    maxItems: 1
> +
> +  drive-open-drain:
> +    description:
> +      Whether to drive the IRQ signal as push-pull (default) or open-dra=
in. Note
> +      that the device requires this pin to become "high", otherwise it w=
ill stop
> +      converting.
> +    type: boolean
> +
> +  microchip,device-addr:
> +    description: Device address when multiple chips are present on the s=
ame bus.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [0, 1, 2, 3]
> +    default: 1
> +
> +  vref-supply:
> +    description:
> +      Phandle to the external reference voltage supply.
> +      If not specified, the internal voltage reference (2.4V) will be us=
ed.
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    spi {
> +      #address-cells =3D <1>;
> +      #size-cells =3D <0>;
> +
> +      adc@0 {
> +        compatible =3D "microchip,mcp3564r";
> +        reg =3D <0>;
> +        interrupt-parent =3D <&gpio5>;
> +        interrupts =3D <15 2>;
> +        spi-max-frequency =3D <20000000>;
> +        microchip,device-addr =3D <1>;
> +        vref-supply =3D <&vref_reg>;
> +        clocks =3D <&xtal>;
> +      };
> +    };
> --=20
> 2.17.1
>=20
>=20
> Met vriendelijke groet / kind regards,
>=20
> Mike Looijmans
> System Expert
>=20
>=20
> TOPIC Embedded Products B.V.
> Materiaalweg 4, 5681 RJ Best
> The Netherlands
>=20
> T: +31 (0) 499 33 69 69
> E: mike.looijmans@topicproducts.com
> W: www.topic.nl
>=20
> Please consider the environment before printing this e-mail

--lH5VOB7Wy4hdAnbH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZGzjBAAKCRB4tDGHoIJi
0iV2AQDcWs95wjcO2wlG324XTzADXysr6e0rPnVJmdp3Fx8crAD/Vnl0BMlqKwLU
dADamTFa0QYWAZmDdULH0DY7tQzEbQc=
=F8JU
-----END PGP SIGNATURE-----

--lH5VOB7Wy4hdAnbH--
