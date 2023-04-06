Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7FFA6D9189
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 10:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236127AbjDFI2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 04:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236113AbjDFI2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 04:28:48 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A265C4C0E
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 01:28:45 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-5047060185eso27829a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 01:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mind.be; s=google; t=1680769724;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=20coA4glkdpOkZOcWK/cfFVjecshS2DyrEnIOMLBfXs=;
        b=fG9Oec8fFAktEZy9s0Bjlye2DO74mjUPYSB2HhLP1kpvMKjH1Wq7+lOy+HdpXjHAbw
         JYngnqiVxaMuAEm7crsLXZWcMhQJzj5zTLKWYVkMslBRRVWV9f07s0l3Vu73eqbzuzHC
         h4V9pJn83impfmYkIlth4CaQCVKLF3h9dnIUz+lQWc8AFBe5MiEwoH+StUDkcYzWUPBo
         +822andwpq5ju15VUDstlvj4wUUYIlzK16mjfVbrnxPZmdJwYjyNqr4Lb5sbVbsLoO9f
         9bS96PznUv7vaW1N+EPK1lrqTLuxApEJuEWqjMcaHYO0+kfhEFTa0+C/MQStsW0l6Exo
         M4Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680769724;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=20coA4glkdpOkZOcWK/cfFVjecshS2DyrEnIOMLBfXs=;
        b=2xGRhBe+gGdUNGn2w3STClz8tYQOOwtTgrc4KqgEGcrSYWh4SuRvOn15y7bl+xh5U6
         JifvkQ+PqnvRHugLtoQwNXmUyvxfob1de+tOIcptpbN3OC7mULA5pzW2rGjIvS/szS6S
         ++0dlsMYN/1NNGj0Kc9SJ1KpmZF8I+/i2nZnFnhXaRRdVHmt8H6FZobZ2lpkZrW93hmK
         YozjGHKShEPxQVJNv894xUOt03xfo2mgKVvsEqsAm3Go8GRfDfEUkMbCl1OzPgT93W7/
         kUX/lHdJXusCSTLSLVQE2EdT4wPFLfpTn5krtTzD2Z0E835Pbi8Sb5p0r0U/MvTuGQ/s
         DnlQ==
X-Gm-Message-State: AAQBX9eCwOh0vhOzDrH1qgZbpwfLrYuFx8FQM2znhJuFQhoql778Mzuf
        2uOhzgw2ZhPniGpjoe9wnll+SA==
X-Google-Smtp-Source: AKy350alUEuW7MUoCbOTgUwV8VD7WVrguT6Wesjzfgmmw0tCYJxCkMvhqRVh6CFt5sUSX/ls27qBgQ==
X-Received: by 2002:a05:6402:148:b0:502:32ae:14fb with SMTP id s8-20020a056402014800b0050232ae14fbmr4101278edu.5.1680769724141;
        Thu, 06 Apr 2023 01:28:44 -0700 (PDT)
Received: from [192.168.2.9] (78-22-137-109.access.telenet.be. [78.22.137.109])
        by smtp.gmail.com with ESMTPSA id 26-20020a508e5a000000b004fcd78d1215sm418780edx.36.2023.04.06.01.28.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 01:28:43 -0700 (PDT)
Message-ID: <32c0a958-58bd-7476-c276-94c8f33ffbb3@mind.be>
Date:   Thu, 6 Apr 2023 10:28:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v6 2/2] leds: lp55xx: configure internal charge pump
To:     Lee Jones <lee@kernel.org>
Cc:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230331114610.48111-1-maarten.zanders@mind.be>
 <20230331114610.48111-3-maarten.zanders@mind.be>
 <20230405152627.GO8371@google.com>
Content-Language: en-US
From:   Maarten Zanders <maarten.zanders@mind.be>
In-Reply-To: <20230405152627.GO8371@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Sorry Maarten, just a couple of small nits.

No need to be sorry.


> This fits on one line, no?  < 100-chars?

I thought the line length was meant to be <80 chars according to:

https://www.kernel.org/doc/html/latest/process/coding-style.html#breaking-long-lines-and-strings

Happy to adapt if this shouldn't be taken as strict as I tried to do. 
Either way I'll post an update with a cleanup.

>
>> --- a/include/linux/platform_data/leds-lp55xx.h
>> +++ b/include/linux/platform_data/leds-lp55xx.h
>> @@ -73,6 +73,9 @@ struct lp55xx_platform_data {
>>   	/* Clock configuration */
>>   	u8 clock_mode;
>>
>> +	/* Charge pump mode */
>> +	u32 charge_pump_mode;
> That's a lot of data.  Does it need to be u32?

No, it luckily doesn't get that big. This is to avoid an intermediate 
variable & casting as the DT parameter has to be 32bit (which I learned 
from an earlier comment). It was changed from u8 in v5 of the patch.

Thanks for the review,
Maarten

