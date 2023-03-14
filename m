Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CB996BA07B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 21:13:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbjCNUNA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 16:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbjCNUMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 16:12:54 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1528A36453
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 13:12:53 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id x3so66890654edb.10
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 13:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678824771;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AgTwHzZth/P2ovg4/SIXDhWMrCdYyhs06Uhyp9mdV6s=;
        b=KrC2zofZrNiIyyk9GGjG9QFwYogUxCILqDxJiE7/QVUYPTIx0O2K3207z+zK9C3IMJ
         a08fJAdRY+y2PjkMrnYgGvRCWwJl8GFUK/Ysh+wau54xWNwVBNKIK3PKViJG6E8dzxzU
         tD0AIuqSaLWpKMiqFfjK/9InUQEXgZ7YajWY6MNOoqcZtQEmBzRju/noI+d4ZmSLVfGj
         XRU8ErAZYOrrYgrHoz2sLFa5i3/TsorARVqE4/tRHz8MyCd73gWK5SYU80NYgyRgIIAK
         H2HjAXWAUzWt5o9rcw4D5Mxzny7c4qDaQxWSahnTf5yzlYS/BVosigPCE/SR7S7wkZ0g
         VsKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678824771;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AgTwHzZth/P2ovg4/SIXDhWMrCdYyhs06Uhyp9mdV6s=;
        b=11RgSHJrb5c3GOBev8U+UMBvyvsHyTvkC/uR5g5a/JqwVGVYo4at7U1mONP5x3vMsm
         PzcTla1SSiom61UkPP92Rh0gqbUqZyWVKjgT4Gj0Jm3l8vFOGgmYfIsF4Gi7Zy5n/DYY
         GjGQ5uGtUcYabhuJyAXiVKnO6tOA/XqyeoD3nW/FKFmNydQL8HEICHGIAqCqgPhQ2fMu
         l7WHlv6eeyv+7PhZovcWZe+Hnf8YPxrKIg2zm9KsaXg3yJrBjN5Q3X7nBUe8y5e0r64C
         qoD9EVXfOhgLQFrh7Ci8IV25ePKr2cW4hdKnLxA5OmF94GuySKhkwfu+KLhvTmNM6JRO
         1ZJQ==
X-Gm-Message-State: AO0yUKXVFNTNHCc/Tn6W3kdl34fWw2kGLGu2n0JdEkAfKkRHxe1rzSjV
        gIWk1mQi4MJP3m6aLzCrn4MEEA==
X-Google-Smtp-Source: AK7set9FwKmH8IWRt0oGFHXN64uPFH0geW/+oy2YAf2Rufey01dFKgJ19ytNYbdzett+AF5M5soC9w==
X-Received: by 2002:a17:906:6945:b0:8ae:f1cd:9551 with SMTP id c5-20020a170906694500b008aef1cd9551mr3922346ejs.76.1678824771563;
        Tue, 14 Mar 2023 13:12:51 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:642b:87c2:1efc:c8af? ([2a02:810d:15c0:828:642b:87c2:1efc:c8af])
        by smtp.gmail.com with ESMTPSA id e12-20020a50a68c000000b004ac54d4da22sm1512106edc.71.2023.03.14.13.12.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Mar 2023 13:12:51 -0700 (PDT)
Message-ID: <a0ec54c2-b11e-5f4b-eb0e-ab9a8e71b02c@linaro.org>
Date:   Tue, 14 Mar 2023 21:12:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] mmc: sdhci: add static to !OF stub
Content-Language: en-US
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230311111238.251000-1-krzysztof.kozlowski@linaro.org>
 <CAPDyKFqaq5ysudyqOe0dB8fm=+p_ywpXdqQr33QUCq3j+Bqnrw@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAPDyKFqaq5ysudyqOe0dB8fm=+p_ywpXdqQr33QUCq3j+Bqnrw@mail.gmail.com>
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

On 13/03/2023 13:49, Ulf Hansson wrote:
> On Sat, 11 Mar 2023 at 12:12, Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> The sdhci_get_compatibility() is not used outside of the unit:
>>
>>   drivers/mmc/host/sdhci-pltfm.c:76:6: error: no previous prototype for ‘sdhci_get_compatibility’ [-Werror=missing-prototypes]
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>  drivers/mmc/host/sdhci-pltfm.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
>> index 328b132bbe57..245e56324dff 100644
>> --- a/drivers/mmc/host/sdhci-pltfm.c
>> +++ b/drivers/mmc/host/sdhci-pltfm.c
>> @@ -73,7 +73,7 @@ static void sdhci_get_compatibility(struct platform_device *pdev)
>>                 host->quirks |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
>>  }
>>  #else
>> -void sdhci_get_compatibility(struct platform_device *pdev) {}
>> +static void sdhci_get_compatibility(struct platform_device *pdev) {}
>>  #endif /* CONFIG_OF */
> 
> sdhci_get_compatibility() is using OF functions with stubs for !OF.
> 
> Perhaps a cleaner option is to drop the #ifdef CONFIG_OF completely
> around sdhci_get_compatibility(), thus we can drop the stub too.

Works, indeed, better idea. I'll send v2.

Best regards,
Krzysztof

