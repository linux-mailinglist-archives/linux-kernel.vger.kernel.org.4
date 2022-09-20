Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEC305BEAD2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 18:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230441AbiITQJG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 12:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbiITQJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 12:09:02 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22E0463F29;
        Tue, 20 Sep 2022 09:09:01 -0700 (PDT)
Received: from mercury (dyndsl-091-096-056-222.ewe-ip-backbone.de [91.96.56.222])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6A81C660036C;
        Tue, 20 Sep 2022 17:08:59 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1663690139;
        bh=U4MKHkfmJTO9JVdcD4fx4hWzMziGhHQzIgsluqhPYqQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=giHCaviJ3ZXY7p6hA6RH72pU4MNDFjEt787CjL4I/zAeDUKaFDTNQQ7ahcllvt3Zg
         53pJmkHK78HEJsq5x+eWUQJaji5LCfRpY7RXO29FMn4z0EkFV86z387dKdR/I/U+Kr
         EBRO+S8PpEnlMOzxi/lNyqgSHPTCvRmZu2kvwT5KK4+bMAqnz1EMiMleWSeau6HH2W
         QbrBZM0ICXDeNSAgzbUm8ScyhU3CtUJg3Lu9SNj6NfIxGVZlADeo1AoLd3HQk+NG6n
         jGtpPSgj1LmTkI9cjmUkuhs0bdrYFYmZ7GMYxcB0fa0on+ipNPZQzoCgasQYxub/17
         bNQRwYFv198kg==
Received: by mercury (Postfix, from userid 1000)
        id 7C66D10607CF; Tue, 20 Sep 2022 18:08:57 +0200 (CEST)
Date:   Tue, 20 Sep 2022 18:08:57 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     ChiaEn Wu <peterwu.pub@gmail.com>
Cc:     pavel@ucw.cz, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        jic23@kernel.org, lars@metafoo.de, broonie@kernel.org,
        mazziesaccount@gmail.com, andriy.shevchenko@linux.intel.com,
        chiaen_wu@richtek.com, alice_chen@richtek.com,
        cy_huang@richtek.com, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-iio@vger.kernel.org,
        szunichen@gmail.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v11 1/8] dt-bindings: power: supply: Add MediaTek MT6370
 Charger
Message-ID: <20220920160857.6qfi66gtmgwesq7g@mercury.elektranox.org>
References: <cover.1663254344.git.chiaen_wu@richtek.com>
 <9382254831bb6ed8c228398a68896b0e8e61c7c4.1663254344.git.chiaen_wu@richtek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lvjs3fe3c77xkyzo"
Content-Disposition: inline
In-Reply-To: <9382254831bb6ed8c228398a68896b0e8e61c7c4.1663254344.git.chiaen_wu@richtek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lvjs3fe3c77xkyzo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Sep 15, 2022 at 05:47:29PM +0800, ChiaEn Wu wrote:
> From: ChiaEn Wu <chiaen_wu@richtek.com>
>=20
> Add MediaTek MT6370 Charger binding documentation.
>=20
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: ChiaEn Wu <chiaen_wu@richtek.com>
> ---
> v11
> - Add more detailed description of irqs.
> - Adujust the order of irqs
> ---

Thanks, queued.

-- Sebastian

>  .../power/supply/mediatek,mt6370-charger.yaml      | 96 ++++++++++++++++=
++++++
>  1 file changed, 96 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/mediat=
ek,mt6370-charger.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/power/supply/mediatek,mt63=
70-charger.yaml b/Documentation/devicetree/bindings/power/supply/mediatek,m=
t6370-charger.yaml
> new file mode 100644
> index 0000000..fd491c5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/mediatek,mt6370-char=
ger.yaml
> @@ -0,0 +1,96 @@
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
r.
> +      We need to use the IRQ "MT6370_IRQ_OVPCTRL_UVP_D" to know when USB
> +      is plugged in, and then the driver will enable BC1.2 detection.
> +      After the hardware of MT6370 completes the BC1.2 detection,
> +      IRQ "MT6370_IRQ_ATTACH" will be triggered, and the driver will know
> +      the result of BC1.2 detection.
> +      When the IRQ "MT6370_IRQ_CHG_MIVR" is triggered, it means that the
> +      hardware enters the "Minimum Input Voltage Regulation loop" and
> +      a workaround needs to be applied at this time.
> +      In summary, "MT6370_IRQ_OVPCTRL_UVP_D", "MT6370_IRQ_ATTACH" and
> +      "MT6370_IRQ_CHG_MIVR" are required in this charger driver.
> +    items:
> +      - description: irq of "USB is plugged in"
> +      - description: irq of "BC1.2 is done"
> +      - description: irq of "Minimum Input Voltage Regulation loop is ac=
tive"
> +
> +  interrupt-names:
> +    items:
> +      - const: uvp_d_evt
> +      - const: attach_i
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

--lvjs3fe3c77xkyzo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmMp5YoACgkQ2O7X88g7
+po+exAAjROzmdoA45Q3bZM+ZLlt2yyMZ84hAR7M1vXnsFLzjftqxdNOu+P+lYX6
j+wUyf8+mINcJP4utRTyxk+O/H1R+fCC6H5Jt/IHMtPD9RcfOgDD6FDdeYVApNch
canxbBi9AKM9HrntaLu8OVWVuvmj15YwsSjXyTKJiRaVdqvcAwToToNkxeZRD1/p
LBufMpBnVIvtWIkamOa3p0iEpuAg5p2AHHeTOVdO9xDTOiAFE3y+k2bkt57WE8ye
s0Ah8LRl/ekhaQjTbDvX4ycHtyw16wUtT8mVu7ZezA8JnSoNrCJm3DAY6qvBc6dL
IKLzd0gZ5hq4xQzmbUJ3KiP3nwtFaOnOzDXE2aAs3X2m0CQc6nC9o2ZcQVBm12gF
namJgZ+/YWCQm3KDvc/ipL8hpkf7jti+TWhRs6WWJza6Rghr+NIcET/GmGHYff8G
HWtp/oOaNwr6Rw8HCxkGD1ew0TUTOrpt6iWhaCcVjKhMsbLvjqYmIR0DSIlOEErT
quIppiPo9YId/JfDENIGuUJXFyd6ZQsjC8tuCcWYTQJOFG42LSjRW9/mUHCHn1Rz
6sE/gyCUN5OOfcPWm0j1nHG9Ob/iVHupmWwjfgBJcD/QwV/v7ePz5BxJxgLLCILd
jnEnmxLe0Rpcdu25YT11/s4lPrf1lPUqCBIsjPlQ5HLvDNTekzQ=
=TGYa
-----END PGP SIGNATURE-----

--lvjs3fe3c77xkyzo--
