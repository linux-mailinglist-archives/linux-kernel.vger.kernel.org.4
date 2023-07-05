Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 390FB747E5F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 09:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232090AbjGEHhK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 03:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231315AbjGEHhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 03:37:07 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11603E41;
        Wed,  5 Jul 2023 00:37:05 -0700 (PDT)
X-GND-Sasl: miquel.raynal@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1688542624;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q6JVbObW4DqYx9q0QffEzB/qcd5stuGhTxLhBBsyTh8=;
        b=g/yvzSdekzdtRDmOBQTW8pBMh4BYil5lC2CEjb78knxVTm9JJJ00Tud+XhonSVw/SryXua
        BqitCmzLqgtyHAyuxipzOuDrcoqK/3Tokvy0lq6x6hEakmLH90vS95kjSQWtn9sw7C4M7h
        wLG7VEYKz63Bs1kiD6zD9b9ZDsh14CN2XEsv1xX+GYnzbP1mu4w5JaOGli9paymNDvi7Kf
        mZwxvn+AJANdMsGKnK/xfu1Yg88XbS30DP8yKDHiEQPerwC9f2m4z8EDLvljwR0X6Vj4SF
        VX3hE2k+UO3hBc1poMG3z7bLVDWos0U1cKjOW4DRWgP420lcoFpqVOQCNM0NaA==
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
Received: by mail.gandi.net (Postfix) with ESMTPSA id 021B4FF809;
        Wed,  5 Jul 2023 07:37:02 +0000 (UTC)
Date:   Wed, 5 Jul 2023 09:37:02 +0200
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
Subject: Re: [RFC PATCH v2 1/2] dt-bindings: nand: meson: support for 512B
 ECC step size
Message-ID: <20230705093702.6c0421d7@xps-13>
In-Reply-To: <20230705065434.297040-2-AVKrasnov@sberdevices.ru>
References: <20230705065434.297040-1-AVKrasnov@sberdevices.ru>
        <20230705065434.297040-2-AVKrasnov@sberdevices.ru>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arseniy,

AVKrasnov@sberdevices.ru wrote on Wed, 5 Jul 2023 09:54:33 +0300:

> Meson NAND supports both 512B and 1024B ECC step size, so replace
> 'const' for only 1024B step size with enum for both sizes.
>=20
> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
> ---
>  Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yam=
l b/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml
> index 3bec8af91bbb..81ca8828731a 100644
> --- a/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml
> +++ b/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml
> @@ -49,7 +49,8 @@ patternProperties:
>          const: hw
> =20
>        nand-ecc-step-size:
> -        const: 1024
> +        enum: [512, 1024]
> +        default: 1024

I was actually wrong in my previous review, there is no strong default
here as the existing binding (and code) try to use the closest
parameters required by the NAND chip: we pick the "optimal"
configuration. So if you don't provide any value here, we expect
the strength and step size advertized by the chip to be used. This is a
common default in the raw NAND subsystem.

Please drop the default line, re-integrate the missing R-by tag from
Rob and in a separate patch please mark nand-ecc-step-size and
nand-ecc-strength mandatory if the other is provide. IOW, we expect
either both, or none of them, but not a single one.

> =20
>        nand-ecc-strength:
>          enum: [8, 16, 24, 30, 40, 50, 60]
> @@ -93,6 +94,7 @@ examples:
>        nand@0 {
>          reg =3D <0>;
>          nand-rb =3D <0>;
> +        nand-ecc-step-size =3D <1024>;

So in the end this line is wrong and once you get the description right
as I mentioned it above, this will fail to pass
`make DT_SCHEMA_FILES=3DDocumentation/devicetree/bindings/mtd/ dt_binidng_c=
heck`
Please drop it from the example, don't add the second property here,
it's best to show a clean example where people stop tampering for no
reason with the optimal values.

>        };
>      };
> =20


Thanks,
Miqu=C3=A8l
