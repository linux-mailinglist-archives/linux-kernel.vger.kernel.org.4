Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9E8C6FEE97
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 11:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237106AbjEKJWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 05:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232984AbjEKJWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 05:22:16 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC37835A5
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 02:22:14 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id DE3145FD42;
        Thu, 11 May 2023 12:22:12 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1683796932;
        bh=S3C/qd36a5XSWTl3tC3h99nhsCKhX8Zq+qQB/zjZvlc=;
        h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
        b=ZB4QzxQRBTsoJVA/f5PB1ldAygQmuHcwnHOETvUTSAeBg0e6DZVDkxZdYxFMStzqa
         re/PdjM4VZtVFsrGTdMPTCugwiX0zOGazaOpligQJImJ05p9Gy91BUvq6sedcZspFo
         hMwMRNdTGsELKxlludhffXL7tr1dfqIblip5OVD2cHNWGOmvLrF8vlfitlc+ekMajR
         TVMQgKZ95YUk4U730bOHTTJO4NWs+Bb2UWPS56/6FgY6q5O3XfdoDl1my2I/BAoz58
         IbcEWqs0wX8g1NxBhCBCvRHVv/OD+z37PNVhH0OtDHMKX4Bdk8HOdA5piGZlY/484O
         GeSfp4uycrxHg==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Thu, 11 May 2023 12:22:11 +0300 (MSK)
Message-ID: <dd25efa3-e46a-e857-d355-53330a8a4181@sberdevices.ru>
Date:   Thu, 11 May 2023 12:17:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v3 6/6] mtd: rawnand: meson: rename node for chip select
Content-Language: en-US
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Liang Yang <liang.yang@amlogic.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Yixun Lan <yixun.lan@amlogic.com>, <oxffffaa@gmail.com>,
        <kernel@sberdevices.ru>, <linux-mtd@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20230510110835.26115-1-AVKrasnov@sberdevices.ru>
 <20230510110835.26115-7-AVKrasnov@sberdevices.ru>
 <CAFBinCAbTuNGEG13f71F8vhN3yGce+kkYJ7PHMpZbh8DzSapJg@mail.gmail.com>
 <20230510225359.061c2df6@xps-13>
 <6918ed54-3929-4832-1e93-6eb55b75c82b@sberdevices.ru>
 <20230511111204.0b0b3d70@xps-13>
From:   Arseniy Krasnov <avkrasnov@sberdevices.ru>
In-Reply-To: <20230511111204.0b0b3d70@xps-13>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH02.sberdevices.ru (172.16.1.5) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/05/11 05:14:00 #21258391
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11.05.2023 12:12, Miquel Raynal wrote:
> Hi Arseniy,
> 
> avkrasnov@sberdevices.ru wrote on Thu, 11 May 2023 11:59:07 +0300:
> 
>> On 10.05.2023 23:53, Miquel Raynal wrote:
>>
>> Hello Martin, Miquel
>>
>>> Hi Martin & Arseniy,
>>>
>>> martin.blumenstingl@googlemail.com wrote on Wed, 10 May 2023 22:40:37
>>> +0200:
>>>   
>>>> Hello Arseniy,
>>>>
>>>> On Wed, May 10, 2023 at 1:13 PM Arseniy Krasnov
>>>> <AVKrasnov@sberdevices.ru> wrote:  
>>>>>
>>>>> This renames node with values for chip select from "reg" to "cs". It is
>>>>> needed because when OTP access is enabled on the attached storage, MTD
>>>>> subsystem registers this storage in the NVMEM subsystem. NVMEM in turn
>>>>> tries to use "reg" node in its own manner, supposes that it has another
>>>>> layout. All of this leads to device initialization failure.    
>>>> In general: if we change the device-tree interface (in this case:
>>>> replacing a "reg" with a "cs" property) the dt-bindings have to be
>>>> updated as well.  
>>>
>>> True, and I would add, bindings should not be broken.  
>>
>> I see, that's true. That is bad way to change bindings.
>>
>>>   
>>>> Documentation/devicetree/bindings/mtd/nand-controller.yaml and
>>>> Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml show
>>>> that the chip select of a NAND chip is specified with a "reg"
>>>> property.  
>>>
>>> All NAND controller binding expect the chip-select to be in the
>>> 'reg' property, very much like a spi device would use reg to store the
>>> cs as well: the reg property tells you how you address the device.
>>>
>>> I also fully agree with Martin's comments below. Changing reg is likely
>>> a wrong approach :)
>>>   
>>>> Also the code has to be backwards compatible with old .dtbs.
>>>>  
>>>>> Example:
>>>>>
>>>>> [...] nvmem mtd0-user-otp: nvmem: invalid reg on /soc/bus@ffe00000/...
>>>>> [...] mtd mtd0: Failed to register OTP NVMEM device
>>>>> [...] meson-nand ffe07800.nfc: failed to register MTD device: -22
>>>>> [...] meson-nand ffe07800.nfc: failed to init NAND chips
>>>>> [...] meson-nand: probe of ffe07800.nfc failed with error -22    
>>>> This is odd - can you please share your definition of the &nfc node?  
>>
>> Sure, here it is:
>>
>> mtd_nand: nfc@7800 {                            
>> 	compatible = "amlogic,meson-axg-nfc";
>> 	...
>> 	nand@0 {                                
>>         	reg = <0>;
>>         };
>> }
>>
>> I checked, that 'nand_set_flash_node()' is called with 'nand@0' and i suppose
>> that it is correct (as You mentioned below). But, 'nvmem_add_cells_from_of()' is called
>> with parent: 'nfc@7800', then it iterates over its childs, e.g. 'nand@0' and thus i get such
>> situation. I guess, that 'nvmem_add_cells_from_of()' must be called with 'nand@0' ?
> 
> We recently had issues with nvmem parsing, but I believe a mainline
> kernel should now be perfectly working on this regard. What version of
> the Linux kernel are you using?

My current version is:

VERSION = 6                                                             
PATCHLEVEL = 2                                                          
SUBLEVEL = 0                                                            
EXTRAVERSION = -rc8 

Fix was in drivers/nvmem/* ?

Thanks, Arseniy

> 
> Thanks,
> Miquèl
