Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96FBC69AA11
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 12:15:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbjBQLPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 06:15:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjBQLPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 06:15:36 -0500
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C600B642DF;
        Fri, 17 Feb 2023 03:15:07 -0800 (PST)
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 17 Feb 2023 20:14:50 +0900
Received: from mail.mfilter.local (mail-arc01.css.socionext.com [10.213.46.36])
        by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id AA8AD2058B4F;
        Fri, 17 Feb 2023 20:14:50 +0900 (JST)
Received: from kinkan2.css.socionext.com ([172.31.9.51]) by m-FILTER with ESMTP; Fri, 17 Feb 2023 20:14:50 +0900
Received: from [10.212.159.180] (unknown [10.212.159.180])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id C87137374;
        Fri, 17 Feb 2023 20:14:49 +0900 (JST)
Message-ID: <27903ae4-3a66-004e-b9f5-e0d4deebdaa6@socionext.com>
Date:   Fri, 17 Feb 2023 20:14:49 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2] dt-bindings: ata: Add UniPhier controller binding
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-ide@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230213045432.32614-1-hayashi.kunihiko@socionext.com>
 <2d76ec86-6580-28b0-0f80-a5c497f8cef7@linaro.org>
 <ed864d57-0de3-a169-ebde-628eb84b8a21@socionext.com>
 <0c6dc673-7e11-eec5-ec2d-e00fb2060bf3@linaro.org>
 <c6b86d56-a8a4-825d-ac34-7a9f00e43b42@socionext.com>
 <2e5a17c2-f0fa-e82e-65ed-fea3637b7e62@linaro.org>
Content-Language: en-US
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
In-Reply-To: <2e5a17c2-f0fa-e82e-65ed-fea3637b7e62@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/02/17 17:42, Krzysztof Kozlowski wrote:
> On 16/02/2023 18:23, Kunihiko Hayashi wrote:
>> On 2023/02/14 18:42, Krzysztof Kozlowski wrote:
>>> On 14/02/2023 10:33, Kunihiko Hayashi wrote:
>>>> Hi Krzysztof,
>>>>
>>>> On 2023/02/13 18:10, Krzysztof Kozlowski wrote:
>>>>> On 13/02/2023 05:54, Kunihiko Hayashi wrote:
>>>>>> Add UniPhier SATA controller compatible string to the platform
>>>>>> binding.
>>>>>> This controller needs maximum three reset controls.
>>>>>>
>>>>>> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
>>>>>> ---
>>>>>>     .../devicetree/bindings/ata/ahci-platform.yaml  | 17
>>>>>> +++++++++++++++++
>>>>>>     1 file changed, 17 insertions(+)
>>>>>>
>>>>>> Changes since v1:
>>>>>> - Restrict resets property changes with compatible strings
>>>>>> - Fix maxItems from two to three
>>>>>>
>>>>>> diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.yaml
>>>>>> b/Documentation/devicetree/bindings/ata/ahci-platform.yaml
>>>>>> index 7dc2a2e8f598..25dd5ffaa517 100644
>>>>>> --- a/Documentation/devicetree/bindings/ata/ahci-platform.yaml
>>>>>> +++ b/Documentation/devicetree/bindings/ata/ahci-platform.yaml
>>>>>> @@ -45,6 +45,9 @@ properties:
>>>>>>                   - marvell,armada-8k-ahci
>>>>>>                   - marvell,berlin2-ahci
>>>>>>                   - marvell,berlin2q-ahci
>>>>>> +              - socionext,uniphier-pro4-ahci
>>>>>> +              - socionext,uniphier-pxs2-ahci
>>>>>> +              - socionext,uniphier-pxs3-ahci
>>>>>>               - const: generic-ahci
>>>>>>           - enum:
>>>>>
>>>>> Top level is saying reset=1, so did you test your bindings?
>>>>
>>>> Umm, I didn't see any errors on dt_binding_check, anyway I'll add
>>>> initial minItems:1 and maxItems:3 on top level first.
>>>
>>> You need to test also all DTS using these bindings. Yours and others.
>>> If you tested the DTS (with proper binding, not one which is basically
>>> noop):
>>>
>>> uniphier-pro4-ace.dtb: sata@65600000: resets: [[27, 12], [27, 28], [37,
>>> 3]] is too long
>>
>> I've tried updating tools and doing dtbs_check, but I couldn't find this
>> error. It seems that this error can't be detected unless there is the
>> specified compatible in "select:".
>>
>>> BTW, the patch has other errors - just look at the beginning of the
>>> file. I cannot see it here in the diff, but when you open the file you
>>> should notice it.
>>
>> Sorry, but I cannot see anything wrong.
>> I'll check the header or something...
> 
> If you open the file, you will notice the same compatibles in two
> places. In select and in properties. You added your compatibles only to
> one place, so not symmetrically.

OK, I understand. I'll add them in both.

Thank you,

---
Best Regards
Kunihiko Hayashi
