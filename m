Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB1366CC625
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 17:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233549AbjC1PYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 11:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233258AbjC1PX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 11:23:59 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C698EF745;
        Tue, 28 Mar 2023 08:22:31 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32SEBd7o005936;
        Tue, 28 Mar 2023 17:21:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=3sl3gaodW7BicjGmVlR6sK/D2fcnxp6E1ErIi0k9bhc=;
 b=IgjZwH/52DBT+sjCMLfoF+gi2dHoas0bL/boWHnDG1mnLKJ1Nluxd0FmEpbDEiObgsAB
 q3ZhS60MZil9FfQGpL0g/Y9RsCEJAfhmXDtHtBvnNqTfAKWQ4S3PAdVOhHBEeaplTMUP
 WUHBL9eweB2bontmSdbnNTdnm5OJDTpJe0lS8U/Znx7HdhsPcFqSyGIiUMnUzhB/sAj+
 7/Z5OEuYYkotU+mLsWxa+lBviRYPCMo6V0xISmymDx2DlCuPb6SzgUEkGrqlTeCxP5nx
 tQXLgRIfHW2BQAtvlIhQDTFiT1+5BM/AxfuDdiJ0re0cLPjaMyjlAhHt6ERFtWKrJ+r3 8g== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3pk5xkjq9q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Mar 2023 17:21:10 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C77A310002A;
        Tue, 28 Mar 2023 17:21:09 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C1C252194CB;
        Tue, 28 Mar 2023 17:21:09 +0200 (CEST)
Received: from [10.201.20.168] (10.201.20.168) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Tue, 28 Mar
 2023 17:21:09 +0200
Message-ID: <50e8d0ee-fe6f-7e31-98f0-ea4eceb597d6@foss.st.com>
Date:   Tue, 28 Mar 2023 17:21:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/7] ARM: dts: stm32: change USART1 clock to an SCMI clock
 on stm32mp15 boards
To:     Alexandre TORGUE <alexandre.torgue@foss.st.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20230327152948.274743-1-valentin.caron@foss.st.com>
 <20230327152948.274743-2-valentin.caron@foss.st.com>
 <5c67d003-c893-8540-a971-6954a57399e5@foss.st.com>
Content-Language: en-US
From:   Valentin CARON <valentin.caron@foss.st.com>
In-Reply-To: <5c67d003-c893-8540-a971-6954a57399e5@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.201.20.168]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-28_02,2023-02-09_01
X-Spam-Status: No, score=-0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

I think this patch is useless.
I will send you a V2 without.

Thank you,
Valentin

On 3/28/23 14:02, Alexandre TORGUE wrote:
> Hi Valentin
>
> On 3/27/23 17:29, Valentin Caron wrote:
>> On ST stm32mp15 boards, change clock of USART1 node to SCMI clock
>> "CK_SCMI_USART1"
>
> I'll change commit title and message as your patch doesn't target 
> STM43MP15 boards but STM32MP15 SCMI boards.
>
> Cheers
> Alex
>
>
>
>> Signed-off-by: Valentin Caron <valentin.caron@foss.st.com>
>> ---
>>   arch/arm/boot/dts/stm32mp157a-dk1-scmi.dts | 4 ++++
>>   arch/arm/boot/dts/stm32mp157c-dk2-scmi.dts | 4 ++++
>>   arch/arm/boot/dts/stm32mp157c-ed1-scmi.dts | 4 ++++
>>   arch/arm/boot/dts/stm32mp157c-ev1-scmi.dts | 4 ++++
>>   4 files changed, 16 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/stm32mp157a-dk1-scmi.dts 
>> b/arch/arm/boot/dts/stm32mp157a-dk1-scmi.dts
>> index e539cc80bef8..5c8164c10e46 100644
>> --- a/arch/arm/boot/dts/stm32mp157a-dk1-scmi.dts
>> +++ b/arch/arm/boot/dts/stm32mp157a-dk1-scmi.dts
>> @@ -77,3 +77,7 @@ &rng1 {
>>   &rtc {
>>       clocks = <&scmi_clk CK_SCMI_RTCAPB>, <&scmi_clk CK_SCMI_RTC>;
>>   };
>> +
>> +&usart1 {
>> +    clocks = <&scmi_clk CK_SCMI_USART1>;
>> +};
>> diff --git a/arch/arm/boot/dts/stm32mp157c-dk2-scmi.dts 
>> b/arch/arm/boot/dts/stm32mp157c-dk2-scmi.dts
>> index 97e4f94b0a24..2c9a207a9d49 100644
>> --- a/arch/arm/boot/dts/stm32mp157c-dk2-scmi.dts
>> +++ b/arch/arm/boot/dts/stm32mp157c-dk2-scmi.dts
>> @@ -83,3 +83,7 @@ &rng1 {
>>   &rtc {
>>       clocks = <&scmi_clk CK_SCMI_RTCAPB>, <&scmi_clk CK_SCMI_RTC>;
>>   };
>> +
>> +&usart1 {
>> +    clocks = <&scmi_clk CK_SCMI_USART1>;
>> +};
>> diff --git a/arch/arm/boot/dts/stm32mp157c-ed1-scmi.dts 
>> b/arch/arm/boot/dts/stm32mp157c-ed1-scmi.dts
>> index 9cf0a44d2f47..21c8169f0e82 100644
>> --- a/arch/arm/boot/dts/stm32mp157c-ed1-scmi.dts
>> +++ b/arch/arm/boot/dts/stm32mp157c-ed1-scmi.dts
>> @@ -82,3 +82,7 @@ &rng1 {
>>   &rtc {
>>       clocks = <&scmi_clk CK_SCMI_RTCAPB>, <&scmi_clk CK_SCMI_RTC>;
>>   };
>> +
>> +&usart1 {
>> +    clocks = <&scmi_clk CK_SCMI_USART1>;
>> +};
>> diff --git a/arch/arm/boot/dts/stm32mp157c-ev1-scmi.dts 
>> b/arch/arm/boot/dts/stm32mp157c-ev1-scmi.dts
>> index 3b9dd6f4ccc9..0084abbeb60e 100644
>> --- a/arch/arm/boot/dts/stm32mp157c-ev1-scmi.dts
>> +++ b/arch/arm/boot/dts/stm32mp157c-ev1-scmi.dts
>> @@ -88,3 +88,7 @@ &rng1 {
>>   &rtc {
>>       clocks = <&scmi_clk CK_SCMI_RTCAPB>, <&scmi_clk CK_SCMI_RTC>;
>>   };
>> +
>> +&usart1 {
>> +    clocks = <&scmi_clk CK_SCMI_USART1>;
>> +};
>
