Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51F8270FA9F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 17:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235171AbjEXPmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 11:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236782AbjEXPmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 11:42:00 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7885DE5F;
        Wed, 24 May 2023 08:41:23 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34OCHa9r031503;
        Wed, 24 May 2023 17:39:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=pFQA71vTmXlhs+z5x4AEKVl+aBjRGHsJvL9B84qGPfQ=;
 b=AiNiFLBZ/K+BBZpvJ1QyxuxUstPKLo8KBB80A3y+ObcuDc3A4q4itJjc5LZ3wq9dJ6yb
 S1lPA1RoFlOd6gAazPh07r1wnl3KzJZYQMP9WiUx0zb3HczZ8QUnPhmRPilTRxC2jK7U
 FfaxnrALsPdcqeCgdtujOkllkCZIZCaY8xuKBIbQ3UiuzS+oFA8sgm7XtoV+02eUi+4e
 2vO1I4BEAOpkBb9D7saYaKWKKt2FI1O0hJaCdKPHpzAKuAiXIGznNbJX0u01nF7OSwQ+
 mh1o++Jo1VM+5r2SDaNWpI+i7l9ULoNaU1kUtbVIYicqUVbQWomCN34uVxn2BlZi9Btw pw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3qrtgv1xa9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 May 2023 17:39:34 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C7CA710002A;
        Wed, 24 May 2023 17:39:33 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B9B2A23150D;
        Wed, 24 May 2023 17:39:33 +0200 (CEST)
Received: from [10.252.20.36] (10.252.20.36) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Wed, 24 May
 2023 17:39:33 +0200
Message-ID: <5bb496d0-6dc1-6ba3-6126-6429037ecf5a@foss.st.com>
Date:   Wed, 24 May 2023 17:39:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 7/8] ARM: dts: stm32: adopt generic iio bindings for adc
 channels on dhcor-drc
Content-Language: en-US
To:     Marek Vasut <marex@denx.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     <kernel@dh-electronics.com>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20230524133918.1439516-1-olivier.moysan@foss.st.com>
 <20230524133918.1439516-8-olivier.moysan@foss.st.com>
 <cc7a0a1a-31bb-92f4-6365-5e0c4a4bc85c@denx.de>
From:   Olivier MOYSAN <olivier.moysan@foss.st.com>
In-Reply-To: <cc7a0a1a-31bb-92f4-6365-5e0c4a4bc85c@denx.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.252.20.36]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-24_11,2023-05-24_01,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marek,

On 5/24/23 15:54, Marek Vasut wrote:
> On 5/24/23 15:39, Olivier Moysan wrote:
>> Use STM32 ADC generic bindings instead of legacy bindings on
>> DHCOR DRC Compact board.
>>
>> The STM32 ADC specific binding to declare channels has been deprecated,
>> hence adopt the generic IIO channels bindings, instead.
>> The STM32MP151 device tree now exposes internal channels using the
>> generic binding. This makes the change mandatory here to avoid a mixed
>> use of legacy and generic binding, which is not supported by the driver.
>>
>> Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
>> ---
>>   .../dts/stm32mp15xx-dhcor-drc-compact.dtsi    | 28 ++++++++++++++++---
>>   1 file changed, 24 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/stm32mp15xx-dhcor-drc-compact.dtsi 
>> b/arch/arm/boot/dts/stm32mp15xx-dhcor-drc-compact.dtsi
>> index 39af79dc654c..92d906bfd5d7 100644
>> --- a/arch/arm/boot/dts/stm32mp15xx-dhcor-drc-compact.dtsi
>> +++ b/arch/arm/boot/dts/stm32mp15xx-dhcor-drc-compact.dtsi
>> @@ -57,15 +57,35 @@ &adc {    /* X11 ADC inputs */
>>       status = "okay";
>>       adc1: adc@0 {
> 
> 
> I sent similar patch recently too:
> 
> [PATCH] ARM: dts: stm32: Update to generic ADC channel binding on DHSOM 
> systems
> 
> But I needed to add #address-cells/#size-cells here and to adc@100, 
> otherwise DTB checker was complaining . Did you run DTB check and was it 
> OK on your side ?

The first patch in this serie adds the #address-cells/#size-cells to the 
  SoC DT. So, there is no need to add them later in the board DT.

I can send a v2 with your patch (after removing the cells properties 
from the patch). Having all the patches in the same serie, will help 
avoiding sequencing problems.

Do you agree with this ?

BRs
Olivier

> 
>> -        st,adc-channels = <0 1 6>;
>> -        st,min-sample-time-nsecs = <5000>;
>>           status = "okay";
>> +        channel@0 {
>> +            reg = <0>;
>> +            st,min-sample-time-ns = <5000>;
>> +        };
>> +        channel@1 {
>> +            reg = <1>;
>> +            st,min-sample-time-ns = <5000>;
>> +        };
>> +        channel@6 {
>> +            reg = <6>;
>> +            st,min-sample-time-ns = <5000>;
>> +        };
>>       };
> 
> [...]
