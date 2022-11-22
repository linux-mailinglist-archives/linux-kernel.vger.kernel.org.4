Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD68563372B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 09:31:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232919AbiKVIa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 03:30:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232916AbiKVIac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 03:30:32 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A18A3F071;
        Tue, 22 Nov 2022 00:30:10 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 81FEC24E238;
        Tue, 22 Nov 2022 16:30:08 +0800 (CST)
Received: from EXMBX068.cuchost.com (172.16.6.68) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 22 Nov
 2022 16:30:08 +0800
Received: from [192.168.125.96] (113.72.144.23) by EXMBX068.cuchost.com
 (172.16.6.68) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 22 Nov
 2022 16:30:07 +0800
Message-ID: <2fd4d4f0-eade-3496-1b03-d980b190b3d5@starfivetech.com>
Date:   Tue, 22 Nov 2022 16:30:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v1 1/4] dt-bindings: power: Add StarFive JH7110 power
 domain definitions
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <linux-riscv@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20221118133216.17037-1-walker.chen@starfivetech.com>
 <20221118133216.17037-2-walker.chen@starfivetech.com>
 <bc853d76-5b65-676a-040a-edf53034c9ad@linaro.org>
 <98866fec-e88a-f241-bb42-78d33f051f11@starfivetech.com>
 <65323df3-1102-8d95-7c13-80d9756c7c33@linaro.org>
From:   Walker Chen <walker.chen@starfivetech.com>
In-Reply-To: <65323df3-1102-8d95-7c13-80d9756c7c33@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [113.72.144.23]
X-ClientProxiedBy: EXCAS063.cuchost.com (172.16.6.23) To EXMBX068.cuchost.com
 (172.16.6.68)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/11/22 16:03, Krzysztof Kozlowski wrote:
> On 22/11/2022 08:46, Walker Chen wrote:
>> On 2022/11/21 18:12, Krzysztof Kozlowski wrote:
>>> On 18/11/2022 14:32, Walker Chen wrote:
>>>> Add power domain definitions for the StarFive JH7110 SoC.
>>>>
>>>> Signed-off-by: Walker Chen <walker.chen@starfivetech.com>
>>>> ---
>>>>  include/dt-bindings/power/jh7110-power.h | 18 ++++++++++++++++++
>>>>  1 file changed, 18 insertions(+)
>>>>  create mode 100644 include/dt-bindings/power/jh7110-power.h
>>>>
>>>> diff --git a/include/dt-bindings/power/jh7110-power.h b/include/dt-bindings/power/jh7110-power.h
>>>> new file mode 100644
>>>> index 000000000000..24160c46fbaf
>>>> --- /dev/null
>>>> +++ b/include/dt-bindings/power/jh7110-power.h
>>>
>>> Filename matching compatible or bindings file.
>> 
>> So the file name should be changed to "starfive,jh7110-power.h" and the compatible in the driver 
>> should also be changed to "starfive,jh7110-power". Is it right ?
> 
> I said filename should be changed. I don't remember what was your
> compatible, but if I did not comment there, in means it looked fine.
> 
>> 
>>>
>>>> @@ -0,0 +1,18 @@
>>>> +/* SPDX-License-Identifier: (GPL-2.0) */
>>>
>>> Dual license for bindings.
>> 
>> Ok, the license will be changed to GPL-2.0 or MIT in the patch v2. 
> 
> Any reasons why not using the licenses recommended by checkpatch?
> 
Well, it sounds like a better way to decide which license to use by checkpatch.
Thanks for your tip.

Best Regards,
Walker Chen

