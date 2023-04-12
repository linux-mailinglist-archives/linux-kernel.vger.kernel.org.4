Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2B8B6DE989
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 04:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbjDLCg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 22:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjDLCg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 22:36:27 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 050B44EDC;
        Tue, 11 Apr 2023 19:36:18 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 9F69124E1D1;
        Wed, 12 Apr 2023 10:36:16 +0800 (CST)
Received: from EXMBX067.cuchost.com (172.16.6.67) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 12 Apr
 2023 10:36:16 +0800
Received: from [192.168.125.89] (113.72.145.176) by EXMBX067.cuchost.com
 (172.16.6.67) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 12 Apr
 2023 10:36:15 +0800
Message-ID: <3557b890-fa43-f16b-95fd-6fc44204086d@starfivetech.com>
Date:   Wed, 12 Apr 2023 10:36:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v1 1/3] riscv: dts: starfive: Enable axp15060 pmic for
 cpufreq
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
 <20230411083257.16155-2-mason.huo@starfivetech.com>
 <20230411-chimp-unvarying-142394732ff5@wendy>
From:   Mason Huo <mason.huo@starfivetech.com>
In-Reply-To: <20230411-chimp-unvarying-142394732ff5@wendy>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [113.72.145.176]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX067.cuchost.com
 (172.16.6.67)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/4/11 17:13, Conor Dooley wrote:
> On Tue, Apr 11, 2023 at 04:32:55PM +0800, Mason Huo wrote:
>> The VisionFive 2 board has an embedded pmic axp15060,
>> which supports the cpu DVFS through the dcdc2 regulator.
>> This patch enables axp15060 pmic and configs the dcdc2.
>> 
>> Signed-off-by: Mason Huo <mason.huo@starfivetech.com>
>> ---
>>  .../starfive/jh7110-starfive-visionfive-2.dtsi    | 15 +++++++++++++++
>>  1 file changed, 15 insertions(+)
>> 
>> diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
>> index 2a6d81609284..df582bddae4b 100644
>> --- a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
>> +++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
>> @@ -114,6 +114,21 @@ &i2c5 {
>>  	pinctrl-names = "default";
>>  	pinctrl-0 = <&i2c5_pins>;
>>  	status = "okay";
>> +
>> +	pmic: axp15060_reg@36 {
> 
> No underscores in node names please & "pmic" is the generic node name
> for pmics.
> 
> Cheers,
> Conor.
> 
Address it in next version.

Thanks
Mason
>> +		compatible = "x-powers,axp15060";
>> +		reg = <0x36>;
>> +
>> +		regulators {
>> +			reg_dcdc2: dcdc2 {
>> +				regulator-boot-on;
>> +				regulator-always-on;
>> +				regulator-min-microvolt = <500000>;
>> +				regulator-max-microvolt = <1540000>;
>> +				regulator-name = "vdd-cpu";
>> +			};
>> +		};
>> +	};
>>  };
>>  
>>  &i2c6 {
>> -- 
>> 2.39.2
>> 
