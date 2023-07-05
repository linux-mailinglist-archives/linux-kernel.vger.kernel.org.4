Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D835E748F93
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 23:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231891AbjGEVKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 17:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231598AbjGEVKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 17:10:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0124319A6;
        Wed,  5 Jul 2023 14:10:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9221A6173D;
        Wed,  5 Jul 2023 21:10:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CBA8C433C7;
        Wed,  5 Jul 2023 21:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688591433;
        bh=n2jgw51oOqSn4DZGTFd2enJxejq0SGh6zPoLj4QBa2A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r4YRd/P4b0xBGtl+HKyhU0UwFhwL1znKUu3F9E/nnPxXcYaDmYZo2z1Nee7kETmLx
         lGb4g3mmhsHL5MqjFkUdAPbHJx3Vu1KEL7DPyec0LVnxz1zWd0gjZ5J1S8Q17n3r+C
         zE9O2UqHY2qkWg1Tud8EzTY3sjFHZveAJE73dGQY7tug9JNpqnAeQ2bhK3ab7TZBKI
         8+QgfmFjLOjzsbMdrPvxU0Xd5i0hVTch+cCiezXQz87sYjjxA9jurKoJiBpj+M/vmx
         uAac8ugCdS/BiumCWdgDAvpq+AWbs+EmJMTUZXQQAvU5o8EDIaRETl9iMIuNLhm4wa
         0opmVGwVy9bYw==
Date:   Wed, 5 Jul 2023 22:10:27 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Dmitry Rokosov <ddrokosov@sberdevices.ru>
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        neil.armstrong@linaro.org, jbrunet@baylibre.com,
        jirislaby@kernel.org, khilman@baylibre.com,
        martin.blumenstingl@googlemail.com, kelvin.zhang@amlogic.com,
        xianwei.zhao@amlogic.com, kernel@sberdevices.ru,
        rockosov@gmail.com, linux-amlogic@lists.infradead.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 6/7] dt-bindings: serial: amlogic,meson-uart: support
 Amlogic A1
Message-ID: <20230705-broadly-hyphen-de6a1eb0058b@spud>
References: <20230705181833.16137-1-ddrokosov@sberdevices.ru>
 <20230705181833.16137-7-ddrokosov@sberdevices.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="NUg9anPJgPseBrgZ"
Content-Disposition: inline
In-Reply-To: <20230705181833.16137-7-ddrokosov@sberdevices.ru>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NUg9anPJgPseBrgZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 05, 2023 at 09:18:32PM +0300, Dmitry Rokosov wrote:
> Introduce meson uart serial bindings for A1 SoC family.
>=20
> Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>

Looks like there's a missing Ack here from Rob:
https://lore.kernel.org/all/168858360022.1592604.9922710628917242811.robh@k=
ernel.org/

Cheers,
Conor.

> ---
>  .../devicetree/bindings/serial/amlogic,meson-uart.yaml          | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/serial/amlogic,meson-uart.=
yaml b/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
> index 01ec45b3b406..f1ae8c4934d9 100644
> --- a/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
> +++ b/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
> @@ -33,6 +33,7 @@ properties:
>                - amlogic,meson8b-uart
>                - amlogic,meson-gx-uart
>                - amlogic,meson-s4-uart
> +              - amlogic,meson-a1-uart
>            - const: amlogic,meson-ao-uart
>        - description: Always-on power domain UART controller on G12A SoCs
>          items:
> @@ -46,6 +47,7 @@ properties:
>            - amlogic,meson8b-uart
>            - amlogic,meson-gx-uart
>            - amlogic,meson-s4-uart
> +          - amlogic,meson-a1-uart
>        - description: Everything-Else power domain UART controller on G12=
A SoCs
>          items:
>            - const: amlogic,meson-g12a-uart
> --=20
> 2.36.0
>=20

--NUg9anPJgPseBrgZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZKXcQwAKCRB4tDGHoIJi
0kUgAQDA95EfCnFuUU2bDSw86Ab1mLQG0Nbq74Hh2Ss1+NO5ZgD/Uk4aj8bCi0rC
8PY85RrvoNH02RyBYPrxMpLdfi1bUgE=
=igVN
-----END PGP SIGNATURE-----

--NUg9anPJgPseBrgZ--
