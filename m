Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B96168609A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 08:31:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbjBAHbn convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 1 Feb 2023 02:31:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbjBAHbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 02:31:42 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D92D31C33B;
        Tue, 31 Jan 2023 23:31:40 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 08C3124E22D;
        Wed,  1 Feb 2023 15:31:39 +0800 (CST)
Received: from EXMBX172.cuchost.com (172.16.6.92) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 1 Feb
 2023 15:31:39 +0800
Received: from [192.168.125.110] (183.27.97.127) by EXMBX172.cuchost.com
 (172.16.6.92) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 1 Feb
 2023 15:31:38 +0800
Message-ID: <eb255bf6-ed92-d9d8-931b-9eb4212c3780@starfivetech.com>
Date:   Wed, 1 Feb 2023 15:31:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v3 6/7] riscv: dts: starfive: Add initial StarFive JH7110
 device tree
Content-Language: en-US
To:     Icenowy Zheng <uwu@icenowy.me>, Conor Dooley <conor@kernel.org>
CC:     <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ben Dooks <ben.dooks@sifive.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        "Philipp Zabel" <p.zabel@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        <linux-kernel@vger.kernel.org>
References: <20221220011247.35560-1-hal.feng@starfivetech.com>
 <20221220011247.35560-7-hal.feng@starfivetech.com> <Y6zHy9oL4xzl+6Rd@spud>
 <dda144a8397a175f3ce092485f08896c9a66d232.camel@icenowy.me>
From:   Hal Feng <hal.feng@starfivetech.com>
In-Reply-To: <dda144a8397a175f3ce092485f08896c9a66d232.camel@icenowy.me>
Content-Type: text/plain; charset="UTF-8"
X-Originating-IP: [183.27.97.127]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX172.cuchost.com
 (172.16.6.92)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Dec 2022 13:25:00 +0800, Icenowy Zheng wrote:
> 在 2022-12-28星期三的 22:48 +0000，Conor Dooley写道：
>> Hey,
>> 
>> On Tue, Dec 20, 2022 at 09:12:46AM +0800, Hal Feng wrote:
[...]
>> > +               U74_1: cpu@1 {
>> > +                       compatible = "sifive,u74-mc", "riscv";
>> > +                       reg = <1>;
>> > +                       d-cache-block-size = <64>;
>> > +                       d-cache-sets = <64>;
>> > +                       d-cache-size = <32768>;
>> > +                       d-tlb-sets = <1>;
>> > +                       d-tlb-size = <40>;
>> > +                       device_type = "cpu";
>> > +                       i-cache-block-size = <64>;
>> > +                       i-cache-sets = <64>;
>> > +                       i-cache-size = <32768>;
>> > +                       i-tlb-sets = <1>;
>> > +                       i-tlb-size = <40>;
>> > +                       mmu-type = "riscv,sv39";
>> > +                       next-level-cache = <&ccache>;
>> > +                       riscv,isa = "rv64imafdc";
>> 
>> That also begs the question:
>> Do your u74s support RV64GBC, as the (current) SiFive documentation
>> suggests?
> 
> It supports RV64GCZbaZbb.
> 
> B is not a well-defined thing by specifications, so it should be
> prevented here.

Thank you for your kindly reply.

Best regards,
Hal
