Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A463363E97E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 06:52:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbiLAFwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 00:52:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiLAFwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 00:52:14 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48116A6052;
        Wed, 30 Nov 2022 21:52:11 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 59DFC24E167;
        Thu,  1 Dec 2022 13:51:59 +0800 (CST)
Received: from EXMBX068.cuchost.com (172.16.6.68) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 1 Dec
 2022 13:51:59 +0800
Received: from [192.168.125.96] (113.72.147.18) by EXMBX068.cuchost.com
 (172.16.6.68) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 1 Dec
 2022 13:51:59 +0800
Message-ID: <da75445a-9bef-7f66-81b9-12c36ad19a37@starfivetech.com>
Date:   Thu, 1 Dec 2022 13:51:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v1 2/4] dt-bindings: power: Add starfive,jh71xx-power
 bindings
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <linux-riscv@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20221118133216.17037-1-walker.chen@starfivetech.com>
 <20221118133216.17037-3-walker.chen@starfivetech.com>
 <99302e53-c0c9-cfe8-4e6a-c70e8428d9c3@linaro.org>
 <f21b0aa9-2ac8-ae28-755a-d530171f930a@starfivetech.com>
 <20221130152451.GA2192004-robh@kernel.org>
From:   Walker Chen <walker.chen@starfivetech.com>
In-Reply-To: <20221130152451.GA2192004-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [113.72.147.18]
X-ClientProxiedBy: EXCAS065.cuchost.com (172.16.6.25) To EXMBX068.cuchost.com
 (172.16.6.68)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/11/30 23:24, Rob Herring wrote:
> On Tue, Nov 22, 2022 at 09:22:03PM +0800, Walker Chen wrote:
>> On 2022/11/21 18:13, Krzysztof Kozlowski wrote:
>> > On 18/11/2022 14:32, Walker Chen wrote:
>> >> Add bindings for the power domain controller on the StarFive JH71XX SoC.
>> >> 
>> > 
>> > Subject: drop second, redundant "bindings".
>> 
>> Will fix.
>> 
>> > 
>> >> Signed-off-by: Walker Chen <walker.chen@starfivetech.com>
>> >> ---
>> >>  .../bindings/power/starfive,jh71xx-power.yaml | 46 +++++++++++++++++++
>> > 
>> > 1st patch should be squashed here. Headers are part of bindings file.
>> 
>> Will be done in the next version of patch.
>> 
>> > 
>> >>  1 file changed, 46 insertions(+)
>> >>  create mode 100644 Documentation/devicetree/bindings/power/starfive,jh71xx-power.yaml
>> >> 
>> >> diff --git a/Documentation/devicetree/bindings/power/starfive,jh71xx-power.yaml b/Documentation/devicetree/bindings/power/starfive,jh71xx-power.yaml
>> >> new file mode 100644
>> >> index 000000000000..2537303b4829
>> >> --- /dev/null
>> >> +++ b/Documentation/devicetree/bindings/power/starfive,jh71xx-power.yaml
>> > 
>> > Filename like compatible.
>> 
>> As mentioned in the previous email, the compatible in the driver should be changed to "starfive,jh7110-power".
> 
> Is the h/w block called 'power' or 'pmu'? Call it what the h/w is 
> called.

h/w block is called PMU, is the abbreviation of Power Management Unit.
It is more appropriate to change the compatile to 'starfive,jh7110-pmu'.

Best Regards,
Walker Chen

