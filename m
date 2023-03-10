Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 155196B4FCF
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 19:08:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbjCJSIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 13:08:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbjCJSIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 13:08:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E98EF1B318;
        Fri, 10 Mar 2023 10:08:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 14EF061BB2;
        Fri, 10 Mar 2023 18:08:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E92FFC433EF;
        Fri, 10 Mar 2023 18:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678471685;
        bh=1Z0qzAWjdgjpl9cppEGMQkzvMHIUxky2AMt6JDpGnN4=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=dRKOZR4q0d/gZV1FcaOoD2TkSsBp9tJ4pMk6uHCG63pE7rD44jrwd3yDEJpLuJEqO
         lJOhyy1MGFgQsUa9Gvzv8CEJm0mtnWngZKfPR6hZ5ZqkjHjW5Q4xGXI9IU1gXYDwSn
         Lww/AAS7YhRd2h54aQHyr3an+NDRKO0dO+elLmjUUt2id6pyTHOhP9hJ+sLRcHPig2
         f9E4lMl3dhLIvkCpzAczBixCwMzpo6P7sh54erF2w+tA8KYfu/WsuGHIhDS/plSnax
         2n8mqX7AkBjtTXQ+oeqrW9gYPftC5rn7j0uSj20O/nlYk6/OpaJbkcXgL+riX3s9kD
         5upRoX6NQy3MA==
Message-ID: <d80001de-3cf7-59e9-5ae7-d8dfe0a1c21e@kernel.org>
Date:   Fri, 10 Mar 2023 19:08:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH V2 4/6] dt-bindings: timestamp: Add Tegra234 support
To:     Dipen Patel <dipenp@nvidia.com>, thierry.reding@gmail.com,
        jonathanh@nvidia.com, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-gpio@vger.kernel.org,
        linus.walleij@linaro.org, devicetree@vger.kernel.org,
        linux-doc@vger.kernel.org, robh+dt@kernel.org,
        timestamp@lists.linux.dev
References: <20230214115553.10416-1-dipenp@nvidia.com>
 <20230214115553.10416-5-dipenp@nvidia.com>
 <3c0ad963-ce69-bd5b-20cd-888e5fbdecaf@kernel.org>
 <7a8027c9-dc73-3684-c5f2-3071f315b3cd@nvidia.com>
 <a5e897e5-4cb9-d50f-47a8-ffb8bd8774cb@kernel.org>
 <18f9a6ca-a61b-4cbb-b729-1fdb6d48651a@nvidia.com>
 <ab9f7730-d399-0786-67e5-aad57716809e@kernel.org>
 <c1a78a59-c8ae-81e5-b641-a7cb75062ab3@nvidia.com>
 <f661f27f-f367-2948-1435-5b5fa43a3b46@kernel.org>
 <6733c921-3cca-cd7b-3846-0ab6ce172c14@nvidia.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <6733c921-3cca-cd7b-3846-0ab6ce172c14@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/03/2023 18:19, Dipen Patel wrote:
> On 3/10/23 12:45 AM, Krzysztof Kozlowski wrote:
>> On 09/03/2023 19:49, Dipen Patel wrote:
>>> On 3/8/23 10:16 PM, Krzysztof Kozlowski wrote:
>>>> On 08/03/2023 21:09, Dipen Patel wrote:
>>>>> On 3/8/23 11:05 AM, Krzysztof Kozlowski wrote:
>>>>>> On 08/03/2023 19:45, Dipen Patel wrote:
>>>>>>> On 2/16/23 6:17 AM, Krzysztof Kozlowski wrote:
>>>>>>>> On 14/02/2023 12:55, Dipen Patel wrote:
>>>>>>>>> Added timestamp provider support for the Tegra234 in devicetree
>>>>>>>>> bindings.
>>>>>>>>
>>>>>>>> 1. Your commit does much more. You need to explain it why you drop some
>>>>>>>> property.
>>>>>>> ACK, will address it next patch
>>>>>>>>
>>>>>>>> 2. Bindings go before its usage (in the patchset).
>>>>>>> Ack...
>>>>>>>>
>>>>>>>> 3. Please use scripts/get_maintainers.pl to get a list of necessary
>>>>>>>> people and lists to CC.  It might happen, that command when run on an
>>>>>>>> older kernel, gives you outdated entries.  Therefore please be sure you
>>>>>>>> base your patches on recent Linux kernel.
>>>>>>> It is based on recent linux at the time patch series was sent...
>>>>>>
>>>>>> That's good but then why you do not use scripts/get_maintainers.pl? The
>>>>>> hint about recent kernel was just a hint... Just do not invent addresses
>>>>>> by yourself and use the tool to get them right.
>>>>>>
>>>>> I will take a note for the next patch series to add any missing people. The current
>>>>> list of people/group is what historically helped review this new timestamp/hte subsystem.
>>>>>
>>>>>> (...)
>>>>>>
>>>>>>>>> +  properties:
>>>>>>>>> +    compatible:
>>>>>>>>> +      contains:
>>>>>>>>> +        enum:
>>>>>>>>> +          - nvidia,tegra194-gte-aon
>>>>>>>>
>>>>>>>> This is an ABI break. Does your driver handle it?
>>>>>>> yes, handling patch is part of this patch series.
>>>>>>
>>>>>> Can you point me to the code which does it? I see "return -ENODEV;", so
>>>>>> I think you do not handle ABI break. I could miss something but since
>>>>>> you disagree with me, please at least bring some arguments...
>>>>> Refer to patch https://patchwork.kernel.org/project/timestamp/patch/20230214115553.10416-3-dipenp@nvidia.com/
>>>>> which has compatible properties added and also code changes to reflect addition/deletion of some
>>>>> properties.
>>>>
>>>> I referred to the code which breaks the ABI.
>>>>
>>>>>
>>>>> I am not sure I have understood about ABI break comment. How else one should handle if
>>>>> there is no related gpio controller property found?
>>>>
>>>> In a way it does not break existing users? There are many ways to handle
>>>> it, but I don't know your code to point you.
>>>
>>> It is new subsystem and has only one driver which uses it so far. 
>>
>> We do not talk about subsystem, but Tegra SoC, which is not new. Unless
>> you meant this is new SoC/DTS?
>>
>>> This was a decision taken
>>> after review comments (By Thierry, also in the mailing list) to add this property (nvidia,gpio-controller)
>>> and necessary changes have been made to existing user. From now on, it has to follow this change.
>>
>> What is "it" which has to follow? There are rules for stable ABI and
>> commit msg does not explain why they should not be followed.
> 
> "It" here means hte-tegra194.c HTE provider which is the only one and not being used by any entity
> yet.
> 
>>
>>>
>>>>
>>>>> I am assuming you are referring to the
>>>>> below code from the patch 2 (link above) when you said "return -ENODEV".
>>>>
>>>>
>>>> Your bindings patch points to ABI break without any
>>>> explanation/justification. Then your code #2 patch actually breaks it,
>>>> also without any justification.
>>> I am going to add explanation/justification in the commit message in the next patch series. But to give
>>> you context, discussion happened here https://patchwork.ozlabs.org/project/linux-gpio/patch/20221103174523.29592-3-dipenp@nvidia.com/
>>
>> Either too many messages (and I missed something) or I could not find
>> why ABI break is accepted and justified.
> 
> https://patchwork.ozlabs.org/project/linux-gpio/patch/20221103174523.29592-5-dipenp@nvidia.com/#3000908 and
> affected code/comment at https://patchwork.ozlabs.org/project/linux-gpio/patch/20221103174523.29592-5-dipenp@nvidia.com/#3000908.
> 
> Will it help if I send new patch series with detailed commit message?

Yes. If the binding is not used, it's a perfectly valid reason and
should be mentioned in commit msg.

Best regards,
Krzysztof

