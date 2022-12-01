Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D448E63F587
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 17:43:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbiLAQnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 11:43:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiLAQne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 11:43:34 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72588AD332
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 08:43:33 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id c1so3343310lfi.7
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 08:43:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L8hpSR/3nlqBj/Be+rcyGGbkrbq4xUfYfMKRCLbhddc=;
        b=lCu5HlOhQ7/BGDbpuRrV2qz9X4a1j8VJ7Ddkd6cyi0SCqY0tT3RyUR6fCYkvpfXxLI
         Sm0knrJkkt4pfkrUQdLNY5ikwXFBtrwim/h1rrqhnKWNJ8oAs+oMrx8/F6J6CD5Mds+f
         9NAykPKuUh2xx0R3prZ4pL5903E/0iZtEaIRwYTIU87NuKgId1LNVfok6GKcJg3Kb6jB
         gcaGyxrJdXV+BfLF802Jy68tGJ4wh/OB9Os3Ia32rVrbgTLzpr9hrafgRO4x/gtowLwC
         VdsWFgDVYt8BDsQkFC2oQWVVJodCo+QV1Dr6S997LApfMfrw+ajXMWy2Rzm6znuyVbOn
         Q6zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L8hpSR/3nlqBj/Be+rcyGGbkrbq4xUfYfMKRCLbhddc=;
        b=HUWgxvvrFTg03x8KeISrWz9xpAGYpYIzvHN/rS1LjutfOCXVUIkKP7Ko8BV7usMAzK
         V5ei8J7s4N/GtY4RO8/aN/i7ExaZjBc84b0rpb3eNI1A7JrhwiJUq33+/qzviygZNGRW
         dUm2fCrxMS5fhTuT0teGOAKHg6H1JdhSyQI3OWeTJR6iMOrIH7YFjY+/r6sMlfAV2Arh
         QjUBgjWm/9GQzRLP0iIHDawmLiWqW/aCSoLo1e4Ladj9H1sJEDwFG1dqjgfjsIFanfVv
         byRUGtFoAeitehZhEODld9es9snswQwgiNsBxX5P0YXOivov5O1VUQZ6/9LRcvwmRdyM
         p++A==
X-Gm-Message-State: ANoB5pnj3IOvQRZO1gjwnEKdeBQO2ct3wyC/s2T0TVREOzOH9l+ZXMdZ
        w0E/NR3IBaZbhZ+I6QQWUe+/Ew==
X-Google-Smtp-Source: AA0mqf6oJcaRDO1AvdOI0rYdDIXBvPwvqzgXbrEtLsnIb+oxjgL46hXpu0tYvA0hGrS9xy+ixNEmSw==
X-Received: by 2002:a05:6512:208a:b0:4b4:b2c6:5d28 with SMTP id t10-20020a056512208a00b004b4b2c65d28mr20872835lfr.47.1669913011802;
        Thu, 01 Dec 2022 08:43:31 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id z15-20020a056512370f00b004b4b69af17dsm286886lfr.214.2022.12.01.08.43.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Dec 2022 08:43:30 -0800 (PST)
Message-ID: <bdab2e58-ea12-0ccf-a25a-ed89e50a5332@linaro.org>
Date:   Thu, 1 Dec 2022 17:43:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 2/4] dt-bindings: hwmon/pmbus: Add mps,mpq7932
 power-management IC
Content-Language: en-US
To:     Saravanan Sekar <saravanan@linumiz.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, marten.lindahl@axis.com,
        jdelvare@suse.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
References: <20221201044643.1150870-1-saravanan@linumiz.com>
 <20221201044643.1150870-3-saravanan@linumiz.com>
 <bc86121f-3cc2-1e55-4c6a-02cb1644a8bd@linaro.org>
 <e7b20055-4f44-aa91-e18d-9fb0f835fbf1@linumiz.com>
 <29de4d2b-3e32-809e-6ccd-5e7a4fe548fc@linaro.org>
 <e0d97b79-2133-8869-eaea-eb286fdb3a11@roeck-us.net>
 <785e942a-0691-f87e-b6e9-058749a79ec1@linaro.org>
 <8228db8d-2a32-1d23-74f3-05b9fe529a82@linumiz.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <8228db8d-2a32-1d23-74f3-05b9fe529a82@linumiz.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/12/2022 17:38, Saravanan Sekar wrote:
>>>> Plus additional comment for the driver (and related to bindings) was
>>>> that this is not hwmon but a regulator driver. Why putting regulator
>>>> driver in hwmon?
>>>>
>>>
>>> Turns out this is primarily a hardware monitoring driver, like the drivers
>>> for all other PMBus chips. Regulator support is actually optional; the driver
>>> works perfectly well with CONFIG_REGULATOR=n (except that it needs some
>>> #ifdefs to address that situation).
>>
>> OK, this would explain location  of the driver. However the bindings are
>> saying:
>> "Monolithic Power System MPQ7932 PMIC"
>> and PMIC is not mainly a hwmon device, even if it has such capabilities.
>> It might be missing description and proper title... or might be misplaced.
>>
> 
> Indeed it is PMIC chip. I think this is not the first and not sure title 
> has to be changed for hwmon subsystem.
> 
> bindings/hwmon/pmbus/ti,lm25066.yaml
> title: National Semiconductor/Texas Instruments LM250x6/LM506x 
> power-management ICs

Then I propose to put it in regulator directory.

Best regards,
Krzysztof

