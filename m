Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D989E7194BC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 09:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231699AbjFAHv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 03:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231572AbjFAHtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 03:49:21 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61294E41;
        Thu,  1 Jun 2023 00:45:07 -0700 (PDT)
X-GND-Sasl: miquel.raynal@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1685605505;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E8q0kpo5yQyJlgrFOIwJycXOb57GbR9p3w4XAi+QTgQ=;
        b=aEhqsT/ShYWjw7oXndLY6YBS1LOxerrLwzyfKw02VgNZR19EmPgnsk526d4kQ3cGH35Zoo
        gqfNFry0Ycir3UnvMUHlGm9mBbCoJej//O1xqNxto9tK89alGjQkuHNYVwPcMcxaSl6SJ7
        T2FG8KNFO+l4noKA0IVF+9Yh+ywbXxyR2nth7xz4xWXnnTn+GV6nXK6IyRvcr62Kuk8VaN
        FU0aouzttm9Ssc5eca1rPXDjCVGTDBCIXXmrU4jRTqzgf7NTEHQIQa4EOK5OSlxvpOTham
        uNXmW6H8gUb2Kc/NSECSwQdazn1k3YWMJ9nG91aQxxsTpxbKv2af5zXx1F010A==
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
Received: by mail.gandi.net (Postfix) with ESMTPSA id BECA9FF804;
        Thu,  1 Jun 2023 07:45:02 +0000 (UTC)
Date:   Thu, 1 Jun 2023 09:45:01 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Peters <mpeters@embeddedTS.com>,
        Kris Bahnsen <kris@embeddedTS.com>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 23/43] dt-bindings: mtd: Add ts7250 nand-controller
Message-ID: <20230601094501.0d67d78a@xps-13>
In-Reply-To: <20230601054549.10843-5-nikita.shubin@maquefel.me>
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
        <20230601054549.10843-5-nikita.shubin@maquefel.me>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nikita,

nikita.shubin@maquefel.me wrote on Thu,  1 Jun 2023 08:45:28 +0300:

> Add YAML bindings for ts7250 NAND Controller.
>=20
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> ---
>=20
> Notes:
>     v0 -> v1:
>    =20
>     make it a nand contoller
>=20
>  .../bindings/mtd/technologic,nand.yaml        | 47 +++++++++++++++++++
>  1 file changed, 47 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mtd/technologic,nan=
d.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/mtd/technologic,nand.yaml =
b/Documentation/devicetree/bindings/mtd/technologic,nand.yaml
> new file mode 100644
> index 000000000000..26d1d9c3331d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mtd/technologic,nand.yaml
> @@ -0,0 +1,47 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mtd/technologic,nand.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Technologic Systems NAND controller
> +
> +maintainers:
> +  - Nikita Shubin <nikita.shubin@maquefel.me>
> +
> +allOf:
> +  - $ref: nand-controller.yaml
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - const: technologic,ts7200-nand
> +      - items:
> +          - enum:
> +              - technologic,ts7300-nand
> +              - technologic,ts7260-nand
> +              - technologic,ts7250-nand
> +          - const: technologic,ts7200-nand
> +
> +  reg:
> +    maxItems: 1
> +
> +  '#address-cells': true
> +  '#size-cells': true
> +
> +required:
> +  - compatible
> +  - reg
> +
> +unevaluatedProperties: true

Should be false I guess.

> +
> +examples:
> +  - |
> +    nand-controller@60000000 {
> +      compatible =3D "technologic,ts7200-nand";
> +      reg =3D <0x60000000 0x8000000>;
> +      #address-cells =3D <1>;
> +      #size-cells =3D <0>;
> +    };
> +
> +...


Thanks,
Miqu=C3=A8l
