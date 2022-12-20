Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4DF76517A8
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 02:15:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233060AbiLTBPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 20:15:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232586AbiLTBOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 20:14:35 -0500
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 04C7C11C32;
        Mon, 19 Dec 2022 17:13:44 -0800 (PST)
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 20 Dec 2022 10:13:40 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id B86AF2059054;
        Tue, 20 Dec 2022 10:13:40 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Tue, 20 Dec 2022 10:13:40 +0900
Received: from [10.212.159.242] (unknown [10.212.159.242])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 1EC71A8558;
        Tue, 20 Dec 2022 10:13:40 +0900 (JST)
Message-ID: <96590704-fc2e-5a30-15b9-32fda9cb571e@socionext.com>
Date:   Tue, 20 Dec 2022 10:13:40 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v3 00/17] dt-bindings: soc: Introduce UniPhier
 miscellaneous register blocks and fix examples
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20221213082449.2721-1-hayashi.kunihiko@socionext.com>
 <20221219154948.GA1439405-robh@kernel.org>
Content-Language: en-US
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
In-Reply-To: <20221219154948.GA1439405-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 2022/12/20 0:49, Rob Herring wrote:
> On Tue, Dec 13, 2022 at 05:24:32PM +0900, Kunihiko Hayashi wrote:
>> This series introduces dt-bindings documents for miscellaneous register
>> blocks implemented in Socionext UniPhier SoCs.
>>
>> These are previously defined in the devicetree and used in the examples
>> of subnodes' dt-bindings, however, not documented.
>>
>> These include two types of the blocks
>>
>> * independent block including miscellaneous registers and functions for
>>    the whole SoC (system controller and SoC-glue logic)
>>
>> * sideband logic including control registers in the component (others)
>>
>> And prior to adding these dt-bindings, fix examples in the existing
>> dt-bindings.
>>
>> This series is part of the previous series shown below:
>>
> https://lore.kernel.org/linux-arm-kernel/20221107103410.3443-2-hayashi.kun
> ihiko@socionext.com
>>
>> Changes since v2:
>> - Drop redundant nodes in examples (clock, reset, soc-glue-debug)
>> - Drop parent node in examples
>> - Add more properties to examples for pinctrl
>> - Add a patch for regulator change
>> - Use consistent quotes
>> - Drop unit address patterns of patternProperties
>> - Mandatory unit address pattern for efuse (soc-glue-debug)
>> - Fix additionalProperties (ahci-glue)
>>
>> Changes since v1:
>> - Fix examples in the existing dt-bindings (Add PATCH 1-7)
>> - Add dt-bindings for SoC-glue logic debug part (Add PATCH 10)
>> - Drop generic and ld6b compatible strings
>> - Change "usb-controller" node in soc-glue to "usb-hub"
>> - Change "usb-controller" node in USB glue layer example to "usb"
>> - Add negation of child properties by compatible string
>>
>> Kunihiko Hayashi (17):
>>    dt-bindings: clock: Fix node descriptions in uniphier-clock example
>>    dt-bindings: reset: Fix node descriptions in uniphier-reset example
>>    dt-bindings: pinctrl: Fix node descriptions in uniphier-pinctrl
>>      example
>>    dt-bindings: regulator: Fix node descriptions in uniphier-regulator
>>      example
>>    dt-bindings: watchdog: Fix node descriptions in uniphier-wdt example
>>    dt-bindings: thermal: Fix node descriptions in uniphier-thermal
>>      example
>>    dt-bindings: phy: Fix node descriptions in uniphier-phy example
>>    dt-bindings: nvmem: Fix node descriptions in uniphier-efuse example
>>    dt-bindings: soc: socionext: Add UniPhier system controller
>>    dt-bindings: soc: socionext: Add UniPhier SoC-glue logic
>>    dt-bindings: soc: socionext: Add UniPhier SoC-glue logic debug part
>>    dt-bindings: soc: socionext: Add UniPhier peripheral block
>>    dt-bindings: soc: socionext: Add UniPhier media I/O block
>>    dt-bindings: soc: socionext: Add UniPhier SD interface block
>>    dt-bindings: soc: socionext: Add UniPhier ADAMV block
>>    dt-bindings: soc: socionext: Add UniPhier DWC3 USB glue layer
>>    dt-bindings: soc: socionext: Add UniPhier AHCI glue layer
> 
> You sent this To me, so I'm assuming you want me to apply it?
 > Otherwise, it can go via the Socionext tree. Let me know and I can fix
 > up Krzysztof's comments and apply the series.

Currently I don't have the Socionext tree for pull-request,
so I'd be happy if you could fix up the comments and apply the series.

Thank you,

---
Best Regards
Kunihiko Hayashi
