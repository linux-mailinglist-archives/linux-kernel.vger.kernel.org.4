Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D40ED674539
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 22:47:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbjASVrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 16:47:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231264AbjASVp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 16:45:29 -0500
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86485A5786;
        Thu, 19 Jan 2023 13:32:18 -0800 (PST)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-4fda31c3351so17149517b3.11;
        Thu, 19 Jan 2023 13:32:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tmK/TW0pH5LDv04GPJxLaF0OPEGlwFRwVsAuWtfqOhI=;
        b=guyAqcRx/i66bLarO4MYebn02MEewoWzMIWaEOppXqob9tf8hrzkld/U3qE769jZcA
         UX6/8FPeDvOMwjszzGjCPKClB9wErnPmXlPplXnjFD6sCAn8hnXvlZcu3hMMiK1eodgg
         UYDHh5GfC79I4iNxxT2Iw1xaCVJ6dwJUy12FLADWypmFpqTLy1X7E39Yh6h+PXIm/77j
         UshKsEdKF+PEWrCQii7QfQx3AdayPDRqYxKJneOBCxZnvIPohqOI4RLuHUlT73f/RCr8
         Yfm35b17o/GmJ288L+b1/OsIENKagFsx6jY/FqUHotgqwo1TN1013KZH9zlJ41N8z9WT
         knKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tmK/TW0pH5LDv04GPJxLaF0OPEGlwFRwVsAuWtfqOhI=;
        b=EICHxYm9FUEkdKI2WrEUqMJ9tmBSMIB0maji/2MFHW/xzv12+FfQmcljGtZZ+j4F0M
         o54NRWAeLrxOKD68cIKAkM5kM/yfu5kxZY2r8vzHvy8CnxcQW1qNJdOxzvHtEL5lhKwx
         FkRYEVcEu7BkfHl1iGKJTImW+r3VGeCPjX7s48wwVL4Zo2Sixq6M5tGar/jwhaOThA6E
         mcXxZBR50lKlADipDLwb1HszyIxd87MThxxMBRq+KY8QDo9QrxxitkoNDYPblA6DlvXx
         gLBKOYrOryKzaJhVSJDFZWUcQF2fDLK7hicQG6umualfyeeDwvXjbCp7RdQ6H/gf1aPq
         dwDA==
X-Gm-Message-State: AFqh2kpFHmsYx0niZRu/KufComqE7eTsZkGoGM6IwHB323mRMMg/hRzk
        QT5stWfN8lYV8Uhtf6wMgT5+eRdDA1qQYA==
X-Google-Smtp-Source: AMrXdXsnwiwu/B/N4cwiew5q8WuarEoUUagOMk7p67iPh5lZ4l9nruRbEWsu+obrowCol1kVzk5HSg==
X-Received: by 2002:a0d:fb07:0:b0:4fb:9c00:f03d with SMTP id l7-20020a0dfb07000000b004fb9c00f03dmr1807643ywf.39.1674163937655;
        Thu, 19 Jan 2023 13:32:17 -0800 (PST)
Received: from [10.4.10.38] (pool-108-26-182-112.bstnma.fios.verizon.net. [108.26.182.112])
        by smtp.gmail.com with ESMTPSA id br38-20020a05620a462600b00706b09b16fasm4235032qkb.11.2023.01.19.13.32.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jan 2023 13:32:16 -0800 (PST)
Message-ID: <0181494e-58f2-2d22-78b2-e9399bf4552a@gmail.com>
Date:   Thu, 19 Jan 2023 16:32:15 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2] drivers/mfd: simple-mfd-i2c: Add generic compatible
Content-Language: en-US
To:     Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        lee.jones@linaro.org
References: <20221202113226.114465-1-Mr.Bossman075@gmail.com>
 <20230119175135.GA2085792-robh@kernel.org> <Y8mt6ZCMf4YZvDYA@google.com>
From:   Jesse Taube <mr.bossman075@gmail.com>
In-Reply-To: <Y8mt6ZCMf4YZvDYA@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/19/23 15:54, Lee Jones wrote:
> On Thu, 19 Jan 2023, Rob Herring wrote:
> 
>> On Fri, Dec 02, 2022 at 06:32:26AM -0500, Jesse Taube wrote:
>>> Some devices may want to use this driver without having a specific
>>> compatible string. Add a generic compatible string to allow this.
>>
>> What devices need this?
>>
>> Is that no specific compatible string at all or just in the kernel?
>> Because the former definitely goes against DT requirements. The latter
>> enables the former without a schema.
>>
>>>
>>> Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
>>> ---
>>>   drivers/mfd/simple-mfd-i2c.c | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/mfd/simple-mfd-i2c.c b/drivers/mfd/simple-mfd-i2c.c
>>> index f4c8fc3ee463..0bda0dd9276e 100644
>>> --- a/drivers/mfd/simple-mfd-i2c.c
>>> +++ b/drivers/mfd/simple-mfd-i2c.c
>>> @@ -73,6 +73,7 @@ static const struct simple_mfd_data silergy_sy7636a = {
>>>   };
>>>   
>>>   static const struct of_device_id simple_mfd_i2c_of_match[] = {
>>> +	{ .compatible = "simple-mfd-i2c-generic" },
>>
>> Simple and generic? There is no such device. Anywhere.
>>
>> This is also not documented which is how I found it (make
>> dt_compatible_check).
I will write docs if needed.
But this should be reverted or dropped rather than
>> documented IMO.
Hi Rob, sorry for the disturbance. The reason I submitted this patch is 
this driver is generic and can be used by many different devices. Adding 
a generic compatible handle allows device tree writers avoid editing the 
  C source. I also will be submitting device trees that use this in the 
future if added.
Thanks,
Jesse Taube
> 
> I thought it would be better than having a huge list here.
> 
> Devices should *also* be allocated a specific compatible string.
> 
> $ git grep simple-mfd -- arch
> 
