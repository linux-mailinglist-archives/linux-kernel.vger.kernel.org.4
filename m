Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95DEC642487
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 09:25:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231824AbiLEIZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 03:25:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231384AbiLEIZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 03:25:34 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C5411659C;
        Mon,  5 Dec 2022 00:25:32 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id E57A124E0AC;
        Mon,  5 Dec 2022 16:25:29 +0800 (CST)
Received: from EXMBX161.cuchost.com (172.16.6.71) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 5 Dec
 2022 16:25:29 +0800
Received: from [192.168.125.128] (113.72.146.33) by EXMBX161.cuchost.com
 (172.16.6.71) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 5 Dec
 2022 16:25:28 +0800
Message-ID: <4327b879-e499-41cd-1846-ce9194efb906@starfivetech.com>
Date:   Mon, 5 Dec 2022 16:22:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v1 1/3] dt-bindings: watchdog: Add watchdog for StarFive
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-watchdog@vger.kernel.org>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Wim Van Sebroeck" <wim@linux-watchdog.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Samin Guo <samin.guo@starfivetech.com>,
        Guenter Roeck <linux@roeck-us.net>,
        <linux-kernel@vger.kernel.org>
References: <20221202093943.149674-1-xingyu.wu@starfivetech.com>
 <20221202093943.149674-2-xingyu.wu@starfivetech.com>
 <cb8deb55-902a-0058-4764-a5f391f8de6d@linaro.org>
 <e0551ed7-2208-6d08-235b-993702f0d89b@starfivetech.com>
 <d6f3d8ac-4fbe-40ca-299b-046973cd0b25@linaro.org>
From:   Xingyu Wu <xingyu.wu@starfivetech.com>
In-Reply-To: <d6f3d8ac-4fbe-40ca-299b-046973cd0b25@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [113.72.146.33]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX161.cuchost.com
 (172.16.6.71)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/12/5 15:30, Krzysztof Kozlowski wrote:
> On 05/12/2022 04:49, Xingyu Wu wrote:
>> On 2022/12/2 18:46, Krzysztof Kozlowski wrote:
>>> On 02/12/2022 10:39, xingu.wu wrote:
>>>> From: Xingyu Wu <xingyu.wu@starfivetech.com>
>>>>
>>>> Add bindings to describe the watchdog for the StarFive SoCs.
>>>>
>>>> Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
>>>> ---
>>>>  .../bindings/watchdog/starfive,wdt.yaml       | 77 +++++++++++++++++++
>>>>  1 file changed, 77 insertions(+)
>>>>  create mode 100644 Documentation/devicetree/bindings/watchdog/starfive,wdt.yaml
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/watchdog/starfive,wdt.yaml b/Documentation/devicetree/bindings/watchdog/starfive,wdt.yaml
>>>> new file mode 100644
>>>> index 000000000000..ece3e80153a0
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/watchdog/starfive,wdt.yaml
>>>
>>> Filename should be based on compatible. You do not allow here any other
>>> models... If you intent and you are 100% sure you will grow with new
>>> models, make it maybe a family-based name.
>> 
>> First, thank you for your reply. We have some other SoCs like JH7100 would use
>> this watchdog driver, but we now use JH7110 as our main release chip.
>> As you say, should we use "starfive,jh71xx-wdt.yaml" as filename?
> 
> starfive,jh7110-wdt.yaml
> I would say because you do not expect any other models (const for
> compatible, not enum)
> 

Thanks, I will rename the file in the patches for next version.

Best regards,
Xingyu Wu
