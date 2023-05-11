Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06B816FE9B4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 04:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231660AbjEKCGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 22:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbjEKCG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 22:06:29 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66723173B;
        Wed, 10 May 2023 19:06:28 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id DDE0E24E0FC;
        Thu, 11 May 2023 10:06:25 +0800 (CST)
Received: from EXMBX062.cuchost.com (172.16.6.62) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 11 May
 2023 10:06:25 +0800
Received: from [192.168.125.107] (113.72.146.187) by EXMBX062.cuchost.com
 (172.16.6.62) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 11 May
 2023 10:06:25 +0800
Message-ID: <2a6add59-981a-f5c1-e744-1cef2b81f29a@starfivetech.com>
Date:   Thu, 11 May 2023 10:06:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v3 1/5] dt-bindings: power: Add JH7110 AON PMU support
Content-Language: en-US
To:     Conor Dooley <conor@kernel.org>
CC:     Conor Dooley <conor.dooley@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Walker Chen <walker.chen@starfivetech.com>,
        Hal Feng <hal.feng@starfivetech.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>
References: <20230510015311.27505-1-changhuang.liang@starfivetech.com>
 <20230510015311.27505-2-changhuang.liang@starfivetech.com>
 <20230510-cloning-clapping-e262f00a94e8@wendy>
 <d80646ae-cf1b-234a-261c-3753f6cc9080@starfivetech.com>
 <20230510-city-scarf-023705d3c96a@spud>
From:   Changhuang Liang <changhuang.liang@starfivetech.com>
In-Reply-To: <20230510-city-scarf-023705d3c96a@spud>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [113.72.146.187]
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX062.cuchost.com
 (172.16.6.62)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/5/11 3:51, Conor Dooley wrote:
> On Wed, May 10, 2023 at 03:20:14PM +0800, Changhuang Liang wrote:
>> On 2023/5/10 15:06, Conor Dooley wrote:
>>> On Tue, May 09, 2023 at 06:53:07PM -0700, Changhuang Liang wrote:
>>>> +          - starfive,jh7110-pmu
>>>> +      - items:
>>>> +          - enum:
>>>> +              - starfive,jh7110-aon-syscon
>>>> +          - const: syscon
>>>
>>> Unfortunately, this is not what was wanted.
>>> This syscon, of which power domain control is just one of the things that
>>> it can do, should be documented in
>>> Documentation/devicetree/bindings/soc/starfive/starfive,jh7110-syscon.yaml
>>> alongside it's brethern "starfive,jh7110-sys-syscon" &
>>> "starfive,jh7110-stg-syscon".
>>>
>>
>> That means that I don't need to modify this original yaml file? 
> 
> Does "this original" mean starfive,jh7100-pmu.yaml?
> If so then...
> 

Yes.

>> I just need to move current changes in this patch into 
>> "Documentation/devicetree/bindings/soc/starfive/starfive,jh7110-syscon.yaml"?
> 
> Correct.
> It makes most sense for that binding, as it depends on the pll binding
> (because it has a ref: to it), to go through the clock tree in Xingyu's
> series.
> I'll apply the driver changes once the binding has been applied.
> 

I think that I have to send v4 after Xingyu's series resend new version. 
If drivers have no other comments. I will make the following changes:

patch 1/5: Only keep the content in starfive,jh7110-pmu.h, move other content into Xingyu's PLL series.
patch 5/5: Drop this patch, move the content into Xingyu's PLL series.
other patch: no change.

Thanks,
Changhuang
