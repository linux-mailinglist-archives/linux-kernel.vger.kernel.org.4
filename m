Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71A1E69CC20
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 14:34:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231782AbjBTNel (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 08:34:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231534AbjBTNeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 08:34:36 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D99661ABEA
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 05:34:33 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id na9-20020a17090b4c0900b0023058bbd7b2so1364398pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 05:34:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NUCp9YKX3Ddj4Bg7opa4+in3GKumx6vDOOx0A/l+ix4=;
        b=a9IL9qr4LSzTWiFKY+QVq7Xg5jSSsXCNC0HpV4+cqfkKgdjoanuZOrtm6uuWOHzhIX
         Oo63RYhBNg1JbCYQXVsPnoBqitJrB4OraKADhnH0Vkvc6q8Kd8qBY7P7SROcscAjsUNe
         8f+vqIjDJs3xOpXznAk3X1kQQOPZjIpKtbcQb5bpPHZHZ9r+1m1MhGNnt0GgOrHGCeDG
         wjACjipOW8nJpqwBc78iBihx3M6pJrTnyOlCgcNcQAhRTubXuv5dr6g/9OiP3oVc81vl
         cFMr4Bk3jZmxreJW9V1XLvkA/AoJ9PhmbATW2Q7d26IHzsrIw9pN9O40EWjFdCHiCBsG
         +Xlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NUCp9YKX3Ddj4Bg7opa4+in3GKumx6vDOOx0A/l+ix4=;
        b=ygcWpjq1sfGBdJ13qxyw4Ax7Kpxs6BDVEOyx0vXC+BSP3LvARCSbgC6vGAxPbDlWUd
         NS5MgUSkdYCbm/0GEFMd3lHGjYbEl7wxb89r0sZmBTxY5ZrzOsCpPVAjCMwQUsaczHP2
         m70iKZtpiSIhzThgrNnxFVqWS9xTn0XanHMRkFkN0m0CKTyRlUdP3DcC1C5Mjt5W7LV4
         zSRzTv5cGE+C4UpxWeHlfENnYQQc5f6/bsvLyGcXOxiA51+Bs93rvQT3AZ/9hOkIdpTR
         DyiGsXgs9PhKoDTAYCNePSWyicfZBTVJaUpSjNFGAbK6obfJVA9gtbZUB8y6oIirZsbp
         o43g==
X-Gm-Message-State: AO0yUKX5QY2tA2pmJCuHx7PA5ntQj1+1XbDgRHQqEw1xwwCz22JOlfht
        6ZArwRCUJAQL0IYvgAUGq3A=
X-Google-Smtp-Source: AK7set/47cWvnjU2FyUkux0Z38yfw1dJwfb+NScN1HFB4ME2hKp1WINTzoaONO1P87eciJUglqaQoQ==
X-Received: by 2002:a05:6a20:a008:b0:bc:8b20:97b7 with SMTP id p8-20020a056a20a00800b000bc8b2097b7mr11837306pzj.28.1676900073261;
        Mon, 20 Feb 2023 05:34:33 -0800 (PST)
Received: from [192.168.1.39] (M014008005000.v4.enabler.ne.jp. [14.8.5.0])
        by smtp.gmail.com with ESMTPSA id d4-20020a170902c18400b00198f9fa23a3sm3019088pld.287.2023.02.20.05.34.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Feb 2023 05:34:32 -0800 (PST)
Message-ID: <ebaa2a4e-0e35-7210-42a7-8cfffefc5db4@gmail.com>
Date:   Mon, 20 Feb 2023 22:34:10 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3] nvmem: u-boot-env: align endianness of crc32 values
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        srinivas.kandagatla@linaro.org
Cc:     chunkeey@gmail.com, linux-kernel@vger.kernel.org
References: <20230213132351.837-1-musashino.open@gmail.com>
 <724bcb6f-775d-a7be-d47c-447dc8ac4c19@milecki.pl>
Content-Language: en-US
From:   INAGAKI Hiroshi <musashino.open@gmail.com>
In-Reply-To: <724bcb6f-775d-a7be-d47c-447dc8ac4c19@milecki.pl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafał,

On 2023/02/20 17:01, Rafał Miłecki wrote:
> On 13.02.2023 14:23, INAGAKI Hiroshi wrote:
>> @@ -117,8 +117,8 @@ static int u_boot_env_parse(struct u_boot_env 
>> *priv)
>>       size_t crc32_offset;
>>       size_t data_offset;
>>       size_t data_len;
>> -    uint32_t crc32;
>> -    uint32_t calc;
>> +    __le32 crc32;
>> +    __le32 calc;
>>       size_t bytes;
>>       uint8_t *buf;
>>       int err;
>> @@ -152,11 +152,11 @@ static int u_boot_env_parse(struct u_boot_env 
>> *priv)
>>           data_offset = offsetof(struct u_boot_env_image_broadcom, 
>> data);
>>           break;
>>       }
>> -    crc32 = le32_to_cpu(*(__le32 *)(buf + crc32_offset));
>> +    crc32 = cpu_to_le32(*(uint32_t *)(buf + crc32_offset));
>>       crc32_data_len = priv->mtd->size - crc32_data_offset;
>>       data_len = priv->mtd->size - data_offset;
>>   -    calc = crc32(~0, buf + crc32_data_offset, crc32_data_len) ^ 
>> ~0L;
>> +    calc = cpu_to_le32(crc32(~0, buf + crc32_data_offset, 
>> crc32_data_len) ^ ~0L);
>
> Can you see what happens on BE device if instead of this whole patch 
> you
> just replace crc32() in above line with crc32_le()?

Thank you for your suggestion.
I tried it, but "calc" still has big-endianness value and needs to be 
converted to little-endianness value.

log:

[    8.725024] u_boot_env 
18001200.spi:flash@0:partitions:partition@c0000: Invalid calculated 
CRC32: 0x88cd6f09 (expected: 0x096fcd88)

"crc32()" seems to be the same as "crc32_le()" [0].

[0]: 
https://elixir.bootlin.com/linux/v5.15.94/source/include/linux/crc32.h#L66

>
>
>>       if (calc != crc32) {
>>           dev_err(dev, "Invalid calculated CRC32: 0x%08x (expected: 
>> 0x%08x)\n", calc, crc32);
>>           err = -EINVAL;

Thanks,
Hiroshi
