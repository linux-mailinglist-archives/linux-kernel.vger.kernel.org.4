Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06BE5646957
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 07:37:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbiLHGhl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 01:37:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbiLHGhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 01:37:36 -0500
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9C92DF77;
        Wed,  7 Dec 2022 22:37:34 -0800 (PST)
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 08 Dec 2022 15:37:33 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id E56742059054;
        Thu,  8 Dec 2022 15:37:33 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Thu, 8 Dec 2022 15:37:33 +0900
Received: from [10.212.156.246] (unknown [10.212.156.246])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 6FB6C1DA8;
        Thu,  8 Dec 2022 15:37:33 +0900 (JST)
Message-ID: <b789e04f-f812-7402-232e-f9b48ec3d11a@socionext.com>
Date:   Thu, 8 Dec 2022 15:37:33 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 08/16] dt-bindings: soc: socionext: Add UniPhier system
 controller
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
References: <20221207055405.30940-1-hayashi.kunihiko@socionext.com>
 <20221207055405.30940-9-hayashi.kunihiko@socionext.com>
 <167042221991.2111700.14995917692321113955.robh@kernel.org>
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
In-Reply-To: <167042221991.2111700.14995917692321113955.robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/12/07 23:19, Rob Herring wrote:
> 
> On Wed, 07 Dec 2022 14:53:57 +0900, Kunihiko Hayashi wrote:
>> Add devicetree binding schema for the system controller implemented on
>> Socionext Uniphier SoCs.
>>
>> This system controller has multiple functions such as clock control,
>> reset control, internal watchdog timer, thermal management, and so on.
>>
>> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
>> ---
>>   .../socionext/socionext,uniphier-sysctrl.yaml | 105 ++++++++++++++++++
>>   MAINTAINERS                                   |   1 +
>>   2 files changed, 106 insertions(+)
>>   create mode 100644
>> Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-sysctrl.yaml
>>
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/thermal/socionext,uniphier-thermal.example.dtb:
> sysctrl@61840000: 'thermal' does not match any of the regexes:
> '^clock-controller(@[0-9a-f]+)?$', '^reset-controller(@[0-9a-f]+)?$',
> '^thermal-sensor(@[0-9a-f]+)?$', '^watchdog(@[0-9a-f]+)?$', 'pinctrl-[0-9]+'
> 	From schema:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-sysctrl.yaml
> 
> doc reference errors (make refcheckdocs):
> 
> See
> https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20221207055405.30940-9-hayashi.kunihiko@socionext.com
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
> your schema. However, it must be unset to test all examples with your
> schema.

Already confirmed with example fixes.
This warning is a result evaluated before applying PATCH 5.
   [05/16] dt-bindings: thermal: Fix node descriptions in uniphier-thermal example

Thank you,

---
Best Regards
Kunihiko Hayashi
