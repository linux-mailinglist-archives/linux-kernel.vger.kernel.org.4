Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65FB36544B3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 16:57:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbiLVP5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 10:57:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231337AbiLVP5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 10:57:40 -0500
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 486CF6595;
        Thu, 22 Dec 2022 07:57:38 -0800 (PST)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BMBtNKr000553;
        Thu, 22 Dec 2022 16:57:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=mLYXc+UkL0/McAv2NjSFthugo2hDHA7ShsQrJDZkdzY=;
 b=PLCWdqKDQisgqSJ03zlXhazC8iRzwxddQMvUBmI9FXvnNdG1nWVnN7BLtK6EDluZ4Cdb
 juRG3sKI87ZBnWgh2cj7MlckRA6ti/0eNbvJ8KhgOvlHkeBYGGGeWb63DJXUsIc8tAS+
 /sKqpwsObDg1J8okoppDHkpknt1j93V7vCnwWdug+kF7zJELbgUhBEClc49KcIrQtG+4
 dAnEncMu/4+fa8DGql/va3xQ5Ye4xuLz4H4OlvaJajJNymsLXp7YQgAqmceuKQ18pSkB
 B/t+5aRVcDKouVfsJfCPuvYGB5rHHFeuG4eab6cIJx8slE8/9UmfLf/JHSkeEecF7z36 Zg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3mh42pxhse-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Dec 2022 16:57:16 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7A70310004D;
        Thu, 22 Dec 2022 16:57:11 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 14D67235F39;
        Thu, 22 Dec 2022 16:57:03 +0100 (CET)
Received: from [10.201.21.217] (10.201.21.217) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.13; Thu, 22 Dec
 2022 16:57:02 +0100
Message-ID: <18d0eca0-838e-92c3-4188-d8dcf480ef6e@foss.st.com>
Date:   Thu, 22 Dec 2022 16:57:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [RFC PATCH 6/7] ARM: dts: stm32: add ETZPC as a system bus for
 STM32MP15x boards
Content-Language: en-US
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        <alexandre.torgue@foss.st.com>, <robh+dt@kernel.org>,
        <Oleksii_Moisieiev@epam.com>, <linus.walleij@linaro.org>,
        <gregkh@linuxfoundation.org>
CC:     <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <loic.pallardy@st.com>,
        <devicetree@vger.kernel.org>, <mark.rutland@arm.com>,
        <arnd@arndb.de>
References: <20221221173055.11719-1-gatien.chevallier@foss.st.com>
 <20221221173055.11719-7-gatien.chevallier@foss.st.com>
 <2e7c901c-e322-ded6-b170-6d2436d74c0f@kernel.org>
 <0bff5b2d-2837-57cb-5434-58158acc1483@foss.st.com>
 <041b77e0-40c5-e724-e5d9-f1da64d5e684@kernel.org>
From:   Gatien CHEVALLIER <gatien.chevallier@foss.st.com>
In-Reply-To: <041b77e0-40c5-e724-e5d9-f1da64d5e684@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.21.217]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-22_08,2022-12-22_03,2022-06-22_01
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/22/22 16:21, Krzysztof Kozlowski wrote:
> On 22/12/2022 15:42, Gatien CHEVALLIER wrote:
>> Hello,
>>
>>
>> On 12/22/22 11:30, Krzysztof Kozlowski wrote:
>>> On 21/12/2022 18:30, Gatien Chevallier wrote:
>>>> The STM32 System Bus is an internal bus on which devices are connected.
>>>> ETZPC is a peripheral overseeing the firewall bus that configures
>>>> and control access to the peripherals connected on it.
>>>>
>>>> For more information on which peripheral is securable, please read
>>>> the STM32MP15 reference manual.
>>>>
>>>> Signed-off-by: Gatien Chevallier <gatien.chevallier@foss.st.com>
>>>> ---
>>>>    arch/arm/boot/dts/stm32mp151.dtsi | 2737 +++++++++++++++--------------
>>>>    1 file changed, 1406 insertions(+), 1331 deletions(-)
>>>>    
>>>> -		lptimer1: timer@40009000 {
>>>> +		etzpc: etzpc@5c007000 {
>>>
>>> Node names should be generic.
>>> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
>>
>> Will change to etzpc: bus@5c007000 in V3
>>
>>>
>>>> +			compatible = "st,stm32mp15-sys-bus";
>>>> +			reg = <0x5c007000 0x400>;
>>>>    			#address-cells = <1>;
>>>> -			#size-cells = <0>;
>>>> -			compatible = "st,stm32-lptimer";
>>>> -			reg = <0x40009000 0x400>;
>>>> -			interrupts-extended = <&exti 47 IRQ_TYPE_LEVEL_HIGH>;
>>>> -			clocks = <&rcc LPTIM1_K>;
>>>> -			clock-names = "mux";
>>>> -			wakeup-source;
>>>> -			status = "disabled";
>>>
>>> Why entire bus is disabled? What resources do you miss?
>>
>> Here, I did not want to modify the status of the nodes in the device
> 
> By making it disabled you actually modify the status of any enabled
> node. By making it enabled you do not cause any change.
> 
>> tree. Nodes that are default enabled in the SoC device tree stay enabled
>> and vice-versa.
> 
> No, because parent is disabled.
> 
>> IMO think this patch should not include these kind of
>> changes in its scope. I describe the bus and the peripherals connected
>> to it, nothing more :)
> 
> I am not proposing to change existing nodes. I am asking why new node is
> being disabled (because it is a new node, isn't it?).

I'm sorry but the ETZPC node is not disabled. The patch is quite hard to 
read as I'm moving all securable/MCU isolation capable peripheral nodes 
under ETZPC.

 >>>> -			#size-cells = <0>;
 >>>> -			compatible = "st,stm32-lptimer";
 >>>> -			reg = <0x40009000 0x400>;
 >>>> -			interrupts-extended = <&exti 47 IRQ_TYPE_LEVEL_HIGH>;
 >>>> -			clocks = <&rcc LPTIM1_K>;
 >>>> -			clock-names = "mux";
 >>>> -			wakeup-source;
 >>>> -			status = "disabled";

are part of lptimer1 node, which is moved under ETZPC. ETZPC node is 
default enabled.

Result after patch is:

etzpc: etzpc@5c007000 {
	compatible = "st,stm32mp15-sys-bus";
	reg = <0x5c007000 0x400>;
	#address-cells = <1>;
	#size-cells = <1>;
	feature-domain-controller;
	#feature-domain-cells = <2>;
	ranges;

	timers2: timer@40000000 {
(...)

Or do I misunderstand you comment?

> 
> Best regards,
> Krzysztof
> 
