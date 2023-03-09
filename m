Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F33D6B1A13
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 04:45:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbjCIDpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 22:45:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjCIDpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 22:45:33 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47E44AB0BD;
        Wed,  8 Mar 2023 19:45:32 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 1794D24DB89;
        Thu,  9 Mar 2023 11:45:31 +0800 (CST)
Received: from EXMBX071.cuchost.com (172.16.6.81) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 9 Mar
 2023 11:45:30 +0800
Received: from [192.168.125.108] (183.27.96.115) by EXMBX071.cuchost.com
 (172.16.6.81) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 9 Mar
 2023 11:45:30 +0800
Message-ID: <70e0d1b2-349a-079c-646f-394edf080fbe@starfivetech.com>
Date:   Thu, 9 Mar 2023 11:45:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 1/3] dt-bindings: phy: Add StarFive JH7110 USB
 dt-binding
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
CC:     Pawel Laszczak <pawell@cadence.com>, Vinod Koul <vkoul@kernel.org>,
        "Albert Ou" <aou@eecs.berkeley.edu>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        "Peter Chen" <peter.chen@kernel.org>,
        Roger Quadros <rogerq@kernel.org>,
        "Philipp Zabel" <p.zabel@pengutronix.de>,
        <devicetree@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-phy@lists.infradead.org>,
        "Emil Renner Berthing" <emil.renner.berthing@canonical.com>,
        <linux-usb@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Conor Dooley <conor@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20230308082800.3008-1-minda.chen@starfivetech.com>
 <20230308082800.3008-2-minda.chen@starfivetech.com>
 <167828360080.2613078.14112010625330944896.robh@kernel.org>
From:   Minda Chen <minda.chen@starfivetech.com>
In-Reply-To: <167828360080.2613078.14112010625330944896.robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [183.27.96.115]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX071.cuchost.com
 (172.16.6.81)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/3/8 22:06, Rob Herring wrote:
> 
> On Wed, 08 Mar 2023 16:27:58 +0800, Minda Chen wrote:
>> Add StarFive JH7110 SoC USB 3.0 phy dt-binding.
>> USB controller is cadence USB 3.0 IP.
>> 
>> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
>> ---
>>  .../bindings/phy/starfive,jh7110-usb-phy.yaml | 158 ++++++++++++++++++
>>  1 file changed, 158 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/phy/starfive,jh7110-usb-phy.yaml
>> 
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/phy/starfive,jh7110-usb-phy.example.dtb: usb@10100000: phy-names:1: 'anyOf' conditional failed, one must be fixed:
> 	'cdns3,usb2-phy' was expected
> 	'cdns3,usb3-phy' was expected
> 	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/usb/cdns,usb3.yaml
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/phy/starfive,jh7110-usb-phy.example.dtb: usb@10100000: 'phys' is a dependency of 'phy-names'
> 	From schema: /usr/local/lib/python3.10/dist-packages/dtschema/schemas/phy/phy-consumer.yaml
> 
> doc reference errors (make refcheckdocs):
> 
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230308082800.3008-2-minda.chen@starfivetech.com
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
I am sorry about this, I just run dtbs_check, not dt_binding_check. Next version I will fix it. 
