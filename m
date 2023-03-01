Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86D996A73B8
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 19:44:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbjCASoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 13:44:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbjCASoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 13:44:10 -0500
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5866848E25;
        Wed,  1 Mar 2023 10:44:09 -0800 (PST)
Received: by mail-pl1-f181.google.com with SMTP id n6so13621275plf.5;
        Wed, 01 Mar 2023 10:44:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vq/pM2gYGR0/e4AUYRe9jBJWUagf30u77VubcFJBb2U=;
        b=vhUJYgCT5FG5nnq9Ii8SVcH/2/UuGMJpE/eiEQvGiYu9kS/WTe7t6bqrKKUYnBkw9O
         MUEO/3nhrV/LpJz49kqOIXBknOyHmFZ9DuODOHypQyFIPozkZpMtUvDtAgCaRT8Z3+2v
         q6Y1zc/1Fj7Lt23fjFfuuokAY+zvQL6uIzWgCISDGbjlHK3jKLuW1PLImA3C+nm0U76u
         01BO+rEIMf7XB8xO5nw68NRopo8YY9YxZJH5z+Ao1l/gXoa0adJkqdUsvNhnt6jQTg0U
         cjPlzyRXVx8jxlPBRBj5YbRMsxYni9FATJ5NKRiPDjVBT9evyE8dR00Bafp0G3fH6emy
         +20w==
X-Gm-Message-State: AO0yUKXTyHSp+6jXAyeY6Pi12buCzCYJPs2cuo/kN4sn0qIpSdI4Va/q
        SlvW+Fp5NcfWJDFYYJBslZoUfTdL+KY=
X-Google-Smtp-Source: AK7set+cvuyvXSoXcRzkQoCiSSZb21c6kZmuhb2/4pwg7iccb6QahZwOrVeAFlRxWKcl2wADAQP2KA==
X-Received: by 2002:a17:902:7293:b0:19c:d23e:52a0 with SMTP id d19-20020a170902729300b0019cd23e52a0mr6312324pll.14.1677696248642;
        Wed, 01 Mar 2023 10:44:08 -0800 (PST)
Received: from ?IPV6:2620:15c:211:201:e8e:76a3:8425:6d37? ([2620:15c:211:201:e8e:76a3:8425:6d37])
        by smtp.gmail.com with ESMTPSA id l10-20020a170902eb0a00b0019ce470b9fesm8887242plb.140.2023.03.01.10.44.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Mar 2023 10:44:07 -0800 (PST)
Message-ID: <e6518637-4e78-3935-133d-79afea67cf80@acm.org>
Date:   Wed, 1 Mar 2023 10:44:06 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/2] include: uapi: scsi: Change utp_upiu_query struct
Content-Language: en-US
To:     Arthur Simchaev <Arthur.Simchaev@wdc.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
Cc:     "beanhuo@micron.com" <beanhuo@micron.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1677078770-30994-1-git-send-email-Arthur.Simchaev@wdc.com>
 <1677078770-30994-2-git-send-email-Arthur.Simchaev@wdc.com>
 <b1f0ed44-d707-5593-7449-8a6bd23c9902@acm.org>
 <BY5PR04MB632717453EB0D403388B4F1EEDAF9@BY5PR04MB6327.namprd04.prod.outlook.com>
 <21f73bfd-1d91-106f-d3a8-eb4674c517e6@acm.org>
 <BY5PR04MB632701F87296BEE554D3F055EDAD9@BY5PR04MB6327.namprd04.prod.outlook.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <BY5PR04MB632701F87296BEE554D3F055EDAD9@BY5PR04MB6327.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/1/23 01:46, Arthur Simchaev wrote:
>>>>>    struct utp_upiu_query {
>>>>>      __u8 opcode;
>>>>>      __u8 idn;
>>>>>      __u8 index;
>>>>>      __u8 selector;
>>>>> -   __be16 reserved_osf;
>>>>> -   __be16 length;
>>>>> -   __be32 value;
>>>>> -   __be32 reserved[2];
>>>>> +   __u8 osf3;
>>>>> +   __u8 osf4;
>>>>> +   __be16 osf5;
>>>>> +   __be32 osf6;
>>>>> +   __be32 osf7;
>>>>>    };
>>>> All changes in UAPI headers must be backwards compatible. The above
>> doesn't look like a backwards compatible change to me.
>>>
>>> This API was originally invented to support ufs-bsg.
>>> AFAIK, ufs-utils is the only app that makes use of this API,
>>> and it doesn't dig into struct utp_upiu_query inner fields.
>>
>> That does not match what I see. I see that code in ufs-utils accesses
>> the 'length' and 'value' members of the above data structure.
>>
>> Please follow the rules for UAPI header files.
>>
>> Thanks,
>>
>> Bart.
> 
> You are right , my fault.
> Anyway, It just return reserved field to the struct.
> Also I can update the tool accordingly. Instead length and value fields,
> using osf5 and osf6.
> In this case we will keep it backward compatible.
> Is it OK?

Hi Arthur,

I doubt that renaming structure members is acceptable for UAPI headers. 
How about introducing a second struct next to the utp_upiu_query struct?

Thanks,

Bart.

