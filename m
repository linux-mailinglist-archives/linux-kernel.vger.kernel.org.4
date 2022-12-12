Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0F6D649902
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 07:34:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbiLLGeG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 01:34:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbiLLGeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 01:34:03 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B211BC2C;
        Sun, 11 Dec 2022 22:33:58 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id EF65C24E1D3;
        Mon, 12 Dec 2022 14:33:49 +0800 (CST)
Received: from EXMBX068.cuchost.com (172.16.6.68) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 12 Dec
 2022 14:33:49 +0800
Received: from [192.168.125.96] (113.72.147.126) by EXMBX068.cuchost.com
 (172.16.6.68) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 12 Dec
 2022 14:33:49 +0800
Message-ID: <bdda8e37-b6a1-1293-4af8-f0a254d37a2a@starfivetech.com>
Date:   Mon, 12 Dec 2022 14:33:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [RESEND PATCH v2 1/3] dt-bindings: power: Add starfive,jh71xx-pmu
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
CC:     <linux-riscv@lists.infradead.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-pm@vger.kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "Emil Renner Berthing" <emil.renner.berthing@canonical.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>
References: <20221208084523.9733-1-walker.chen@starfivetech.com>
 <20221208084523.9733-2-walker.chen@starfivetech.com>
 <167050594063.531467.3185697679617153248.robh@kernel.org>
From:   Walker Chen <walker.chen@starfivetech.com>
In-Reply-To: <167050594063.531467.3185697679617153248.robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [113.72.147.126]
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX068.cuchost.com
 (172.16.6.68)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/12/8 21:31, Rob Herring wrote:
> 
> On Thu, 08 Dec 2022 16:45:21 +0800, Walker Chen wrote:
>> Add bindings for Power Management Unit (PMU) on the StarFive JH71XX SoC.
>> 
>> Signed-off-by: Walker Chen <walker.chen@starfivetech.com>
>> ---
>>  .../bindings/power/starfive,jh71xx-pmu.yaml   | 45 +++++++++++++++++++
>>  .../dt-bindings/power/starfive,jh7110-pmu.h   | 17 +++++++
>>  2 files changed, 62 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/power/starfive,jh71xx-pmu.yaml
>>  create mode 100644 include/dt-bindings/power/starfive,jh7110-pmu.h
>> 
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> ./Documentation/devicetree/bindings/power/starfive,jh71xx-pmu.yaml:18:7: [warning] wrong indentation: expected 4 but found 6 (indentation)
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/power/starfive,jh71xx-pmu.yaml: properties:compatible: [{'enum': ['starfive,jh7110-pmu']}] is not of type 'object', 'boolean'
> 	from schema $id: http://json-schema.org/draft-07/schema#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/power/starfive,jh71xx-pmu.yaml: ignoring, error in schema: properties: compatible
> Documentation/devicetree/bindings/power/starfive,jh71xx-pmu.example.dtb:0:0: /example-0/power-controller@17030000: failed to match any schema with compatible: ['starfive,jh7110-pmu']
> 
> doc reference errors (make refcheckdocs):
> 
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20221208084523.9733-2-walker.chen@starfivetech.com
> 
> The base for the series is generally the latest rc1. A different dependency
> should be noted in *this* patch.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your schema.
> 

Please forgive my mistake, I forgot to make dt_binding_check for .yaml file. 
Now there is no complain after syntax and indentation are fixed.
Thank you for your comment.

Best regards,
Walker Chen

