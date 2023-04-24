Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7036E6EC92F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 11:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231142AbjDXJnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 05:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjDXJnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 05:43:02 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA7552694
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 02:43:00 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-506bf4cbecbso6046607a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 02:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682329379; x=1684921379;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sTC30/cz84+6KAee/oGkWJA1JugNorQ2NhQ6WARnGE0=;
        b=rtXWuf3JNfkAHAfAmA2cEYMt2sdc9jR4Np+5Kb6vSaHsvgYP0eCOgfvbZ7EpzUe5qh
         0aAifedgOIbLeCg/woGiS4eDLparxUgHXtonnp2Pc0LvYnp/hSZb01nG/Lvngez8L6BH
         3U3RhEV315jDBzxVmjH7taP6NMQlWO4nCqKgxgJSxGrYNJMMdE3exov5zgFOv9yO41LC
         9Uq1pT96vyqPopct5Y7iY558ZhrF6vjqh90YMSHNELRgMAyZKpJolY0pRu3/RvtEHzrF
         gQDrXhyFLSaxni8K7W4aS+VpmSUS42MENZbyOtjGOIw0hJG4qKzfdv8JaOdu2NXKJp3u
         eLgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682329379; x=1684921379;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sTC30/cz84+6KAee/oGkWJA1JugNorQ2NhQ6WARnGE0=;
        b=EYE9MkN5B0rvwZVMZr/mJEnky/og+y8mBX/LDPCGMaB8ZDpUHyfLW0AVIrDe9Hhbut
         Iue3rE+X1D3F6QZV5Eka1xIAtNAq3+ZS84GmKVLX4jHz5Szzs9CZs5jbxJyu4dgKFkW7
         b5cXXcxe+tdlYJtX5zCkmWB7o1O+QdAt9FjtMGmAaKcZojcanTxOye5FE26YgAqdV0df
         OUdz4OcLHmBXlkEGZEcPQCZasa7/g9oj0m4NqBAUcJph/bUJHKm7hjQ2ha+ssggKPCsH
         wXJeHN3k7W2QUQpNd3eaZ2fmsONJlBg4AikS2jqYOonF7b8gKBVxhsG71XKPtRRsG3KL
         dYnA==
X-Gm-Message-State: AAQBX9fErI/ZqBNMJTTn3WrYo/E+TRCw3dDoXprGqBPgLapf3sYIqZ8/
        HxzGOY/se/vP2uczzqM4m9cFkw==
X-Google-Smtp-Source: AKy350YAXqslb6hk6tvtZLyLLmjKobEKe0JFksRkukozW2c/onCbo7bLelBLsbcyrHZmm2SkaAaDXQ==
X-Received: by 2002:aa7:cd7c:0:b0:4fc:3777:f630 with SMTP id ca28-20020aa7cd7c000000b004fc3777f630mr10401509edb.0.1682329378898;
        Mon, 24 Apr 2023 02:42:58 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:fcdb:bf53:d053:3a52? ([2a02:810d:15c0:828:fcdb:bf53:d053:3a52])
        by smtp.gmail.com with ESMTPSA id e17-20020aa7d7d1000000b00508480633bdsm4561189eds.74.2023.04.24.02.42.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Apr 2023 02:42:58 -0700 (PDT)
Message-ID: <be129c4f-3ad7-c54b-936e-08b142608ebc@linaro.org>
Date:   Mon, 24 Apr 2023 11:42:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 1/2] dt-bindings: hwmon: Add max6639
To:     Naresh Solanki <naresh.solanki@9elements.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Marcello Sylvester Bauer <sylv@sylv.io>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230420111759.2687001-1-Naresh.Solanki@9elements.com>
 <76e57634-75dd-01e8-9c56-36ed7de17812@linaro.org>
 <c8d1b5db-318e-3401-0834-b89769831eca@9elements.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <c8d1b5db-318e-3401-0834-b89769831eca@9elements.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/04/2023 11:18, Naresh Solanki wrote:

>>> Changes in V2:
>>> - Update subject
>>> - Drop blank lines
>>> ---
>>>   .../bindings/hwmon/maxim,max6639.yaml         | 52 +++++++++++++++++++
>>>   1 file changed, 52 insertions(+)
>>>   create mode 100644 Documentation/devicetree/bindings/hwmon/maxim,max6639.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/hwmon/maxim,max6639.yaml b/Documentation/devicetree/bindings/hwmon/maxim,max6639.yaml
>>> new file mode 100644
>>> index 000000000000..1aaedfd7cee0
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/hwmon/maxim,max6639.yaml
>>> @@ -0,0 +1,52 @@
>>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/hwmon/maxim,max6639.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Maxim max6639
>>
>> What is this device? fan controller?
> Yes Fan controller.
> Do you want me to update the title here as:
> "Maxim MAC6639 2 channel fan controller & temperature monitor" ?

Enough would be:
Maxim MAX6639 Fan Controller


> 
>>
>>> +
>>> +maintainers:
>>> +  - Naresh Solanki <Naresh.Solanki@9elements.com>
>>> +
>>> +description: |
>>> +  The MAX6639 is a 2-channel temperature monitor with dual, automatic, PWM
>>> +  fan-speed controller.  It monitors its own temperature and one external
>>> +  diode-connected transistor or the temperatures of two external diode-connected
>>> +  transistors, typically available in CPUs, FPGAs, or GPUs.
>>> +
>>> +  Datasheets:
>>> +    https://datasheets.maximintegrated.com/en/ds/MAX6639-MAX6639F.pdf
>>> +
>>> +properties:
>>> +  compatible:
>>> +    enum:
>>> +      - maxim,max6639
>>> +
>>> +  reg:
>>> +    maxItems: 1
>>> +
>>> +  '#address-cells':
>>> +    const: 1
>>> +
>>> +  '#size-cells':
>>> +    const: 0
>>
>> Why do you need these two properties?
> Ack. Will remove them.
>>
>> Anyway, the binding looks incomplete. Where are the supplies? Interrupts?
> This patch just adds basic support to the existing platform driver.
> Intention is to be able to call the driver from DT with basic 
> initialization from driver the existing driver.

Bindings should be rather complete. Here the datasheet is accessible and
few properties quite obvious, so I don't see a reason to skip them.


Best regards,
Krzysztof

