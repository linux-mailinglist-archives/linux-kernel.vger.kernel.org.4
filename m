Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98B4E5BAF1C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 16:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbiIPOS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 10:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231588AbiIPOSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 10:18:53 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30618B1B83;
        Fri, 16 Sep 2022 07:18:52 -0700 (PDT)
Received: from mercury (unknown [82.141.252.181])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0DC40660203B;
        Fri, 16 Sep 2022 15:18:50 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1663337930;
        bh=ZLM9d9F/EoTTN2+Qe1HJE5YhJNqZQ6yu6k4zqiLIIBk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=huXbpgc/7LoK2ak5zlFNwWRCFsHcpe2bvGGx7ThsS5scPh6K7Fn0mt0lww5ikW0tG
         w0W/TaSEUrdjnfXJU8qjV+68/ExoMY52Kws5VvW/BCO+6tArhHngiPcH4NBl3H+RTH
         c0xBYC3GDN149VGjFUkBwDt+WnI0ptKn5t4NETAyuVEjcqPW6vZN4h9I4WJ+Yas3JC
         9uH0NuLiXVeVIHCEP8xYnsVEXs2VHh9h5ffDKRi30kq53g33MQIcHyxyd368LUStkZ
         q8GZBebRE7ZX41GTnUzM7MSfD5TapID8gkOSVUFYc+q/Xbmibv8taKed8TLIThv0cq
         qxwNucN8tKQnw==
Received: by mercury (Postfix, from userid 1000)
        id BA4751060849; Fri, 16 Sep 2022 16:18:43 +0200 (CEST)
Date:   Fri, 16 Sep 2022 16:18:43 +0200
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
Message-ID: <20220916141843.pmlg3x7yrnkdr26r@mercury.elektranox.org>
References: <cover.1663254344.git.chiaen_wu@richtek.com>
 <9382254831bb6ed8c228398a68896b0e8e61c7c4.1663254344.git.chiaen_wu@richtek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fwbn4zdugcfjfhv7"
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


--fwbn4zdugcfjfhv7
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

Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>

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

--fwbn4zdugcfjfhv7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmMkhcAACgkQ2O7X88g7
+prLghAAgaMdleTOkYQYJw7BnJdS13FoSXBt0v+LtednJi/uKwwDFWX9R6t04m4c
fxSU/K1LiIkUQWw/iT0YXM5m2xl2tbFwTYq7fUwj6soTbHjCuv5ii6b2cQw5+bTe
SBRQWf4OJqqU0Wo2IpjdsVQeKSCpCoUUjgAf1VWwGh80SH4lXdpKlNuZIlYo6m4R
S86iaJLgM1Zaf1y4xV1MBoVyhC4peHPlcYl+zqTalN9tRXthDjEbGKsodbxSv3yX
tVAYuY3YXLmmHfCASxbaFeDxW7GzgmQiHV1a7c5rjvaPqpO1lFJ4+sl04mFPQ+u/
ZkvT9Dw8SawWQOUa4S/myktxiUrZlEaIVCj+iW0yE0yN03ARG2Le6n3JSFE2Spt5
4jUjo3VFyFFJNrRzFS00lO8Pwrs143mvKuD28Dh6g4Gdi7IJz6aRZdM2fx9SwwS9
iQn4Hp/0lrdhpmecZZSS2awHnuGv+wi++Jpx4/GDhE7OMHjWX+pZA7spNJZhb/e6
DwbIo8zM+y3wosRM8kcxR9PPmLaPpMsP6WkUHDuSaiCzzYPxEWA8g276IUjCtWUs
gCqHcb7/a+CuMKbVwmqemzhaxcekH5fqdpTqIWEA+QkxCOqCqG5KqK7tw/tg5fYe
6DUSkNR6hysUsU6DgjeopXNXhPhyE7F8odG1MkFPFcw2EDNskxU=
=KswM
-----END PGP SIGNATURE-----

--fwbn4zdugcfjfhv7--
