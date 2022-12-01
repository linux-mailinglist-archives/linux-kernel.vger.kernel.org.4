Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8650263EB19
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 09:29:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbiLAI3q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 03:29:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiLAI3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 03:29:44 -0500
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 95798FCA;
        Thu,  1 Dec 2022 00:29:41 -0800 (PST)
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 01 Dec 2022 17:29:40 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id 7B1BE2059054;
        Thu,  1 Dec 2022 17:29:40 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Thu, 1 Dec 2022 17:29:40 +0900
Received: from [10.212.157.157] (unknown [10.212.157.157])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id AD02EA855D;
        Thu,  1 Dec 2022 17:29:39 +0900 (JST)
Message-ID: <ba9fac4e-bfb1-3b8e-ad81-5d8109529d43@socionext.com>
Date:   Thu, 1 Dec 2022 17:29:39 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 1/8] dt-bindings: soc: socionext: Add UniPhier system
 controller
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221129103509.9958-1-hayashi.kunihiko@socionext.com>
 <20221129103509.9958-2-hayashi.kunihiko@socionext.com>
 <ce1b5859-4ca6-6d2d-19bc-e33e48165093@linaro.org>
 <adee56c4-6932-9272-3319-e003ab8413b5@socionext.com>
 <cb76a56f-6492-5209-be30-e31aa075ce8e@linaro.org>
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
In-Reply-To: <cb76a56f-6492-5209-be30-e31aa075ce8e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/12/01 0:24, Krzysztof Kozlowski wrote:
> On 30/11/2022 09:59, Kunihiko Hayashi wrote:
>>>> +maintainers:
>>>> +  - Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
>>>> +
>>>> +description: |+
>>>> +  System controller implemented on Socionext UniPhier SoCs has multiple
>>>> +  functions such as clock control, reset control, internal watchdog
>>>> timer,
>>>> +  thermal management, and so on.
>>>> +
>>>> +properties:
>>>> +  compatible:
>>>> +    items:
>>>> +      - enum:
>>>> +          - socionext,uniphier-ld4-sysctrl
>>>> +          - socionext,uniphier-pro4-sysctrl
>>>> +          - socionext,uniphier-pro5-sysctrl
>>>> +          - socionext,uniphier-pxs2-sysctrl
>>>> +          - socionext,uniphier-ld6b-sysctrl
>>>> +          - socionext,uniphier-sld8-sysctrl
>>>> +          - socionext,uniphier-ld11-sysctrl
>>>> +          - socionext,uniphier-ld20-sysctrl
>>>> +          - socionext,uniphier-pxs3-sysctrl
>>>> +          - socionext,uniphier-nx1-sysctrl
>>>
>>> All of them can have children or only some?
>>
>> In case of this system controller,
>> all SoCs has clock-controller, reset-controller and watchdog.
>>
>> However, some SoCs don't have thermal-sensor and
>> their register addresses are reserved.
> 
> OK
> 
>>
>>>> +          - socionext,uniphier-sysctrl
> 
> What about this one? What SoC is this? Looks too generic.

It's the same one as soc-glue, so it should be placed as follows.

items:
   - enum:
       - ...
       - ...
   - const: socionext,uniphier-sysctrl

However, currently it is no use for now. I'll drop it.

Thank you,

---
Best Regards
Kunihiko Hayashi
