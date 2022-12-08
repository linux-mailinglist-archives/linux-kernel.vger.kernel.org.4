Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40AF764727F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 16:09:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbiLHPJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 10:09:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiLHPJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 10:09:44 -0500
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6C49349B70;
        Thu,  8 Dec 2022 07:09:43 -0800 (PST)
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 09 Dec 2022 00:09:42 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id CDA812058B4F;
        Fri,  9 Dec 2022 00:09:42 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Fri, 9 Dec 2022 00:09:42 +0900
Received: from [10.212.157.17] (unknown [10.212.157.17])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 0E4CE1DA8;
        Fri,  9 Dec 2022 00:09:42 +0900 (JST)
Message-ID: <8d29ddb9-359c-df91-abb6-acdb6927fa95@socionext.com>
Date:   Fri, 9 Dec 2022 00:09:41 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 01/16] dt-bindings: clock: Fix node descriptions in
 uniphier-clock example
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221207055405.30940-1-hayashi.kunihiko@socionext.com>
 <20221207055405.30940-2-hayashi.kunihiko@socionext.com>
 <c2782196-6dae-522a-50d5-5e5223e66e56@linaro.org>
Content-Language: en-US
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
In-Reply-To: <c2782196-6dae-522a-50d5-5e5223e66e56@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/12/08 17:06, Krzysztof Kozlowski wrote:
> On 07/12/2022 06:53, Kunihiko Hayashi wrote:
>> Prior to adding dt-bindings for SoC-dependent controllers, rename the
>> clock nodes their parent nodes to the generic names in the example.
>>
>> And also fix the missing compatible string.
>>
>> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
>> ---
>>   .../clock/socionext,uniphier-clock.yaml       | 21 +++++++++++--------
>>   1 file changed, 12 insertions(+), 9 deletions(-)
>>
>> diff --git
>> a/Documentation/devicetree/bindings/clock/socionext,uniphier-clock.yaml
>> b/Documentation/devicetree/bindings/clock/socionext,uniphier-clock.yaml
>> index 9a0cc7341630..672450a1ecda 100644
>> ---
>> a/Documentation/devicetree/bindings/clock/socionext,uniphier-clock.yaml
>> +++
>> b/Documentation/devicetree/bindings/clock/socionext,uniphier-clock.yaml
>> @@ -61,11 +61,12 @@ required:
>>
>>   examples:
>>     - |
>> -    sysctrl@61840000 {
>> -        compatible = "socionext,uniphier-sysctrl", "simple-mfd",
>> "syscon";
>> +    syscon@61840000 {
>> +        compatible = "socionext,uniphier-ld11-sysctrl",
>> +                     "simple-mfd", "syscon";
>>           reg = <0x61840000 0x4000>;
>>
>> -        clock {
>> +        clock-controller {
>>               compatible = "socionext,uniphier-ld11-clock";
>>               #clock-cells = <1>;
>>           };
>> @@ -74,11 +75,12 @@ examples:
>>       };
>>
>>     - |
>> -    mioctrl@59810000 {
>> -        compatible = "socionext,uniphier-mioctrl", "simple-mfd",
>> "syscon";
>> +    syscon@59810000 {
>> +        compatible = "socionext,uniphier-ld11-mioctrl",
>> +                     "simple-mfd", "syscon";
>>           reg = <0x59810000 0x800>;
>>
>> -        clock {
>> +        clock-controller {
>>               compatible = "socionext,uniphier-ld11-mio-clock";
>>               #clock-cells = <1>;
>>           };
>> @@ -87,11 +89,12 @@ examples:
>>       };
>>
>>     - |
>> -    perictrl@59820000 {
>> -        compatible = "socionext,uniphier-perictrl", "simple-mfd",
>> "syscon";
>> +    syscon@59820000 {
>> +        compatible = "socionext,uniphier-ld11-perictrl",
>> +                     "simple-mfd", "syscon";
>>           reg = <0x59820000 0x200>;
>>
>> -        clock {
> 
> These are all three same examples (no differences except compatibles),
> so you can as well keep only one. You can also skip parent node,
> otherwise you might keep getting warnings for this schema. The parent is
> not that relevant here and its bindings (e.g.
> socionext,uniphier-sysctrl.yaml) should include complete example -
> parent with all the children.
I understand.
I'll keep one and drop the parent node from the example.

Thank you,

---
Best Regards
Kunihiko Hayashi
