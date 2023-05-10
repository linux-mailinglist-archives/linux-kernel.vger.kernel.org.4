Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85FA16FE28A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 18:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234959AbjEJQdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 12:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjEJQdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 12:33:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C43751993;
        Wed, 10 May 2023 09:33:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E485649CF;
        Wed, 10 May 2023 16:33:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3AB7C433D2;
        Wed, 10 May 2023 16:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683736398;
        bh=B0b6cOMcZUGceKxl+bbmm5jECCCo2ziNwdO/amd/6v8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z15/Eq9Xj23CdyzuPZ2qQAMfzZfryv2AWPFFLEgtWKSUVoQJcK+7Jblt39yY2WxwM
         bz2F2vLSrkiUIonk7nwFucX+fkk27TX8U1saCT5TDpHX9S+urFIxlmrT+qd24uI+Pd
         CNG26mEWvy1uDLFSrbIb2O3se9MVxdCRONh8q4/gagKkKFHDGx3Qi+WKNWsraAMUBi
         lJNIcykm6o7AjKbrnceYjMUkqqvaVH/9MyM2J9Qq78xp0d3Vrn+PYFiwVeogsy0Yol
         3mEJoYS3ZnLJVt2BSjSyR09AoQY18PXP7sWafPCzCWXUi1oxiZXIgbkvov6ob/xNbs
         iVWt2+Wk3b0jQ==
Date:   Wed, 10 May 2023 17:33:12 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Martin =?utf-8?B?WmHFpW92acSN?= <m.zatovic1@gmail.com>
Cc:     linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        gregkh@linuxfoundation.org, beanhuo@micron.com,
        nipun.gupta@amd.com, linus.walleij@linaro.org, mwen@igalia.com,
        bvanassche@acm.org, arnd@arndb.de, ogabbay@kernel.org,
        linux@zary.sk, jacek.lawrynowicz@linux.intel.com,
        geert+renesas@glider.be, benjamin.tissoires@redhat.com,
        masahiroy@kernel.org, yangyicong@hisilicon.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCHv4 3/4] dt-bindings: wiegand: add GPIO bitbanged Wiegand
 controller
Message-ID: <20230510-drearily-shush-5a7197557ece@spud>
References: <20230510162243.95820-1-m.zatovic1@gmail.com>
 <20230510162243.95820-4-m.zatovic1@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="BcjXyh0P91ULlUov"
Content-Disposition: inline
In-Reply-To: <20230510162243.95820-4-m.zatovic1@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--BcjXyh0P91ULlUov
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 10, 2023 at 06:22:42PM +0200, Martin Za=C5=A5ovi=C4=8D wrote:
> GPIO bitbanged Wiegand controller requires definitions of GPIO
> lines to be used on top of the common Wiegand properties. Wiegand
> utilizes two such lines - D0(low data line) and D1(high data line).
>=20
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Martin Za=C5=A5ovi=C4=8D <m.zatovic1@gmail.com>
> ---
>  .../bindings/wiegand/wiegand-gpio.yaml        | 51 +++++++++++++++++++
>  MAINTAINERS                                   |  5 ++
>  2 files changed, 56 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/wiegand/wiegand-gpi=
o.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/wiegand/wiegand-gpio.yaml =
b/Documentation/devicetree/bindings/wiegand/wiegand-gpio.yaml
> new file mode 100644
> index 000000000000..df28929f6dae
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/wiegand/wiegand-gpio.yaml
> @@ -0,0 +1,51 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/wiegand/wiegand-gpio.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: GPIO bitbanged Wiegand interface devicetree bindings

=46rom the previous versions, drop "devicetree bindings".

> +
> +maintainers:
> +  - Martin Za=C5=A5ovi=C4=8D <m.zatovic1@gmail.com>
> +
> +description:
> +  This represents the GPIO lines used for bit-banged Wiegand on dedicate=
d GPIO
> +  lines.
> +
> +allOf:
> +  - $ref: /schemas/wiegand/wiegand-controller.yaml#
> +
> +properties:
> +  compatible:
> +    const: wiegand-gpio
> +
> +  data-hi-gpios:
> +    description: GPIO used as Wiegands data-hi line.
> +    maxItems: 1
> +
> +  data-lo-gpios:
> +    description: GPIO used as Wiegands data-lo line.
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - data-hi-gpios
> +  - data-lo-gpios
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    wiegand@f00 {

Also as previously pointed out dt_binding_check doesn't like this:
Warning (unit_address_vs_reg): /example-0/wiegand@f00: node has a unit name=
, but no reg or ranges property

Cheers,
Conor.

> +        compatible =3D "wiegand-gpio";
> +        pulse-len-us =3D <50>;
> +        interval-len-us =3D <2000>;
> +        frame-gap-us =3D <2000>;
> +        data-lo-gpios =3D <&gpio2 6 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
> +        data-hi-gpios =3D <&gpio2 7 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
> +
> +        /* devices */
> +    };


--BcjXyh0P91ULlUov
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZFvHSAAKCRB4tDGHoIJi
0tGiAQC4CrhL1hBx+1yq7L/r00Cgk/+d9WPFvmAQwHpVlP2/0wD/TbptDqye1tAl
PsxEsR6UHOyQPs8iVCUTINQGg7/jWQ4=
=/wI1
-----END PGP SIGNATURE-----

--BcjXyh0P91ULlUov--
