Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13F3A646955
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 07:37:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbiLHGh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 01:37:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbiLHGhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 01:37:25 -0500
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B5E309E45A;
        Wed,  7 Dec 2022 22:37:24 -0800 (PST)
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 08 Dec 2022 15:37:23 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id 18452205D901;
        Thu,  8 Dec 2022 15:37:23 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Thu, 8 Dec 2022 15:37:23 +0900
Received: from [10.212.156.246] (unknown [10.212.156.246])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 45D571DA8;
        Thu,  8 Dec 2022 15:37:22 +0900 (JST)
Message-ID: <1015c275-cf02-ce67-964e-c240d973261d@socionext.com>
Date:   Thu, 8 Dec 2022 15:37:21 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 09/16] dt-bindings: soc: socionext: Add UniPhier
 SoC-glue logic
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20221207055405.30940-1-hayashi.kunihiko@socionext.com>
 <20221207055405.30940-10-hayashi.kunihiko@socionext.com>
 <20221207153553.GA2269092-robh@kernel.org>
Content-Language: en-US
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
In-Reply-To: <20221207153553.GA2269092-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 2022/12/08 0:35, Rob Herring wrote:
> On Wed, Dec 07, 2022 at 02:53:58PM +0900, Kunihiko Hayashi wrote:
>> Add devicetree binding schema for the SoC-glue logic implemented on
>> Socionext Uniphier SoCs.
>>
>> This SoC-glue logic is a set of miscellaneous function registers
>> handling signals for specific devices outside system components,
>> and also has multiple functions such as I/O pinmux, usb-phy, debug,
>> clock-mux for a specific SoC, and so on.
>>
>> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
>> ---

(snip)

>> +allOf:
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            enum:
>> +              - socionext,uniphier-pro4-soc-glue
>> +              - socionext,uniphier-ld11-soc-glue
>> +    else:
>> +      patternProperties:
>> +        "^usb-hub(@[0-9a-f]+)?$": false
> 
> While just if and else is valid json-schema, we require 'then'. Can you
> change this to 'if: { not: {...}, then: {}'.

I see. I'll rewrite it with invert condition.

> You should be getting a warning for this. The rest of the warnings from
> the bot look like false positives you can ignore.
Hmm, I couldn't see the warning for this condition.

The warnings your bot printed are the results evaluated before
applying the example fixes (PATCH 1-7) or before fixing the
existing devicetree (need to fix but yet).

Thank you,

---
Best Regards
Kunihiko Hayashi
