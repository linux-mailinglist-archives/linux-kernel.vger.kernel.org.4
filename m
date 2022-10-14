Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB305FE6CB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 04:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbiJNCFk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 22:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiJNCFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 22:05:38 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC78C14FD24;
        Thu, 13 Oct 2022 19:05:35 -0700 (PDT)
X-QQ-mid: bizesmtp66t1665713125t0dqa2lu
Received: from [192.168.50.235] ( [113.72.147.11])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 14 Oct 2022 10:05:24 +0800 (CST)
X-QQ-SSF: 01000000000000B09000000A0000000
X-QQ-FEAT: 2w1wQVt6itRSuTllDZ9c9Ncos8L/9I0A7xLMcJaSF7QfOTy00g1XU9/te0E+F
        u9+R5cNiUMb+3Gxnu/jD8XTWeJNgCEPTWzy+rsT//Kh6LYfRsZwdtcxaTcoD0ON+maBm+K2
        oJV5WixWyamuOzzL1Vttws3ETFJ0i1LVuW3fv/J5BSJAOiKspFGGzhTskEWVCCMih9SPqjJ
        Cg041J/HHc+Rb/6NmNobZiZLHwUctb/P4TEtSPN9we9Lz02rplMZB0uAxa6KfvdRad9xXK+
        MZS/lyqLVCJxm9r6rhz06SHHwEN1wiNcU/0ln0vPr68YN+a9RZWaojCNkpj7E53WYUxMoqn
        +EYoj3o1P4udrqrgjLeIDscuE7OORTnuaeIUPaeSLH+g2nn4/k=
X-QQ-GoodBg: 0
Message-ID: <9A0A65FD121C76C0+be2a3620-d30f-b6ac-3241-89b40191030b@linux.starfivetech.com>
Date:   Fri, 14 Oct 2022 10:05:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v1 26/30] pinctrl: starfive: Add StarFive JH7110 driver
Content-Language: en-US
To:     Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
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
        linux-kernel@vger.kernel.org
References: <20220929143225.17907-1-hal.feng@linux.starfivetech.com>
 <20220930074341.6386-1-hal.feng@linux.starfivetech.com>
 <CACRpkdYMQ98Q1iXr7-YdUkQrSK8aauZuSFeDp2f7ubNH_W7_HQ@mail.gmail.com>
 <CAJM55Z91TL4eLOjZsRVZuxspcL40gG2MQRZf31h0L2yyaW--Cg@mail.gmail.com>
From:   Hal Feng <hal.feng@linux.starfivetech.com>
In-Reply-To: <CAJM55Z91TL4eLOjZsRVZuxspcL40gG2MQRZf31h0L2yyaW--Cg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:linux.starfivetech.com:qybglogicsvr:qybglogicsvr2
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,FORGED_MUA_MOZILLA,
        NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Oct 2022 15:31:59 +0200, Emil Renner Berthing wrote:
> On Tue, 4 Oct 2022 at 10:57, Linus Walleij <linus.walleij@linaro.org> wrote:
> >
> > On Fri, Sep 30, 2022 at 9:45 AM Hal Feng
> > <hal.feng@linux.starfivetech.com> wrote:
> >
> > > From: Jianlong Huang <jianlong.huang@starfivetech.com>
> > >
> > > Add pinctrl driver for StarFive JH7110 SoC.
> > >
> > > Signed-off-by: Jianlong Huang <jianlong.huang@starfivetech.com>
> > > Signed-off-by: Hal Feng <hal.feng@linux.starfivetech.com>
> >
> > Since Emil submitted the first driver I would really appreciate his review
> > on this version.
> 
> I tried really hard to come up with a good way to share code between
> the JH7100 and JH7110 drivers, but so many details different on the
> JH7110 that it's probably best to just have a separate driver, so that
> part is fine.
> 
> As mentioned elsewhere this driver certainly shouldn't be accepted
> without following the generic pinctrl and pinmux bindings. You can see
> the driver I wrote here:
> https://github.com/esmil/linux/commit/c2633315385fef1a25aa3711facef07d915820e1
> 
> It is certainly not perfect and far from complete, but at least it
> does follow the generic bindings. Feel free to copy all or parts of
> that.

Thanks for your great contribution! We will rewrite the pinctrl driver
and bindings so make them follow the generic pinctrl framework.

Best regards,
Hal

