Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1F1D5FB9F0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 19:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbiJKRwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 13:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbiJKRwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 13:52:35 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D79940037;
        Tue, 11 Oct 2022 10:52:31 -0700 (PDT)
X-QQ-mid: bizesmtp67t1665510739tbwjqr9m
Received: from [192.168.1.231] ( [113.72.146.141])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 12 Oct 2022 01:52:18 +0800 (CST)
X-QQ-SSF: 0100000000200090B000B00A0000000
X-QQ-FEAT: eSZ1CZgv+JDpbz+8SZtFjGpBaoHZNJKphrrKecDmH7nFw9yOYamWc6tnUXtiK
        5hqBaXLrf5CuIHQTdb0xFyaOht6w2j/pHl/eluwYwBsXw/EYe1upcfnk8v/ClL+IhgLqg1D
        NQWyxjYe2HsuXrYs0WZNLcSpZYVdZC7iJCx0Pruqa/KnemRMSq9WYz9/OtaPqOrh8r+eFrn
        77a4bV7aFLfWOzNgU3oekYrgRNUegBHk8OhXbHqYfwIPeC6kkc1nuw7f+NPrXtWJIpCEjy+
        W+lDWWcd1xXRXOz8KqzeDSadVBRMPFcB3o8T9bdwfcYhDvuaEE8pihJHU/taIhOdmcCRC/r
        CpfCAVlKq4JPAfRbyNoY0rHYmdeAA==
X-QQ-GoodBg: 0
Message-ID: <6BB36B91BD2046FD+e637d229-f656-a548-c45a-8d62a0c7928d@linux.starfivetech.com>
Date:   Wed, 12 Oct 2022 01:52:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v1 17/30] dt-bindings: clock: Add
 starfive,jh7110-clkgen-sys bindings
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
 <20220929222647.23816-1-hal.feng@linux.starfivetech.com>
 <c99f6552-db04-fe30-ed69-4a08b0af5276@linaro.org>
Content-Language: en-US
From:   Hal Feng <hal.feng@linux.starfivetech.com>
In-Reply-To: <c99f6552-db04-fe30-ed69-4a08b0af5276@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:linux.starfivetech.com:qybglogicsvr:qybglogicsvr2
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,FORGED_MUA_MOZILLA,
        NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Sep 2022 12:58:12 +0200, Krzysztof Kozlowski wrote:
> On 30/09/2022 00:26, Hal Feng wrote:
> > From: Emil Renner Berthing <kernel@esmil.dk>
> > 
> > Add bindings for the system clock generator on the JH7110
> > RISC-V SoC by StarFive Technology Ltd.
> > 
> > Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> > Signed-off-by: Hal Feng <hal.feng@linux.starfivetech.com>
> 
> (...)
> 
> > +  '#clock-cells':
> > +    const: 1
> > +    description:
> > +      See <dt-bindings/clock/starfive-jh7110-sys.h> for valid indices.
> > +
> > +required:
> > +  - compatible
> > +  - clocks
> > +  - clock-names
> > +  - '#clock-cells'
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    syscrg_clk: clock-controller@13020000 {
> 
> Does not look like you tested the bindings. Please run `make
> dt_binding_check` (see
> Documentation/devicetree/bindings/writing-schema.rst for instructions).

Will rewrite the bindings and test them. Thanks.

Best regards,
Hal
