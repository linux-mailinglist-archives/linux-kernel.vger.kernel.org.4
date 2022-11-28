Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A76B1639FFB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 04:09:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbiK1DJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 22:09:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbiK1DJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 22:09:29 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CFF6DF33;
        Sun, 27 Nov 2022 19:09:24 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id DC2C024E1D3;
        Mon, 28 Nov 2022 11:09:21 +0800 (CST)
Received: from EXMBX068.cuchost.com (172.16.6.68) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 28 Nov
 2022 11:09:21 +0800
Received: from [192.168.125.96] (183.27.97.81) by EXMBX068.cuchost.com
 (172.16.6.68) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 28 Nov
 2022 11:09:21 +0800
Message-ID: <c2bfb7bc-f679-3731-fef4-4c7c2e4e5445@starfivetech.com>
Date:   Mon, 28 Nov 2022 11:09:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v1 3/4] soc: starfive: Add StarFive JH71XX pmu driver
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <linux-riscv@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20221118133216.17037-1-walker.chen@starfivetech.com>
 <20221118133216.17037-4-walker.chen@starfivetech.com>
 <15a860d8-d134-5eab-1635-74622421c5d7@linaro.org>
From:   Walker Chen <walker.chen@starfivetech.com>
In-Reply-To: <15a860d8-d134-5eab-1635-74622421c5d7@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [183.27.97.81]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX068.cuchost.com
 (172.16.6.68)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/11/21 18:14, Krzysztof Kozlowski wrote:
> On 18/11/2022 14:32, Walker Chen wrote:
>> Add generic power domain driver for the StarFive JH71XX SoC.
>> 
>> Signed-off-by: Walker Chen <walker.chen@starfivetech.com>
> 
> Thank you for your patch. There is something to discuss/improve.
> 
>> +
>> +MODULE_AUTHOR("Walker Chen <walker.chen@starfivetech.com>");
>> +MODULE_DESCRIPTION("StarFive JH71XX Power Domain Driver");
>> +MODULE_LICENSE("GPL");
>> diff --git a/include/soc/starfive/pm_domains.h b/include/soc/starfive/pm_domains.h
>> new file mode 100644
>> index 000000000000..a20e28e9baf3
>> --- /dev/null
>> +++ b/include/soc/starfive/pm_domains.h
>> @@ -0,0 +1,15 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * Copyright (C) 2022 StarFive Technology Co., Ltd.
>> + * Author: Walker Chen <walker.chen@starfivetech.com>
>> + */
>> +
>> +#ifndef __SOC_STARFIVE_PMDOMAINS_H__
>> +#define __SOC_STARFIVE_PMDOMAINS_H__
>> +
>> +#include <linux/types.h>
>> +
>> +void starfive_pmu_hw_event_turn_on(u32 mask);
>> +void starfive_pmu_hw_event_turn_off(u32 mask);
> 
> These are not used outside of driver. Drop entire header file.
> 

Yes, these two exported functions will be drop in the next version of patches.

Best Regards,
Walker Chen

