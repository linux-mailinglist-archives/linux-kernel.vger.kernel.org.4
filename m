Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F92D746C03
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 10:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbjGDIfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 04:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbjGDIfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 04:35:12 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A19DA0;
        Tue,  4 Jul 2023 01:35:10 -0700 (PDT)
X-GND-Sasl: miquel.raynal@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1688459709;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uvAuV/3iJvCMZubcgL+XBZbe9I+F9An23rR/WG2KkOk=;
        b=dxbyvJLoyuSTWV6OoUQLs5km4NhJfItKwdpPLbWEoSMn4YYLpHNtrpn3X2vfqcm10LDd9P
        VwQn7C0FuRxtjywGTEPSXFR7rJDE5uF40cEnDBZqY30xynnH31H7hYHDhedGMQA7uXMPbJ
        cGJRG1BPCDOElaTv2jP7FYC4JBmcEe7Q9aP9oYBjFyoiQjq77NOUr/unh97rT7JK8TUQY1
        wLNt7PA08ttZuGWeUAFhb2y38b3eYURhXy8065r4iL4e9jqHcudpsNyMcYhbDta9xOlu7b
        kSMZ8iih7rDyoQaggWYn2Hyz8vqAw2ZOt7/xDsAW3pnnJLKHpkqbCYnpB2L8Sw==
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
X-GND-Sasl: miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D814E240009;
        Tue,  4 Jul 2023 08:35:03 +0000 (UTC)
Date:   Tue, 4 Jul 2023 10:35:02 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Cc:     Liang Yang <liang.yang@amlogic.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        <oxffffaa@gmail.com>, <kernel@sberdevices.ru>,
        <linux-mtd@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v1 1/2] dt-bindings: nand: meson: support for 512B
 ECC step size
Message-ID: <20230704103502.299ac7de@xps-13>
In-Reply-To: <20230628092937.538683-2-AVKrasnov@sberdevices.ru>
References: <20230628092937.538683-1-AVKrasnov@sberdevices.ru>
        <20230628092937.538683-2-AVKrasnov@sberdevices.ru>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arseniy,

AVKrasnov@sberdevices.ru wrote on Wed, 28 Jun 2023 12:29:35 +0300:

> Meson NAND supports both 512B and 1024B ECC step size, so replace
> 'const' for only 1024B step size with enum for both sizes.
>=20
> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
> ---
>  Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yam=
l b/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml
> index 3bec8af91bbb..d42daa285d17 100644
> --- a/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml
> +++ b/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml
> @@ -49,7 +49,7 @@ patternProperties:
>          const: hw
> =20
>        nand-ecc-step-size:
> -        const: 1024
> +        enum: [512, 1024]

I believe you should as well mention the default value.

>        nand-ecc-strength:
>          enum: [8, 16, 24, 30, 40, 50, 60]
> @@ -93,6 +93,7 @@ examples:
>        nand@0 {
>          reg =3D <0>;
>          nand-rb =3D <0>;
> +        nand-ecc-step-size =3D <1024>;

And I don't think this line is really required, but I don't mind.

>        };
>      };
> =20


Thanks,
Miqu=C3=A8l
