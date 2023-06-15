Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A520C731C56
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 17:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344670AbjFOPUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 11:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240856AbjFOPT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 11:19:59 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91326107;
        Thu, 15 Jun 2023 08:19:58 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35FCIhx0021879;
        Thu, 15 Jun 2023 17:19:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=JBhEQ1HO2ejCLfpB19AwgOlNqtqOQiA2AZp9z8Cz/1E=;
 b=Kz7aSIl0ySOWsOrs46XZZhgzfeJbL9QUl4Wam435CzpizWNt/RYmMamsl0S8WCu96vGj
 iwDNO7TF8gK+N71HgX6/9ylUTHJGKyhE43XGmaCFemfOXw7xIhOZ1aNan8l0EKDimGBQ
 sLplos3q/o8VvEqnC03HmfRvOQNzH1z7B42J1iYx43fpygidsIOHF2qko+iDUI3DbIM7
 FXmPZda05/qalAjzKXZ+IRbnhtim1uGMSTb3PiXUrm8I43cCOtI4ROYQyE8Ncmm9D7Ts
 RMTyPePi+ItanfQ/4oF2TBONq2gGzk8OSA5x1LUVBYwgFqFgDEPIcuo4iCcZZ6L/nFLJ 9w== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3r7y8sjjhe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Jun 2023 17:19:27 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0522410002A;
        Thu, 15 Jun 2023 17:19:27 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id F062223152C;
        Thu, 15 Jun 2023 17:19:26 +0200 (CEST)
Received: from [10.201.21.210] (10.201.21.210) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Thu, 15 Jun
 2023 17:19:23 +0200
Message-ID: <266de9f5-826a-c1bf-be8d-11f5e27c87dc@foss.st.com>
Date:   Thu, 15 Jun 2023 17:19:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/6] dt-bindings: mmc: mmci: Add st,stm32mp25-sdmmc2
 compatible
Content-Language: en-US
From:   Yann Gautier <yann.gautier@foss.st.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Christophe Kerello <christophe.kerello@foss.st.com>,
        <linux-kernel@vger.kernel.org>, Marek Vasut <marex@denx.de>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Xiang wangx <wangxiang@cdjrlc.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230615092001.1213132-1-yann.gautier@foss.st.com>
 <20230615092001.1213132-2-yann.gautier@foss.st.com>
 <CAPDyKFqJsqmNzeRg8hj55yUEMSycOWsmKVKsMWk4Qu7Y8_dNzg@mail.gmail.com>
 <3b6781cb-8f59-e70a-bcf8-9fb48fa47cbf@foss.st.com>
In-Reply-To: <3b6781cb-8f59-e70a-bcf8-9fb48fa47cbf@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.201.21.210]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-15_11,2023-06-15_01,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/15/23 17:16, Yann Gautier wrote:
> On 6/15/23 15:20, Ulf Hansson wrote:
>> On Thu, 15 Jun 2023 at 11:20, Yann Gautier <yann.gautier@foss.st.com> 
>> wrote:
>>>
>>> For STM32MP25, we'll need to distinguish how is managed the delay block.
>>> This is done through a new comptible dedicated for this SoC, as the
>>> delay block registers are located in SYSCFG peripheral.
>>>
>>> Signed-off-by: Yann Gautier <yann.gautier@foss.st.com>
>>> ---
>>>   Documentation/devicetree/bindings/mmc/arm,pl18x.yaml | 6 ++++++
>>>   1 file changed, 6 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/mmc/arm,pl18x.yaml 
>>> b/Documentation/devicetree/bindings/mmc/arm,pl18x.yaml
>>> index 1c96da04f0e53..e47b3418b6c77 100644
>>> --- a/Documentation/devicetree/bindings/mmc/arm,pl18x.yaml
>>> +++ b/Documentation/devicetree/bindings/mmc/arm,pl18x.yaml
>>> @@ -59,6 +59,12 @@ properties:
>>>             - const: st,stm32-sdmmc2
>>>             - const: arm,pl18x
>>>             - const: arm,primecell
>>> +      - description: Entry for STMicroelectronics variant of PL18x for
>>> +          STM32MP25. This dedicated compatible is used by bootloaders.
>>
>> What does this last sentence mean? Can we drop it?
> 
> Hi Ulf,
> 
> I just copied (and added "for STM32MP25") what was done for STM32MP1x:
>        - description: Entry for STMicroelectronics variant of PL18x.
>            This dedicated compatible is used by bootloaders.
>          items:
>            - const: st,stm32-sdmmc2
>            - const: arm,pl18x
>            - const: arm,primecell
>        - description: Entry for STMicroelectronics variant of PL18x for
>            STM32MP25. This dedicated compatible is used by bootloaders.
>          items:
>            - const: st,stm32mp25-sdmmc2
>            - const: arm,pl18x
>            - const: arm,primecell
> 
> 
> Should I remove (or adapt) both descriptions?
> 
> 
> Best regards,
> Yann
> 

At the time the patch was done it was really just used by bootloaders.
But as it is now used in the driver for delay block, I should remove the 
second sentence.


Yann

>>
>>> +        items:
>>> +          - const: st,stm32mp25-sdmmc2
>>> +          - const: arm,pl18x
>>> +          - const: arm,primecell
>>>
>>>     clocks:
>>>       description: One or two clocks, the "apb_pclk" and the "MCLK"
>>> -- 
>>> 2.25.1
>>>
>>
>> Kind regards
>> Uffe
> 

