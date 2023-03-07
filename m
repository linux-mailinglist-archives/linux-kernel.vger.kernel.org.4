Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 921E46AD42B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 02:43:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbjCGBnt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 20:43:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjCGBnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 20:43:46 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00AD756504;
        Mon,  6 Mar 2023 17:43:14 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id C2A8424E13A;
        Tue,  7 Mar 2023 09:43:13 +0800 (CST)
Received: from EXMBX068.cuchost.com (172.16.6.68) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 7 Mar
 2023 09:43:13 +0800
Received: from [192.168.120.57] (171.223.208.138) by EXMBX068.cuchost.com
 (172.16.6.68) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 7 Mar
 2023 09:43:13 +0800
Message-ID: <b650c07c-b19c-6e58-9b77-f55ee2ccd6f6@starfivetech.com>
Date:   Tue, 7 Mar 2023 09:43:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v4 4/4] dt-bindings: syscon: Add StarFive syscon doc
To:     Conor Dooley <conor.dooley@microchip.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        <linux-kernel@vger.kernel.org>
References: <20230215113249.47727-1-william.qiu@starfivetech.com>
 <20230215113249.47727-5-william.qiu@starfivetech.com>
 <41bcc545-6eda-6c30-c600-d97ef009abf2@linaro.org> <Y+4Fbrz8EYIGyjVj@wendy>
 <8388695b-98f9-223b-1e15-86aaefec2d6f@linaro.org> <ZAXzCfs7wkxaUWN7@wendy>
Content-Language: en-US
From:   William Qiu <william.qiu@starfivetech.com>
In-Reply-To: <ZAXzCfs7wkxaUWN7@wendy>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [171.223.208.138]
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX068.cuchost.com
 (172.16.6.68)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/3/6 22:04, Conor Dooley wrote:
> Hey William,
> 
> On Thu, Feb 16, 2023 at 11:31:45AM +0100, Krzysztof Kozlowski wrote:
>> On 16/02/2023 11:29, Conor Dooley wrote:
>> > On Thu, Feb 16, 2023 at 11:23:00AM +0100, Krzysztof Kozlowski wrote:
>> >> On 15/02/2023 12:32, William Qiu wrote:
>> >>> Add documentation to describe StarFive System Controller Registers.
>> >>>
>> >>> Signed-off-by: William Qiu <william.qiu@starfivetech.com>
>> >>> ---
>> >>
>> >> Thank you for your patch. There is something to discuss/improve.
> 
> Could you please submit a v5 of this, with the bits below fixed,
> whenever Hal sends their next version of the base dts series?
> There's no maintainers coverage for a soc/starfive subdirectory of
> dt-bindings yet, so please CC conor@kernel.org &
> linux-riscv@lists.infradead.com on the patch.
> 
> Thanks,
> Conor.
> 

I'll do it today.

Best regards
William
>> >>
>> >>> +properties:
>> >>> +  compatible:
>> >>> +    items:
>> >>> +      - enum:
>> >>> +          - starfive,jh7110-stg-syscon
>> >>> +          - starfive,jh7110-sys-syscon
>> >>> +          - starfive,jh7110-aon-syscon
>> >>
>> >> Maybe keep them ordered alphabetically?
>> >>
>> >>> +      - const: syscon
>> >>> +
>> >>> +  reg:
>> >>> +    maxItems: 1
>> >>> +
>> >>> +required:
>> >>> +  - compatible
>> >>> +  - reg
>> >>> +
>> >>> +additionalProperties: false
>> >>> +
>> >>> +examples:
>> >>> +  - |
>> >>> +    syscon@10240000 {
>> >>> +        compatible = "starfive,jh7110-stg-syscon", "syscon";
>> >>> +        reg = <0x10240000 0x1000>;
>> >>> +    };
>> >>
>> >> Keep only one example. All others are the same.
>> > 
>> > With these fixed:
>> > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
>> > 
>> > @Krzysztof, I assume the location of the binding is okay with you since
>> > you didn't object to it & I suppose this one is up to me to apply if so.
>> 
>> Yeah, generic sysreg devices go to soc. If their primary functions were
>> different (e.g. clock controller which also is syscon), then they should
>> go to respective directories, but it's not the case here, I think.
>> 
>> Best regards,
>> Krzysztof
>> 
>> 
