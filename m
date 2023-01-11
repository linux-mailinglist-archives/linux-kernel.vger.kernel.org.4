Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67B66665B6B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 13:33:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232915AbjAKMdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 07:33:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231766AbjAKMdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 07:33:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E78F1E029;
        Wed, 11 Jan 2023 04:33:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 75F4561CAB;
        Wed, 11 Jan 2023 12:33:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4F8EC433D2;
        Wed, 11 Jan 2023 12:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673440386;
        bh=6W/sprcBudgz8eSbOqZAoynmDsVr5n+AmKEg6gnvo7E=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=iNT+x5ovfUERKQKn0QCi2Hr6v1mc7OiOcp6FQWt55TXInjq9T7CaIw11ND7C5K6ZT
         qrEZ7E3sqmJKzPFVmXFT/Dwd+jckngmq17h0qOdHtAhtAOa6FseN9c0fgoPKqXiP4a
         yjqB+ITh1XrU3EA61z774v29nYdIAo76DcGTTgrHXRmxgCU9BwkfWP9Y8MsqvrLHO/
         XWB4TpvaGXUcGljISgvuKfCUcmis1KaMB+7QA1ul4ZpeKCnZjKlzNmHw1Z7AptcCiu
         M26Li5Hk/rrhHH8ew/GEO62iVArAjy0ZIA5pSknU6M7DIehshw8AlKfbin3S/yEJFi
         L/v4Ma3Fu4+YQ==
Message-ID: <f169d05a-7a07-aedf-bad2-30cb4a88fc16@kernel.org>
Date:   Wed, 11 Jan 2023 13:32:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [RFC PATCH 3/7] dt-bindings: bus: add STM32MP15 ETZPC firewall
 bus bindings
Content-Language: en-US
To:     Gatien CHEVALLIER <gatien.chevallier@foss.st.com>,
        alexandre.torgue@foss.st.com, robh+dt@kernel.org,
        Oleksii_Moisieiev@epam.com, linus.walleij@linaro.org,
        gregkh@linuxfoundation.org
Cc:     linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        loic.pallardy@st.com, devicetree@vger.kernel.org,
        mark.rutland@arm.com, arnd@arndb.de
References: <20221221173055.11719-1-gatien.chevallier@foss.st.com>
 <20221221173055.11719-4-gatien.chevallier@foss.st.com>
 <879325d2-4b2d-bc1d-310c-ece4c449ad8f@kernel.org>
 <8357d887-c8ab-39bc-4ef0-62e9225fb2a6@foss.st.com>
 <118e7f0c-bf5d-4bda-ee70-92eb2b71649c@kernel.org>
 <8f022dc8-d728-ba91-35ed-8a4006855f0d@foss.st.com>
 <dfe328fc-349b-3357-a8ac-6fc363f403fc@kernel.org>
 <19157c67-fa83-e598-d7ee-c313f3d4b198@foss.st.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <19157c67-fa83-e598-d7ee-c313f3d4b198@foss.st.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/01/2023 12:54, Gatien CHEVALLIER wrote:
>>>> Then why do you define them in bindings? Use raw numbers. Do you see
>>>> anywhere in arm/arm64 bindings for GIC_SPI interrupt numbers?
>>>>
>>>
>>> What would you think of simply removing the comments that state that IDs
>>> are reserved, mimicking the way it is for qcom bindings? Fundamentally,
>>> they are indeed only IDs and could be raw numbers.
>>
>> If these are IDs then there are no reserved numbers and they are
>> continuous from 0 to X. Without gaps.
>>
>>> IMO, this makes reading the device tree harder. Because you'd have to
>>> look what the raw number corresponds to.
>>
>> Sure, but that's not the reason to put numbers to the bindings... You
>> mix defines with bindings.
>>
>>> To take an example, it has already been done for SCMI clocks and I find
>>> it eases comprehension.
>>
>> You need to be a bit more specific...
> 
> Please see include/dt-bindings/clock/stm32mp1-clks.h, where there are 
> various clock IDs defined, some of them not contiguous.

These are pretty often added to accommodate space for exposing these
clocks in the future. IOW, these might be IDs just not all are shared
via header. There are such platforms and it is OK.

> 
> Errata: for SCMI clocks they are indeed contiguous but not clock IDs.
> 
>>
>> Anyway, IDs should be placed in bindings. Some mapping of
>> internal/hardware ports, registers, offsets, values - usually not.
>>
>> I don't know where exactly your case fits, but when some IDs are
>> reserved it is a clear sign that these are not IDs (again - IDs start
>> from 0 and go incrementally by one, without gaps).
>>
> 
> I do agree with your statement that IDs should not be reserved.
> 
> I think I've missed something to better highlight my point of view: It 
> would be perfectly fine using numbers that are not described in this 
> bindings file. It would just not correspond to an ID of a peripheral 
> described in the SoC reference manual, thus making no sense to use them. 
> Stating that they are reserved was incorrect, it's just that peripherals 
> get a firewall ID, depending on the platform.

Why peripheral ID should be put into the bindings? Why bindings is a
place for it? Interrupt numbers, GPIO indices/numbers, register offsets,
IOMMU ports - none of these are suitable for bindings.

> 
> I think it should be okay not describing IDs that are not relevant, what 
> do you think? I found that in include/dt-bindings/arm/qcom,ids.h, IDs 
> are not continuous. Not mentioning an ID could be used for deprecation.

These are not IDs of clocks. These are unique identifiers assigned by
vendor and used by different pieces: firmware/bootloaders, DTS and Linux
driver. We have no control of them but they exist. They also do not
represent any hardware number.

You bring some examples as an argument, but these examples are not
always related to your case. To be clear - we talk here about bindings,
so they bind different interfaces of software components (e.g. Linux
kernel with DTS). Now, what is the different interface here in your
case? If you say your peripheral hardware ID, then answer is no - this
is not software interface.

Best regards,
Krzysztof

