Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 386915FBA08
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 20:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbiJKSBc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 14:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiJKSB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 14:01:29 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2DAC6B67F;
        Tue, 11 Oct 2022 11:01:27 -0700 (PDT)
X-QQ-mid: bizesmtp76t1665511278t5i75y1k
Received: from [192.168.1.231] ( [113.72.146.141])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 12 Oct 2022 02:01:16 +0800 (CST)
X-QQ-SSF: 0100000000200090B000B00A0000000
X-QQ-FEAT: Xz3VOcA7Mr1IeMy5YkFr3EQysBY1c40hmsRb8FmCb9HYXwFMzxuV3pNPfW+Oo
        Yy88ZEliVWGfuHpA9UsW0WR3SsrAgYJ/mLN08uP1rAii9nv3hF0/fAVMKfE3oSRBi5IuKh1
        U6iVYMZ3Oc63DZX1BtdGiS6TE0gZ/iCK7uw8lKbdAavr8+ly9R+pW+ggB1N5PXseqyAuvtP
        CQ5imFaDSqNGkNvpJomvgk7Yuz920GfcMiAaVEb9dS2p81f/c1PCl1SnWT6u2mFa2/jR0OI
        ZLu6IQl++hK59OYWwKDqXiBU88HgVfhBH1w3vnz3X3JsZGmpxtML80nMfBf8/QW6eFJzT60
        IDiKhi5WSKdJtJ5KxPm5ABHVKtfOqPAfUvAblZJzbb5ix17+Uo=
X-QQ-GoodBg: 0
Message-ID: <950768A5571BD396+4cf106df-5127-4646-5879-a516a002760c@linux.starfivetech.com>
Date:   Wed, 12 Oct 2022 02:01:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v1 20/30] dt-bindings: clock: Add
 starfive,jh7110-clkgen-aon bindings
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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
 <20220930055632.5136-1-hal.feng@linux.starfivetech.com>
 <ff493398-7786-db0d-ae94-b52207e2a56c@linaro.org>
From:   Hal Feng <hal.feng@linux.starfivetech.com>
In-Reply-To: <ff493398-7786-db0d-ae94-b52207e2a56c@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:linux.starfivetech.com:qybglogicsvr:qybglogicsvr2
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,FORGED_MUA_MOZILLA,
        NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Sep 2022 12:59:01 +0200, Krzysztof Kozlowski wrote:
> On 30/09/2022 07:56, Hal Feng wrote:
> > From: Emil Renner Berthing <kernel@esmil.dk>
> > 
> > Add bindings for the always-on clock generator on the JH7110
> > RISC-V SoC by StarFive Technology Ltd.
> > 
> 
> (...)
> 
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/clock/starfive-jh7110-sys.h>
> > +
> > +    aoncrg: clock-controller@17000000 {
> 
> Does not look like you tested the bindings. Please run `make
> dt_binding_check` (see
> Documentation/devicetree/bindings/writing-schema.rst for instructions).
Will rewrite the bindings and test them. Thanks.

Best regards,
Hal

