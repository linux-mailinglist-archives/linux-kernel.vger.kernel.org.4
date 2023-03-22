Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2966B6C4753
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 11:16:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbjCVKQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 06:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjCVKQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 06:16:50 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E26BB5B428;
        Wed, 22 Mar 2023 03:16:49 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id ew6so7637831edb.7;
        Wed, 22 Mar 2023 03:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679480208;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jpDA9uUcZvzGnD9pLQgn6VIYHngYXS5+gJ+ISFCbQ4k=;
        b=BS3B+GSSEJ0WqKPR/Ct8/TRtsDaddf81nnqiToflDBOwCObEAzue/bZloBZi6Z8T3a
         k2zTRNcyJKTzaWUNeLHH3HsejObgT34xz7bkSY+AecBkPYsEPgvXO/PS5gObiyhAxdAa
         y6W3BrbODyb1e07sODfcNIOrMw0mh6I2pmfIczHnxYaL9mnyjduX/7U4j3Q2PJtYLQJp
         Atk+N0Rlobkd0WvizQ4gOE12XkvLOLxN1WJPjE4mFvX0JVMNKNUhfom/BSJKhzaonz8N
         HH4yArtKlQOR08pyd+trd+dCllFDVuGrccSnzWiW5DnAiCJ+JtapdWKTTlDtWw6TdhsP
         M7UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679480208;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jpDA9uUcZvzGnD9pLQgn6VIYHngYXS5+gJ+ISFCbQ4k=;
        b=XYpZ9TWAjZyc+M3kOJizYaN/BYas6oz73dBkCR+wOdMcBteZJTTf3ouCKVt7i+hP7L
         HT8KTp5vPpo9TYZwfR+av+E/ljinydwsf3SOmDC0d40vuKavnh/1/OxVayY/iRgiFrIz
         7DZUCNxcUhDnbhYll0lfo3BL/gfofnizY7zWv6RWnQmAX88jlSG/Skhes05Yo8Cn/4Zz
         STLAd3gWm3Cn4YVhIp5vRu7AfH0I2hLL7y57mjJsvoj+9gIDxxRIuLvrpFbJSOgMZ7Mp
         UyGMz3dN7HMR+BJ6zeD0b33AptsIJ3d3FRBAwhO5CTs9OvdRhwMGiOxdcpqzkjAFXUjV
         S5MQ==
X-Gm-Message-State: AO0yUKUxbU3uKjWKwpwRZUEBJj/1LzWQEFr0yNTUsb68WhjSGd0il3x0
        sc2JNtH8n7/ASemlyxVABECHES/gT6w=
X-Google-Smtp-Source: AK7set9piLYg6v1I/RemGzk8hcZOPEJZSGDct+Dz8Mm8jN4Nphd/jZq6O7eXIb6Xzl+L7wPOqJ+lpw==
X-Received: by 2002:aa7:d3d4:0:b0:4fb:78a0:eabf with SMTP id o20-20020aa7d3d4000000b004fb78a0eabfmr5776830edr.29.1679480208273;
        Wed, 22 Mar 2023 03:16:48 -0700 (PDT)
Received: from [192.168.1.16] ([41.233.203.65])
        by smtp.gmail.com with ESMTPSA id b26-20020a170906195a00b00930a4e5b46bsm6930377eje.211.2023.03.22.03.16.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 03:16:47 -0700 (PDT)
Message-ID: <9e339ec0-d244-ea22-d9d8-70a76ac1bc0a@gmail.com>
Date:   Wed, 22 Mar 2023 12:16:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] staging: greybus: remove unnecessary blank line
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     gregkh@linuxfoundation.org, outreachy@lists.linux.dev,
        johan@kernel.org, elder@kernel.org, vireshk@kernel.org,
        thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        greybus-dev@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-pwm@vger.kernel.org
References: <20230322100927.28351-1-eng.mennamahmoud.mm@gmail.com>
 <369edb35-b93b-301c-fcef-8e64e5d4a122@inria.fr>
Content-Language: en-US
From:   Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
In-Reply-To: <369edb35-b93b-301c-fcef-8e64e5d4a122@inria.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On ٢٢‏/٣‏/٢٠٢٣ ١٢:١٤, Julia Lawall wrote:
>
> On Wed, 22 Mar 2023, Menna Mahmoud wrote:
>
>> Remove unnecessary blank line before struct as reported
>> by checkpatch:
>>
>> " CHECK: Please don't use multiple blank lines"
> Since there is no vX indicator, one doesn't know that this replaces some
> previous patches.

yes, sorry I missed it because I dropped the previous commits, I will 
add it.


Menna

>
> julia
>
>> Signed-off-by: Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
>> ---
>>   drivers/staging/greybus/greybus_authentication.h | 1 -
>>   drivers/staging/greybus/pwm.c                    | 1 -
>>   2 files changed, 2 deletions(-)
>>
>> diff --git a/drivers/staging/greybus/greybus_authentication.h b/drivers/staging/greybus/greybus_authentication.h
>> index 7edc7295b7ab..48b4a9794d3c 100644
>> --- a/drivers/staging/greybus/greybus_authentication.h
>> +++ b/drivers/staging/greybus/greybus_authentication.h
>> @@ -41,7 +41,6 @@
>>   #define CAP_AUTH_RESULT_CR_NO_KEY	0x03
>>   #define CAP_AUTH_RESULT_CR_SIG_FAIL	0x04
>>
>> -
>>   /* IOCTL support */
>>   struct cap_ioc_get_endpoint_uid {
>>   	__u8			uid[8];
>> diff --git a/drivers/staging/greybus/pwm.c b/drivers/staging/greybus/pwm.c
>> index 3fda172239d2..26d39e08c3b6 100644
>> --- a/drivers/staging/greybus/pwm.c
>> +++ b/drivers/staging/greybus/pwm.c
>> @@ -24,7 +24,6 @@ struct gb_pwm_chip {
>>   #define pwm_chip_to_gb_pwm_chip(chip) \
>>   	container_of(chip, struct gb_pwm_chip, chip)
>>
>> -
>>   static int gb_pwm_count_operation(struct gb_pwm_chip *pwmc)
>>   {
>>   	struct gb_pwm_count_response response;
>> --
>> 2.34.1
>>
>>
>>
