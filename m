Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE83B741733
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 19:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231892AbjF1R2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 13:28:42 -0400
Received: from dfw.source.kernel.org ([139.178.84.217]:43116 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbjF1R1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 13:27:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE7886141D;
        Wed, 28 Jun 2023 17:27:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A4E5C433C8;
        Wed, 28 Jun 2023 17:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687973256;
        bh=F0PybSEQg3oGD0oV9xIryADKGMGVcc7224PKlDe1/K4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OsEgIy0JwjVpU/mf7fw0rJ7mr+bBZglsYTZdbf8Dn4JnhFnNOfIYLU+hA2LvICmyA
         lbjO6oUAEmzFzxKcnasoNxL9iOPO8Rh8t+dRQCrDckMUzPjN8mr/1y3eEffWaX7kqZ
         rLpVnZOl4+btvjWEsh1AyhVwI92R2NCuIeEsOEizLnzegfQNqOESqhsWn2E+q+AG6Y
         uRVh0DGL/D7Qa6n9QZPt8ZX41A47uykMP6noohpzhbSR3CJ2ebJ/qLnqkYWTZFugZw
         jfRmKQgENyts32K84EzGzLkPj1SKCzbYs9Ie75gtkpc3Tx9FwcKiBOZyEN2l/6N8/T
         5mb2O2878JRww==
Date:   Wed, 28 Jun 2023 18:27:30 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Huqiang Qin <huqiang.qin@amlogic.com>
Cc:     tglx@linutronix.de, maz@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        neil.armstrong@linaro.org, khilman@baylibre.com,
        jbrunet@baylibre.com, martin.blumenstingl@googlemail.com,
        hkallweit1@gmail.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Subject: Re: [PATCH V2 1/2] dt-bindings: interrupt-controller: Add support
 for Amlogic-C3 SoCs
Message-ID: <20230628-carat-dwarf-0b8e8c047c45@spud>
References: <20230628091533.3884385-1-huqiang.qin@amlogic.com>
 <20230628091533.3884385-2-huqiang.qin@amlogic.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="XbbCx1QsHjc5jIJV"
Content-Disposition: inline
In-Reply-To: <20230628091533.3884385-2-huqiang.qin@amlogic.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XbbCx1QsHjc5jIJV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 28, 2023 at 05:15:32PM +0800, Huqiang Qin wrote:
> Update dt-binding document for GPIO interrupt controller of Amlogic-C3 So=
Cs
>=20
> Signed-off-by: Huqiang Qin <huqiang.qin@amlogic.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> ---
>  .../bindings/interrupt-controller/amlogic,meson-gpio-intc.yaml   | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/amlog=
ic,meson-gpio-intc.yaml b/Documentation/devicetree/bindings/interrupt-contr=
oller/amlogic,meson-gpio-intc.yaml
> index e84e4f33b358..3d06db98e978 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/amlogic,meso=
n-gpio-intc.yaml
> +++ b/Documentation/devicetree/bindings/interrupt-controller/amlogic,meso=
n-gpio-intc.yaml
> @@ -35,6 +35,7 @@ properties:
>                - amlogic,meson-sm1-gpio-intc
>                - amlogic,meson-a1-gpio-intc
>                - amlogic,meson-s4-gpio-intc
> +              - amlogic,c3-gpio-intc
>            - const: amlogic,meson-gpio-intc
> =20
>    reg:
> --=20
> 2.37.1
>=20

--XbbCx1QsHjc5jIJV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZJxtggAKCRB4tDGHoIJi
0hj7AQDpVNTHoWvTaJwjH4OGLihfyqwOGbkOpryPiMX1htjj6gEAkF5EUPPKWA4c
QU+X8XLZU39rF0w7SHpuQNW2J1IAPgQ=
=wqpH
-----END PGP SIGNATURE-----

--XbbCx1QsHjc5jIJV--
