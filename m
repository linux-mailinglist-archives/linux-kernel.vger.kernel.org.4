Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 132B366D720
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 08:45:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235896AbjAQHpb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 02:45:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235913AbjAQHp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 02:45:29 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D67EC23DA9;
        Mon, 16 Jan 2023 23:45:25 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 6E6D624E208;
        Tue, 17 Jan 2023 15:45:23 +0800 (CST)
Received: from EXMBX168.cuchost.com (172.16.6.78) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 17 Jan
 2023 15:45:23 +0800
Received: from [192.168.125.95] (113.72.144.207) by EXMBX168.cuchost.com
 (172.16.6.78) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 17 Jan
 2023 15:45:22 +0800
Message-ID: <02174460-87b8-bb1c-7b6f-39694fa416c3@starfivetech.com>
Date:   Tue, 17 Jan 2023 15:45:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3 0/3] JH7110 PMU Support
Content-Language: en-US
To:     Conor Dooley <conor@kernel.org>
CC:     <linux-riscv@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230116074259.22874-1-walker.chen@starfivetech.com>
 <Y8WjKArEZH5zd5jb@spud>
From:   Walker Chen <walker.chen@starfivetech.com>
In-Reply-To: <Y8WjKArEZH5zd5jb@spud>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [113.72.144.207]
X-ClientProxiedBy: EXCAS061.cuchost.com (172.16.6.21) To EXMBX168.cuchost.com
 (172.16.6.78)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/1/17 3:19, Conor Dooley wrote:
> Hey Walker,
> 
> On Mon, Jan 16, 2023 at 03:42:56PM +0800, Walker Chen wrote:
>> Hello,
>> 
>> This patchset adds PMU (Power Management Unit) controller driver for the
>> StarFive JH7110 SoC. In order to meet low power requirements, PMU is
>> designed for including multiple PM domains that can be used for power
>> gating of selected IP blocks for power saving by reduced leakage
>> current. The first patch adds device tree binding for PM domain provider
>> and consumer. The second patch adds pmu driver and support JH7110 SoC.
>> The last patch adds device node about pmu to JH7110 dts. 
>> 
>> The series has been tested on the VisionFive 2 boards which equip with
>> JH7110 SoC and works normally.
> 
> For the series:
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> 
> I'm hoping that someone with knowledge of the power APIs will take a
> look now that the driver looks to be in a pretty good state (to my naive
> eyes at least).
> 
>> Changes in v3:
>> - Rebased on tag v6.1.
> 
> FYI, please pick something more recent than that.
> Ideally, the last -rc1, which in this case is v6.2-rc1.

OK, the next version will be rebased to the latest kernel. 

> It's helpful to do this, as when I went to apply your patch, there were
> some conflicts that needed to be sorted out. Because of your prerequisite
> patches, the usual `b4` commands would not usable. E.g.
> 
> b4 am -3 20230116074259.22874-1-walker.chen@starfivetech.com
> Analyzing 4 messages in the thread
> Checking attestation on all messages, may take a moment...
> ---
>   [PATCH v3 1/3] dt-bindings: power: Add starfive,jh7110-pmu
>   [PATCH v3 2/3] soc: starfive: Add StarFive JH71XX pmu driver
>   [PATCH v3 3/3] riscv: dts: starfive: add pmu controller node
> ---
> Total patches: 3
> Preparing fake-am for v3: JH7110 PMU Support
>   ERROR: Could not find matching blob for MAINTAINERS (85e8f83161d7)
>          If you know on which tree this patchset is based,
>          add it as a remote and perform "git remote update"
>          in order to fetch the missing objects.
> 
> Fortunately, this is just a driver addition so despite `b4` not
> helping it was easy to resolve but for other patches in the future,
> this may not be the case.
> 
> Assuming the dt maintainers are happy with the binding, ping me in 2
> weeks if no-one else has commented and I'll apply patches 1 & 2.

Could I drop patch 3 and rebase patch 1 & 2 on the latest mainline then submit as v4 ?

Best regards,
Walker

