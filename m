Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 163F56B5BA5
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 13:28:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbjCKM23 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 07:28:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbjCKM2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 07:28:25 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F067F23A58
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 04:28:20 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id g10so2274349eda.1
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 04:28:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678537699;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pPEaqI1ON+Jn2Wz34fKyoAxqC6NH3Zw3zwW0rrLUejU=;
        b=DT9pmfkyGwFe5IJRHANvFYu9IPa2zOsae76eWOLZB+huoYm6JF72C5GZQ3SHXAa/3o
         JLZAZKYKpM11n1bltWGzYOPxAaGHb3/BKHMDAzgsjpv8lSCiwsL6EX2x94+kxttLVtuh
         TUzcruCBRjtQY9RW+MmN5GeQ/R8zofYqTvWAPRvoraIK2Cc7UWVwAgeaHp6V0F/TYo24
         o8GiF9JVGzPHF8d1jEjr9q0P1Nm4MB9p8I0f/FuopCGhK2mX76jUccfZYwzg+UPNBu9w
         R0Uvu7vyk/gr8rJxKN91ZERA1Dh4ug9MM2CbyPO0fYYVtKti8J+LX97obxWur0nZFR7j
         AI2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678537699;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pPEaqI1ON+Jn2Wz34fKyoAxqC6NH3Zw3zwW0rrLUejU=;
        b=zn5na6qo66Y6AaaCsPtgHxSuCDkP7CmkH7u3JAFkglFEKMX7fuqqVVyL1x9xY5kHg/
         aZG4hzyGUVcoe/sm9Qcf99jQh2vQ9jhgcHq4mq7ECRyh8sPAmpb31I0k2Ex0ULeTp6oE
         BmI29aUuR42t5GQNNBDlKU2WZONCqdN04PYy/UJ2rVusJVe0ZLC36R0IibZLp2gTR5GV
         g9+rRhavxatobpw7oMF0kRwTWqccF7KmhCtq6/9EsgqWLgrijcSs5IPmsZHhgc4Imw/0
         X8PReItJS8qFPfuKTmQ5oXDsEYvI52wcTakrYfibr4PDKAJI+suf6r1seI/XhCOhbKcj
         S4GQ==
X-Gm-Message-State: AO0yUKViETHGHuDfoEtb8qhs0BEAMuhzXhcbt2dNi3Fvhw5iPYWcklba
        4Mm7tLWc/0hKzyI40tDAdldej0us5n/DFyuu82o=
X-Google-Smtp-Source: AK7set+Ub83gAFtPrDgwfkko5f/le16ZoQ2PtQzI56nDp9q2GDkj1c02utyeGUOBflEUvCTY7dtK6Q==
X-Received: by 2002:a05:6402:150f:b0:4af:6a7e:9145 with SMTP id f15-20020a056402150f00b004af6a7e9145mr25916119edw.14.1678537699148;
        Sat, 11 Mar 2023 04:28:19 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:fa97:2d7c:bdd7:e1b? ([2a02:810d:15c0:828:fa97:2d7c:bdd7:e1b])
        by smtp.gmail.com with ESMTPSA id g2-20020a1709062da200b008cf377e8795sm1032372eji.199.2023.03.11.04.28.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Mar 2023 04:28:18 -0800 (PST)
Message-ID: <8f448bc9-2f2b-77cb-ffe2-895593a6047e@linaro.org>
Date:   Sat, 11 Mar 2023 13:28:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 3/4] iio: light: max44009: add missing OF device matching
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Marek Vasut <marek.vasut@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Robert Eshleman <bobbyeshleman@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230311111457.251475-1-krzysztof.kozlowski@linaro.org>
 <20230311111457.251475-3-krzysztof.kozlowski@linaro.org>
 <20230311122619.2d8bfaf5@jic23-huawei>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230311122619.2d8bfaf5@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/03/2023 13:26, Jonathan Cameron wrote:
> On Sat, 11 Mar 2023 12:14:56 +0100
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> 
>> The driver currently matches only via i2c_device_id, but also has
>> of_device_id table:
>>
>>   drivers/iio/light/max44009.c:545:34: error: ‘max44009_of_match’ defined but not used [-Werror=unused-const-variable=]
>>
>> Fixes: 6aef699a7d7e ("iio: light: add driver for MAX44009")
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Don't use of_match_ptr() unless you are absolutely sure no other firmware
> route will make use of the of_match_table.
> 
> In this particular case ACPI using PRP0001 is broken by that macro.

It's not broken because there was no matching via PRP0001 due to missing
table.

> 
> So good to set the of_match_table, but make sure to always set it
> and hence you don't need the __maybe_unused.

So you want to add PRP0001? We can, the fix is for different issue, though.

Best regards,
Krzysztof

