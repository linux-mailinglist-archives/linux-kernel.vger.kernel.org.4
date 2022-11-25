Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC80638280
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 03:41:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbiKYClD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 21:41:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiKYCkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 21:40:55 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F00252B180;
        Thu, 24 Nov 2022 18:40:53 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id A878924DBCB;
        Fri, 25 Nov 2022 10:40:52 +0800 (CST)
Received: from EXMBX068.cuchost.com (172.16.6.68) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 25 Nov
 2022 10:40:52 +0800
Received: from [192.168.125.96] (183.27.97.81) by EXMBX068.cuchost.com
 (172.16.6.68) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 25 Nov
 2022 10:40:51 +0800
Message-ID: <dfd4d062-f5f3-826d-b314-73302fc6c86c@starfivetech.com>
Date:   Fri, 25 Nov 2022 10:40:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v1 3/4] soc: starfive: Add StarFive JH71XX pmu driver
Content-Language: en-US
To:     Conor Dooley <conor@kernel.org>, Arnd Bergmann <arnd@arndb.de>
CC:     <linux-riscv@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>
References: <20221118133216.17037-1-walker.chen@starfivetech.com>
 <20221118133216.17037-4-walker.chen@starfivetech.com> <Y3fe0LbZlOX1Dcw5@spud>
From:   Walker Chen <walker.chen@starfivetech.com>
In-Reply-To: <Y3fe0LbZlOX1Dcw5@spud>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [183.27.97.81]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX068.cuchost.com
 (172.16.6.68)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/11/19 3:36, Conor Dooley wrote:
> Hey Walker,
> 
> On Fri, Nov 18, 2022 at 09:32:15PM +0800, Walker Chen wrote:
>> Add generic power domain driver for the StarFive JH71XX SoC.
>> 
>> Signed-off-by: Walker Chen <walker.chen@starfivetech.com>
>> ---
>>  MAINTAINERS                       |   8 +
> 
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index a70c1d0f303e..112f1e698723 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -19623,6 +19623,14 @@ F:	Documentation/devicetree/bindings/reset/starfive,jh7100-reset.yaml
>>  F:	drivers/reset/starfive/
>>  F:	include/dt-bindings/reset/starfive*
>>  
>> +STARFIVE JH71XX PMU CONTROLLER DRIVER
>> +M:	Walker Chen <walker.chen@starfivetech.com>
>> +S:	Maintained
> 
> Should this be supported? (ditto the other series that you guys have
> sent out in the last few days)

Ok, will be changed to Supported.

> 
>> +F:	Documentation/devicetree/bindings/power/starfive*
>> +F:	drivers/soc/starfive/jh71xx_pmu.c
>> +F:	include/soc/starfive/pm_domains.h
>> +F:	include/dt-bindings/power/jh7110-power.h
> 
> I noticed that you have not CCed Arnd on these patches, which makes me
> wonder how do you intend getting these patches applied?
> Until now, Palmer has mostly merged RISC-V drivers/soc patches, but in
> the last few days I've taken over for drivers/soc/{sifive,microchip}.
> 
> Are you going to send PRs for this stuff to Arnd, or would you like me
> to apply patches for drivers/soc/startech? I happy to do that for you if
> you like.
> 
> If you're going to send pull requests, I am not sure if Arnd requires
> GPG signed tags for them. Arnd?
> 
> Otherwise, if you want me to take them, please add something like the
> following, in addition to the entry your series already adds for the
> specific driver:
> STARFIVE SOC DRIVERS
> M:	Conor Dooley <conor@kernel.org>
> S:	Maintained
> T:	git https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux.git/
> F:	drivers/soc/starfive/
> F:	include/soc/starfive/

Thank you for taking the time to review and comment. I hope you apply these patches 
for drivers/soc/starfive. If you do that, I am very grateful to you!
The above description will be added to MAINTAINERS in the next version of patch.

Best Regards,
Walker Chen

