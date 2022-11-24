Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D850F637573
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 10:44:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbiKXJoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 04:44:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbiKXJoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 04:44:19 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1478654CD;
        Thu, 24 Nov 2022 01:44:16 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 0F58D24E2E7;
        Thu, 24 Nov 2022 17:44:15 +0800 (CST)
Received: from EXMBX068.cuchost.com (172.16.6.68) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 24 Nov
 2022 17:44:15 +0800
Received: from [192.168.125.96] (183.27.97.81) by EXMBX068.cuchost.com
 (172.16.6.68) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 24 Nov
 2022 17:44:14 +0800
Message-ID: <eeffbdd3-51d3-87cb-dda1-81b99ab51698@starfivetech.com>
Date:   Thu, 24 Nov 2022 17:44:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v1 3/4] soc: starfive: Add StarFive JH71XX pmu driver
Content-Language: en-US
To:     Conor Dooley <conor.dooley@microchip.com>
CC:     Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        <linux-riscv@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20221118133216.17037-1-walker.chen@starfivetech.com>
 <20221118133216.17037-4-walker.chen@starfivetech.com>
 <CAJM55Z9jfpOW49Z5cdR18T0w4Ae6CQAYF-AsCD8eOcPczwgoZA@mail.gmail.com>
 <6303c341-a691-fd52-2861-74e9d3ea09c9@starfivetech.com>
 <Y385J2m5YByyAz0g@wendy>
From:   Walker Chen <walker.chen@starfivetech.com>
In-Reply-To: <Y385J2m5YByyAz0g@wendy>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [183.27.97.81]
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX068.cuchost.com
 (172.16.6.68)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/11/24 17:28, Conor Dooley wrote:
> Hey Walker,
> Just jumping in here...
> 
> On Thu, Nov 24, 2022 at 05:08:57PM +0800, Walker Chen wrote:
>> On 2022/11/19 2:31, Emil Renner Berthing wrote:
>> > On Fri, 18 Nov 2022 at 14:35, Walker Chen <walker.chen@starfivetech.com> wrote:
> 
>> >> diff --git a/include/soc/starfive/pm_domains.h b/include/soc/starfive/pm_domains.h
>> >> new file mode 100644
>> >> index 000000000000..a20e28e9baf3
>> >> --- /dev/null
>> >> +++ b/include/soc/starfive/pm_domains.h
>> >> @@ -0,0 +1,15 @@
>> >> +/* SPDX-License-Identifier: GPL-2.0 */
>> >> +/*
>> >> + * Copyright (C) 2022 StarFive Technology Co., Ltd.
>> >> + * Author: Walker Chen <walker.chen@starfivetech.com>
>> >> + */
>> >> +
>> >> +#ifndef __SOC_STARFIVE_PMDOMAINS_H__
>> >> +#define __SOC_STARFIVE_PMDOMAINS_H__
>> >> +
>> >> +#include <linux/types.h>
>> >> +
>> >> +void starfive_pmu_hw_event_turn_on(u32 mask);
>> >> +void starfive_pmu_hw_event_turn_off(u32 mask);
>> >> +
>> >> +#endif /* __SOC_STARFIVE_PMDOMAINS_H__ */
>> > 
>> > The header and functions within are named very generic, but
>> > implemented by the jh71xx-specific driver.
>> > 
>> > Also who should use this header? These functions are never called by
>> > anything in this series.
>> 
>> These two functions will be used by the GPU module. Only the power-off
>> of the GPU is not controlled by the software through PMU module. So
>> here the functions are needed to export.
> 
> ...the general policy is to avoid adding things without users. I think
> they should be kept as static functions for now & when your GPU driver
> is being upstreamed you can expose these functions. That way your usage
> of them can be reviewed with the appropriate context.
> 

OK, thank you for your advice. I will modify the code according to your suggestion
 in the next version of patch.

Best Regards,
Walker Chen

