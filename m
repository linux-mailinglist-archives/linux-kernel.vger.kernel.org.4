Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65BCF693F16
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 08:47:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbjBMHrx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 02:47:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjBMHrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 02:47:52 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55CE5E4;
        Sun, 12 Feb 2023 23:47:48 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 8167924E377;
        Mon, 13 Feb 2023 15:47:35 +0800 (CST)
Received: from EXMBX162.cuchost.com (172.16.6.72) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 13 Feb
 2023 15:47:35 +0800
Received: from [192.168.1.100] (183.27.97.168) by EXMBX162.cuchost.com
 (172.16.6.72) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 13 Feb
 2023 15:47:34 +0800
Message-ID: <1e2a4708-1cff-e2be-9044-3e8d3082463a@starfivetech.com>
Date:   Mon, 13 Feb 2023 15:47:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v1 2/4] dt-bindings: phy: Add starfive,jh7110-dphy-rx
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
CC:     Palmer Dabbelt <palmer@dabbelt.com>,
        Conor Dooley <conor@kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        <devicetree@vger.kernel.org>,
        "Emil Renner Berthing" <kernel@esmil.dk>,
        <linux-kernel@vger.kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        <linux-riscv@lists.infradead.org>,
        "Kishon Vijay Abraham I" <kishon@kernel.org>,
        Jack Zhu <jack.zhu@starfivetech.com>,
        "Vinod Koul" <vkoul@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-phy@lists.infradead.org>
References: <20230210061713.6449-1-changhuang.liang@starfivetech.com>
 <20230210061713.6449-3-changhuang.liang@starfivetech.com>
 <167603709304.2486157.3430490619494105631.robh@kernel.org>
From:   Changhuang Liang <changhuang.liang@starfivetech.com>
In-Reply-To: <167603709304.2486157.3430490619494105631.robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [183.27.97.168]
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX162.cuchost.com
 (172.16.6.72)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/2/10 21:58, Rob Herring wrote:
> 
> On Thu, 09 Feb 2023 22:17:11 -0800, Changhuang Liang wrote:
>> Starfive SoC like the jh7110 use a MIPI D-PHY RX controller based on
>> a M31 IP. Add a binding for it.
>>
>> Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
>> ---
>>  .../bindings/phy/starfive,jh7110-dphy-rx.yaml | 78 +++++++++++++++++++
>>  1 file changed, 78 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/phy/starfive,jh7110-dphy-rx.yaml
>>
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> Documentation/devicetree/bindings/phy/starfive,jh7110-dphy-rx.example.dts:18:18: fatal error: dt-bindings/clock/starfive,jh7110-crg.h: No such file or directory
>    18 |         #include <dt-bindings/clock/starfive,jh7110-crg.h>
>       |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> compilation terminated.
> make[1]: *** [scripts/Makefile.lib:434: Documentation/devicetree/bindings/phy/starfive,jh7110-dphy-rx.example.dtb] Error 1
> make[1]: *** Waiting for unfinished jobs....
> make: *** [Makefile:1508: dt_binding_check] Error 2
> 
> doc reference errors (make refcheckdocs):
> 
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230210061713.6449-3-changhuang.liang@starfivetech.com
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

The file dt-bindings/clock/starfive,jh7110-crg.h doesn't merge in the mailline, i will delete a reference to this file
and update clocks/resets macros to the real number in the starfive,dphy-rx.yaml.
