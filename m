Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 811136AD7EC
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 08:01:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbjCGHBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 02:01:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231254AbjCGHAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 02:00:47 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D92AA89F2C;
        Mon,  6 Mar 2023 23:00:17 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id D868224E2C5;
        Tue,  7 Mar 2023 14:58:28 +0800 (CST)
Received: from EXMBX071.cuchost.com (172.16.6.81) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 7 Mar
 2023 14:58:28 +0800
Received: from [192.168.125.108] (183.27.97.46) by EXMBX071.cuchost.com
 (172.16.6.81) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 7 Mar
 2023 14:58:28 +0800
Message-ID: <3871e4ad-af5a-4c71-aee1-abcd60186012@starfivetech.com>
Date:   Tue, 7 Mar 2023 14:58:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/3] dt-bindings: phy: Add StarFive JH7110 USB dt-binding
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
CC:     <linux-phy@lists.infradead.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-kernel@vger.kernel.org>, "Vinod Koul" <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        "Emil Renner Berthing" <kernel@esmil.dk>
References: <20230306095257.25957-1-minda.chen@starfivetech.com>
 <167810459782.12203.9014682894570874393.robh@kernel.org>
From:   Minda Chen <minda.chen@starfivetech.com>
In-Reply-To: <167810459782.12203.9014682894570874393.robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [183.27.97.46]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX071.cuchost.com
 (172.16.6.81)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/3/6 20:25, Rob Herring wrote:
> 
> On Mon, 06 Mar 2023 17:52:57 +0800, Minda Chen wrote:
>> Add StarFive JH7110 SoC USB 3.0 phy dt-binding.
>> USB controller is cadence USB 3.0 IP.
>> 
>> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
>> ---
>>  .../bindings/phy/starfive,jh7110-usb-phy.yaml | 116 ++++++++++++++++++
>>  1 file changed, 116 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/phy/starfive,jh7110-usb-phy.yaml
>> 
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> ./Documentation/devicetree/bindings/phy/starfive,jh7110-usb-phy.yaml:30:8: [warning] wrong indentation: expected 6 but found 7 (indentation)
> ./Documentation/devicetree/bindings/phy/starfive,jh7110-usb-phy.yaml:40:8: [warning] wrong indentation: expected 6 but found 7 (indentation)
> ./Documentation/devicetree/bindings/phy/starfive,jh7110-usb-phy.yaml:57:12: [error] syntax error: mapping values are not allowed here (syntax)
> 
> dtschema/dtc warnings/errors:
> make[1]: *** Deleting file 'Documentation/devicetree/bindings/phy/starfive,jh7110-usb-phy.example.dts'
> Documentation/devicetree/bindings/phy/starfive,jh7110-usb-phy.yaml:57:12: mapping values are not allowed in this context
> make[1]: *** [Documentation/devicetree/bindings/Makefile:26: Documentation/devicetree/bindings/phy/starfive,jh7110-usb-phy.example.dts] Error 1
> make[1]: *** Waiting for unfinished jobs....
> ./Documentation/devicetree/bindings/phy/starfive,jh7110-usb-phy.yaml:57:12: mapping values are not allowed in this context
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/phy/starfive,jh7110-usb-phy.yaml: ignoring, error parsing file
> make: *** [Makefile:1512: dt_binding_check] Error 2
> 
> doc reference errors (make refcheckdocs):
> 
> 
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230306095257.25957-1-minda.chen@starfivetech.com
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
Thanks! I will fix this issue in patch v2.
