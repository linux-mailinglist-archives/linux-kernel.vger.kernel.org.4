Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8AF06A85BE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 17:02:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjCBQCg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 11:02:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCBQCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 11:02:34 -0500
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BE46C647;
        Thu,  2 Mar 2023 08:02:32 -0800 (PST)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 5C9285FD13;
        Thu,  2 Mar 2023 19:02:29 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1677772949;
        bh=pH2/BwYk/ccvRyZeYLpUS9yuCtPjv0uFSqqBycYa3+w=;
        h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
        b=NrQDWL1D/S2DwS0paqi4/35Oc9QzCAYJuamgniaczeKEmMiddE+LdwvlczVH4SXkW
         reA8Rh9S6xCnBxtSx5J9ydCdvEns1EMTAT+B8bZNkMCFRgSoHZKGu8SMumvx0B6DB5
         2rwY1Ok8av/N2IMUk5H6MczJZ2swgESpmtBDYH94ZWduE5P1LtGojTylhF/aJn9fnb
         YoqLNfOPwdxdmDM2jIeUs0TsEt5BEY+QXZZLOtUH0lEVBBMd+R4/JNEXVIFGDeu20b
         Qlz0pwmRJMUZtyxiZPoDGw/52Tp97OHIElHe7jwEtJjCwTycZP/uDnbK+ZRWvTjRr9
         4nsCB4KnQb1/g==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Thu,  2 Mar 2023 19:02:28 +0300 (MSK)
Message-ID: <6a4abcc5-5246-20ac-e25b-f88ee90c1331@sberdevices.ru>
Date:   Thu, 2 Mar 2023 19:02:28 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 1/2] dt-bindings: leds: add binding for aw200xx
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     <linux-leds@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel@sberdevices.ru>
References: <20230228211046.109693-1-mmkurbanov@sberdevices.ru>
 <20230228211046.109693-2-mmkurbanov@sberdevices.ru>
 <8c3a16f6-f1fb-911b-b935-31ed8e227f8f@linaro.org>
From:   Martin Kurbanov <mmkurbanov@sberdevices.ru>
In-Reply-To: <8c3a16f6-f1fb-911b-b935-31ed8e227f8f@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH02.sberdevices.ru (172.16.1.5) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/03/02 07:22:00 #20908555
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-03-02 10:48, Krzysztof Kozlowski wrote:

>> +  For more product information please see the link below:
>> +  aw20036 - https://www.awinic.com/Public/Uploads/uploadfile/files/20200509/20200509151532_5eb65894d205a.pdf
>> +  aw20054 - https://www.awinic.com/Public/Uploads/uploadfile/files/20200509/20200509151602_5eb658b2b77cb.pdf
>> +  aw20072 - https://www.awinic.com/Public/Uploads/uploadfile/files/20200509/20200509151754_5eb659227a145.pdf
> 
> Links do not work. Error 401

They are changed the links. I will correct in the next version.

>> +  awinic,display-rows:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description:
>> +      Leds matrix size
> 
> Why do you need this property? Number of LEDs are known from the number
> of children. Matrix size is fixed in compatible, isn't it?

Number of LEDs are known, but matrix size are programmable.
Example for the aw20036, the matrix size can be 1x12, 2x12, 3x12.

-- 
Best Regards,
Kurbanov Martin

