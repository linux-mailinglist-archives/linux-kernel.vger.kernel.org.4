Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3514E712D70
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 21:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242258AbjEZT1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 15:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbjEZT1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 15:27:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7729913D;
        Fri, 26 May 2023 12:27:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CEDDF652F2;
        Fri, 26 May 2023 19:27:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8380CC4339B;
        Fri, 26 May 2023 19:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685129249;
        bh=3uRdBp40YhYXT8GRorK2WbmkmiCKqXai1mhNyaEzUFA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Aw8QBIKuDebB99fs+5bwbbOHNnpgYjXo39IRgpRsXFjDJFoXlZ3yvWBT5biMQF7HB
         kA0pogT51fjNT2zANbz/7sWES5gNnooq5OeVozMFSOe20JT7RzuYqV4nXnmbItETkY
         XLra+6Jv8yvPRki9CsWCWH2a2p1kYV+EziKTSBjjsDu6Do+1BAHj5Ux5JGYt7lZCpv
         KYTzjn40wmg0i+W9pXMK+wX3IDHVDcCeFt5odv738KN3qat1BZPvgtQtD64JWWdaYl
         2zyBuVWdr6St0Hq9qlsllQpUNzb2Vp8q9Lgusl+5XkCfVnFUrd5iuxkk5lH/i3n5kn
         0AnMLFMVrLo9A==
Date:   Fri, 26 May 2023 20:27:24 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Fred Treven <fred.treven@cirrus.com>
Cc:     Ben Bright <ben.bright@cirrus.com>,
        James Ogletree <james.ogletree@cirrus.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Simon Trimmer <simont@opensource.cirrus.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        patches@opensource.cirrus.com, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        lee@kernel.org
Subject: Re: [PATCH v2 1/5] dt-bindings: input: cirrus,cs40l26: Support for
 CS40L26
Message-ID: <20230526-swapping-clay-d114144380a4@spud>
References: <1685059471-9598-1-git-send-email-fred.treven@cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tV7bW6DEZdfhDFt9"
Content-Disposition: inline
In-Reply-To: <1685059471-9598-1-git-send-email-fred.treven@cirrus.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tV7bW6DEZdfhDFt9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Yo Fred,

Tooling does not like your series very much, prob the missing v2's on
some patches:
	Grabbing thread from lore.kernel.org/all/1685059471-9598-1-git-send-email-=
fred.treven%40cirrus.com/t.mbox.gz
	Checking for newer revisions
	Grabbing search results from lore.kernel.org
	Analyzing 6 messages in the thread
	Will use the latest revision: v2
	You can pick other revisions using the -vN flag
	Checking attestation on all messages, may take a moment...
	---
	  =E2=9C=93 [PATCH v2 1/5] dt-bindings: input: cirrus,cs40l26: Support for=
 CS40L26
	    =E2=9C=93 Signed: DKIM/cirrus.com
	    + Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
	  =E2=9C=93 [PATCH v2 2/5] Input: cs40l26 - Support for CS40L26 Haptic Dev=
ice
	    =E2=9C=93 Signed: DKIM/cirrus.com
	    + Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
	  ERROR: missing [3/5]!
	  ERROR: missing [4/5]!
	  ERROR: missing [5/5]!
=09
On Thu, May 25, 2023 at 07:04:27PM -0500, Fred Treven wrote:
> Introduce required basic devicetree parameters for the
> initial commit of CS40L26.
>=20
> Signed-off-by: Fred Treven <fred.treven@cirrus.com>
> ---
>  .../devicetree/bindings/input/cirrus,cs40l26.yaml  | 102 +++++++++++++++=
++++++
>  MAINTAINERS                                        |  10 ++
>  2 files changed, 112 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/cirrus,cs40l2=
6.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/input/cirrus,cs40l26.yaml =
b/Documentation/devicetree/bindings/input/cirrus,cs40l26.yaml
> new file mode 100644
> index 000000000000..9cbc964ebded
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/cirrus,cs40l26.yaml
> @@ -0,0 +1,102 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/input/cirrus,cs40l26.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Cirrus Logic CS40L26 Boosted Haptic Amplifier
> +
> +maintainers:
> +  - Fred Treven <fred.treven@cirrus.com>
> +
> +description:
> +  CS40L26 is a Boosted Haptic Driver with Integrated DSP and Waveform Me=
mory
> +  with Advanced Closed Loop Algorithms and LRA protection
> +
> +properties:
> +  compatible:
> +    enum:
> +      - cirrus,cs40l26a
> +      - cirrus,cs40l26b
> +      - cirrus,cs40l27a
> +      - cirrus,cs40l27b

I had a _brief_ look at the driver - you don't seem to have any match
data, so are all of these devices actually compatible with eachother?

IOW, should this be:
properties:
  compatible:
    oneOf:
      - items:
          - enum:
              - cirrus,cs40l26b
              - cirrus,cs40l27a
              - cirrus,cs40l27b
          - const: cirrus,cs40l26a

      - const: cirrus,cs40l26a

And then drop all but the cs40l26a in the driver? Apologies if I missed
some difference in there.

> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  reset-gpios:
> +    maxItems: 1
> +
> +  VA-supply:
> +    description: Regulator for VA analog voltage
> +
> +  VP-supply:
> +    description: Regulator for VP peak voltage
> +
> +  cirrus,bst-ipk-microamp:

Are these namings ripped from a datasheet? "bst-ipk" doesn't immediately
mean anything to me, but I am not familiar with these devices.

> +    description:
> +      Maximum amount of current that can be drawn by the device's boost =
converter.
> +    multipleOf: 50000
> +    minimum: 1600000
> +    maximum: 4800000
> +    default: 4500000
> +
> +  cirrus,bst-ctl-microvolt:

Ditto here. If there aren't rips, then maybe it'd be a good idea to use
full words.

> +    description: Maximum target voltage to which DSP may increase the VB=
ST supply.
> +    multipleOf: 50000
> +    minimum: 2550000
> +    maximum: 11000000
> +    default: 11000000
> +
> +  cirrus,bst-exploratory-mode-disable:

This one is a lot better ;)

> +    description:
> +      Disable boost exploratory mode.
> +
> +      In exploratory mode the analog maximum peak current limit of 4.5 A
> +      (tolerance of + 160 mA) will be applied. This is required for the
> +      device to successfully detect a boost inductor short.
> +
> +      Boost exploratory mode allows the device to overshoot the set boos=
t peak
> +      current limit (i.e. if current peak limit is set to 2.5 A to prote=
ct the
> +      battery inductor, the current limit will be opened up to 4.5 A for
> +      several milliseconds at boost startup).
> +      This has potential to damage the boost inductor.
> +
> +      Disabling this mode will prevent this from happening; it will also
> +      prevent the device from detecting boost inductor short errors.
> +    type: boolean
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - reset-gpios
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/input/input.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    i2c {
> +      #address-cells =3D <1>;
> +      #size-cells =3D <0>;
> +
> +      cs40l26@58 {

Generally using generic node names what we want, so something matching
the class of device. Section 2.2.2 "Generic Names Recommendation" of the
dt spec contains a bunch of ones to pick from, but I don't really know
where "haptic amplifier" fits in!

Cheers,
Conor.

> +        compatible =3D "cirrus,cs40l26a";
> +        reg =3D <0x58>;
> +        interrupt-parent =3D <&gpio>;
> +        interrupts =3D <57 IRQ_TYPE_LEVEL_LOW>;
> +        reset-gpios =3D <&gpio 54 GPIO_ACTIVE_LOW>;
> +        VA-supply =3D <&dummy_vreg>;
> +        VP-supply =3D <&dummy_vreg>;
> +        cirrus,bst-ctl-microvolt =3D <2600000>;
> +        cirrus,bst-ipk-microamp =3D <1650000>;
> +        cirrus,bst-exploratory-mode-disable;
> +      };
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2b073facf399..d72ed4957b0b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4926,6 +4926,16 @@ L:	netdev@vger.kernel.org
>  S:	Maintained
>  F:	drivers/net/ethernet/cirrus/ep93xx_eth.c
> =20
> +CIRRUS LOGIC HAPTICS DRIVER
> +M:	Fred Treven <fred.treven@cirrus.com>
> +M:	Ben Bright <ben.bright@cirrus.com>
> +M:	James Ogletree <james.ogletree@cirrus.com>
> +L:	patches@opensource.cirrus.com
> +S:	Supported
> +W:	https://github.com/CirrusLogic/linux-drivers/wiki
> +T:	git https://github.com/CirrusLogic/linux-drivers.git
> +F:	Documentation/devicetree/bindings/input/cirrus,cs40l26.yaml
> +
>  CIRRUS LOGIC LOCHNAGAR DRIVER
>  M:	Charles Keepax <ckeepax@opensource.cirrus.com>
>  M:	Richard Fitzgerald <rf@opensource.cirrus.com>
> --=20
> 2.7.4
>=20

--tV7bW6DEZdfhDFt9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZHEIGwAKCRB4tDGHoIJi
0t6QAP9E9dWzbERra4geP23ilLfikDeJOJuvzCU/Wj4emI0vxgEAijltpWlRkGHl
sHf604wO5huXKXqOPeaKJeTN4KpeEQA=
=Gwos
-----END PGP SIGNATURE-----

--tV7bW6DEZdfhDFt9--
