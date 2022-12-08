Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FABC647386
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 16:51:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbiLHPvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 10:51:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbiLHPvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 10:51:10 -0500
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE59E26553;
        Thu,  8 Dec 2022 07:51:06 -0800 (PST)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 7DD6E240012;
        Thu,  8 Dec 2022 15:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1670514665;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g5n3JsbbZaE7ybECVhrvextoT7PBeRSsX4KeV8+PcM0=;
        b=UyngXYx9Vcm9JGJ1b3z7b8NO21EvHn5BIi7f4ns15NUnU/N1IIK5CNH2c7ecEyW/V8uFgY
        Ni34Ojo008tCgLgY/9IESNlGr6CUyt+e2amEEV/NVXQlZNEbjyEuE6WPO32o5bJy0+SIKu
        hpswvin9x1zQfcqy+oNxdyMLN9LUKC6fQMp5TsXaK0mjpluyLENZmqfR3k/V32Vo9fLxhr
        B1QimGkMWjtcPbHfhtckx3QwyHpnLSBq/R1W0lbTAbX1wxQeBoa/qzgQAIkeSCVo4+XNak
        VB6f1fmQjxSE2kwN4nE9YC63UcpmCHxly4fMv8fEngeppnb8GVyZOfTNl6iSAg==
Date:   Thu, 8 Dec 2022 16:51:01 +0100
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
Message-ID: <20221208165101.584e4b92@bootlin.com>
In-Reply-To: <8dfb5b8a-766a-14ec-16d4-74fdd9f7d622@linaro.org>
References: <20221207162435.1001782-1-herve.codina@bootlin.com>
        <20221207162435.1001782-4-herve.codina@bootlin.com>
        <36895e49-aea5-3676-e7df-78b30277e6a0@linaro.org>
        <20221208100530.137fa8b7@bootlin.com>
        <8dfb5b8a-766a-14ec-16d4-74fdd9f7d622@linaro.org>
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

On Thu, 8 Dec 2022 10:46:32 +0100
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 08/12/2022 10:05, Herve Codina wrote:
> > Hi Krzysztof,
> >=20
> > On Thu, 8 Dec 2022 09:26:41 +0100
> > Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> >  =20
> >> On 07/12/2022 17:24, Herve Codina wrote: =20
> >>> The 'depends-on' property is set in involved DTS.
> >>>
> >>> Move it to a required property.
> >>>
> >>> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> >>> ---
> >>>  Documentation/devicetree/bindings/pci/renesas,pci-rcar-gen2.yaml | 1=
 +   =20
> >>
> >> This should be squashed with previous patch. There is no point to add
> >> property and immediately in the next patch make it required. Remember
> >> that bindings are separate from DTS.
> >>
> >> Best regards,
> >> Krzysztof
> >> =20
> >=20
> > I though about make dtbs_check in case of git bisect. =20
>=20
> And what would this commit change? In Git you will have
> 1. dt-bindings: PCI: renesas,pci-rcar-gen2: Add depends-on for RZ/N1 SoC
> family
> 2. dt-bindings: PCI: renesas,pci-rcar-gen2: 'depends-on' is no more optio=
nal
>=20
> so what is the difference for git bisect?

Well, today, I have:
1. dt-bindings: Add depends-on
2. dts: Add depends-on
3. dt-bindings: Move depends-on to mandatory

If I squash dt-bindings commits, I am going to have:
  1. dt-bindings: Add mandatory depends-on
  2. dts: Add depends-on
or
  1. dts: Add depends-on
  2. dt-bindings: Add mandatory depends-on

I have not tested but if I used only the first commit in each
case (git bisect):
In the first case, dtbs_check is probably going to signal the
missing 'depends-on' property on dts.
In the second case, dtbs_check is probably going to signal the
not described 'depends-on' property present in dts.

>=20
> >=20
> > But, ok I will squash or perhaps remove completely this commit.
> > It introduces a DT compatibility break adding a new mandatory
> > property (raised by Rob on cover letter review).
> > Is this compatibility break can be acceptable ? =20
>=20
> Requiring property in bindings as a fix for something which was broken
> is ok. But this is independent of Linux drivers, which should not stop
> working.

Ok, thanks.

>=20
> Best regards,
> Krzysztof
>=20

Regards,
Herv=C3=A9
