Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE4165C04E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 13:53:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237712AbjACMwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 07:52:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237732AbjACMwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 07:52:23 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FD3BCFC;
        Tue,  3 Jan 2023 04:52:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 500D5B80E12;
        Tue,  3 Jan 2023 12:52:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1488EC433D2;
        Tue,  3 Jan 2023 12:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672750339;
        bh=Wa6TU/u66JGcOO2l7KQC5SQzR8MRkoV+DozPJjJgvFc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZVWeXS8n9PHu8ZQP/yg3TdI1mkaBooz1jyzb/4734yf52pbUuAVqX5Rn3B08TxHWj
         kevH5vWcWONZc/vmhRS/xaZWV6EdttNGfgZj5dtmb2cVscXVQ1bLWbrV1A5W+zwHFV
         ksHh1iYvkF2stlaqHfcAg5kyC4zHvgwX+DW/GV73LFN8gjxhDwoWgrsoWuWJDlCKWM
         WjruZfe3XbujcvJbZ6ZCorgUxUMxFdvsasxEt0RHXSLDDE7XXOrX1qFYvJzuMM972g
         tWA6SVkz6FiIsRpTaJnTE7HY4CPlgBWfEventIbOxDzYpFuOLnSGqcQi4h4YmtAluJ
         JQBzHFZ8CV27w==
Date:   Tue, 3 Jan 2023 12:52:12 +0000
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
Message-ID: <Y7Qk/EgOI9mkJIjn@google.com>
References: <20221221210917.458537-1-fabrizio.castro.jz@renesas.com>
 <20221221210917.458537-3-fabrizio.castro.jz@renesas.com>
 <CAMuHMdXDwEUzBpG+w_G6=CzKo=n92cdVw6v8JwOwf9o86HnOZQ@mail.gmail.com>
 <TYWPR01MB87758FB15ED12D396AE738DDC2F49@TYWPR01MB8775.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <TYWPR01MB87758FB15ED12D396AE738DDC2F49@TYWPR01MB8775.jpnprd01.prod.outlook.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 03 Jan 2023, Fabrizio Castro wrote:

> Hi Geert,
> 
> Thanks for your feedback!
> 
> > -----Original Message-----
> > From: Geert Uytterhoeven <geert@linux-m68k.org>
> > Sent: 03 January 2023 08:37
> > To: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> > Cc: Linus Walleij <linus.walleij@linaro.org>; Bartosz Golaszewski
> > <brgl@bgdev.pl>; Rob Herring <robh+dt@kernel.org>; Krzysztof Kozlowski
> > <krzysztof.kozlowski+dt@linaro.org>; Sebastian Reichel <sre@kernel.org>;
> > Geert Uytterhoeven <geert+renesas@glider.be>; Lee Jones <lee@kernel.org>;
> > linux-gpio@vger.kernel.org; devicetree@vger.kernel.org; linux-
> > kernel@vger.kernel.org; linux-pm@vger.kernel.org; Chris Paterson
> > <Chris.Paterson2@renesas.com>; Biju Das <biju.das@bp.renesas.com>; linux-
> > renesas-soc@vger.kernel.org; Laurent Pinchart
> > <laurent.pinchart@ideasonboard.com>; Jacopo Mondi <jacopo@jmondi.org>
> > Subject: Re: [PATCH v2 2/4] mfd: Add RZ/V2M PWC core driver
> > 
> > Hi Fabrizio,
> > 
> > On Wed, Dec 21, 2022 at 10:09 PM Fabrizio Castro
> > <fabrizio.castro.jz@renesas.com> wrote:
> > > The External Power Sequence Controller (PWC) IP (found in the
> > > RZ/V2M SoC) is a controller for external power supplies (regulators
> > > and power switches), and it supports the following features: it
> > > generates a power on/off sequence for external power supplies,
> > > it generates an on/off sequence for the LPDDR4 core power supply
> > > (LPVDD), it comes with General-Purpose Outputs, and it processes
> > > key input signals.
> > 
> > Thanks for your patch!
> > 
> > > The PWC is basically a Multi-Function Device (MFD), its software
> > > support comes with a core driver, and specialized drivers for
> > > its specific features.
> > 
> > I have to admit I'm not such a big fan of MFD.  In this driver,
> > you are not even sharing resources in the MFD cells, just the mapped
> > register base.  So I think you can easily save +100 LoC and reduce
> > maintenance synchronization overhead across subsystems by just having
> > a single non-MFD driver instead.
> > 
> > Did you pick MFD because the PWC poweroff feature depends on board
> > wiring, and thus is optional?
> 
> I am not a big fan of MFD, either.

Interesting.

Could you both elaborate further please?

> I picked MFD because we were not 100% sure of what the IP could do
> when we started working on it.
> I have received more information regarding the IP now (which I don't
> have the liberty to discuss), I am still not 100% sure that's all
> of it, but basically its support may require expansion later on.
> 
> I liked the solution based on syscon and simple-mfd for several reasons,
> but having dropped syscon and simple-mfd due to issues with the dt-bindings
> I have moved on with a core driver to instantiate the required SW support.
> We could of course move to a unified driver if that makes more sense?
> If we were to move to unified driver, under which directory would you
> suggest we put it?

If you do not have any resources to share, you can simply register each
of the devices via Device Tree.  I do not see a valid reason to force a
parent / child relationship for your use-case.

Many people attempt to use MFD as a dumping ground / workaround for a
bunch of reasons.  Some valid, others not so much.

-- 
Lee Jones [李琼斯]
