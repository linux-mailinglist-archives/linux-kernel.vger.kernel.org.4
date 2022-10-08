Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B16025F86F7
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 20:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbiJHS7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 14:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbiJHS7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 14:59:09 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7074AF59B
        for <linux-kernel@vger.kernel.org>; Sat,  8 Oct 2022 11:57:16 -0700 (PDT)
X-QQ-mid: bizesmtp88t1665255258tpzq9y8b
Received: from [192.168.0.179] ( [113.85.219.225])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 09 Oct 2022 02:54:17 +0800 (CST)
X-QQ-SSF: 0100000000200090B000B00A0000000
X-QQ-FEAT: 2aB7Y8UOkmPkPMNeCU9D3ga5YoRbEIqL1KC8KFDdIkY5MNJpOgc3ZKG/gxh+q
        tIyW3rJ0wzkKyCuqCwoV2xIymEMWMJR/4HtKSUyu9CcbfHPW2xl6doxSioe1Aq4sNtqB7Sl
        BrSm/RhQbI7TXLjPpS7BHqE519HdiFmr0p5w2bcojiCUgvNJUJVkXdVypW3hsrfcjtXMFLR
        VGSCOGgc2XZitLhR9u+wbmZTKeHiUSt9IoO86ERYSRJ9Q54pVg27NKhvLjjQsysXCkNiTRY
        dQcuk2HrH6f2vaB154XQi22zeSyIutnuoqgtSBv/VrT0luU4VeVcZV2v1WkWCPMr2mpC8tT
        xBNm/NlHq30bjtNhU3Mr6Ov5UNtMVhFiFrSG0nMyypZH2m2dlCTK6G1ilkXcA==
X-QQ-GoodBg: 0
Message-ID: <F3EFC1097B3F50DD+9675984c-d18b-f70e-1e07-715c7ce23836@linux.starfivetech.com>
Date:   Sun, 9 Oct 2022 02:54:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v1 04/30] dt-bindings: sifive-l2-cache: Support StarFive
 JH71x0 SoCs
Content-Language: en-US
To:     Ben Dooks <ben.dooks@codethink.co.uk>
Cc:     Conor Dooley <conor@kernel.org>, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
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
 <20220929143225.17907-5-hal.feng@linux.starfivetech.com>
 <YzW60PDwnJ7GeLYK@spud>
 <b2880b7b-c50d-9161-4278-615cf66c2094@codethink.co.uk>
From:   Hal Feng <hal.feng@linux.starfivetech.com>
In-Reply-To: <b2880b7b-c50d-9161-4278-615cf66c2094@codethink.co.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:linux.starfivetech.com:qybglogicsvr:qybglogicsvr2
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,FORGED_MUA_MOZILLA,
        NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Oct 2022 10:26:44 +0100, Ben Dooks wrote:
> On 29/09/2022 16:33, Conor Dooley wrote:
> > On Thu, Sep 29, 2022 at 10:31:59PM +0800, Hal Feng wrote:
> >> From: Emil Renner Berthing <kernel@esmil.dk>
> >>
> >> This cache controller is also used on the StarFive JH7100 and JH7110
> >> SoCs.
> >
> > Ditto this patch, hopefully [0] will have landed as 6.1 material
> > before you get around to an actual v2.
> >
> > Thanks,
> > Conor
> >
> > 0 - https://lore.kernel.org/linux-riscv/20220913061817.22564-1-zong.li@sifive.com/
> 
> Also, the l2 cache is being proprely named the ccache (composable cache)
> as it is not necessarily an L2 cache.
> 

Thanks for reminding. I will modify the code, based on the patches from Zong Li.
I hope his patch series will be merged as soon as possible.

Best regards,
Hal
