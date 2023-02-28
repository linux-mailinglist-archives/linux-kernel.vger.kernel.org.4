Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FD706A5526
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 10:06:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbjB1JGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 04:06:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjB1JGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 04:06:54 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A06B1A97E;
        Tue, 28 Feb 2023 01:06:53 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id E886E24E4A6;
        Tue, 28 Feb 2023 17:06:51 +0800 (CST)
Received: from EXMBX068.cuchost.com (172.16.6.68) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 28 Feb
 2023 17:05:48 +0800
Received: from [192.168.120.55] (171.223.208.138) by EXMBX068.cuchost.com
 (172.16.6.68) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 28 Feb
 2023 17:05:47 +0800
Message-ID: <f8d2b665-ce5d-81f8-8c55-81f1a4cb62b9@starfivetech.com>
Date:   Tue, 28 Feb 2023 17:05:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v4 4/4] dt-bindings: syscon: Add StarFive syscon doc
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
CC:     <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        <linux-kernel@vger.kernel.org>
References: <20230215113249.47727-1-william.qiu@starfivetech.com>
 <20230215113249.47727-5-william.qiu@starfivetech.com>
 <20230220234335.GA615198-robh@kernel.org>
 <348796cc-72d9-4dcf-9f09-4c2aa55cb858@starfivetech.com>
 <20230227222904.GC1048218-robh@kernel.org>
From:   William Qiu <william.qiu@starfivetech.com>
In-Reply-To: <20230227222904.GC1048218-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [171.223.208.138]
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX068.cuchost.com
 (172.16.6.68)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/2/28 6:29, Rob Herring wrote:
> On Tue, Feb 21, 2023 at 10:44:02AM +0800, William Qiu wrote:
>> 
>> 
>> On 2023/2/21 7:43, Rob Herring wrote:
>> > On Wed, Feb 15, 2023 at 07:32:49PM +0800, William Qiu wrote:
>> >> Add documentation to describe StarFive System Controller Registers.
>> >> 
>> >> Signed-off-by: William Qiu <william.qiu@starfivetech.com>
>> >> ---
>> >>  .../bindings/soc/starfive/jh7110-syscon.yaml  | 51 +++++++++++++++++++
>> >>  MAINTAINERS                                   |  5 ++
>> >>  2 files changed, 56 insertions(+)
>> >>  create mode 100644 Documentation/devicetree/bindings/soc/starfive/jh7110-syscon.yaml
>> >> 
>> >> diff --git a/Documentation/devicetree/bindings/soc/starfive/jh7110-syscon.yaml b/Documentation/devicetree/bindings/soc/starfive/jh7110-syscon.yaml
>> >> new file mode 100644
>> >> index 000000000000..fa4d8522a454
>> >> --- /dev/null
>> >> +++ b/Documentation/devicetree/bindings/soc/starfive/jh7110-syscon.yaml
>> >> @@ -0,0 +1,51 @@
>> >> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> >> +%YAML 1.2
>> >> +---
>> >> +$id: http://devicetree.org/schemas/soc/starfive/jh7110-syscon.yaml#
>> >> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> >> +
>> >> +title: StarFive JH7110 SoC system controller
>> >> +
>> >> +maintainers:
>> >> +  - William Qiu <william.qiu@starfivetech.com>
>> >> +
>> >> +description: |
>> >> +  The StarFive JH7110 SoC system controller provides register information such
>> >> +  as offset, mask and shift to configure related modules such as MMC and PCIe.
>> >> +
>> >> +properties:
>> >> +  compatible:
>> >> +    items:
>> >> +      - enum:
>> >> +          - starfive,jh7110-stg-syscon
>> >> +          - starfive,jh7110-sys-syscon
>> >> +          - starfive,jh7110-aon-syscon
>> > 
>> > Is 'syscon' really part of what the blocks are called? Is just 'stg', 
>> > 'sys' and 'aon' not unique enough?
>> > 
>> > Rob
>> Hi Rob,
>> 
>> In StarFive SoC, we do have syscrg/aoncrg/stgcrg, which is uesd to be the clock
>> controller, so 'syscon' is added to avoid confusion.
> 
> You've only added to my confusion. 'syscrg' and 'sys-syscon' are 2 
> different h/w blocks and unrelated to each other? Or 'syscrg' is the 
> clock portion of 'sys-syscon'? In that case, 'syscrg' should be a child 
> of 'sys-syscon' or possibly just all one node. Please provide details on 
> the entire h/w block so we can provide better input on the bindings.
> 
> Rob

Hi Rob,

It's my description that's problematic.'syscon' here refers to the hardware module
inside our JH7110, which is different from the syscon interface in linux. The syscon
I added now uses the syscon interface of linux to read and write the syscon register
in our JH7110. So we decided to name it that way.

Best regards
William
