Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A207646AB0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 09:38:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbiLHIiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 03:38:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbiLHIiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 03:38:14 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C5E32DA9E;
        Thu,  8 Dec 2022 00:38:08 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id ED42C24DEBC;
        Thu,  8 Dec 2022 16:38:06 +0800 (CST)
Received: from EXMBX068.cuchost.com (172.16.6.68) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 8 Dec
 2022 16:38:07 +0800
Received: from [192.168.120.55] (171.223.208.138) by EXMBX068.cuchost.com
 (172.16.6.68) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 8 Dec
 2022 16:38:05 +0800
Message-ID: <39916671-8ab1-4f39-1d9b-a66ebedfc772@starfivetech.com>
Date:   Thu, 8 Dec 2022 16:38:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v1 1/3] dt-bindings: mmc: Add bindings for StarFive
Content-Language: en-US
To:     Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-mmc@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        <linux-riscv@lists.infradead.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        <devicetree@vger.kernel.org>
References: <20221207131731.1291517-1-william.qiu@starfivetech.com>
 <20221207131731.1291517-2-william.qiu@starfivetech.com>
 <167042222472.2111911.2050446708831690640.robh@kernel.org>
 <Y5CnQlYTZJrJNjCf@spud>
From:   William Qiu <william.qiu@starfivetech.com>
In-Reply-To: <Y5CnQlYTZJrJNjCf@spud>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [171.223.208.138]
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX068.cuchost.com
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



On 2022/12/7 22:46, Conor Dooley wrote:
> On Wed, Dec 07, 2022 at 08:19:49AM -0600, Rob Herring wrote:
>> 
>> On Wed, 07 Dec 2022 21:17:29 +0800, William Qiu wrote:
>> > Add documentation to describe StarFive
>> > designware mobile storage host controller driver.
>> > 
>> > Signed-off-by: William Qiu <william.qiu@starfivetech.com>
>> > ---
>> >  .../bindings/mmc/starfive,jh7110-sdio.yaml    | 71 +++++++++++++++++++
>> >  1 file changed, 71 insertions(+)
>> >  create mode 100644 Documentation/devicetree/bindings/mmc/starfive,jh7110-sdio.yaml
>> > 
>> 
>> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
>> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>> 
>> yamllint warnings/errors:
>> 
>> dtschema/dtc warnings/errors:
>> Documentation/devicetree/bindings/mmc/starfive,jh7110-sdio.example.dts:21:18: fatal error: dt-bindings/clock/starfive-jh7110.h: No such file or directory
>>    21 |         #include <dt-bindings/clock/starfive-jh7110.h>
>>       |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Hello William,
> As with the other bindings that StarFive has sent out recently,
> including this header in the example creates a dependency on the
> clock/reset stuff being merged prior to the drivers for unrelated
> subsytems.
> To avoid that, you can drop the headers & definitions from these
> *examples* & use the numbers themselves instead.
> 
> That way, the only thing that depends on the clock binding headers is
> the DeviceTree patch & the driver can be merged once it is ready.
> 
> Thanks,
> Conor.
> 
Hi Conor,

Thank you for your suggestion. I will take it and fix it.

Best regards,
William Qiu

>> compilation terminated.
>> make[1]: *** [scripts/Makefile.lib:406: Documentation/devicetree/bindings/mmc/starfive,jh7110-sdio.example.dtb] Error 1
>> make[1]: *** Waiting for unfinished jobs....
>> make: *** [Makefile:1492: dt_binding_check] Error 2
>> 
>> doc reference errors (make refcheckdocs):
>> 
>> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20221207131731.1291517-2-william.qiu@starfivetech.com
>> 
>> The base for the series is generally the latest rc1. A different dependency
>> should be noted in *this* patch.
>> 
>> If you already ran 'make dt_binding_check' and didn't see the above
>> error(s), then make sure 'yamllint' is installed and dt-schema is up to
>> date:
>> 
>> pip3 install dtschema --upgrade
>> 
>> Please check and re-submit after running the above command yourself. Note
>> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
>> your schema. However, it must be unset to test all examples with your schema.
>> 
