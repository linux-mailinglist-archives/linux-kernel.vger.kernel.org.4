Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4EE76E738A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 08:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231836AbjDSG5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 02:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231128AbjDSG5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 02:57:48 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E37191;
        Tue, 18 Apr 2023 23:57:46 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 2A64724E268;
        Wed, 19 Apr 2023 14:57:45 +0800 (CST)
Received: from EXMBX162.cuchost.com (172.16.6.72) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 19 Apr
 2023 14:57:45 +0800
Received: from [192.168.125.106] (113.72.144.253) by EXMBX162.cuchost.com
 (172.16.6.72) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 19 Apr
 2023 14:57:44 +0800
Message-ID: <17a9c045-9a82-bf36-65f1-b5bf6a7b2f33@starfivetech.com>
Date:   Wed, 19 Apr 2023 14:57:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RESEND v2 0/6] Add JH7110 AON PMU support
Content-Language: en-US
To:     Conor Dooley <conor.dooley@microchip.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Walker Chen <walker.chen@starfivetech.com>,
        Hal Feng <hal.feng@starfivetech.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>
References: <20230419035646.43702-1-changhuang.liang@starfivetech.com>
 <20230419-subway-itinerary-9f5532929c14@wendy>
From:   Changhuang Liang <changhuang.liang@starfivetech.com>
In-Reply-To: <20230419-subway-itinerary-9f5532929c14@wendy>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [113.72.144.253]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX162.cuchost.com
 (172.16.6.72)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/4/19 14:23, Conor Dooley wrote:
> On Tue, Apr 18, 2023 at 08:56:40PM -0700, Changhuang Liang wrote:
[...]
>> - Used pmu_status save the pmu status offset.
>> - Changed "JH71XX_PMU_DPHY_SWITCH" to "JH71XX_AON_PMU_SWITCH"
>> - Changed copyright to "2022-2023"
> 
> For the future, when you resend, please say why you did.
> 

OK, thanks for your correction. I'll pay attention.

>>
>> v1: https://lore.kernel.org/all/20230411064743.273388-1-changhuang.liang@starfivetech.com/
>>
[...]
>>
>> base-commit: 197b6b60ae7bc51dd0814953c562833143b292aa
>> prerequisite-patch-id: 388b8adbb0fe2daf4d07a21eafd4f1bd50ce2403
> 
> Also, all of this pre-req patch id stuff is pretty useless. You've
> already pointed out the patches that this is based on, so IMO this
> information isn't helpful & is probably more likely confuse tooling
> than anything else.
> 
> Cheers,
> Conor.

OK, will not use "--base" for next.

