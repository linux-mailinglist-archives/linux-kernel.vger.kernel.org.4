Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3935A6FB553
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 18:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234530AbjEHQiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 12:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234382AbjEHQhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 12:37:45 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA1146E87;
        Mon,  8 May 2023 09:37:36 -0700 (PDT)
Received: from mercury (195-23-45-170.net.novis.pt [195.23.45.170])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 16749660574D;
        Mon,  8 May 2023 17:37:33 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1683563853;
        bh=es+2Vg5vpbSoOm58wIOQnVTmBCiV+CnwrUUXaKbUTLY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iUdnBvZrUQkwiAEIWZdSWd6P6yq+4KdNH+/saBQkhQjrfCrIQYTreHqGaD6h+iRtD
         S9geDZl9fP1waE7OTdWixXuAhB3KOr4mwMqNiaHX3hO1Fl6+X43FXAahRVsaVSMwMY
         334UbpWXdW8b0lwm1/3ML2/jc70kkBhtkHJ3xdEVrk+IwUhYU70AQZc6XyyUZyzf6B
         uJymUPGtBQsqoJtPBLdL0WXyo9AlYD1GzKwEZJHiaiLIm589jFIo85bWEZ60o5IPov
         ZZX589b0YrwbfdBizAIntCAJ5liQ0rqSeTUYW/M3GHtvoSX+rgsS5/KglCMb+lgCVb
         n0SCrf+mg/7pw==
Received: by mercury (Postfix, from userid 1000)
        id 5C3E61066FBE; Mon,  8 May 2023 14:39:34 +0200 (CEST)
Date:   Mon, 8 May 2023 14:39:34 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2 2/3] dt-bindings: power: reset: convert
 nvmem-reboot-mode bindings to YAML
Message-ID: <20230508123934.om25c73xuprqviwq@mercury.elektranox.org>
References: <20230417145536.414490-1-brgl@bgdev.pl>
 <20230417145536.414490-3-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mdqi6q4wcgrzti64"
Content-Disposition: inline
In-Reply-To: <20230417145536.414490-3-brgl@bgdev.pl>
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mdqi6q4wcgrzti64
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Apr 17, 2023 at 04:55:35PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>=20
> Convert the DT binding document for nvmem-reboot-mode from .txt to YAML.
>=20
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Thanks, queued.

-- Sebastian

>  .../power/reset/nvmem-reboot-mode.txt         | 26 ----------
>  .../power/reset/nvmem-reboot-mode.yaml        | 52 +++++++++++++++++++
>  2 files changed, 52 insertions(+), 26 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/power/reset/nvmem-r=
eboot-mode.txt
>  create mode 100644 Documentation/devicetree/bindings/power/reset/nvmem-r=
eboot-mode.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/power/reset/nvmem-reboot-m=
ode.txt b/Documentation/devicetree/bindings/power/reset/nvmem-reboot-mode.t=
xt
> deleted file mode 100644
> index 752d6126d5da..000000000000
> --- a/Documentation/devicetree/bindings/power/reset/nvmem-reboot-mode.txt
> +++ /dev/null
> @@ -1,26 +0,0 @@
> -NVMEM reboot mode driver
> -
> -This driver gets reboot mode magic value from reboot-mode driver
> -and stores it in a NVMEM cell named "reboot-mode". Then the bootloader
> -can read it and take different action according to the magic
> -value stored.
> -
> -Required properties:
> -- compatible: should be "nvmem-reboot-mode".
> -- nvmem-cells: A phandle to the reboot mode provided by a nvmem device.
> -- nvmem-cell-names: Should be "reboot-mode".
> -
> -The rest of the properties should follow the generic reboot-mode descrip=
tion
> -found in reboot-mode.txt
> -
> -Example:
> -	reboot-mode {
> -		compatible =3D "nvmem-reboot-mode";
> -		nvmem-cells =3D <&reboot_mode>;
> -		nvmem-cell-names =3D "reboot-mode";
> -
> -		mode-normal     =3D <0xAAAA5501>;
> -		mode-bootloader =3D <0xBBBB5500>;
> -		mode-recovery   =3D <0xCCCC5502>;
> -		mode-test       =3D <0xDDDD5503>;
> -	};
> diff --git a/Documentation/devicetree/bindings/power/reset/nvmem-reboot-m=
ode.yaml b/Documentation/devicetree/bindings/power/reset/nvmem-reboot-mode.=
yaml
> new file mode 100644
> index 000000000000..14a262bcbf7c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/reset/nvmem-reboot-mode.yaml
> @@ -0,0 +1,52 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/power/reset/nvmem-reboot-mode.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Generic NVMEM reboot mode
> +
> +maintainers:
> +  - Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> +
> +description:
> +  This driver gets the reboot mode magic value from the reboot-mode driv=
er
> +  and stores it in the NVMEM cell named "reboot-mode". The bootloader can
> +  then read it and take different action according to the value.
> +
> +properties:
> +  compatible:
> +    const: nvmem-reboot-mode
> +
> +  nvmem-cells:
> +    description:
> +      A phandle pointing to the nvmem-cells node where the vendor-specif=
ic
> +      magic value representing the reboot mode is stored.
> +    maxItems: 1
> +
> +  nvmem-cell-names:
> +    items:
> +      - const: reboot-mode
> +
> +patternProperties:
> +  "^mode-.+":
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Vendor-specific mode value written to the mode register
> +
> +required:
> +  - compatible
> +  - nvmem-cells
> +  - nvmem-cell-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    reboot-mode {
> +        compatible =3D "nvmem-reboot-mode";
> +        nvmem-cells =3D <&reboot_reason>;
> +        nvmem-cell-names =3D "reboot-mode";
> +        mode-recovery =3D <0x01>;
> +        mode-bootloader =3D <0x02>;
> +    };
> +...
> --=20
> 2.37.2
>=20

--mdqi6q4wcgrzti64
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmRY7YUACgkQ2O7X88g7
+pqliA/+PTCQsQ+tMps+bNbGAcfRdYA0vzp4XVryQtM8fDKsYjHPbIVNbo6m1Jzj
m8M0JG97Rv4vtAxAaAShGGRwmt0siViFBMHF3+rY0MMoXEDqyu1mgo3DUo31oglY
cguJUCXyGonf+jCtPKjDiMAiszKUhGzbp7HLlAPNlajPse3H08fOpIf7+4YK3ejy
4UecDxLoHwk2dWxH68unPODaHvoDCAF7hW5kTd6Czz8A6Z3x46IMF0J9/5Zn2vzU
ia2IdAHhjd7/PHdf7ehJaG7dcYn53cnjy2ADSjM5nl9Q5Nw1iBn8ZcBuktEYp7gZ
wKDV4U0zMlgpzSaAYe9RXElUJygJ+2BrNauEm8OJuD9FqW+mtPtlZOmLevmkDW4U
Xu9zEK2xDx5cN3DBydlxdoy2e2wmHkAZCCuoqJh9bC4RIKCraLVNLg2MjJWVK4R6
iixAIqkJPfS+JW94eXLYTFq89PC7gvDzWye5uP47dp+8f1Y2+qQ09VGPn4UQwCkM
+URv6OuH7kNMoFlFk9BJPBbyUxkjXlATIXj8OuZptVNl5l9/RS1fV2moy6otk0qm
/lVokTTJpp0JvmeqA+Et4imrKQA9rCkfFTHsHNcTCLlZxMpuY9+jiySVGEfnzB4G
/SoHiG4BPeb69Rn1JcTPkvvRONZvxgCTrdLh3POtVYfvxR82Fas=
=HEcC
-----END PGP SIGNATURE-----

--mdqi6q4wcgrzti64--
