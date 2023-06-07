Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2BFD725622
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 09:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238593AbjFGHoG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 03:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237764AbjFGHnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 03:43:37 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0756421D
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 00:40:41 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9745d99cfccso976216866b.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 00:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686123640; x=1688715640;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QzNzUxBgctT5U3+gB3td/wPDXx9tt+J9TkByw444vb4=;
        b=dpiv/lAao6jUqNRWIwDa/t6LO1tyPxkPWni1OUv3MwCcaBvBG9TZJWlQAsTwrpJG8z
         WiSLr3KTYWPNapPhFe4g/UQTjDvdv2Kh5m3vUHx2Uvn0qhMaWW7936pz4POvuJM/IQsq
         Nj5IuPvfSkJvvk2/lgKSqanZnlPWCLIWckttk5fd61hIvF0Cv5Sw1t5kE8iZvriviEW+
         In+gf5HZQY8yoXdiDm/zttqRTvXjVTxgNdcYNhuap4h3KffjSa1/I4wWvgR5nzhKYxNl
         ilEXGjb2B7MxuIK+KjltPks5gdQ0IXXIg2nLLmfmXMao4M6uuWPsgMMFy1+JhqAIHqER
         v4DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686123640; x=1688715640;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QzNzUxBgctT5U3+gB3td/wPDXx9tt+J9TkByw444vb4=;
        b=XLmYif31+lLyT3mVQdxuRbOmJ8LeQuOFtGLZc9eJL42NNzxKNQAISXO98wKtst7qkq
         1wS5O47kiGFwfv4p4IdGYOt83pcHihRF7MdSKnK/abOiep1Sn7SVWQrHf+ccIfI12SBX
         n3t7lkYSF1+7cbMfuXHFeRNTTc08/t7liEXez1vn2yqdzQh3nNtsC49dmfm/xmTOot5s
         vgNxcKMD6gCY0rUnp0zhOuJfFKUdlWvkYUH8MiEScR+n3C14yM9aAoUcW2AwXNUmHzON
         WO8kB9fyit6HiPCwmLJ3ZOAZOttQrZgABVv5daOTJ5zGNeYD8PekuY96g+0LZ6ZXTFo2
         jReg==
X-Gm-Message-State: AC+VfDw2SkcwlBbcF7JHtdt7tWKOGYLjmVkdBvKYXoQTcuaw4QPhb0F1
        Lqw6m+axkH+Krz3LjPHh9cinrQ==
X-Google-Smtp-Source: ACHHUZ6nIjpeIRlx7fPahFZ5gzxmNl29452UMvG6AuY1y9w+PrjwLC4zGKqXZHhvW+xhYzrUW9v6Ug==
X-Received: by 2002:a17:907:9403:b0:965:cc76:7716 with SMTP id dk3-20020a170907940300b00965cc767716mr4912526ejc.76.1686123640173;
        Wed, 07 Jun 2023 00:40:40 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id k16-20020a1709065fd000b00977db7d08cbsm3376124ejv.74.2023.06.07.00.40.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 00:40:39 -0700 (PDT)
Message-ID: <f141a538-23b8-d10e-227c-5f0ad191c3a6@linaro.org>
Date:   Wed, 7 Jun 2023 09:40:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 2/7] dt-bindings: pwm: restrict node name suffixes
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Dipen Patel <dipenp@nvidia.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Dilip Kota <eswara.kota@linux.intel.com>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-rtc@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-spi@vger.kernel.org, timestamp@lists.linux.dev,
        linux-watchdog@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>
References: <20230530144851.92059-1-krzysztof.kozlowski@linaro.org>
 <20230530144851.92059-3-krzysztof.kozlowski@linaro.org>
 <20230607073652.hoyrernfcuoryrqs@pengutronix.de>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230607073652.hoyrernfcuoryrqs@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/06/2023 09:36, Uwe Kleine-König wrote:
> On Tue, May 30, 2023 at 04:48:46PM +0200, Krzysztof Kozlowski wrote:
>> Make the pattern matching node names a bit stricter to improve DTS
>> consistency.  The pattern is restricted to:
>> 1. Only one unit address or one -N suffix,
>> 2. -N suffixes to decimal numbers.
>>
>> Suggested-by: Rob Herring <robh@kernel.org>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
>>
>> ---
>>
>> Cc: Tony Lindgren <tony@atomide.com>
>> Cc: Oleksij Rempel <o.rempel@pengutronix.de>
>> ---
>>  Documentation/devicetree/bindings/pwm/pwm.yaml | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/pwm/pwm.yaml b/Documentation/devicetree/bindings/pwm/pwm.yaml
>> index 3c01f85029e5..abd9fa873354 100644
>> --- a/Documentation/devicetree/bindings/pwm/pwm.yaml
>> +++ b/Documentation/devicetree/bindings/pwm/pwm.yaml
>> @@ -13,7 +13,7 @@ select: false
>>  
>>  properties:
>>    $nodename:
>> -    pattern: "^pwm(@.*|-[0-9a-f])*$"
>> +    pattern: "^pwm(@.*|-([0-9]|[1-9][0-9]+))?$"
> 
> With this patch we forbid now the following patterns:
> 
> 	pwm-[0-9a-f][@-].*
> 	pwm-0[0-9a-f]+
> 	pwm-[a-f]([@-].*)?

Yes, this was discussed last time:
https://lore.kernel.org/all/20221127182232.GA128974-robh@kernel.org/

> 
> Checking for such names:
> 
> 	$ git grep -oP '\bpwm-([0-9a-f][@-].*|0[0-9a-f]+|[0-9]*[a-f][0-9a-f]*)(*pla:\s*\{)' arch/*/boot/dts
> 	arch/arm/boot/dts/meson8.dtsi:pwm-f-ao
> 	arch/arm/boot/dts/meson8.dtsi:pwm-e
> 	arch/arm/boot/dts/meson8b.dtsi:pwm-d
> 	arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi:pwm-a
> 	arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi:pwm-b-x7
> 	arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi:pwm-b-x19
> 	arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi:pwm-c-c
> 	arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi:pwm-c-x5
> 	arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi:pwm-c-x8
> 	arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi:pwm-d-x3
> 	arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi:pwm-d-x6
> 	arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi:pwm-e
> 	arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi:pwm-f-z
> 	arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi:pwm-f-a
> 	arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi:pwm-f-x
> 	arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi:pwm-f-h
> 	arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi:pwm-a-e

Are you sure these are pwms, not pins?

> 
> These are all pinmux-settings and no pwm nodes, so the change is fine.
> (But arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi isn't properly
> sorted alphabetically.)

Exactly...

> 
> Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>


Best regards,
Krzysztof

