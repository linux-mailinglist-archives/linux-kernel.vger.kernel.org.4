Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75AA7649830
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 04:19:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbiLLDTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Dec 2022 22:19:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbiLLDTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Dec 2022 22:19:44 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B253BBCB7;
        Sun, 11 Dec 2022 19:19:42 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id C95EF24E115;
        Mon, 12 Dec 2022 11:19:40 +0800 (CST)
Received: from EXMBX068.cuchost.com (172.16.6.68) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 12 Dec
 2022 11:19:40 +0800
Received: from [192.168.125.96] (113.72.147.126) by EXMBX068.cuchost.com
 (172.16.6.68) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 12 Dec
 2022 11:19:40 +0800
Message-ID: <c45b1c4c-1e7d-ff08-a07e-0752630339bc@starfivetech.com>
Date:   Mon, 12 Dec 2022 11:19:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [RESEND PATCH v2 1/3] dt-bindings: power: Add starfive,jh71xx-pmu
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <linux-riscv@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20221208084523.9733-1-walker.chen@starfivetech.com>
 <20221208084523.9733-2-walker.chen@starfivetech.com>
 <ac374e10-fb5b-c56c-7c76-b131446533fe@linaro.org>
From:   Walker Chen <walker.chen@starfivetech.com>
In-Reply-To: <ac374e10-fb5b-c56c-7c76-b131446533fe@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [113.72.147.126]
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

On 2022/12/8 17:03, Krzysztof Kozlowski wrote:
> On 08/12/2022 09:45, Walker Chen wrote:
>> Add bindings for Power Management Unit (PMU) on the StarFive JH71XX SoC.
>> 
>> Signed-off-by: Walker Chen <walker.chen@starfivetech.com>
> 
> 
> 
>> +    };
>> diff --git a/include/dt-bindings/power/starfive,jh7110-pmu.h b/include/dt-bindings/power/starfive,jh7110-pmu.h
>> new file mode 100644
>> index 000000000000..73c6a79a2181
>> --- /dev/null
>> +++ b/include/dt-bindings/power/starfive,jh7110-pmu.h
>> @@ -0,0 +1,17 @@
>> +/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
> 
> Why different license than the bindings? MIT is pretty compatible, but
> if it does not matter for you, keep same licenses as bindings.

MIT should be the least restrictive license. But it seems that BSD is more used and more safe.
So both of them will be used same licenses in next version. Thanks.

> 
>> +/*
>> + * Copyright (C) 2022 StarFive Technology Co., Ltd.
>> + * Author: Walker Chen <walker.chen@starfivetech.com>
>> + */
>> +#ifndef __DT_BINDINGS_POWER_JH7110_POWER_H__
>> +#define __DT_BINDINGS_POWER_JH7110_POWER_H__
>> +
>> +#define JH7110_PD_SYSTOP	0
>> +#define JH7110_PD_CPU		1
>> +#define JH7110_PD_GPUA		2
>> +#define JH7110_PD_VDEC		3
>> +#define JH7110_PD_VOUT		4
>> +#define JH7110_PD_ISP		5
>> +#define JH7110_PD_VENC		6
>> +
>> +#endif
> 
> Best regards,
> Krzysztof
> 

