Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2B05B582E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 12:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbiILKYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 06:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbiILKYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 06:24:13 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F3F357DE;
        Mon, 12 Sep 2022 03:24:12 -0700 (PDT)
Received: from mercury (unknown [185.122.133.20])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 23F4A6601FD2;
        Mon, 12 Sep 2022 11:24:11 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1662978251;
        bh=wGBIlvKje4FgHqTdo2MburWH2bvJgnDyHAqqfxkP0yo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MSBzYp8s99gXfGN5lZJrpXNDS7i0MFjnjP5ccBa7zLkGNKTJU7vNZMzNObIZ3AjMD
         ZRPA+eXE7rj+nhMfMpi2qdru9eMKj9cMJ9VHNl6MOMqyqvSFHQpoYTDkbRLo4sYKjk
         gAVm4qZa8blIyMFgD4nwahT9lT+8CHrI5ioAyAhAc7podq+Iiu0oc8LIY8ej9I4ixf
         /WaK2BnKU4KygHuXdc1lHYdk3Jr2F0PE5TcLqvbRp9j+SQ2xHCMF+gUT/W/NMgTY0I
         mMm0KxoDCrM/2+5c2bOZCgd2PouSmTprbUQxTwufEv7Zjv8cea4dLG/ShWumhcbuRA
         kWoWLo09WYfKw==
Received: by mercury (Postfix, from userid 1000)
        id E32EA106084A; Mon, 12 Sep 2022 12:24:07 +0200 (CEST)
Date:   Mon, 12 Sep 2022 12:24:07 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     ChiaEn Wu <peterwu.pub@gmail.com>
Cc:     pavel@ucw.cz, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        jic23@kernel.org, lars@metafoo.de, broonie@kernel.org,
        mazziesaccount@gmail.com, chiaen_wu@richtek.com,
        alice_chen@richtek.com, cy_huang@richtek.com,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-iio@vger.kernel.org,
        szunichen@gmail.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v10 1/8] dt-bindings: power: supply: Add MediaTek MT6370
 Charger
Message-ID: <20220912102407.znzd2buqpkopvawp@mercury.elektranox.org>
References: <cover.1662476695.git.chiaen_wu@richtek.com>
 <3184e9e5f59edf41788bb95e2ad496772dc70a4a.1662476695.git.chiaen_wu@richtek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zly4a6vosjjv2mrv"
Content-Disposition: inline
In-Reply-To: <3184e9e5f59edf41788bb95e2ad496772dc70a4a.1662476695.git.chiaen_wu@richtek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zly4a6vosjjv2mrv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Sep 06, 2022 at 04:33:57PM +0800, ChiaEn Wu wrote:
> From: ChiaEn Wu <chiaen_wu@richtek.com>
>=20
> Add MediaTek MT6370 Charger binding documentation.
>=20
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: ChiaEn Wu <chiaen_wu@richtek.com>
> ---
>  .../power/supply/mediatek,mt6370-charger.yaml      | 88 ++++++++++++++++=
++++++
>  1 file changed, 88 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/mediat=
ek,mt6370-charger.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/power/supply/mediatek,mt63=
70-charger.yaml b/Documentation/devicetree/bindings/power/supply/mediatek,m=
t6370-charger.yaml
> new file mode 100644
> index 0000000..bd09a0a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/mediatek,mt6370-char=
ger.yaml
> @@ -0,0 +1,88 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/power/supply/mediatek,mt6370-charger.=
yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek MT6370 Battery Charger
> +
> +maintainers:
> +  - ChiaEn Wu <chiaen_wu@richtek.com>
> +
> +description: |
> +  This module is part of the MT6370 MFD device.
> +  Provides Battery Charger, Boost for OTG devices and BC1.2 detection.
> +
> +properties:
> +  compatible:
> +    const: mediatek,mt6370-charger
> +
> +  interrupts:
> +    description: |
> +      Specify what irqs are needed to be handled by MT6370 Charger drive=
r. IRQ
> +      "MT6370_IRQ_CHG_MIVR", "MT6370_IRQ_ATTACH" and "MT6370_IRQ_OVPCTRL=
_UVP_D"
> +      are required.

This does not look like a useful description. It just lists the
below in wrong order?

> +    items:
> +      - description: BC1.2 done irq
> +      - description: usb plug in irq
> +      - description: mivr irq

I had to lookup, that mivr is supposed to mean "minimum input voltage regul=
ation"
for Mediatek/Richtek. Please spell it out here.

-- Sebastian

> +
> +  interrupt-names:
> +    items:
> +      - const: attach_i
> +      - const: uvp_d_evt
> +      - const: mivr
> +
> +  io-channels:
> +    description: |
> +      Use ADC channel to read VBUS, IBUS, IBAT, etc., info.
> +    minItems: 1
> +    items:
> +      - description: |
> +          VBUS voltage with lower accuracy (+-75mV) but higher measure
> +          range (1~22V)
> +      - description: |
> +          VBUS voltage with higher accuracy (+-30mV) but lower measure
> +          range (1~9.76V)
> +      - description: the main system input voltage
> +      - description: battery voltage
> +      - description: battery temperature-sense input voltage
> +      - description: IBUS current (required)
> +      - description: battery current
> +      - description: |
> +          regulated output voltage to supply for the PWM low-side gate d=
river
> +          and the bootstrap capacitor
> +      - description: IC junction temperature
> +
> +  io-channel-names:
> +    minItems: 1
> +    items:
> +      - const: vbusdiv5
> +      - const: vbusdiv2
> +      - const: vsys
> +      - const: vbat
> +      - const: ts_bat
> +      - const: ibus
> +      - const: ibat
> +      - const: chg_vddp
> +      - const: temp_jc
> +
> +  usb-otg-vbus-regulator:
> +    type: object
> +    description: OTG boost regulator.
> +    unevaluatedProperties: false
> +    $ref: /schemas/regulator/regulator.yaml#
> +
> +    properties:
> +      enable-gpios:
> +        maxItems: 1
> +
> +required:
> +  - compatible
> +  - interrupts
> +  - interrupt-names
> +  - io-channels
> +
> +additionalProperties: false
> +
> +...
> --=20
> 2.7.4
>=20

--zly4a6vosjjv2mrv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmMfCMMACgkQ2O7X88g7
+prG+g/+IL/Rc+kycHrb7Jfw2EV0b6A+45R087Ob3Dy1Kf/LHxOHOeyD31c7AMTI
aicts0U9FYihYjdXrnAVp32UYgCFQW3HWd0SEcLFqgKaU8Xa/5zy40rCqPmEhc1X
PjU6pasOjIhT2uVxqTjdeI3rX7zatlnqAQBEkmRbdfCs9TZY2FPZVt/6916scKjl
KzyHyHMaXM/I8BaADFri0bm0SCUSfiewje4R2T6qFYRPYQ3f2K0SJq2lJBDi2qp/
JuFhd/DyvD6C5CrZrF80z6yL8m0XPXWLa58qPSTY8ytmoB7aECt+Xz9J4KFUJJpW
AasdfJLmyITBw2c5YJ4tZTice8w3WzijRPI6RCmTgncB0t7NkEt4CXUosXI/A0Tv
sM/o/17Av/2XvKbmMHCeoaPaPqnO6qo18aaHpBLbXHHTS503k1SOpYZFtzTPYO0Z
5B09/S1HZGJ6qxcBPRwfzW0Pg9O2lrlKhaExg0RgInRpAZaYDJfC+7UP+oZfmr3K
4P9wim6khdqaAg8b7tFcCYEvjFyIouV4ObwR69WZS6JFyjZAP5QKAOPhvGjn5RPK
4rW77VttfIARWAjtRbqq7LU1N8yu2gwe2OwW6++TNnpS72cBhuKeNd3R9eyS7Ki+
zko36FKuEdMnU5LCWUBDmbHXBvrovj++3N4s5qB5tZCSmvD+os8=
=QiKk
-----END PGP SIGNATURE-----

--zly4a6vosjjv2mrv--
