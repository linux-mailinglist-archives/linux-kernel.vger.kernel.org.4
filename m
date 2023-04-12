Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22FE76DE983
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 04:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjDLCgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 22:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjDLCgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 22:36:02 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08B14172B;
        Tue, 11 Apr 2023 19:36:01 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id F112324E201;
        Wed, 12 Apr 2023 10:35:53 +0800 (CST)
Received: from EXMBX067.cuchost.com (172.16.6.67) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 12 Apr
 2023 10:35:53 +0800
Received: from [192.168.125.89] (113.72.145.176) by EXMBX067.cuchost.com
 (172.16.6.67) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 12 Apr
 2023 10:35:53 +0800
Message-ID: <2f5b4e94-0476-83df-0b18-a6b2ba1ea896@starfivetech.com>
Date:   Wed, 12 Apr 2023 10:35:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v1 3/3] riscv: dts: starfive: Add cpu scaling for JH7110
 SoC
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
 <20230411083257.16155-4-mason.huo@starfivetech.com>
 <20230411-darling-chump-faaf8dec29ef@wendy>
From:   Mason Huo <mason.huo@starfivetech.com>
In-Reply-To: <20230411-darling-chump-faaf8dec29ef@wendy>
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



On 2023/4/11 17:06, Conor Dooley wrote:
> Hey Mason,
> 
> On Tue, Apr 11, 2023 at 04:32:57PM +0800, Mason Huo wrote:
>> Add the operating-points-v2 to support cpu scaling
>> on StarFive JH7110 SoC.
> 
> (btw, there's no need to wrap commit messages at 52 columns, you have
> 72 to work with)
> 
Hi Conor,

Thanks for your review.
Will place it in the same line.

>> It supports up to 4 cpu frequency loads.
>> 
>> Signed-off-by: Mason Huo <mason.huo@starfivetech.com>
>> ---
>>  .../jh7110-starfive-visionfive-2.dtsi         | 25 +++++++++++++++++++
>>  arch/riscv/boot/dts/starfive/jh7110.dtsi      | 25 +++++++++++++++++++
>>  2 files changed, 50 insertions(+)
>> 
>> diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
>> index df582bddae4b..ae446b268e78 100644
>> --- a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
>> +++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
>> @@ -228,3 +228,28 @@ &uart0 {
>>  	pinctrl-0 = <&uart0_pins>;
>>  	status = "okay";
>>  };
>> +
>> +&U74_1 {
>> +	clocks =  <&syscrg JH7110_SYSCLK_CPU_CORE>;
>> +	clock-names = "cpu";
>> +	cpu-supply = <&reg_dcdc2>;
>> +};
>> +
>> +&U74_2 {
>> +	clocks =  <&syscrg JH7110_SYSCLK_CPU_CORE>;
>> +	clock-names = "cpu";
>> +	cpu-supply = <&reg_dcdc2>;
>> +};
>> +
>> +&U74_3 {
>> +	clocks =  <&syscrg JH7110_SYSCLK_CPU_CORE>;
>> +	clock-names = "cpu";
>> +	cpu-supply = <&reg_dcdc2>;
>> +};
>> +
>> +&U74_4 {
>> +	clocks =  <&syscrg JH7110_SYSCLK_CPU_CORE>;
>                 ^^
> There's a double space in each of these.
> 
>> +	clock-names = "cpu";
>> +	cpu-supply = <&reg_dcdc2>;
>> +};
> 
> How come these two clock properties are being added in <board>.dtsi?
> Should they not be in <soc>.dtsi?
>> Thanks,
> Conor.
Yes, will move them to <soc>.dtsi

Thanks
Mason
