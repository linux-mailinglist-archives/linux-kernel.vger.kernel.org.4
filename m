Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E39976B64BA
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 11:06:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjCLKGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 06:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbjCLKGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 06:06:18 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 132867ABD
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 03:06:09 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id g10so8695687eda.1
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 03:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678615567;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aV+kJBet/buNFIhXzGjSgBkhcUdA9Gm7ve97F0LmOIk=;
        b=DTrZXm3F2Ta+pPrJURrqVVFG8NNKdZQc7cvzaJYWGDa6hl/JMpfJ7+qr6pBFNbvh8+
         5tuLtE4J4HdVotJQaO1yIkCjvGtfmsS4llGFi88cKzRR41/2l3OK9sTmz9xjS10g3qPc
         vWwK8Vuftk70WeWLU6elp4NcFBPhBnSbAA2NS2NT8Ae0lXw8CZA+l1cTQNTDYwoDhbo0
         yVN8O7C9CTWD+HP14dqP133/PrZYyZt9CW3BqKEcqqv0DYLyrLShTQLQiz2yWZWDBYPz
         PohfP9qAYziG3WYUnW5ZS30oSZjI3FoTna6ByoXkEzPZAJlBF1dU9e0hXR2lUteheFoc
         wggQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678615567;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aV+kJBet/buNFIhXzGjSgBkhcUdA9Gm7ve97F0LmOIk=;
        b=hRYMImi/Bex4DZgZZmI8tXuDKN7otwiL7tnImQF0wnDzn7tEpV3x8M5zryjWLJv5g0
         W2lm5c1lEldGVRqU0yKVkfp+8AaOdDkOOEnerZahJ7P9efwQ3n4usxmDA+CnDacIKCFm
         OwkV3WTKgESoIDRm2g5XdYw3oMIsK3BMwtvsPfYA4IvlyHAcQ5bK5Pd/m6Sv7ax7b7eQ
         Druo6WAdVwzLyS/pGEi7O79dLAlGNEKaw/leHWBbsduiF4njqbhXaYLqN4nQ3Uy7qG7/
         icm+7vuLe+NyYV2fpz4/Kl4umPKjqFU6rKq7kjUgFOxuacAqmywUm1JI0zsI1RI3hbOJ
         SSTw==
X-Gm-Message-State: AO0yUKUM1aKsW6570ERBl9XWewbkHQ+uZGAUXFm341Q+yQ4kElOzYVIp
        wuwTj79EwPMx2c4odVa8KNGo7KXnOBSJ5aVkPYk=
X-Google-Smtp-Source: AK7set/Ie5L873rUBadNNyZph3dFtaaab0uv6A+aA0VFB83y/tpy4le60VyqHIbg0vMwHV/xVrKH6g==
X-Received: by 2002:a05:6402:70d:b0:4fa:c9ea:b691 with SMTP id w13-20020a056402070d00b004fac9eab691mr3319374edx.6.1678615567537;
        Sun, 12 Mar 2023 03:06:07 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:d9f6:3e61:beeb:295a? ([2a02:810d:15c0:828:d9f6:3e61:beeb:295a])
        by smtp.gmail.com with ESMTPSA id g2-20020a1709062da200b008cf377e8795sm2049206eji.199.2023.03.12.03.06.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Mar 2023 03:06:07 -0700 (PDT)
Message-ID: <7fd46f69-1a38-b9a8-a82e-cb2f7c5e8686@linaro.org>
Date:   Sun, 12 Mar 2023 11:06:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/2] tpm: st33zp24: Mark ACPI and OF related data as maybe
 unused
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230311173541.262949-1-krzysztof.kozlowski@linaro.org>
 <ZA0wlYIh3KRV/QjW@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <ZA0wlYIh3KRV/QjW@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/03/2023 02:53, Jarkko Sakkinen wrote:
> On Sat, Mar 11, 2023 at 06:35:40PM +0100, Krzysztof Kozlowski wrote:
>> The driver can be compile tested with !CONFIG_OF or !CONFIG_ACPI making
>>
>>   drivers/char/tpm/st33zp24/i2c.c:141:34: error: ‘of_st33zp24_i2c_match’ defined but not used [-Werror=unused-const-variable=]
>>   drivers/char/tpm/st33zp24/spi.c:258:34: error: ‘of_st33zp24_spi_match’ defined but not used [-Werror=unused-const-variable=]
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Please also briefly describe the change.

I lost there piece of word. Should be:

"The driver can be compile tested with !CONFIG_OF or !CONFIG_ACPI making
unused."

This is self-descriptive, I think. We allow it to be unused. Solution is
trivial and so common, I am really not sure what's the benefit to repeat
the code in the commit msg 100 times... The code is really obvious, thus
the commit msg focuses on the "why".

> 
>> ---
>>  drivers/char/tpm/st33zp24/i2c.c | 4 ++--
>>  drivers/char/tpm/st33zp24/spi.c | 4 ++--
>>  2 files changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/char/tpm/st33zp24/i2c.c b/drivers/char/tpm/st33zp24/i2c.c
>> index c4d0b744e3cc..2d28f55ef490 100644
>> --- a/drivers/char/tpm/st33zp24/i2c.c
>> +++ b/drivers/char/tpm/st33zp24/i2c.c
>> @@ -138,13 +138,13 @@ static const struct i2c_device_id st33zp24_i2c_id[] = {
>>  };
>>  MODULE_DEVICE_TABLE(i2c, st33zp24_i2c_id);
>>  
>> -static const struct of_device_id of_st33zp24_i2c_match[] = {
>> +static const struct of_device_id of_st33zp24_i2c_match[] __maybe_unused = {
>>  	{ .compatible = "st,st33zp24-i2c", },
>>  	{}
>>  };
>>  MODULE_DEVICE_TABLE(of, of_st33zp24_i2c_match);
>>  
>> -static const struct acpi_device_id st33zp24_i2c_acpi_match[] = {
>> +static const struct acpi_device_id st33zp24_i2c_acpi_match[] __maybe_unused = {
>>  	{"SMO3324"},
>>  	{}

Best regards,
Krzysztof

