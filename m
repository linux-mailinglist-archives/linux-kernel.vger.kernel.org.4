Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E44C27500A9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 10:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbjGLIDn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 04:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjGLIDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 04:03:09 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50A781987
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 01:02:02 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3fbef8ad9bbso72118115e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 01:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1689148921; x=1691740921;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YkIwyBsrrasbrw6SKcJzFKY+sZkplhIF1ednI0kruDo=;
        b=bDSyjqZU/kFai51bS4zMV7wkn6IN8baUYkKTFjyQ9VhethzeBGEkbszBcepIHQbhX/
         SR/g8PJirC6plcC2OT3jO68NN6EISfhUEmvt1ZcYlS/KOUSkMDDyzznSdhUpivM0iJrQ
         13i1l9cefjz5I67sRJQjmQxF2fa4P6dQ1xUf9knjRn5qTZv38166mojcNDNcHvXl6FfO
         ZPLuDOoK4MudT/YUB8wSHQ5pU5Z1S1Uo9G9e864mQVzsIieIc4ZhlEWbw2DVMhPKZv+y
         9pxVVcRTZpHSUgTEL4Ayjp11/BWLsAVT7lgVUza3wY3VczprtRt4N1StlWKYkVsvVF/d
         dVMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689148921; x=1691740921;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YkIwyBsrrasbrw6SKcJzFKY+sZkplhIF1ednI0kruDo=;
        b=hDPk5JW92VYw6YbDxrAiaDwIVKGgetGZpssEGrCyu3M2QGmW0tLN5bjJT3UkrZ6WFj
         G8DlUMBAh7Esc/iqtA7hsoR3gvR2j+7GryzXGnRnj8tUNU96yn8Z5jZWt9tis/6Z0fRx
         xWXa3I3F0dhcJX+KcWAoDM2v7ZGuJE5vCrWkBxCkD9F5gG+CPAkt1pbckLSOLvB5ZYkf
         ZhZRELfWXg+0mfIMkrW5iabSgzxEXuYIW8C7HNleYhcG4CZfr/hfi2qX1oqtqruqFqZ6
         1ns4k2fAt9qZrPmCtIzW/m+JyThtU3b50TWSPzCGfGY+Cn8irpZkW7AH509inU2tqJri
         ssGQ==
X-Gm-Message-State: ABy/qLaYBUPYetU6wCkdNHy6qgVzY5i7S+QkhZ2cEvgCKNIqvoyxL3aL
        rgtsCA67NQ4SsWqiqVM76hZBIg==
X-Google-Smtp-Source: APBJJlFBDoZQA2YW3Bxt2cfhjxIimssHNv6+Ox3A25mufenbLcs3GAodp0BeuMoLjGNPDIVyI6916Q==
X-Received: by 2002:a1c:ed10:0:b0:3fb:b008:2002 with SMTP id l16-20020a1ced10000000b003fbb0082002mr18164102wmh.0.1689148920442;
        Wed, 12 Jul 2023 01:02:00 -0700 (PDT)
Received: from [192.168.1.172] ([93.5.22.158])
        by smtp.gmail.com with ESMTPSA id g23-20020a7bc4d7000000b003fc02a410d0sm12536303wmk.48.2023.07.12.01.01.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 01:02:00 -0700 (PDT)
Message-ID: <a335efdc-2ecb-c25a-7507-5ef2e19c5ca1@baylibre.com>
Date:   Wed, 12 Jul 2023 10:01:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/3] dt-bindings: display: panel: add startek
 kd070fhfid015 support
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Guillaume La Roque <glaroque@baylibre.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20230711-startek_display-v1-0-163917bed385@baylibre.com>
 <20230711-startek_display-v1-1-163917bed385@baylibre.com>
 <14bed951-22ae-4aa8-5fcb-b2cd92ebdbef@linaro.org>
Content-Language: en-US
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <14bed951-22ae-4aa8-5fcb-b2cd92ebdbef@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

Thanks for your review

On 12/07/2023 07:32, Krzysztof Kozlowski wrote:
> On 11/07/2023 17:36, Alexandre Mergnat wrote:
>> The Startek KD070FHFID015 is a 7-inch TFT LCD display with a resolution

snip

>> +
>> +  dcdc-gpios: true
> 
>  From where does this come? Which schema defines it?

It's a miss. I will fix it and reset-gpios too by adding a maxItems and 
a description.

>> +
>> +  height-mm:
>> +    const: 151
>> +
>> +  iovcc-supply:
>> +    description: Reference to the regulator powering the panel IO pins.
>> +
>> +  reg:
>> +    maxItems: 1
>> +    description: DSI virtual channel
>> +
>> +  reset-gpios: true
>> +
>> +  port: true
>> +
>> +  power-supply: true
>> +
>> +  width-mm:
>> +    const: 95
>> +
>> +additionalProperties: false
>> +
>> +required:
>> +  - compatible
>> +  - dcdc-gpios
>> +  - iovcc-supply
>> +  - reg
>> +  - reset-gpios
>> +  - port
>> +  - power-supply
> 
> Missing example.

I will add it.

-- 
Regards,
Alexandre
