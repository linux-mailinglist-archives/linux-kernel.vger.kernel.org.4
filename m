Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8DE1749530
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 08:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233295AbjGFGCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 02:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233071AbjGFGCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 02:02:19 -0400
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C29CCE;
        Wed,  5 Jul 2023 23:02:16 -0700 (PDT)
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id 1A3DA100083;
        Thu,  6 Jul 2023 09:02:13 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 1A3DA100083
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1688623333;
        bh=wyxlQ93v05b7JnZGehYFodABlKWTrWnDqvvvdm+T1GU=;
        h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
        b=oAVDgB6qfEpyHXt8qkV37x45nawz2HO0q8iki2znNLVo/rNJvLmKK3aT6FFxTDTou
         Zbbb8xYqNrqKHmcG+ibvJ1+ohOzEFH2TXYDSorhkguXSlL9Ks/Ln1k0Wh9c1gdnhlp
         ue2oI4ebNMgbMpJAKJ0N19A2Qmppbf/iG31ydiLcLFjzu3bxR4hIKrhvWN0CbWRODU
         k88q+qZ8wilDXjHRzG9SktSZFeQrES/TKk0Atug35pjL0jzxAINoq9/LqvJkDGxnqI
         LUu8rdxs9UqMff8H5pEkck+hStRhvLJFSjBk4UVcZLF7fnfTjEPCM9ZDJVLMgEYwvk
         kzmfZGCWNfc/A==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Thu,  6 Jul 2023 09:02:12 +0300 (MSK)
Received: from [192.168.0.12] (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 6 Jul 2023 09:02:06 +0300
Message-ID: <677b0b16-2bfc-46e5-6029-e3b56abcaa3c@sberdevices.ru>
Date:   Thu, 6 Jul 2023 08:57:00 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [RFC PATCH v2 1/2] dt-bindings: nand: meson: support for 512B ECC
 step size
Content-Language: en-US
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     Liang Yang <liang.yang@amlogic.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        <oxffffaa@gmail.com>, <kernel@sberdevices.ru>,
        <linux-mtd@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20230705065434.297040-1-AVKrasnov@sberdevices.ru>
 <20230705065434.297040-2-AVKrasnov@sberdevices.ru>
 <20230705093702.6c0421d7@xps-13>
 <365898fb-3719-38e0-4383-e04ccc0b475b@sberdevices.ru>
 <20230705102254.0aeb94ea@xps-13>
From:   Arseniy Krasnov <avkrasnov@sberdevices.ru>
In-Reply-To: <20230705102254.0aeb94ea@xps-13>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 178461 [Jul 05 2023]
X-KSMG-AntiSpam-Version: 5.9.59.0
X-KSMG-AntiSpam-Envelope-From: AVKrasnov@sberdevices.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 520 520 ccb018a655251011855942a2571029252d3d69a2, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;p-i-exch-sc-m01.sberdevices.ru:7.1.1,5.0.1;100.64.160.123:7.1.2;sberdevices.ru:7.1.1,5.0.1, FromAlignment: s, {Tracking_white_helo}, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/07/05 14:57:00 #21566867
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05.07.2023 11:22, Miquel Raynal wrote:
> Hi Arseniy,
> 
> avkrasnov@sberdevices.ru wrote on Wed, 5 Jul 2023 11:03:30 +0300:
> 
>> On 05.07.2023 10:37, Miquel Raynal wrote:
>>> Hi Arseniy,
>>>
>>> AVKrasnov@sberdevices.ru wrote on Wed, 5 Jul 2023 09:54:33 +0300:
>>>   
>>>> Meson NAND supports both 512B and 1024B ECC step size, so replace
>>>> 'const' for only 1024B step size with enum for both sizes.
>>>>
>>>> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>>>> ---
>>>>  Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml | 4 +++-
>>>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml b/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml
>>>> index 3bec8af91bbb..81ca8828731a 100644
>>>> --- a/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml
>>>> +++ b/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml
>>>> @@ -49,7 +49,8 @@ patternProperties:
>>>>          const: hw
>>>>  
>>>>        nand-ecc-step-size:
>>>> -        const: 1024
>>>> +        enum: [512, 1024]
>>>> +        default: 1024  
>>>
>>> I was actually wrong in my previous review, there is no strong default
>>> here as the existing binding (and code) try to use the closest
>>> parameters required by the NAND chip: we pick the "optimal"
>>> configuration. So if you don't provide any value here, we expect
>>> the strength and step size advertized by the chip to be used. This is a
>>> common default in the raw NAND subsystem.
>>>
>>> Please drop the default line, re-integrate the missing R-by tag from
>>> Rob and in a separate patch please mark nand-ecc-step-size and
>>> nand-ecc-strength mandatory if the other is provide. IOW, we expect
>>> either both, or none of them, but not a single one.  
>>
>> I see, no problem! "mandatory" means update description of both fields like:
>>
>>     description:                                                        
>>       Mandatory if nand-ecc-step-size is set.
> 
> Nope :-)
> 
> Something along:
> 
> allOf:
>   - if:
>     <nand-chip>:
>       properties:
>         contains:
>           - nand-ecc-step-size
>     then:
>       required:
>         <nand-chip>:
>           properties:
>             - nand-ecc-strength
> 
> And same with the opposite logic.

I see, thanks! And this should be for all nand chips, not only Amlogic? I mean in
nand-chip.yaml? 

I'll include it as third patch in this patchset.

Thanks, Arseniy

> 
>>
>> etc.
>>
>> ?
>>
>>>   
>>>>  
>>>>        nand-ecc-strength:
>>>>          enum: [8, 16, 24, 30, 40, 50, 60]
>>>> @@ -93,6 +94,7 @@ examples:
>>>>        nand@0 {
>>>>          reg = <0>;
>>>>          nand-rb = <0>;
>>>> +        nand-ecc-step-size = <1024>;  
>>>
>>> So in the end this line is wrong and once you get the description right
>>> as I mentioned it above, this will fail to pass
>>> `make DT_SCHEMA_FILES=Documentation/devicetree/bindings/mtd/ dt_binidng_check`
>>> Please drop it from the example, don't add the second property here,
>>> it's best to show a clean example where people stop tampering for no
>>> reason with the optimal values.  
>>
>> Ok!
>>
>> Thanks, Arseniy
>>
>>>   
>>>>        };
>>>>      };
>>>>    
>>>
>>>
>>> Thanks,
>>> Miquèl  
> 
> 
> Thanks,
> Miquèl
