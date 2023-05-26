Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C560712CC8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 20:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242730AbjEZSrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 14:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbjEZSrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 14:47:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B24D912A;
        Fri, 26 May 2023 11:47:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 45E636529B;
        Fri, 26 May 2023 18:47:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0B59C433D2;
        Fri, 26 May 2023 18:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685126837;
        bh=KVm/h7/hQejLAPfbXJ0XNl6nVho+GiUZ5mBW9zeA4JM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FZ2g8yrvQf7mM1/oXZVaJJ9fdV8N06kJJb1K+Y+CWDT0gJSCfbiUC+xQJljkdlzBs
         dDwPaFexqYfItJo7/U4WfeFuL1FUIr5sOln2lLOSiCL/MC7BK7bnYjRU+48W63P/kM
         XSz6Otrx6RV/Ftr7TYp/HE/IbyQQKszmCJwQAnL4otIOIPbYGeLPIM0K7GT4D/nWdJ
         IH06nhz9fmUfboZjmS7hObQRWuYloPW6VZoomHVI8O1wc80OMH+muUXpqGHSYAVUfK
         BeDGE1mFwZgVTuAD9gK3aGYn2udlAR1xfgdCTaRXygqEhZFN/kT3WeMltfkBZAs1VW
         gVR3UjO16FSmg==
Date:   Fri, 26 May 2023 19:47:13 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Mike Looijmans <mike.looijmans@topic.nl>
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: clock: Add nvmem-clock
Message-ID: <20230526-wok-thwarting-90b7170d9e99@spud>
References: <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.2167d5ad-7e99-4eb9-a313-030fc7a7d546@emailsignatures365.codetwo.com>
 <20230526143807.10164-1-mike.looijmans@topic.nl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="XcYMVmXJ/sJCP8Sh"
Content-Disposition: inline
In-Reply-To: <20230526143807.10164-1-mike.looijmans@topic.nl>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XcYMVmXJ/sJCP8Sh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Mike,

I have no comments about whether this is a good idea or not, I'll leave
that Stephen, Krzysztof etc..

On Fri, May 26, 2023 at 04:38:06PM +0200, Mike Looijmans wrote:
> Add bindings for a fixed-rate clock that retrieves its rate from an
> NVMEM provider. This allows to store clock settings in EEPROM or EFUSE
> or similar device.
>=20
> Component shortages lead to boards being shipped with different clock
> crystals, based on what was available at the time. The clock frequency
> was written to EEPROM at production time. Systems can adapt to a wide
> range of input frequencies using the clock framework, but this required
> us to patch the devicetree at runtime or use some custom driver. This
> provides a more generic solution.
>=20
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
>=20
> ---
>=20
> Changes in v2:
> Changed "fixed-clock" into "nvmem-clock" in dts example
> Add minItems:1 to nvmem-cell-names
>=20
>  .../bindings/clock/nvmem-clock.yaml           | 63 +++++++++++++++++++
>  1 file changed, 63 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/nvmem-clock.y=
aml
>=20
> diff --git a/Documentation/devicetree/bindings/clock/nvmem-clock.yaml b/D=
ocumentation/devicetree/bindings/clock/nvmem-clock.yaml
> new file mode 100644
> index 000000000000..af96a5e9372d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/nvmem-clock.yaml
> @@ -0,0 +1,63 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/nvmem-clock.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Simple fixed-rate clock source from NVMEM
> +
> +maintainers:
> +  - Mike Looijmans <mike.looijmans@topic.nl>
> +
> +description:
> +  Provides a clock rate from NVMEM. Typical usage is that the factory pl=
aces a
> +  crystal on the board and writes the rate into an EEPROM or EFUSE. If s=
ome math
> +  is required, one can add a fixed-factor clock using this clock as inpu=
t.
> +
> +properties:
> +  compatible:
> +    const: nvmem-clock
> +
> +  "#clock-cells":
> +    const: 0
> +
> +  nvmem-cells:
> +    minItems: 1
> +    maxItems: 2
> +    description:
> +      Reads clock-frequency and optionally clock-accuracy from an NVMEM =
provider
> +      in binary native integer format. The size of the NVMEM cell can be=
 1, 2, 4
> +      or 8 bytes.

How is that size communicated to the driver? Some nvmem magic just takes
care of it?

> +
> +  nvmem-cell-names:
> +    minItems: 1
> +    items:
> +      - const: clock-frequency
> +      - const: clock-accuracy
> +
> +  clock-accuracy:

I think the common pattern is to add a unit suffix for things like
this, which I guess would be -ppb?

Cheers,
Conor.

> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      accuracy of clock in ppb (parts per billion). Alternative for prov=
iding
> +      this through nvmem, the nvmem provided value takes precedence.
> +
> +  clock-output-names:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - "#clock-cells"
> +  - nvmem-cells
> +  - nvmem-cell-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    xtal {
> +      compatible =3D "nvmem-clock";
> +      #clock-cells =3D <0>;
> +      nvmem-cells =3D <&efuse_xtal_freq>;
> +      nvmem-cell-names =3D "clock-frequency";
> +    };
> +...
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

--XcYMVmXJ/sJCP8Sh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZHD+sQAKCRB4tDGHoIJi
0gXlAP9tM6VZjMbCk7uDsxgVhuxkssWXoWpS9GExKxdhR2SuNAEA+ZWMC6Qu2G9A
ilC37CZ8ryNiVLmlQXyADnGi4Q0wIQU=
=ix/J
-----END PGP SIGNATURE-----

--XcYMVmXJ/sJCP8Sh--
