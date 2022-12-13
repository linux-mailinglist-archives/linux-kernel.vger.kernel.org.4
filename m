Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD4564B604
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 14:23:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234720AbiLMNXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 08:23:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbiLMNXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 08:23:06 -0500
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E53A17E20;
        Tue, 13 Dec 2022 05:23:04 -0800 (PST)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 1C113240013;
        Tue, 13 Dec 2022 13:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1670937782;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jL+xcBOYdD78r23PS31gaU3YWiITl+rwOOygEItoozc=;
        b=R9lbeAi05SXD39ZRp974M2gOcfxUCkydItXUcL25E8l+i3X9Q10gtIXNvsjFoeHZ0mGAof
        hlmzRAxYl2EBM+jdc/2tMtHqWNJUf3tASXMOhILMNJWwKgpccTEQgz7+c9sKsSpa5utsIN
        hQ2zETYa1IjOKLpkNHZkh9r/c3B08ex+NbIteQYr2joiySEOj7D0Y4dqNlOrJxR69D7tAm
        2iW0SMlg8c6mNtQyOI7Kdpp/l+XH3AzZACxHCmq4APQD84EzakheDHpDwpX3giYhWycz5c
        ny1MOiwborctRk5UbT7cTWtbzIuOok26jp2YPH0P6KsscYO8dAmEhb+or5X0Uw==
Date:   Tue, 13 Dec 2022 14:22:58 +0100
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
Subject: Re: [PATCH v3 3/9] dt-bindings: PCI: renesas,pci-rcar-gen2:
 'depends-on' is no more optional
Message-ID: <20221213142258.77767caf@bootlin.com>
In-Reply-To: <15cb7a77-4308-15f0-4669-7a2673b4abcb@linaro.org>
References: <20221207162435.1001782-1-herve.codina@bootlin.com>
        <20221207162435.1001782-4-herve.codina@bootlin.com>
        <36895e49-aea5-3676-e7df-78b30277e6a0@linaro.org>
        <20221208100530.137fa8b7@bootlin.com>
        <8dfb5b8a-766a-14ec-16d4-74fdd9f7d622@linaro.org>
        <20221208165101.584e4b92@bootlin.com>
        <15cb7a77-4308-15f0-4669-7a2673b4abcb@linaro.org>
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

On Fri, 9 Dec 2022 09:06:55 +0100
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 08/12/2022 16:51, Herve Codina wrote:
> > Hi Krzysztof,
> >=20
> > On Thu, 8 Dec 2022 10:46:32 +0100
> > Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> >  =20
> >> On 08/12/2022 10:05, Herve Codina wrote: =20
> >>> Hi Krzysztof,
> >>>
> >>> On Thu, 8 Dec 2022 09:26:41 +0100
> >>> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> >>>    =20
> >>>> On 07/12/2022 17:24, Herve Codina wrote:   =20
> >>>>> The 'depends-on' property is set in involved DTS.
> >>>>>
> >>>>> Move it to a required property.
> >>>>>
> >>>>> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> >>>>> ---
> >>>>>  Documentation/devicetree/bindings/pci/renesas,pci-rcar-gen2.yaml |=
 1 +     =20
> >>>>
> >>>> This should be squashed with previous patch. There is no point to add
> >>>> property and immediately in the next patch make it required. Remember
> >>>> that bindings are separate from DTS.
> >>>>
> >>>> Best regards,
> >>>> Krzysztof
> >>>>   =20
> >>>
> >>> I though about make dtbs_check in case of git bisect.   =20
> >>
> >> And what would this commit change? In Git you will have
> >> 1. dt-bindings: PCI: renesas,pci-rcar-gen2: Add depends-on for RZ/N1 S=
oC
> >> family
> >> 2. dt-bindings: PCI: renesas,pci-rcar-gen2: 'depends-on' is no more op=
tional
> >>
> >> so what is the difference for git bisect? =20
> >=20
> > Well, today, I have:
> > 1. dt-bindings: Add depends-on
> > 2. dts: Add depends-on
> > 3. dt-bindings: Move depends-on to mandatory =20
>=20
> What does it mean "I have"? Patches on mailing list? But we talk about
> Git and I wrote you bindings are DTS are not going the same tree.
>=20
> >=20
> > If I squash dt-bindings commits, I am going to have:
> >   1. dt-bindings: Add mandatory depends-on
> >   2. dts: Add depends-on
> > or
> >   1. dts: Add depends-on
> >   2. dt-bindings: Add mandatory depends-on =20
>=20
> And how does it matter? Anyway it goes separate trees.

I finally understand what you mean by separate trees.
And indeed, you're right, my patches split does not make
any sense.

According to feedbacks on this v3 series, these 3 patches
will be removed in v4.

Thanks for the review,
Herv=C3=A9

--=20
Herv=C3=A9 Codina, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
