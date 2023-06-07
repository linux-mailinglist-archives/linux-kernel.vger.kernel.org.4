Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A90B072569D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 09:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237800AbjFGH6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 03:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235040AbjFGH6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 03:58:08 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AB5E8E;
        Wed,  7 Jun 2023 00:58:06 -0700 (PDT)
X-GND-Sasl: miquel.raynal@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1686124684;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mKG1NX3ZxmRc+PLD+/MdWhbgvUph3jo+duURfanqw8k=;
        b=OXG9qUfFLgGWSo42JBDd7LiRIw2e/RdSt/ppyHO7/uiQLS0JfFs6sf21x40J5mQpTB9qoG
        BkkLUU4css7mTSHTVLl+toSnLLJ2MXk+cJDJXdIm7LB1SMN+g8xHBE7hSlHif/HlEPn4xa
        BdOhDZ86hr9okM2ndhrXRq1xif4NBiQUSv3pzAo6C8zdTonkcTkRz73qBdQaJyX5TFYoyK
        AYEKMzDcdPVuF0hKOgXeviDURHSQ7FxHvTeJM72gwX7kSDZ21C3OwPktQ05SXEopbxAURi
        6u2hCpXQrqPfFUjC4Z9EXpvFGD790UsrHG98wMD+Q7GQxB7qruwOah5gkWw+Mw==
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 72F6224000E;
        Wed,  7 Jun 2023 07:58:03 +0000 (UTC)
Date:   Wed, 7 Jun 2023 09:58:02 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Cc:     Liang Yang <liang.yang@amlogic.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        <oxffffaa@gmail.com>, <kernel@sberdevices.ru>,
        <linux-mtd@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] dt-bindings: nand: meson: Fix 'nand-rb' property
Message-ID: <20230607095802.3adcd4f9@xps-13>
In-Reply-To: <20230606193507.35024-1-AVKrasnov@sberdevices.ru>
References: <20230606193507.35024-1-AVKrasnov@sberdevices.ru>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arseniy,

AVKrasnov@sberdevices.ru wrote on Tue, 6 Jun 2023 22:35:07 +0300:

> Add description of 'nand-rb' property. Use "Fixes" because this property
> must be supported since the beginning. For this controller 'nand-rb' is
> stored in the controller node (not in chip), because it has only single
> r/b wire for all chips.

Sorry if I mislead you in the first place, but you could definitely
have two chips and only one with RB wired. It needs to be defined in
the chips.

Please keep the bindings and driver changes related to this in the same
series.

>=20
> Fixes: fbc00b5e746f ("dt-bindings: nand: meson: convert txt to yaml")
> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
> ---
>  Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yam=
l b/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml
> index 28fb9a7dd70f..866edf800b81 100644
> --- a/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml
> +++ b/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml
> @@ -37,6 +37,8 @@ properties:
>        - const: core
>        - const: device
> =20
> +  nand-rb: true
> +
>  patternProperties:
>    "^nand@[0-7]$":
>      type: object
> @@ -81,6 +83,7 @@ examples:
> =20
>        pinctrl-0 =3D <&nand_pins>;
>        pinctrl-names =3D "default";
> +      nand-rb =3D "true";
> =20
>        #address-cells =3D <1>;
>        #size-cells =3D <0>;


Thanks,
Miqu=C3=A8l
