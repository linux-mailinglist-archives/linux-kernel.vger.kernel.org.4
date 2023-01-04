Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6177B65D5C7
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 15:35:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239433AbjADOei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 09:34:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239580AbjADOec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 09:34:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 142FF373A6;
        Wed,  4 Jan 2023 06:34:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C83C4B81674;
        Wed,  4 Jan 2023 14:34:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53E62C433D2;
        Wed,  4 Jan 2023 14:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672842868;
        bh=gRkCSnXk5MjxVH+vyivnl3Fj49JHVY24sOY1WJh8QEg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k5MykoyoJXROrSbBrVfL6RN/UKCq7OIH2LH9suxKq1RhPopZd0KV9VzH9OZArvVAi
         OjeULj7tH4EBtWom9/n4D8+Bq67oYBDRuS79zCMcnKeV3uohIyY7Yg9vF3LtdZ5ijX
         OME+yvl/61fF7eMF7/j3La0XQbhVDW/PFfRXTx0EWs3N9hO6BZC25sGAKUkzS9+gGU
         nCNXqaSlXkppnNS1gAnozooIQ0Ex1pEkn2m96QOmGFIJL8fF8o3QxsObi4Rpb0wi7O
         4gL8y75HZVvL7qRenCVdHz77J3/DFblD9V+fjJ41jwtSpdkfZBGYUEV6pAlarxz3bP
         hgZjXGlhHRxJA==
Date:   Wed, 4 Jan 2023 14:34:21 +0000
From:   Lee Jones <lee@kernel.org>
To:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo@jmondi.org>
Subject: Re: [PATCH v2 2/4] mfd: Add RZ/V2M PWC core driver
Message-ID: <Y7WObZFfsCJuMdLW@google.com>
References: <20221221210917.458537-1-fabrizio.castro.jz@renesas.com>
 <20221221210917.458537-3-fabrizio.castro.jz@renesas.com>
 <CAMuHMdXDwEUzBpG+w_G6=CzKo=n92cdVw6v8JwOwf9o86HnOZQ@mail.gmail.com>
 <TYWPR01MB87758FB15ED12D396AE738DDC2F49@TYWPR01MB8775.jpnprd01.prod.outlook.com>
 <Y7Qk/EgOI9mkJIjn@google.com>
 <TYWPR01MB87753C261831519F4D6788E5C2F49@TYWPR01MB8775.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <TYWPR01MB87753C261831519F4D6788E5C2F49@TYWPR01MB8775.jpnprd01.prod.outlook.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 03 Jan 2023, Fabrizio Castro wrote:

> Hi Lees,
> 
> Thanks for your feedback!
> 
> > From: Lee Jones <lee@kernel.org>
> > Sent: 03 January 2023 12:52
> > Subject: Re: [PATCH v2 2/4] mfd: Add RZ/V2M PWC core driver
> > 
> > On Tue, 03 Jan 2023, Fabrizio Castro wrote:
> > 
> > > Hi Geert,
> > >
> > > Thanks for your feedback!
> > >
> > > > -----Original Message-----
> > > > From: Geert Uytterhoeven <geert@linux-m68k.org>
> > > > Sent: 03 January 2023 08:37
> > > > To: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> > > > Cc: Linus Walleij <linus.walleij@linaro.org>; Bartosz Golaszewski
> > > > <brgl@bgdev.pl>; Rob Herring <robh+dt@kernel.org>; Krzysztof Kozlowski
> > > > <krzysztof.kozlowski+dt@linaro.org>; Sebastian Reichel
> > <sre@kernel.org>;
> > > > Geert Uytterhoeven <geert+renesas@glider.be>; Lee Jones
> > <lee@kernel.org>;
> > > > linux-gpio@vger.kernel.org; devicetree@vger.kernel.org; linux-
> > > > kernel@vger.kernel.org; linux-pm@vger.kernel.org; Chris Paterson
> > > > <Chris.Paterson2@renesas.com>; Biju Das <biju.das@bp.renesas.com>;
> > linux-
> > > > renesas-soc@vger.kernel.org; Laurent Pinchart
> > > > <laurent.pinchart@ideasonboard.com>; Jacopo Mondi <jacopo@jmondi.org>
> > > > Subject: Re: [PATCH v2 2/4] mfd: Add RZ/V2M PWC core driver

Could you please tell your mailer to remove mail headers from the body
please.

> > > > > The External Power Sequence Controller (PWC) IP (found in the
> > > > > RZ/V2M SoC) is a controller for external power supplies (regulators
> > > > > and power switches), and it supports the following features: it
> > > > > generates a power on/off sequence for external power supplies,
> > > > > it generates an on/off sequence for the LPDDR4 core power supply
> > > > > (LPVDD), it comes with General-Purpose Outputs, and it processes
> > > > > key input signals.
> > > >
> > > > Thanks for your patch!
> > > >
> > > > > The PWC is basically a Multi-Function Device (MFD), its software
> > > > > support comes with a core driver, and specialized drivers for
> > > > > its specific features.
> > > >
> > > > I have to admit I'm not such a big fan of MFD.  In this driver,
> > > > you are not even sharing resources in the MFD cells, just the mapped
> > > > register base.  So I think you can easily save +100 LoC and reduce
> > > > maintenance synchronization overhead across subsystems by just having
> > > > a single non-MFD driver instead.
> > > >
> > > > Did you pick MFD because the PWC poweroff feature depends on board
> > > > wiring, and thus is optional?
> > >
> > > I am not a big fan of MFD, either.
> > 
> > Interesting.
> > 
> > Could you both elaborate further please?
> 
> I have nothing against MFD

Okay, just checking.  I'll withdraw my next command then. :)

$ rm -rf drivers/mfd

> > If you do not have any resources to share, you can simply register each
> > of the devices via Device Tree.  I do not see a valid reason to force a
> > parent / child relationship for your use-case.
> 
> There would probably be overlapping on the same memory region, which would
> lead to ioremapping the same region multiple times, which is something
> I would prefer to avoid if possible.

Okay, so you *do* have shared resources.

In which case, why is simple-mfd not working for you?

> > Many people attempt to use MFD as a dumping ground / workaround for a
> > bunch of reasons.  Some valid, others not so much.
> 
> As it turns out, it looks like I don't have valid reasons to use MFD,
> therefore I'll switch to a single, non MFD, driver.
> 
> Thank you for taking the time to look into this though! Really
> appreciated.

Although it is considered okay to have a multi-purpose driver in any one
of the subsystems, it's sometimes nicer to split the various
functionality to be looked after (maintained) by their respective
subject matter experts.  You have to do what's right in any given
situation.

Ultimately it's a call you need to make with the maintainer(s).

-- 
Lee Jones [李琼斯]
