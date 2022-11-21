Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F9A86328E1
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 16:59:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231739AbiKUP7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 10:59:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231626AbiKUP7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 10:59:34 -0500
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B2ECD14F8;
        Mon, 21 Nov 2022 07:59:30 -0800 (PST)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 0F79420003;
        Mon, 21 Nov 2022 15:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1669046366;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vIt6AuJ7GIaRWp1llDbgKYyeVQtkl3f5S6lFmrSy6FI=;
        b=ATmDkAilR0io8E4xeN8WOkQqnr6HsflrhC3AGz/D1hsPKZyqxs89B1pbmOHUe7a0Q1K5fL
        LFeq/lwxbI6H8wJaPln24ZqQiF8Al2y5/TcRU7ZJv9opEtQ8mFZpUqHR75kfiz1YxFqh/4
        pCy6hn2xxje11vaz3oKrlUtrBb+KDR1LejmD6MpHz1KaJJeVn7k2LVSnjsOoMOK2RNaopm
        qKrFBBuMQb0eOBLSnklFqVGNmLX2l9APaNQyVPPKsHF92Kt2kUedAy6wmEknKLCcoTFwvM
        +hEyDOzYbLIJMJLt2DlwfTuUgKN/cmqoTO49OWpp8i1uzYf3zoldbcMLXmAXXg==
Date:   Mon, 21 Nov 2022 16:59:21 +0100
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
Message-ID: <20221121165921.559d6538@bootlin.com>
In-Reply-To: <d9bd5075-9d06-888d-36a9-911e2d7ec5af@linaro.org>
References: <20221114111513.1436165-1-herve.codina@bootlin.com>
        <20221114111513.1436165-3-herve.codina@bootlin.com>
        <a1a7fdf4-2608-d6c9-7c7a-f8e8fae3a742@linaro.org>
        <c9a77262-f137-21d9-58af-eb4efb8aadbf@linaro.org>
        <20221115150417.513955a7@bootlin.com>
        <20221118112349.7f09eefb@bootlin.com>
        <d9bd5075-9d06-888d-36a9-911e2d7ec5af@linaro.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-redhat-linux-gnu)
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

Hi,

On Mon, 21 Nov 2022 12:43:16 +0100
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 18/11/2022 11:23, Herve Codina wrote:
> > Hi Krzysztof, Geert,
> >=20
> > On Tue, 15 Nov 2022 15:04:17 +0100
> > Herve Codina <herve.codina@bootlin.com> wrote:
> >  =20
> >> Hi Krzysztof,
> >>
> >> On Tue, 15 Nov 2022 14:07:52 +0100
> >> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> >> =20
> >>> On 15/11/2022 14:05, Krzysztof Kozlowski wrote:   =20
> >>>> On 14/11/2022 12:15, Herve Codina wrote:     =20
> >>>>> Add the h2mode property to force the USBs mode ie:
> >>>>>  - 2 hosts
> >>>>> or
> >>>>>  - 1 host and 1 device
> >>>>>
> >>>>> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> >>>>> ---
> >>>>>  .../bindings/clock/renesas,r9a06g032-sysctrl.yaml      | 10 ++++++=
++++
> >>>>>  1 file changed, 10 insertions(+)
> >>>>>
> >>>>> diff --git a/Documentation/devicetree/bindings/clock/renesas,r9a06g=
032-sysctrl.yaml b/Documentation/devicetree/bindings/clock/renesas,r9a06g03=
2-sysctrl.yaml
> >>>>> index 95bf485c6cec..f9e0a58aa4fb 100644
> >>>>> --- a/Documentation/devicetree/bindings/clock/renesas,r9a06g032-sys=
ctrl.yaml
> >>>>> +++ b/Documentation/devicetree/bindings/clock/renesas,r9a06g032-sys=
ctrl.yaml
> >>>>> @@ -39,6 +39,16 @@ properties:
> >>>>>    '#power-domain-cells':
> >>>>>      const: 0
> >>>>> =20
> >>>>> +  renesas,h2mode:
> >>>>> +    description: |
> >>>>> +      Configure the USBs mode.
> >>>>> +        - <0> : the USBs are in 1 host and 1 device mode.
> >>>>> +        - <1> : the USBs are in 2 host mode.
> >>>>> +      If the property is not present, the value used is the one al=
ready present
> >>>>> +      in the CFG_USB register (from reset or set by the bootloader=
).
> >>>>> +    $ref: /schemas/types.yaml#/definitions/uint32
> >>>>> +    enum: [0, 1]     =20
> >>>>
> >>>> 0/1 are quite cryptic. Why not making it a string which is easy to r=
ead
> >>>> and understand? Can be something like "two-hosts" and "one-host". Or
> >>>> anything you find more readable...     =20
> >>>
> >>> ...but actually you should rather make it a property of your USB
> >>> controller, not clock controller. You have two controllers and we hav=
e a
> >>> generic property for them - dr_mode.
> >>>
> >>> Best regards,
> >>> Krzysztof
> >>>    =20
> >>
> >> IMHO, this property in the USB controllers does not make sense.
> >> Indeed each controller cannot have a different 'mode'.
> >> Some controllers are USB host only (EHCI and OHCI) and the USBF
> >> controller I worked on is device only.
> >> 'h2mode' allows to choose between host or device on one of the USB
> >> but not at the USB controller level.
> >>
> >> This property should be handle outside the USB controller nodes.
> >>
> >> Currently, this node (declared as a clock node) is in fact a sysctrl
> >> node and can do some configuration not related to clocks.
> >>
> >> I agree with you something related to choosing USB Host/Device in
> >> a clock node seems strange.
> >>
> >> Some discussion were already opened related to this property and how
> >> to handle it:
> >>   https://lore.kernel.org/all/20221107182642.05a09f2f@bootlin.com/
> >>   https://lore.kernel.org/all/20221107173614.474707d7@bootlin.com/
> >> =20
> >=20
> > We advanced on this topic.
> >=20
> > First, even if 'renesas,r9a06g032-sysctrl.yaml' is present in
> > the devicetree/bindings/clock/ directory, this node is really
> > a 'system controller' node:
> > - title: Renesas RZ/N1D (R9A06G032) System Controller
> > - compatible: renesas,r9a06g032-sysctrl
> >=20
> > It handles clocks, power domains, some DMA routing, ...
> >=20
> > Now, the property 'h2mode' allows to choose between:
> >   - 2 USB hosts
> > or
> >   - 1 USB host and 1 USB device.
> >=20
> > This switching is system wide and has no reason to be done in
> > one specific USB controller. It can impact multiple devices and
> > PLL settings.
> >=20
> > The 'renesas,r9a06g032-sysctrl' node, as the system control
> > node of our system, is the best candidate to handle the property. =20
>=20
> Not necessarily. IIUC, you have:
>=20
> 1. sysctrl with some register(s) for choosing device mode
> 2. usb device or host at one address
> 3. usb host at separate address
>=20

Just to clarify, usb device and host controller are not provided by
the same IP.
We have an USB host at some address range (PCI OHCI/EHCI USB host
below a PCI bridge) and the USB device at some other address range
(below a AHB to someting bridge).
And I am not sure that only USB host or devices are affected by this
property change.

> If so then:
> A. Pretty often we have wrapper nodes for this purpose (USB, phy
> wrappers or glues) which are usually needed to configure something for a
> generic block (like Synopsys etc).
>=20
> B. Pretty often the device (so your USB host or device) needs to poke
> something in system controller registers, e.g. for power or some other
> setup.

And we did it for some items (clocks and power).

>=20
> Your case looks a lot like (B). We have many, many of such examples
> already. Actually it is exactly like that, except that it affects
> possibility of another device (e.g. choosing USB device blocks having
> host there).
>=20
> C. It looks a bit like a multi-serial-protocol interfaces (so
> UART+I2C+SPI). The difference is that such cases have all these nodes
> defined as a children of the protocol-wrapping device. Not here.
>=20
> I would propose to go with (B) unless of course it's causes some crazy
> architecture/code choices. Why? Because with exception of (C) we should
> not define properties which represent DT node choices. IOW, Choosing a
> node and compatible (e.g. usb controller as device) is enough to
> describe the hardware. No need for other properties to control some
> register in other block.

The issue with h2mode is that it affects several devices and these
devices should not be in a "running" state when the h2mode is changed.

PCI devices (host controllers) itself are not described in the DT. They
are automatically enumerated.
Changing the property in USB device controller can leads to hang on
other busses. Indeed, changing this property when a device affected
by the property is running can lead to a bus hang.

In order to do that from the USB device controller I need to synchronize
the other devices to wait for this setting before running.
1) probe sysctrl without setting h2mode
2) probe some devices (USB host and probably others)
   Stop at some point and wait for the h2mode property setting.
3) probe usb device -> Set h2mode property
4) allow devices waiting for the property setting to continue.

This synchronization seems pretty tricky and what to do if nobody
set the property (USB device controller not present or status=3D"disabled"
for instance) ?

Setting this property in sysctrl probe avoid the need for all of this
synchronization:
1) probe sysctrl and set h2mode.
2) probe other devices (no need to wait for the setting as it is already do=
ne)

The probing of the other devices (or the starting of they running state)
is guaranteed as they all need some clocks and so cannot start without
having the sysctrl node already probed.
This sysctrl node handles the clocks.

So, I think that this property must be set during sysctrl probe call.


=46rom the DT point of view, I can put the property in the USB device
controller node but I have the feeling that, if I do that, I will do
some ugly things at sysctrl probe such as parsing nodes other than the
sysctrl one to find the property and set h2mode accordingly :(

>=20
>=20
> >=20
> > In order to be less cryptic in the property value, what do you
> > think about:
> >   renesas,h2mode:
> >     - one-dev : the USBs are in 1 host and 1 device mode.
> >     - only-hosts : the USBs are in 2 hosts mode. =20
>=20
> Name looks better, if we go this path.

Ok, I will take care if we go this path.

>=20
> >=20
> > With these details and change on the property value,
> > Is it ok for you to have the 'renesas,h2mode' property
> > in the 'renesas,r9a06g032-sysctrl' node ? =20
>=20
>=20

Regards,
Herv=C3=A9

--=20
Herv=C3=A9 Codina, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
