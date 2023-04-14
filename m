Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 550996E2B3A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 22:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbjDNUmm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 16:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbjDNUmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 16:42:40 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75654E4A
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 13:42:38 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id c9so9787969ejz.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 13:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681504957; x=1684096957;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C8pLu4jERpRba3FUTEoPszF0/AQbHGcUDrxLnefSzTE=;
        b=w8Hp01Vm5edDVFPyq4CzVtZ3SVBji5A7jB93jOxlbSP1mAg0w8WmdrKlPapj/DtZu3
         93qDObTt8sPCkx7T5KeXjR8HINtXd9BstDincbjezkcF5Y48yW0UY5MEwXm7El1w1pBj
         Rp/Y3jp9aV7V4PwuCySYTiQLluVcxK++AGzBB0bBtmaT+OaXoZFoxc+HGJ7Hm6jAS2Dt
         fvgGGlfhas+3eZCskUokP2Wa7HfHCUTfMEI980aJ4W7uhJwOo7XG0t8+WVyBYaxPGrLE
         9z9nGqayH6O03k3zih6J77bcqtcjaeHk3CPiLvY6odp6e/TXP7CMiMlXwo3lylkfCnrT
         NYaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681504957; x=1684096957;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C8pLu4jERpRba3FUTEoPszF0/AQbHGcUDrxLnefSzTE=;
        b=emZyaRnas5E2JqFm8fpecM8fqrR4eqJoDB2aX+7BqYroky9aU66YADexmpToPhO+jN
         Cgp7yF11Tu5bIUFjBzN0L3EMz2iGQWbj14OvIPZiQcj9PQfJvpeiItKVMkfEqSBnSfd/
         zocF3i1GmkYkdd/AEOLxO+pi6TSctVrRUapVUH59pASyqsXfrhALgD+4SwxFSd9IqglK
         Ba5fbsFK2oYxaMwkhK3FFnv1m5YkrHxe3/gl9VJWqtAqYKbw13sCVeRwfZBfIES46nRl
         Lf1FAcn2Zp6VU6ZFmaJdY7Q3tdM80kOKTMsHpPD4GqIE+3Ci9HCWPhItLsPLd3TgeHdI
         5OkQ==
X-Gm-Message-State: AAQBX9dE5Q7TMpvSku6hUz4l7oUQ7dFJ/Un91uy7zmohWGUEw4Zzuu6o
        JrJ2tUB3tEcm/OvmFC/04tMfIbU3Q0A0GJedH2E=
X-Google-Smtp-Source: AKy350blLh5O9Aqx8n+mdVx/OhzQ8YJzp+126dy3SDo+2KiE4ZFWQvXzvrky4iJqJYy913BH1+wI3w==
X-Received: by 2002:a17:906:5610:b0:94e:ff98:44a7 with SMTP id f16-20020a170906561000b0094eff9844a7mr332362ejq.72.1681504956944;
        Fri, 14 Apr 2023 13:42:36 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:ffae:8aab:ae5a:4688? ([2a02:810d:15c0:828:ffae:8aab:ae5a:4688])
        by smtp.gmail.com with ESMTPSA id d26-20020a170906c21a00b0094f0053d491sm569273ejz.162.2023.04.14.13.42.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Apr 2023 13:42:36 -0700 (PDT)
Message-ID: <20b0af27-97c9-d764-43ef-d13a429ffe1d@linaro.org>
Date:   Fri, 14 Apr 2023 22:42:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 1/1] dt-bindings: iio: pressure: Support Honeywell
 mprls0025pa sensor
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andreas Klinger <ak@it-klinger.de>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        linux-kernel@vger.kernel.org
References: <ZDlLmCIiKSMa7Hah@arbad>
 <d577bc44-780f-f25d-29c6-ed1d353b540c@linaro.org>
In-Reply-To: <d577bc44-780f-f25d-29c6-ed1d353b540c@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/04/2023 22:40, Krzysztof Kozlowski wrote:
> On 14/04/2023 14:48, Andreas Klinger wrote:
>> Honeywell mpr is a pressure sensor series. There are many different models with different pressure
>> ranges, units and transfer functions.
>>
>> The range and transfer function need to be set up in the dt. Therefore new properties
>> honeywell,pmin-pascal, honeywell,pmax-pascal, honeywell,transfer-function are introduced.
> 
> Please wrap commit message according to Linux coding style / submission
> process (neither too early nor over the limit):
> https://elixir.bootlin.com/linux/v5.18-rc4/source/Documentation/process/submitting-patches.rst#L586
> 
>>
>> Add dt-bindings.
>>
>> Signed-off-by: Andreas Klinger <ak@it-klinger.de>
> 
> Patches 2 and 3 are missing. At least they were mentioned in the
> changelog but this is 1/1.
> 
>> ---
>>  .../iio/pressure/honeywell,mprls0025pa.yaml   | 93 +++++++++++++++++++
>>  1 file changed, 93 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/iio/pressure/honeywell,mprls0025pa.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/iio/pressure/honeywell,mprls0025pa.yaml b/Documentation/devicetree/bindings/iio/pressure/honeywell,mprls0025pa.yaml
>> new file mode 100644
>> index 000000000000..c0eb3c4be16f
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/iio/pressure/honeywell,mprls0025pa.yaml
>> @@ -0,0 +1,93 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/iio/pressure/honeywell,mprls0025pa.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Honeywell mpr series pressure sensor
>> +
>> +maintainers:
>> +  - Andreas Klinger <ak@it-klinger.de>
>> +
>> +description: |
>> +  Honeywell pressure sensor of model mprls0025pa.
>> +
>> +  This sensor has an I2C and SPI interface. Only the I2C interface is implemented.
>> +
>> +  There are many models with different pressure ranges available. The vendor calls them "mpr
>> +  series". All of them have the identical programming model and differ in the pressure range, unit
> 
> Wrap according to Linux coding style, so at 80.
> 
>> +  and transfer function.
>> +
>> +  To support different models one need to specify the pressure range as well as the transfer
>> +  function. Pressure range needs to be converted from its unit to pascal.
>> +
>> +  The transfer function defines the ranges of numerical values delivered by the sensor. The minimal
>> +  range value stands for the minimum pressure and the maximum value also for the maximum pressure
>> +  with linear relation inside the range.
>> +
>> +  Specifications about the devices can be found at:
>> +    https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/
>> +      pressure-sensors/board-mount-pressure-sensors/micropressure-mpr-series/documents/
>> +      sps-siot-mpr-series-datasheet-32332628-ciid-172626.pdf
>> +
>> +properties:
>> +  compatible:
>> +    const: honeywell,mprls0025pa
> 
> So this is one compatible for entire family of 96 separate devices.
> Looks like reasonable compromise, although I will wait for Rob's
> approval on that.
> 
> Anyway you need to fix the coding style.

... and as Rob's bot pointed out, test it before sending.

Best regards,
Krzysztof

