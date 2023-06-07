Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A40A9726391
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 17:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241219AbjFGPAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 11:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240878AbjFGPAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 11:00:52 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B011410F8;
        Wed,  7 Jun 2023 08:00:50 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id E2F4D5FD6C;
        Wed,  7 Jun 2023 18:00:48 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1686150048;
        bh=yZw7OBt/wiNYBcIeHQpsh+rQgqcW0pEIZQT5EamZdeA=;
        h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
        b=GTLnBO4GcM/5+3XBiS+Rz3HvXus4rlcOKXcCUw52CPge+vgRqQc2Pvlmoq/Wl5stg
         8JCEaYFOiMiNJ0Zo821HaecH+hkjm3AvF84e7Yd5CWRA3omx6Cfc4pCW/I0rlBaPxw
         nEEbDhEPFCLClETnVHhxOHFpIiZMX95TXRnlNkRKC+fOtWlhEIHgQr0DUIB6DGd2SX
         YgeLwo70TYNrN7a9DyHA7/Zi9O41buRZd4ZUD3hZmwdYiArGLkrdMqLplla7LNo+06
         ut2Y/dqr0lFEz0ulzoeD4RLVFxTByjccOwDrWgBHumfBE5cNbuo6wcpRT33Tvis8cr
         HMetNTzoQ2WMg==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Wed,  7 Jun 2023 18:00:48 +0300 (MSK)
Message-ID: <57ccf7ac-7d94-8a66-7a0e-abfe14f7df2c@sberdevices.ru>
Date:   Wed, 7 Jun 2023 17:55:53 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v1] dt-bindings: nand: meson: Fix 'nand-rb' property
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>
CC:     Liang Yang <liang.yang@amlogic.com>,
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
 <6c1973d1-38c0-6048-90ad-da2f60df8238@sberdevices.ru>
 <9105207b-0dfb-346f-422f-984cf3454f90@linaro.org>
From:   Arseniy Krasnov <avkrasnov@sberdevices.ru>
In-Reply-To: <9105207b-0dfb-346f-422f-984cf3454f90@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
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



On 07.06.2023 17:58, Krzysztof Kozlowski wrote:
> On 07/06/2023 16:52, Arseniy Krasnov wrote:
>>
>>
>> On 07.06.2023 12:36, Miquel Raynal wrote:
>>> Hi Arseniy,
>>>
>>> avkrasnov@sberdevices.ru wrote on Wed, 7 Jun 2023 12:04:29 +0300:
>>>
>>>> On 07.06.2023 12:08, Krzysztof Kozlowski wrote:
>>>>> On 07/06/2023 10:57, Arseniy Krasnov wrote:  
>>>>>>
>>>>>>
>>>>>> On 07.06.2023 11:53, Krzysztof Kozlowski wrote:  
>>>>>>> On 07/06/2023 10:40, Arseniy Krasnov wrote:  
>>>>>>>> Hello Miquel, 
>>>>>>>>
>>>>>>>> On 07.06.2023 10:58, Miquel Raynal wrote:
>>>>>>>>  
>>>>>>>>> Hi Arseniy,
>>>>>>>>>
>>>>>>>>> AVKrasnov@sberdevices.ru wrote on Tue, 6 Jun 2023 22:35:07 +0300:
>>>>>>>>>  
>>>>>>>>>> Add description of 'nand-rb' property. Use "Fixes" because this property
>>>>>>>>>> must be supported since the beginning. For this controller 'nand-rb' is
>>>>>>>>>> stored in the controller node (not in chip), because it has only single
>>>>>>>>>> r/b wire for all chips.  
>>>>>>>>>
>>>>>>>>> Sorry if I mislead you in the first place, but you could definitely
>>>>>>>>> have two chips and only one with RB wired. It needs to be defined in
>>>>>>>>> the chips.  
>>>>>>>>
>>>>>>>> Ok, so to clarify: is it ok, that in bindings this property will be placed in the
>>>>>>>> chip, but in driver, i'm trying to read it from the controller node (thus  in
>>>>>>>> dts file it will be also in controller node)?  
>>>
>>> The bindings and your driver internal representation are two different
>>> things. Anyway, as mentioned above, wiring the RB line to one die and
>>> not the other would be valid hardware design and would require the rb
>>> property to be in the chip node. Please perform a per-chip property read
>>> in the driver as well.
>>
>> Done, I resend both patches (bindings + driver update) as a single patchset. Your review comments
>> for driver code were also fixed.
> 
> No, please send new version, not the same. New version means with fixed
> comments and with patch changelog.

Sorry, Yes, I mean new version, here it is:
https://lore.kernel.org/linux-mtd/20230607145026.2899547-1-AVKrasnov@sberdevices.ru/

There I fixed bindings and tested it.

Thanks, Arseniy

> 
> Best regards,
> Krzysztof
> 
