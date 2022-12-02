Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F212640686
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 13:15:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233151AbiLBMPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 07:15:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232011AbiLBMO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 07:14:59 -0500
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CA180B90FE;
        Fri,  2 Dec 2022 04:14:58 -0800 (PST)
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 02 Dec 2022 21:14:57 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id 690CA2059054;
        Fri,  2 Dec 2022 21:14:57 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Fri, 2 Dec 2022 21:14:57 +0900
Received: from [10.212.159.169] (unknown [10.212.159.169])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 4A2DC1974;
        Fri,  2 Dec 2022 21:14:56 +0900 (JST)
Message-ID: <04a9db58-4768-f045-9d97-f79e237369bb@socionext.com>
Date:   Fri, 2 Dec 2022 21:14:55 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 8/8] dt-bindings: soc: socionext: Add UniPhier AHCI glue
 layer
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20221129103509.9958-1-hayashi.kunihiko@socionext.com>
 <20221129103509.9958-9-hayashi.kunihiko@socionext.com>
 <33ca35f4-acee-6b2b-1a73-41ed5882819e@socionext.com>
 <4345f968-8c2b-6c54-7f2c-81effaba3ab2@linaro.org>
Content-Language: en-US
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
In-Reply-To: <4345f968-8c2b-6c54-7f2c-81effaba3ab2@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/12/02 21:08, Krzysztof Kozlowski wrote:
> On 01/12/2022 10:30, Kunihiko Hayashi wrote:
>> Hi Krzysztof,
>>
>> On 2022/11/29 19:35, Kunihiko Hayashi wrote:
>>> Add DT binding schema for components belonging to the platform-specific
>>> AHCI glue layer implemented in UniPhier SoCs.
>>>
>>> This AHCI glue layer works as a sideband logic for the host controller,
>>> including core reset, PHYs, and some signals to the controller.
>>>
>>> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
>>
>> (snip)
>>
>>> +examples:
>>> +  - |
>>> +    sata-controller@65700000 {
>>> +        compatible = "socionext,uniphier-pxs3-ahci-glue", "simple-mfd";
>>> +        reg = <0x65b00000 0x400>;
>>> +        #address-cells = <1>;
>>> +        #size-cells = <1>;
>>> +        ranges = <0 0x65700000 0x100>;
>>
>> In PATCH 7/8, you suggested that the node name of "USB glue layer" should
>> changes to the generic node name "usb@...".
>>
>> However, in case of this "AHCI glue layer", I can't change
>> "sata-controller"
>> to the generic node name "sata@...", because ata/sata-common.yaml has
>> pattern
>> "^sata(@.*)?$", and the changed node matches this pattern unintentionally.
>>
>> This layer isn't a sata host controller, so it's hard to give a generic
>> name
>> to this node. I'd like you opinion.
> 
> Yeah, I think it's fine. We do not have good names for such nodes.

OK, I leave the name for this node.

Thank you,

---
Best Regards
Kunihiko Hayashi
