Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 640AC6E418F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 09:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbjDQHpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 03:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbjDQHpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 03:45:07 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B11D112F;
        Mon, 17 Apr 2023 00:44:57 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 63DD580CF;
        Mon, 17 Apr 2023 15:44:48 +0800 (CST)
Received: from EXMBX061.cuchost.com (172.16.6.61) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 17 Apr
 2023 15:44:48 +0800
Received: from [192.168.125.131] (183.27.97.249) by EXMBX061.cuchost.com
 (172.16.6.61) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 17 Apr
 2023 15:44:46 +0800
Message-ID: <8c396a98-a76e-cd68-4d26-15ae3a15a623@starfivetech.com>
Date:   Mon, 17 Apr 2023 15:43:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 5/7] dt-bindings: soc: starfive: Add StarFive syscon
 module
To:     Rob Herring <robh@kernel.org>,
        William Qiu <william.qiu@starfivetech.com>
CC:     <linux-riscv@lists.infradead.org>, Conor Dooley <conor@kernel.org>,
        "Emil Renner Berthing" <kernel@esmil.dk>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Hal Feng <hal.feng@starfivetech.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, <linux-clk@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <devicetree@vger.kernel.org>,
        "Michael Turquette" <mturquette@baylibre.com>
References: <20230414024157.53203-1-xingyu.wu@starfivetech.com>
 <20230414024157.53203-6-xingyu.wu@starfivetech.com>
 <168147484896.3576391.17289619505417988717.robh@kernel.org>
Content-Language: en-US
From:   Xingyu Wu <xingyu.wu@starfivetech.com>
In-Reply-To: <168147484896.3576391.17289619505417988717.robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [183.27.97.249]
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX061.cuchost.com
 (172.16.6.61)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/4/14 20:37, Rob Herring wrote:
> 
> On Fri, 14 Apr 2023 10:41:55 +0800, Xingyu Wu wrote:
>> From: William Qiu <william.qiu@starfivetech.com>
>> 
>> Add documentation to describe StarFive System Controller Registers.
>> 
>> Signed-off-by: William Qiu <william.qiu@starfivetech.com>
>> ---
>>  .../soc/starfive/starfive,jh7110-syscon.yaml  | 58 +++++++++++++++++++
>>  MAINTAINERS                                   |  6 ++
>>  2 files changed, 64 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/soc/starfive/starfive,jh7110-syscon.yaml
>> 
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> ./Documentation/devicetree/bindings/soc/starfive/starfive,jh7110-syscon.yaml: Unable to find schema file matching $id: http://devicetree.org/schemas/clock/starfive,jh7110-pll.yaml
> 
> doc reference errors (make refcheckdocs):
> 
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230414024157.53203-6-xingyu.wu@starfivetech.com
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

I have updated yamllint and dtschema, and tested it and didn't see this error.
I asked william and also didn't see this. This error says the file:
http://devicetree.org/schemas/clock/starfive,jh7110-pll.yaml was not found.
This file is added in patch 1 but patch 1 should be applied after these patchset
about JH7110 basic clock drivers. I don't know if that's the reason.

Best regards,
Xingyu Wu
