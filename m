Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 549996C4C88
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 14:56:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbjCVN4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 09:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbjCVN4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 09:56:10 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF0224E5C0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 06:56:01 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id bg16-20020a05600c3c9000b003eb34e21bdfso13097915wmb.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 06:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1679493360;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GfK1edIPOkCfn9npIlPg19GtGQUodkHXzekBkWBELqo=;
        b=7nlprO9IVxDYv+4mhSsg2vF76OfQrW1ZbU9beJXk56XJ9DsXqOsVsktBWrO/c+L40z
         902uA3n3eJGfAqarQppWUBzzGyabQ52KT2+HxfSxoJ3FBHbrIAPT6HZ4GpxVUfbMdbmI
         6oQzzK9yWGp/RM9b2TfYuB0RFjA5+qBlBBClxjEkF8VbsU3PTUgRJlyOanl6N9bKox2q
         vXFgzof8hOObqMOTiKcKytsu203uFooMN8c6i5YUQ7KtpFhqusO0hGAMfr59jf9yj+D5
         J/crFMM7pT+l+TKGU1y9t0IStjMOp+ahknk2OayU46vrU6sZWC1HtWGzh+tubGn3+ho9
         3O4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679493360;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GfK1edIPOkCfn9npIlPg19GtGQUodkHXzekBkWBELqo=;
        b=gSJZ3jsQealZBC8g7RuPU8FzxP4mbcItNRHNqaJtNCIVX8JTU7gbQqMVB8DjW0mw+T
         BbgNZHRy1BQ7agHUZZ3AdwdT1muNoI5QZlRWxelz51qPPOLmB+Rt0I/FDQbrqVjnmDRe
         UcFmjdqkITkE5e7A5NhaMQ27QEIMQAQAh9Y6UXSSNwYXh0bKNf3o39VZXiB5FcnZTJ6n
         Im4bju/weBuXy7dT5Bk9AC5KgycwmScZ0TZb5Zt8d6JP+PNqoQt5/LYGWtvIFhAHBHam
         jEP6JDhUolv7rY5vGdXjX1l9hX4dWtTqfq5Cf3NAjcymeWmtB3lO/yQ6F750ASSK4p/e
         /vAg==
X-Gm-Message-State: AO0yUKV3wqpHGyDK/hK/up61/ep6eBTskSZxSSFxrofJYnEmBoemUvwq
        EoWMtDqjke5XXMtHa4ba2KFehA==
X-Google-Smtp-Source: AK7set/gFr9mRfDWI3gyDUcgYPOIJjmNSqG+lN/9s4FSRwczR9sPTa8fnSXrAxfhAsnBtFbFN1SGLg==
X-Received: by 2002:a1c:f60a:0:b0:3ed:a2db:dd24 with SMTP id w10-20020a1cf60a000000b003eda2dbdd24mr5780949wmc.32.1679493360165;
        Wed, 22 Mar 2023 06:56:00 -0700 (PDT)
Received: from [192.168.1.70] (151.31.102.84.rev.sfr.net. [84.102.31.151])
        by smtp.gmail.com with ESMTPSA id t14-20020a05600c198e00b003eda46d6792sm14619138wmq.32.2023.03.22.06.55.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 06:55:59 -0700 (PDT)
Message-ID: <a63d420c-54ad-e7b0-cc10-64bb942b4e6a@baylibre.com>
Date:   Wed, 22 Mar 2023 14:55:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 1/4] dt-bindings: mfd: Add TI TPS6594 PMIC
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, corbet@lwn.net, arnd@arndb.de,
        gregkh@linuxfoundation.org, derek.kiernan@xilinx.com,
        dragan.cvetic@xilinx.com
Cc:     eric.auger@redhat.com, jgg@ziepe.ca, razor@blackwall.org,
        stephen@networkplumber.org, davem@davemloft.net,
        christian.koenig@amd.com, contact@emersion.fr,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, sterzik@ti.com, u-kumar1@ti.com,
        eblanc@baylibre.com, jneanne@baylibre.com
References: <20230321171020.74736-1-jpanis@baylibre.com>
 <20230321171020.74736-2-jpanis@baylibre.com>
 <88a6856e-c766-d4a5-1882-5350fd0e248a@linaro.org>
 <bffba580-e737-8996-4812-3c76c880acc9@baylibre.com>
 <de3acab7-cf76-3135-9ff8-a0e5537a434b@linaro.org>
From:   Julien Panis <jpanis@baylibre.com>
In-Reply-To: <de3acab7-cf76-3135-9ff8-a0e5537a434b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/22/23 09:16, Krzysztof Kozlowski wrote:
> On 22/03/2023 09:01, Julien Panis wrote:
>>>> +  ti,multi-phase-id:
>>>> +    description: |
>>>> +      Describes buck multi-phase configuration, if any. For instance, XY id means
>>>> +      that outputs of buck converters X and Y are combined in multi-phase mode.
>>>> +    $ref: /schemas/types.yaml#/definitions/uint32-array
>>> No improvements here. As Rob pointed out, this looks like coupled
>>> regulators.
>> I used 'oneOf' logic to handle mutual exclusion. But it seems that I did not
>> understand what you and Rob expected.
>> Does some generic property already exist for 'coupled regulators' ?
> Yes, see regulator.yaml binding.

Krzysztof, I talked with the regulator API/yaml maintainer.
Actually, our multiphase concept is different than coupled regulators:
https://lore.kernel.org/all/ZBr+7X3lcFdI8p%2Fo@sirena.org.uk/

We must not use the generic 'coupled regulator' property here.
So, 'ti,multi-phase-id' can be kept.

>
> Best regards,
> Krzysztof
>

