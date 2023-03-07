Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD096ADBF7
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 11:31:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbjCGKbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 05:31:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbjCGKax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 05:30:53 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F7772737;
        Tue,  7 Mar 2023 02:30:12 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id EC71C24E31D;
        Tue,  7 Mar 2023 18:30:10 +0800 (CST)
Received: from EXMBX168.cuchost.com (172.16.6.78) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 7 Mar
 2023 18:30:10 +0800
Received: from [192.168.125.96] (183.27.97.46) by EXMBX168.cuchost.com
 (172.16.6.78) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 7 Mar
 2023 18:30:10 +0800
Message-ID: <0725e451-7c0b-0aac-ecd3-502b02276a9a@starfivetech.com>
Date:   Tue, 7 Mar 2023 18:30:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v4 1/3] dt-bindings: dma: snps,dw-axi-dmac: constrain
 resets items for JH7110 dma
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "Emil Renner Berthing" <emil.renner.berthing@canonical.com>
CC:     <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
References: <20230306140430.28951-1-walker.chen@starfivetech.com>
 <20230306140430.28951-2-walker.chen@starfivetech.com>
 <b2b36909-b0b1-7507-3145-141eb5ec0f3f@linaro.org>
From:   Walker Chen <walker.chen@starfivetech.com>
In-Reply-To: <b2b36909-b0b1-7507-3145-141eb5ec0f3f@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [183.27.97.46]
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX168.cuchost.com
 (172.16.6.78)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/3/7 17:03, Krzysztof Kozlowski wrote:
> On 06/03/2023 15:04, Walker Chen wrote:
>> The DMA controller needs two reset items to work properly on JH7110 SoC,
>> so there is need to constrain the items' value to 2, other platforms
>> have 1 reset item at most.
>> 
>> Signed-off-by: Walker Chen <walker.chen@starfivetech.com>
>> ---
>>  .../bindings/dma/snps,dw-axi-dmac.yaml        | 24 +++++++++++++++----
>>  1 file changed, 20 insertions(+), 4 deletions(-)
>> 
>> diff --git a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
>> index ad107a4d3b33..d8b5439f215c 100644
>> --- a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
>> +++ b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
>> @@ -12,14 +12,12 @@ maintainers:
>>  description:
>>    Synopsys DesignWare AXI DMA Controller DT Binding
>>  
>> -allOf:
>> -  - $ref: "dma-controller.yaml#"
>> -
>>  properties:
>>    compatible:
>>      enum:
>>        - snps,axi-dma-1.01a
>>        - intel,kmb-axi-dma
>> +      - starfive,jh7110-axi-dma
>>  
>>    reg:
>>      minItems: 1
>> @@ -58,7 +56,8 @@ properties:
>>      maximum: 8
>>  
>>    resets:
>> -    maxItems: 1
>> +    minItems: 1
>> +    maxItems: 2
>>  
>>    snps,dma-masters:
>>      description: |
>> @@ -109,6 +108,23 @@ required:
>>    - snps,priority
>>    - snps,block-size
>>  
>> +allOf:
>> +  - $ref: "dma-controller.yaml#"
> 
> Rebase your patches on something recent... I would argue that it should
> be based on maintainer's (or linux-next) tree, but that would be too
> good to be true.

This was written by referring to the syntax of other dt-binding, but your suggestion 
is a good one, the next version of patches will be rebased on kernel 6.3.

> 
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            enum:
>> +              - starfive,jh7110-axi-dma
>> +    then:
>> +      properties:
>> +        resets:
>> +          minItems: 2
> 
> What are the items expected here?

Do you mean to add descriptions for items here ?

Thanks!

Best regards,
Walker
