Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 759316F629E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 03:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbjEDBVv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 21:21:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjEDBVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 21:21:50 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 252F0101;
        Wed,  3 May 2023 18:21:45 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 2A1117F8A;
        Thu,  4 May 2023 09:21:37 +0800 (CST)
Received: from EXMBX062.cuchost.com (172.16.6.62) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 4 May
 2023 09:21:37 +0800
Received: from [192.168.125.107] (183.27.99.121) by EXMBX062.cuchost.com
 (172.16.6.62) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 4 May
 2023 09:21:36 +0800
Message-ID: <d2044dc1-ff5c-7398-5646-1bfdfb8ea935@starfivetech.com>
Date:   Thu, 4 May 2023 09:21:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
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
 <b34a8d59-34e4-8358-9d2b-367f4707ca7c@starfivetech.com>
 <f0d82428-aaa5-3dd4-bc29-f1057fe749bc@linaro.org>
 <0c94aadf-fac3-d05c-1c54-ae8337526849@starfivetech.com>
 <31c582a7-682a-330e-51d4-53b4a0c5f3a2@linaro.org>
From:   Changhuang Liang <changhuang.liang@starfivetech.com>
In-Reply-To: <31c582a7-682a-330e-51d4-53b4a0c5f3a2@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [183.27.99.121]
X-ClientProxiedBy: EXCAS061.cuchost.com (172.16.6.21) To EXMBX062.cuchost.com
 (172.16.6.62)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/4/17 1:29, Krzysztof Kozlowski wrote:
>>>> A standard property? Like "clocks" or "resets"?
>>>
>>> Like lane-polarities now submitted to one MIPI.
>>>
>>> Anyway it does not look like a property of a board. You said it is fixed
>>> per SoC, so it should be implied from the compatible. Otherwise please
>>> explain in description and provide some rationale.
>>>
>>> Best regards,
>>> Krzysztof
>>>
>>
>> This property is the only one used for this IP, I have compared this IP with
>> other DPHY rx module, DPHY modules form the other manufacturers not have this
>> configure.
>> And we also have a SoC called JH7100. It DPHY rx module is the same as JH7110.
>> But we don't do the upstream work on it. If it use this lane-maps will be 
>> configure as "lane_maps = /bits/ 8 <0 1 2 3 4 5>;".
> 
> And JH7100 is different SoC, so you have different compatible. Again -
> is this board specific? If not, looks like SoC specific, thus imply it
> from compatible.
> 
> 
> Best regards,
> Krzysztof
> 

Vinod,

Hi, could you give me some suggestions about Krzysztof's comment? Thanks for
your time.

Best regards,
Changhuang
