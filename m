Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67E4E69BE7B
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 05:45:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbjBSEpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 23:45:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBSEpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 23:45:38 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0283012044
        for <linux-kernel@vger.kernel.org>; Sat, 18 Feb 2023 20:45:38 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id dc6so964749pfb.7
        for <linux-kernel@vger.kernel.org>; Sat, 18 Feb 2023 20:45:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WRO+djRIibrSxvhTwvDO601H9x5cmQvtHgtRKlyn26Y=;
        b=Em6R99nY10LV+04LV1tpvGe4v9ru6OQHdfcuhbC7K5WyLwwnmCZTg2J7EsnN2BMf6h
         5I4voaKp4YdM0QmhhhXssHxouW6RmATlHzMNiUti2NEERIIGElNzcFsSD1xPFufVO7OI
         IclyPYU2YYcjE5KQu61YFhuaXa7r9pqszzMtYzoCPIqltvAevJk5h97HV+5DhPotxVx+
         pxjyT0s/JuCCSNVZCMwjc2b5zgR1q1rDLpMi5+6EiGPhgDq9QMX+abFp1NlFNjna8nM5
         MOLF4k63pLGGOYSFnYQKpm0hvEGtHlo9DAVeA/yeuVgH7XLpas1QNGwyxf14OonkXVDG
         eNMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WRO+djRIibrSxvhTwvDO601H9x5cmQvtHgtRKlyn26Y=;
        b=ehRhBXhviSgxGYkQUCm7SYANyZy1+oqoj+WcaJkQknrU8XwOQBpdxDyCcY5sQld2zh
         sI96GS5W5k82OmC+1SnDrBSrLZzj61aUY5oYKyd8YE1tL8kn5DJ0iq+UfrtVmCfNvUZv
         LciZo0SDjPUrWLEaBTg7A14unSpAoiY5HgohUfRlvPPKLvrdHE6BK+y1RG51aBRApLP7
         qV4njGp/i9ezqA/2UNalApnTpVytsRf/e4fq34pByruVD/w/uchb+CCNyxhH/foURGs2
         W61Hba6w1+GUaH6mH9g8LmiwOU47J+7FIOvI9S8etxvIcq4GfUZzCQ7k+3RemhIqYFk/
         U2yA==
X-Gm-Message-State: AO0yUKWATmnu5WANWd9rm4TUFduiNH7UqqrKb+d9HVolhxoO8G0KF9ed
        N+t9ZnCvr6Ge3516VF6KqhlQsEv0JvE=
X-Google-Smtp-Source: AK7set8o0aTWb9qKbJ6RPKW9/L7zq9BhBFiZV+FiYAIY91ExzPYgICPHnJxWSp6NIzMP0O9ey32rJw==
X-Received: by 2002:a62:1850:0:b0:5a8:ac17:fa6c with SMTP id 77-20020a621850000000b005a8ac17fa6cmr5960729pfy.15.1676781937398;
        Sat, 18 Feb 2023 20:45:37 -0800 (PST)
Received: from ?IPV6:240b:12:500:6500:c9c8:1e6f:495e:8dfe? ([240b:12:500:6500:c9c8:1e6f:495e:8dfe])
        by smtp.gmail.com with ESMTPSA id e23-20020a62ee17000000b005907664a3eesm5299562pfi.125.2023.02.18.20.45.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Feb 2023 20:45:37 -0800 (PST)
Message-ID: <1276b70d-9461-4a4c-08f7-2bed42557fd6@gmail.com>
Date:   Sun, 19 Feb 2023 13:45:33 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v3] nvmem: u-boot-env: align endianness of crc32 values
To:     Christian Lamparter <chunkeey@gmail.com>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Cc:     srinivas.kandagatla@linaro.org, linux-kernel@vger.kernel.org
References: <20230213132351.837-1-musashino.open@gmail.com>
 <d8e6135f837462a7f7cdf59e20bfc449@milecki.pl>
 <93a02a4c-9cba-4b39-4b3e-406a30a8e094@gmail.com>
Content-Language: en-US
From:   INAGAKI Hiroshi <musashino.open@gmail.com>
In-Reply-To: <93a02a4c-9cba-4b39-4b3e-406a30a8e094@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christian,

On 2023/02/18 2:30, Christian Lamparter wrote:
> On 2/13/23 14:37, Rafał Miłecki wrote:
>> On 2023-02-13 14:23, INAGAKI Hiroshi wrote:
>>> This patch fixes crc32 error on Big-Endianness system by 
>>> conversion of
>>> calculated crc32 value.
>>>
>>> Little-Endianness system:
>>>
>>>   obtained crc32: Little
>>> calculated crc32: Little
>>>
>>> Big-Endianness system:
>>>
>>>   obtained crc32: Little
>>> calculated crc32: Big
>>>
>>> log (APRESIA ApresiaLightGS120GT-SS, RTL8382M, Big-Endianness):
>>>
>>> [    8.570000] u_boot_env
>>> 18001200.spi:flash@0:partitions:partition@c0000: Invalid calculated
>>> CRC32: 0x88cd6f09 (expected: 0x096fcd88)
>>> [    8.580000] u_boot_env: probe of
>>> 18001200.spi:flash@0:partitions:partition@c0000 failed with error -22
>>>
>>> Fixes: f955dc144506 ("nvmem: add driver handling U-Boot 
>>> environment variables")
>>>
>>> Signed-off-by: INAGAKI Hiroshi <musashino.open@gmail.com>
>>> ---
>>> v2 -> v3
>>>
>>> - fix sparse warning by using __le32 type and cpu_to_le32
>>> - fix character length of the short commit hash in "Fixes:" tag
>>>
>>> v1 -> v2
>>>
>>> - wrong fix for sparse warning due to misunderstanding
>>> - add missing "Fixes:" tag
>>>
>>>  drivers/nvmem/u-boot-env.c | 8 ++++----
>>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/nvmem/u-boot-env.c b/drivers/nvmem/u-boot-env.c
>>> index 29b1d87a3c51..164bb04dfc3b 100644
>>> --- a/drivers/nvmem/u-boot-env.c
>>> +++ b/drivers/nvmem/u-boot-env.c
>>> @@ -117,8 +117,8 @@ static int u_boot_env_parse(struct u_boot_env 
>>> *priv)
>>>      size_t crc32_offset;
>>>      size_t data_offset;
>>>      size_t data_len;
>>> -    uint32_t crc32;
>>> -    uint32_t calc;
>>> +    __le32 crc32;
>>> +    __le32 calc;
>>>      size_t bytes;
>>>      uint8_t *buf;
>>>      int err;
>>
>> This looks counter-intuitive to me, to store values on host system in
>> specified endianness. I'd say we should use __le32 type only to
>> represent numbers in device stored data (e.g. structs as processed by
>> device).
>>
>> My suggesion: leave uint32_t for local variables and use 
>> le32_to_cpu().
>
> Hmm, this is strange. The kernel's u-boot-env driver works without any
> additional changes in the le<->be department on the Big-Endian
> PowerPC APM82181 WD MyBook Live NAS.
>
> Is there something odd going on with the WD MyBook Live, or is it
> the APRESIA ApresiaLightGS120GT-SS that is special?
>

This additional changes are for resolving sparse warnings. Of course 
it's working fine on my device with the previous changes, but due to 
the warning it wasn't merged into the mainline and needs to be resolved.

> Regards,
> Christian

Thanks,
Hiroshi
