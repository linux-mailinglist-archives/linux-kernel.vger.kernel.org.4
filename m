Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF40F6A54E7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 09:58:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbjB1I6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 03:58:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjB1I6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 03:58:03 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40EA73A9B;
        Tue, 28 Feb 2023 00:58:01 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id F169A24E46D;
        Tue, 28 Feb 2023 16:57:58 +0800 (CST)
Received: from EXMBX162.cuchost.com (172.16.6.72) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 28 Feb
 2023 16:55:09 +0800
Received: from [192.168.125.68] (113.72.145.171) by EXMBX162.cuchost.com
 (172.16.6.72) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 28 Feb
 2023 16:55:08 +0800
Message-ID: <6aaebbc4-9d60-6445-7066-a9a60c50c6dd@starfivetech.com>
Date:   Tue, 28 Feb 2023 16:55:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 1/3] dt-bindings: phy: Add starfive,jh7110-dphy-rx
To:     Rob Herring <robh@kernel.org>
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
References: <20230223015952.201841-1-changhuang.liang@starfivetech.com>
 <20230223015952.201841-2-changhuang.liang@starfivetech.com>
 <20230227183434.GA642331-robh@kernel.org>
Content-Language: en-US
From:   Changhuang Liang <changhuang.liang@starfivetech.com>
In-Reply-To: <20230227183434.GA642331-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [113.72.145.171]
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX162.cuchost.com
 (172.16.6.72)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/2/28 2:34, Rob Herring wrote:
> On Wed, Feb 22, 2023 at 05:59:50PM -0800, Changhuang Liang wrote:
[...]
>> +
>> +  clocks:
>> +    maxItems: 3
>> +
>> +  clock-names:
>> +    items:
>> +      - const: cfg
>> +      - const: ref
>> +      - const: tx
> 
> Should be 'rx' given this is the 'rx' block? A description of each clock 
> in 'clocks' would be good.
> 

'tx': This clock is directly used to generate transmit escape sequences, 
will add description of each clock in 'clocks'.

>> +
>> +  resets:
>> +    items:
>> +      - description: DPHY_HW reset
>> +      - description: DPHY_B09_ALWAYS_ON reset
>> +
>> +  starfive,aon-syscon:
>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>> +    items:
>> +      items:
> 
> - items: ?
> 
> Otherwise, multiple 2 cell entries are allowed. Is that intended?
> 

Will change to:
items:
  - items:

>> +        - description: phandle of AON SYSCON
>> +        - description: register offset
>> +    description: The power of dphy rx is configured by AON SYSCON
>> +      in this property.
> 
> 
>> +
>> +  "#phy-cells":
>> +    const: 0
>> +
>> +required:
>> +  - compatible
>> +  - reg
[...]
>> -- 
>> 2.25.1
>>
