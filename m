Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABFD56DAC25
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 13:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232932AbjDGLR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 07:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbjDGLR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 07:17:26 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E10F30EF;
        Fri,  7 Apr 2023 04:17:24 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id F085124E36E;
        Fri,  7 Apr 2023 19:17:22 +0800 (CST)
Received: from EXMBX168.cuchost.com (172.16.6.78) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 7 Apr
 2023 19:17:22 +0800
Received: from [192.168.120.57] (171.223.208.138) by EXMBX168.cuchost.com
 (172.16.6.78) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 7 Apr
 2023 19:17:22 +0800
Message-ID: <f56fc309-0397-96ad-7df4-8bc3d9a914cb@starfivetech.com>
Date:   Fri, 7 Apr 2023 19:17:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v7 1/2] dt-bindings: soc: starfive: Add StarFive syscon
 doc
To:     Conor Dooley <conor.dooley@microchip.com>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>
References: <20230406103308.1280860-1-william.qiu@starfivetech.com>
 <20230406103308.1280860-2-william.qiu@starfivetech.com>
 <833b68a5-263d-d293-4910-2ca50b43e60d@linaro.org>
 <2ce35d68-ae6c-129f-588e-9b292de3a654@starfivetech.com>
 <20230407-stand-reversion-1db211c03ff4@wendy>
Content-Language: en-US
From:   William Qiu <william.qiu@starfivetech.com>
In-Reply-To: <20230407-stand-reversion-1db211c03ff4@wendy>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [171.223.208.138]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX168.cuchost.com
 (172.16.6.78)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-2.0 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/4/7 18:11, Conor Dooley wrote:
> On Fri, Apr 07, 2023 at 05:30:31PM +0800, William Qiu wrote:
>> 
>> This would be $ref: /schemas/clock/starfive,jh7110-pll.yaml#, but this file is not
>> available at present,  so I would like to ask if I should submit the documents
>> instead of Xingyu
> 
> Or just send the whole lot as one series, and I'll ack the soc bits for
> Stephen to take the whole lot via clk? I think Xingyu owes a respin
> anyway cos of the changes to this binding file that Krzysztof requested
> there.
> 
> Plus, the base clock support is now in clk-next, so their stuff is now
> applicable to the clk tree.
> 

So it is the best choice to give the whole series to Xingyu?

>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 4c0b39c44957..0b2170e1e4ff 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -19911,6 +19911,11 @@ S:	Supported
>>  F:	Documentation/devicetree/bindings/mmc/starfive*
>>  F:	drivers/mmc/host/dw_mmc-starfive.c
>>  
>> +STARFIVE JH7110 SYSCON
>> +M:	William Qiu <william.qiu@starfivetech.com>
>> +S:	Supported
>> +F:	Documentation/devicetree/bindings/soc/starfive/starfive,jh7110-syscon.yaml
> 
> Can you squash this in please (whitespace damaged):
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 90abe83c02f3..6fbb486f59ab 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19943,6 +19943,7 @@ STARFIVE SOC DRIVERS
>  M:     Conor Dooley <conor@kernel.org>
>  S:     Maintained
>  T:     git https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux.git/
> +F:     Documentation/devicetree/bindings/soc/starfive/
>  F:     drivers/soc/starfive/
> 

I would tell Xingyu to do so.

Best regards,
William
> Cheers,
> Conor.
