Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0B3D6BE56E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 10:22:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbjCQJWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 05:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjCQJWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 05:22:10 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D89E5B421C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 02:22:08 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id z21so17859867edb.4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 02:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679044927;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nsHFbM31p4aG2NzU6pYJrvN8mc9wOJaxONeK5EJ0yBk=;
        b=NZFKWGNHrB/onuIrzQib8AmrVjFUNprwpo1xdl/8hS0tnGtLfqpa3t+tpA5DqfYzAF
         RE73ioNVxXmBqQvisjhlkEdcLm0dbDZgYQWmn8dPR8xgLcCaDMhuTP7gBf1RToz3TdHk
         cKDWIEEXf3BF/wAcdNbY0tAZk0Ls7R3xI2qUrBie+P2vtFN+WB3g1ec+btKjR9RmbQVG
         TnJHGCf1XHV9TVyLwmg/k1FC37PhmdZU7HbipyclPw2YNZJXL2gYcpHtNCnkjuCM7ChR
         iVoyW/UY8c585YsXeAS8rR4eaK1DrmF5hrq0oLs+jVPtZr0uTustud0tp7bdSeReCs4w
         R17g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679044927;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nsHFbM31p4aG2NzU6pYJrvN8mc9wOJaxONeK5EJ0yBk=;
        b=k6tm/mmGDVclvpJFxv8egP8Weq3XBO112oU7v/ophPHubXttwZka+DaBy9hE6KZP4E
         L6doJTksdaTJm26L4iLOxDKbNpNrqE3Hrqyv+Z1GIK6Gec34pAJ1CcnTDfujxS92T7nD
         QrD1CjQzHj0X6w+zUU47vwMWKs1VVW3kF50BKlpEzlROGu9sUOncV/A9jJQKAiwG5jC5
         VROxAqRNK1gQ9Jp4py0otJy4IIgUjQd1AAU2evPl9mVDsKe3ZdChOFqypTgJg1S6hB6W
         NT+Zrx7ZBCsE+4qfWR4N+rgXTSZ9OsRw+3vJZW+to5bHDLX8jqoj1OwCs+p4PZ1U6fAv
         rBCg==
X-Gm-Message-State: AO0yUKVnHoiXOKOt1Npx1zSrWPg3GgbMjzu7Yr36KeJbZeN3ulSffmvS
        qVDF1wF7WCKcKDnpWdkwSqknuQ==
X-Google-Smtp-Source: AK7set9IrUtS0MYoDpyUE9kUDDV8lJU7DfdO4dwR1skLJr+3VbeFqBnq5yZdMh1F1GsvAQSFdds7Mw==
X-Received: by 2002:a17:907:2cc6:b0:930:d30a:6c20 with SMTP id hg6-20020a1709072cc600b00930d30a6c20mr5834516ejc.17.1679044927382;
        Fri, 17 Mar 2023 02:22:07 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:848a:1971:93e0:b465? ([2a02:810d:15c0:828:848a:1971:93e0:b465])
        by smtp.gmail.com with ESMTPSA id j10-20020a170906094a00b008cafeec917dsm745003ejd.101.2023.03.17.02.22.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Mar 2023 02:22:07 -0700 (PDT)
Message-ID: <c299fae9-e923-4b3d-539d-01ce5fb63a46@linaro.org>
Date:   Fri, 17 Mar 2023 10:22:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 2/2] crypto - img-hash: Drop of_match_ptr for ID table
Content-Language: en-US
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230310223027.315954-1-krzysztof.kozlowski@linaro.org>
 <20230310223027.315954-2-krzysztof.kozlowski@linaro.org>
 <ZBPYpYfd29YwN1Dy@gondor.apana.org.au>
 <b8cd828b-edc5-6748-bf97-af0fc85e14a4@linaro.org>
 <ZBQlKMTcTm1yjete@gondor.apana.org.au>
 <e7cd7252-9cc6-0970-b0e2-35fccde45e86@linaro.org>
 <ZBQvx0PDQJ4qpnNO@gondor.apana.org.au>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <ZBQvx0PDQJ4qpnNO@gondor.apana.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/03/2023 10:15, Herbert Xu wrote:
> On Fri, Mar 17, 2023 at 10:01:44AM +0100, Krzysztof Kozlowski wrote:
>>
>> That's not true. There is no waste because having it on x86 allows to
>> match via ACPI PRP0001. It's on purpose there.
> 
> Alright how about this, I don't have any OF devices on my machine
> yet this structure is still taking up the extra memory for every
> single device driver.  This is wrong.
> 
>> There are OF-drivers used on ACPI and x86/arm64.
> 
> Well then they should be selecting OF and everyone will be happy.

OK, I will change it. It's a bit tiring to discuss the same concept with
different maintainers and each time receive different point of view or
each time need to convince that the other way is preferred. I already
had such talks with Mark, so it is just easier change patch. Also, I
tend to keep forgetting all the arguments. :)

Let me just share also other maintainer's point of view:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0e62470652fa
https://lore.kernel.org/all/20230311183534.1d0dfd64@jic23-huawei/

Anyway, I appreciate your feedback and thank you for picking up the
first patch. I'll rework this one.

Have a nice day!

Best regards,
Krzysztof

