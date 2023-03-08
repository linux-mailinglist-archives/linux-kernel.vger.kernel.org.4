Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B18936B04A4
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 11:37:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbjCHKhF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 05:37:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbjCHKhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 05:37:00 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A3FF984C7
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 02:36:31 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id a25so64010246edb.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 02:36:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678271791;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VG+RlrvK7dZWuzlwZ1EYIzr+/GC/6ow/DPfTqBZGod4=;
        b=LEii19fZHdyPtUtrIbxlgmS8ZY8i5KnQZi6X3CkZvve17XFtkFB1QTXGNSLxzX/YSV
         Eql3hZ5/oMgUfyTQtsgiWcTKuQ22bwtycmZSddNcGS+Pz84h+SjX06d8ZRaAyoypdiEF
         kZwTsrAv2Y6Uiu2tSqwjdKWNMraWGE40vSv67fl/aAPZFrmC1M0aaHIDNX92fi0PzonY
         LwQMz4y+MjUhTedroJ9LgFj0+5thiYgrgVxNNxP4zB5abDy3p6asS6E3eYkbMbZqrNxp
         9+38WdnNKm02t1i5vnATS0FBgPxHtc104iqJLuWbpJRugxNrjnVdwBF0fz9NI97X+eac
         VJNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678271791;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VG+RlrvK7dZWuzlwZ1EYIzr+/GC/6ow/DPfTqBZGod4=;
        b=a65YpyeeavwnyUAKujgnZb/PB3nJh4c5phNBaPVCvxngkxXxZcIMHWljv/Tc5HmqlG
         6XCD0REdgfuEXR3g1pFfSPbbjnpi+GnxN4RmdRgzdcGesoOJB7yC9pd+k5PDHtRxd57M
         Eb56cHQfn9rbkuD+Xeqz8DypXGK/G6ZDRb/e+aqrxlo5dMQVPewSLgwp9boJ9Juu9FL2
         azTD3nZ410AzF742G1kJXxinobHSu7hiAd4vU1ehiMNjXscYOBlconLtKVvjZ6l7vzMZ
         12BNe8+S9zpeLWQSLfzei+ahSzBH4OfQs8XjJRZBTbp/jr3ECgVQbii3X+YwvJMBn+1v
         mzkw==
X-Gm-Message-State: AO0yUKVAVCJF4IVy1ULOACU79DBKVa7dWnsQJJsIN9ZTGIjoj1pGcGFf
        qrosJIq9BRtLqV5zYpL7AgIuWg==
X-Google-Smtp-Source: AK7set+XBkFvOC4Zw1V00sJcba/mjbhIsdM76P8x5GoJIkuLsllH0XcGs1KzVG/UTXiT1PAi0vj+XQ==
X-Received: by 2002:a17:906:bc57:b0:874:e17e:2526 with SMTP id s23-20020a170906bc5700b00874e17e2526mr16260378ejv.72.1678271790829;
        Wed, 08 Mar 2023 02:36:30 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:ff33:9b14:bdd2:a3da? ([2a02:810d:15c0:828:ff33:9b14:bdd2:a3da])
        by smtp.gmail.com with ESMTPSA id ga2-20020a170906b84200b00882f9130eafsm7253599ejb.26.2023.03.08.02.36.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 02:36:30 -0800 (PST)
Message-ID: <52f951e6-1b14-1a47-0a62-4203978be024@linaro.org>
Date:   Wed, 8 Mar 2023 11:36:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v1 1/2] dt-bindings: hwmon: ina2xx: add supply property
Content-Language: en-US
To:     Svyatoslav Ryhel <clamor95@gmail.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230308094024.14115-1-clamor95@gmail.com>
 <20230308094024.14115-2-clamor95@gmail.com>
 <559c2588-e586-b4fb-97f8-5fe25bb79607@linaro.org>
 <CAPVz0n38LtyAqBP4GfC003xzaW78FaZ91zjdTNe46ormL5RY=Q@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAPVz0n38LtyAqBP4GfC003xzaW78FaZ91zjdTNe46ormL5RY=Q@mail.gmail.com>
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

On 08/03/2023 11:32, Svyatoslav Ryhel wrote:
> ср, 8 бер. 2023 р. о 12:27 Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> пише:
>>
>> On 08/03/2023 10:40, Svyatoslav Ryhel wrote:
>>> Add supply property.
>>
>> You have entire commit msg to explain and give background, but instead
>> there is just sentence duplicating subject. And since you did not
>> explain anything, we have questions... like: INA238 does not have VDD,
>> so this does not look correct.
>>
> 
> This is why a regulator is not mandatory. If ina238 does not have vdd
> then one who needs ina238 may omit this prop. How about looking from
> this perspective?

Not required means "optional", not "not existing" or "totally invalid".

Best regards,
Krzysztof

