Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8DA26E03B4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 03:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbjDMB3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 21:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbjDMB3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 21:29:37 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 190306E86;
        Wed, 12 Apr 2023 18:29:34 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id A4D907FEF;
        Thu, 13 Apr 2023 09:29:27 +0800 (CST)
Received: from EXMBX162.cuchost.com (172.16.6.72) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 13 Apr
 2023 09:29:27 +0800
Received: from [192.168.125.82] (183.27.97.249) by EXMBX162.cuchost.com
 (172.16.6.72) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 13 Apr
 2023 09:29:26 +0800
Message-ID: <b05a43df-1138-3dbd-08a9-0f2bc9b74807@starfivetech.com>
Date:   Thu, 13 Apr 2023 09:29:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v4 1/3] dt-bindings: phy: Add starfive,jh7110-dphy-rx
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
References: <20230412084540.295411-1-changhuang.liang@starfivetech.com>
 <20230412084540.295411-2-changhuang.liang@starfivetech.com>
 <8dd0dc63-e0df-8764-f756-da032d9d671c@linaro.org>
 <eb47b7c7-bdbb-92d9-ba39-604ce487f297@starfivetech.com>
 <f6a4fb28-d635-4d99-44bb-d929cb41eef2@linaro.org>
From:   Changhuang Liang <changhuang.liang@starfivetech.com>
In-Reply-To: <f6a4fb28-d635-4d99-44bb-d929cb41eef2@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [183.27.97.249]
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX162.cuchost.com
 (172.16.6.72)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/4/13 0:55, Krzysztof Kozlowski wrote:
> On 12/04/2023 14:42, Changhuang Liang wrote:
>>
>>
>> On 2023/4/12 19:34, Krzysztof Kozlowski wrote:
>>> On 12/04/2023 10:45, Changhuang Liang wrote:
>>>> StarFive SoCs like the jh7110 use a MIPI D-PHY RX controller based on
>>>> a M31 IP. Add a binding for it.
>>>
>>> So this is D-PHY? Or the other patch is D-PHY? The naming is quite
>>> confusing and your commit msgs are not helping here.
>>>
>>> Also the power domain phandle here adds to the confusion.
>>>
>>
>> Yes, this is DPHY, DPHY has rx and tx, and last version we are discussing that 
>> use power domain replace syscon:
>> https://lore.kernel.org/all/5dc4ddc2-9d15-ebb2-38bc-8a544ca67e0d@starfivetech.com/
> 
> The other patch - DPHY PMU - is confusing. Instead of writing short
> commits, explain more.
> 

OK, I will add more commit message in DPHY PMU dt-binding patch, for example:

dt-bindings: power: Add JH7110 DPHY PMU support.

Add DPHY PMU for StarFive JH7110 SoC, it can be used to turn on/off DPHY rx/tx
power switch, and it don't need the reg and interrupt properties.

I think this commit message will helpful for you to distinguish them.

>>
>>>>
>>>> Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
>>>> ---
>>>>  .../bindings/phy/starfive,jh7110-dphy-rx.yaml | 85 +++++++++++++++++++
>>>>  1 file changed, 85 insertions(+)
>>>>  create mode 100644 Documentation/devicetree/bindings/phy/starfive,jh7110-dphy-rx.yaml
>>>>
>> [...]
>>>> +
>>>> +  power-domains:
>>>> +    maxItems: 1
>>>> +
>>>> +  lane_maps:
>>>
>>> Why did this appear? Underscores are not allowed. It looks like you
>>> re-implement some standard property.
>>>
>>
>> Will change to lane-maps.
>> Yes, according to Vinod advice, lane mapping table use device tree
>> to parse makes sense.
> 
> Hm, I have a feeling that I saw such property, so you should dig into
> existing and in-flight bindings.
> 
> Best regards,
> Krzysztof
> 
