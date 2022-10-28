Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A56B610864
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 04:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234558AbiJ1Cq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 22:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234884AbiJ1Cq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 22:46:57 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A19DA9F34F;
        Thu, 27 Oct 2022 19:46:55 -0700 (PDT)
X-QQ-mid: bizesmtp77t1666925205trdp212h
Received: from [192.168.125.106] ( [113.72.144.82])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 28 Oct 2022 10:46:44 +0800 (CST)
X-QQ-SSF: 01000000000000B0B000000A0000000
X-QQ-FEAT: vqhsT3OOnzRLiM/g5o2j2J4W/+or9KnaRTkPOvebYDLsCzhWkN0QrHZbnLoVo
        M/MhoZK0UtjJIzkdUkWy4KmfRps7PNjYdykPWjVgdeMBJDreHNWrZMezfqTdsGEQquL+rFb
        bmLVfCjfEiL/+WJfDfk3jvnIf+Mtl4nNT2g+DLQWcFIuhFdJIyG9shL42UPYIg2EYp8oML4
        j1tm8oPF9yK8KRRh1/eEQ/iVfNvLwQa5yq1FdOiprbOuuaq5NwJ5mrXE0UKN3NpH62Yiu76
        oFMMYkeOM98R+3htFcuNmJl2IKijsoe/pbTbXo1LF2dk00BGpQzOL4MnonpcpXB7qW+C8e4
        q1v0Idjt3wIZ5is6IV5KeliQKK7/6UH3LpI8VYY
X-QQ-GoodBg: 0
Message-ID: <44B201EE232142D8+724bfbd1-f1aa-a13d-fd38-655df7d7036e@linux.starfivetech.com>
Date:   Fri, 28 Oct 2022 10:46:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v1 15/30] clk: starfive: Use regmap APIs to operate
 registers
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-riscv@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        linux-kernel@vger.kernel.org
References: <20220929143225.17907-1-hal.feng@linux.starfivetech.com>
 <20220929175602.19946-1-hal.feng@linux.starfivetech.com>
 <20220930214824.A14ACC433D6@smtp.kernel.org>
 <CAJM55Z8xxrKqaN64KAP9miTis4wFbL2S9uhV5h-SOiYjbYng+g@mail.gmail.com>
 <20221012230525.C6E58C433D7@smtp.kernel.org>
 <07B628ED6CABEF1D+932737cc-7d4b-4071-531e-82f88d89a872@linux.starfivetech.com>
 <20221027012605.B6769C433C1@smtp.kernel.org>
Content-Language: en-US
From:   Hal Feng <hal.feng@linux.starfivetech.com>
In-Reply-To: <20221027012605.B6769C433C1@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:linux.starfivetech.com:qybglogicsvr:qybglogicsvr2
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,FORGED_MUA_MOZILLA,
        NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Oct 2022 18:26:03 -0700, Stephen Boyd wrote:
> Quoting Hal Feng (2022-10-22 21:11:41)
> > On Wed, 12 Oct 2022 16:05:23 -0700, Stephen Boyd wrote:
> > > I think we should use auxiliary bus and split the driver logically into
> > > a reset driver in drivers/reset and a clk driver in drivers/clk. That
> > > way the appropriate maintainers can review the code. There is only one
> > > platform device with a single reg property and node in DT, but there are
> > > two drivers. 
> > 
> > Yes, I agree that the reset driver and the clock driver should be split.
> > However, I think using auxiliary bus is a little bit complicated in this
> > case, because the reset is not a part of functionality of the clock in 
> > JH7110. They just share a common register base address.
> 
> That is why auxiliary bus exists.
> 
> > I think it is 
> > better to use ioremap for the same address, and the dt will be like
> > 
> > syscrg_clk: clock-controller@13020000 {
> >         compatible = "starfive,jh7110-clkgen-sys";
> >         reg = <0x0 0x13020000 0x0 0x10000>;
> >         ...
> > };
> > syscrg_rst: reset-controller@13020000 {
> >         compatible = "starfive,jh7110-reset-sys";
> >         reg = <0x0 0x13020000 0x0 0x10000>;
> >         ...
> > };
> > 
> > What do you think of this approach? I would appreciate your suggestions.
> > 
> 
> We shouldn't have two different nodes with the same reg property. Please
> ioremap in whatever driver probes and creates the auxiliary device(s)
> and then pass the void __iomem * to it.

Okay, I will use auxiliary bus for clock and reset driver on the next version.

Best regards,
Hal

