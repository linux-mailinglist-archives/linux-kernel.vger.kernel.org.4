Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6E595F1F60
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 22:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbiJAU3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 16:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiJAU3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 16:29:23 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D774419A0;
        Sat,  1 Oct 2022 13:29:22 -0700 (PDT)
Received: from mercury (unknown [185.209.196.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id DE0BC6602056;
        Sat,  1 Oct 2022 21:29:20 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1664656161;
        bh=GbqOd45+B69iop5KOZFk6L2zfF4jSUmsDB16falyAG8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dVfAgPTN/qSyC+mo0Cuken4g9GkZJyX8Oju5sSBYkj7Y29KkeotlRyOdR7Hh21f78
         Bv3IYyztUKcQk7NURth6D2uPiC8h4e4zQNWcGgL6ZlKI3zZCwiyFLyyIL2icUdO0BR
         wZKrLoow4cZZ4bFX0WfsFSOqV/QKQPHtu0zqRo+9ZS2Of9ooYHm4ecR0A1CwUAhFU+
         5BlzRcYxflUolxcRwMxPUv/d0BeSqH/uw8TbSa1ef+qwDk2HxZCt/T3kg2/Z5JkKan
         9HFES3rz1A6478uzPB6u7dUfdyDJ0vOMIgMENIypeybPZdSlld5iU9BZ6CVtkNiMZD
         W79scUmn3wZaA==
Received: by mercury (Postfix, from userid 1000)
        id 89FB1106090C; Sat,  1 Oct 2022 22:29:18 +0200 (CEST)
Date:   Sat, 1 Oct 2022 22:29:18 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     ChiaEn Wu <peterwu.pub@gmail.com>, pavel@ucw.cz,
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
Message-ID: <20221001202918.me7z2qzm7cmrkzsg@mercury.elektranox.org>
References: <cover.1663254344.git.chiaen_wu@richtek.com>
 <9382254831bb6ed8c228398a68896b0e8e61c7c4.1663254344.git.chiaen_wu@richtek.com>
 <CAL_Jsq+Zkgfq0q_XgpLEjHLPGSuG06L6y5YbzbiberNMWtAuJw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ubomutkj3cdfuzuy"
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+Zkgfq0q_XgpLEjHLPGSuG06L6y5YbzbiberNMWtAuJw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ubomutkj3cdfuzuy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Sep 26, 2022 at 09:52:06AM -0500, Rob Herring wrote:
> On Thu, Sep 15, 2022 at 4:49 AM ChiaEn Wu <peterwu.pub@gmail.com> wrote:
> >
> > From: ChiaEn Wu <chiaen_wu@richtek.com>
> >
> > Add MediaTek MT6370 Charger binding documentation.
> >
> > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > Signed-off-by: ChiaEn Wu <chiaen_wu@richtek.com>
> > ---
> > v11
> > - Add more detailed description of irqs.
> > - Adujust the order of irqs
> > ---
> >  .../power/supply/mediatek,mt6370-charger.yaml      | 96 ++++++++++++++=
++++++++
> >  1 file changed, 96 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/power/supply/medi=
atek,mt6370-charger.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/power/supply/mediatek,mt=
6370-charger.yaml b/Documentation/devicetree/bindings/power/supply/mediatek=
,mt6370-charger.yaml
> > new file mode 100644
> > index 0000000..fd491c5
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/power/supply/mediatek,mt6370-ch=
arger.yaml
> > @@ -0,0 +1,96 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/power/supply/mediatek,mt6370-charge=
r.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: MediaTek MT6370 Battery Charger
> > +
> > +maintainers:
> > +  - ChiaEn Wu <chiaen_wu@richtek.com>
> > +
> > +description: |
> > +  This module is part of the MT6370 MFD device.
> > +  Provides Battery Charger, Boost for OTG devices and BC1.2 detection.
> > +
> > +properties:
> > +  compatible:
> > +    const: mediatek,mt6370-charger
> > +
> > +  interrupts:
> > +    description: |
> > +      Specify what irqs are needed to be handled by MT6370 Charger dri=
ver.
> > +      We need to use the IRQ "MT6370_IRQ_OVPCTRL_UVP_D" to know when U=
SB
> > +      is plugged in, and then the driver will enable BC1.2 detection.
> > +      After the hardware of MT6370 completes the BC1.2 detection,
> > +      IRQ "MT6370_IRQ_ATTACH" will be triggered, and the driver will k=
now
> > +      the result of BC1.2 detection.
> > +      When the IRQ "MT6370_IRQ_CHG_MIVR" is triggered, it means that t=
he
> > +      hardware enters the "Minimum Input Voltage Regulation loop" and
> > +      a workaround needs to be applied at this time.
> > +      In summary, "MT6370_IRQ_OVPCTRL_UVP_D", "MT6370_IRQ_ATTACH" and
> > +      "MT6370_IRQ_CHG_MIVR" are required in this charger driver.
> > +    items:
> > +      - description: irq of "USB is plugged in"
> > +      - description: irq of "BC1.2 is done"
> > +      - description: irq of "Minimum Input Voltage Regulation loop is =
active"
> > +
> > +  interrupt-names:
> > +    items:
> > +      - const: uvp_d_evt
> > +      - const: attach_i
> > +      - const: mivr
>=20
> Now warning in linux-next:
>=20
> /builds/robherring/linux-dt/Documentation/devicetree/bindings/mfd/mediate=
k,mt6370.example.dtb:
> charger: interrupt-names:0: 'uvp_d_evt' was expected
>  From schema: /builds/robherring/linux-dt/Documentation/devicetree/bindin=
gs/power/supply/mediatek,mt6370-charger.yaml
> /builds/robherring/linux-dt/Documentation/devicetree/bindings/mfd/mediate=
k,mt6370.example.dtb:
> charger: interrupt-names:1: 'attach_i' was expected
>  From schema: /builds/robherring/linux-dt/Documentation/devicetree/bindin=
gs/power/supply/mediatek,mt6370-charger.yaml

Looks like the example in the MFD binding has the order of uvp_d_evt
and attach_i swapped. ChiaEn Wu, please send a fix.

-- Sebastian

--ubomutkj3cdfuzuy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmM4ox4ACgkQ2O7X88g7
+pqiyA/9HXF36bAyC9iIpST8niA6muqyZfyOveLj5kVZ3S11bsd/z4T/M/R2UqOY
DxCrfDzDFEk9oaG4yQfnEkhsTQDpcKnXsHtvKYOtL3M69BN+jS5yNiUE8BaD+imk
ZCEHfb58sLh+qUavxwpTbSoCD8pN/sorE/gN2XDf0CC6lV0dq2+AlIYsk1zmzTnX
iOi6267Gkzq10oZKQYBIV95AjBBUhdDLKwF1fY9ZDLI8sqce94u51+bc0UxPrVSg
ebcTLn+AfEShc46x8gDJciFVefpyTLG7QUSpp9TFq1uCqVLjzK7avE4nNyL20Sfb
UqTcywtvGR+hBrZwNY/XWZlRznUHX9Sf0VwrDcG6HrNtyAMCRk4m7PM6NQ9NEe6A
jgQcVKnSvaVzUsgfsPSCU1UjiB0CcdOyhhjw5rhFX7Jw5Vm6oNODADMkkGeyPGdV
uJh2Oy17rAa79UjG/uvqiwawqF3OouO3T4IhGlX1Oe0SEuDngmg4nXhXpR8fLCbf
Lbikea2i0bwfwEroIgOA7lSrQsvBBHE5oaCMbKn7niPa44eg+FRqu52XQQtVV/eP
CEnvMXqEIoFOJuK+0rqZdaVaiIMAjdS0GXL1reeKSchutJb60HkasffA7YuFytGr
Jg9UGEuC8GkNWwp8EETNu45A5pKaq35hzV/E8WfSPaAQ9t6sa2I=
=bCC4
-----END PGP SIGNATURE-----

--ubomutkj3cdfuzuy--
