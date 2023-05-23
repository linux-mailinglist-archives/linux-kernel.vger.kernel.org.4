Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7720070E4A8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 20:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237773AbjEWS1s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 14:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbjEWS1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 14:27:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 513588F;
        Tue, 23 May 2023 11:27:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE7AA63129;
        Tue, 23 May 2023 18:27:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09CE4C433D2;
        Tue, 23 May 2023 18:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684866463;
        bh=XV1di+GuMw6Q1zA3mSrPZ/CUWvlb3FRyCbsgPWVNna0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YPRehp6m7et84NL7upNyUgSgsV0Otf/IW4DYgi+uj86CCGHKSh9N1ag1GDWBZKe69
         exMmwtptERAaVcSoz6SmZct4GjjU8Sb4FpWgb6aybfHjub21yq/YUw2G+QW6sEusd3
         xMIejEOfewleK5nFmXdrru6GGc6IJWNLrIznndHFDiY1/Rr4HxqOeSTykw/VVqFuJE
         e8fpmKGhos7AP3Qpwx6JxOyA7bui0MvTLAFfmsTw5PT9yYRCBVdPh1urLomtCxmCgY
         VgbmOQVQJ8lR5xJULK/qnjWyFUwojMok/hWzmFhcnKjGO1nd39Qw1wZsTW4ypGd1gt
         SuPOUEuXzUnhg==
Date:   Tue, 23 May 2023 19:27:38 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor.dooley@microchip.com, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, sre@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/4] dt-bindings: power: reset: atmel,at91sam9260-shdwc:
 convert to yaml
Message-ID: <20230523-depletion-petty-978775d05b22@spud>
References: <20230523061512.195271-1-claudiu.beznea@microchip.com>
 <20230523061512.195271-3-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4QfNIu1KVbjjpExj"
Content-Disposition: inline
In-Reply-To: <20230523061512.195271-3-claudiu.beznea@microchip.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4QfNIu1KVbjjpExj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Claudiu,

On Tue, May 23, 2023 at 09:15:10AM +0300, Claudiu Beznea wrote:
> Convert Atmel shutdown controller to YAML.
>=20
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>

> diff --git a/Documentation/devicetree/bindings/power/reset/atmel,at91sam9=
260-shdwc.yaml b/Documentation/devicetree/bindings/power/reset/atmel,at91sa=
m9260-shdwc.yaml
> new file mode 100644
> index 000000000000..3b3162677db3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/reset/atmel,at91sam9260-shd=
wc.yaml
> @@ -0,0 +1,81 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)

I think you'll need an explict Ack from Rob as the text binding has no
licence text.

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/power/reset/atmel,at91sam9260-shdwc.y=
aml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Atmel SHDWC Shutdown Controller
> +
> +maintainers:
> +  - Claudiu Beznea <claudiu.beznea@microchip.com>
> +
> +description: |
> +  Atmel SHDWC shutdown controller controls the power supplies VDDIO and =
VDDCORE
> +  and the wake-up detection on debounced input lines.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - atmel,at91sam9260-shdwc
> +      - atmel,at91sam9rl-shdwc
> +      - atmel,at91sam9x5-shdwc

For my own curiosity, is this x a wildcard or part of the product name?
Quick google was slightly confusing.

> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  atmel,wakeup-mode:
> +    description: operation mode of the wakeup mode
> +    $ref: /schemas/types.yaml#/definitions/string
> +    enum: [ none, high, low, any ]
> +
> +  atmel,wakeup-counter:
> +    description: counter on wake-up 0
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 ]

This can just be
minimum: 0
maximum: 15
I think.

Otherwise, looks good to me.

Thanks,
Conor.

--4QfNIu1KVbjjpExj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZG0FmgAKCRB4tDGHoIJi
0inzAQCWkwG07Dt5F/OF9pU6MN9adj6hqLi8AuPEL69yois7BgEAgUyZ4xlAfRoK
YwYAEd3JvLpw9MU9HQPwhBmOSGXHRgw=
=+W2q
-----END PGP SIGNATURE-----

--4QfNIu1KVbjjpExj--
