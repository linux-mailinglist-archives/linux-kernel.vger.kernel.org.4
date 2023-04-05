Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CCE96D721A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 03:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236690AbjDEBkj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 4 Apr 2023 21:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbjDEBkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 21:40:37 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4FB32D6A;
        Tue,  4 Apr 2023 18:40:34 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id A5D6724DBFD;
        Wed,  5 Apr 2023 09:40:27 +0800 (CST)
Received: from EXMBX172.cuchost.com (172.16.6.92) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 5 Apr
 2023 09:40:27 +0800
Received: from [172.16.16.231] (183.27.98.171) by EXMBX172.cuchost.com
 (172.16.6.92) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 5 Apr
 2023 09:40:26 +0800
Message-ID: <39a2c174-c7f5-cb0f-5430-87b859a2ea5c@starfivetech.com>
Date:   Wed, 5 Apr 2023 09:40:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v7 21/22] riscv: dts: starfive: Add StarFive JH7110
 VisionFive 2 board device tree
To:     Shengyu Qu <wiagn233@outlook.com>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>
CC:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor@kernel.org>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ben Dooks <ben.dooks@sifive.com>,
        "Daniel Lezcano" <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        <linux-kernel@vger.kernel.org>
References: <20230401111934.130844-1-hal.feng@starfivetech.com>
 <20230401111934.130844-22-hal.feng@starfivetech.com>
 <TY3P286MB26110E2983EB074270B7610898939@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
Content-Language: en-US
From:   Hal Feng <hal.feng@starfivetech.com>
In-Reply-To: <TY3P286MB26110E2983EB074270B7610898939@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="UTF-8"
X-Originating-IP: [183.27.98.171]
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX172.cuchost.com
 (172.16.6.92)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Apr 2023 02:38:25 +0800, Shengyu Qu wrote:
> Hi Hal,
> 
>> +    aliases {
>> +        i2c0 = &i2c0;
>> +        i2c2 = &i2c2;
>> +        i2c5 = &i2c5;
>> +        i2c6 = &i2c6;
>> +        serial0 = &uart0;
>> +    };
>> +
>> +    chosen {
>> +        stdout-path = "serial0:115200n8";
>> +    };
>> +
>> +    cpus {
>> +        timebase-frequency = <4000000>;
> 
> Is mtime frequency on JH7110 could be modified?  If not, I think it's better
> 
> to put it into jh7110.dtsi.

This frequency is from (osc / 6). This is based on the frequency
of the crystal oscillator on the board. So we set it here.

Best regards,
Hal

> 
>> +    };
>> +
>> +    memory@40000000 {
>> +        device_type = "memory";
>> +        reg = <0x0 0x40000000 0x1 0x0>;
>> +    };
>> +
>> +    gpio-restart {
>> +        compatible = "gpio-restart";
>> +        gpios = <&sysgpio 35 GPIO_ACTIVE_HIGH>;
>> +        priority = <224>;
>> +    };
>> +};
>> +
> 
> Best regards,
> 
> Shengyu
> 

