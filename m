Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DBD2654424
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 16:21:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235230AbiLVPVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 10:21:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbiLVPVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 10:21:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4672662DE;
        Thu, 22 Dec 2022 07:21:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9DEDCB81E12;
        Thu, 22 Dec 2022 15:21:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C8F7C433D2;
        Thu, 22 Dec 2022 15:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671722502;
        bh=7/Y2uZ8A9lceps36kzxsVQStq3KTyvTY+WEoC5HeMOk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=oog2bss5LB4qzM4eYx1PNIIP8v0QIoRTekYHSaGz54yrd5OFLqf+83ujZqurOshZj
         1AWVSBpqMlWOlB08VIBE/JisLYBdK/aBBd1TJNQyh0ZQ/rQGhdUxUU705WDJlmwFu/
         nlKvHve0vmoGatJ6jRne4OXHJOLqdgvsf/rx0hByUhQo6Q8vWQVUQTy0cyift9V0TF
         tlIj0DUpdPgNG0sa/BytuhU8vzkSSmElHSa9mHzXrK2cZoM327+/Rl+dsrMz6JXaef
         tx/7F0xRS5E5Gimw4ulTiBfPy74iCjvB20j8+yUssNwg2hV3X4HVObKePAzYKuh+3H
         crTk8GEfREWMw==
Message-ID: <041b77e0-40c5-e724-e5d9-f1da64d5e684@kernel.org>
Date:   Thu, 22 Dec 2022 16:21:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [RFC PATCH 6/7] ARM: dts: stm32: add ETZPC as a system bus for
 STM32MP15x boards
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
 <20221221173055.11719-7-gatien.chevallier@foss.st.com>
 <2e7c901c-e322-ded6-b170-6d2436d74c0f@kernel.org>
 <0bff5b2d-2837-57cb-5434-58158acc1483@foss.st.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <0bff5b2d-2837-57cb-5434-58158acc1483@foss.st.com>
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

On 22/12/2022 15:42, Gatien CHEVALLIER wrote:
> Hello,
> 
> 
> On 12/22/22 11:30, Krzysztof Kozlowski wrote:
>> On 21/12/2022 18:30, Gatien Chevallier wrote:
>>> The STM32 System Bus is an internal bus on which devices are connected.
>>> ETZPC is a peripheral overseeing the firewall bus that configures
>>> and control access to the peripherals connected on it.
>>>
>>> For more information on which peripheral is securable, please read
>>> the STM32MP15 reference manual.
>>>
>>> Signed-off-by: Gatien Chevallier <gatien.chevallier@foss.st.com>
>>> ---
>>>   arch/arm/boot/dts/stm32mp151.dtsi | 2737 +++++++++++++++--------------
>>>   1 file changed, 1406 insertions(+), 1331 deletions(-)
>>>   
>>> -		lptimer1: timer@40009000 {
>>> +		etzpc: etzpc@5c007000 {
>>
>> Node names should be generic.
>> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
> 
> Will change to etzpc: bus@5c007000 in V3
> 
>>
>>> +			compatible = "st,stm32mp15-sys-bus";
>>> +			reg = <0x5c007000 0x400>;
>>>   			#address-cells = <1>;
>>> -			#size-cells = <0>;
>>> -			compatible = "st,stm32-lptimer";
>>> -			reg = <0x40009000 0x400>;
>>> -			interrupts-extended = <&exti 47 IRQ_TYPE_LEVEL_HIGH>;
>>> -			clocks = <&rcc LPTIM1_K>;
>>> -			clock-names = "mux";
>>> -			wakeup-source;
>>> -			status = "disabled";
>>
>> Why entire bus is disabled? What resources do you miss?
> 
> Here, I did not want to modify the status of the nodes in the device 

By making it disabled you actually modify the status of any enabled
node. By making it enabled you do not cause any change.

> tree. Nodes that are default enabled in the SoC device tree stay enabled 
> and vice-versa.

No, because parent is disabled.

> IMO think this patch should not include these kind of 
> changes in its scope. I describe the bus and the peripherals connected 
> to it, nothing more :)

I am not proposing to change existing nodes. I am asking why new node is
being disabled (because it is a new node, isn't it?).

Best regards,
Krzysztof

