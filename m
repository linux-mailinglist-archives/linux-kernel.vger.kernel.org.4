Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D574654235
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 14:57:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235243AbiLVN5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 08:57:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiLVN5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 08:57:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B8721144;
        Thu, 22 Dec 2022 05:57:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BAF1A61B8D;
        Thu, 22 Dec 2022 13:57:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F382C433D2;
        Thu, 22 Dec 2022 13:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671717436;
        bh=Um0fYLkeLbgGgX8YQYjN8Kos+9pmPyhWFk8Cz0CMg8w=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Y4UnKnYJiSEmCJMW9kU3XYcroTOhwIA0n1WeKdEBwNWPZru1cU81W7LXc8e5rZ1Jz
         wp5xwvc8aujnKhZPGyGNPt5L9/u/KniKJ0r5CV/SNwyEiaDXetU7KFX/fujzs3ykYm
         oMkLU/Baj0kDrGdJklXWEX4XQTDbmbGxqmoeZ5379Jan1QLXTzvTOz3kAkaJTiT7tq
         KTmy8iQs9C25mPDptNyJC25tyOnn0+gDw6wCakV57JibU6ldApnXcTADTGF+nK6Drc
         BYV4wZXJe1Tfx1nejckwUKwIIHWUUyNkk756XY7XqLzO2pY0m4L/fKnJcYMJss8GHW
         CiMvHLBRAn2ow==
Message-ID: <118e7f0c-bf5d-4bda-ee70-92eb2b71649c@kernel.org>
Date:   Thu, 22 Dec 2022 14:57:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
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
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <8357d887-c8ab-39bc-4ef0-62e9225fb2a6@foss.st.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/12/2022 14:51, Gatien CHEVALLIER wrote:
> Hello,
> 
> On 12/22/22 11:26, Krzysztof Kozlowski wrote:
>> On 21/12/2022 18:30, Gatien Chevallier wrote:
>>> Adds the list of peripherals IDs under firewall bus on STM32MP15.
>>>
>>> Signed-off-by: Gatien Chevallier <gatien.chevallier@foss.st.com>
>>> ---
>>>   include/dt-bindings/bus/stm32mp15_sys_bus.h | 98 +++++++++++++++++++++
>>>   1 file changed, 98 insertions(+)
>>>   create mode 100644 include/dt-bindings/bus/stm32mp15_sys_bus.h
>>>
>>> diff --git a/include/dt-bindings/bus/stm32mp15_sys_bus.h b/include/dt-bindings/bus/stm32mp15_sys_bus.h
>>> new file mode 100644
>>> index 000000000000..97eacc7b5f16
>>> --- /dev/null
>>> +++ b/include/dt-bindings/bus/stm32mp15_sys_bus.h
>>
>> That's wrong in multiple ways:
>> 1. No underscores
>> 2. Missing vendor prefix
>> 3. Name not matching compatible.
> 
> Sure, will comply in V3.
> 
>>
>>> @@ -0,0 +1,98 @@
>>> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
>>> +/*
>>> + * Copyright (C) STMicroelectronics 2022 - All Rights Reserved
>>> + */
>>> +#ifndef _DT_BINDINGS_BUS_STM32MP15_SYS_BUS_H
>>> +#define _DT_BINDINGS_BUS_STM32MP15_SYS_BUS_H
>>> +
>>> +/* ETZPC IDs */
>>> +#define STM32MP1_ETZPC_STGENC_ID	0
>>> +#define STM32MP1_ETZPC_BKPSRAM_ID	1
>>> +#define STM32MP1_ETZPC_IWDG1_ID		2
>>> +#define STM32MP1_ETZPC_USART1_ID	3
>>> +#define STM32MP1_ETZPC_SPI6_ID		4
>>> +#define STM32MP1_ETZPC_I2C4_ID		5
>>> +/* ID 6 reserved */
>>
>> Reserved why? These are IDs so they start from 0 and go by 0. Don't
>> hard-code some register offsets.
> 
> Here, I do define IDs. Some appear as reserved based on what I've seen 
> in the SoC datasheet that states these as "indexes"
> 
> Please see the table 94 in chapter 15.6 (ETZPC) of the STM32MP157 
> Reference manual:
> [1] https://www.st.com/resource/en/reference_manual/DM00327659-.pdf

Then why do you define them in bindings? Use raw numbers. Do you see
anywhere in arm/arm64 bindings for GIC_SPI interrupt numbers?

Best regards,
Krzysztof

