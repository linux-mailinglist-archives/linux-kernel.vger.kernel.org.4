Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51F8C648186
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 12:19:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbiLILTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 06:19:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbiLILSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 06:18:32 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D024349095;
        Fri,  9 Dec 2022 03:18:25 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id A86D024E1FE;
        Fri,  9 Dec 2022 19:18:23 +0800 (CST)
Received: from EXMBX068.cuchost.com (172.16.6.68) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 9 Dec
 2022 19:18:23 +0800
Received: from [192.168.120.55] (171.223.208.138) by EXMBX068.cuchost.com
 (172.16.6.68) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 9 Dec
 2022 19:18:22 +0800
Message-ID: <b56b3363-5792-cf51-0ffe-914afccaa423@starfivetech.com>
Date:   Fri, 9 Dec 2022 19:18:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v1 1/3] dt-bindings: mmc: Add bindings for StarFive
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        <linux-kernel@vger.kernel.org>
References: <20221207131731.1291517-1-william.qiu@starfivetech.com>
 <20221207131731.1291517-2-william.qiu@starfivetech.com>
 <CACRpkdY6364RtQMgGAFA024Pb-9v6+xcTUJdH+-MvzooBGYnhw@mail.gmail.com>
Content-Language: en-US
From:   William Qiu <william.qiu@starfivetech.com>
In-Reply-To: <CACRpkdY6364RtQMgGAFA024Pb-9v6+xcTUJdH+-MvzooBGYnhw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [171.223.208.138]
X-ClientProxiedBy: EXCAS061.cuchost.com (172.16.6.21) To EXMBX068.cuchost.com
 (172.16.6.68)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/12/9 5:13, Linus Walleij wrote:
> Hi William,
> 
> thanks for your patch!
> 
> On Wed, Dec 7, 2022 at 2:17 PM William Qiu <william.qiu@starfivetech.com> wrote:
> 
>> Add documentation to describe StarFive
>> designware mobile storage host controller driver.
>>
>> Signed-off-by: William Qiu <william.qiu@starfivetech.com>
> 
> (...)
> 
>> +  starfive,sys-syscon:
>> +    $ref: /schemas/types.yaml#/definitions/uint32-array
>> +    description:
>> +      The desired number of times that the host execute tuning when needed.
> 
> This is not consistent with the use in the code of the attached driver.
> There it is a phandle, and it has three cells, which I am critical of.
> Also this description is hard to understand.
> 

Will update all of it in next version.


>> +required:
>> +  - compatible
>> +  - reg
>> +  - clocks
>> +  - clock-names
>> +  - interrupts
> 
> I don't think the syscon phandle is optional.
> 

Will fix.

>> +    #include <dt-bindings/clock/starfive-jh7110.h>
>> +    #include <dt-bindings/reset/starfive-jh7110.h>
>> +    mmc@16010000 {
>> +            compatible = "starfive,jh7110-sdio";
>> +            reg = <0x16010000 0x10000>;
> 
> No syscon phandle in the example: this needs to be added.
> 

I will add the syscon phandle.

Thank you for taking time to review and provide helpful comments for this patch.

Best regards,
William Qiu
> Yours,
> Linus Walleij
