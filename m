Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBAB36E72E4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 08:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231612AbjDSGKv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 19 Apr 2023 02:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231532AbjDSGKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 02:10:47 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72F075FFB;
        Tue, 18 Apr 2023 23:10:45 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 6094224E25E;
        Wed, 19 Apr 2023 14:10:43 +0800 (CST)
Received: from EXMBX162.cuchost.com (172.16.6.72) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 19 Apr
 2023 14:10:43 +0800
Received: from [192.168.125.106] (113.72.144.253) by EXMBX162.cuchost.com
 (172.16.6.72) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 19 Apr
 2023 14:10:42 +0800
Message-ID: <bf04808b-5988-c3d2-e2c4-4e8cdbaec838@starfivetech.com>
Date:   Wed, 19 Apr 2023 14:10:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 1/3] dt-bindings: phy: Add starfive,jh7110-dphy-rx
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jack Zhu <jack.zhu@starfivetech.com>,
        <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
References: <20230412084540.295411-1-changhuang.liang@starfivetech.com>
 <20230412084540.295411-2-changhuang.liang@starfivetech.com>
 <8dd0dc63-e0df-8764-f756-da032d9d671c@linaro.org>
 <eb47b7c7-bdbb-92d9-ba39-604ce487f297@starfivetech.com>
 <f6a4fb28-d635-4d99-44bb-d929cb41eef2@linaro.org>
 <b34a8d59-34e4-8358-9d2b-367f4707ca7c@starfivetech.com>
 <f0d82428-aaa5-3dd4-bc29-f1057fe749bc@linaro.org>
 <20230418184246.GA2103246-robh@kernel.org>
 <CAL_JsqKVa+XHkoDbDLaD+haC2J7QDJ_oLr9RAT=7Pvwa-rWHLg@mail.gmail.com>
From:   Changhuang Liang <changhuang.liang@starfivetech.com>
In-Reply-To: <CAL_JsqKVa+XHkoDbDLaD+haC2J7QDJ_oLr9RAT=7Pvwa-rWHLg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Originating-IP: [113.72.144.253]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX162.cuchost.com
 (172.16.6.72)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/4/19 2:46, Rob Herring wrote:
> On Tue, Apr 18, 2023 at 1:42 PM Rob Herring <robh@kernel.org> wrote:
>>
>> On Thu, Apr 13, 2023 at 10:41:23AM +0200, Krzysztof Kozlowski wrote:
>>> On 13/04/2023 04:34, Changhuang Liang wrote:
>>>>>>>> +  lane_maps:
>>>>>>>
>>>>>>> Why did this appear? Underscores are not allowed. It looks like you
>>>>>>> re-implement some standard property.
>>>>>>>
>>>>>>
>>>>>> Will change to lane-maps.
>>>>>> Yes, according to Vinod advice, lane mapping table use device tree
>>>>>> to parse makes sense.
>>>>>
>>>>> Hm, I have a feeling that I saw such property, so you should dig into
>>>>> existing and in-flight bindings.
>>>>>
>>>>> Best regards,
>>>>> Krzysztof
>>>>>
>>>>
>>>> A standard property? Like "clocks" or "resets"?
>>>
>>> Like lane-polarities now submitted to one MIPI.
>>>
>>
>> data-lanes perhaps?
> 
> Except that is for the controller's endpoint rather than the phy.
> Presumably if the controller knows the mapping, then it can tell the
> phy if it needs the information. IOW, don't just copy 'data-lanes' to
> the phy. Follow the normal patterns.
> 
> Rob

I am not sure if phy can fetch from the other controller's endpoint. In 
addition, like our JH7110 SoC, it have data-lanes configure (data-lanes = <1 2>)
in csi2rx controller, but this data-lanes configure is not appropriate to phy, 
maybe they are independent. 
