Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C711629B76
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 15:04:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbiKOOEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 09:04:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbiKOOEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 09:04:34 -0500
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 246AD2B249;
        Tue, 15 Nov 2022 06:04:27 -0800 (PST)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 80E43240007;
        Tue, 15 Nov 2022 14:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1668521066;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m52RNtELDDNqeiQtokfOg67uyM39sRsLuDiZvZRE3B0=;
        b=NudmAyB06AsNNnCsJt4iwJTc6oYb518K4zCuIOTgbH8Jph8xyl9lERBCB2rnRwhIGlKBQp
        0SCkDrVS9j7Y6KCJBn7R/kjc9dvG7aYqFHfIRuJSmjqhK2bOqQeAl44Si8MpfBCh22fcNk
        NlRqtIHOgh45m2guJrdSSJ7SxCHrVVUvxxzkG6xjm6yA9uxRs9d4YUexh8zpT6WRdv0RTk
        PGhDPkAejvpA8OGDZ98Mz+prO9BXnSRl7YWadgkJb8aicuF1+vFP11gcp+xcyUH9SQ0rym
        SAsKehe8H7y8d99gTxn8KMhegCxtNBHK1+2Xsdo4DLgiWtxwdUHLQ2QRvebGqQ==
Date:   Tue, 15 Nov 2022 15:04:17 +0100
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
Message-ID: <20221115150417.513955a7@bootlin.com>
In-Reply-To: <c9a77262-f137-21d9-58af-eb4efb8aadbf@linaro.org>
References: <20221114111513.1436165-1-herve.codina@bootlin.com>
        <20221114111513.1436165-3-herve.codina@bootlin.com>
        <a1a7fdf4-2608-d6c9-7c7a-f8e8fae3a742@linaro.org>
        <c9a77262-f137-21d9-58af-eb4efb8aadbf@linaro.org>
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

Hi Krzysztof,

On Tue, 15 Nov 2022 14:07:52 +0100
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 15/11/2022 14:05, Krzysztof Kozlowski wrote:
> > On 14/11/2022 12:15, Herve Codina wrote: =20
> >> Add the h2mode property to force the USBs mode ie:
> >>  - 2 hosts
> >> or
> >>  - 1 host and 1 device
> >>
> >> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> >> ---
> >>  .../bindings/clock/renesas,r9a06g032-sysctrl.yaml      | 10 ++++++++++
> >>  1 file changed, 10 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/clock/renesas,r9a06g032=
-sysctrl.yaml b/Documentation/devicetree/bindings/clock/renesas,r9a06g032-s=
ysctrl.yaml
> >> index 95bf485c6cec..f9e0a58aa4fb 100644
> >> --- a/Documentation/devicetree/bindings/clock/renesas,r9a06g032-sysctr=
l.yaml
> >> +++ b/Documentation/devicetree/bindings/clock/renesas,r9a06g032-sysctr=
l.yaml
> >> @@ -39,6 +39,16 @@ properties:
> >>    '#power-domain-cells':
> >>      const: 0
> >> =20
> >> +  renesas,h2mode:
> >> +    description: |
> >> +      Configure the USBs mode.
> >> +        - <0> : the USBs are in 1 host and 1 device mode.
> >> +        - <1> : the USBs are in 2 host mode.
> >> +      If the property is not present, the value used is the one alrea=
dy present
> >> +      in the CFG_USB register (from reset or set by the bootloader).
> >> +    $ref: /schemas/types.yaml#/definitions/uint32
> >> +    enum: [0, 1] =20
> >=20
> > 0/1 are quite cryptic. Why not making it a string which is easy to read
> > and understand? Can be something like "two-hosts" and "one-host". Or
> > anything you find more readable... =20
>=20
> ...but actually you should rather make it a property of your USB
> controller, not clock controller. You have two controllers and we have a
> generic property for them - dr_mode.
>=20
> Best regards,
> Krzysztof
>=20

IMHO, this property in the USB controllers does not make sense.
Indeed each controller cannot have a different 'mode'.
Some controllers are USB host only (EHCI and OHCI) and the USBF
controller I worked on is device only.
'h2mode' allows to choose between host or device on one of the USB
but not at the USB controller level.

This property should be handle outside the USB controller nodes.

Currently, this node (declared as a clock node) is in fact a sysctrl
node and can do some configuration not related to clocks.

I agree with you something related to choosing USB Host/Device in
a clock node seems strange.

Some discussion were already opened related to this property and how
to handle it:
  https://lore.kernel.org/all/20221107182642.05a09f2f@bootlin.com/
  https://lore.kernel.org/all/20221107173614.474707d7@bootlin.com/

Regards,
Herv=C3=A9

--=20
Herv=C3=A9 Codina, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
