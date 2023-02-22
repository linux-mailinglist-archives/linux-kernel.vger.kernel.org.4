Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC2169F075
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 09:38:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbjBVIi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 03:38:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjBVIix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 03:38:53 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C09BAD2C
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 00:38:52 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id i34so1891925eda.7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 00:38:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VGYrvXKx730j8waNg6kc6q9n1QzZ6m03dBYS2j7HOQw=;
        b=ikQu+qovo7VzH2uaNVKQF4awl/fxax4qj1G6kByJSoCI4aiiAnzx5WPzEZGCSXn75K
         7hxlTaQwBvFnSZVsdBK+0X0et14eVzTaMw/KSxO7SVaxNBKroRDGyRGwZRsMPIQVh/Sl
         J5jqAdLyNst0fPoKLPZX8ksKjM/IA+lLOoc01lRXl5eSBRwFMqOcOoe8DpHJSpOPZrPl
         7gXcCX3AxMyS8q5n3oz3booaV57u4zDb5swg9nxlguwirS9L6uxEMIAJjd844htJP+QZ
         5/+jPdWcJxPTp7MIexOWRbFEGMyy+wbXsjlSFyUnOkI+B1eDHLDT/T5kHKX6u+GeBir8
         +pQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VGYrvXKx730j8waNg6kc6q9n1QzZ6m03dBYS2j7HOQw=;
        b=RpW8dya3Qql51amsovDu3i8zExNkKX9+HI9LJlV7Bsz4QDZd1HIdYNLObc8p9KxGyr
         sfF1j6JLiBfTH1UiR0oFPAPyU7Ttq6jEyll2U67sS0A11dWD5OVOK/H/Szq0+jvChxq8
         rirGfNEfXcIerTG0iIJweemBLBSBuH1Bfl1MwEZeAcResQa6wsobZXzSIDBQoeSxxeOh
         Y/fxOwTFp58QVzYdEBbkthS9mVGRbXn5v3SlNdrVJCIkJZ9oxGKL7ZZg4AEMuZPZBxQQ
         ZyouH4pM/JM5V+zGPHyZuqJqRCgbzrkHnS/F/As5JuM3Pk2Q5M8Y9sDYT4GZkG8uXkHf
         /d/w==
X-Gm-Message-State: AO0yUKURJ3Wfwx4GsxmcXQ+nXaUs/trf18wzIsiwTp4Ialj3Mx+rWgxI
        sG28yqhnTbstKFAa0K/FUmKSHw==
X-Google-Smtp-Source: AK7set/ZWj3Inch8FESqr8vZe3PV7J6tCfOU4ycr20w9XgWAqWr8t7mtTcZYAg6wYekGNYxhb7NjHA==
X-Received: by 2002:a17:906:9c85:b0:8af:2e78:ac2b with SMTP id fj5-20020a1709069c8500b008af2e78ac2bmr19914255ejc.3.1677055130718;
        Wed, 22 Feb 2023 00:38:50 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id u13-20020a1709063b8d00b008e45d7055f8sm1025458ejf.198.2023.02.22.00.38.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Feb 2023 00:38:50 -0800 (PST)
Message-ID: <5f2bebad-5c9d-41bd-63c1-043f1d8c6c16@linaro.org>
Date:   Wed, 22 Feb 2023 09:38:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3] dt-bindings: ata: Add UniPhier controller binding
Content-Language: en-US
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-ide@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230220054711.4584-1-hayashi.kunihiko@socionext.com>
 <8a4042fd-02a3-261e-4126-7a3090850fda@linaro.org>
 <7e19d3f4-a3bc-dc9d-35a0-9bfc05f22b2c@socionext.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <7e19d3f4-a3bc-dc9d-35a0-9bfc05f22b2c@socionext.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/02/2023 02:03, Kunihiko Hayashi wrote:
>>> -  resets:
>>> -    maxItems: 1
>>
>> Why moving it?
> 
> Sorry for my mistake. I should fix it.
> 
>>> +allOf:
>>
>> This goes to the same place as in example-schema.
> 
> I can see "allOf" next to "required" in example-schema,

Are you agreeing or disagreeing here (thus I should explain that it's
not the same place)? If the first, sometimes it's enough to say "ack" or
"sure".

> 


Best regards,
Krzysztof

