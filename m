Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1979B6F4064
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 11:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232402AbjEBJtL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 05:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233443AbjEBJtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 05:49:08 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59734524F;
        Tue,  2 May 2023 02:49:05 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id DC045E000B;
        Tue,  2 May 2023 09:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1683020943;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/gfQOh2PwLRlQwHDSKhkoGrNXpAwRAnESR/q6uR4syw=;
        b=Y5M2PSY/L2VSU9ucaJhy48rOisVe/Q65cV5eN3o9/bbow5TScajZGfS8Mz1IGeWH03A2AL
        OZ04z+MNJi1LgqSLexpsmLQiFx4YgOAR5yUYqUJ53aHQwcBnu4jd+femeHT+osqvfCPkPY
        AREHvgHt3Ee8b88s5+jArsABJ9ynk2AZ2Vi1FIOaiFVOjtkcZAI8oxmBEHXgYOWWm5Np5h
        8UwK7SUmvvfEB5Rfk5hAlZzrSACRYNXEa1nJZNDe69QkYpBI6BFwu5vHEboZsDq8Hwnv6h
        Y/OBeSWpShjwMnqhJdlL+c5CXrOmryoyYmIlBtUHA2l8Ut23mHneu16/pzjg7w==
Date:   Tue, 2 May 2023 11:48:58 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Arnd Bergmann <arnd@kernel.org>, Linus Walleij <linusw@kernel.org>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lukasz Majewski <lukma@denx.de>, linux-mtd@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 22/43] dt-bindings: mtd: add DT bindings for ts7250 nand
Message-ID: <20230502114858.7152572a@xps-13>
In-Reply-To: <20230424123522.18302-23-nikita.shubin@maquefel.me>
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
        <20230424123522.18302-23-nikita.shubin@maquefel.me>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nikita,

nikita.shubin@maquefel.me wrote on Mon, 24 Apr 2023 15:34:38 +0300:

> Add YAML bindings for ts7250 NAND.
>=20
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> ---
>  .../bindings/mtd/technologic,nand.yaml        | 56 +++++++++++++++++++
>  1 file changed, 56 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mtd/technologic,nan=
d.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/mtd/technologic,nand.yaml =
b/Documentation/devicetree/bindings/mtd/technologic,nand.yaml
> new file mode 100644
> index 000000000000..3234d93a1c21
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mtd/technologic,nand.yaml
> @@ -0,0 +1,56 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mtd/technologic,nand.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Technologic Systems NAND controller
> +
> +maintainers:
> +  - Lukasz Majewski <lukma@denx.de>
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: technologic,ts7200-nand

would -nand-controller instead of -nand work as a suffix here?

You mention ts7250 in the title, should we have a more specific
compatible than ts7200 as well?

I see by looking at the mtd patch that you actually try to match both,
so they should both be defined in the bindings.

> +      - const: gen_nand

This is a old hack for very simple controllers (converted to DT probing
12 years ago). The logic used by this driver has been deprecated for
like 10 years and does not really apply to modern APIs. I would really
like to keep this driver contained with platform data coming from arch/
data only.

I suggest you create a real NAND controller driver based on the
generic one (should not be very complex, just duplicate the code so the
migration to the up-to-date API is eased) and you flag it as "must be
updated to ->exec_op() somehow. This way if someone starts the
conversion, it does not need to cope with the 5 other users of the
generic driver which anyway share nothing in common besides the
deprecated ->cmd_ctrl() backbone.

I read the comments on the cover letter, people are kind of pushing on
having this merged quickly. I am fine accepting a legacy controller
driver and migrating it to ->exec_op() later, but the current driver
conversion does not fit the approach taken years ago towards a cleaner
mtd tree.

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
> +
> +examples:
> +  - |
> +    nand-parts@0 {
> +      compatible =3D "technologic,ts7200-nand", "gen_nand";
> +      reg =3D <0x60000000 0x8000000>;
> +      #address-cells =3D <1>;
> +      #size-cells =3D <1>;
> +
> +      partition@0 {
> +        label =3D "TS-BOOTROM";
> +        reg =3D <0x00000000 0x00020000>;
> +        read-only;
> +      };

Partitions are not useful here, but if you want them, use the
partitions container instead, please.

> +
> +      partition@20000 {
> +        label =3D "Linux";
> +        reg =3D <0x00020000 0x07d00000>;
> +      };
> +
> +      partition@7d20000 {
> +        label =3D "RedBoot";
> +        reg =3D <0x07d20000 0x002e0000>;
> +        read-only;
> +      };
> +    };
> +
> +...


Thanks,
Miqu=C3=A8l
