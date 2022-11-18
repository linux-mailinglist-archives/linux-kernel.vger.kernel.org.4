Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0496762F277
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 11:24:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241766AbiKRKYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 05:24:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241685AbiKRKYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 05:24:07 -0500
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B78A82BF9;
        Fri, 18 Nov 2022 02:24:02 -0800 (PST)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 79BA9240012;
        Fri, 18 Nov 2022 10:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1668767041;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gAcx7QAUPrBgKxdDsMkzSjOogdyVGhpWAUFHST1vmNg=;
        b=if+/MVMSSjiNWlYdIqPhPPvdvL3j3E+LU3MfyW/y2pI2vFZO80VfbWNzZAbvYzFLTIDjDV
        NPmMGGKojW5nGz+AIQz/gSYLZgnLoTsBmRwvZH2oBPhJAm5zCSTJmkoZ8o6o+TAZDWiypp
        DBtObKz5Min24uivAmZIRVl3bGmpJjzG6iacNZVhTlZotFvsyMEuOcv8cLRyxPXh+ptA+x
        kGRafjawWQ00oZCQ+/rnEewwpxMFpQmZmHYUkKwFbSpHfrecZxFbgB+krRglPrkNyYJL+q
        aKeHPrQVs9pjro+ghTQ07JW+5IYGA9gFPWQQi3migO/faekywO39QVkvKETh2w==
Date:   Fri, 18 Nov 2022 11:23:49 +0100
From:   Herve Codina <herve.codina@bootlin.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH v2 2/7] dt-bindings: clock: renesas,r9a06g032-sysctrl:
 Add h2mode property
Message-ID: <20221118112349.7f09eefb@bootlin.com>
In-Reply-To: <20221115150417.513955a7@bootlin.com>
References: <20221114111513.1436165-1-herve.codina@bootlin.com>
        <20221114111513.1436165-3-herve.codina@bootlin.com>
        <a1a7fdf4-2608-d6c9-7c7a-f8e8fae3a742@linaro.org>
        <c9a77262-f137-21d9-58af-eb4efb8aadbf@linaro.org>
        <20221115150417.513955a7@bootlin.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof, Geert,

On Tue, 15 Nov 2022 15:04:17 +0100
Herve Codina <herve.codina@bootlin.com> wrote:

> Hi Krzysztof,
>=20
> On Tue, 15 Nov 2022 14:07:52 +0100
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
>=20
> > On 15/11/2022 14:05, Krzysztof Kozlowski wrote: =20
> > > On 14/11/2022 12:15, Herve Codina wrote:   =20
> > >> Add the h2mode property to force the USBs mode ie:
> > >>  - 2 hosts
> > >> or
> > >>  - 1 host and 1 device
> > >>
> > >> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> > >> ---
> > >>  .../bindings/clock/renesas,r9a06g032-sysctrl.yaml      | 10 +++++++=
+++
> > >>  1 file changed, 10 insertions(+)
> > >>
> > >> diff --git a/Documentation/devicetree/bindings/clock/renesas,r9a06g0=
32-sysctrl.yaml b/Documentation/devicetree/bindings/clock/renesas,r9a06g032=
-sysctrl.yaml
> > >> index 95bf485c6cec..f9e0a58aa4fb 100644
> > >> --- a/Documentation/devicetree/bindings/clock/renesas,r9a06g032-sysc=
trl.yaml
> > >> +++ b/Documentation/devicetree/bindings/clock/renesas,r9a06g032-sysc=
trl.yaml
> > >> @@ -39,6 +39,16 @@ properties:
> > >>    '#power-domain-cells':
> > >>      const: 0
> > >> =20
> > >> +  renesas,h2mode:
> > >> +    description: |
> > >> +      Configure the USBs mode.
> > >> +        - <0> : the USBs are in 1 host and 1 device mode.
> > >> +        - <1> : the USBs are in 2 host mode.
> > >> +      If the property is not present, the value used is the one alr=
eady present
> > >> +      in the CFG_USB register (from reset or set by the bootloader).
> > >> +    $ref: /schemas/types.yaml#/definitions/uint32
> > >> +    enum: [0, 1]   =20
> > >=20
> > > 0/1 are quite cryptic. Why not making it a string which is easy to re=
ad
> > > and understand? Can be something like "two-hosts" and "one-host". Or
> > > anything you find more readable...   =20
> >=20
> > ...but actually you should rather make it a property of your USB
> > controller, not clock controller. You have two controllers and we have a
> > generic property for them - dr_mode.
> >=20
> > Best regards,
> > Krzysztof
> >  =20
>=20
> IMHO, this property in the USB controllers does not make sense.
> Indeed each controller cannot have a different 'mode'.
> Some controllers are USB host only (EHCI and OHCI) and the USBF
> controller I worked on is device only.
> 'h2mode' allows to choose between host or device on one of the USB
> but not at the USB controller level.
>=20
> This property should be handle outside the USB controller nodes.
>=20
> Currently, this node (declared as a clock node) is in fact a sysctrl
> node and can do some configuration not related to clocks.
>=20
> I agree with you something related to choosing USB Host/Device in
> a clock node seems strange.
>=20
> Some discussion were already opened related to this property and how
> to handle it:
>   https://lore.kernel.org/all/20221107182642.05a09f2f@bootlin.com/
>   https://lore.kernel.org/all/20221107173614.474707d7@bootlin.com/
>=20

We advanced on this topic.

First, even if 'renesas,r9a06g032-sysctrl.yaml' is present in
the devicetree/bindings/clock/ directory, this node is really
a 'system controller' node:
- title: Renesas RZ/N1D (R9A06G032) System Controller
- compatible: renesas,r9a06g032-sysctrl

It handles clocks, power domains, some DMA routing, ...

Now, the property 'h2mode' allows to choose between:
  - 2 USB hosts
or
  - 1 USB host and 1 USB device.

This switching is system wide and has no reason to be done in
one specific USB controller. It can impact multiple devices and
PLL settings.

The 'renesas,r9a06g032-sysctrl' node, as the system control
node of our system, is the best candidate to handle the property.

In order to be less cryptic in the property value, what do you
think about:
  renesas,h2mode:
    - one-dev : the USBs are in 1 host and 1 device mode.
    - only-hosts : the USBs are in 2 hosts mode.

With these details and change on the property value,
Is it ok for you to have the 'renesas,h2mode' property
in the 'renesas,r9a06g032-sysctrl' node ?


Regards,
Herv=C3=A9

--=20
Herv=C3=A9 Codina, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
