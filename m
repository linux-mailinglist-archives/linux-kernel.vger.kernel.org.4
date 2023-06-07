Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 840E4726381
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 16:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238619AbjFGO5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 10:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240595AbjFGO5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 10:57:48 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C66E91FDB;
        Wed,  7 Jun 2023 07:57:29 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id AE6045FD6E;
        Wed,  7 Jun 2023 17:57:27 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1686149847;
        bh=c5e9Hn2iWEoovV4OiRRedc1P1r4+v4qAhT08M7pHODc=;
        h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
        b=gAaEepNtKegJU7Wc0IZhBJxXUjdudfDS2bXbuTPi2rcMrWr4upfpX+yvwDlMlTdMG
         Newa/obL3r7plfg8OhFB7PwIcHtM1bnyZoKxCpHUDQggc0B/Nb4j0xL/ew1/A2Pyuq
         DbnyxuePczlzcMcz9Px0V4rBOhnoapxGEXO12SsfxNt2s55T0Xa3qf70AejXZTBm+B
         F7t1h9PUFWIQE+iAPINfqpNze08/oD3YeebSpID4U/atjAMZiqiZQ6skdKuB/qxc0f
         1cXBq6Ew3jLIX0Oc1R4E19jQVNzyQEgo+iDII+8fjiR9pGG0OtTFiJ0YH+VoOc0Atr
         pMCYg1N2lDF4Q==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Wed,  7 Jun 2023 17:57:27 +0300 (MSK)
Message-ID: <6c1973d1-38c0-6048-90ad-da2f60df8238@sberdevices.ru>
Date:   Wed, 7 Jun 2023 17:52:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v1] dt-bindings: nand: meson: Fix 'nand-rb' property
Content-Language: en-US
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Liang Yang <liang.yang@amlogic.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        <oxffffaa@gmail.com>, <kernel@sberdevices.ru>,
        <linux-mtd@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20230606193507.35024-1-AVKrasnov@sberdevices.ru>
 <20230607095802.3adcd4f9@xps-13>
 <166bdc27-f77c-9076-f866-180cfa5bff76@sberdevices.ru>
 <08da4e86-433a-7d2e-25ff-ffa24221abdf@linaro.org>
 <835a3587-1e0f-64d7-1d1a-b639ae8b7307@sberdevices.ru>
 <2ca6e619-1d57-8fff-6176-9ee890e0d167@linaro.org>
 <5ca9eb2b-4bc8-5883-a029-3eeca905fe6e@sberdevices.ru>
 <20230607113605.50a992bb@xps-13>
From:   Arseniy Krasnov <avkrasnov@sberdevices.ru>
In-Reply-To: <20230607113605.50a992bb@xps-13>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH01.sberdevices.ru (172.16.1.4) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/06/07 09:39:00 #21450961
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07.06.2023 12:36, Miquel Raynal wrote:
> Hi Arseniy,
> 
> avkrasnov@sberdevices.ru wrote on Wed, 7 Jun 2023 12:04:29 +0300:
> 
>> On 07.06.2023 12:08, Krzysztof Kozlowski wrote:
>>> On 07/06/2023 10:57, Arseniy Krasnov wrote:  
>>>>
>>>>
>>>> On 07.06.2023 11:53, Krzysztof Kozlowski wrote:  
>>>>> On 07/06/2023 10:40, Arseniy Krasnov wrote:  
>>>>>> Hello Miquel, 
>>>>>>
>>>>>> On 07.06.2023 10:58, Miquel Raynal wrote:
>>>>>>  
>>>>>>> Hi Arseniy,
>>>>>>>
>>>>>>> AVKrasnov@sberdevices.ru wrote on Tue, 6 Jun 2023 22:35:07 +0300:
>>>>>>>  
>>>>>>>> Add description of 'nand-rb' property. Use "Fixes" because this property
>>>>>>>> must be supported since the beginning. For this controller 'nand-rb' is
>>>>>>>> stored in the controller node (not in chip), because it has only single
>>>>>>>> r/b wire for all chips.  
>>>>>>>
>>>>>>> Sorry if I mislead you in the first place, but you could definitely
>>>>>>> have two chips and only one with RB wired. It needs to be defined in
>>>>>>> the chips.  
>>>>>>
>>>>>> Ok, so to clarify: is it ok, that in bindings this property will be placed in the
>>>>>> chip, but in driver, i'm trying to read it from the controller node (thus  in
>>>>>> dts file it will be also in controller node)?  
> 
> The bindings and your driver internal representation are two different
> things. Anyway, as mentioned above, wiring the RB line to one die and
> not the other would be valid hardware design and would require the rb
> property to be in the chip node. Please perform a per-chip property read
> in the driver as well.

Done, I resend both patches (bindings + driver update) as a single patchset. Your review comments
for driver code were also fixed.

> 
>>>>>
>>>>> No, because how would your DTS pass validation? I understand you did not
>>>>> test the bindings, but this will improve, right?  
>>>>
>>>> Ok, i'll follow DTS layout in the driver, "test the bindings" You mean "make dt_binding_check"?  
>>>
>>> Yes. They were sent without testing.
>>>
>>> But please also test your DTS with dtbs_check. 

Done

Thanks, Arseniy

>>
>> Got it!
>>
>> Thanks, Arseniy
>>
>>>
>>>
>>> Best regards,
>>> Krzysztof
>>>   
> 
> 
> Thanks,
> Miquèl
