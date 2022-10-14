Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0245FE793
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 05:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbiJNDZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 23:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbiJNDZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 23:25:43 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D342511D99A
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 20:25:40 -0700 (PDT)
X-QQ-mid: bizesmtp70t1665717897tggdurz9
Received: from [192.168.50.235] ( [113.72.147.11])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 14 Oct 2022 11:24:55 +0800 (CST)
X-QQ-SSF: 01000000000000B09000000A0000000
X-QQ-FEAT: Sm8l2YSuDykwx9zlf9aLJ0pyGRo8hfvyvKRxpLKx+MBlrJvD5pae//UyWDAHW
        na+5Zc7KD3nH6kxeXh6Yqpsg0LCAFrZLbmfKzGrO0BDwerR9xpCu/dFNr2efEUDZBpPls6y
        0LDmtH/jgCC728s/PbjIVFaNySz6J0mJm1iSKu6MrWK0k1EGan9i1YWZUUWi3EDBHYOAgW7
        2LECSrZ7SDNEbTiafYaBMYy8np1WuK2EYswgPqtX9OxtcVauKnhg8LPOPxBNgvYoa5exsQ9
        wQooaViwTDRQvilIPnMdhtemhJTHDS6oTPIW3h1NeNCTDhUYflKHmS7yqFkhvESXqWXhT27
        dc07HIQ4XYHjmjFWxc2ve/5cGaJHF6vbiVpGk7z6+CQyfKG3JElOgvjk2WIIg==
X-QQ-GoodBg: 0
Message-ID: <7CB1B79E00E38D81+9631ccf1-48b5-9ffa-e5cd-b0c9a7c50a56@linux.starfivetech.com>
Date:   Fri, 14 Oct 2022 11:24:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v1 29/30] RISC-V: defconfig: Enable CONFIG_SERIAL_8250_DW
Content-Language: en-US
To:     Conor Dooley <conor@kernel.org>
Cc:     Ben Dooks <ben.dooks@codethink.co.uk>,
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
References: <20220929143225.17907-1-hal.feng@linux.starfivetech.com>
 <20220930090653.7449-1-hal.feng@linux.starfivetech.com>
 <01c658ad-7f73-20fc-03c0-c82dcd820aa4@codethink.co.uk>
 <Yzdig6GepDx34u1j@spud>
From:   Hal Feng <hal.feng@linux.starfivetech.com>
In-Reply-To: <Yzdig6GepDx34u1j@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:linux.starfivetech.com:qybglogicsvr:qybglogicsvr2
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,FORGED_MUA_MOZILLA,
        NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Sep 2022 22:41:23 +0100, Conor Dooley wrote:
> On Fri, Sep 30, 2022 at 09:54:14PM +0100, Ben Dooks wrote:
> > On 30/09/2022 10:06, Hal Feng wrote:
> > > Add CONFIG_SERIAL_8250_DW=y, which is a necessary option for
> > > StarFive JH7110 and JH7100 SoCs to boot with serial ports.
> > > 
> > > Signed-off-by: Hal Feng <hal.feng@linux.starfivetech.com>
> > 
> > That might be useful for other users at some point an I don't
> > think it adds much code.
> 
> Honestly I think this should be applied for 6.1, for parity with the
> other SoCs that have their serial console enabled by default.
> 
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Could this patch be pulled out and applied for v6.1? So the JH7100
and the coming JH7110 can enable serial console by default when
booting. Thanks.

Best regards,
Hal
