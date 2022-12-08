Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD3A646C53
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 11:00:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbiLHKAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 05:00:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiLHKAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 05:00:45 -0500
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B881164AB;
        Thu,  8 Dec 2022 02:00:42 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 0607420003;
        Thu,  8 Dec 2022 10:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1670493641;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pQBvnBipF0jBYBuu1EcKJlR/pd4YO5GJfr3JHPYqAq8=;
        b=nHcSa8RDjNx8DzhiTHdnU62FP/U3JJFVD/kHc9FRwYndvpGihZr8KVG5P3UdSF/xTo4u2v
        +5JyQUxoQvDH5LFHTBxynsI7WZm+tjoremxnDBAN29LIip92uhp2yPPoYAFk6naOyHqako
        vrCPsn27kC0s95MhEALjy8UeHjE9LZzUO19D+K6X3KM7TMIaZAdVR+fQAO2npW0ycNH54L
        U2VADhsqdaMr3hdyuVrwoqMT3t6MdCwV6Ok2YX0960rhpZXhuViLxqyX2uUnMAHZlRB7IA
        UjJOAQ+XxF0KOCp1d6WHagxXOghUylxmnaity+qqz1a+81FqR2bNqC825po7DQ==
Date:   Thu, 8 Dec 2022 11:00:35 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Xiangsheng Hou <xiangsheng.hou@mediatek.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Chuanhong Guo <gch981213@gmail.com>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, benliang.zhao@mediatek.com,
        bin.zhang@mediatek.com
Subject: Re: [PATCH v3 7/9] dt-bindings: mtd: Split ECC engine with rawnand
 controller
Message-ID: <20221208110035.5649a051@xps-13>
In-Reply-To: <fe70d964-229a-8bda-a414-e009dd955e5e@linaro.org>
References: <20221208062955.2546-1-xiangsheng.hou@mediatek.com>
        <20221208062955.2546-8-xiangsheng.hou@mediatek.com>
        <fe70d964-229a-8bda-a414-e009dd955e5e@linaro.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

krzysztof.kozlowski@linaro.org wrote on Thu, 8 Dec 2022 10:44:17 +0100:

> On 08/12/2022 07:29, Xiangsheng Hou wrote:
> > Split MediaTek ECC engine with rawnand controller and convert to
> > YAML schema.
> >=20
> > Signed-off-by: Xiangsheng Hou <xiangsheng.hou@mediatek.com>
> > ---
> >  .../bindings/mtd/mediatek,mtk-nfc.yaml        | 154 +++++++++++++++
> >  .../mtd/mediatek,nand-ecc-engine.yaml         |  62 ++++++
> >  .../devicetree/bindings/mtd/mtk-nand.txt      | 176 ------------------
> >  3 files changed, 216 insertions(+), 176 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/mtd/mediatek,mtk-=
nfc.yaml
> >  create mode 100644 Documentation/devicetree/bindings/mtd/mediatek,nand=
-ecc-engine.yaml
> >  delete mode 100644 Documentation/devicetree/bindings/mtd/mtk-nand.txt
> >=20
> > diff --git a/Documentation/devicetree/bindings/mtd/mediatek,mtk-nfc.yam=
l b/Documentation/devicetree/bindings/mtd/mediatek,mtk-nfc.yaml
> > new file mode 100644
> > index 000000000000..eb1a44c7ae4e
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mtd/mediatek,mtk-nfc.yaml
> > @@ -0,0 +1,154 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/mtd/mediatek,mtk-nfc.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: MediaTek(MTK) SoCs raw NAND FLASH controller (NFC)
> > +
> > +maintainers:
> > +  - Xiangsheng Hou <xiangsheng.hou@mediatek.com>
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - mediatek,mt2701-nfc
> > +      - mediatek,mt2712-nfc
> > +      - mediatek,mt7622-nfc
> > +
> > +  reg:
> > +    items:
> > +      - description: Base physical address and size of NFI.
> > +
> > +  interrupts:
> > +    items:
> > +      - description: NFI interrupt
> > +
> > +  clocks:
> > +    items:
> > +      - description: clock used for the controller
> > +      - description: clock used for the pad
> > +
> > +  clock-names:
> > +    items:
> > +      - const: nfi_clk
> > +      - const: pad_clk
> > +
> > +  ecc-engine:
> > +    description: device-tree node of the required ECC engine.
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +
> > +patternProperties:
> > +  "^nand@[a-f0-9]$":
> > +    type: object =20
>=20
> This should be instead:
>     $ref: nand-chip.yaml#
>     unevaluatedProperties: false
>=20
> and then properties below (due to current dtschema limitations) should
> list properties from nand-controller.yaml:
>=20
>       nand-on-flash-bbt: true
>=20
> Optionally, we could create additional schema - nand-controller-chip,
> which would be referenced directly by nand-controller and itself would
> ref nand-chip.

Isn't this enough? (in linux-next)
https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git/tree/Document=
ation/devicetree/bindings/mtd/nand-controller.yaml?h=3Dmtd/next#n54

Thanks,
Miqu=C3=A8l
