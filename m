Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3DC618472
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 17:30:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231827AbiKCQag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 12:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231324AbiKCQaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 12:30:22 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98694B92;
        Thu,  3 Nov 2022 09:30:20 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2A3GToek119565;
        Thu, 3 Nov 2022 11:29:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1667492990;
        bh=tku/OEvVMYCVyJUwEFWbSTgXMuBEfZMv78bmcEijKEU=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=NI9urWluRQ1mAozq+guJV0WCseYHWaz89rZOHQku5axa2KGRwPtoY4XRk7RoRWeuO
         Z/WYOnoY/Oho88F4rkakWLjh2voQYoM8ihJl8I0SX6Mf4QR8UjnQ+83fce1TkajChi
         goB8VhRG2859EkhvsRTDnQIxkmlnTTjfIadXe+pY=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2A3GToL9072450
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 3 Nov 2022 11:29:50 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Thu, 3 Nov
 2022 11:29:50 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Thu, 3 Nov 2022 11:29:50 -0500
Received: from [10.250.32.80] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2A3GTnWQ003709;
        Thu, 3 Nov 2022 11:29:49 -0500
Message-ID: <67f9ce4b-1ed6-fc41-c133-1fbafb743830@ti.com>
Date:   Thu, 3 Nov 2022 11:29:49 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v4 7/9] ARM: dts: nspire: Use MATRIX_KEY macro for
 linux,keymap
Content-Language: en-US
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
CC:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Daniel Tang <dt.tangr@gmail.com>,
        Fabian Vogt <fabian@ritter-vogt.de>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20221101215804.16262-1-afd@ti.com>
 <20221101215804.16262-8-afd@ti.com>
 <CAKdAkRTQ2bjQEn1HM=ZMHdC8Goyf1rUDNfMkNK3jMA2CR-t4eg@mail.gmail.com>
From:   Andrew Davis <afd@ti.com>
In-Reply-To: <CAKdAkRTQ2bjQEn1HM=ZMHdC8Goyf1rUDNfMkNK3jMA2CR-t4eg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/2/22 11:07 PM, Dmitry Torokhov wrote:
> Hi Andrew,
> 
> On Tue, Nov 1, 2022 at 2:59 PM Andrew Davis <afd@ti.com> wrote:
>>
>> This looks better and allows us to see the row and column numbers
>> more easily. Switch to this macro here.
>>
>> Signed-off-by: Andrew Davis <afd@ti.com>
>> ---
>>   arch/arm/boot/dts/nspire-clp.dts | 90 ++++++++++++++++++++++++--------
>>   arch/arm/boot/dts/nspire-cx.dts  | 90 ++++++++++++++++++++++++--------
>>   arch/arm/boot/dts/nspire-tp.dts  | 90 ++++++++++++++++++++++++--------
>>   3 files changed, 204 insertions(+), 66 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/nspire-clp.dts b/arch/arm/boot/dts/nspire-clp.dts
>> index f52f38c615886..916ede0c2499c 100644
>> --- a/arch/arm/boot/dts/nspire-clp.dts
>> +++ b/arch/arm/boot/dts/nspire-clp.dts
>> @@ -6,32 +6,78 @@
>>    */
>>   /dts-v1/;
>>
>> +#include <dt-bindings/input/input.h>
>> +
>>   /include/ "nspire-classic.dtsi"
>>
>>   &keypad {
>>          linux,keymap = <
>> -       0x0000001c      0x0001001c      0x00020039
>> -       0x0004002c      0x00050034      0x00060015
>> -       0x0007000b      0x0008002d      0x01000033
>> -       0x0101004e      0x01020011      0x01030004
>> -       0x0104002f      0x01050003      0x01060016
>> -       0x01070002      0x01080014      0x02000062
>> -       0x0201000c      0x0202001f      0x02030007
>> -       0x02040013      0x02050006      0x02060010
>> -       0x02070005      0x02080019      0x03000027
>> -       0x03010037      0x03020018      0x0303000a
>> -       0x03040031      0x03050009      0x03060032
>> -       0x03070008      0x03080026      0x04000028
>> -       0x04010035      0x04020025      0x04040024
>> -       0x04060017      0x04080023      0x05000028
>> -       0x05020022      0x0503001b      0x05040021
>> -       0x0505001a      0x05060012      0x0507006f
>> -       0x05080020      0x0509002a      0x0601001c
>> -       0x0602002e      0x06030068      0x06040030
>> -       0x0605006d      0x0606001e      0x06070001
>> -       0x0608002b      0x0609000f      0x07000067
>> -       0x0702006a      0x0704006c      0x07060069
>> -       0x0707000e      0x0708001d      0x070a000d
>> +               MATRIX_KEY(0,  0, 0x1c)
>> +               MATRIX_KEY(0,  1, 0x1c)
>> +               MATRIX_KEY(0,  2, 0x39)
> 
> Can this also be switched over to using KEY_* macros to describe the
> keycodes emitted?
> 

That's going to be done in a follow up patch. This change here was
done mechanically, but moving to KEY_* might need to be double
checked by hand since some of these do not seem to map how one
would expect to the function on the keypad.

Thanks,
Andrew
