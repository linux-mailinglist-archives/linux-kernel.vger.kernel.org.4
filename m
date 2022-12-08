Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 067D1647282
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 16:10:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbiLHPJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 10:09:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbiLHPJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 10:09:52 -0500
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E7FDD99526;
        Thu,  8 Dec 2022 07:09:50 -0800 (PST)
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 09 Dec 2022 00:09:50 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id 503112058B4F;
        Fri,  9 Dec 2022 00:09:50 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Fri, 9 Dec 2022 00:09:50 +0900
Received: from [10.212.157.17] (unknown [10.212.157.17])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id BBD711DA8;
        Fri,  9 Dec 2022 00:09:49 +0900 (JST)
Message-ID: <27378fda-5b0b-1be8-dc2e-bd408fad4071@socionext.com>
Date:   Fri, 9 Dec 2022 00:09:49 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 03/16] dt-bindings: pinctrl: Fix node descriptions in
 uniphier-pinctrl example
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221207055405.30940-1-hayashi.kunihiko@socionext.com>
 <20221207055405.30940-4-hayashi.kunihiko@socionext.com>
 <edd39013-af5f-5868-6c78-173d8f163754@linaro.org>
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
In-Reply-To: <edd39013-af5f-5868-6c78-173d8f163754@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/12/08 17:07, Krzysztof Kozlowski wrote:
> On 07/12/2022 06:53, Kunihiko Hayashi wrote:
>> Rename the parent node to the generic node name "syscon".
>>
>> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
>> ---
>>   .../devicetree/bindings/pinctrl/socionext,uniphier-pinctrl.yaml | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git
>> a/Documentation/devicetree/bindings/pinctrl/socionext,uniphier-pinctrl.yaml
>> b/Documentation/devicetree/bindings/pinctrl/socionext,uniphier-pinctrl.yaml
>> index 14a8c0215cc6..186fc550af4c 100644
>> ---
>> a/Documentation/devicetree/bindings/pinctrl/socionext,uniphier-pinctrl.yaml
>> +++
>> b/Documentation/devicetree/bindings/pinctrl/socionext,uniphier-pinctrl.yaml
>> @@ -69,7 +69,7 @@ examples:
>>     - |
>>       // The UniPhier pinctrl should be a subnode of a "syscon" compatible
>> node.
>>
>> -    soc-glue@5f800000 {
>> +    syscon@5f800000 {
>>           compatible = "socionext,uniphier-pro4-soc-glue", "simple-mfd",
>> "syscon";
>>           reg = <0x5f800000 0x2000>;
>>
> 
> Not visible in the diff but this is a poor example. It has only
> compatible! Drop the parent node instead and extend the pinctrl node to
> show complete picture of pinctrl.

I should add some child nodes of groups and pin attributes as an example
from the devicetree.

Thank you,

---
Best Regards
Kunihiko Hayashi
