Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 797EB68AFB9
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 13:33:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbjBEMdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 07:33:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjBEMdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 07:33:14 -0500
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F26B7D82;
        Sun,  5 Feb 2023 04:33:12 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 315CWlu4112097;
        Sun, 5 Feb 2023 06:32:47 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1675600367;
        bh=QnYw+4j+c0tSorkl20tTL9KSqtvcV9iclc90eBc99JU=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=nBndfUAEM0EQLOULmoKyEV5XFqSV7L6X11ZJa+aDwFCs6qWaXHHIJ+8HFHnE4vrry
         S/WalWjDzsV6k14spUO5j5jHV30jPyjGnxjib7vICCaU7U+CjYsI+0J/tlNTRiFJHs
         kiDGhDkZ8yj9J9+JrZ0DftuE8iI4EAbFJu2P/S6I=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 315CWlWu010899
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 5 Feb 2023 06:32:47 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Sun, 5
 Feb 2023 06:32:47 -0600
Received: from DLEE101.ent.ti.com ([fe80::91ee:60bc:bfb7:851c]) by
 DLEE101.ent.ti.com ([fe80::91ee:60bc:bfb7:851c%18]) with mapi id
 15.01.2507.016; Sun, 5 Feb 2023 06:32:47 -0600
From:   "Ding, Shenghao" <shenghao-ding@ti.com>
To:     Rob Herring <robh@kernel.org>, Shenghao Ding <13916275206@139.com>
CC:     "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "Lu, Kevin" <kevin-lu@ti.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH v5] ASoC: dt-bindings: Add tas2781
 amplifier
Thread-Topic: [EXTERNAL] Re: [PATCH v5] ASoC: dt-bindings: Add tas2781
 amplifier
Thread-Index: AQHZOBqB7tvoGVc4E0OYTlg50DrTvq7AQ5CQ
Date:   Sun, 5 Feb 2023 12:32:47 +0000
Message-ID: <857038e20b2944e89ef433097374041d@ti.com>
References: <20230203040115.27321-1-13916275206@139.com>
 <20230203215724.GA938713-robh@kernel.org>
In-Reply-To: <20230203215724.GA938713-robh@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.250.160.107]
x-exclaimer-md-config: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob=20
Thanks for your review comments. My answers are inline
with prefix [DING]

-----Original Message-----
From: Rob Herring <robh@kernel.org>=20
Sent: Saturday, February 4, 2023 5:57 AM
To: Shenghao Ding <13916275206@139.com>
Cc: krzysztof.kozlowski+dt@linaro.org; broonie@kernel.org; lgirdwood@gmail.=
com; Lu, Kevin <kevin-lu@ti.com>; Ding, Shenghao <shenghao-ding@ti.com>; al=
sa-devel@alsa-project.org; devicetree@vger.kernel.org; linux-kernel@vger.ke=
rnel.org
Subject: [EXTERNAL] Re: [PATCH v5] ASoC: dt-bindings: Add tas2781 amplifier

On Fri, Feb 03, 2023 at 12:01:15PM +0800, Shenghao Ding wrote:
> Create tas2781.yaml for tas2781 driver.
>=20
> Signed-off-by: Shenghao Ding <13916275206@139.com>
>=20
> ---
> Changes in v5:
>  - Drop the full stop in the Subject.
>  - Drop the reset-gpios reference to gpio.txt.
>  - Add Changelog.
>  Changes to be committed:
> 	new file:   Documentation/devicetree/bindings/sound/ti,tas2781.yaml
> ---
>  .../devicetree/bindings/sound/ti,tas2781.yaml | 87=20
> +++++++++++++++++++
>  1 file changed, 87 insertions(+)
>  create mode 100644=20
> Documentation/devicetree/bindings/sound/ti,tas2781.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/sound/ti,tas2781.yaml=20
> b/Documentation/devicetree/bindings/sound/ti,tas2781.yaml
> new file mode 100644
> index 000000000000..8af44792a904
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/ti,tas2781.yaml
> @@ -0,0 +1,87 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) # Copyright=20
> +(C) 2022 - 2023 Texas Instruments Incorporated %YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/ti,tas2781.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Texas Instruments TAS2781 SmartAMP
> +
> +maintainers:
> +  - Shenghao Ding <shenghao-ding@ti.com>
> +  - Kevin Lu <kevin-lu@ti.com>
> +
> +description: |

Don't need '|' unless you need line endings preserved. Wrap lines at 80 cha=
rs.
[DING] Accept this comment. I will remove all the "|" after "description:"
> +  The TAS2781 is a mono, digital input Class-D audio amplifier =20
> + optimized for efficiently driving high peak power into small =20
> + loudspeakers. Integrated an on-chip DSP supports Texas Instruments =20
> + Smart Amp speaker protection algorithm. The integrated speaker =20
> + voltage and current sense provides for real time  monitoring of=20
> + loudspeaker behavior.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ti,tas2781
> +
> +  reg:
> +    maxItems: 1
> +    description: |
> +      I2C address of the device can be in range from 0x38 to 0x40.

Express as constraints instead:

items:
  minimum: 0x38
  maximum: 0x40
[DING] Accept this comment.
Or was this the range of the slot addresses?
[DING] Yes.
> +
> +  reset-gpios:
> +    maxItems: 1
> +    description: |
> +      A GPIO line handling reset of the chip. As the line is active high=
,
> +      it should be marked GPIO_ACTIVE_HIGH.

The description doesn't add anything. Drop.

> +
> +  interrupts:
> +    maxItems: 1
> +
> +  ti,audio-slots:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    minItems: 1
> +    maxItems: 4
> +    description: |
> +      I2c address of the device for different audio slots,

I2C

> +      useless in mono case.
> +
> +  ti,broadcast-addr:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      Generic i2c address for all the tas2781 devices in

I2C

Be consistent.
[DING] Accept this comment.
> +      purpose of I2C broadcast during the multi-device
> +      writes, useless in mono case.
> +
> +  '#sound-dai-cells':
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +   #include <dt-bindings/gpio/gpio.h>
> +   i2c {
> +     /* example with quad support, such as tablet or pad device */
> +     #address-cells =3D <1>;
> +     #size-cells =3D <0>;
> +     quad: codec@38 {
> +       compatible =3D "ti,tas2781";
> +       reg =3D <0x38>;
> +       #sound-dai-cells =3D <1>;
> +       reset-gpios =3D < &gpio1 10 GPIO_ACTIVE_HIGH >;
> +       interrupt-parent =3D <&gpio1>;
> +       interrupts =3D <15>;
> +       ti,audio-slots =3D < 0x38 /* topleft-channel */
> +                          0x39 /* topright-channel */
> +                          0x3a /* bottomleft-channel */
> +                          0x3b /* bottomright-channel */

Do these vary? Or the slot addresses are fixed and which slots are used var=
ies?=20
[DING] Yes, these will vary with different projects. In some projects there=
're two addresses,=20
in some there're six addresses, in others the I2C addresses may be out of o=
rder.=20
> +                        >;
> +       ti,broadcast-addr =3D <0x40>;

I tend to think the I2C addresses should all be in 'reg'.
[DING] broadcast-addr item is used in multiple tas2781s case to enable the=
=20
broadcast mode to download dsp fw  simultaneously. Without this item,=20
broadcast mode will be disabled, and downloading dsp fw will be one by one.
As you know, not all project will enable the broadcast feature, so we have =
to=20
add this item. As to reg item, it is only stored the primary tas2781 I2C ad=
dr.
> +     };
> +   };
> +...
> --
> 2.34.1
>=20
>=20
