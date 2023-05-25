Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F27457111CD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 19:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240793AbjEYRPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 13:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233441AbjEYRPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 13:15:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F99219C;
        Thu, 25 May 2023 10:15:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0AAFE647AC;
        Thu, 25 May 2023 17:15:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61CDBC433EF;
        Thu, 25 May 2023 17:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685034949;
        bh=TXjQCnAa5THzyIrwuNbT4Dh/meMvaMaqsvTb26bbuzI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B5eR9BgPKenKGqomZZBwCcCY5t43JkAdu/9kaqNRakcPH6DNU7PBd4KV7W1mUlwya
         nLJcFkY1rAyJThZ6XEWDKUI0bgZNDr4Fzger9xEWLC0CEJR+5KVO6AloJq1LuWrVHe
         VnaL4btQZ9mBS/YcuxkPQoSj1WYpcf+jjl3Etgh+YZICHOILgOCnhnjD7TstVboNcl
         E/UW8Aw7Ly/n0ZQ0EwesPlIsevT4nEClXCQFDJOrZawlDsSGpFsfz0OlCgiapjzXXH
         L02ioiaXvLrUJ0jZs5rLzWCCs/WOBqsVnf1OIFiuYW9LQX42dxLrV5+CTqvP4ZWhS2
         99zRuI+5yA8Yw==
Date:   Thu, 25 May 2023 18:15:43 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>, y@spud
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, daniel.lezcano@linaro.org,
        tglx@linutronix.de, wim@linux-watchdog.org, linux@roeck-us.net,
        sebastian.reichel@collabora.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 4/5] dt-bindings: watchdog: atmel,at91rm9200-wdt: convert
 to yaml
Message-ID: <20230525-union-camping-ceb65a7edc4c@spud>
References: <20230525125602.640855-1-claudiu.beznea@microchip.com>
 <20230525125602.640855-5-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3mPePxdRmSeXHm4M"
Content-Disposition: inline
In-Reply-To: <20230525125602.640855-5-claudiu.beznea@microchip.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3mPePxdRmSeXHm4M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 25, 2023 at 03:56:01PM +0300, Claudiu Beznea wrote:
> Convert Atmel AT91RM9200 system timer watchdog bindings to YAML.
>=20
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  .../watchdog/atmel,at91rm9200-wdt.yaml        | 29 +++++++++++++++++++
>  .../watchdog/atmel-at91rm9200-wdt.txt         |  9 ------
>  2 files changed, 29 insertions(+), 9 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/atmel,at91=
rm9200-wdt.yaml
>  delete mode 100644 Documentation/devicetree/bindings/watchdog/atmel-at91=
rm9200-wdt.txt
>=20
> diff --git a/Documentation/devicetree/bindings/watchdog/atmel,at91rm9200-=
wdt.yaml b/Documentation/devicetree/bindings/watchdog/atmel,at91rm9200-wdt.=
yaml
> new file mode 100644
> index 000000000000..d05cdf15dc1c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/atmel,at91rm9200-wdt.yaml
> @@ -0,0 +1,29 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/watchdog/atmel,at91rm9200-wdt.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Atmel AT91RM9200 System Timer Watchdog
> +
> +maintainers:
> +  - Nicolas Ferre <nicolas.ferre@microchip.com>
> +  - Alexandre Belloni <alexandre.belloni@bootlin.com>
> +  - Claudiu Beznea <claudiu.beznea@microchip.coam>
> +
> +properties:
> +  compatible:
> +    const: atmel,at91rm9200-wdt
> +
> +required:
> +  - compatible
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    watchdog {
> +        compatible =3D "atmel,at91rm9200-wdt";
> +    }

This example is broken, you missed copying the ;

Thanks,
Conor.

> +
> +...
> diff --git a/Documentation/devicetree/bindings/watchdog/atmel-at91rm9200-=
wdt.txt b/Documentation/devicetree/bindings/watchdog/atmel-at91rm9200-wdt.t=
xt
> deleted file mode 100644
> index d4d86cf8f9eb..000000000000
> --- a/Documentation/devicetree/bindings/watchdog/atmel-at91rm9200-wdt.txt
> +++ /dev/null
> @@ -1,9 +0,0 @@
> -Atmel AT91RM9200 System Timer Watchdog
> -
> -Required properties:
> -- compatible: must be "atmel,at91sam9260-wdt".
> -
> -Example:
> -	watchdog@fffffd00 {
> -		compatible =3D "atmel,at91rm9200-wdt";
> -	};
> --=20
> 2.34.1
>=20

--3mPePxdRmSeXHm4M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZG+XvwAKCRB4tDGHoIJi
0m3yAQCPkatqkx00U98+bRNZhMThHa+pW4rc5LIOS2Dy25zAqgEA9ZW8F0jNB+dl
2tCAK1FKZoK+u11mnITqEPloSinnjQk=
=Rk6Q
-----END PGP SIGNATURE-----

--3mPePxdRmSeXHm4M--
