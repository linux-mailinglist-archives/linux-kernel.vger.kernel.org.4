Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5127470F1A9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 11:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240514AbjEXJCJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 05:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236330AbjEXJCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 05:02:07 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2E218E;
        Wed, 24 May 2023 02:02:01 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 1012524E26B;
        Wed, 24 May 2023 17:01:53 +0800 (CST)
Received: from EXMBX061.cuchost.com (172.16.6.61) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 24 May
 2023 17:01:52 +0800
Received: from [192.168.125.131] (183.27.98.143) by EXMBX061.cuchost.com
 (172.16.6.61) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 24 May
 2023 17:01:51 +0800
Message-ID: <38a9cb77-18b3-4daa-724b-9f2282f7d948@starfivetech.com>
Date:   Wed, 24 May 2023 17:00:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 1/7] dt-bindings: clock: Add StarFive JH7110 PLL clock
 generator
Content-Language: en-US
To:     Conor Dooley <conor.dooley@microchip.com>,
        Torsten Duwe <duwe@lst.de>
CC:     <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
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
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <u-boot@lists.denx.de>
References: <20230512022036.97987-1-xingyu.wu@starfivetech.com>
 <20230512022036.97987-2-xingyu.wu@starfivetech.com>
 <20230519135733.GA10188@lst.de>
 <20230519-smokeless-guileless-2a71cae06509@wendy>
 <df43411e-8982-74f5-6148-e7281c37dada@starfivetech.com>
 <20230523-fondue-monotype-0c751a8f0c13@wendy>
 <20230523131006.46997d84@blackhole.lan>
 <20230523-saturate-axis-f46b78b7b82b@wendy>
From:   Xingyu Wu <xingyu.wu@starfivetech.com>
In-Reply-To: <20230523-saturate-axis-f46b78b7b82b@wendy>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [183.27.98.143]
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX061.cuchost.com
 (172.16.6.61)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/5/23 19:28, Conor Dooley wrote:
> On Tue, May 23, 2023 at 01:10:06PM +0200, Torsten Duwe wrote:
>> On Tue, 23 May 2023 09:28:39 +0100
>> Conor Dooley <conor.dooley@microchip.com> wrote:
>> 
>> > On Tue, May 23, 2023 at 10:56:43AM +0800, Xingyu Wu wrote:
>> > > On 2023/5/19 22:16, Conor Dooley wrote:
>> > > > On Fri, May 19, 2023 at 03:57:33PM +0200, Torsten Duwe wrote:
>> > > >> On Fri, May 12, 2023 at 10:20:30AM +0800, Xingyu Wu wrote:
>> > > >> [...]
>> 
>> > > >> > +/* PLL clocks */
>> > > >> > +#define JH7110_CLK_PLL0_OUT			0
>> > > >> > +#define JH7110_CLK_PLL1_OUT			1
>> > > >> > +#define JH7110_CLK_PLL2_OUT			2
>> > > >> 
>> > > >> In U-Boot commit 58c9c60b Yanhong Wang added:
>> > > >> 
>> > > >> +
>> > > >> +#define JH7110_SYSCLK_PLL0_OUT                       190
>> > > >> +#define JH7110_SYSCLK_PLL1_OUT                       191
>> > > >> +#define JH7110_SYSCLK_PLL2_OUT                       192
>> > > >> +
>> > > >> +#define JH7110_SYSCLK_END                    193
>> [...]
>> > > > Ohh, that's not good.. If you pass the U-Boot dtb to Linux it
>> > > > won't understand the numbering. The headers are part of the
>> > > > dt-binding :/
>> 
>> In fact, the clock index >= 190 makes linux hang on boot, waiting with
>> EPROBE_DEFER for every device's clock, because the sysclk driver errors
>> out with EINVAL (jh7110_sysclk_get()).
> 
> Yup, that's about what I expected to happen.
> 
>> > > Because PLL driver is separated from SYSCRG drivers in Linux, the
>> > > numbering starts from 0. But in Uboot, the PLL driver is included
>> > > in the SYSCRG driver, and the number follows the SYSCRG.
>> > 
>> > Unfortunately, how you choose to construct your drivers has nothing to
>> > do with this.
>> > These defines/numbers appear in the dts and are part of the DT ABI.
>> > The same dts is supposed to work for Linux & U-Boot.
>> 
>> The JH7110 has 6 blocks of 64k iomem in that functional area:
>> {SYS,STG,AON} x {CRG,SYSCON}. None of these has 190 clocks.
>> The good news: the current DTS, as proposed here and in U-Boot master,
>> provides nodes for all 6 entities. The bad news is that the clock
>> assignments to those nodes and their numbering is messed up.
>> 
>> AFAICT PLL{0,1,2} _are_ generated in SYS_SYSCON and thus U-Boot gets it
>> wrong, in addition to the erroneous DTS.
> 
> The numbers are kinda hocus-pocus anyway, they are just made up since the
> clock numbering usually isn't something with a nice TRM to go and
> reference (unlike interrupts which usually are documented in that way).
> It is very helpful to make them aligned some register/bit positions or,
> but that is not required.
> IOW U-Boot is not wrong per se to use 190 instead of 0, but it is wrong
> to have different numbers in both places.
> 
> It sounds like you're saying that (and I have not looked) the U-Boot dts
> actually has structural difference w.r.t. what provides which clock?
> If so, that'll need to be fixed independently of the numbering problem.
> 
> Otherwise Xingyu & Yanhong should coordinate on which is the "correct"
> way of doing things & do it in both places.
> 

Oh, unfortunately, the 7110 can not support to mix the uboot dtb and linux dtb up.
If boot the Linux and should use the linux dtb instead of the uboot dtb.
Because all clock ids and reset ids in Linux and Uboot are different include
PLL, and some modules can work in Linux but not in uboot.
I suggest to boot Linux with its own linux dtb.

Best regards,
Xingyu Wu


