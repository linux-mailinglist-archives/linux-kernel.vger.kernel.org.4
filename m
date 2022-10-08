Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9DA05F82D3
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 05:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbiJHDpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 23:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiJHDpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 23:45:18 -0400
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 570883385D;
        Fri,  7 Oct 2022 20:45:10 -0700 (PDT)
X-QQ-mid: bizesmtp83t1665200686tzpdo9vx
Received: from [192.168.0.179] ( [113.85.219.225])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 08 Oct 2022 11:44:44 +0800 (CST)
X-QQ-SSF: 0100000000000070B000000A0000000
X-QQ-FEAT: 5q30pvLz2icsEuufAGCipRcNEAph5F1NreXxmwTiOB81pjLvIeHTUCJHoejvj
        xszPS/H7HnRPCCwPI76Wy6OgloCXqv3WBfz+JCNR6CvwHY8jIiK7OaSs4BSz3FHgyDWm18M
        oaRfvlN9I9TAJ/2luWIMMslqd4pAJ145pQsI/sT7o95rfvr4YXDu0luZFoV6fOraDZRqXO0
        L26Ewd0+jc8P1Z3CUfFEnzxgZ9lx63QvxRxuB6Dz+LQUh7b5oTbz6pQNde69BTIYZ8u+HBX
        Ci8t6uuccQ+2QZ4hm7IqzvkW5164wMP8NVGAMap/WQup2FhDKWi5GRwuHDBVd1GVM0KjYIT
        s3RB1I3QAnJPYSb7Io2o/DVdiLtoOjnthc396jbELnR/+r20Y1tyoa9xl8g70IipdeIRQDt
X-QQ-GoodBg: 0
Message-ID: <394AB2D3535D9461+093b7754-53cb-87c7-8f0e-68326a1ab3c5@linux.starfivetech.com>
Date:   Sat, 8 Oct 2022 11:44:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v1 01/30] dt-bindings: riscv: Add StarFive JH7110 bindings
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
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
 <20220929143225.17907-2-hal.feng@linux.starfivetech.com>
 <5cd77839-d75b-9290-5d34-90d6464938d6@linaro.org>
From:   Hal Feng <hal.feng@linux.starfivetech.com>
In-Reply-To: <5cd77839-d75b-9290-5d34-90d6464938d6@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:linux.starfivetech.com:qybglogicsvr:qybglogicsvr2
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,FORGED_MUA_MOZILLA,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_NONE,T_SPF_HELO_TEMPERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Sep 2022 16:34:22 +0200, Krzysztof Kozlowski wrote:
> On 29/09/2022 16:31, Hal Feng wrote:
> > From: Emil Renner Berthing <kernel@esmil.dk>
> 
> Drop last "bindings" from subject, it's redundant.

Will fix. Thanks.

> 
> > 
> > Add device tree bindings for the StarFive JH7110 RISC-V SoC and the
> > VisionFive2 board for it.
> > 
> > Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> > Signed-off-by: Hal Feng <hal.feng@linux.starfivetech.com>
> > ---
> >  Documentation/devicetree/bindings/riscv/starfive.yaml | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/riscv/starfive.yaml b/Documentation/devicetree/bindings/riscv/starfive.yaml
> > index 5b36243fd674..543be573921d 100644
> > --- a/Documentation/devicetree/bindings/riscv/starfive.yaml
> > +++ b/Documentation/devicetree/bindings/riscv/starfive.yaml
> > @@ -21,6 +21,9 @@ properties:
> >        - items:
> >            - const: beagle,beaglev-starlight-jh7100-r0
> >            - const: starfive,jh7100
> 
> Blank line.

Will fix. Thanks.

Best Regards,
Hal

