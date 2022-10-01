Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A02BA5F184E
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 03:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232596AbiJABWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 21:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbiJABVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 21:21:39 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D7343FD73
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 18:18:21 -0700 (PDT)
X-QQ-mid: bizesmtp91t1664586871tcwf5ude
Received: from CSD1051 ( [113.72.146.201])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 01 Oct 2022 09:14:29 +0800 (CST)
X-QQ-SSF: 01000000000000308000000A0000000
X-QQ-FEAT: PXtIlpCZyqdoUCaznDtdk1gVxdQFhDYD3xz//q16G0AgZvwIO2tuR6R0JunZn
        uxvR+gjF7QCJd/Vn6HBzqgWAfDT0XURA9RI5t+BFQetFrVz9CFQnuU6VO6Nk+L8kIEZ4Gna
        0WhRHPrxLqR4kbt8kzIozEzYDeg3FOe0/VFf2mzwKPM86sf0cNpmmSciBtnnKl7La4P6iXy
        TbFieBvcljfVC5YsGyJQLSk9IlT4ZzCYCI4cgAGwC7/5EUBU0IU0djPo6pZ86BTHKhhja9o
        k6XXlhPiWxO2Ox6oyTAjEOR0f4nTM2SoXpUxD02jtmKFRMMk28OQILWco8LehWnqTB9xrv0
        zucVUFcdqPvSqxvf88=
X-QQ-GoodBg: 0
From:   <hal.feng@linux.starfivetech.com>
To:     "'Conor Dooley'" <conor@kernel.org>,
        "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>
Cc:     <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        "'Rob Herring'" <robh+dt@kernel.org>,
        "'Krzysztof Kozlowski'" <krzysztof.kozlowski+dt@linaro.org>,
        "'Paul Walmsley'" <paul.walmsley@sifive.com>,
        "'Palmer Dabbelt'" <palmer@dabbelt.com>,
        "'Albert Ou'" <aou@eecs.berkeley.edu>,
        "'Daniel Lezcano'" <daniel.lezcano@linaro.org>,
        "'Thomas Gleixner'" <tglx@linutronix.de>,
        "'Marc Zyngier'" <maz@kernel.org>,
        "'Philipp Zabel'" <p.zabel@pengutronix.de>,
        "'Stephen Boyd'" <sboyd@kernel.org>,
        "'Michael Turquette'" <mturquette@baylibre.com>,
        "'Linus Walleij'" <linus.walleij@linaro.org>,
        "'Emil Renner Berthing'" <kernel@esmil.dk>,
        <linux-kernel@vger.kernel.org>
References: <20220929143225.17907-1-hal.feng@linux.starfivetech.com> <4ddabe3a-9f55-2a6a-c1c1-ccc3fc74e98a@linaro.org> <YzXc/FSbDpkElK0O@spud>
In-Reply-To: <YzXc/FSbDpkElK0O@spud>
Subject: Re: [PATCH v1 00/30] Basic StarFive JH7110 RISC-V SoC support
Date:   Sat, 1 Oct 2022 09:13:01 +0800
Message-ID: <617C2EE03810F071+013401d8d532$f4548310$dcfd8930$@linux.starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: zh-cn
Thread-Index: AQLyOrMrqu8us6tOmdilaJnshXDZwAImr5qgAixKxMCro1Q8gA==
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:linux.starfivetech.com:qybglogicsvr:qybglogicsvr2
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2022 at 18:59:24 +0100, Conor Dooley wrote:
> On Thu, Sep 29, 2022 at 04:45:26PM +0200, Krzysztof Kozlowski wrote:
> > On 29/09/2022 16:31, Hal Feng wrote:
> >
> > > This series is also available at
> > > https://github.com/hal-feng/linux/commits/visionfive2-minimal
> > >
> > > [1]
> > > https://www.cnx-software.com/2022/08/23/starfive-visionfive-2-quad-c
> > > ore-risc-v-sbc-linux/
> > > [2] https://wiki.rvspace.org/
> > >
> > > Emil Renner Berthing (17):
> > >   dt-bindings: riscv: Add StarFive JH7110 bindings
> > >   dt-bindings: timer: Add StarFive JH7110 clint
> > >   dt-bindings: interrupt-controller: Add StarFive JH7110 plic
> > >   dt-bindings: sifive-l2-cache: Support StarFive JH71x0 SoCs
> > >   soc: sifive: l2 cache: Convert to platform driver
> > >   soc: sifive: l2 cache: Add StarFive JH71x0 support
> > >   reset: starfive: jh7100: Use 32bit I/O on 32bit registers
> > >   dt-bindings: reset: Add StarFive JH7110 reset definitions
> > >   clk: starfive: Factor out common clock driver code
> > >   dt-bindings: clock: Add StarFive JH7110 system clock definitions
> > >   dt-bindings: clock: Add starfive,jh7110-clkgen-sys bindings
> > >   clk: starfive: Add StarFive JH7110 system clock driver
> > >   dt-bindings: clock: Add StarFive JH7110 always-on definitions
> > >   dt-bindings: clock: Add starfive,jh7110-clkgen-aon bindings
> > >   clk: starfive: Add StarFive JH7110 always-on clock driver
> > >   RISC-V: Add initial StarFive JH7110 device tree
> > >   RISC-V: Add StarFive JH7110 VisionFive2 board device tree
> >
> > Where is the rest of patches? Lists got only 5 of them. Anyway this is
> > a bit too big patchset. Split per subsystem.
> 
> They seem to be coming in over time in dribs and drabs. I assume it is not
a
> mailing list problem given how many lists are CCed on the mail and the
fact
> that they have different providers.
> 
> For v2 (or multiple v2s) please fix up your process so that this gets sent
> normally and not a couple of patches every hour.

Our email server has technical issue and we are aware of this.
Will fix in next revision. Sorry for the inconvenience caused.

Best Regards,
Hal

