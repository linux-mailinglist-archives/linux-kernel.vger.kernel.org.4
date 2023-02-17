Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC3C869B1CB
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 18:30:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbjBQRai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 12:30:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBQRad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 12:30:33 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E306F6EB9E
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 09:30:26 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id co2so6521580edb.13
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 09:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D3nrUk6MQuSIK0/Ry6ENPbzwEVXVXfrQ+tHO/TWp/DI=;
        b=cdMbLQgMjEI7MrcJVVeK4sVuFf3Zf+rswFP6H/PYVeT7DkD3/8lmLXSqBIEJVCeOqc
         DBtA6je5qqib2y1qXZj+PUPSVUw5NqyxOZTZd2Hpzl0n0O6r5vyR3Cbl8FMgBwYiStbl
         bvVe3CZRHaCKR8NpPhAq5Pi/LESWhqyQFg/27LX8WXnsou5wO0U0togV6sgktkQ5Vbei
         RGk1VgRJMFsLfwNUMBZvkcruE5VF6EdJSi/t3iCEs9XEDNUUx+auFOiIMED4qEtB4kne
         4uKsd1fwAA6+mTALI4cG3IJ96iwKT6blLS4rdqM/rV0UEaMO75+8aZUR+iMMTTVzRjrt
         GDpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D3nrUk6MQuSIK0/Ry6ENPbzwEVXVXfrQ+tHO/TWp/DI=;
        b=AK9Hy0S4gzdnyPQ/Ko9erbyjpVOT9DLOyN1arvfj5ZZfvFviY5YAjSbfOrvgbi9tZu
         9YmfcZO/lRpcreiJU/JjiLhvfsIwzv4vV5dbiuKDcCLJlH1f3UDTVVf8k6o6IEBtbUCd
         obavdXDRfLhPLuzvrZug7Vd9liVIZ/hZKnkN+C222H4V6nNHqY5eqQuGDxuflUFy4q15
         Q5cklFaYEExijIh1CrCUt/6mRMwmk54vgfiEWrqTjTtP3ax2pW8wRQ1TtjX37YHmmXu9
         hiNA9pO0Z1NTKZ9LLb/aCyL7B+U/u3sWpPasAweoFHlQ3gzjWBPksoJfTvtLLSBjfjkB
         A9Zw==
X-Gm-Message-State: AO0yUKW3WLaLG2/Iz74a09BF6oww9/BO1Renj4In0lxJSBQ7Y74r4xax
        JY62G4OZdeA2D80ewEMybbE=
X-Google-Smtp-Source: AK7set+rFaZCB7iQTiWhyZ5sK42Q4O9wu7ToJviN4egYvAgwaju4Q+SBThwIe7CDEApvKCRTw+ZjPg==
X-Received: by 2002:aa7:c051:0:b0:4ac:d30d:c3a3 with SMTP id k17-20020aa7c051000000b004acd30dc3a3mr1113263edo.32.1676655025359;
        Fri, 17 Feb 2023 09:30:25 -0800 (PST)
Received: from shift (pd9e2966a.dip0.t-ipconnect.de. [217.226.150.106])
        by smtp.gmail.com with ESMTPSA id gs23-20020a170906f19700b008ba326ebaffsm121213ejb.191.2023.02.17.09.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 09:30:24 -0800 (PST)
Received: from localhost ([127.0.0.1])
        by shift with esmtp (Exim 4.96)
        (envelope-from <chunkeey@gmail.com>)
        id 1pT4WA-000GNI-2L;
        Fri, 17 Feb 2023 18:30:24 +0100
Message-ID: <93a02a4c-9cba-4b39-4b3e-406a30a8e094@gmail.com>
Date:   Fri, 17 Feb 2023 18:30:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v3] nvmem: u-boot-env: align endianness of crc32 values
Content-Language: de-DE, en-US
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        INAGAKI Hiroshi <musashino.open@gmail.com>
Cc:     srinivas.kandagatla@linaro.org, linux-kernel@vger.kernel.org
References: <20230213132351.837-1-musashino.open@gmail.com>
 <d8e6135f837462a7f7cdf59e20bfc449@milecki.pl>
From:   Christian Lamparter <chunkeey@gmail.com>
In-Reply-To: <d8e6135f837462a7f7cdf59e20bfc449@milecki.pl>
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

On 2/13/23 14:37, Rafał Miłecki wrote:
> On 2023-02-13 14:23, INAGAKI Hiroshi wrote:
>> This patch fixes crc32 error on Big-Endianness system by conversion of
>> calculated crc32 value.
>>
>> Little-Endianness system:
>>
>>   obtained crc32: Little
>> calculated crc32: Little
>>
>> Big-Endianness system:
>>
>>   obtained crc32: Little
>> calculated crc32: Big
>>
>> log (APRESIA ApresiaLightGS120GT-SS, RTL8382M, Big-Endianness):
>>
>> [    8.570000] u_boot_env
>> 18001200.spi:flash@0:partitions:partition@c0000: Invalid calculated
>> CRC32: 0x88cd6f09 (expected: 0x096fcd88)
>> [    8.580000] u_boot_env: probe of
>> 18001200.spi:flash@0:partitions:partition@c0000 failed with error -22
>>
>> Fixes: f955dc144506 ("nvmem: add driver handling U-Boot environment variables")
>>
>> Signed-off-by: INAGAKI Hiroshi <musashino.open@gmail.com>
>> ---
>> v2 -> v3
>>
>> - fix sparse warning by using __le32 type and cpu_to_le32
>> - fix character length of the short commit hash in "Fixes:" tag
>>
>> v1 -> v2
>>
>> - wrong fix for sparse warning due to misunderstanding
>> - add missing "Fixes:" tag
>>
>>  drivers/nvmem/u-boot-env.c | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/nvmem/u-boot-env.c b/drivers/nvmem/u-boot-env.c
>> index 29b1d87a3c51..164bb04dfc3b 100644
>> --- a/drivers/nvmem/u-boot-env.c
>> +++ b/drivers/nvmem/u-boot-env.c
>> @@ -117,8 +117,8 @@ static int u_boot_env_parse(struct u_boot_env *priv)
>>      size_t crc32_offset;
>>      size_t data_offset;
>>      size_t data_len;
>> -    uint32_t crc32;
>> -    uint32_t calc;
>> +    __le32 crc32;
>> +    __le32 calc;
>>      size_t bytes;
>>      uint8_t *buf;
>>      int err;
> 
> This looks counter-intuitive to me, to store values on host system in
> specified endianness. I'd say we should use __le32 type only to
> represent numbers in device stored data (e.g. structs as processed by
> device).
> 
> My suggesion: leave uint32_t for local variables and use le32_to_cpu().

Hmm, this is strange. The kernel's u-boot-env driver works without any
additional changes in the le<->be department on the Big-Endian
PowerPC APM82181 WD MyBook Live NAS.

Is there something odd going on with the WD MyBook Live, or is it
the APRESIA ApresiaLightGS120GT-SS that is special?

Regards,
Christian
