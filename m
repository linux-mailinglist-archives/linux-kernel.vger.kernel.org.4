Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B30746FB7D4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 21:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232792AbjEHT4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 15:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbjEHT4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 15:56:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99181449F;
        Mon,  8 May 2023 12:56:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 81B7864228;
        Mon,  8 May 2023 19:56:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E8E1C433D2;
        Mon,  8 May 2023 19:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683575771;
        bh=ltJDojvCNNaKUmHf67mg4itsVJG4A+kiE3jK368sh/g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JKqxt7yI/HwKC+CiPqt7/Ymw1In8Cfy8sUKQ/N7Y5GOPm5L2ABrTm9Dq1nq41eKmA
         AHTe3dJ4GZjFimrFv+fDk/u/+RUWcoT5MUOqKMxtEMUEGuTjd6fu/fgM5xxHQsYTJn
         2HGkpIohveBZGoI/TNxjP5JokEHzmUgSCY476/9BTTVAr9RXgcUrfl1qZ1808BRITo
         LoxutEU2zLJb5KwB1WD3QO6jkj4KXEimqgHysuWKLttqzvJQ7fBdVxFJspaZqRUdEY
         TOYjF1/9ux3HNq2T+/zI1zlbxNWr6xGoNzEPn1KGiSMEwlBi0eTJB8Bw8C8Cp/Zpy5
         bUNNKgVeYmjKQ==
Date:   Mon, 8 May 2023 20:56:07 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Stanislav Jakubek <stano.jakubek@gmail.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: mmc: brcm,kona-sdhci: convert to YAML
Message-ID: <20230508-earwig-prance-a2f25f23551d@spud>
References: <88c64da50a1af868d8b14054c440e5ff96a63399.1683548624.git.stano.jakubek@gmail.com>
 <a1fd4092b8a31c2ee58a3cd4cca062db13197b45.1683548624.git.stano.jakubek@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="LFCvaqCAlBvxkDQI"
Content-Disposition: inline
In-Reply-To: <a1fd4092b8a31c2ee58a3cd4cca062db13197b45.1683548624.git.stano.jakubek@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LFCvaqCAlBvxkDQI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 08, 2023 at 02:46:03PM +0200, Stanislav Jakubek wrote:
> Convert Broadcom Kona family SDHCI controller bindings to DT schema.
>=20
> Changes during conversion:
>   - also mark reg and interrupts as required
>   - drop deprecated compatible (it's been deprecated for ~10 years)
>=20
> Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> ---
>  .../bindings/mmc/brcm,kona-sdhci.txt          | 21 --------
>  .../bindings/mmc/brcm,kona-sdhci.yaml         | 48 +++++++++++++++++++
>  2 files changed, 48 insertions(+), 21 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mmc/brcm,kona-sdhci=
=2Etxt
>  create mode 100644 Documentation/devicetree/bindings/mmc/brcm,kona-sdhci=
=2Eyaml
>=20
> diff --git a/Documentation/devicetree/bindings/mmc/brcm,kona-sdhci.txt b/=
Documentation/devicetree/bindings/mmc/brcm,kona-sdhci.txt
> deleted file mode 100644
> index 7f5dd83f5bd9..000000000000
> --- a/Documentation/devicetree/bindings/mmc/brcm,kona-sdhci.txt
> +++ /dev/null
> @@ -1,21 +0,0 @@
> -Broadcom BCM281xx SDHCI
> -
> -This file documents differences between the core properties in mmc.txt
> -and the properties present in the bcm281xx SDHCI
> -
> -Required properties:
> -- compatible : Should be "brcm,kona-sdhci"
> -- DEPRECATED: compatible : Should be "bcm,kona-sdhci"
> -- clocks: phandle + clock specifier pair of the external clock
> -
> -Refer to clocks/clock-bindings.txt for generic clock consumer properties.
> -
> -Example:
> -
> -sdio2: sdio@3f1a0000 {
> -	compatible =3D "brcm,kona-sdhci";
> -	reg =3D <0x3f1a0000 0x10000>;
> -	clocks =3D <&sdio3_clk>;
> -	interrupts =3D <0x0 74 0x4>;
> -};
> -
> diff --git a/Documentation/devicetree/bindings/mmc/brcm,kona-sdhci.yaml b=
/Documentation/devicetree/bindings/mmc/brcm,kona-sdhci.yaml
> new file mode 100644
> index 000000000000..87711edf9b39
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/brcm,kona-sdhci.yaml
> @@ -0,0 +1,48 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mmc/brcm,kona-sdhci.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Broadcom Kona family SDHCI controller
> +
> +maintainers:
> +  - Florian Fainelli <f.fainelli@gmail.com>
> +
> +allOf:
> +  - $ref: sdhci-common.yaml#
> +
> +properties:
> +  compatible:
> +    const: brcm,kona-sdhci
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - interrupts
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include "dt-bindings/clock/bcm281xx.h"
> +
> +    mmc@3f1a0000 {
> +        compatible =3D "brcm,kona-sdhci";
> +        reg =3D <0x3f1a0000 0x10000>;
> +        clocks =3D <&master_ccu BCM281XX_MASTER_CCU_SDIO3>;
> +        interrupts =3D <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
> +    };
> +...
> --=20
> 2.25.1
>=20

--LFCvaqCAlBvxkDQI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZFlT1gAKCRB4tDGHoIJi
0vqAAP45AkL/hMblRuxYevWDGHld8fxiCLO3SJe5wWE2IV+U6AD/c/sI1OW2syKr
4Rfp9AR81dk0RssoLeVUOZi7tRpzQgM=
=crpY
-----END PGP SIGNATURE-----

--LFCvaqCAlBvxkDQI--
