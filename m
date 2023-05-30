Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9295715E86
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 14:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231450AbjE3MJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 08:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231362AbjE3MJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 08:09:02 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED61FC5;
        Tue, 30 May 2023 05:09:00 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34UC4pTN018239;
        Tue, 30 May 2023 14:08:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=eUMt/DGvSnsVrLlt9wTQ7XbXUJ6l9bqRdAwrT9NXRl4=;
 b=gpY60mVqFAHm5rhYyUhnApTQy+VI+kpHjEhL+RL0V2FdWiHUyjZb48b4pLS6qiNbGX2e
 8xG4XR6+yUNpNSeUxA4EXa5JjMMkmNjj5IK73Vel8PP7cYDEwSL0b7/tylFqnodu4hur
 fbTNPB4qVeEaXOjcwJERDAbMS+VHSlHWumhHWNtGtSfgWnexxbyY9outi7zR0CxkGOB4
 PPVL1rjtBiY/OfGpBt6JBbHG3PcHaoPvvt9Zf3zcy80AcRq+f+/mewrlw4x+tQTT9vFl
 zWUaCpiAUxiejXCqZ3+nZTRv+EaoIv/xBqq7cZpZoZgOpY4PQaXDVZztTUYO6JQAj1Yq hw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3qwdm5hhgj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 May 2023 14:08:32 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5F0C610002A;
        Tue, 30 May 2023 14:08:30 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 3839E21ED5D;
        Tue, 30 May 2023 14:08:30 +0200 (CEST)
Received: from [10.201.21.93] (10.201.21.93) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Tue, 30 May
 2023 14:08:29 +0200
Message-ID: <4308327f-d2e2-e9a2-6add-5e0352d3f1e2@foss.st.com>
Date:   Tue, 30 May 2023 14:08:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 02/11] pinctrl: stm32: add stm32mp257 pinctrl support
Content-Language: en-US
To:     Conor Dooley <conor.dooley@microchip.com>
CC:     Conor Dooley <conor@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>, <soc@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>
References: <20230529162034.20481-1-alexandre.torgue@foss.st.com>
 <20230529162034.20481-3-alexandre.torgue@foss.st.com>
 <20230529-enrich-clammy-14b498baf09f@spud>
 <879b7689-5663-28b5-9431-2fdd243ffff2@foss.st.com>
 <20230530-payday-gravity-45a26bd7f2dc@wendy>
From:   Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20230530-payday-gravity-45a26bd7f2dc@wendy>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.21.93]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-30_08,2023-05-30_01,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/30/23 10:56, Conor Dooley wrote:
> On Tue, May 30, 2023 at 10:38:30AM +0200, Alexandre TORGUE wrote:
>> Hi Conor
>>
>> On 5/29/23 20:04, Conor Dooley wrote:
>>> On Mon, May 29, 2023 at 06:20:25PM +0200, Alexandre Torgue wrote:
>>>> Add stm32mp257 pinctrl support.
>>>> diff --git a/drivers/pinctrl/stm32/pinctrl-stm32.h b/drivers/pinctrl/stm32/pinctrl-stm32.h
>>>> index e0c31c4c8bca..5e5de92ddd58 100644
>>>> --- a/drivers/pinctrl/stm32/pinctrl-stm32.h
>>>> +++ b/drivers/pinctrl/stm32/pinctrl-stm32.h
>>>> @@ -24,6 +24,9 @@
>>>>    #define STM32MP_PKG_AB		BIT(1)
>>>>    #define STM32MP_PKG_AC		BIT(2)
>>>>    #define STM32MP_PKG_AD		BIT(3)
>>>> +#define STM32MP_PKG_AI		BIT(8)
>>>> +#define STM32MP_PKG_AK		BIT(10)
>>>> +#define STM32MP_PKG_AL		BIT(11)
>>>
>>> Mainly out of curiosity, why have you go duplicate defines for these?
>>
>> Mainly to fit with available packages for various STM32 MPU. Currently MP1
>> SoCs are available with packages AB/AC/AD and MP2 series with AI/AK/AL but
>> in the future we could have package AB/AC/AD/AI available for a particular
>> SoC and then I need to anticipate this case.
> 
> Sorry, what I meant was "why have you got defines for these in this
> header, when there is an existing set in
> include/dt-bindings/pinctrl/stm32-pinfunc.h?".

Ok, I see. To be honest I do it as we did in the past for STM32 MCU and 
MP1 products. We had this discussion maybe 5 or 6 years ago about the 
fact to include or not the "dt-bindings" file in the stm32 drivers. I 
don't remember exactly the rational behind our choice. It is something 
that we could improve for all our STM32 products. Sorry for this 
imprecise answer.

Alex


> 
> Cheers,
> Conor.
> 

