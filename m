Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 993EB71784F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 09:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234632AbjEaHdk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 03:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232237AbjEaHdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 03:33:38 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8249A183;
        Wed, 31 May 2023 00:33:30 -0700 (PDT)
X-GND-Sasl: miquel.raynal@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1685518409;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bb4lcxo6KJyRdv/YgpViXadSVJCkTncR89slgKCigfI=;
        b=fboRmsByi86S6b3FgQOOllfZLVlm1OSKDQ1ieRrq4Qibk6LaT0ZOGYeJqxE9dBpI+Lfdmn
        1FlU5ZtzZ06CTEUdqkx0H174cfXXYGrpgJ3XetyqzyGP0awsTHtdq9QZqVA8hOf3dNzoQz
        yAh/1r+JXL2qWt6dYwN5ladiu7KIHVXHcL58ywY012Iuh5rOHLOp2RteGMiZnDXPGkLnbn
        4UN0vXnhD2JeIxLfXW59ARmwOJuSKgstlnNR53ulViUlDb1xV1L2iTMv2iRQaFEiPG0nso
        yr12dYK+fy5gQbPEf/eyZP5Rz7eZjPQsRfrsZravIPP+dSZ5darBQkb3Y+m35w==
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
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9C24BFF80D;
        Wed, 31 May 2023 07:33:27 +0000 (UTC)
Date:   Wed, 31 May 2023 09:33:26 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     richard@nod.at, vigneshr@ti.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, linux-mtd@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, enachman@marvell.com
Subject: Re: [PATCH v7 4/4] dt-bindings: mtd: marvell-nand: Remove
 deprecated compatibles
Message-ID: <20230531093326.26b6ced7@xps-13>
In-Reply-To: <20230530235456.1009082-5-chris.packham@alliedtelesis.co.nz>
References: <20230530235456.1009082-1-chris.packham@alliedtelesis.co.nz>
        <20230530235456.1009082-5-chris.packham@alliedtelesis.co.nz>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chris,

chris.packham@alliedtelesis.co.nz wrote on Wed, 31 May 2023 11:54:56
+1200:

> Remove compatible values that were marked as deprecated in the old text
> binding.
>=20
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
>  .../devicetree/bindings/mtd/marvell,nand-controller.yaml       | 3 ---
>  1 file changed, 3 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/mtd/marvell,nand-controlle=
r.yaml b/Documentation/devicetree/bindings/mtd/marvell,nand-controller.yaml
> index 7cd4a2e99343..80ce854291cb 100644
> --- a/Documentation/devicetree/bindings/mtd/marvell,nand-controller.yaml
> +++ b/Documentation/devicetree/bindings/mtd/marvell,nand-controller.yaml
> @@ -18,9 +18,6 @@ properties:
>        - enum:
>            - marvell,armada370-nand-controller
>            - marvell,pxa3xx-nand-controller
> -          - marvell,armada-8k-nand
> -          - marvell,armada370-nand
> -          - marvell,pxa3xx-nand

Not sure what you're doing here? I would actually expect these three
lines to have something along:

                 deprecated: true

and this should be part of the conversion to yaml. Or perhaps I am
missing something?

The rest of the series looks good to me.

> =20
>    reg:
>      maxItems: 1


Thanks,
Miqu=C3=A8l
