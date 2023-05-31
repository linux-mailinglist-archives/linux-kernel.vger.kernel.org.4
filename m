Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AABD6718002
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 14:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235809AbjEaMfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 08:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235403AbjEaMfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 08:35:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF3A8E;
        Wed, 31 May 2023 05:35:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6050063030;
        Wed, 31 May 2023 12:35:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1740C4339E;
        Wed, 31 May 2023 12:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685536513;
        bh=yuATc0ewpjoNkponZyfQ6nxQCdgMjgGjVPMha1ccK5o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BE5M3bXVySZN4XBI7InXHGgsRr+/vX8+uyevGhLaMHsvzFl0OP+np7347BMSm3/PW
         U6nEdPtTyyg/nbk0loD54Fdg8LVFAvMY9TtowZFw0+XM1SmiCKGYtUk+JMK7ujL1Gl
         Q1hbP80hFOr7B9LHX9X/Z6Y2W6Y/6Yl+Jzks1pdbAis+ZPSZkUn/7JhpgTwZZ7Kf25
         K/IRhJvfPiU6+YWpirDBBizqxv4egoG8r36hBf88SxzDNklyYt9YvykBSZ62zkNmTG
         xG+4Erdnrx+bYTxd9rt0r/o+vjyoImE2xhcWbwUATckXRC6wb2gxoSjGGInfYTUPaw
         epLzsz/BJcT+g==
Date:   Wed, 31 May 2023 13:35:08 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, linux-mtd@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, enachman@marvell.com,
        Vadym Kochan <vadym.kochan@plvision.eu>
Subject: Re: [PATCH v7 3/4] dt-bindings: mtd: marvell-nand: Convert to YAML
 DT scheme
Message-ID: <20230531-botanical-swoosh-05683af1d3f0@spud>
References: <20230530235456.1009082-1-chris.packham@alliedtelesis.co.nz>
 <20230530235456.1009082-4-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="YdeHVyof/+8Ux7qZ"
Content-Disposition: inline
In-Reply-To: <20230530235456.1009082-4-chris.packham@alliedtelesis.co.nz>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YdeHVyof/+8Ux7qZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Chris,

On Wed, May 31, 2023 at 11:54:55AM +1200, Chris Packham wrote:
> From: Vadym Kochan <vadym.kochan@plvision.eu>
>=20
> Switch the DT binding to a YAML schema to enable the DT validation.
>=20
> Dropped deprecated compatibles and properties described in txt file.
>=20
> Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
>=20
> Notes:
>     Changes in v7:
>     - Restore "label" and "partitions" properties (should be picked up via
>       nand-controller.yaml but aren't)
>     - Add/restore nand-on-flash-bbt and nand-ecc-mode which aren't covered
>       by nand-controller.yaml.
>     - Use "unevalautedProperties: false"
>     - Corrections for clock-names, dma-names, nand-rb and nand-ecc-streng=
th
>     - Add pxa3xx-nand-controller example
>    =20
>     Changes in v6:
>     - remove properties covered by nand-controller.yaml
>     - add example using armada-8k compatible
>    =20
>     earlier changes:
>    =20
>     v5:
>        1) Get back "label" and "partitions" properties but without
>           ref to the "partition.yaml" which was wrongly used.
>    =20
>        2) Add "additionalProperties: false" for nand@ because all possible
>           properties are described.
>    =20
>     v4:
>        1) Remove "label" and "partitions" properties
>    =20
>        2) Use 2 clocks for A7K/8K platform which is a requirement
>    =20
>     v3:
>       1) Remove txt version from the MAINTAINERS list
>    =20
>       2) Use enum for some of compatible strings
>    =20
>       3) Drop:
>             #address-cells
>             #size-cells:
>    =20
>          as they are inherited from the nand-controller.yaml
>    =20
>       4) Add restriction to use 2 clocks for A8K SoC
>    =20
>       5) Dropped description for clock-names and extend it with
>          minItems: 1
>    =20
>       6) Drop description for "dmas"
>    =20
>       7) Use "unevalautedProperties: false"
>    =20
>       8) Drop quites from yaml refs.
>    =20
>       9) Use 4-space indentation for the example section
>    =20
>     v2:
>       1) Fixed warning by yamllint with incorrect indentation for compati=
ble list
>=20
>  .../bindings/mtd/marvell,nand-controller.yaml | 221 ++++++++++++++++++
>  .../devicetree/bindings/mtd/marvell-nand.txt  | 126 ----------
>  MAINTAINERS                                   |   1 -
>  3 files changed, 221 insertions(+), 127 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mtd/marvell,nand-co=
ntroller.yaml
>  delete mode 100644 Documentation/devicetree/bindings/mtd/marvell-nand.txt
>=20
> diff --git a/Documentation/devicetree/bindings/mtd/marvell,nand-controlle=
r.yaml b/Documentation/devicetree/bindings/mtd/marvell,nand-controller.yaml
> new file mode 100644
> index 000000000000..7cd4a2e99343
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mtd/marvell,nand-controller.yaml
> @@ -0,0 +1,221 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mtd/marvell,nand-controller.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Marvell NAND Flash Controller (NFC)
> +
> +maintainers:
> +  - Miquel Raynal <miquel.raynal@bootlin.com>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - const: marvell,armada-8k-nand-controller
> +          - const: marvell,armada370-nand-controller

Apologies if I have missed this - but the commit message should probably
explain where this fallback came from since it does not appear to be
present in the original binding.

> +      - enum:
> +          - marvell,armada370-nand-controller
> +          - marvell,pxa3xx-nand-controller

> +          - marvell,armada-8k-nand
> +          - marvell,armada370-nand
> +          - marvell,pxa3xx-nand

Please mark these 3 as deprecated.

> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    description:
> +      Shall reference the NAND controller clocks, the second one is
> +      is only needed for the Armada 7K/8K SoCs

As a nit, allOf below invalidates this second part of the sentence (in
possibly a clearer way too).

> +    minItems: 1
> +    maxItems: 2
> +
> +  clock-names:
> +    minItems: 1
> +    items:
> +      - const: core
> +      - const: reg
> +
> +  dmas:
> +    maxItems: 1
> +
> +  dma-names:
> +    items:
> +      - enum:

I don't think the items: here is needed, enum on its own suffices, no?

Cheers,
Conor.

--YdeHVyof/+8Ux7qZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZHc+6wAKCRB4tDGHoIJi
0uyhAQDKKUynMOe4ocCMIjqXxFF5IJ80y0JmIzHnljlbls4TAgD9E0fd+PguTVQu
cNOwu/6pc/nngrCtlryA4l55i5qpEQc=
=fT3C
-----END PGP SIGNATURE-----

--YdeHVyof/+8Ux7qZ--
