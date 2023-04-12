Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 403886DE986
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 04:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbjDLCgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 22:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjDLCgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 22:36:10 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 618D75241;
        Tue, 11 Apr 2023 19:36:08 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 1B98D24E203;
        Wed, 12 Apr 2023 10:36:02 +0800 (CST)
Received: from EXMBX067.cuchost.com (172.16.6.67) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 12 Apr
 2023 10:36:02 +0800
Received: from [192.168.125.89] (113.72.145.176) by EXMBX067.cuchost.com
 (172.16.6.67) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 12 Apr
 2023 10:36:01 +0800
Message-ID: <fa83f623-517f-9b4f-9b82-9cae4a0aba60@starfivetech.com>
Date:   Wed, 12 Apr 2023 10:36:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v1 2/3] cpufreq: dt-platdev: Add JH7110 SOC to the
 allowlist
Content-Language: en-US
To:     Conor Dooley <conor.dooley@microchip.com>
CC:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor@kernel.org>,
        "Paul Walmsley" <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Shengyu Qu <wiagn233@outlook.com>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>
References: <20230411083257.16155-1-mason.huo@starfivetech.com>
 <20230411083257.16155-3-mason.huo@starfivetech.com>
 <20230411-rewire-outlook-a5fb631fb635@wendy>
From:   Mason Huo <mason.huo@starfivetech.com>
In-Reply-To: <20230411-rewire-outlook-a5fb631fb635@wendy>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [113.72.145.176]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX067.cuchost.com
 (172.16.6.67)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/4/11 17:20, Conor Dooley wrote:
> On Tue, Apr 11, 2023 at 04:32:56PM +0800, Mason Huo wrote:
>> Add the compatible strings for supporting the generic
>> cpufreq driver on the StarFive JH7110 SoC.
>> 
>> Signed-off-by: Mason Huo <mason.huo@starfivetech.com>
>> ---
>>  drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
>>  1 file changed, 1 insertion(+)
>> 
>> diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
>> index e85703651098..a1ac955aa7e2 100644
>> --- a/drivers/cpufreq/cpufreq-dt-platdev.c
>> +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
>> @@ -92,6 +92,7 @@ static const struct of_device_id allowlist[] __initconst = {
>>  
>>  	{ .compatible = "xlnx,zynq-7000", },
>>  	{ .compatible = "xlnx,zynqmp", },
>> +	{ .compatible = "starfive,jh7110", },
> 
> This struct looks to be in alphabetical order with a blank line between
> vendors.

Right. Should place it behind "st-ericsson".

Thanks
Mason
