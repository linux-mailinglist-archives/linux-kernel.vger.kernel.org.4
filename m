Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4850E5B3B22
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 16:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231628AbiIIOwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 10:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbiIIOwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 10:52:30 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7161412E19D;
        Fri,  9 Sep 2022 07:52:29 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id j6-20020a17090a694600b00200bba67dadso1802768pjm.5;
        Fri, 09 Sep 2022 07:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date;
        bh=QD55vyuIc4UcqqPaEpJjzkaWqOsMbkBdhIDNhKX/OsY=;
        b=IlTGlFK/8GThOW2rs7NZlCYJNFlrbQz8mW42xy84bZShRGkgoA8xGy1yR/lITjOJK4
         0VoitCJwW244abBynNjdKGf4REHfBU5aQt5FG6KKZZoQGxMA9fusVUdgrlVJ8OQKFrML
         3bAvLAyWhKvIFfw1zZp8pCFbjzFuNOz5snjiDkr50lrfr7GxtG2Tc6T17tZD91tlORs8
         Avck1u0G+aAKInXdykTFis6/A9ltBuKH0xZqxXKW5qNFaaumHGr+swQwnUD/m3RyrhF8
         wS6mr0ixdaCxXnaUoKa+SHWohwtkWzOUI3acIXZSzIHbkbtG5ICewzH+mE/pgFePi4Y2
         BBoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date;
        bh=QD55vyuIc4UcqqPaEpJjzkaWqOsMbkBdhIDNhKX/OsY=;
        b=rNTPN/4L2W9D9KZZnpj0f4MhTlKOl5Sgk1SHEIEtrWR9HOVKTTqtfLGL/4bW4refeH
         SNTJZhU+64RrPzPAah+NVPaL584w5a4QgJb4IZfoW/VeqYbOCsO7u16WOhpE50tY7QS2
         ObEAEUAZ4CYQplhUTo2lSLjWt7ZooVqLE5dzKA7L2Rk1VdkIEO8/LZxBSb2bpkLGfD9U
         uekzeF33dIm7/a2Ap2OIkvDzYP4AQjggn5YeAdvnivcs/xcWxYAiwFI4E5+FhPGqAqQo
         KKc7YK+5KyFHO6lpgUPFWxsx6JF8RfOzjSzEqxxaN/xpa/u3XyS0BYUBoKahkz10nwil
         CBjQ==
X-Gm-Message-State: ACgBeo36kPdxDEZuLjEVlyXClEM2j+P8maZyKHrZVo3cucRsMSVSHjB1
        i0k6p34ROvKpHYvY5GSQ8o9x9xE0bSEKJQ==
X-Google-Smtp-Source: AA6agR6n6aoXqqrPhNzIWkZ4BeA7f+bnUtuZ98ul/S/ZcPbJTpJ3BysVyTlj/U0Vywa53m+FRSwBGg==
X-Received: by 2002:a17:902:c94a:b0:177:fd5d:d361 with SMTP id i10-20020a170902c94a00b00177fd5dd361mr5696040pla.139.1662735148963;
        Fri, 09 Sep 2022 07:52:28 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q2-20020a17090a1b0200b002001c9bf22esm566680pjq.8.2022.09.09.07.52.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Sep 2022 07:52:28 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <339d3857-2deb-b5d9-332d-cc65cc90ca19@roeck-us.net>
Date:   Fri, 9 Sep 2022 07:52:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v8 3/4] dt-bindings: hwmon: Add bindings for max31760
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>, jdelvare@suse.com
Cc:     linux-hwmon@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220909133718.388213-1-Ibrahim.Tilki@analog.com>
 <20220909133718.388213-4-Ibrahim.Tilki@analog.com>
 <9d5e8a41-8e0a-c67a-1b68-f743b4680510@linaro.org>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <9d5e8a41-8e0a-c67a-1b68-f743b4680510@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 9/9/22 07:49, Krzysztof Kozlowski wrote:
> On 09/09/2022 15:37, Ibrahim Tilki wrote:
>> Adding bindings for Analog Devices MAX31760 Fan-Speed Controller
>>
>> Signed-off-by: Ibrahim Tilki <Ibrahim.Tilki@analog.com>
>> ---
> 
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Please wait with applying for Rob's bot to check it.
> 

I don't think I see those results unless there is a failure.
Is there a link where I can look up the results ?

Thanks,
Guenter
