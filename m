Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED6516337F2
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 10:07:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233120AbiKVJH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 04:07:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233151AbiKVJHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 04:07:16 -0500
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F9C345ECE;
        Tue, 22 Nov 2022 01:07:12 -0800 (PST)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 4ABDD20020;
        Tue, 22 Nov 2022 09:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1669108030;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6Dz9Z+NGn0lP9RbIYv43VrueImmxYaOjVbuyx5C9qq4=;
        b=UEO3XOz82Lnuu6MKsFKK2Eg38zIJFP7P2/65MotSeCr7EDM545DwJTe9TFRch/FYY/maNR
        TemkYuWp/M16uAQ0dKjNIpYMJZcYwPL6GoxHzmUPXbCWdgmoaRLovylhneNMQwOermC6P+
        gpsPElqwP4NraCNdlmMAxfL7r31pfc41tSFlBXNXHO0N4lJofh/HgibuTnzlxpMiaWj39S
        J3I//MbJTZQ1ph7BhRUHTHj1IvmQGDpYDOoWwnH0JZzsPhPEkyI9D0IGRGrCWr46OoSolU
        0lvF2BoZVjYRzBFUnabESwT3ADRfDnYkpoc1yZjAOtkGoZGXHTBMcOUeZMMr+A==
Date:   Tue, 22 Nov 2022 10:07:06 +0100
From:   Herve Codina <herve.codina@bootlin.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
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
Message-ID: <20221122100706.739cec4d@bootlin.com>
In-Reply-To: <191a7f3e-0733-8058-5829-fe170a06dd5a@linaro.org>
References: <20221114111513.1436165-1-herve.codina@bootlin.com>
        <20221114111513.1436165-3-herve.codina@bootlin.com>
        <a1a7fdf4-2608-d6c9-7c7a-f8e8fae3a742@linaro.org>
        <c9a77262-f137-21d9-58af-eb4efb8aadbf@linaro.org>
        <20221115150417.513955a7@bootlin.com>
        <20221118112349.7f09eefb@bootlin.com>
        <d9bd5075-9d06-888d-36a9-911e2d7ec5af@linaro.org>
        <20221121165921.559d6538@bootlin.com>
        <4e54bfb4-bb67-73b8-f58f-56797c5925d3@linaro.org>
        <CAMuHMdU=-ZUzHSb0Z8P3wsLK9cgGVCPdMi6AcjTH23tUQEeEBA@mail.gmail.com>
        <a3e1332e-fc15-8a78-0ddd-6d5b26197f11@linaro.org>
        <CAMuHMdXzqZB4sKMmroriq5oPp7z=yXiHk=+eQKwSyPhNbYqgYA@mail.gmail.com>
        <1f12883b-1e37-7f2b-f9e9-c8bad290a133@linaro.org>
        <CAMuHMdVbzg8y2So+A=z8nUwHMoL+XKUrvoXp9QdbCnUve1_Atw@mail.gmail.com>
        <191a7f3e-0733-8058-5829-fe170a06dd5a@linaro.org>
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

On Tue, 22 Nov 2022 09:42:48 +0100
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 22/11/2022 09:25, Geert Uytterhoeven wrote:
> > Hi Krzysztof,
> >=20
> > On Tue, Nov 22, 2022 at 8:45 AM Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote: =20
> >> On 21/11/2022 21:46, Geert Uytterhoeven wrote: =20
> >>>> This does not change anything. Herve wrote:
> >>>> =20
> >>>>> probe some devices (USB host and probably others) =20
> >>>>
> >>>> Why some can be probed earlier and some not, if there are no
> >>>> dependencies? If there are dependencies, it's the same case with sys=
ctrl
> >>>> touching the register bit and the USB controller touching it (as well
> >>>> via syscon, but that's obvious, I assume).
> >>>>
> >>>> Where is the synchronization problem? =20
> >>>
> >>> The h2mode bit (and probably a few other controls we haven't figured =
out
> >>> yet) in the sysctrl must be set before any of the USB devices is acti=
ve.
> >>> Hence it's safest for the sysctrl to do this before any of the USB dr=
ivers
> >>> probes. =20
> >>
> >> Again, this does not differ from many, many of other devices. All of
> >> them must set something in system controller block, before they start
> >> operating (or at specific time). It's exactly the same everywhere. =20
> >=20
> > The issue here is that there are two _different drivers_ (USB host
> > and device). When both are modular, and the driver that depends on the
> > sysctrl setting is loaded second, you have a problem: the sysctrl change
> > must not be done when the first driver is already using the hardware.
> >=20
> > Hence the sysctrl driver should take care of it itself during early
> > initialization (it's the main clock controller, so it's a dependency
> > for all other I/O device drivers). =20
>=20
> I assumed you have there bit for the first device (which can switch
> between USB host and USB device) to choose appropriate mode. The
> bindings also expressed this - "the USBs are". Never said anything about
> dependency between these USBs.
>=20
> Are you saying that the mode for first device cannot be changed once the
> second device (which is only host) is started? IOW, the mode setup must
> happen before any of these devices are started?
>=20
> Anyway with sysctrl approach you will have dependency and you cannot
> rely on clock provider-consumer relationship to order that dependency.
> What if you make all clocks on and do not take any clocks in USB device?
> Broken dependency. What if you want to use this in a different SoC,
> where the sysctrl does not provide clocks? Broken dependency.

The issue is really related to the Renesas sysctrl itself and not related
to the USB drivers themselves.
=46rom the drivers themselves, the issue is not seen (I mean the driver
takes no specific action related to this issue).
If we change the SOC, the issue will probably not exist anymore.

>=20
> You have here in such case parent-child dependency, not
> provider-consumer. Just like for all serial-protocol engines (I2C/UART/SP=
I).
>=20
> Best regards,
> Krzysztof
>=20



--=20
Herv=C3=A9 Codina, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
