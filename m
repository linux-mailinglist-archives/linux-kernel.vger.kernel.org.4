Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83BB87207CE
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 18:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236528AbjFBQkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 12:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235966AbjFBQkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 12:40:05 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BCC2196;
        Fri,  2 Jun 2023 09:40:01 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 107)
        id B979A68BEB; Fri,  2 Jun 2023 18:39:58 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
Received: from blackhole.lan (p5b33f9bb.dip0.t-ipconnect.de [91.51.249.187])
        by verein.lst.de (Postfix) with ESMTPSA id 3758768AA6;
        Fri,  2 Jun 2023 18:39:27 +0200 (CEST)
Date:   Fri, 2 Jun 2023 18:39:22 +0200
From:   Torsten Duwe <duwe@lst.de>
To:     Xingyu Wu <xingyu.wu@starfivetech.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <yanhong.wang@starfivetech.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Conor Dooley <conor@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        "Rob Herring" <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Hal Feng" <hal.feng@starfivetech.com>,
        William Qiu <william.qiu@starfivetech.com>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>
Subject: Re: [PATCH v4 1/7] dt-bindings: clock: Add StarFive JH7110 PLL
 clock generator
Message-ID: <20230602183922.649b8e88@blackhole.lan>
In-Reply-To: <df43411e-8982-74f5-6148-e7281c37dada@starfivetech.com>
References: <20230512022036.97987-1-xingyu.wu@starfivetech.com>
        <20230512022036.97987-2-xingyu.wu@starfivetech.com>
        <20230519135733.GA10188@lst.de>
        <20230519-smokeless-guileless-2a71cae06509@wendy>
        <df43411e-8982-74f5-6148-e7281c37dada@starfivetech.com>
Organization: LST e.V.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.34; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 May 2023 10:56:43 +0800
Xingyu Wu <xingyu.wu@starfivetech.com> wrote:

> On 2023/5/19 22:16, Conor Dooley wrote:
> > On Fri, May 19, 2023 at 03:57:33PM +0200, Torsten Duwe wrote:
> >> On Fri, May 12, 2023 at 10:20:30AM +0800, Xingyu Wu wrote:
> >> [...]
> >> >  #ifndef __DT_BINDINGS_CLOCK_STARFIVE_JH7110_CRG_H__
> >> >  #define __DT_BINDINGS_CLOCK_STARFIVE_JH7110_CRG_H__
> >> >  
> >> > +/* PLL clocks */
> >> > +#define JH7110_CLK_PLL0_OUT			0
> >> > +#define JH7110_CLK_PLL1_OUT			1
> >> > +#define JH7110_CLK_PLL2_OUT			2
> >> 
> >> In U-Boot commit 58c9c60b Yanhong Wang added:
> >> 
> >> +
> >> +#define JH7110_SYSCLK_PLL0_OUT                       190
> >> +#define JH7110_SYSCLK_PLL1_OUT                       191
> >> +#define JH7110_SYSCLK_PLL2_OUT                       192
> >> +
> >> +#define JH7110_SYSCLK_END                    193
> >> 
> >> in that respective file.
> >> 
> >> > +#define JH7110_PLLCLK_END			3
> >> > +
> >> >  /* SYSCRG clocks */
> >> >  #define JH7110_SYSCLK_CPU_ROOT			0
> >> 
> >> If the symbolic names referred to the same items, would it be possible
> >> to keep the two files in sync somehow?
> > 
> > Ohh, that's not good.. If you pass the U-Boot dtb to Linux it won't
> > understand the numbering. The headers are part of the dt-binding :/
> 
> Because PLL driver is separated from SYSCRG drivers in Linux,

Can you _please_ point me at that "PLL driver" "in Linux" ?
I seem to be unable to find it. All I can see is a stub in
drivers/clk/starfive/clk-starfive-jh7110-sys.c, which simply
sets the PLLs to 1000, 1066 and 1188 MHz fixed, respectively.

The comment above says

| They will be dropped and registered in the PLL clock driver instead.

and that's the one I'm looking for.

Thanks,

	Torsten
