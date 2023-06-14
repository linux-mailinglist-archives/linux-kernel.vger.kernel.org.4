Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59CC372F42A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 07:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242897AbjFNFcf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 01:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234327AbjFNFcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 01:32:33 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8AE3198D;
        Tue, 13 Jun 2023 22:32:31 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b1b72dc2feso2916541fa.3;
        Tue, 13 Jun 2023 22:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686720750; x=1689312750;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g+qH04ox/9SD7VXix3RPkQb/VsDtH0DaySagYZUq/B4=;
        b=VYxsw7luRgE4KyyGUu3p8JPYSAvnNE82w32YWzIKxFYDlkM+ed26p6NCOfm77az836
         gYkv0bAAxwOsfoa5dOL99T2sV7tndqha9bepcF4DBz+W/wDOXspEEo0glz2TOMtgSsk1
         p8ekb16fdUJR6Y7Zh0zn6A0oAjDqdgrtRHg/58MYdwoCQ9rFZP4N5chLFKOq+xMcgEc4
         2K/4sDmaim89aORrmQnajWutAHsCZiseFH2J+zNO2IYGgMLM5j2TXnZxnUnnSjdhFdIO
         9Y8MlFwN9qJbvwO1lOdY9zBcungpEXvnq3i+dMEezTwcwaXLUR9/FxlOA3t2IIDZtMTo
         pOLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686720750; x=1689312750;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g+qH04ox/9SD7VXix3RPkQb/VsDtH0DaySagYZUq/B4=;
        b=bBBL+mVjdIkH2Dg7dY8WG1HA/inRoX0XRRUM/a/chYdL1LZNT53KPFT60fIUZ2vph4
         lwSQV2pC35cc5DEQYOSfTyDIsnsL1IXlTofhzf7/ngcWzOIHB9PR7JfjajzSc0+gSKU9
         BEF5j0tDhCBf0jGo1OqnHx8zwmXG1dkhv1r0gW5b8COGug79kUFcLn0LoDji+Db4klSr
         NEj4YHc/UWZbj0V0UrTI1P+rv9CWJ4ZCaRTfPRY2BdVqCmSnUUSLYi+dJA/jIjFWTAkC
         jRkVwdixzpjGnaIkPM64ceIwIhwhukJx9u8r5jrOQEMb9YfTL749Y9D77TywR10F3bbs
         sKkA==
X-Gm-Message-State: AC+VfDyP0vY1XaREr5QO6VgVAdUoipNVIOr9dLcOi/EMvknm0dApK394
        v1qkqPxKj6G0N8tU2vMvzKlrhRNXs5Y=
X-Google-Smtp-Source: ACHHUZ6f0/qoB5+qg+dWtoPRZABLaQPDJ64eb8rT3Qr5lcNQOi0DwHSzDRDR1JWPGCaDHIQe63QIqg==
X-Received: by 2002:a05:651c:83:b0:2b3:429f:2b96 with SMTP id 3-20020a05651c008300b002b3429f2b96mr1300888ljq.37.1686720749511;
        Tue, 13 Jun 2023 22:32:29 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f8:1500::1? (dc78bmyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f8:1500::1])
        by smtp.gmail.com with ESMTPSA id j9-20020a2e8249000000b002a7746800d0sm2433403ljh.130.2023.06.13.22.32.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jun 2023 22:32:29 -0700 (PDT)
Message-ID: <fac025f6-6187-2258-9d49-61799754294f@gmail.com>
Date:   Wed, 14 Jun 2023 08:32:27 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/3] dt-bindings: ROHM BU27010 RGBC + flickering sensor
Content-Language: en-US, en-GB
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1686650184.git.mazziesaccount@gmail.com>
 <98e0b6fba7ff7515b541a517296d5b89dc73ce5b.1686651445.git.mazziesaccount@gmail.com>
 <22dadcf6-9879-efb2-9987-7f286b38b93b@linaro.org>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <22dadcf6-9879-efb2-9987-7f286b38b93b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/13/23 21:42, Krzysztof Kozlowski wrote:
> On 13/06/2023 12:19, Matti Vaittinen wrote:
>> The ROHM BU27010 is a sensor with 6 photodiodes (red, green, blue, clear,
>> IR and flickering detection) with five configurable channels. Red, green
>> and flickering detection being always available and two out of the rest
>> three (blue, clear, IR) can be selected to be simultaneously measured.
>> Typical application is adjusting LCD/OLED backlight of TVs, mobile phones
>> and tablet PCs.
> 
> Please use subject prefixes matching the subsystem. You can get them for
> example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
> your patch is touching.
> e.g.: "dt-bindings: iio:"
> 

Right, thanks!

> 
>>
>> Add binding document for ROHM BU27010.
>>
>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>> ---
>>   .../bindings/iio/light/rohm,bu27010.yaml      | 49 +++++++++++++++++++
>>   1 file changed, 49 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/iio/light/rohm,bu27010.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/iio/light/rohm,bu27010.yaml b/Documentation/devicetree/bindings/iio/light/rohm,bu27010.yaml
>> new file mode 100644
>> index 000000000000..2bde9d2f1def
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/iio/light/rohm,bu27010.yaml
>> @@ -0,0 +1,49 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/iio/light/rohm,bu27010.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: ROHM BU27010 color sensor
>> +
>> +maintainers:
>> +  - Matti Vaittinen <mazziesaccount@gmail.com>
>> +
>> +description: |
>> +  The ROHM BU27010 is a sensor with 6 photodiodes (red, green, blue, clear,
>> +  IR and flickering detection) with five configurable channels. Red, green
>> +  and flickering detection being always available and two out of the rest
>> +  three (blue, clear, IR) can be selected to be simultaneously measured.
>> +  Typical application is adjusting LCD/OLED backlight of TVs, mobile phones
>> +  and tablet PCs.
>> +
>> +properties:
>> +  compatible:
>> +    const: rohm,bu27010
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  vdd-supply: true
> 
> Isn't vdd-supply required for the hardware to work? How does it get the
> power otherwise?

The BU27010 works by magic smoke. When smoke leaks out the sensor no 
longer works.

Ehh, I think you are right. My thinking was that it is not uncommon for 
people to not have all fixed regulators present in device-tree. But I 
agree, this does not mean we should encourage that. I'll add supply to 
the list of the required properties.

> 
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    i2c {
>> +      #address-cells = <1>;
>> +      #size-cells = <0>;
>> +
>> +      light-sensor@38 {
>> +        compatible = "rohm,bu27010";
>> +        reg = <0x38>;
>> +      };
>> +    };
>> +
> 
> Trailing blank line.

Indeed. Thanks.

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

