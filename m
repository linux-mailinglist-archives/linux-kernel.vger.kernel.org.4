Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE3A5E7856
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 12:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbiIWK3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 06:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231341AbiIWK24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 06:28:56 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 106551323E2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 03:28:53 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id i26so19043584lfp.11
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 03:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=9Z/2h4ISg166Duv/L7tQkzRz8Gycv601fQApJ8U1hqk=;
        b=CIqmag4j3rqNMDRLZK1GWci91Se3HW/3lrhu6PMBTpoQbN87AZgLrmaM0Ot7FYH8sW
         /ewsbSqG8GMq2UoGzdQ4hwyb3DH0BpXvVMyZjM92MCqS1nC6t6mCka4cdk2+mG6JXlQr
         fnQ+U4/L+613ghIGP97oDjTQx8nsVyPq7gStNvrXaZxZ8kcUuPJUwPfFiwIe1eKYlPcJ
         wgyTViuZmaWTQmZCo3nURzKhFdN+9I56mOhrDuT7mkyqBrqmgy09eI/psQlOKut5RE+N
         +64RnuAgYbr8ny7cLs7RoLZLQdkUMP0UL2s7jxtPTgEE2EXigiO72ZXVhkRcjlUOJ0K6
         k11w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=9Z/2h4ISg166Duv/L7tQkzRz8Gycv601fQApJ8U1hqk=;
        b=gugOpIZfJ48+sy0U0W8s392/8zSInVBWW5qn4HjO9srYrEMoR6SHwGihHE/qevHoUE
         alNGBxaD4D7lewY7fi3boJ2xn9nf2KFqRfWYIiFVB7Q11rKJOYwK0/yiABa2DaJLNGNl
         rrx/xr4wlRqyHuDInfC8PtiYjCdRRKiX8eGLFtuMK1cXlKMswUZ4jM6sK7rt93c1zaz5
         GxOfsXgiSm4o7R40kWismW6gUF8NzDU0oBg/93/SZxHQkGyS7UhsSWTDwopjxHTjMzNq
         +yUHcvOU2CT923nxxxdqwDu6md2x4Z+TAVqRIrh55DajTbcUBN1Yg9kKF9ibVUSMzRbN
         50Fw==
X-Gm-Message-State: ACrzQf0IGYKaIdcNCUhpkxnAHvLvqYQcmlMmD3oqDlaD0yHveqfPdyt5
        t/TFARCWtQrK6BO0EuPmHVVdwQ==
X-Google-Smtp-Source: AMsMyM7MBNH77N37AcVzjh4hwgWGVAm1sHl8mNVVwupE5EyJeYmwpMXtErRHycZXc0fIt/+e+lbF8g==
X-Received: by 2002:a05:6512:234c:b0:499:9c33:af96 with SMTP id p12-20020a056512234c00b004999c33af96mr2833587lfu.545.1663928931479;
        Fri, 23 Sep 2022 03:28:51 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id j3-20020a2e8003000000b0026ad753448fsm1313676ljg.85.2022.09.23.03.28.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Sep 2022 03:28:51 -0700 (PDT)
Message-ID: <3b0c9c24-ecb5-04df-67de-62f584fabdfd@linaro.org>
Date:   Fri, 23 Sep 2022 12:28:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: =?UTF-8?Q?Re=3a_=5bPATCH_2/3=5d_arm64=3a_dts=3a_rockchip=3a_add_PX3?=
 =?UTF-8?Q?0-=c2=b5Q7_=28Ringneck=29_SoM_with_Haikou_baseboard?=
Content-Language: en-US
To:     Quentin Schulz <quentin.schulz@theobroma-systems.com>,
        Quentin Schulz <foss+kernel@0leil.net>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        heiko@sntech.de, dmitry.torokhov@gmail.com,
        klaus.goger@theobroma-systems.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org
References: <20220922101211.3215888-1-foss+kernel@0leil.net>
 <20220922101211.3215888-3-foss+kernel@0leil.net>
 <e481af15-7e37-47dc-b272-6d032b5dd7a7@linaro.org>
 <f72271d7-9f42-45e9-01a4-590bd20250ab@theobroma-systems.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <f72271d7-9f42-45e9-01a4-590bd20250ab@theobroma-systems.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/09/2022 11:55, Quentin Schulz wrote:
>>> +
>>> +	leds {
>>> +		compatible = "gpio-leds";
>>
>> This belongs to DTSI.
>>
> 
> It is in the DTSI :)

Ah, right...


> 
>>> +		pinctrl-names = "default";
>>> +		pinctrl-0 = <&module_led_pin>;
>>> +		status = "okay";
>>
>> No need.
>>
>>> +
>>> +		module_led: led-0 {
>>
>> Why DTSI - which in logic comes first - starts with 1 and this is 0?\
>>
> 
> The first diff in this patch is for the DTS, this is now the DTSI. So it 
> does have led-0 in the DTSI and led-1 in the DTS which I think is what 
> you're requesting here? Is this a correct assumption?

Yep.


Best regards,
Krzysztof

