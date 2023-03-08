Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3D946B04F3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 11:49:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbjCHKtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 05:49:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbjCHKtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 05:49:40 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABB0493E37
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 02:49:38 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id ay14so60218899edb.11
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 02:49:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678272577;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eIVX6Q+wuDbqZ/cwjngt/vxJSb/KTYgiM7a99i9TgCg=;
        b=fzRXtOeNzLF+uBzCxSrxIsc9ahjghGspm081T3BGJpuPbc+Pbf8jrXo02SqM8sEmSk
         BR+QzoQqJfQHSVvA/KujB6kGi03ZeqTrTl+zg1p4NaJGGm9YFcRlueEtUhQIADs8Ww5b
         i/ndHgl5WuZmJDKjIWA2DbrmhgQC2MiBOFgsiUBxVmRQx3MXW91KGSW/X0vHUWGyX2to
         EMRl7GlZSPpPB7yWUXFiMR8T7gwDW1fL4rvErn/KMfiszT5wDTuJ0snF+IKheW8XrmhZ
         DGXNd/FFS4tHfI43CihC33EMOjus/8JDz8TlP/f6VBRTLoRouODFFF3GGQBpyWUgAz8n
         Y0uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678272577;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eIVX6Q+wuDbqZ/cwjngt/vxJSb/KTYgiM7a99i9TgCg=;
        b=jVqOON8mi1wwpbKHU2mrh3e68rU9AVNuHn0NSoAq0k+03bwzOHCgZigIhC2MTVGYmL
         9YmZ0V37pc/cUTtWaQOcPjnA8iI7MRubZX7cpDUKEFyVbeRDA6t+dzC/jMGlotkW1R3o
         sTfcKAhH2TfKICZZVfZHlaRzJ3Z+qWHCdY6Sgvg2T5jX3av9cwEJ8CYfsADobW5XZQrD
         l5Cv6wChA0+lyfAi5Yu1EhMOrw90TRHmxcIYg0gSQSkCR5dkkNdgpSS+DSLXMTXYG/Jk
         0x4XOxf3loRuWGy1WFQo/7leovSdaPvF2atlnSZiRckUACXXoQqUA3roSvNXYlyypv6z
         6gsg==
X-Gm-Message-State: AO0yUKW1KsjjlwKowCxK2xrY1wLjSgsnceuMcYZCHUs+c+hB79lyybWn
        2o9mH1omiIPi1UY4vgfOo6yyGg==
X-Google-Smtp-Source: AK7set+8p1PgQPRzlFznQupET+FkEQpoQ+wy5R2mWpUIbzv4Vx31T7YpL4AX0ZjC3vd4C1H+buV5sQ==
X-Received: by 2002:a17:907:7748:b0:8e8:6b69:2093 with SMTP id kx8-20020a170907774800b008e86b692093mr20248395ejc.25.1678272577191;
        Wed, 08 Mar 2023 02:49:37 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:ff33:9b14:bdd2:a3da? ([2a02:810d:15c0:828:ff33:9b14:bdd2:a3da])
        by smtp.gmail.com with ESMTPSA id h21-20020a170906261500b008b23b22b062sm7271824ejc.114.2023.03.08.02.49.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 02:49:36 -0800 (PST)
Message-ID: <18450b30-7781-0315-2d08-e536a0e94815@linaro.org>
Date:   Wed, 8 Mar 2023 11:49:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v1] max77663-rtc: pass rtc address from device tree node
 if exists
Content-Language: en-US
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Svyatoslav Ryhel <clamor95@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org
References: <20230308083759.11692-1-clamor95@gmail.com>
 <f1df5968-4322-3f67-3da8-c10ea50386a8@linaro.org>
 <CAPVz0n24odz4bxt8nRe08-UJFoaDSTGMAPfj2b2RBG+ZbwntfQ@mail.gmail.com>
 <190897d3-39b6-fb7c-dc18-dac580fadea6@linaro.org>
 <06f8eec8-94f3-0fed-b496-831c77baf368@linaro.org>
 <202303080942204be1ceeb@mail.local>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <202303080942204be1ceeb@mail.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/03/2023 10:42, Alexandre Belloni wrote:
> On 08/03/2023 10:14:22+0100, Krzysztof Kozlowski wrote:
>> On 08/03/2023 10:11, Krzysztof Kozlowski wrote:
>>> On 08/03/2023 09:58, Svyatoslav Ryhel wrote:
>>>> I would love to, but max77663 uses max77686 rtc
>>>> https://github.com/torvalds/linux/blob/master/drivers/mfd/max77620.c#L123
>>>> how to handle this?
>>>
>>> Don't top post.
>>>
>>> Hm, so it seems max7763 is already documented via max77620. I missed
>>> that. Add the new property to max77620, not to max77686 RTC. It does not
>>> look like RTC's property, but the PMIC's.
>>
>> To clarify - the I2C address selection for regmap is in max77686 RTC,
>> but I meant DT property.
>>
>> Different thing is that we do not pass addresses as property fields.
>> These should be devices on the I2C bus rather... unless you are aware of
>> existing property like this?
>>
> 
> I'd say that the RTC should have been modeled as a discrete component
> from the beginning instead of using an i2c dummy device

Yeah, exactly. Current design was working for existing use
cases/devices, but has limits, thus RTC should be reworked. Actually
even for oldest PMIC max77686, the RTC was a separate device on I2C bus.
We just made it for simplicity part of PMIC.

Best regards,
Krzysztof

