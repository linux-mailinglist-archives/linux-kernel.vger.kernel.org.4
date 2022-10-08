Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 684EE5F82B0
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 05:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbiJHDSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 23:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiJHDSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 23:18:51 -0400
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D7D7F099;
        Fri,  7 Oct 2022 20:18:42 -0700 (PDT)
X-QQ-mid: bizesmtp81t1665199102tpuhbm7o
Received: from [192.168.0.179] ( [113.85.219.225])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 08 Oct 2022 11:18:20 +0800 (CST)
X-QQ-SSF: 0100000000000060B000000A0000000
X-QQ-FEAT: Xz3VOcA7Mr3FZ3OhgK4//97wG8mXezqudifr+ShDF71jo6ZVNegJFLWSbQFjs
        41Jkwc4FOs1oe/FY1u2vbwzyJsrWi07okA/K9Kw8EcCWxzXCDMZjCtIecmdYWkahSCFZmq2
        FlZUaOWjGBheO9+8V1nF8nJLhkK0tq1vOo2Y865x5+gXgoM+figV3SUenuKBQBYi2ppIYYt
        zbUI+FFvvQwk1WTagPRUVB8dtcleD3gu0azJcoLMfx49m0J8R5r3y4EK17gIkJR0yc1c+UG
        0ia8wSy9vJGL0dNANOgjtjEu6Or+njZqd8XIbyahDoFBISbvIxLs9uVPIdQnfhor+THm8xL
        NaZwtBbKzX7gkQpcg1bdYyZpa4QAljGfhbt9pfnHJUJbPI+HtcKLhzm2vIcyg==
X-QQ-GoodBg: 0
Message-ID: <98CA462042A5283C+38a7a131-b02a-e4a2-180d-1e64cb788af3@linux.starfivetech.com>
Date:   Sat, 8 Oct 2022 11:18:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v1 00/30] Basic StarFive JH7110 RISC-V SoC support
Content-Language: en-US
To:     Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
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
 <CAJM55Z8zg=-meSGhFnVh4Tb4=5M3sHis1oapzXCEipyDkuyvyg@mail.gmail.com>
From:   Hal Feng <hal.feng@linux.starfivetech.com>
In-Reply-To: <CAJM55Z8zg=-meSGhFnVh4Tb4=5M3sHis1oapzXCEipyDkuyvyg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:linux.starfivetech.com:qybglogicsvr:qybglogicsvr2
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,FORGED_MUA_MOZILLA,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Oct 2022 15:05:45 +0200, Emil Renner Berthing wrote:
> On Thu, 29 Sept 2022 at 16:34, Hal Feng <hal.feng@linux.starfivetech.com> wrote:
> > This series adds basic support for the StarFive JH7110 RISC-V SoC to
> > boot up and get a serial console. This series includes basic clock,
> > reset, pinctrl and uart drivers, which are necessary for booting.
> > It's should be noted that the reset and clock driver codes of JH7110
> > are partly common with those of JH7100, so the common codes are
> > factored out and can be reused by drivers of JH7110 and other more
> > SoCs from StarFive.
> >
> > The JH7110 is the upgraded version of JH7100 and also the first official
> > released version of JH71XX series SoCs from StarFive Technology Ltd.
> > The VisionFive 2 boards equipped with JH7110 SoCs are launched
> > recently [1]. More information and support can visit RVspace wiki [2].
> >
> > This series is also available at
> > https://github.com/hal-feng/linux/commits/visionfive2-minimal
> >
> > [1] https://www.cnx-software.com/2022/08/23/starfive-visionfive-2-quad-core-risc-v-sbc-linux/
> > [2] https://wiki.rvspace.org/
> 
> Hi Hal,
> 
> Firstly thanks for working on this! And sorry about the late reply. On
> the next version could you please cc
> emil.renner.berthing@canonical.com since it seems to handle the
> mailing list a bit better.

OK, I will cc to your new email instead on v2.

Best Regards,
Hal

> I see you've changed the clock/reset and pinctrl quite a bit, so I'll
> comment on that separatel

