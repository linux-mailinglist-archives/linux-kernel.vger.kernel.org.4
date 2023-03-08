Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 450276B0610
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 12:36:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbjCHLgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 06:36:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbjCHLfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 06:35:50 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBC87B1A6C;
        Wed,  8 Mar 2023 03:35:49 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id bh20so11889862oib.9;
        Wed, 08 Mar 2023 03:35:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678275349;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x2ob5v9YUXQwfQj5y56Az67vh2N1Igtp/kRfAGxC6W8=;
        b=PFMppGXgZqjqxfnoRZMzoGc7AmAaoDK5Ph913NRsb2LDL44jk7NI04RUhFp6/UUT/j
         Q2axxYShfELDjUehuVeC5ih1n3RHxKRU2g9KnyZPfPxKdUdZqAmNf8kZaNhcuZ0UOcnf
         f4B7/Z17q8TH6rjK2UsdOA5ov+EuxJMmsjj7e+q8SbNy8eQna6avbhnTswHIl1pQ+CgD
         zGJgEv+2hn7SSeL2A8fTQQvhs0sbCm5TkhwBBiLfiYgRBwdIUTjlcaIVW7z44R3PMJmu
         69nNIq6MxN+/Gm320Lf5KRJXScA5afQSP/+dFcg4PzbozMw4dn1zqXismwo0bwjb/KLE
         x1qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678275349;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x2ob5v9YUXQwfQj5y56Az67vh2N1Igtp/kRfAGxC6W8=;
        b=M+QrCDEcWGNM5mBYKZ6a+h8MPnyg8FhvoWZDIK1iLnCrMKzUTPwKwKspfXo+LTbPpo
         61i4mhw6TJUFQyOxbsK8X0erqcA4Xe6foKruEbdI8GV/GnCos28wYN3Mon5D8dtXmy8E
         ExZw+yhbNn0GCXi1mQMeWxTpA9i1yh3eHjEV+Cn45Osbxef5b5T93gM+vex/hTpLbsLw
         Cgk5FW1Jfj3Aph/5nU8LrNsm6g+1kE+Q0pSI5U5WCPs3Jj6ueHZ9q+Sp3Fjpir1o1fxX
         0z3QVu5F1vQ0cMXjnLzg28U9jbwi0zXzB6tndD419CE1vs+ymI5dA6EMYqaw/rjss8Tw
         Yjuw==
X-Gm-Message-State: AO0yUKWcIPY+57xUBwTsRgt7ZkW3Rw86h7h9EIezyIx71p0g5wk77RXl
        RVQQmrs4jbWq60IVXcg3ZFg=
X-Google-Smtp-Source: AK7set8lb8jozZgQgsED0eGz5aHAWImsYZUwqtR268BCMeBhHc5n5dyO6NrjRKco9Z5SIybl0oOFxg==
X-Received: by 2002:aca:1a09:0:b0:383:b2c0:4f61 with SMTP id a9-20020aca1a09000000b00383b2c04f61mr7395672oia.43.1678275349058;
        Wed, 08 Mar 2023 03:35:49 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w133-20020acadf8b000000b00383b371f2a7sm3531418oig.42.2023.03.08.03.35.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 03:35:48 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <2b012916-3955-6c4a-a74b-1e86eaa19485@roeck-us.net>
Date:   Wed, 8 Mar 2023 03:35:46 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Content-Language: en-US
To:     Svyatoslav Ryhel <clamor95@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230308094024.14115-1-clamor95@gmail.com>
 <20230308094024.14115-2-clamor95@gmail.com>
 <559c2588-e586-b4fb-97f8-5fe25bb79607@linaro.org>
 <CAPVz0n38LtyAqBP4GfC003xzaW78FaZ91zjdTNe46ormL5RY=Q@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v1 1/2] dt-bindings: hwmon: ina2xx: add supply property
In-Reply-To: <CAPVz0n38LtyAqBP4GfC003xzaW78FaZ91zjdTNe46ormL5RY=Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/8/23 02:32, Svyatoslav Ryhel wrote:
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
> 

If a chip does not have VDD, the driver should not even try to get it
for that chip. INS238 is supported by a different driver, so that does
not require special code, but it needs to be spelled out in the devicetree
bindings. Devicetree has a means to specify if a property is valid for
a given device.

Having said this, as it turns out, _none_ of the chips supported by
the ina2xx and the ina238 drivers have VDD. All of them have Vs, and
all but INA219 have Vbus. The bindings don't even explain which one
of those is supposed to refer to "VDD".

Also, regulator_get_optional() returns -ENODEV if CONFIG_REGULATOR
is not enabled, so it isn't entirely optional. We can not suddenly fail
to load the driver on systems with CONFIG_REGULATOR=n, so some conditional
code will unfortunately be necessary.

Guenter

>>
>> Best regards,
>> Krzysztof
>>
> 
> Best regards,
> Svyatoslav R.

