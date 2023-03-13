Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7C576B6DC1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 04:03:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbjCMDDe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 23:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbjCMDDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 23:03:19 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E8861B9;
        Sun, 12 Mar 2023 20:03:15 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 9644824E3E2;
        Mon, 13 Mar 2023 11:03:08 +0800 (CST)
Received: from EXMBX172.cuchost.com (172.16.6.92) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 13 Mar
 2023 10:37:35 +0800
Received: from [192.168.125.74] (183.27.96.115) by EXMBX172.cuchost.com
 (172.16.6.92) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 13 Mar
 2023 10:37:34 +0800
Message-ID: <afee6601-e21c-5cde-deab-221420de68e9@starfivetech.com>
Date:   Mon, 13 Mar 2023 10:37:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v5 03/21] clk: starfive: Rename clk-starfive-jh7100.h to
 clk-starfive-jh71x0.h
Content-Language: en-US
To:     Conor Dooley <conor@kernel.org>
CC:     <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, Stephen Boyd <sboyd@kernel.org>,
        "Michael Turquette" <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ben Dooks <ben.dooks@sifive.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        "Emil Renner Berthing" <emil.renner.berthing@canonical.com>,
        <linux-kernel@vger.kernel.org>
References: <20230311090733.56918-1-hal.feng@starfivetech.com>
 <20230311090733.56918-4-hal.feng@starfivetech.com>
 <c7e5a23a-16f9-4e30-adc7-a422abeb50ef@spud>
From:   Hal Feng <hal.feng@starfivetech.com>
In-Reply-To: <c7e5a23a-16f9-4e30-adc7-a422abeb50ef@spud>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [183.27.96.115]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX172.cuchost.com
 (172.16.6.92)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Mar 2023 14:00:23 +0000, Conor Dooley wrote:
> On Sat, Mar 11, 2023 at 05:07:15PM +0800, Hal Feng wrote:
>> From: Emil Renner Berthing <kernel@esmil.dk>
>> 
>> Rename clk-starfive-jh7100.h to clk-starfive-jh71x0.h for making
>> the code to be common.
>> 
>> Tested-by: Tommaso Merciai <tomm.merciai@gmail.com>
>> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
>> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
>> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
>> ---
>>  .../clk/starfive/{clk-starfive-jh7100.h => clk-starfive-jh71x0.h} | 0
> 
> So this patch has broken the build :(
> https://patchwork.kernel.org/project/linux-riscv/patch/20230311090733.56918-4-hal.feng@starfivetech.com/
> 
> I would imagine it is because you can't rename the header without also
> changing the users of the header.

Will fix it later. Thanks for pointing it out.

Best regards,
Hal
