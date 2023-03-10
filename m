Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7E16B410B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 14:49:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbjCJNs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 08:48:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbjCJNsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 08:48:55 -0500
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C8AF85682;
        Fri, 10 Mar 2023 05:48:43 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id EB859240009;
        Fri, 10 Mar 2023 13:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1678456122;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HB/pbQhDhg7B7QwfyKv1SCZm0Tn/atunyx/ifJpw/FI=;
        b=l8BtWiMIBPishNyfN2XkcAhzEoCELEatIGy3uNHLtZrfy80CSHAAHG8trCJB6CXSVnq/8l
        5yaOpLOpO2JnaSxDlvbDSw+l9CUt9C9dVmPdyPJvrg07SbG+1R5y44QboMKl+BOxFI7nOL
        PhatGwcOAZp87VxkE0vYKejqyYw5g5/w+Di3HbSqMpVC0iEXl1MRBLD3q7GIme8ZovIG68
        /v3tLpH687kv1DwHgUpeJGzwfz81mXbmdhw0NyGhFa8RwxQFSZjmY+3uxGS+UOllTC+UH9
        LQSuzfi6dXx1veLw+J5Mof8aYRWWng9f4secjTO6DJC+ztegJdDWZ7j6S9pqRQ==
Date:   Fri, 10 Mar 2023 14:48:40 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Walle <michael@walle.cc>, devicetree@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH] dt-bindings: nvmem: allow MTD to be explicitly an NVMEM
 provider
Message-ID: <20230310144840.5203fe50@xps-13>
In-Reply-To: <20230310105330.14181-1-zajec5@gmail.com>
References: <20230310105330.14181-1-zajec5@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafa=C5=82,

zajec5@gmail.com wrote on Fri, 10 Mar 2023 11:53:30 +0100:

> From: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
>=20
> There are a lot of devices with NVMEM content stored in MTD devices in
> relevant partitions. Add a DT binding for marking such partitions.
>=20
> Note: Linux already treats every MTD partition as NVMEM provider so in
> general it doesn't need to care about this binding. It's meant just to
> make DT clearer in describing hardware.
>=20
> Signed-off-by: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
> ---
> As explained in commit body this isn't really needed for Linux. I
> thought it'd be a small nice addition for writing clear DTS files.
> ---
>  .../devicetree/bindings/nvmem/mtd.yaml        | 52 +++++++++++++++++++
>  1 file changed, 52 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/nvmem/mtd.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/nvmem/mtd.yaml b/Documenta=
tion/devicetree/bindings/nvmem/mtd.yaml
> new file mode 100644
> index 000000000000..7435b2803cf9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/nvmem/mtd.yaml
> @@ -0,0 +1,52 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/nvmem/mtd.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MTD access based NVMEM
> +
> +description: |
> +  MTD partitions can be NVMEM providers. This binding allows explicitly =
marking
> +  such partitions.

We already have that, it's nvmem-cell? I understand what you want to
do, but I think it suffers from a common problem, see below.

> +  The exact way of handling MTD partition content (NVMEM cells) should be
> +  described using a proper NVMEM layout.

Ok so I believe this is another solution for the layout offset proposed
by Michael. Except that it only fixes it for mtd. I think I would
prefer the former solution which handles all nvmem cases.

> +
> +maintainers:
> +  - Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
> +
> +allOf:
> +  - $ref: nvmem.yaml#
> +  - $ref: /schemas/mtd/partitions/partition.yaml#
> +
> +properties:
> +  compatible:
> +    const: mtd-nvmem
> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - reg
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    partitions {
> +        compatible =3D "fixed-partitions";
> +        #address-cells =3D <1>;
> +        #size-cells =3D <1>;
> +
> +        partition@0 {
> +            compatible =3D "mtd-nvmem";

Actually there has been valid push-back from devlink gurus against stale
compatibles (on a device-driver point of view) like that. Maybe
something like this instead:

	partition@x{
		<mtd-nvmem-property>

?

> +            reg =3D <0x0 0x40000>;
> +            label =3D "device-data";
> +
> +            nvmem-layout {
> +                /* Just a dummy example: Kontron can be found on OTP act=
ually */
> +                compatible =3D "kontron,sl28-vpd";

The Onie tlv compatible would perfectly apply here.

> +            };
> +        };
> +    };


Thanks,
Miqu=C3=A8l
