Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 022E469739E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 02:28:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233619AbjBOB2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 20:28:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233472AbjBOB2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 20:28:05 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E331A1BA;
        Tue, 14 Feb 2023 17:28:03 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 7D07E24E20A;
        Wed, 15 Feb 2023 09:27:56 +0800 (CST)
Received: from EXMBX162.cuchost.com (172.16.6.72) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 15 Feb
 2023 09:27:56 +0800
Received: from [192.168.1.100] (183.27.97.168) by EXMBX162.cuchost.com
 (172.16.6.72) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 15 Feb
 2023 09:27:55 +0800
Message-ID: <e6b9e942-633b-90f4-104e-1d6fbe5d0235@starfivetech.com>
Date:   Wed, 15 Feb 2023 09:27:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v1 2/4] dt-bindings: phy: Add starfive,jh7110-dphy-rx
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     Jack Zhu <jack.zhu@starfivetech.com>,
        <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
References: <20230210061713.6449-1-changhuang.liang@starfivetech.com>
 <20230210061713.6449-3-changhuang.liang@starfivetech.com>
 <3fc07187-f5a0-86d1-a0fd-ba18a2baf555@linaro.org>
 <f33f3ce0-ca0f-b24e-eab6-4fb9a6ae6d4a@starfivetech.com>
 <80d16935-dad6-8087-c1b2-1d5b1c3f738e@linaro.org>
From:   Changhuang Liang <changhuang.liang@starfivetech.com>
In-Reply-To: <80d16935-dad6-8087-c1b2-1d5b1c3f738e@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [183.27.97.168]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX162.cuchost.com
 (172.16.6.72)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/2/14 15:49, Krzysztof Kozlowski wrote:
> On 14/02/2023 04:07, Changhuang Liang wrote:
>>
>> OK, will drop quotes
>>
>>>> +    items:
>>>> +      items:
>>>> +        - description: phandle of AON SYSCON
>>>> +        - description: register offset
>>>> +    description: The register of dphy rx driver can be configured
>>>> +      by AON SYSCON in this property.
>>>
>>> Can be? So does not have to? But you made it a required property....
>>>
>>
>> Maybe I described it wrong.
>> I will change to:
>> 	description: The power of dphy rx can be configured by AON SYSCON
>> 	  in this property.
>> It is like AON SYSCON is the power switch of the dphy rx, it is necessary to
>> configure the AON SYSCON register, so I made it a required property.
> 
> Then do not use "can be". Can is optional: I can jump but I don't have
> to. :)
> 

OK, "can be" will be changed to "is".

Best Regards,
Changhuang Liang
