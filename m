Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8BBB633CE9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 13:52:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233525AbiKVMwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 07:52:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbiKVMwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 07:52:16 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBD7F6176E;
        Tue, 22 Nov 2022 04:52:11 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 23C2524E14F;
        Tue, 22 Nov 2022 20:52:05 +0800 (CST)
Received: from EXMBX072.cuchost.com (172.16.6.82) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 22 Nov
 2022 20:52:05 +0800
Received: from [192.168.125.106] (113.72.144.23) by EXMBX072.cuchost.com
 (172.16.6.82) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 22 Nov
 2022 20:52:06 +0800
Message-ID: <ecf8e680-a4f2-d72f-c888-8faaca1c8b46@starfivetech.com>
Date:   Tue, 22 Nov 2022 20:51:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v2 4/8] dt-bindings: sifive,ccache0: Support StarFive
 JH7110 SoC
Content-Language: en-US
To:     Emil Renner Berthing <emil.renner.berthing@canonical.com>
CC:     Conor Dooley <conor.dooley@microchip.com>,
        Conor Dooley <conor@kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ben Dooks <ben.dooks@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20221118011714.70877-1-hal.feng@starfivetech.com>
 <20221118011714.70877-5-hal.feng@starfivetech.com> <Y3duiJguYE6VrVLP@spud>
 <Y3dvCPP1g0LzzHFO@spud>
 <a5193e23-efe1-fa65-15de-d53b80b87d63@starfivetech.com>
 <Y3yRTuo69JUsfLqk@wendy>
 <0f9e423e-37c0-a838-bf25-f9b6784a31d0@starfivetech.com>
 <Y3yd+tfFl4yvXOx6@wendy>
 <b57bdf1c-19f4-3d70-7618-16817669abc5@starfivetech.com>
 <CAJM55Z-aQfvUZXNtaorAk4acpbbVsj-f-8TQn6uZXQosD=MORA@mail.gmail.com>
From:   Hal Feng <hal.feng@starfivetech.com>
In-Reply-To: <CAJM55Z-aQfvUZXNtaorAk4acpbbVsj-f-8TQn6uZXQosD=MORA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [113.72.144.23]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX072.cuchost.com
 (172.16.6.82)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Nov 2022 11:35:28 +0100, Emil Renner Berthing wrote:
> On Tue, 22 Nov 2022 at 11:16, Hal Feng <hal.feng@starfivetech.com> wrote:
> >
> > On Tue, 22 Nov 2022 10:01:30 +0000, Conor Dooley wrote:
> > > On Tue, Nov 22, 2022 at 05:55:57PM +0800, Hal Feng wrote:
> > > > On Tue, 22 Nov 2022 09:07:26 +0000, Conor Dooley wrote:
> > > > > On Tue, Nov 22, 2022 at 04:40:23PM +0800, Hal Feng wrote:
> > > > > > On Fri, 18 Nov 2022 19:39:52 +0800, Conor Dooley wrote:
> > > > > > > On Fri, Nov 18, 2022 at 11:37:50AM +0000, Conor Dooley wrote:
> > > > > > > > On Fri, Nov 18, 2022 at 09:17:10AM +0800, Hal Feng wrote:
> > > > > > > > > From: Emil Renner Berthing <kernel@esmil.dk>
> > > > > > > > >
> > > > > > > > > This cache controller is also used on the StarFive JH7110 SoC.
> > > > > > > >
> > > > > > > > "... and configured identically to that of the FU740"?
> > > > > > > > Anyways,
> > > > > > > > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> > > > > > >
> > > > > > > Actually, after looking at the next patch - why can you not fall back to
> > > > > > > the fu740 one since you appear to have the same configuration as it?
> > > > > >
> > > > > > Right, I will drop this patch and use "sifive,fu740-c000-ccache" as
> > > > > > compatible in dts.
> > > > >
> > > > > Uh, that's not quite what I was suggesting. Rather than using that one
> > > > > in isolation, you can do the following in your dt:
> > > > > "starfive,jh7110-ccache", "sifive,fu740-c000-ccache"
> > > > >
> > > > > And then in the driver we need to make no changes - unless down the line
> > > > > we find some sort of issue that requires special handling etc. There's
> > > > > no harm in having a "starfive,jh7110-ccache" IMO.
> > > >
> > > > Just like what microchip did as blow?
> >
> > below
> >
> > > >
> > > > Documentation/devicetree/bindings/riscv/sifive,ccache0.yaml:
> > > > properties:
> > > >   compatible:
> > > >     oneOf:
> > > >       - items:
> > > >           - enum:
> > > >               - sifive,ccache0
> > > >               - sifive,fu540-c000-ccache
> > > >               - sifive,fu740-c000-ccache
> > > >               - starfive,jh7110-ccache
> > > >           - const: cache
> > > >       - items:
> > > >           - const: microchip,mpfs-ccache
> > > >           - const: sifive,fu540-c000-ccache
> > > >           - const: cache
> > >
> > > No, I don't think this is correct either. You'd do something like:
> > >
> > > >       - items:
> > > >           - const: starfive,jh7110-ccache
> > > >           - const: sifive,fu740-c000-ccache
> 
> For the record I don't think the line above should be there. The
> fu7400-c000 is a specific tapeout and pretending the JH7110 is that
> tapeout is not right. Especially when there is already the
> "sifive,ccache0" string for the generic IP.

I will change this line to

- const: sifive,ccache0

Thanks for your suggestion.

> 
> > > >           - const: cache
> >
> > Yeah, this is what I mean. Thanks.
> >
> > Best regards,
> > Hal
> >
> > >
> > > And then the driver needs no changes.
> >

