Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14F0C5EFC8C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 19:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234931AbiI2R7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 13:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234970AbiI2R7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 13:59:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92899FD1;
        Thu, 29 Sep 2022 10:59:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3C13DB82617;
        Thu, 29 Sep 2022 17:59:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D8C7C433D6;
        Thu, 29 Sep 2022 17:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664474370;
        bh=q9pUnXr+y7ypf+y9MFvS031N4YM5aIIn48LYK2fF6ak=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NsesspPuNjiQpeaUs5Gl0Pc5mZrqIZrRFwrqNTM2SlBclmeg4Dh2fzkdW1q4jmPhF
         dxWFzIvSoedHnZWGkpgjQHbM7jplc2ug/MXFq9CvXRCd8wgeynb9Mu1Sx19iyWdqNr
         0bFP/QFI2R/jpoK0exdhgZ9PNLWtJ5n6JLMgevAMSthuiVBuGG3SwVI6oi31mLn38w
         R0HwVpqYrP2eOs+eDNR344/s+xva+gSzcDPdUi02DGu8B1DCNcc+8gdj5XxchMTY2y
         ZQa9FyasbW40mQ5ZZiIY6gHZHyrY1nNF7ziFOLnytHsqAxH8ozyhxp8XSyu+A8ktER
         x4xt4YUxj4OkQ==
Date:   Thu, 29 Sep 2022 18:59:24 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Hal Feng <hal.feng@linux.starfivetech.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 00/30] Basic StarFive JH7110 RISC-V SoC support
Message-ID: <YzXc/FSbDpkElK0O@spud>
References: <20220929143225.17907-1-hal.feng@linux.starfivetech.com>
 <4ddabe3a-9f55-2a6a-c1c1-ccc3fc74e98a@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ddabe3a-9f55-2a6a-c1c1-ccc3fc74e98a@linaro.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2022 at 04:45:26PM +0200, Krzysztof Kozlowski wrote:
> On 29/09/2022 16:31, Hal Feng wrote:
> 
> > This series is also available at 
> > https://github.com/hal-feng/linux/commits/visionfive2-minimal
> > 
> > [1] https://www.cnx-software.com/2022/08/23/starfive-visionfive-2-quad-core-risc-v-sbc-linux/
> > [2] https://wiki.rvspace.org/
> > 
> > Emil Renner Berthing (17):
> >   dt-bindings: riscv: Add StarFive JH7110 bindings
> >   dt-bindings: timer: Add StarFive JH7110 clint
> >   dt-bindings: interrupt-controller: Add StarFive JH7110 plic
> >   dt-bindings: sifive-l2-cache: Support StarFive JH71x0 SoCs
> >   soc: sifive: l2 cache: Convert to platform driver
> >   soc: sifive: l2 cache: Add StarFive JH71x0 support
> >   reset: starfive: jh7100: Use 32bit I/O on 32bit registers
> >   dt-bindings: reset: Add StarFive JH7110 reset definitions
> >   clk: starfive: Factor out common clock driver code
> >   dt-bindings: clock: Add StarFive JH7110 system clock definitions
> >   dt-bindings: clock: Add starfive,jh7110-clkgen-sys bindings
> >   clk: starfive: Add StarFive JH7110 system clock driver
> >   dt-bindings: clock: Add StarFive JH7110 always-on definitions
> >   dt-bindings: clock: Add starfive,jh7110-clkgen-aon bindings
> >   clk: starfive: Add StarFive JH7110 always-on clock driver
> >   RISC-V: Add initial StarFive JH7110 device tree
> >   RISC-V: Add StarFive JH7110 VisionFive2 board device tree
> 
> Where is the rest of patches? Lists got only 5 of them. Anyway this is a
> bit too big patchset. Split per subsystem.

They seem to be coming in over time in dribs and drabs. I assume it is
not a mailing list problem given how many lists are CCed on the mail and
the fact that they have different providers.

For v2 (or multiple v2s) please fix up your process so that this gets
sent normally and not a couple of patches every hour.

Thanks,
Conor.
