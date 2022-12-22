Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FABB654348
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 15:42:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbiLVOmi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 09:42:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235652AbiLVOmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 09:42:36 -0500
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AAF8DF3F;
        Thu, 22 Dec 2022 06:42:34 -0800 (PST)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BMBwOVt016862;
        Thu, 22 Dec 2022 15:42:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=fvpymYp2FaznQd80RWNDR540iqdoNsFsg4q4JG4xgdM=;
 b=4EyEl9gJxslTyAXas03y9REGd114PsRPmOT7sEDyBdDWau0nXDoMFF2PEtrUEBz7rkgJ
 s2BnWgge9zOGTqtASq5myo4o+Ckh7iP8HvqglMjKpMYzFNnDGeTvr94W7qSKgCWKZv99
 MnMLdJ2/XkJ2T1HgVOtUI1H72ry5h3Kr3/s/SQxu4ctYvLsOyffxD9nC3u8TmLxNFiIx
 S9LNR4EOzVl2vNViUWeygBy0mMpRLqAQIUIG3ZmM0RRQtXiXayzu/RUP9r3TdAVZF6pr
 QZ6ehYf+MaYqa2Gz0xTZSOwcDv9BT0yyAkU7Sv5nnAeijnYzxOUeQrkvvOYFmrTZvSNc Ug== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3mh605wnnw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Dec 2022 15:42:14 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 164F1100059;
        Thu, 22 Dec 2022 15:42:13 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 37A75231DC2;
        Thu, 22 Dec 2022 15:42:10 +0100 (CET)
Received: from [10.201.21.217] (10.201.21.217) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.13; Thu, 22 Dec
 2022 15:42:09 +0100
Message-ID: <0bff5b2d-2837-57cb-5434-58158acc1483@foss.st.com>
Date:   Thu, 22 Dec 2022 15:42:09 +0100
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
From:   Gatien CHEVALLIER <gatien.chevallier@foss.st.com>
In-Reply-To: <2e7c901c-e322-ded6-b170-6d2436d74c0f@kernel.org>
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

Hello,


On 12/22/22 11:30, Krzysztof Kozlowski wrote:
> On 21/12/2022 18:30, Gatien Chevallier wrote:
>> The STM32 System Bus is an internal bus on which devices are connected.
>> ETZPC is a peripheral overseeing the firewall bus that configures
>> and control access to the peripherals connected on it.
>>
>> For more information on which peripheral is securable, please read
>> the STM32MP15 reference manual.
>>
>> Signed-off-by: Gatien Chevallier <gatien.chevallier@foss.st.com>
>> ---
>>   arch/arm/boot/dts/stm32mp151.dtsi | 2737 +++++++++++++++--------------
>>   1 file changed, 1406 insertions(+), 1331 deletions(-)
>>   
>> -		lptimer1: timer@40009000 {
>> +		etzpc: etzpc@5c007000 {
> 
> Node names should be generic.
> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

Will change to etzpc: bus@5c007000 in V3

> 
>> +			compatible = "st,stm32mp15-sys-bus";
>> +			reg = <0x5c007000 0x400>;
>>   			#address-cells = <1>;
>> -			#size-cells = <0>;
>> -			compatible = "st,stm32-lptimer";
>> -			reg = <0x40009000 0x400>;
>> -			interrupts-extended = <&exti 47 IRQ_TYPE_LEVEL_HIGH>;
>> -			clocks = <&rcc LPTIM1_K>;
>> -			clock-names = "mux";
>> -			wakeup-source;
>> -			status = "disabled";
> 
> Why entire bus is disabled? What resources do you miss?

Here, I did not want to modify the status of the nodes in the device 
tree. Nodes that are default enabled in the SoC device tree stay enabled 
and vice-versa. IMO think this patch should not include these kind of 
changes in its scope. I describe the bus and the peripherals connected 
to it, nothing more :)

> 
>> +			#size-cells = <1>;
>> +			feature-domain-controller;
>> +			#feature-domain-cells = <2>;
>> +			ranges;
>>   
> Best regards,
> Krzysztof
> 

Best regards,
Gatien
