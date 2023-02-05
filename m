Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F30868B11D
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 18:37:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbjBERha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 12:37:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjBERh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 12:37:28 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E12E0193FE;
        Sun,  5 Feb 2023 09:37:25 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id d21-20020a056830005500b0068bd2e0b25bso2681024otp.1;
        Sun, 05 Feb 2023 09:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=KzQczVVwdRA/Z7vPglNFmtc/zQXF/DwmrsXVAsLwTdg=;
        b=avJOayGlLjRxU+jq/ig5PQKFbwQcxqMRd8Ye4uah8mBDRxVB572NXSwgYYfW3VEh7l
         9C758+cF3deGOsoKohyE5SVhVqdhu7Vjxdo8r404fOE9cxiw0940D5fKv13abqgkRLfW
         CW64WH9mRF7D2MZClevv/S5FWWMQMQVodLnxflqiLY+5aJNk7vKAo70f0FljfRQz+Wt1
         3ROw4ZSgOUdOTN9zIgR5N1B/yi6TVZYMQdTPW+Z37p6OeFqZONgQoqhvtLg6LNNagdLq
         4dGdyRf2ZBEwP+u3qOFqspAfYxJF4BHT7kF1923vNkwXxi+LeaS4qNMZ8m25LBFWR6Nx
         NB2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KzQczVVwdRA/Z7vPglNFmtc/zQXF/DwmrsXVAsLwTdg=;
        b=gbPprRv90XNMHF9PRhHH4tQIM1yfdSgkUNykIBfJkFnmGP1/WNdEH6Mg1LzcwXw5JS
         PKxMfQh01E9KxiUA0kovBQsz7bB/VifE19vqFvsbsmZYYx4aVY99evZQzgigKwtmn5m8
         zaQqNCz0U3CDtQttxXqkqcEIGoDmti/620knpMceJdFsAOvVLaFKgXAMkjsy2OJ+Tkkm
         y2fgozHoPS4c1nkJ8aUoCtzhnjJ9EBzH0aru7Q0jNkw/mFbSloq89F0NI2YTy+q4Bueq
         5oIcGlfG5hbOQqAyoELQTD/l3ZomFWcMoFj6uRNsH1mvkVsLkcbd+/3XOdYGtRiTQduO
         cKhg==
X-Gm-Message-State: AO0yUKW6NIhVo3NLI8cxgQF4ieCib+3uEMqRdcRNu7nwo1+W9XIonqfG
        LSY7mifNHKakzF6LuhTHo3w=
X-Google-Smtp-Source: AK7set/PMbNUNqAeQfSvfNitlbsFwkiO1hktS3+JuSXne4TE0U++RBummdiQURisHcIWvvnesUV9zw==
X-Received: by 2002:a9d:6243:0:b0:68b:c67c:5d0b with SMTP id i3-20020a9d6243000000b0068bc67c5d0bmr8130416otk.10.1675618645178;
        Sun, 05 Feb 2023 09:37:25 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x39-20020a056830246700b0068bb7bd2668sm3722805otr.73.2023.02.05.09.37.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Feb 2023 09:37:24 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <b3829a0f-ff83-651e-f78d-794565b023ec@roeck-us.net>
Date:   Sun, 5 Feb 2023 09:37:22 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] lm85: Bounds check to_sensor_dev_attr()->index usage
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20230127223744.never.113-kees@kernel.org>
 <20230128131319.GA4173006@roeck-us.net>
 <63dd8c1a.170a0220.d3456.3451@mx.google.com>
 <20230204015700.GG3089769@roeck-us.net>
 <63deaa0b.050a0220.bf1e1.6c26@mx.google.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <63deaa0b.050a0220.bf1e1.6c26@mx.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/4/23 10:55, Kees Cook wrote:
> On Fri, Feb 03, 2023 at 05:57:00PM -0800, Guenter Roeck wrote:
>> That line of argument would suggest that we should perform parameter checks
>> on each function entry all over the place, no matter if the range is known
>> to be valid or not. Maybe that is the way things are going, but I don't
>> like it at all. I have seen that kind of code before, in the telco space,
>> where it typically at least doubled code size and resulted in mediocre
>> performance, just because of a rule that mandated checking all parameters
>> at the beginning of each function.
> 
> Well, I doubt I'll be able to change your opinion of telco code, but I
> do think robustness is not an unreasonable default state for software,
> and that GCC and Clang do a pretty good job with optimization, etc.
> 
>> I assume this is just one of many many patches you plan to send to add
>> parameter checks to similar hwmon code ? I _really_ don't want to have
>> the hwmon code cluttered with such unnecessary checks.
> 
> I was trying to provide complete coverage inspired by the specific
> complaint GCC had, but this would also silence the warning:
> 
> diff --git a/drivers/hwmon/lm85.c b/drivers/hwmon/lm85.c
> index 8d33c2484755..87d2455e721f 100644
> --- a/drivers/hwmon/lm85.c
> +++ b/drivers/hwmon/lm85.c
> @@ -1106,6 +1106,7 @@ static ssize_t pwm_auto_pwm_minctl_store(struct device *dev,
>   	mutex_lock(&data->update_lock);
>   	data->autofan[nr].min_off = val;
>   	tmp = lm85_read_value(client, LM85_REG_AFAN_SPIKE1);
> +	nr = clamp_t(int, nr, 0, ARRAY_SIZE(data->autofan) - 1);
>   	tmp &= ~(0x20 << nr);
>   	if (data->autofan[nr].min_off)
>   		tmp |= 0x20 << nr;
> 
> What's happening is GCC see that "nr" is used as a shift argument, so it
> believes (not unreasonably) that this otherwise unknown value could be
> up to 32. Here we can give it the bounded range ahead of time, keeping
> it happy.
> 
I'll accept that if you also add a note clarifying that this is to silence
a gcc/clang warning.

Guenter

