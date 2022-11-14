Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86C766276FE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 09:02:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236121AbiKNICw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 03:02:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236116AbiKNICt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 03:02:49 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC381958F
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 00:02:47 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id k19so12119852lji.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 00:02:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sYOkC3lSl+MCr0UtIVqb3uN+PxWKiXCe/KSGqm7Qpw4=;
        b=DH+KqV80xgBULrXFFFSI+0ylBOGgDx3w6GbXJJk/vMUzZruaUiL2huAzlCsWiQsEqK
         CYlVQcGC2HkQFYMCuzM6iK00X4WXZUE/0snchq3BZzwgzS+gA6j8iXPaOyXQg8R8I2Qd
         c9i8w6mYogOniJ1wRzl8VK2cpeh7W8RuFAi54=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sYOkC3lSl+MCr0UtIVqb3uN+PxWKiXCe/KSGqm7Qpw4=;
        b=PJxzRyVIWpTMaIH5T702gDF/yUsPLFGTZ2oUk1bJxkTNCRs2vMf3ssHrxuxPU8p4rr
         98kJnQ8Vec8uo48J9BirhSb14drDuRg3S9D4kRpXGmm+kTrq16xzoMpD6taz9jI06Pc6
         1sB2mgQ0JV0VUlkAnXtJfGQ6KzQKpEyvxU0LtzYAaKtsacywuQA8pBMqkdLdH3b1MiBr
         /8sGLWEW9s51iPuMFDn9T2+vOy133MYFs93x4ITWwQ3cpWOItf5zW5xNVSOsDDMOyER+
         BLGPAU4uZNyKsEW9XRlkP9P3nE5qbxMiuyrnlqOZE+HoR5Gokyt0IT4tzuSkKTEcseNe
         wRng==
X-Gm-Message-State: ANoB5pkarF0BbQc5sfIIkFRTOZrW3KDJYuGkSr0AV5BJM79Sm2mUrqI2
        ZgdIzDvLYIekzpkQhgXvj9xHEg==
X-Google-Smtp-Source: AA0mqf676uYWbKGiXMXUjh0D7SVyW8ofLT9CqD+JCKE7P0nbNhtoW3TSlB7wJnQdLy+u1OmceiOUow==
X-Received: by 2002:a2e:a448:0:b0:277:1cfe:398 with SMTP id v8-20020a2ea448000000b002771cfe0398mr3439816ljn.10.1668412966059;
        Mon, 14 Nov 2022 00:02:46 -0800 (PST)
Received: from [172.16.11.74] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id a3-20020a05651c030300b002772414817esm1900919ljp.1.2022.11.14.00.02.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 00:02:45 -0800 (PST)
Message-ID: <4e98c469-cd22-a946-784c-5e0391142570@rasmusvillemoes.dk>
Date:   Mon, 14 Nov 2022 09:02:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 1/5] iio: addac: ad74413r: add spi_device_id table
Content-Language: en-US, da
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Oleksij Rempel <linux@rempel-privat.de>
References: <20221111143921.742194-1-linux@rasmusvillemoes.dk>
 <20221111143921.742194-2-linux@rasmusvillemoes.dk>
 <20221112165049.51a5f391@jic23-huawei>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <20221112165049.51a5f391@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/2022 17.50, Jonathan Cameron wrote:
> On Fri, 11 Nov 2022 15:39:17 +0100
> Rasmus Villemoes <linux@rasmusvillemoes.dk> wrote:
> 
>> Silence the run-time warning
>>
>>   SPI driver ad74413r has no spi_device_id for adi,ad74412r
>>
>> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
>> ---
>>  drivers/iio/addac/ad74413r.c | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/drivers/iio/addac/ad74413r.c b/drivers/iio/addac/ad74413r.c
>> index 899bcd83f40b..37485be88a63 100644
>> --- a/drivers/iio/addac/ad74413r.c
>> +++ b/drivers/iio/addac/ad74413r.c
>> @@ -1457,12 +1457,20 @@ static const struct of_device_id ad74413r_dt_id[] = {
>>  };
>>  MODULE_DEVICE_TABLE(of, ad74413r_dt_id);
>>  
>> +static const struct spi_device_id ad74413r_spi_id[] = {
>> +	{ .name = "ad74412r", .driver_data = (kernel_ulong_t)&ad74412r_chip_info_data },
>> +	{ .name = "ad74413r", .driver_data = (kernel_ulong_t)&ad74413r_chip_info_data },
>> +	{},
> Trivial, but prefer not to have a comma after a "NULL" terminator like this.
> It would never make sense to add anything after it in the array.

I agree and wouldn't have added it if it weren't for the existing case
in the other table.

> Now you are matching existing driver style, but I'd still rather not see more
> instances of this added.

Sure.

> Also, driver_data is not currently used. It should be because adding this
> spi_id table means the driver can be probed via various routes where
> device_get_match_data() == NULL. 

That makes sense, I think I thought that that would somehow happen
automatically. Looking through the history of similar fixes, I see that
for example 3f8dd0a7dc does indeed add code as you suggest, but
855fe49984 does not (and also doesn't add the corresponding .driver_data
initializers in the spi table). They may very well both be correct, but
looping in Oleksij for good measure.

> Hence, alongside this change you need to have a fallback to cover that case.
> Something along the lines of...
> 
> 	st->chip_info = device_get_match_data(..);
> 	if (!st->chip_info) {
> 		struct spi_device_id *id = spi_get_device_id();
> 		if (!id)
> 			return -EINVAL;
> 
> 		st->chip_info = (void *)id->driver_data;
> 		//or better yet cast to the correct type I'm just too lazy to look it up ;)
> 		if (!st->chip_info)
> 			return -EINVAL;
> 
> 	}

Thanks,
Rasmus

