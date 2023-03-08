Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3DFF6B083E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 14:16:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbjCHNQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 08:16:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbjCHNQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 08:16:22 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF8774C6F7
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 05:13:12 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id s11so65517079edy.8
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 05:13:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678281187;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zl9a5YR7z/ZneHIO81SBz6TtTLPvQqQTr5PQNn8diCw=;
        b=AMcs3U9Rn+VjKT/+tfC2gO2HfbUv00+q8Q0mRyu15tA3Kax6sEgLnVNCQxt2MWjO/5
         Y2jM2xxvYZImWuqTU+MOlvnqFucZ8nQmQz+HHdGploejQQwF3SOTNkjviLHop4/OilaD
         cbx/hwJBhWq4en7HSM8AhQ3Q2pCtBvpIVV6ush5FEhsWRZ9y2sIPn1jSWSjJwG/KCvfd
         ZAu+UsevLhjXiyl8f02+v9q6v95BqQBbu7er6g0+5dZ9d5uC9AYfv3D9kTUz7P4rlnuO
         ztpljTFmqBvRaE9VyYCw4D/HNtasNeVAHhWzE/xdSbSK4hmgumaF1hFz2EHgKpdhIrHX
         KfBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678281187;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zl9a5YR7z/ZneHIO81SBz6TtTLPvQqQTr5PQNn8diCw=;
        b=yOt+1mh9NJ+4Hb6yJpM3OGzTOZ/5Hi361qkPCS4gXUOigSpa1m6KbxqsKbPAqz2Lza
         Dn7Y0tWSqVmxLUziwPX5SGFM+VnQPBnp975HsaGFLY3gp0M5eSdUb7mRLs0UvlC+0zgP
         9+11iFrSvqVIOYKjyvH4GnecldbAwIx//WHRltFS43W6Hiu98+D5BH1JvEg/85Tybf5U
         gZ7n/fcCDaIds7QEPYTovqRqBVB96PYpQEnXJL0Ak6iLqBBCj2pAJtpbIuNp9KUeJlH4
         eSKzOeHvfikGzwX5SihAKisX4VFntzbtns2SCC6J+wd41vTm/dZvbUSjT/4Hw0cMh7eI
         MHBw==
X-Gm-Message-State: AO0yUKW5Z3gcdRiC68SsxLmI5DZm1w0/RAIgLYT5Bqk7OfiH8e7P1jsF
        1ybcLV7YWCQmX10IG9PA2QVaLg==
X-Google-Smtp-Source: AK7set/5FpmW/1zhzgWVHzPGlyvoqKpijeBE+DbwesSw/NeBoeQ1LYdVkaGS4aciyPpa+VK4WO4Y8Q==
X-Received: by 2002:a17:906:7395:b0:8e4:96c4:8a4 with SMTP id f21-20020a170906739500b008e496c408a4mr17505111ejl.62.1678281187589;
        Wed, 08 Mar 2023 05:13:07 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:ff33:9b14:bdd2:a3da? ([2a02:810d:15c0:828:ff33:9b14:bdd2:a3da])
        by smtp.gmail.com with ESMTPSA id w21-20020a1709064a1500b008cce6c5da29sm7440904eju.70.2023.03.08.05.13.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 05:13:07 -0800 (PST)
Message-ID: <bfb859da-ea8e-50a1-81b0-7f84a55e930f@linaro.org>
Date:   Wed, 8 Mar 2023 14:13:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v1 1/2] dt-bindings: hwmon: ina2xx: add supply property
Content-Language: en-US
To:     Svyatoslav Ryhel <clamor95@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230308094024.14115-1-clamor95@gmail.com>
 <20230308094024.14115-2-clamor95@gmail.com>
 <31ca0ede-012c-4849-bf25-d0492b116681@sirena.org.uk>
 <6DBD0F5A-4625-4FCD-8D64-23293D734A82@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <6DBD0F5A-4625-4FCD-8D64-23293D734A82@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/03/2023 13:58, Svyatoslav Ryhel wrote:
> 
> 
> 8 березня 2023 р. 14:54:34 GMT+02:00, Mark Brown <broonie@kernel.org> написав(-ла):
>> On Wed, Mar 08, 2023 at 11:40:23AM +0200, Svyatoslav Ryhel wrote:
>>> Add supply property.
>>
>>> +  vdd-supply: true
>>> +
>>>  required:
>>>    - compatible
>>>    - reg
>>
>> Unless the device can work without power the supply should be required.
> 
> Device can work without supply defined on most devices,

Are you sure they can work without any power? INA231 does not say VS
supply is optional. Datasheet says:
"The INA231 is typically powered by a separate supply that can range
from 2.7 V to 5.5 V."

Although it uses word "typically" which could suggest other design, but
are you sure it can work without it? From where it gets the power?


>  but in my case power is gated with gpio and devices will not work
without fixed regulator.

BTW, wrap your lines to match mailing list style.

Best regards,
Krzysztof

