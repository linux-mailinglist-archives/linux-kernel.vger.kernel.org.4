Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECAC96B1E7E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 09:45:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbjCIIot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 03:44:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbjCIIoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 03:44:32 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A0225B86;
        Thu,  9 Mar 2023 00:44:30 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 7D5CB24E2D9;
        Thu,  9 Mar 2023 16:44:23 +0800 (CST)
Received: from EXMBX061.cuchost.com (172.16.6.61) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 9 Mar
 2023 16:44:23 +0800
Received: from [192.168.125.128] (183.27.96.115) by EXMBX061.cuchost.com
 (172.16.6.61) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 9 Mar
 2023 16:44:22 +0800
Message-ID: <abfbd29b-e0dd-2756-d65a-4bdc6be096a0@starfivetech.com>
Date:   Thu, 9 Mar 2023 16:44:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v4 1/3] dt-bindings: watchdog: Add watchdog for StarFive
 JH7100 and JH7110
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-watchdog@vger.kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Samin Guo <samin.guo@starfivetech.com>,
        <linux-kernel@vger.kernel.org>, Guenter Roeck <linux@roeck-us.net>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Conor Dooley <conor@kernel.org>
References: <20230308034036.99213-1-xingyu.wu@starfivetech.com>
 <20230308034036.99213-2-xingyu.wu@starfivetech.com>
 <94ba1427-21ea-86ee-d60d-7817f8e673fa@linaro.org>
 <783fe50c-1649-b1c4-06cd-ac81bcad5117@starfivetech.com>
 <812bbccf-010f-1138-f104-7db7d47ebc9a@linaro.org>
From:   Xingyu Wu <xingyu.wu@starfivetech.com>
In-Reply-To: <812bbccf-010f-1138-f104-7db7d47ebc9a@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [183.27.96.115]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX061.cuchost.com
 (172.16.6.61)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/3/9 16:35, Krzysztof Kozlowski wrote:
> On 09/03/2023 09:13, Xingyu Wu wrote:
>> On 2023/3/9 15:30, Krzysztof Kozlowski wrote:
>>> On 08/03/2023 04:40, Xingyu Wu wrote:
>>>> Add bindings to describe the watchdog for the StarFive JH7100/JH7110 SoC.
>>>> And Use JH7100 as first StarFive SoC with watchdog.
>>>>
>>>> Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
>>>> ---
>>>
>>> What happened here? You wrote in changelog "Modified" but what exactly?
>>> How am I supposed to find it?
>>>
>>> Provide detailed description, since you decided to remove my tag.
>>> Otherwise, standard response:
>>>
>>> This is a friendly reminder during the review process.
>>>
>>> It looks like you received a tag and forgot to add it.
>>>
>>> If you do not know the process, here is a short explanation:
>>> Please add Acked-by/Reviewed-by/Tested-by tags when posting new
>>> versions. However, there's no need to repost patches *only* to add the
>>> tags. The upstream maintainer will do that for acks received on the
>>> version they apply.
>>>
>>> https://elixir.bootlin.com/linux/v5.17/source/Documentation/process/submitting-patches.rst#L540
>>>
>>> If a tag was not added on purpose, please state why and what changed.
>>>
>> 
>> I am sorry I did not elaborate it. The dt-bindings was only supported JH7110 watchdog in v3 patchset
>> and you had sent Reviewed-by tags. But at the same time tried to add JH7100 watchdog after discussion
>> and used JH7100 as the dt-binding's name because JH7100 is the first StarFive SoCs about watchdog.
>> The compatible also add 'starfive,jh7100-wdt' in the dt-binding. It is different from the v3 patch and
>> I did not add the Reviewed-by tag.
> 
> So what is the difference? Filename and new compatible?
> 

Yes. So are these acceptable and can still add the tag?

Best regards,
Xingyu Wu
